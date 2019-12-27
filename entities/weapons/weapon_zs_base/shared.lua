SWEP.Primary.Sound = Sound("Weapon_Pistol.Single")
SWEP.Primary.Damage = 30
SWEP.Primary.KnockbackScale = 1
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.15

SWEP.ConeMax = 0.03
SWEP.ConeMin = 0.01
SWEP.ConeRamp = 3

SWEP.CSMuzzleFlashes = true


SWEP.Primary.ClipSize = 8
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"
SWEP.RequiredClip = 1

SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "dummy"

SWEP.WalkSpeed = SPEED_NORMAL

SWEP.HoldType = "pistol"
SWEP.IronSightsHoldType = "ar2"

SWEP.IronSightsPos = Vector(0, 0, 0)

SWEP.AngleAdded = {
	Pitch = 0,
	Yaw = 0,
	Roll = 0,
	CurrentPitch = 0,
	CurrentYaw = 0,
	CurrentRoll = 0
}

function SWEP:SetupDataTables()
	self:NetworkVar("Vector", 31, "ConeAdder")
	self:NetworkVar("Float", 31, "LastFire")
end

function SWEP:Initialize()
	if not self:IsValid() then return end --???

	self:SetWeaponHoldType(self.HoldType)
	self:SetDeploySpeed(1.1)

	-- Maybe we didn't want to convert the weapon to the new system...
	if self.Cone then
		self.ConeMin = self.ConeIronCrouching
		self.ConeMax = self.ConeMoving
		self.ConeRamp = 3
	end

	if CLIENT then
		self:CheckCustomIronSights()
		self:Anim_Initialize()
	end
end

function SWEP:DevineConeAdder() 
	if (IsValid(self.Owner) and self:GetLastFire() + (self.Primary.Delay or 0) + FrameTime() <= CurTime()) then
		self:SetConeAdder(self:GetConeAdder() / 2)
	end
end

-- function SWEP:SetConeAdder()
	-- self:SetNWFloat("LastFire", CurTime())
	-- self:SetNWVector("ConeAdder", self:GetConeAdder() + Vector(math.Rand(0, 1), math.Rand(0, 1), math.Rand(0, 1)) * math.Min(self.ConeMax, math.Rand(self.ConeMin, self.ConeMax)) * 0.2)
-- end

-- function SWEP:GetConeAdder()
	-- return self:GetNWVector("ConeAdder")
-- end
function SWEP:ResetConeAdder()
	self:SetConeAdder(Vector(0, 0, 0))
end

function SWEP:SetConeAndFire()
	self:SetLastFire(CurTime())
	if (self:GetConeAdder():Length() < (self.MaxConeAdder or 1.0)) then
		self:SetConeAdder((self:GetConeAdder() or Vector(0, 0, 0)) + Vector(math.Rand(0, 1), math.Rand(0, 1), math.Rand(0, 1)) * math.Min(self.ConeMax, math.Rand(self.ConeMin, self.ConeMax)) * 0.2)
	end
end

function SWEP:GetConeAdderLength()
	return self:GetConeAdder():Length()
end

function SWEP:DoRecoil()
	if (!IsValid(self.Owner)) then
		return
	end
	
	local recoil = self.Recoil
	
	local mul = 1
	
	if (self.Owner:Crouching()) then
		mul = mul - 0.2
	end
	
	if (self:GetIronsights()) then
		mul = mul - 0.15
	end

	recoil = recoil * mul
	
	if SERVER then
		
		self.Owner:ViewPunch(Angle(math.Rand(-recoil * 3, 0), math.Rand(-recoil, recoil), 0))
	else
		local curAng = self.Owner:EyeAngles()
		curAng.pitch = curAng.pitch - math.Rand(recoil * 3, 0)
		curAng.yaw = curAng.yaw + math.Rand(-recoil, recoil)
		curAng.Roll = 0
		self.Owner:SetEyeAngles(curAng)
	end
end

function SWEP:GetCone()
	-- if not self.Owner:OnGround() or self.ConeMax == self.ConeMin then return self.ConeMax end

	local basecone = self.ConeMin
	local conedelta = self.ConeMax - basecone

	if !self.Owner:OnGround() then
		basecone = basecone * 1.2
	end
	
	local multiplier = math.min(self.Owner:GetVelocity():Length() / self.WalkSpeed, 1) * 0.5
	if not self.Owner:Crouching() then multiplier = multiplier + 0.15 end
	if self:GetIronsights() then multiplier = multiplier - 0.15 end

	-- if (SERVER) then
	-- PrintMessage(3, tostring(basecone) .. "\t" .. tostring(self:GetConeAdderLength()) .. "\t" .. tostring(conedelta) .. "\t" .. tostring(multiplier) .. "\t" .. tostring(self.ConeRamp))
	-- else
	-- chat.AddText(Color(255, 0, 0), tostring(basecone) .. "\t" .. tostring(self:GetConeAdderLength()) .. "\t" .. tostring(conedelta) .. "\t" .. tostring(multiplier) .. "\t" .. tostring(self.ConeRamp))
	-- end
	return math.min(((basecone + self:GetConeAdderLength()) + conedelta * multiplier ^ self.ConeRamp),self.ConeMax*1.2)
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end 
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	self:EmitFireSound()
	self:TakeAmmo()
	self:ShootBullets(self.Primary.Damage, self.Primary.NumShots, self:GetCone())
	self.IdleAnimation = CurTime() + self:SequenceDuration()
