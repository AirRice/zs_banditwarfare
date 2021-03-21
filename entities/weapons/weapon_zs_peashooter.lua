AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_peashooterpistol_name"
	SWEP.TranslateDesc = "weapon_peashooterpistol_desc"
	SWEP.Slot = 1
	SWEP.SlotPos = 0

	SWEP.ViewModelFOV = 60
	SWEP.ViewModelFlip = false

	SWEP.HUD3DBone = "v_weapon.p228_Slide"
	SWEP.HUD3DPos = Vector(-0.88, 0.35, 1)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.015
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "pistol"

SWEP.ViewModel = "models/weapons/cstrike/c_pist_p228.mdl"
SWEP.WorldModel = "models/weapons/w_pist_p228.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_P228.Single")
SWEP.Primary.Damage = 8
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.08

SWEP.Primary.ClipSize = 18
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"
GAMEMODE:SetupDefaultClip(SWEP.Primary)
SWEP.Recoil = 0.27
SWEP.ConeMax = 0.04
SWEP.ConeMin = 0.011
SWEP.MovingConeOffset = 0.05
SWEP.IronSightsPos = Vector(-6, -1, 2.25)

GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)