AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_rupture_name"
	SWEP.TranslateDesc = "weapon_rupture_desc"
	SWEP.Slot = 3
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "v_weapon.ump45_Release"
	SWEP.HUD3DPos = Vector(-2, -5, 6)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.025
	SWEP.VElements = {
		["crossbow_rope+++"] = { type = "Model", model = "models/props_phx/trains/monorail1.mdl", bone = "v_weapon.ump45_Parent", rel = "crossbow_limb", pos = Vector(0.648, 0, -1.341), angle = Angle(0, 90, 0), size = Vector(0.05, 0.014, 0.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },
		["crossbow_limb+"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025c.mdl", bone = "v_weapon.ump45_Parent", rel = "crossbow_limb", pos = Vector(0, 0, -1.68), angle = Angle(0, 0, 0), size = Vector(0.209, 0.264, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
		["crossbow_rope++"] = { type = "Model", model = "models/props_phx/trains/monorail1.mdl", bone = "v_weapon.ump45_Parent", rel = "crossbow_limb", pos = Vector(-1.481, 0, -1.022), angle = Angle(0, 90, 0), size = Vector(0.05, 0.014, 0.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },
		["crossbow_limb"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025c.mdl", bone = "v_weapon.ump45_Parent", rel = "", pos = Vector(0.384, -5.639, -0.456), angle = Angle(90, 0, 90), size = Vector(0.209, 0.264, 0.048), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
		["crossbow_base"] = { type = "Model", model = "models/props_combine/combine_emitter01.mdl", bone = "v_weapon.ump45_Parent", rel = "crossbow_limb", pos = Vector(3.378, 0, 3.019), angle = Angle(180, 180, 0), size = Vector(0.402, 0.479, 0.402), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["crossbow_wheel+"] = { type = "Model", model = "models/props_wasteland/wheel01a.mdl", bone = "v_weapon.ump45_Parent", rel = "crossbow_limb", pos = Vector(-0.299, 12, -0.617), angle = Angle(0, 0, 90), size = Vector(0.037, 0.104, 0.037), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder003", skin = 0, bodygroup = {} },
		["crossbow_rope+"] = { type = "Model", model = "models/props_phx/trains/monorail1.mdl", bone = "v_weapon.ump45_Parent", rel = "crossbow_limb", pos = Vector(4.3, -5.89, -1.101), angle = Angle(0, -55, 0), size = Vector(0.029, 0.014, 0.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },
		["crossbow_wheel"] = { type = "Model", model = "models/props_wasteland/wheel01a.mdl", bone = "v_weapon.ump45_Parent", rel = "crossbow_limb", pos = Vector(-0.299, -12, -0.617), angle = Angle(0, 0, 90), size = Vector(0.037, 0.104, 0.037), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder003", skin = 0, bodygroup = {} },
		["crossbow_rope"] = { type = "Model", model = "models/props_phx/trains/monorail1.mdl", bone = "v_weapon.ump45_Parent", rel = "crossbow_limb", pos = Vector(4.3, 5.889, -1.101), angle = Angle(0, 55, 0), size = Vector(0.029, 0.014, 0.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },
		["crossbow_base+"] = { type = "Model", model = "models/props_combine/eli_pod_inner.mdl", bone = "v_weapon.ump45_Parent", rel = "crossbow_limb", pos = Vector(4, 0, 1.756), angle = Angle(90, 0, 0), size = Vector(0.347, 0.136, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["bolt"] = { type = "Model", model = "models/props_combine/combine_dispenser.mdl", bone = "v_weapon.ump45_Bolt", rel = "", pos = Vector(-1.589, 0.893, 6.499), angle = Angle(0, -180, 180), size = Vector(0.05, 0.09, 0.141), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["ejectport"] = { type = "Model", model = "models/props_lab/hev_case.mdl", bone = "v_weapon.ump45_Eject", rel = "", pos = Vector(-1.816, -0.322, -3.178), angle = Angle(-180, 0, 180), size = Vector(0.045, 0.045, 0.045), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["eject_1"] = { type = "Model", model = "models/items/battery.mdl", bone = "v_weapon.ump45_Eject", rel = "", pos = Vector(0, -1.849, -1.403), angle = Angle(0, 90, 0), size = Vector(0.388, 0.388, 0.574), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }



	}
	SWEP.WElements = {
		["crossbow_rope+++"] = { type = "Model", model = "models/props_phx/trains/monorail1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "crossbow_limb", pos = Vector(0.648, 0, -1.341), angle = Angle(0, 90, 0), size = Vector(0.05, 0.014, 0.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },
		["crossbow_limb+"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "crossbow_limb", pos = Vector(0, 0, -1.68), angle = Angle(0, 0, 0), size = Vector(0.209, 0.264, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
		["crossbow_rope++"] = { type = "Model", model = "models/props_phx/trains/monorail1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "crossbow_limb", pos = Vector(-1.481, 0, -1.022), angle = Angle(0, 90, 0), size = Vector(0.05, 0.014, 0.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },
		["crossbow_limb"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.823, 0.722, -3.945), angle = Angle(10.592, 180, 0), size = Vector(0.209, 0.264, 0.048), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
		["crossbow_base"] = { type = "Model", model = "models/props_combine/combine_emitter01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "crossbow_limb", pos = Vector(3.378, 0, 3.019), angle = Angle(180, 180, 0), size = Vector(0.402, 0.479, 0.402), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["crossbow_wheel+"] = { type = "Model", model = "models/props_wasteland/wheel01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "crossbow_limb", pos = Vector(-0.299, 12, -0.617), angle = Angle(0, 0, 90), size = Vector(0.037, 0.104, 0.037), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder003", skin = 0, bodygroup = {} },
		["crossbow_rope+"] = { type = "Model", model = "models/props_phx/trains/monorail1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "crossbow_limb", pos = Vector(4.3, -5.89, -1.101), angle = Angle(0, -55, 0), size = Vector(0.029, 0.014, 0.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },
		["crossbow_wheel"] = { type = "Model", model = "models/props_wasteland/wheel01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "crossbow_limb", pos = Vector(-0.299, -12, -0.617), angle = Angle(0, 0, 90), size = Vector(0.037, 0.104, 0.037), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder003", skin = 0, bodygroup = {} },
		["crossbow_rope"] = { type = "Model", model = "models/props_phx/trains/monorail1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "crossbow_limb", pos = Vector(4.3, 5.889, -1.101), angle = Angle(0, 55, 0), size = Vector(0.029, 0.014, 0.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },
		["crossbow_base+"] = { type = "Model", model = "models/props_combine/eli_pod_inner.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "crossbow_limb", pos = Vector(9.765, 0, 1.838), angle = Angle(90, 0, 0), size = Vector(0.347, 0.136, 0.261), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/cstrike/c_smg_ump45.mdl"
SWEP.WorldModel = "models/weapons/w_smg_ump45.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_Crossbow.Single")
SWEP.Primary.Damage = 30
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

SWEP.IronSightsPos = Vector(-5.3, -1, 1.4)
SWEP.IronSightsAng = Vector(-1, 0.2, 2.55)

function SWEP:EmitFireSound()
	self:EmitSound(self.Primary.Sound)
	self:EmitSound("weapons/mortar/mortar_fire1.wav", 75, 110,1,CHAN_VOICE)
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