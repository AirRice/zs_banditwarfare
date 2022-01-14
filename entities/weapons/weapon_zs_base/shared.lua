SWEP.Primary.Sound = Sound("Weapon_Pistol.Single")
SWEP.Primary.Damage = 30
SWEP.Primary.KnockbackScale = 1
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.15
SWEP.IsFirearm = true

SWEP.ConeMax = 0.03
SWEP.ConeMin = 0.01
SWEP.MovingConeOffset = 0

-- 에임이 늘어나는 단위
SWEP.AimExpandUnit = 0.03
-- 에임이 늘어난 상태가 유지되는 기간
SWEP.AimExpandStayDuration = 0.2
-- 에임이 줄어드는 단위
SWEP.AimCollapseUnit = 0.25

SWEP.CSMuzzleFlashes = true
SWEP.AimStartTime = 0

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
SWEP.ReloadSpeed = 1
SWEP.HoldType = "pistol"
SWEP.IronSightsHoldType = "ar2"

SWEP.IdleActivity = ACT_VM_IDLE

SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.LastAttemptedShot = 0
SWEP.SelfKnockBackForce = 0
SWEP.FireAnimSpeed = 1.0

SWEP.AngleAdded = {
	Pitch = 0,
	Yaw = 0,
	Roll = 0,
	CurrentPitch = 0,
	CurrentYaw = 0,
	CurrentRoll = 0
}

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 31, "ConeAdder")
	self:NetworkVar("Float", 30, "NextAutoReload")
	self:NetworkVar("Float", 29, "ReloadFinish")
	self:NetworkVar("Float", 28, "ReloadStart")
end



function SWEP:Initialize()
	if not self:IsValid() then return end --???

	self:SetWeaponHoldType(self.HoldType)
	self:SetDeploySpeed(1.1)

	-- Maybe we didn't want to convert the weapon to the new system...
	self:SetConeAdder(0)
	if CLIENT then
		self:CheckCustomIronSights()
		self:Anim_Initialize()
		if self.TranslateName then
			self.PrintName = translate.Get(self.TranslateName)
		end
	end
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
	
	if self:GetIronsights() then
		mul = mul - 0.15
	end

	recoil = recoil * mul
	
	if SERVER then
		self.Owner:ViewPunch(Angle(math.Rand(-recoil * 2, 0), math.Rand(-recoil, recoil), 0))
	else
		local curAng = self.Owner:EyeAngles()
		curAng.pitch = curAng.pitch - math.Rand(recoil * 2, 0)
		curAng.yaw = curAng.yaw + math.Rand(-recoil, recoil)
		curAng.Roll = 0
		self.Owner:SetEyeAngles(curAng)
	end
end

function SWEP:GetCone()
	local basecone = self.ConeMin
	local conediff = self.ConeMax - self.ConeMin + self.MovingConeOffset
	
	local multiplier = math.min(self.Owner:GetVelocity():Length() / self.WalkSpeed, 1)*0.3
	if !self.Owner:OnGround() then
		basecone = basecone * 1.2
		multiplier = 0.55
	end
	if self.Owner:Crouching() then 
		multiplier = multiplier - 0.1 
	end
	if self:GetIronsights() then 
		multiplier = multiplier - 0.1 
	end

	return (basecone + self:GetConeAdder()) + conediff*math.max(multiplier,0)
end
function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end 
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	--self:SetNextReload(CurTime() + self.Primary.Delay)
	self:EmitFireSound()
	self:TakeAmmo()
	self:ShootBullets(self.Primary.Damage, self.Primary.NumShots, self:GetCone())
	self.IdleAnimation = CurTime() + self:SequenceDuration()
end

function SWEP:SecondaryAttack()
	if self:GetNextSecondaryFire() <= CurTime() and not self.Owner:IsHolding() and not (self:GetReloadFinish() > 0) then
		self:SetIronsights(true)
	end
end

function SWEP:EmitReloadSound()
	if self.ReloadSound and IsFirstTimePredicted() then
		self:EmitSound(self.ReloadSound, 75, 100, 1, CHAN_WEAPON + 21)
	end
end

function SWEP:EmitReloadFinishSound()
	if self.ReloadFinishSound and IsFirstTimePredicted() then
		self:EmitSound(self.ReloadFinishSound, 75, 100, 1, CHAN_WEAPON + 21)
	end
end

function SWEP:CanReload()
	local hasclip1 = self:GetMaxClip1() > 0 and self:Clip1() < self:GetMaxClip1() and self:ValidPrimaryAmmo() and (self:Ammo1() > 0)
	if self.RequiredClip > 1 then
		hasclip1 = self:GetMaxClip1() > 0 and self:Clip1() < self:GetMaxClip1() and self:ValidPrimaryAmmo() and (self:Ammo1() >= self.RequiredClip)
	end

	return self:GetNextReload() <= CurTime() and self:GetReloadFinish() == 0 and
		(
			hasclip1 or self:GetMaxClip2() > 0 and self:Clip1() < self:GetMaxClip2() and self:ValidSecondaryAmmo() and self:Ammo1() > 0
		)
end

function SWEP:Reload()
	if self.Owner:IsHolding() then return end

	-- Custom reload function that does not use c++ hardcoded DefaultReload, Taken from newer version ZS.
	if self:CanReload() then	
		if self:GetIronsights() then
			self:SetIronsights(false)
		end
		self:SetReloadStart(CurTime())

		self:SendReloadAnimation()
		self:ProcessReloadEndTime()

		self.Owner:DoReloadEvent()
		self.IdleAnimation = CurTime() + self:SequenceDuration()
		self:SetNextReload(self.IdleAnimation)
		self:EmitReloadSound()
	end
