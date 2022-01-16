﻿AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_immortal_name"
	SWEP.TranslateDesc = "weapon_immortal_desc"
	SWEP.Slot = 1
	SWEP.SlotPos = 3

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "Python"
	SWEP.HUD3DPos = Vector(2, 0, -2.5)
	SWEP.HUD3DScale = 0.03
	
	SWEP.VElements = {
		["barrelcover"] = { type = "Model", model = "models/vehicles/prisoner_pod_inner.mdl", bone = "Python", rel = "", pos = Vector(-0.003, 0.172, 10.34), angle = Angle(5.268, -90.18, 180), size = Vector(0.193, 0.193, 0.193), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["cylinder"] = { type = "Model", model = "models/props_combine/headcrabcannister01a.mdl", bone = "Cylinder", rel = "", pos = Vector(-0.058, -0.087, 1.705), angle = Angle(90, 0, -90), size = Vector(0.061, 0.061, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "glass/glasswindow001b", skin = 2, bodygroup = {} },
		["barrel"] = { type = "Model", model = "models/props_trainstation/pole_448connection002b.mdl", bone = "Cylinder", rel = "", pos = Vector(-0.007, -0.681, 9.984), angle = Angle(0, 0, 0), size = Vector(0.057, 0.032, 0.046), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["cylinder+"] = { type = "Model", model = "models/props_combine/combine_teleportplatform.mdl", bone = "Cylinder", rel = "", pos = Vector(0, 0, -0.761), angle = Angle(0, 0, 0), size = Vector(0.034, 0.034, 0.024), color = Color(255, 255, 255, 255), surpresslightning = false, material = "glass/glasswindow001b", skin = 2, bodygroup = {} }
	}
	SWEP.WElements = {
		["cylinder"] = { type = "Model", model = "models/props_combine/combine_teleportplatform.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.187, 1.039, -3.554), angle = Angle(90, 0, 0), size = Vector(0.05, 0.05, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel"] = { type = "Model", model = "models/props_trainstation/pole_448connection002b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(13.048, 0.871, -4.332), angle = Angle(-96, 0, 0), size = Vector(0.079, 0.039, 0.034), color = Color(255, 255, 255, 255), surpresslightning = false, material = "particle/bendibeam", skin = 0, bodygroup = {} },
		["barrelcover"] = { type = "Model", model = "models/vehicles/prisoner_pod_inner.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(13.699, 0.841, -3.527), angle = Angle(81.195, 0, 0), size = Vector(0.185, 0.185, 0.185), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end
SWEP.ViewModelBoneMods = {
	["Cylinder"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Python"] = { scale = Vector(1, 1, 1), pos = Vector(-0.212, 0, 0), angle = Angle(0, 0, 0) }
}

sound.Add(
{
	name = "Weapon_Immortal.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	soundlevel = 100,
	sound = "weapons/gauss/fire1.wav"
})

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "pistol"

SWEP.ViewModel = "models/weapons/c_357.mdl"
SWEP.WorldModel = "models/weapons/w_357.mdl"
SWEP.UseHands = true
SWEP.ReloadSound = Sound("Weapon_AWP.ClipOut")
SWEP.Primary.Sound = Sound("Weapon_Immortal.Single")
SWEP.Primary.Damage = 45
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.7
SWEP.Recoil = 3
SWEP.Primary.ClipSize = 4
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"
GAMEMODE:SetupDefaultClip(SWEP.Primary)
SWEP.TracerName = "AirboatGunHeavyTracer"
SWEP.ConeMax = 0.003
SWEP.ConeMin = 0.0005
SWEP.MovingConeOffset = 0.08
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
SWEP.ReloadSpeed = 1.3
SWEP.IronSightsPos = Vector(-4.6, 0, -0.12)
SWEP.IronSightsAng = Vector(0, 0, 0)

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:EmitFireSound()
	self:TakeAmmo()
	self:ShootBullets(self.Primary.Damage+self.Primary.Damage*math.Clamp(1-self:GetOwner():Health()/self:GetOwner():GetMaxHealth(),0,1), self.Primary.NumShots, self:GetCone())
	self.IdleAnimation = CurTime() + self:SequenceDuration()
end