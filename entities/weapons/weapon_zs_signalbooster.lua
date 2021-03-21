AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_signalbooster_name"
	SWEP.TranslateDesc = "weapon_signalbooster_desc"

	SWEP.ViewModelFOV = 80

	SWEP.Slot = 4

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

	SWEP.VElements = {
		["element_name++"] = { type = "Model", model = "models/props_rooftop/antenna03a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(0, 0, 4.593), angle = Angle(-0, -34.119, 0), size = Vector(0.056, 0.056, 0.056), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["element_name+"] = { type = "Model", model = "models/props_lab/harddrive02.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(-0.424, 0, 0), angle = Angle(0, 180, 0), size = Vector(0.079, 0.324, 0.28), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["element_name"] = { type = "Model", model = "models/props_lab/keypad.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.704, 2.176, -1.538), angle = Angle(-0.361, -154.907, 180), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["element_name"] = { type = "Model", model = "models/props_lab/keypad.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.654, 2.711, -1.68), angle = Angle(-17.813, 147.498, 180), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["element_name+"] = { type = "Model", model = "models/props_lab/harddrive02.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(-0.424, 0, 0), angle = Angle(0, 180, 0), size = Vector(0.079, 0.324, 0.28), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["element_name++"] = { type = "Model", model = "models/props_rooftop/antenna03a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(0, 0, 4.593), angle = Angle(-0, -34.119, 0), size = Vector(0.056, 0.056, 0.056), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_slam.mdl"
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.WalkSpeed = SPEED_NORMAL

SWEP.HoldType = "slam"
SWEP.DoubleCapSpeed = true
SWEP.AdditionalSigilInfo = true

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end