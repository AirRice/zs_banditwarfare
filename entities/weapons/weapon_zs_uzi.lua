AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "'스프레이어' Uzi 9mm"
	SWEP.Slot = 2
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 50

	SWEP.HUD3DBone = "v_weapon.mac10_bolt"
	SWEP.HUD3DPos = Vector(-1.45, 1.25, 0)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.015
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "pistol"

SWEP.ViewModel = "models/weapons/cstrike/c_smg_mac10.mdl"
SWEP.WorldModel = "models/weapons/w_smg_mac10.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_MAC10.Single")
SWEP.Primary.Damage = 15
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.06

SWEP.Primary.ClipSize = 40
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"

GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SMG1

SWEP.ConeMax = 0.125
SWEP.ConeMin = 0.05
SWEP.Recoil = 0.45
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
SWEP.WalkSpeed = SPEED_NORMAL

SWEP.IronSightsPos = Vector(-7, 15, 0)
SWEP.IronSightsAng = Vector(3, -3, -10)
