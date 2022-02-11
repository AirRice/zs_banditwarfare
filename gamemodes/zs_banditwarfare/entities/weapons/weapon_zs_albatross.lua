AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_albatross_name"
	SWEP.TranslateDesc = "weapon_albatross_desc"
	SWEP.Slot = 3
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 55
	SWEP.HUD3DBone = "v_weapon.AK47_Parent"
	SWEP.HUD3DPos = Vector(-1.6, -4.5, -0.3)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.025
	
	SWEP.VElements = {
		["Sideshell+++"] = { type = "Model", model = "models/weapons/shotgun_shell.mdl", bone = "v_weapon.AK47_Parent", rel = "Body", pos = Vector(-3.067, -1.435, 1.69), angle = Angle(-90, 0, 0), size = Vector(0.462, 0.462, 0.462), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Sideshell"] = { type = "Model", model = "models/weapons/shotgun_shell.mdl", bone = "v_weapon.AK47_Parent", rel = "Body", pos = Vector(-3.951, -1.435, 1.69), angle = Angle(-90, 0, 0), size = Vector(0.462, 0.462, 0.462), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Body+"] = { type = "Model", model = "models/props_vents/vent_large_corner001.mdl", bone = "v_weapon.AK47_Parent", rel = "Grip", pos = Vector(-0.755, 0, 6.243), angle = Angle(0, 0, -90), size = Vector(0.082, 0.043, 0.082), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["Mag+"] = { type = "Model", model = "models/props_pipes/pipe01_connector01.mdl", bone = "v_weapon.AK47_Clip", rel = "Mag", pos = Vector(0, 0, 2.448), angle = Angle(-90, 0, 0), size = Vector(1.003, 1.003, 1.003), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 5, bodygroup = {} },
		["Bolt+"] = { type = "Model", model = "models/mechanics/robotics/j1.mdl", bone = "v_weapon.AK47_Bolt", rel = "", pos = Vector(-1.915, 0.083, -2.955), angle = Angle(-180, 0, 180), size = Vector(0.043, 0.043, 0.043), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },
		["Body++"] = { type = "Model", model = "models/props_trainstation/pole_448connection002b.mdl", bone = "v_weapon.AK47_Parent", rel = "Grip", pos = Vector(12.225, 0, 7.5), angle = Angle(-90, 90, -90), size = Vector(0.064, 0.05, 0.045), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["Body"] = { type = "Model", model = "models/props_combine/combinetrain01a.mdl", bone = "v_weapon.AK47_Parent", rel = "Grip", pos = Vector(6.126, 0, 4.811), angle = Angle(0, 0, 0), size = Vector(0.017, 0.019, 0.01), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["Sideshell++"] = { type = "Model", model = "models/weapons/shotgun_shell.mdl", bone = "v_weapon.AK47_Parent", rel = "Body", pos = Vector(-4.83, -1.435, 1.69), angle = Angle(-90, 0, 0), size = Vector(0.462, 0.462, 0.462), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Body++++"] = { type = "Model", model = "models/hunter/tubes/tube1x1x3c.mdl", bone = "v_weapon.AK47_Parent", rel = "Grip", pos = Vector(10.182, 0, 7.048), angle = Angle(90, -90, -90), size = Vector(0.096, 0.054, 0.086), color = Color(150, 133, 132, 255), surpresslightning = false, material = "phoenix_storms/fender_wood", skin = 0, bodygroup = {} },
		["Grip"] = { type = "Model", model = "models/weapons/w_pist_usp.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(0, 1.797, 0.885), angle = Angle(-90, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Mag"] = { type = "Model", model = "models/props_phx/oildrum001.mdl", bone = "v_weapon.AK47_Clip", rel = "", pos = Vector(0, 1.947, -2.077), angle = Angle(0, 0, 17.843), size = Vector(0.261, 0.261, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 5, bodygroup = {} },
		["Body+++"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "v_weapon.AK47_Parent", rel = "Grip", pos = Vector(16.076, 0, 5.751), angle = Angle(0, -90, -90), size = Vector(0.18, 0.18, 0.201), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },
		["Body+++++"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "v_weapon.AK47_Parent", rel = "Grip", pos = Vector(16.076, 0, 7.209), angle = Angle(0, -90, -90), size = Vector(0.201, 0.201, 0.201), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },
		["nozzle"] = { type = "Model", model = "models/props_wasteland/laundry_basket001.mdl", bone = "v_weapon.AK47_Parent", rel = "Body+++++", pos = Vector(0, 0, 7.788), angle = Angle(0, 0, 0), size = Vector(0.035, 0.035, 0.074), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Sideshell+"] = { type = "Model", model = "models/weapons/shotgun_shell.mdl", bone = "v_weapon.AK47_Parent", rel = "Body", pos = Vector(-2.178, -1.435, 1.69), angle = Angle(-90, 0, 0), size = Vector(0.462, 0.462, 0.462), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Bolt"] = { type = "Model", model = "models/props_combine/combine_light002a.mdl", bone = "v_weapon.AK47_Bolt", rel = "", pos = Vector(-1.153, 0, 0.948), angle = Angle(0, 0, 180), size = Vector(0.034, 0.085, 0.105), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/canister_propane01a", skin = 0, bodygroup = {} }
	}


	SWEP.WElements = {
		["Sideshell+++"] = { type = "Model", model = "models/weapons/shotgun_shell.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Body", pos = Vector(-3.067, -1.435, 1.69), angle = Angle(-90, 0, 0), size = Vector(0.462, 0.462, 0.462), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Sideshell"] = { type = "Model", model = "models/weapons/shotgun_shell.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Body", pos = Vector(-3.951, -1.435, 1.69), angle = Angle(-90, 0, 0), size = Vector(0.462, 0.462, 0.462), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Body+"] = { type = "Model", model = "models/props_vents/vent_large_corner001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Grip", pos = Vector(-0.755, 0, 6.243), angle = Angle(0, 0, -90), size = Vector(0.082, 0.043, 0.082), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["Bolt"] = { type = "Model", model = "models/props_combine/combine_light002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Body", pos = Vector(-1.588, -1.262, 1.769), angle = Angle(0, -90, -90), size = Vector(0.034, 0.085, 0.105), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/canister_propane01a", skin = 0, bodygroup = {} },
		["Body++"] = { type = "Model", model = "models/props_trainstation/pole_448connection002b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Grip", pos = Vector(12.225, 0, 7.5), angle = Angle(-90, 90, -90), size = Vector(0.064, 0.05, 0.045), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["Body"] = { type = "Model", model = "models/props_combine/combinetrain01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Grip", pos = Vector(6.126, 0, 4.811), angle = Angle(0, 0, 0), size = Vector(0.017, 0.019, 0.01), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["Body++++"] = { type = "Model", model = "models/hunter/tubes/tube1x1x3c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Grip", pos = Vector(10.182, 0, 7.048), angle = Angle(90, -90, -90), size = Vector(0.096, 0.054, 0.086), color = Color(150, 133, 132, 255), surpresslightning = false, material = "phoenix_storms/fender_wood", skin = 0, bodygroup = {} },
		["Mag+"] = { type = "Model", model = "models/props_pipes/pipe01_connector01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Mag", pos = Vector(0, 0, 2.448), angle = Angle(-90, 0, 0), size = Vector(1.003, 1.003, 1.003), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 5, bodygroup = {} },
		["nozzle"] = { type = "Model", model = "models/props_wasteland/laundry_basket001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Body+++++", pos = Vector(0, 0, 7.788), angle = Angle(0, 0, 0), size = Vector(0.035, 0.035, 0.074), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Mag"] = { type = "Model", model = "models/props_phx/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Body", pos = Vector(3.72, 0, -2.541), angle = Angle(90, 0, 0), size = Vector(0.261, 0.261, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 5, bodygroup = {} },
		["Body+++++"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Grip", pos = Vector(16.076, 0, 7.209), angle = Angle(0, -90, -90), size = Vector(0.201, 0.201, 0.201), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },
		["Body+++"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Grip", pos = Vector(16.076, 0, 5.751), angle = Angle(0, -90, -90), size = Vector(0.18, 0.18, 0.201), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },
		["Grip"] = { type = "Model", model = "models/weapons/w_pist_usp.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.242, 1.373, 2.632), angle = Angle(-5.917, 3.848, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Sideshell+"] = { type = "Model", model = "models/weapons/shotgun_shell.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Body", pos = Vector(-2.178, -1.435, 1.69), angle = Angle(-90, 0, 0), size = Vector(0.462, 0.462, 0.462), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Sideshell++"] = { type = "Model", model = "models/weapons/shotgun_shell.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Body", pos = Vector(-4.83, -1.435, 1.69), angle = Angle(-90, 0, 0), size = Vector(0.462, 0.462, 0.462), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "shotgun"

SWEP.ViewModel = "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"
SWEP.UseHands = true
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.Primary.Sound = Sound("Weapon_XM1014.Single")
SWEP.Primary.Damage = 6
SWEP.Primary.NumShots = 8
SWEP.Primary.Delay = 0.35
SWEP.SelfKnockBackForce = 100
SWEP.Primary.ClipSize = 12
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "buckshot"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ReloadSpeed = 0.85

SWEP.ConeMax = 0.081
SWEP.ConeMin = 0.064
SWEP.MovingConeOffset = 0.05
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
SWEP.AimExpandStayDuration = 0.002
SWEP.Recoil = 2.89
SWEP.WalkSpeed = SPEED_SLOWER

SWEP.nextreloadfinish = 0

function SWEP:EmitFireSound()
	self:EmitSound(self.Primary.Sound)
	self:EmitSound("weapons/shotgun/shotgun_fire"..math.random(6,7)..".wav", 80, 105, 0.75, CHAN_WEAPON + 20)
end

function SWEP:SecondaryAttack()
end
