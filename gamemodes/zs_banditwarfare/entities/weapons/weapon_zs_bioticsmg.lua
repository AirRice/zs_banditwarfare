AddCSLuaFile()
local util_SharedRandom = util.SharedRandom
if CLIENT then
	SWEP.TranslateName = "weapon_bioticsmg_name"
	SWEP.TranslateDesc = "weapon_bioticsmg_desc"
	SWEP.Slot = 2
	SWEP.SlotPos = 0
	
	SWEP.VElements = {
		["sidedecor+++++"] = { type = "Model", model = "models/gibs/gunship_gibs_eye.mdl", bone = "v_weapon.MP5_Parent", rel = "body", pos = Vector(-0.48, 0.764, 8.812), angle = Angle(1.169, -0.331, -180), size = Vector(0.065, 0.101, 0.333), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["body_rib1+++"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "v_weapon.MP5_Parent", rel = "body", pos = Vector(0.649, -0.5, 13.5), angle = Angle(180, 180, 0), size = Vector(0.5, 0.5, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["body_rib1+"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "v_weapon.MP5_Parent", rel = "body", pos = Vector(0.649, 0.5, 13.5), angle = Angle(180, 0, 0), size = Vector(0.5, 0.5, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["ammo+"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "v_weapon.MP5_Clip", rel = "", pos = Vector(0.187, 3.476, -1.037), angle = Angle(0, 0, 102.486), size = Vector(0.652, 0.652, 0.875), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["ammo"] = { type = "Model", model = "models/props_junk/terracotta01.mdl", bone = "v_weapon.MP5_Clip", rel = "", pos = Vector(0.187, 4.787, -0.963), angle = Angle(0, 0, -69.45), size = Vector(0.146, 0.127, 0.365), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["body"] = { type = "Model", model = "models/props_c17/canister_propane01a.mdl", bone = "v_weapon.MP5_Parent", rel = "", pos = Vector(0, -4.211, 1.649), angle = Angle(-180, 90, 0), size = Vector(0.122, 0.054, 0.298), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/zombie_fast/fast_zombie_sheet", skin = 0, bodygroup = {} },
		["sidedecor+++"] = { type = "Model", model = "models/props_junk/meathook001a.mdl", bone = "v_weapon.MP5_Parent", rel = "body", pos = Vector(-0.48, 1.307, 6.206), angle = Angle(180, -32, 0), size = Vector(0.298, 0.298, 0.206), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidedecor"] = { type = "Model", model = "models/gibs/gunship_gibs_eye.mdl", bone = "v_weapon.MP5_Parent", rel = "body", pos = Vector(-0.48, -0.42, 8.812), angle = Angle(167.957, 0, 0), size = Vector(0.065, 0.101, 0.333), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sight"] = { type = "Model", model = "models/gibs/gunship_gibs_sensorarray.mdl", bone = "v_weapon.MP5_Parent", rel = "body", pos = Vector(0, 0.159, 17.436), angle = Angle(161.578, 0, -180), size = Vector(0.202, 0.202, 0.202), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["grip"] = { type = "Model", model = "models/weapons/w_pist_elite_single.mdl", bone = "v_weapon.MP5_Parent", rel = "body", pos = Vector(7.116, 0, 3.586), angle = Angle(90, 0, 0), size = Vector(0.952, 0.952, 0.859), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidedecor++"] = { type = "Model", model = "models/props_junk/meathook001a.mdl", bone = "v_weapon.MP5_Parent", rel = "body", pos = Vector(-0.48, -1.308, 8.781), angle = Angle(0, -148.351, 0), size = Vector(0.298, 0.298, 0.421), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["body_rib1++++"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "v_weapon.MP5_Parent", rel = "body", pos = Vector(-1.232, 0, 3.099), angle = Angle(0, -90, 0), size = Vector(0.705, 0.57, 0.705), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidedecor++++"] = { type = "Model", model = "models/props_junk/meathook001a.mdl", bone = "v_weapon.MP5_Parent", rel = "body", pos = Vector(-0.48, -1.308, 6.206), angle = Angle(180, -148.351, 0), size = Vector(0.298, 0.298, 0.206), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidedecor+"] = { type = "Model", model = "models/props_junk/meathook001a.mdl", bone = "v_weapon.MP5_Parent", rel = "body", pos = Vector(-0.48, 1.307, 8.781), angle = Angle(0, -32.079, 0), size = Vector(0.298, 0.298, 0.421), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["grip+"] = { type = "Model", model = "models/props_c17/canister02a.mdl", bone = "v_weapon.MP5_Parent", rel = "body", pos = Vector(1.682, 0, 7.717), angle = Angle(0, 0, 0), size = Vector(0.187, 0.18, 0.247), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/flesh", skin = 0, bodygroup = {} },
		["body_rib1+++++"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "v_weapon.MP5_Parent", rel = "body", pos = Vector(-1.232, 0, 14), angle = Angle(180, -90, 0), size = Vector(0.705, 0.57, 0.705), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["body_rib1"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "v_weapon.MP5_Parent", rel = "body", pos = Vector(0.649, -0.5, 3.359), angle = Angle(0, 180, 0), size = Vector(0.5, 0.5, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["body_rib1++"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "v_weapon.MP5_Parent", rel = "body", pos = Vector(0.649, 0.5, 3.359), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["sidedecor+++++"] = { type = "Model", model = "models/gibs/gunship_gibs_eye.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(-0.48, 0.764, 8.812), angle = Angle(1.169, -0.331, -180), size = Vector(0.065, 0.101, 0.333), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["body_rib1+++"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(0.649, -0.5, 13.5), angle = Angle(180, 180, 0), size = Vector(0.5, 0.5, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["body_rib1+"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(0.649, 0.5, 13.5), angle = Angle(180, 0, 0), size = Vector(0.5, 0.5, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["ammo+"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(14.678, 1.442, -2.429), angle = Angle(4.477, 92.401, 16.044), size = Vector(0.802, 0.977, 0.802), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["body_rib1++++++"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(-1.232, 0, 3.099), angle = Angle(0, -90, 0), size = Vector(0.705, 0.57, 0.705), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["ammo"] = { type = "Model", model = "models/props_junk/terracotta01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "ammo+", pos = Vector(0.001, -0.145, 1.087), angle = Angle(0, 0, -174.465), size = Vector(0.129, 0.257, 0.379), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["grip+"] = { type = "Model", model = "models/props_c17/canister02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(0.763, 0, 20.576), angle = Angle(0, 0, 0), size = Vector(0.201, 0.131, 0.201), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/flesh", skin = 0, bodygroup = {} },
		["sidedecor+++"] = { type = "Model", model = "models/props_junk/meathook001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(-0.48, 1.307, 6.206), angle = Angle(180, -32, 0), size = Vector(0.298, 0.298, 0.206), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidedecor"] = { type = "Model", model = "models/gibs/gunship_gibs_eye.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(-0.48, -0.42, 8.812), angle = Angle(167.957, 0, 0), size = Vector(0.065, 0.101, 0.333), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sight"] = { type = "Model", model = "models/gibs/gunship_gibs_sensorarray.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(0, 0.013, 19.444), angle = Angle(161.578, 0, -180), size = Vector(0.202, 0.202, 0.202), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidedecor++"] = { type = "Model", model = "models/props_junk/meathook001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(-0.48, -1.308, 8.781), angle = Angle(0, -148.351, 0), size = Vector(0.298, 0.298, 0.421), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["body_rib1"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(0.649, -0.5, 3.359), angle = Angle(0, 180, 0), size = Vector(0.5, 0.5, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["body_rib1++++"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(1.577, 0, 18.879), angle = Angle(-180, 90, 7.517), size = Vector(0.776, 0.776, 0.86), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["body_rib1++"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(0.649, 0.5, 3.359), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["grip++"] = { type = "Model", model = "models/props_c17/canister02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(1.95, 0, 8.277), angle = Angle(0, 0, 0), size = Vector(0.344, 0.279, 0.273), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/flesh", skin = 0, bodygroup = {} },
		["body"] = { type = "Model", model = "models/props_c17/canister_propane01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.695, 0.893, -5.103), angle = Angle(101.836, -180, -1.249), size = Vector(0.122, 0.09, 0.347), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/zombie_fast/fast_zombie_sheet", skin = 0, bodygroup = {} },
		["body_rib1+++++"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(-1.232, 0, 14), angle = Angle(180, -90, 0), size = Vector(0.705, 0.57, 0.705), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidedecor++++"] = { type = "Model", model = "models/props_junk/meathook001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(-0.48, -1.308, 6.206), angle = Angle(180, -148.351, 0), size = Vector(0.298, 0.298, 0.206), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidedecor+"] = { type = "Model", model = "models/props_junk/meathook001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(-0.48, 1.307, 8.781), angle = Angle(0, -32.079, 0), size = Vector(0.298, 0.298, 0.421), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 50

	SWEP.HUD3DBone = "v_weapon.MP5_Parent"
	SWEP.HUD3DPos = Vector(-1.1, -6.6, -7)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.02
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "smg"

SWEP.ViewModel = "models/weapons/cstrike/c_smg_mp5.mdl"
SWEP.WorldModel = "models/weapons/w_smg_mp5.mdl"
SWEP.UseHands = true
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = true

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_SMG1.Reload")
SWEP.Primary.Sound = Sound("Weapon_AR2.NPC_Single")
SWEP.Primary.Damage = 15
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.13

SWEP.Primary.ClipSize = 40
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "alyxgun"
SWEP.Primary.DefaultClip = 200

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SMG1

SWEP.ConeMax = 0.125
SWEP.ConeMin = 0.019
SWEP.Recoil = 1.05
SWEP.WalkSpeed = SPEED_NORMAL
SWEP.m_NotBulletWeapon = true

function SWEP:ShootBullets(dmg, numbul, cone)
	local owner = self:GetOwner()
	--owner:MuzzleFlash()
	if SERVER then
		self:SetConeAndFire()
	end
	self:DoRecoil()
	self:SendWeaponAnimation()
	owner:DoAttackEvent()

	self:GetOwner():EmitSound("physics/flesh/flesh_strider_impact_bullet"..math.random(1, 3)..".wav", 72, math.Rand(85, 95), 0.5)
	if CLIENT then return end
	local aimvec = owner:GetAimVector()
	for i=1, numbul do
	local ent = ents.Create("projectile_poisonspit_smg")
	if ent:IsValid() then
		ent:SetOwner(owner)
		aimvec.z = math.max(aimvec.z, -0.25)
		aimvec:Normalize()
		local vStart = owner:GetShootPos()
		ent:SetPos(vStart)
		ent:Spawn()
		ent.Damage = self.Primary.Damage
		local phys = ent:GetPhysicsObject()
		if phys:IsValid() then
			local cone = math.deg(self:GetCone())
			local eyeang = self:GetOwner():EyeAngles()
			eyeang:RotateAroundAxis(eyeang:Forward(),util_SharedRandom("rotate"..self:EntIndex(), 0, 360))
			eyeang:RotateAroundAxis(eyeang:Up(),util_SharedRandom("bulletangle"..self:EntIndex(), -cone, cone))
			phys:Wake()
			phys:SetVelocityInstantaneous(eyeang:Forward() * 1700)
			phys:EnableGravity(false)
		end
	end
	end
end

SWEP.IronSightsPos = Vector(-2.641, 0, 0.6)
SWEP.IronSightsAng = Vector(0, 0, -15)

