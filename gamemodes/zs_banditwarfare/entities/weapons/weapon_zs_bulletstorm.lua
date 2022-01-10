AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_bulletstorm_name"
	SWEP.TranslateDesc = "weapon_bulletstorm_desc"
	SWEP.Slot = 2
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 50

	SWEP.HUD3DBone = "v_weapon.p90_Release"
	SWEP.HUD3DPos = Vector(-1.35, -0.5, -6.5)
	SWEP.HUD3DAng = Angle(0, 0, 0)
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "smg"

SWEP.ViewModel = "models/weapons/cstrike/c_smg_p90.mdl"
SWEP.WorldModel = "models/weapons/w_smg_p90.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_p90.Single")
SWEP.Primary.Damage = 7
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.044

SWEP.Primary.ClipSize = 50
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 0.13
SWEP.ConeMin = 0.01
SWEP.MovingConeOffset = -0.01
SWEP.Recoil = 0.22
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
SWEP.AimExpandUnit = 0.1
SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SMG1

SWEP.WalkSpeed = SPEED_SLOW

SWEP.IronSightsPos = Vector(-2, 6, 3)
SWEP.IronSightsAng = Vector(0, 2, 0)