end

function SWEP:GetWalkSpeed()
	if self:GetIronsights() then
		return math.min(self.WalkSpeed, math.max(90, self.WalkSpeed * 0.5))
	end

	return self.WalkSpeed
end

function SWEP:EmitFireSound()
	self:EmitSound(self.Primary.Sound)
end

function SWEP:SetIronsights(b)
	self:SetDTBool(0, b)

	if self.IronSightsHoldType then
		if b then
			self:SetWeaponHoldType(self.IronSightsHoldType)
		else
			self:SetWeaponHoldType(self.HoldType)
		end
	end

	gamemode.Call("WeaponDeployed", self.Owner, self)
end

function SWEP:Deploy()
	self:SetNextReload(0)
	gamemode.Call("WeaponDeployed", self.Owner, self)
	self:SetIronsights(false)

	if self.PreHolsterClip1 then
		local diff = self:Clip1() - self.PreHolsterClip1
		self:SetClip1(self.PreHolsterClip1)
		if SERVER then
			self.Owner:GiveAmmo(diff, self.Primary.Ammo, true)
		end
		self.PreHolsterClip1 = nil
	end
	if self.PreHolsterClip2 then
		local diff = self:Clip2() - self.PreHolsterClip2
		self:SetClip2(self.PreHolsterClip2)
		if SERVER then
			self.Owner:GiveAmmo(diff, self.Secondary.Ammo, true)
		end
		self.PreHolsterClip2 = nil
	end

	self.IdleAnimation = CurTime() + self:SequenceDuration()

	if CLIENT then
		self:CheckCustomIronSights()
	end

	return true
end

function SWEP:Holster()
	if self:ValidPrimaryAmmo() then
		self.PreHolsterClip1 = self:Clip1()
	end
	if self:ValidSecondaryAmmo() then
		self.PreHolsterClip2 = self:Clip2()
	end

	if CLIENT then
		self:Anim_Holster()
	end

	return true
end

function SWEP:TakeAmmo()
	self:TakePrimaryAmmo(self.RequiredClip)
end

function SWEP:Reload()
	if self.Owner:IsHolding() then return end

	if self:GetIronsights() then
		self:SetIronsights(false)
	end

	if self:GetNextReload() <= CurTime() and self:DefaultReload(ACT_VM_RELOAD) then
		self.IdleAnimation = CurTime() + self:SequenceDuration()
		self:SetNextReload(self.IdleAnimation)
		self.Owner:DoReloadEvent()
		if self.ReloadSound then
			self:EmitSound(self.ReloadSound)
		end
	end
	
	self:ResetConeAdder()
end

function SWEP:GetIronsights()
	return self:GetDTBool(0)
end

function SWEP:CanPrimaryAttack()
	if self.Owner:IsHolding() or self.Owner:GetBarricadeGhosting() then return false end

	if self:Clip1() < self.RequiredClip then
		self:EmitSound("Weapon_Pistol.Empty")
		self:SetNextPrimaryFire(CurTime() + math.max(0.25, self.Primary.Delay))
		return false
	end

	return self:GetNextPrimaryFire() <= CurTime()
end

function SWEP:SecondaryAttack()
	if self:GetNextSecondaryFire() <= CurTime() and not self.Owner:IsHolding() then
		self:SetIronsights(true)
	end
end

function SWEP:OnRestore()
	self:SetIronsights(false)
end

local tempknockback
function SWEP:StartBulletKnockback()
	tempknockback = {}
end

function SWEP:EndBulletKnockback()
	tempknockback = nil
end

function SWEP:DoBulletKnockback(scale)
	for ent, prevvel in pairs(tempknockback) do
		local curvel = ent:GetVelocity()
		ent:SetVelocity(curvel * -1 + (curvel - prevvel) * scale + prevvel)
	end
end

function GenericBulletCallback(attacker, tr, dmginfo)
	local ent = tr.Entity
	if ent:IsValid() then
		if ent:IsPlayer() then
			if attacker:IsPlayer() and ent:Team() ~= attacker:Team() and tempknockback then
				tempknockback[ent] = ent:GetVelocity()
			end
		else
			local phys = ent:GetPhysicsObject()
			if ent:GetMoveType() == MOVETYPE_VPHYSICS and phys:IsValid() and phys:IsMoveable() then
				ent:SetPhysicsAttacker(attacker)
			end
		end
	end
