AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_fusilier_name"
	SWEP.TranslateDesc = "weapon_fusilier_desc"
	SWEP.Slot = 3
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "v_weapon.galil"
	SWEP.HUD3DPos = Vector(1.7, 0, 2)
	SWEP.HUD3DScale = 0.015
	SWEP.VElements = {
		["body+++++"] = { type = "Model", model = "models/props_vents/vent_large_corner001.mdl", bone = "v_weapon.galil", rel = "body", pos = Vector(-4.657, 0, -13.829), angle = Angle(164.804, 180, 90), size = Vector(0.076, 0.112, 0.098), color = Color(130, 97, 122, 255), surpresslightning = false, material = "phoenix_storms/fender_wood", skin = 0, bodygroup = {} },
		["barrel+++++++"] = { type = "Model", model = "models/props_wasteland/laundry_basket002.mdl", bone = "v_weapon.galil", rel = "body", pos = Vector(0.34, 0, 27.24), angle = Angle(0, 0, 0), size = Vector(0.02, 0.02, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel+"] = { type = "Model", model = "models/props_combine/combine_light002a.mdl", bone = "v_weapon.galil", rel = "body", pos = Vector(1.141, 0, -3.21), angle = Angle(0, 0, -180), size = Vector(0.122, 0.217, 0.152), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["barrel+++"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "v_weapon.galil", rel = "body", pos = Vector(-0.803, 0, 13.152), angle = Angle(0, 0, 0), size = Vector(0.043, 0.024, 0.238), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_trainstation/trainstation_ornament001", skin = 0, bodygroup = {} },
		["trigger"] = { type = "Model", model = "models/hunter/tubes/tube1x1x1d.mdl", bone = "v_weapon.trigger", rel = "", pos = Vector(0.218, 0.079, 0.612), angle = Angle(90, 0, 0), size = Vector(0.037, 0.037, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_vents/borealis_vent001b", skin = 0, bodygroup = {} },
		["body"] = { type = "Model", model = "models/hunter/tubes/tube1x1x8c.mdl", bone = "v_weapon.galil", rel = "", pos = Vector(0, -0.534, 7.867), angle = Angle(-0.378, 90, 0), size = Vector(0.122, 0.046, 0.035), color = Color(130, 97, 122, 255), surpresslightning = false, material = "phoenix_storms/fender_wood", skin = 0, bodygroup = {} },
		["mag+"] = { type = "Model", model = "models/hunter/blocks/cube025x025x025.mdl", bone = "v_weapon.magazine", rel = "", pos = Vector(0, 3.569, 1.633), angle = Angle(0, 180, 10), size = Vector(0.112, 0.741, 0.181), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["barrel++++++"] = { type = "Model", model = "models/props_combine/combinebutton.mdl", bone = "v_weapon.galil", rel = "body", pos = Vector(-0.142, 0, 16.353), angle = Angle(-90, -90, 180), size = Vector(0.072, 0.208, 0.158), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["barrel+++++"] = { type = "Model", model = "models/props_c17/canister01a.mdl", bone = "v_weapon.galil", rel = "body", pos = Vector(-1.517, 0, 15.781), angle = Angle(0, 0, 0), size = Vector(0.119, 0.119, 0.086), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["barrel++++"] = { type = "Model", model = "models/props_c17/signpole001.mdl", bone = "v_weapon.galil", rel = "body", pos = Vector(0.314, 0, 12.92), angle = Angle(0, 0, 0), size = Vector(0.463, 0.463, 0.145), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["body++++++"] = { type = "Model", model = "models/props_borealis/bluebarrel001.mdl", bone = "v_weapon.galil", rel = "body", pos = Vector(-0.942, 0, -1.798), angle = Angle(0, 0, -180), size = Vector(0.114, 0.07, 0.34), color = Color(130, 97, 122, 255), surpresslightning = false, material = "phoenix_storms/fender_wood", skin = 0, bodygroup = {} },
		["body++++"] = { type = "Model", model = "models/props_vents/vent_large_corner001.mdl", bone = "v_weapon.galil", rel = "body", pos = Vector(-1.428, 0, -11.752), angle = Angle(100.111, 0, 90), size = Vector(0.116, 0.086, 0.093), color = Color(130, 97, 122, 255), surpresslightning = false, material = "phoenix_storms/fender_wood", skin = 0, bodygroup = {} },
		["body++"] = { type = "Model", model = "models/hunter/triangles/trapezium3x3x1c.mdl", bone = "v_weapon.galil", rel = "body", pos = Vector(-4.657, 0, -16.371), angle = Angle(180, 180, 180), size = Vector(0.061, 0.039, 0.221), color = Color(248, 165, 122, 255), surpresslightning = false, material = "models/props_rooftop/rooftopcluster01a", skin = 0, bodygroup = {} },
		["barrel"] = { type = "Model", model = "models/props_docks/dock01_pole01a_128.mdl", bone = "v_weapon.galil", rel = "body", pos = Vector(0, 0, 3.954), angle = Angle(0, 0, 0), size = Vector(0.145, 0.141, 0.145), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_junk/i-beam01", skin = 0, bodygroup = {} },
		["bolt"] = { type = "Model", model = "models/props_c17/canister_propane01a.mdl", bone = "v_weapon.bolt", rel = "", pos = Vector(-1.035, 0.252, -0.088), angle = Angle(-90, 0, 0), size = Vector(0.021, 0.021, 0.032), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_vents/borealis_vent001", skin = 0, bodygroup = {} },
		["body+++"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025b.mdl", bone = "v_weapon.galil", rel = "body", pos = Vector(-2.712, 0, -6.336), angle = Angle(-96.999, 0, 90), size = Vector(0.03, 0.03, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_vents/borealis_vent001c", skin = 0, bodygroup = {} },
		["mag"] = { type = "Model", model = "models/hunter/blocks/cube025x025x025.mdl", bone = "v_weapon.magazine", rel = "", pos = Vector(0, 3.716, 0.827), angle = Angle(0, 0, -10), size = Vector(0.046, 0.755, 0.326), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["barrel++"] = { type = "Model", model = "models/props_combine/headcrabcannister01a.mdl", bone = "v_weapon.bolt", rel = "", pos = Vector(-0.514, 0.929, -1.469), angle = Angle(90, -180, 0), size = Vector(0.086, 0.05, 0.057), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["mag++"] = { type = "Model", model = "models/hunter/blocks/cube025x025x025.mdl", bone = "v_weapon.magazine", rel = "", pos = Vector(0, 4, -0.5), angle = Angle(0, 0, -10), size = Vector(0.112, 0.732, 0.112), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["body+++++"] = { type = "Model", model = "models/props_vents/vent_large_corner001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(-4.657, 0, -13.829), angle = Angle(164.804, 180, 90), size = Vector(0.076, 0.112, 0.098), color = Color(130, 97, 122, 255), surpresslightning = false, material = "phoenix_storms/fender_wood", skin = 0, bodygroup = {} },
		["barrel+++++++"] = { type = "Model", model = "models/props_wasteland/laundry_basket002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(0.34, 0, 27.24), angle = Angle(0, 0, 0), size = Vector(0.02, 0.02, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel+"] = { type = "Model", model = "models/props_combine/combine_light002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(1.141, 0, -3.21), angle = Angle(0, 0, -180), size = Vector(0.122, 0.217, 0.152), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["body+++"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(-2.712, 0, -6.336), angle = Angle(-96.999, 0, 90), size = Vector(0.03, 0.03, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_vents/borealis_vent001c", skin = 0, bodygroup = {} },
		["mag"] = { type = "Model", model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(-4.644, 0, -2.264), angle = Angle(0, -90, 0), size = Vector(0.112, 0.638, 0.211), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["body"] = { type = "Model", model = "models/hunter/tubes/tube1x1x8c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12.965, 1.639, -5.276), angle = Angle(-95.971, -0.567, -1.372), size = Vector(0.122, 0.046, 0.035), color = Color(130, 97, 122, 255), surpresslightning = false, material = "phoenix_storms/fender_wood", skin = 0, bodygroup = {} },
		["barrel++++++"] = { type = "Model", model = "models/props_combine/combinebutton.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(-0.142, 0, 16.353), angle = Angle(-90, -90, 180), size = Vector(0.072, 0.208, 0.158), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["barrel+++"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(-0.803, 0, 13.152), angle = Angle(0, 0, 0), size = Vector(0.043, 0.024, 0.238), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_trainstation/trainstation_ornament001", skin = 0, bodygroup = {} },
		["body++++++"] = { type = "Model", model = "models/props_borealis/bluebarrel001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(-0.942, 0, -1.798), angle = Angle(0, 0, -180), size = Vector(0.114, 0.07, 0.34), color = Color(130, 97, 122, 255), surpresslightning = false, material = "phoenix_storms/fender_wood", skin = 0, bodygroup = {} },
		["body++++"] = { type = "Model", model = "models/props_vents/vent_large_corner001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(-1.428, 0, -11.752), angle = Angle(100.111, 0, 90), size = Vector(0.116, 0.086, 0.093), color = Color(130, 97, 122, 255), surpresslightning = false, material = "phoenix_storms/fender_wood", skin = 0, bodygroup = {} },
		["barrel++"] = { type = "Model", model = "models/props_combine/headcrabcannister01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(0.361, 0, -0.461), angle = Angle(86.487, 0, 0), size = Vector(0.086, 0.05, 0.057), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["barrel"] = { type = "Model", model = "models/props_docks/dock01_pole01a_128.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(0, 0, 3.954), angle = Angle(0, 0, 0), size = Vector(0.145, 0.141, 0.145), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_junk/i-beam01", skin = 0, bodygroup = {} },
		["barrel+++++"] = { type = "Model", model = "models/props_c17/canister01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(-1.517, 0, 15.781), angle = Angle(0, 0, 0), size = Vector(0.119, 0.119, 0.086), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["body++"] = { type = "Model", model = "models/hunter/triangles/trapezium3x3x1c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(-4.657, 0, -16.371), angle = Angle(180, 180, 180), size = Vector(0.061, 0.039, 0.221), color = Color(248, 165, 122, 255), surpresslightning = false, material = "models/props_rooftop/rooftopcluster01a", skin = 0, bodygroup = {} },
		["barrel++++"] = { type = "Model", model = "models/props_c17/signpole001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "body", pos = Vector(0.314, 0, 12.92), angle = Angle(0, 0, 0), size = Vector(0.463, 0.463, 0.145), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} }
	}
end


SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/cstrike/c_rif_galil.mdl"
SWEP.WorldModel = "models/weapons/w_rif_galil.mdl"
SWEP.UseHands = true

SWEP.ReloadSound = Sound("Weapon_AWP.ClipOut")
SWEP.Primary.Damage = 35
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.3
SWEP.ReloadDelay = SWEP.Primary.Delay
SWEP.ReloadSpeed = 0.8
SWEP.Primary.ClipSize = 7
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "357"
SWEP.Primary.DefaultClip = 21
SWEP.Primary.KnockbackScale = 0.1

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN

SWEP.ConeMax = 0.008
SWEP.ConeMin = 0.002
SWEP.Recoil = 1.33
SWEP.DefaultRecoil = 2.23
SWEP.MovingConeOffset = 0.14
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)

SWEP.IronSightsPos = Vector(-6.441, 0, 1.799)
SWEP.IronSightsAng = Vector(0, 0, 0)


SWEP.WalkSpeed = SPEED_SLOWEST

SWEP.TracerName = "Tracer"

function SWEP:EmitFireSound()
	self:EmitSound("weapons/ak47/ak47-1.wav", 75, 76, 0.53)
	self:EmitSound("weapons/scout/scout_fire-1.wav", 75, 86, 0.67, CHAN_AUTO+20)
end
