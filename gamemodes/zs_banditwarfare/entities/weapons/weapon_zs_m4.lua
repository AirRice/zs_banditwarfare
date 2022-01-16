AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_stalker_name"
	SWEP.TranslateDesc = "weapon_stalker_desc"
	SWEP.Slot = 2
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "v_weapon.m4_Parent"
	SWEP.HUD3DPos = Vector(-0.75, -5.5, -5.2)
	SWEP.HUD3DAng = Angle(0, -8, 0)
	SWEP.HUD3DScale = 0.02
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "smg"

SWEP.ViewModel = "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel = "models/weapons/w_rif_m4a1.mdl"
SWEP.UseHands = true
SWEP.Primary.Sound = Sound("Weapon_m4a1.Single")
SWEP.Primary.Damage = 13
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.1

SWEP.Primary.ClipSize = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "ar2"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SMG1

SWEP.ConeMax = 0.048
SWEP.ConeMin = 0.003
SWEP.Recoil = 0.37
SWEP.MovingConeOffset = 0.08
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
SWEP.WalkSpeed = SPEED_SLOW
SWEP.IronSightsPos = Vector(-8.2, 10, -1)
SWEP.IronSightsAng = Vector(1.261, -1.364, -4.441)
