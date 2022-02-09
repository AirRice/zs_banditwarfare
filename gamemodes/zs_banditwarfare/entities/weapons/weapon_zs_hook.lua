AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_meathook_name"
	SWEP.TranslateDesc = "weapon_meathook_desc"
	
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/props_junk/meathook001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 1.363, -5), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/props_junk/meathook001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.181, 4, -9), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.DamageType = DMG_SLASH

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/props_junk/meathook001a.mdl"
SWEP.UseHands = true

SWEP.MeleeDamage = 10
SWEP.MeleeRange = 65
SWEP.MeleeSize = 1.15

SWEP.HitGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
SWEP.MissGesture = SWEP.HitGesture
SWEP.Primary.Delay = 1.3
SWEP.SwingRotation = Angle(30, -30, -30)
SWEP.SwingTime = 0.45
SWEP.SwingHoldType = "grenade"

SWEP.IsConsumable = true

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(95, 105))
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav", 75, math.random(120, 130))
end

function SWEP:PlayHitSound()
	self:EmitSound("physics/metal/metal_sheet_impact_bullet"..math.random(2)..".wav")
end

function SWEP:PlayerHitUtil(owner, damage, hitent, dmginfo)
	hitent:MeleeViewPunch(damage*0.5)
	if hitent:Health() > self.MeleeDamage then
		local status = hitent:GetStatus("spawnbuff")
		if status and status:IsValid() then
			return false
		end
		hitent:AddLegDamage(50)

		if SERVER then
			local ang = self:GetOwner():EyeAngles()
			ang:RotateAroundAxis(ang:Forward(), 180)

			local startPos = owner:GetShootPos()

			local endPos = startPos + ang:Forward() * self.MeleeRange

			local tr = util.TraceHull({start = startPos, endpos = endPos, filter = owner, mins = Vector(-self.MeleeSize, -self.MeleeSize, -self.MeleeSize), maxs = Vector(self.MeleeSize, self.MeleeSize, self.MeleeSize)})

			local ent = ents.Create("prop_meathook")
			if ent:IsValid() then
				ent:SetPos(tr.HitPos)
				ent:Spawn()
				ent:SetOwner(owner)

				local followed = false
				if hitent:GetBoneCount() > 1 then
					local boneindex = hitent:NearestBone(tr.HitPos)
					if boneindex and boneindex > 0 then
						ent:FollowBone(hitent, boneindex)
						ent:SetPos((hitent:GetBonePositionMatrixed(boneindex) * 2 + tr.HitPos) / 3)
						followed = true
					end
				end
				if not followed then
					ent:SetParent(hitent)
				end

				ent:SetAngles(ang)
			end
			timer.Simple(0, function() owner:StripWeapon(self:GetClass()) end)
		end
	end
end