AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_rupture_name"
	SWEP.TranslateDesc = "weapon_rupture_desc"
	SWEP.Slot = 3
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 70
	SWEP.HUD3DBone = "v_weapon.famas"
	SWEP.HUD3DPos = Vector(1.75, -4, 5)
	SWEP.HUD3DScale = 0.026
	SWEP.VElements = {
		["sidebattery++++"] = { type = "Model", model = "models/items/car_battery01.mdl", bone = "v_weapon.famas", rel = "base", pos = Vector(-0.755, 1.029, -1.609), angle = Angle(-90, 180, 0), size = Vector(0.218, 0.218, 0.218), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["pullhandle"] = { type = "Model", model = "models/props_combine/combine_emitter01.mdl", bone = "v_weapon.bolt", rel = "", pos = Vector(0, 0.407, -0.244), angle = Angle(24.01, 90, -180), size = Vector(0.083, 0.083, 0.083), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery++"] = { type = "Model", model = "models/props_lab/powerbox02b.mdl", bone = "v_weapon.famas", rel = "base", pos = Vector(1.325, -6.424, -1.798), angle = Angle(0, 0, 0), size = Vector(0.086, 0.086, 0.086), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["limb"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025c.mdl", bone = "v_weapon.famas", rel = "base", pos = Vector(-0.962, -5.25, -1.364), angle = Angle(0, 90, 0), size = Vector(0.293, 0.293, 0.097), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_wasteland/wood_fence01a", skin = 0, bodygroup = {} },
		["base++"] = { type = "Model", model = "models/props_combine/combinethumper002.mdl", bone = "v_weapon.famas", rel = "base", pos = Vector(0, 9.163, -4.272), angle = Angle(-180, 180, 93.026), size = Vector(0.029, 0.035, 0.035), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["grip"] = { type = "Model", model = "models/weapons/w_pist_fiveseven.mdl", bone = "v_weapon.famas", rel = "base", pos = Vector(0.079, -2.741, -7.948), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "v_weapon.famas", rel = "base", pos = Vector(0, -2.258, -2.037), angle = Angle(-180, 0, 0), size = Vector(0.02, 0.046, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery+"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "v_weapon.famas", rel = "base", pos = Vector(-0.959, -10.294, -1.349), angle = Angle(0, -10.186, 90), size = Vector(0.142, 0.224, 0.187), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["battery"] = { type = "Model", model = "models/items/battery.mdl", bone = "v_weapon.magazine", rel = "", pos = Vector(0, -4, -0.569), angle = Angle(-90, -90, 0), size = Vector(0.316, 0.216, 0.545), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["back++"] = { type = "Model", model = "models/props_combine/breenpod_inner.mdl", bone = "v_weapon.famas", rel = "base", pos = Vector(0, -13.459, -6.896), angle = Angle(-14.422, -90, 0), size = Vector(0.372, 0.093, 0.12), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["back+"] = { type = "Model", model = "models/props_combine/combine_emitter01.mdl", bone = "v_weapon.famas", rel = "base", pos = Vector(0, 7.48, -2.248), angle = Angle(0, -90, 0), size = Vector(0.224, 1.131, 0.224), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery+++"] = { type = "Model", model = "models/items/car_battery01.mdl", bone = "v_weapon.famas", rel = "base", pos = Vector(0.684, 1.029, -1.609), angle = Angle(-90, 0, 0), size = Vector(0.218, 0.218, 0.218), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base"] = { type = "Model", model = "models/props_combine/combine_train02b.mdl", bone = "v_weapon.famas", rel = "", pos = Vector(0, -2.314, 14.84), angle = Angle(0, 0, -90), size = Vector(0.021, 0.035, 0.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "v_weapon.famas", rel = "base", pos = Vector(0.688, -8.968, -1.333), angle = Angle(0, -166.051, -90), size = Vector(0.142, 0.224, 0.187), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["battery+"] = { type = "Model", model = "models/items/combine_rifle_cartridge01.mdl", bone = "v_weapon.magazine", rel = "", pos = Vector(0, -4.5, 1.401), angle = Angle(-59.612, 90, 0), size = Vector(0.467, 0.467, 0.467), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["back"] = { type = "Model", model = "models/props_combine/breenconsole.mdl", bone = "v_weapon.famas", rel = "base", pos = Vector(0, -4.919, 1.039), angle = Angle(180, 180, 90), size = Vector(0.071, 0.138, 0.164), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery+++1"] = { type = "Model", model = "models/props_c17/utilityconnecter006c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-4.371, 3.299, -1.851), angle = Angle(-90.199, -154, 0), size = Vector(0.135, 0.135, 0.14), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery++++++"] = { type = "Model", model = "models/props_c17/utilityconnecter006c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(3.884, 3.299, -1.851), angle = Angle(-90.199, -26.178, 0), size = Vector(0.135, 0.135, 0.14), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	}

	SWEP.WElements = {
		["limb"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-0.962, -5.25, -1.364), angle = Angle(0, 90, 0), size = Vector(0.293, 0.293, 0.097), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_wasteland/wood_fence01a", skin = 0, bodygroup = {} },
		["sidebattery"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0.688, -8.968, -1.333), angle = Angle(0, -166.051, -90), size = Vector(0.142, 0.224, 0.187), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery+++++"] = { type = "Model", model = "models/items/car_battery01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0.684, 1.029, -1.609), angle = Angle(-90, 0, 0), size = Vector(0.218, 0.218, 0.218), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["back"] = { type = "Model", model = "models/props_combine/breenconsole.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, -4.919, 1.039), angle = Angle(180, 180, 90), size = Vector(0.071, 0.138, 0.164), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery++++"] = { type = "Model", model = "models/items/car_battery01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-0.755, 1.029, -1.609), angle = Angle(-90, 180, 0), size = Vector(0.218, 0.218, 0.218), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base"] = { type = "Model", model = "models/props_combine/combine_train02b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.381, 1.725, -5.763), angle = Angle(0, -94.45, 180), size = Vector(0.021, 0.035, 0.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery++++++"] = { type = "Model", model = "models/props_c17/utilityconnecter006c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(3.884, 3.299, -1.851), angle = Angle(-90.199, -26.178, 0), size = Vector(0.135, 0.135, 0.14), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base++"] = { type = "Model", model = "models/props_combine/combinethumper002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 9.163, -4.272), angle = Angle(-180, 180, 93.026), size = Vector(0.029, 0.035, 0.035), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, -2.258, -2.037), angle = Angle(-180, 0, 0), size = Vector(0.02, 0.046, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery+++1"] = { type = "Model", model = "models/props_c17/utilityconnecter006c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-4.371, 3.299, -1.851), angle = Angle(-90.199, -154, 0), size = Vector(0.135, 0.135, 0.14), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["back++"] = { type = "Model", model = "models/props_combine/breenpod_inner.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, -13.459, -6.896), angle = Angle(-14.422, -90, 0), size = Vector(0.372, 0.093, 0.12), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["back+"] = { type = "Model", model = "models/props_combine/combine_emitter01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 7.48, -2.248), angle = Angle(0, -90, 0), size = Vector(0.224, 1.131, 0.224), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery+"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-0.959, -10.294, -1.349), angle = Angle(0, -10.186, 90), size = Vector(0.142, 0.224, 0.187), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery++"] = { type = "Model", model = "models/props_lab/powerbox02b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(1.325, -6.424, -1.798), angle = Angle(0, 0, 0), size = Vector(0.086, 0.086, 0.086), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery+++"] = { type = "Model", model = "models/items/car_battery01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0.684, 1.029, -1.609), angle = Angle(-90, 0, 0), size = Vector(0.218, 0.218, 0.218), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/cstrike/c_rif_famas.mdl"
SWEP.WorldModel = "models/weapons/w_rif_famas.mdl"
SWEP.UseHands = true
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.Primary.Sound = Sound("Weapon_Crossbow.Single")
SWEP.Primary.Damage = 40
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.26

SWEP.Primary.ClipSize = 5
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "XBowBolt"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_AR2

SWEP.ConeMax = 0.015
SWEP.ConeMin = 0.003
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
SWEP.Recoil = 0.768
SWEP.WalkSpeed = SPEED_FAST

SWEP.IronSightsPos = Vector(-6.15, 4, -1.5)
SWEP.IronSightsAng = Vector(4, 0, 0)

function SWEP:EmitFireSound()
	self:EmitSound(self.Primary.Sound)
	self:EmitSound("npc/assassin/ball_zap1.wav", 75, 110,50,CHAN_WEAPON+20) --weapons/mortar/mortar_fire1.wav
	
end

function SWEP:ShootBullets(dmg, cone, numbul)
	self:SetConeAndFire()
	self:DoRecoil()

	local owner = self.Owner
	--owner:MuzzleFlash()
	self:SendWeaponAnimation()
	owner:DoAttackEvent()

	local aimvec = owner:GetAimVector()
	if SERVER then
		local ent = ents.Create("projectile_flechettearrow")
		if ent:IsValid() then
			ent:SetPos(owner:GetShootPos())
			ent:SetAngles(aimvec:Angle())
			ent:SetOwner(owner)
			ent:Spawn()
			ent.Damage = self.Primary.Damage
			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then
				phys:Wake()
				phys:SetVelocity(aimvec *1900)
			end
		end
    end
end