end

function SWEP:FinishReload()
	self:SendWeaponAnim(self.IdleActivity)
	self:SetNextReload(0)
	self:SetReloadStart(0)
	self:SetReloadFinish(0)
	self:EmitReloadFinishSound()

	local owner = self:GetOwner()
	if not owner:IsValid() then return end

	local max1 = self:GetMaxClip1()
	local max2 = self:GetMaxClip2()

	if max1 > 0 then
		local ammotype = self:GetPrimaryAmmoType()
		local spare = owner:GetAmmoCount(ammotype)
		local current = self:Clip1()
		local needed = max1 - current

		needed = math.min(spare, needed)

		self:SetClip1(current + needed)
		if SERVER then
			owner:RemoveAmmo(needed, ammotype)
		end
	end

	if max2 > 0 then
		local ammotype = self:GetSecondaryAmmoType()
		local spare = owner:GetAmmoCount(ammotype)
		local current = self:Clip2()
		local needed = max2 - current

		needed = math.min(spare, needed)

		self:SetClip2(current + needed)
		if SERVER then
			owner:RemoveAmmo(needed, ammotype)
		end
	end
end

function SWEP:SendReloadAnimation()
	self:SendWeaponAnim(ACT_VM_RELOAD)
end

function SWEP:ProcessReloadEndTime()
	local reloadspeed = self.ReloadSpeed
	self:SetReloadFinish(CurTime() + self:SequenceDuration() / reloadspeed)
	if not self.DontScaleReloadSpeed then
		self:GetOwner():GetViewModel():SetPlaybackRate(reloadspeed)
	end
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
	self:SetNextAutoReload(0)
	self:SetReloadFinish(0)
	self.LastAttemptedShot = CurTime()
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

function SWEP:GetIronsights()
	return self:GetDTBool(0)
end

function SWEP:CanPrimaryAttack()
	if self.Owner:IsHolding() or self.Owner:GetBarricadeGhosting() or self:GetReloadFinish() > 0 then return false end
	self.LastAttemptedShot = CurTime()
	if self:Clip1() < self.RequiredClip then
		self:EmitSound("Weapon_Pistol.Empty")
		self:SetNextPrimaryFire(CurTime() + math.max(0.25, self.Primary.Delay))
		return false
	end

	return self:GetNextPrimaryFire() <= CurTime()
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
		if attacker:IsPlayer() and attacker.LastShotWeapon and attacker:GetActiveWeapon():GetClass() == attacker.LastShotWeapon 
		and not attacker.RicochetBullet and not tr.HitWorld and not tr.HitSky and tr.Hit and SERVER then
			attacker.ShotsHit = attacker.ShotsHit + 1
		end
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
	self:GetOwner():GetViewModel():SetPlaybackRate(self.FireAnimSpeed)
end

function SWEP:SetConeAndFire()
	self.AimStartTime = CurTime()
	hook.Add("Think", self, function(s)
		s:SetConeAdder(math.Clamp(s:GetConeAdder()+s.AimExpandUnit * FrameTime(), 0, s.ConeMax-s.ConeMin))

		 if (s.AimStartTime + s.Primary.Delay <= CurTime()) then
			s.CollapseStartTime = CurTime()

			hook.Add("Think", s, function(_)
				if (_.CollapseStartTime + _.AimExpandStayDuration > CurTime()) then
					return
				end      
				_:SetConeAdder(math.Clamp(_:GetConeAdder() - _.AimCollapseUnit * FrameTime(), 0, _.ConeMax-_.ConeMin))
				if (_:GetConeAdder() <= 0) then
					hook.Remove("Think", _)
				end
			end)
		end
	end)
end


SWEP.BulletCallback = GenericBulletCallback
function SWEP:ShootBullets(dmg, numbul, cone)	
	self:SetConeAndFire()
	self:DoRecoil()

	local owner = self.Owner
	--owner:MuzzleFlash()
	self:SendWeaponAnimation()
	owner:DoAttackEvent()
	
	if owner and owner:IsValid() and owner:IsPlayer() and self.IsFirearm and SERVER then
		owner.ShotsFired = owner.ShotsFired + numbul
		owner.LastShotWeapon = self:GetClass()
	end
	self:DoSelfKnockBack(1)
	self:StartBulletKnockback()
	if IsFirstTimePredicted() then
		owner:FireBullets({Num = numbul, Src = owner:GetShootPos(), Dir = owner:GetAimVector(), Spread = Vector(cone, cone, 0), Tracer = 1, TracerName = self.TracerName, Force = dmg * 0.1, Damage = dmg, Callback = self.BulletCallback})
	end
	self:DoBulletKnockback(self.Primary.KnockbackScale * 0.05)
	self:EndBulletKnockback()
end

function SWEP:DoSelfKnockBack(scale)
	local owner = self.Owner
	scale = scale or 1
	if owner and owner:IsValid() and owner:IsPlayer() then
		if self.SelfKnockBackForce > 0 then
			if owner:Alive() then
				owner:SetGroundEntity(NULL)
				owner:SetVelocity(-1 * owner:GetAimVector() * self.SelfKnockBackForce * scale)
			end
		end
	end
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
