AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_megamasher_name"
	SWEP.TranslateDesc = "weapon_megamasher_desc"
	SWEP.ViewModelFOV = 75

	SWEP.VElements = {
		["base2"] = { type = "Model", model = "models/props_wasteland/buoy01.mdl", bone = "ValveBiped.Bip01", rel = "base", pos = Vector(12, 0, 0), angle = Angle(0, 90, 270), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base"] = { type = "Model", model = "models/props_junk/iBeam01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12.706, 2.761, -22), angle = Angle(13, -12.5, 0), size = Vector(0.15, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base3"] = { type = "Model", model = "models/props_borealis/bluebarrel001.mdl", bone = "ValveBiped.Bip01", rel = "base", pos = Vector(-5, 0, 0), angle = Angle(0, 270, 90), size = Vector(0.4, 0.4, 0.4), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["base2"] = { type = "Model", model = "models/props_wasteland/buoy01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(12, 0, 0), angle = Angle(90, 0, 0), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base"] = { type = "Model", model = "models/props_junk/iBeam01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10, 1, -35), angle = Angle(0, 0, 90), size = Vector(0.15, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base3"] = { type = "Model", model = "models/props_borealis/bluebarrel001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-5, 0, 0), angle = Angle(90, 0, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.HoldType = "melee2"

SWEP.DamageType = DMG_CLUB

SWEP.ViewModel = "models/weapons/v_sledgehammer/c_sledgehammer.mdl"
SWEP.WorldModel = "models/weapons/w_sledgehammer.mdl"
SWEP.UseHands = true

SWEP.MeleeDamage = 150
SWEP.MeleeRange = 75
SWEP.MeleeSize = 4
SWEP.MeleeKnockBack = 150

SWEP.Primary.Delay = 2.25

SWEP.WalkSpeed = SPEED_SLOWEST * 0.5
SWEP.SwingWalkSpeed = SPEED_FASTEST * 1.5
SWEP.SwingRotation = Angle(60, 0, -80)
SWEP.SwingOffset = Vector(0, -30, 0)
SWEP.SwingTime = 1.33
SWEP.SwingHoldType = "melee"

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(20, 25))
end

function SWEP:PlayHitSound()
	self:EmitSound("vehicles/v8/vehicle_impact_heavy"..math.random(4)..".wav", 80, math.Rand(95, 105))
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/flesh/flesh_bloody_break.wav", 80, math.Rand(90, 100))
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	local effectdata = EffectData()
		effectdata:SetOrigin(tr.HitPos)
		effectdata:SetNormal(tr.HitNormal)
	util.Effect("explosion", effectdata)
	for _, ent in pairs(ents.FindInSphere(tr.HitPos, 64)) do
		if ent and ent:IsValid() and not ent == self:GetOwner() and not ent:IsPlayer() then
			local nearest = ent:NearestPoint(tr.HitPos)
			local ratio = 1
			if nearest:Distance(tr.HitPos) > 32 then
				ratio = 0.5+0.5*math.Clamp((nearest:Distance(tr.HitPos)-32)/64 ,0,1)
			end
			if TrueVisibleFilters(tr.HitPos, nearest, inflictor, ent) then
				ent:TakeSpecialDamage(ratio * self.MeleeDamage * 0.25, DMG_BLAST, self:GetOwner(), self, nearest)
			end
		end
	end
	if IsValid(hitent) then
		if not hitent:IsPlayer() and self:GetOwner():IsPlayer() then
			if hitent:GetClass() == "prop_drone" or hitent:GetClass() == "prop_manhack" and not hitent:IsSameTeam(self:GetOwner()) and SERVER then
				hitent:Destroy()
			elseif not hitent:IsSameTeam(self:GetOwner()) and SERVER and (hitent:IsNailed() or hitent.IsBarricadeObject) then
				hitent:TakeSpecialDamage(math.max(hitent:GetBarricadeHealth() or self.MeleeDamage,500), DMG_DIRECT, self:GetOwner(), self, tr.HitPos)
			end
		end
	end
end

function SWEP:Move(mv)
	if self:IsSwinging() then
		local ratio = math.Clamp((self:GetSwingEnd()-CurTime())/self.SwingTime,0,1)
		local speed = self.WalkSpeed + (self.SwingWalkSpeed)*ratio
		--mv:SetForwardSpeed(10000)
		--mv:SetSideSpeed(mv:GetSideSpeed() * 0.05)
		mv:SetMaxSpeed(speed)
		mv:SetMaxClientSpeed(speed)	
	end
end

function SWEP:StartSwinging()
	self.m_LastViewAngles = self:GetOwner():EyeAngles()
	self.BaseClass.StartSwinging(self)
end

function SWEP:StopSwinging()
	self.m_LastViewAngles = nil
	self.BaseClass.StopSwinging(self)
end

if not CLIENT then return end

function SWEP:CreateMove(cmd)
	if self.m_LastViewAngles and self:IsSwinging() then
		local difflimit = 256
		local maxdiff = FrameTime() * difflimit
		local mindiff = -maxdiff
		local originalangles = self.m_LastViewAngles
		local viewangles = cmd:GetViewAngles()

		local diff = math.AngleDifference(viewangles.yaw, originalangles.yaw)
		if diff > maxdiff or diff < mindiff then
			viewangles.yaw = math.NormalizeAngle(originalangles.yaw + math.Clamp(diff, mindiff, maxdiff))
		end

		self.m_LastViewAngles = viewangles

		cmd:SetViewAngles(viewangles)
	end
end