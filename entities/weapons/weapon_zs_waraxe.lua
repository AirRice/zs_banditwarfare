AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_waraxe_name"
	SWEP.TranslateDesc = "weapon_waraxe_desc"
	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/props_trainstation/pole_448Connection002b.mdl", bone = "v_weapon.Glock_Slide", rel = "", pos = Vector(3.292, 0.305, -0.005), angle = Angle(13.053, -90.301, 89.9), size = Vector(0.085, 0.045, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sides"] = { type = "Model", model = "models/props_trainstation/Column_Arch001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-0.06, 0, -0.08), angle = Angle(0, 0, 0), size = Vector(0.119, 0.008, 0.09), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["backing"] = { type = "Model", model = "models/props_c17/concrete_barrier001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(1, 0, 4.5), angle = Angle(90, 0, 0), size = Vector(0.08, 0.016, 0.03), color = Color(203, 233, 236, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["nozzle1"] = { type = "Model", model = "models/props_c17/canister02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "nozzlebase", pos = Vector(-1.7, 0, -0.7), angle = Angle(90, 0, 0), size = Vector(0.129, 0.129, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["nozzlebase"] = { type = "Model", model = "models/props_junk/cinderblock01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 0, -4), angle = Angle(90, 0, 90), size = Vector(0.2, 0.15, 0.12), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["nozzle2"] = { type = "Model", model = "models/props_c17/canister02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "nozzlebase", pos = Vector(-1.7, 0, 0.7), angle = Angle(90, 0, 0), size = Vector(0.129, 0.129, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/props_trainstation/pole_448Connection002b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 1.71, -3.711), angle = Angle(87.421, -5.053, 0), size = Vector(0.085, 0.045, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sides"] = { type = "Model", model = "models/props_trainstation/Column_Arch001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-0.06, 0, -0.08), angle = Angle(0, 0, 0), size = Vector(0.119, 0.008, 0.09), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["backing"] = { type = "Model", model = "models/props_c17/concrete_barrier001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(1, 0, 4.5), angle = Angle(90, 0, 0), size = Vector(0.08, 0.016, 0.03), color = Color(203, 233, 236, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["nozzle1"] = { type = "Model", model = "models/props_c17/canister02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "nozzlebase", pos = Vector(-1.7, 0, -0.7), angle = Angle(90, 0, 0), size = Vector(0.129, 0.129, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["nozzlebase"] = { type = "Model", model = "models/props_junk/cinderblock01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 0, -4), angle = Angle(90, 0, 90), size = Vector(0.2, 0.15, 0.12), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["nozzle2"] = { type = "Model", model = "models/props_c17/canister02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "nozzlebase", pos = Vector(-1.7, 0, 0.7), angle = Angle(90, 0, 0), size = Vector(0.129, 0.129, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.Slot = 1
	SWEP.SlotPos = 3

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "v_weapon.Glock_Slide"
	SWEP.HUD3DPos = Vector(0.5, 0.5, -1.25)
	SWEP.HUD3DAng = Angle(90, 0, 0)
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "pistol"

SWEP.ViewModel = "models/weapons/cstrike/c_pist_glock18.mdl"
SWEP.WorldModel = "models/weapons/w_pist_glock18.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_USP.Single")
SWEP.Primary.Damage = 10
SWEP.Primary.NumShots = 4
SWEP.Primary.Delay = 0.3

SWEP.Primary.ClipSize = 12
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.IronSightsPos = Vector(-5.9, 12, 2.3)

SWEP.ConeMax = 0.035
SWEP.ConeMin = 0.02
SWEP.Recoil = 0.8
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
function SWEP:EmitFireSound()
	self:EmitSound(self.Primary.Sound, 80, 75)
	self:EmitSound("weapons/ar2/npc_ar2_altfire.wav", 55, 150,1,CHAN_VOICE)
end
