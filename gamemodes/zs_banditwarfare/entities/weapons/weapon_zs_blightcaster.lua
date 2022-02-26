AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_blightcaster_name"
	SWEP.TranslateDesc = "weapon_blightcaster_desc"
	SWEP.Slot = 3
	SWEP.SlotPos = 0

	SWEP.ViewModelFOV = 48
	SWEP.ViewModelFlip = false

	SWEP.HUD3DBone = "base"
	SWEP.HUD3DPos = Vector(0.5, -3.5, 22)
	SWEP.HUD3DAng = Angle(180, 0, 0)
	SWEP.HUD3DScale = 0.035
	SWEP.VElements = {
		["Handle+"] = { type = "Model", model = "models/props_pipes/pipeset02d_64_001a.mdl", bone = "base", rel = "Handle", pos = Vector(5.431, 1.207, 7.267), angle = Angle(0, 180, 12), size = Vector(0.225, 0.225, 0.225), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Base+++"] = { type = "Model", model = "models/gibs/strider_gib3.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Handle", pos = Vector(1.5, 5.721, 7.019), angle = Angle(0, -90, 0), size = Vector(0.224, 0.423, 0.224), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Frontnoz"] = { type = "Model", model = "models/gibs/gunship_gibs_headsection.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Handle", pos = Vector(17.701, 0, 12.02), angle = Angle(7.481, 0, 0), size = Vector(0.093, 0.093, 0.093), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/charple/charple3_sheet", skin = 0, bodygroup = {} },
		["Handle+++"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "base", rel = "Handle", pos = Vector(6.142, 0, 7.006), angle = Angle(0, 90, 0), size = Vector(0.026, 0.03, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Base"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Handle", pos = Vector(-0.594, 0, 8.718), angle = Angle(0, -90, -101.359), size = Vector(2.137, 2.137, 2.137), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Base++++"] = { type = "Model", model = "models/props_pipes/pipecluster16d_001a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Handle", pos = Vector(0.658, 0.407, 10.89), angle = Angle(0, -90, 0), size = Vector(0.041, 0.041, 0.041), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Base+"] = { type = "Model", model = "models/gibs/strider_gib1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Handle", pos = Vector(-11.884, 0, 8.944), angle = Angle(0, 0, 0), size = Vector(0.224, 0.264, 0.263), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Base+++++"] = { type = "Model", model = "models/props_vents/vent_cluster001.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Handle", pos = Vector(-0.831, 2.029, 10.89), angle = Angle(0, -90, 0), size = Vector(0.112, 0.112, 0.112), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Frontnoz+"] = { type = "Model", model = "models/maxofs2d/thruster_projector.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Handle", pos = Vector(14.829, 0, 9.517), angle = Angle(-90, 0, 0), size = Vector(0.342, 0.342, 0.342), color = Color(175, 255, 255, 255), surpresslightning = false, material = "models/flesh", skin = 0, bodygroup = {} },
		["Handle++"] = { type = "Model", model = "models/props_pipes/pipeset02d_64_001a.mdl", bone = "base", rel = "Handle", pos = Vector(5.431, -1.208, 7.267), angle = Angle(0, 180, 168), size = Vector(0.225, 0.225, 0.225), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Handle"] = { type = "Model", model = "models/weapons/w_pist_deagle.mdl", bone = "base", rel = "", pos = Vector(-0.851, 10.204, 10.258), angle = Angle(90, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Base++"] = { type = "Model", model = "models/gibs/strider_gib3.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Handle", pos = Vector(1.5, -5.722, 7.019), angle = Angle(0, 90, 0), size = Vector(0.224, 0.423, 0.224), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["Handle+"] = { type = "Model", model = "models/props_pipes/pipeset02d_64_001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Handle", pos = Vector(5.431, 1.207, 7.267), angle = Angle(0, 180, 12), size = Vector(0.225, 0.225, 0.225), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Base+++"] = { type = "Model", model = "models/gibs/strider_gib3.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Handle", pos = Vector(1.5, 5.721, 7.019), angle = Angle(0, -90, 0), size = Vector(0.224, 0.423, 0.224), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Frontnoz"] = { type = "Model", model = "models/gibs/gunship_gibs_headsection.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Handle", pos = Vector(17.701, 0, 12.02), angle = Angle(7.481, 0, 0), size = Vector(0.093, 0.093, 0.093), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/charple/charple3_sheet", skin = 0, bodygroup = {} },
		["Handle+++"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Handle", pos = Vector(6.142, 0, 7.006), angle = Angle(0, 90, 0), size = Vector(0.026, 0.03, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Base"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Handle", pos = Vector(-0.594, 0, 8.718), angle = Angle(0, -90, -101.359), size = Vector(2.137, 2.137, 2.137), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Base++"] = { type = "Model", model = "models/gibs/strider_gib3.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Handle", pos = Vector(1.5, -5.722, 7.019), angle = Angle(0, 90, 0), size = Vector(0.224, 0.423, 0.224), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Base+"] = { type = "Model", model = "models/gibs/strider_gib1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Handle", pos = Vector(-11.884, 0, 8.944), angle = Angle(0, 0, 0), size = Vector(0.224, 0.264, 0.263), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Handle"] = { type = "Model", model = "models/weapons/w_pist_deagle.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.663, 0.847, 2.459), angle = Angle(-4.717, -5.415, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Frontnoz+"] = { type = "Model", model = "models/maxofs2d/thruster_projector.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Handle", pos = Vector(14.829, 0, 9.517), angle = Angle(-90, 0, 0), size = Vector(0.342, 0.342, 0.342), color = Color(175, 255, 255, 255), surpresslightning = false, material = "models/flesh", skin = 0, bodygroup = {} },
		["Handle++"] = { type = "Model", model = "models/props_pipes/pipeset02d_64_001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Handle", pos = Vector(5.431, -1.208, 7.267), angle = Angle(0, 180, 168), size = Vector(0.225, 0.225, 0.225), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Base++++"] = { type = "Model", model = "models/props_pipes/pipecluster16d_001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Handle", pos = Vector(0.658, 0.407, 10.89), angle = Angle(0, -90, 0), size = Vector(0.041, 0.041, 0.041), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Base+++++"] = { type = "Model", model = "models/props_vents/vent_cluster001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Handle", pos = Vector(-0.831, 2.029, 10.89), angle = Angle(0, -90, 0), size = Vector(0.112, 0.112, 0.112), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end
SWEP.ShowWorldModel = false
SWEP.ShowViewModel = false
SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "shotgun"
SWEP.IronSightsHoldType = "rpg"
SWEP.ViewModel = "models/weapons/c_rpg.mdl"
SWEP.WorldModel = "models/weapons/w_rocket_launcher.mdl"
SWEP.UseHands = true

SWEP.Primary.Damage = 50
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.6
SWEP.ReloadSpeed = 0.5

SWEP.Primary.ClipSize = 3
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "alyxgun"
SWEP.Primary.DefaultClip = 15

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN

SWEP.ConeMax = 0.003
SWEP.ConeMin = 0
SWEP.Recoil = 2.25
SWEP.MovingConeOffset = 0.28
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
SWEP.IronSightsPos = Vector(-16.8, 30, -3.64)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.WalkSpeed = SPEED_SLOWER
function SWEP:EmitFireSound()
	self:EmitSound("weapons/grenade_launcher1.wav", 80, math.random(76, 82), 0.8)
	self:EmitSound("npc/ichthyosaur/water_growl5.wav", 75, 170, 0.75, CHAN_WEAPON + 20)
	self:EmitSound(string.format("physics/body/body_medium_break%d.wav", math.random(2, 4)), 72, math.random(70, 80), 0.75, CHAN_WEAPON + 21)
end

function SWEP:EmitReloadSound()
	if IsFirstTimePredicted() then
		self:EmitSound("npc/barnacle/barnacle_digesting"..math.random(1,2)..".wav", 75, 135, 1, CHAN_WEAPON + 20)
		self:EmitSound("npc/headcrab_poison/ph_poisonbite3.wav", 75, 46, 0.75, CHAN_WEAPON + 21)
	end
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:EmitFireSound()	
	self:TakeAmmo()
	local dmg = self.Primary.Damage
	self:SetConeAndFire()
	self:DoRecoil()

	local owner = self:GetOwner()
	--owner:MuzzleFlash()
	self:SendWeaponAnimation()
	owner:DoAttackEvent()
	local aimvec = owner:GetAimVector()
	if SERVER then
		local ent = ents.Create("projectile_bonemesh_blightcaster")
		if ent:IsValid() then
			ent:SetPos(owner:GetShootPos())
			local ang = owner:EyeAngles()
			ang:RotateAroundAxis(ang:Up(), -90)
			ent:SetAngles(ang)
			ent:SetOwner(owner)
			ent:Spawn()
			ent.Damage = self.Primary.Damage
			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then
				phys:Wake()
				phys:SetVelocity(aimvec *1900)
			end
			--ent:SetVelocity(aimvec *2200)
		end
    end
	self.IdleAnimation = CurTime() + self:SequenceDuration()
end