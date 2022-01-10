AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_tosser_name"
	SWEP.TranslateDesc = "weapon_tosser_desc"
	SWEP.Slot = 2
	SWEP.SlotPos = 0

	SWEP.HUD3DBone = "ValveBiped.base"
	SWEP.HUD3DPos = Vector(1.5, 0.25, -2)
	SWEP.HUD3DScale = 0.02

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "smg"

SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_SMG1.Reload")
SWEP.Primary.Sound = Sound("Weapon_AR2.NPC_Single")
SWEP.Primary.Damage = 8
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.09

SWEP.Primary.ClipSize = 25
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SMG1

SWEP.ConeMax = 0.065
SWEP.ConeMin = 0.01
SWEP.MovingConeOffset = 0
SWEP.Recoil = 0.375
SWEP.WalkSpeed = SPEED_NORMAL
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)

--SWEP.IronSightsPos = Vector(-6.42, 4, 2.53)
SWEP.IronSightsPos = Vector(-6.425, 5, 1.02)
