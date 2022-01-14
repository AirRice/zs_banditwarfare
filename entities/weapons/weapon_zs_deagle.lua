AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_deagle_name"
	SWEP.TranslateDesc = "weapon_deagle_desc"
	SWEP.Slot = 1
	SWEP.SlotPos = 1

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 55

	SWEP.HUD3DBone = "v_weapon.Deagle_Slide"
	SWEP.HUD3DPos = Vector(-1, 0, 1)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.015

	SWEP.IronSightsPos = Vector(-6.35, 5, 1.7)
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "revolver"

SWEP.ViewModel = "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel = "models/weapons/w_pist_deagle.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_Deagle.Single")
SWEP.Primary.Damage = 26
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.28
SWEP.Primary.KnockbackScale = 2
SWEP.Recoil = 1.6
SWEP.Primary.ClipSize = 7
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 0.007
SWEP.ConeMin = 0.003
SWEP.MovingConeOffset = 0.15
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)