end

function SWEP:SendWeaponAnimation()
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
end

SWEP.BulletCallback = GenericBulletCallback
function SWEP:ShootBullets(dmg, numbul, cone)	
	if SERVER then
		self:SetConeAndFire()
	end
	self:DoRecoil()
	
	local owner = self.Owner
	--owner:MuzzleFlash()
	self:SendWeaponAnimation()
	owner:DoAttackEvent()

	self:StartBulletKnockback()
	owner:FireBullets({Num = numbul, Src = owner:GetShootPos(), Dir = owner:GetAimVector(), Spread = Vector(cone, cone, 0), Tracer = 1, TracerName = self.TracerName, Force = dmg * 0.1, Damage = dmg, Callback = self.BulletCallback})
	self:DoBulletKnockback(self.Primary.KnockbackScale * 0.05)
	self:EndBulletKnockback()
end

local ActIndex = {
	[ "pistol" ] 		= ACT_HL2MP_IDLE_PISTOL,
	[ "smg" ] 			= ACT_HL2MP_IDLE_SMG1,
	[ "grenade" ] 		= ACT_HL2MP_IDLE_GRENADE,
	[ "ar2" ] 			= ACT_HL2MP_IDLE_AR2,
	[ "shotgun" ] 		= ACT_HL2MP_IDLE_SHOTGUN,
	[ "rpg" ]	 		= ACT_HL2MP_IDLE_RPG,
	[ "physgun" ] 		= ACT_HL2MP_IDLE_PHYSGUN,
	[ "crossbow" ] 		= ACT_HL2MP_IDLE_CROSSBOW,
	[ "melee" ] 		= ACT_HL2MP_IDLE_MELEE,
	[ "slam" ] 			= ACT_HL2MP_IDLE_SLAM,
	[ "normal" ]		= ACT_HL2MP_IDLE,
	[ "fist" ]			= ACT_HL2MP_IDLE_FIST,
	[ "melee2" ]		= ACT_HL2MP_IDLE_MELEE2,
	[ "passive" ]		= ACT_HL2MP_IDLE_PASSIVE,
	[ "knife" ]			= ACT_HL2MP_IDLE_KNIFE,
	[ "duel" ]      = ACT_HL2MP_IDLE_DUEL,
	[ "revolver" ]		= ACT_HL2MP_IDLE_REVOLVER
}

function SWEP:SetWeaponHoldType( t )

	t = string.lower( t )
	local index = ActIndex[ t ]
	
	if ( index == nil ) then
		Msg( "SWEP:SetWeaponHoldType - ActIndex[ \""..t.."\" ] isn't set! (defaulting to normal) (from "..self:GetClass()..")\n" )
		t = "normal"
		index = ActIndex[ t ]
	end

	self.ActivityTranslate = {}
	self.ActivityTranslate [ ACT_MP_STAND_IDLE ] 				= index
	self.ActivityTranslate [ ACT_MP_WALK ] 						= index+1
	self.ActivityTranslate [ ACT_MP_RUN ] 						= index+2
	self.ActivityTranslate [ ACT_MP_CROUCH_IDLE ] 				= index+3
	self.ActivityTranslate [ ACT_MP_CROUCHWALK ] 				= index+4
	self.ActivityTranslate [ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] 	= index+5
	self.ActivityTranslate [ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ] = index+5
	self.ActivityTranslate [ ACT_MP_RELOAD_STAND ]		 		= index+6
	self.ActivityTranslate [ ACT_MP_RELOAD_CROUCH ]		 		= index+6
	self.ActivityTranslate [ ACT_MP_JUMP ] 						= index+7
	self.ActivityTranslate [ ACT_RANGE_ATTACK1 ] 				= index+8
	self.ActivityTranslate [ ACT_MP_SWIM_IDLE ] 				= index+8
	self.ActivityTranslate [ ACT_MP_SWIM ] 						= index+9
	
	-- "normal" jump animation doesn't exist
	if t == "normal" then
		self.ActivityTranslate [ ACT_MP_JUMP ] = ACT_HL2MP_JUMP_SLAM
	end
	
	-- these two aren't defined in ACTs for whatever reason
	if t == "knife" || t == "melee2" then
		self.ActivityTranslate [ ACT_MP_CROUCH_IDLE ] = nil
	end
end

SWEP:SetWeaponHoldType("pistol")

function SWEP:TranslateActivity(act)
	if self:GetIronsights() and self.ActivityTranslateIronSights then
		return self.ActivityTranslateIronSights[act] or -1
	end

	return self.ActivityTranslate and self.ActivityTranslate[act] or -1
end
