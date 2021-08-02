AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_tommysmg_name"
	SWEP.TranslateDesc = "weapon_tommysmg_desc"
	SWEP.Slot = 2
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "v_weapon.galil"
	SWEP.HUD3DPos = Vector(3,0, 6)
	SWEP.HUD3DScale = 0.025
	SWEP.VElements = {
		["drumclip"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "v_weapon.magazine", rel = "", pos = Vector(0, 5.149, 2.482), angle = Angle(180, 0, 0), size = Vector(0.363, 0.363, 0.092), color = Color(150, 150, 150, 255), surpresslightning = false, material = "", skin = 6, bodygroup = {} },
		["barrel"] = { type = "Model", model = "models/props_c17/furnituredrawer003a.mdl", bone = "v_weapon.galil", rel = "base", pos = Vector(0, 13.524, -1.005), angle = Angle(90, -90, 0), size = Vector(0.211, 0.211, 0.342), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "v_weapon.galil", rel = "", pos = Vector(0, 0, 3.845), angle = Angle(0, 0, -90), size = Vector(0.028, 0.028, 0.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel+"] = { type = "Model", model = "models/props_c17/utilityconnecter006d.mdl", bone = "v_weapon.galil", rel = "base", pos = Vector(0.143, 15.074, 0.689), angle = Angle(0, 0, 90), size = Vector(0.231, 0.231, 0.432), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel++"] = { type = "Model", model = "models/props_c17/canister01a.mdl", bone = "v_weapon.galil", rel = "base", pos = Vector(0.143, 16.968, 0.625), angle = Angle(0, 180, 90), size = Vector(0.158, 0.158, 0.677), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Backside"] = { type = "Model", model = "models/props_phx/construct/metal_plate1_tri.mdl", bone = "v_weapon.galil", rel = "base", pos = Vector(-0.401, -9.556, -1.591), angle = Angle(90, -180, 0), size = Vector(0.082, 0.289, 0.244), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/bench01a", skin = 0, bodygroup = {} }
	}	
	SWEP.WElements = {
		["drumclip"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.614, 0, 0.908), angle = Angle(-107.953, 0, 0), size = Vector(0.363, 0.363, 0.092), color = Color(150, 150, 150, 255), surpresslightning = false, material = "", skin = 6, bodygroup = {} },
		["barrel"] = { type = "Model", model = "models/props_c17/furnituredrawer003a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 10.666, -1.005), angle = Angle(90, -90, 0), size = Vector(0.211, 0.211, 0.175), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10, 0.795, -4.562), angle = Angle(-180, 90, -9.171), size = Vector(0.028, 0.028, 0.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel+"] = { type = "Model", model = "models/props_c17/utilityconnecter006d.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0.143, 12.168, 0.739), angle = Angle(0, 0, 90), size = Vector(0.296, 0.296, 0.296), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel++"] = { type = "Model", model = "models/props_c17/canister01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0.143, 12.692, 0.625), angle = Angle(0, 180, 90), size = Vector(0.158, 0.158, 0.326), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Backside"] = { type = "Model", model = "models/props_phx/construct/metal_plate1_tri.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-0.723, -9.476, -1.591), angle = Angle(90, -180, 0), size = Vector(0.082, 0.485, 0.432), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/bench01a", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "shotgun"

SWEP.ViewModel = "models/weapons/cstrike/c_rif_galil.mdl"
SWEP.WorldModel = "models/weapons/w_rif_galil.mdl"
SWEP.UseHands = true
SWEP.ShowViewModel = false

SWEP.Primary.Sound = Sound("Weapon_M249.Single")
SWEP.Primary.Damage = 11
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.047

SWEP.Primary.ClipSize = 75
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
GAMEMODE:SetupDefaultClip(SWEP.Primary)
	
SWEP.ConeMax = 0.065
SWEP.ConeMin = 0.007
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)

SWEP.Recoil = 0.38

SWEP.WalkSpeed = SPEED_SLOWER
function SWEP:EmitFireSound()
	self:EmitSound(self.Primary.Sound)
	self:EmitSound("weapons/ak47/ak47-1.wav", 55, 110,1,CHAN_VOICE)
end