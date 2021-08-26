AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_reaperUMP_name"
	SWEP.TranslateDesc = "weapon_reaperUMP_desc"
	SWEP.Slot = 2
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "v_weapon.ump45_Release"
	SWEP.HUD3DPos = Vector(-1.1, -3, 2)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.02
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/cstrike/c_smg_ump45.mdl"
SWEP.WorldModel = "models/weapons/w_smg_ump45.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_UMP45.Single")
SWEP.Primary.Damage = 13
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.082

SWEP.Primary.ClipSize = 28
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_AR2

SWEP.ConeMax = 0.095
SWEP.ConeMin = 0.0155
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
SWEP.Recoil = 0.668
SWEP.WalkSpeed = SPEED_FAST

SWEP.IronSightsPos = Vector(-5.3, -3, 4.4)
SWEP.IronSightsAng = Vector(-1, 0.2, 2.55)
