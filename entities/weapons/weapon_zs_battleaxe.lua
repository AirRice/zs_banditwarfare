AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_battleaxe_name"
	SWEP.TranslateDesc = "weapon_battleaxe_desc"
	SWEP.Slot = 1
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DPos = Vector(-0.95, 0, 1)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DBone = "v_weapon.USP_Slide"
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "pistol"

SWEP.ViewModel = "models/weapons/cstrike/c_pist_usp.mdl"
SWEP.WorldModel = "models/weapons/w_pist_usp.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_USP.Single")
SWEP.Primary.Damage = 15
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.2
SWEP.Recoil = 0.5

SWEP.Primary.ClipSize = 12
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.IronSightsPos = Vector(-5.9, 12, 2.3)

SWEP.ConeMax = 0.013
SWEP.ConeMin = 0.005
SWEP.MovingConeOffset = 0.04
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)