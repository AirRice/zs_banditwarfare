AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_waraxe_name"
	SWEP.TranslateDesc = "weapon_waraxe_desc"

	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/props_c17/concrete_barrier001a.mdl", bone = "v_weapon.USP_Parent", rel = "", pos = Vector(-0.69, -3.5, -1.5), angle = Angle(0, 0, 90), size = Vector(0.019, 0.019, 0.019), color = Color(203, 233, 236, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+++"] = { type = "Model", model = "models/props_c17/canister02a.mdl", bone = "v_weapon.USP_Parent", rel = "base+", pos = Vector(-1.201, 0, -0.7), angle = Angle(90, 0, 0), size = Vector(0.129, 0.129, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/props_junk/cinderblock01a.mdl", bone = "v_weapon.USP_Parent", rel = "base", pos = Vector(0.5, 3, 0), angle = Angle(0, 90, 90), size = Vector(0.119, 0.119, 0.119), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base++"] = { type = "Model", model = "models/props_c17/canister02a.mdl", bone = "v_weapon.USP_Parent", rel = "base+", pos = Vector(-1.201, 0, 0.699), angle = Angle(90, 0, 0), size = Vector(0.129, 0.129, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/props_c17/concrete_barrier001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.659, 2.4, -3.651), angle = Angle(0, 85, 0), size = Vector(0.019, 0.019, 0.019), color = Color(203, 233, 236, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+++"] = { type = "Model", model = "models/props_c17/canister02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base+", pos = Vector(-1.201, 0, -0.7), angle = Angle(90, 0, 0), size = Vector(0.129, 0.129, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/props_junk/cinderblock01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0.5, 3, 0), angle = Angle(0, 90, 90), size = Vector(0.119, 0.119, 0.119), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base++"] = { type = "Model", model = "models/props_c17/canister02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base+", pos = Vector(-1.201, 0, 0.699), angle = Angle(90, 0, 0), size = Vector(0.129, 0.129, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.Slot = 1
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DPos = Vector(-0.95, 0, 1)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DBone = "v_weapon.USP_Slide"
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "pistol"

SWEP.ViewModel = "models/weapons/cstrike/c_pist_usp.mdl"
SWEP.WorldModel = "models/weapons/w_pist_usp.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_USP.Single")
SWEP.Primary.Damage = 10
SWEP.Primary.NumShots = 4
SWEP.Primary.Delay = 0.45

SWEP.Primary.ClipSize = 12
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.IronSightsPos = Vector(-5.9, 12, 2.3)

SWEP.ConeMax = 0.015
SWEP.ConeMin = 0.02
SWEP.Recoil = 0.8
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
function SWEP:EmitFireSound()
	self:EmitSound(self.Primary.Sound, 80, 75)
	self:EmitSound("weapons/ar2/npc_ar2_altfire.wav", 55, 150,1,CHAN_VOICE)
end
