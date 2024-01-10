AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_sawhack_name"
	SWEP.TranslateDesc = "weapon_sawhack_desc"
	SWEP.ViewModelFOV = 60

	SWEP.VElements = {
		["axe"] = { type = "Model", model = "models/props/cs_militia/axe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.184, 1.501, -7.421), angle = Angle(2.427, -10, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["saw"] = { type = "Model", model = "models/props_junk/sawblade001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "axe", pos = Vector(0, 14, -0.021), angle = Angle(0, 0, 0), size = Vector(0.449, 0.449, 0.805), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["saw2"] = { type = "Model", model = "models/XQM/Rails/trackball_1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "axe", pos = Vector(0, 14, 0), angle = Angle(0, 0, 0), size = Vector(0.234, 0.234, 0.133), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_lab/door_klab01", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["axe"] = { type = "Model", model = "models/props/cs_militia/axe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.023, 2.147, -8.32), angle = Angle(-6.166, 20.881, 86.675), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["saw2"] = { type = "Model", model = "models/XQM/Rails/trackball_1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "axe", pos = Vector(0, 14, 0), angle = Angle(0, 90, 0), size = Vector(0.234, 0.234, 0.133), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_lab/door_klab01", skin = 0, bodygroup = {} },
		["saw"] = { type = "Model", model = "models/props_junk/sawblade001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "axe", pos = Vector(0, 14, -0.021), angle = Angle(0, 0, 0), size = Vector(0.449, 0.449, 0.805), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true

SWEP.HoldType = "melee2"

SWEP.Primary.Delay = 0.45

SWEP.MeleeDamage = 20
SWEP.MeleeRange = 55
SWEP.MeleeSize = 1.9
SWEP.MeleeKnockBack = 10

SWEP.WalkSpeed = SPEED_FAST

SWEP.SwingTime = 0.15
SWEP.SwingRotation = Angle(0, -35, -50)
SWEP.SwingOffset = Vector(10, 0, 0)
SWEP.HoldType = "melee2"
SWEP.SwingHoldType = "melee"
SWEP.SpecialHoldType = "slam"

SWEP.HitDecal = "Manhackcut"
SWEP.HitAnim = ACT_VM_MISSCENTER

SWEP.BlockingPos = Vector(34, 10, -10)
SWEP.BlockingAng = Angle(0, 90, -20)

SWEP.LastStartBlocking = 0
SWEP.BlockDelay = 0.3
SWEP.LastStopBlocking = 0
sound.Add( {
	name = "Loop_Sawhack_Engine",
	channel = CHAN_AUTO+20,
	volume = 1,
	level = 75,
	pitch = 70,
	volume = 0.2,
	sound = "npc/manhack/mh_blade_loop1.wav"
} )
sound.Add( {
	name = "Loop_Sawhack_Engine2",
	channel = CHAN_AUTO+21,
	volume = 1,
	level = 75,
	pitch = 130,
	volume = 0.1,
	sound = "npc/manhack/mh_engine_loop1.wav"
} )

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 5, "Blocking")
	if self.BaseClass.SetupDataTables then
		self.BaseClass.SetupDataTables(self)
	end
end

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(75, 80))
end

function SWEP:PlayHitSound()
	self:EmitSound("npc/manhack/grind"..math.random(5)..".wav")
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("ambient/machines/slicer"..math.random(4)..".wav")
end

function SWEP:Deploy()
	if self.BaseClass.Deploy then
		self.BaseClass.Deploy(self)
	end
    self:EmitSound( "Loop_Sawhack_Engine" )
	self:EmitSound( "Loop_Sawhack_Engine2" )	
    return true
end

function SWEP:OnRemove()
	self:StopSound( "Loop_Sawhack_Engine" )
	self:StopSound( "Loop_Sawhack_Engine2" )
end

function SWEP:Holster()
    self:StopSound( "Loop_Sawhack_Engine" )
	self:StopSound( "Loop_Sawhack_Engine2" )
	return self.BaseClass.Holster(self)
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if not hitflesh then
		local effectdata = EffectData()
			effectdata:SetOrigin(tr.HitPos)
			effectdata:SetNormal(tr.HitNormal)
			effectdata:SetMagnitude(2)
			effectdata:SetScale(1)
		util.Effect("sparks", effectdata)
	end
end

function SWEP:CanPrimaryAttack()
	if self:GetBlocking() or (self.LastStopBlocking + self.BlockDelay) >= CurTime() then
		return false
	end
	if self.BaseClass.CanPrimaryAttack then
		return self.BaseClass.CanPrimaryAttack(self)
	end
	return true
end

function SWEP:Think()
    if self:GetOwner():KeyReleased(IN_ATTACK2) or not self:GetOwner():Alive() or self:GetOwner():Health() <= 0 then
		self:SetBlocking( false )
		self.LastStopBlocking = CurTime()
    end
    if self:GetOwner():KeyDown(IN_ATTACK2) then
		if not self:GetBlocking() then
			self.LastStartBlocking = CurTime()
			self:SetBlocking(true)
		end
	end
	if self.BaseClass.Think then
		self.BaseClass.Think(self)
	end
end

function SWEP:Move(mv)
	if self:GetBlocking() and mv:KeyDown(IN_ATTACK2) and not self:GetOwner():GetBarricadeGhosting() then
		mv:SetMaxSpeed(self.WalkSpeed*0.25)
		mv:SetMaxClientSpeed(self.WalkSpeed*0.25)	
		mv:SetSideSpeed(mv:GetSideSpeed() * 0.25)
	end
end

function SWEP:PlayerHitUtil(owner, damage, hitent, dmginfo)
	hitent:MeleeViewPunch(damage*0.1)
	if hitent:WouldDieFrom(damage, dmginfo:GetDamagePosition()) then
		hitent:Dismember(hitent:NearestDismemberableBone(dmginfo:GetDamagePosition()))
	else
		local bleed = hitent:GetStatus("bleed")
		if bleed and bleed:IsValid() then
			bleed:AddDamage(damage)
			bleed.Damager = owner
		else
			local stat = hitent:GiveStatus("bleed")
			if stat and stat:IsValid() then
				stat:SetDamage(damage)
				stat.Damager = owner
			end
		end
	end
end

if SERVER then
	function SWEP:ProcessDamage(dmginfo)
		local attacker, inflictor = dmginfo:GetAttacker(), dmginfo:GetInflictor()
		local owner = self:GetOwner()
		local lasthitgroup = owner:LastHitGroup()
		local attackweapon = (attacker:IsPlayer() and attacker:GetActiveWeapon() or nil)
		if attacker:IsPlayer() then
			local center = owner:LocalToWorld(owner:OBBCenter())
			local hitpos = owner:NearestPoint(dmginfo:GetDamagePosition())
			if dmginfo:IsDamageType(DMG_BULLET) and not (attackweapon and attackweapon.IgnoreDamageScaling) and owner:IsPosInBoneRange(hitpos, "ValveBiped.Bip01_Head1", 24) and math.random(10) > 3 then
				local reflectdmginfo = dmginfo
				dmginfo:SetDamage(0)
				local effectdata = EffectData()
					effectdata:SetOrigin(center)
					effectdata:SetStart(owner:WorldToLocal(hitpos))
					effectdata:SetAngles((center - hitpos):Angle())
					effectdata:SetEntity(owner)
				util.Effect("shadedeflect", effectdata, true, true)

				local reflectTarget = self:GetClosestReflectTarget()
				local damage = reflectdmginfo:GetDamage()
				if IsValid(reflectTarget) && reflectTarget:IsPlayer() && IsFirstTimePredicted() then
					self:FireBullets({Num = 1, Src = hitpos, Dir = reflectTarget:EyePos() - hitpos, Spread = Vector(0.15, 0.15, 0), Tracer = 1, TracerName = "rico_trace", Force = damage * 0.15, Damage = damage, Callback = GenericBulletCallback})
				end
			end
		end
	end

	function SWEP:GetClosestReflectTarget()
		local owner = self:GetOwner()
		local minimum = nil
		local selectedTarget = nil
		local mypos = owner:EyePos()
		for _,ent in ipairs(player.GetAllActive()) do
			if ent == owner or ent:Team() == owner:Team() or (ent:Team() != TEAM_BANDIT && ent:Team() != TEAM_HUMAN) then continue end
			local centre = ent:WorldSpaceCenter()
			local sqrdst = mypos:DistToSqr(centre)
			if (centre - mypos):GetNormalized():Dot(owner:GetAimVector()) < 0.5 then continue end
			if (minimum == nil or sqrdst < minimum) then
				minimum = sqrdst
				selectedTarget = ent
			end
		end
		if (selectedTarget and selectedTarget:IsValid() and WorldVisible(mypos,selectedTarget:WorldSpaceCenter())) then
			return selectedTarget
		else
			return nil
		end
	end
end

function SWEP:TranslateActivity( act )

	if self:GetBlocking() and self.ActivityTranslateSpecial[act] then
		return self.ActivityTranslateSpecial[act] or -1
	end

	return self.BaseClass.TranslateActivity(self, act)
end


if CLIENT then
	function SWEP:PostDrawViewModel(vm, pl, wep)
		local veles = self.VElements
		local saw1ang = veles["saw"].angle
		local saw2ang = veles["saw2"].angle
		local rotatespeed = CurTime()*1400
		saw1ang.y = (rotatespeed)%360
		saw2ang.y = (rotatespeed)%360
		if self.BaseClass.PostDrawViewModel then 
			self.BaseClass.PostDrawViewModel(self,vm, pl, wep)
		end
	end
	function SWEP:DrawWorldModel()
		local owner = self:GetOwner()
		if owner:IsValid() and owner.ShadowMan then return end
		local weles = self.WElements
		local saw1ang = weles["saw"].angle
		local saw2ang = weles["saw2"].angle
		local rotatespeed = CurTime()*1400
		saw1ang.y = (rotatespeed)%360
		saw2ang.y = (rotatespeed)%360
		self:Anim_DrawWorldModel()
	end

	local ghostlerp = 0
	function SWEP:GetViewModelPosition(pos, ang)
		
			local rot = self.BlockingAng
			local offset = self.BlockingPos

			ang = Angle(ang.pitch, ang.yaw, ang.roll) -- Copy
			local power = 0
			if self:GetBlocking() then
				local delta = math.Clamp(CurTime() - self.LastStartBlocking , 0, self.BlockDelay)
				power = CosineInterpolation(0, 1, delta / self.BlockDelay)
			else
				local delta = math.Clamp(math.Clamp((self.LastStopBlocking - self.LastStartBlocking), 0, self.BlockDelay) - (CurTime() - self.LastStopBlocking), 0, self.BlockDelay)
				power = CosineInterpolation(0, 1, delta / self.BlockDelay)				
			end
			pos = pos + offset.x * power * ang:Right() + offset.y * power * ang:Forward() + offset.z * power * ang:Up()

			ang:RotateAroundAxis(ang:Right(), rot.pitch * power)
			ang:RotateAroundAxis(ang:Up(), rot.yaw * power)
			ang:RotateAroundAxis(ang:Forward(), rot.roll * power)
		

		if self:GetOwner():GetBarricadeGhosting() then
			ghostlerp = math.min(1, ghostlerp + FrameTime() * 4)
		elseif ghostlerp > 0 then
			ghostlerp = math.max(0, ghostlerp - FrameTime() * 5)
		end

		if ghostlerp > 0 then
			pos = pos + 3.5 * ghostlerp * ang:Up()
			ang:RotateAroundAxis(ang:Right(), -30 * ghostlerp)
		end

		return pos, ang
	end
end