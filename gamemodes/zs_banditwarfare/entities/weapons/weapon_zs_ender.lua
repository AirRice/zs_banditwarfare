AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_endershotgun_name"
	SWEP.TranslateDesc = "weapon_endershotgun_desc"
	SWEP.Slot = 3
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "v_weapon.galil"
	SWEP.HUD3DPos = Vector(1, 0, 6)
	SWEP.HUD3DScale = 0.015
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "shotgun"

SWEP.ViewModel = "models/weapons/cstrike/c_rif_galil.mdl"
SWEP.WorldModel = "models/weapons/w_rif_galil.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_Galil.Single")
SWEP.Primary.Damage = 5
SWEP.Primary.NumShots = 11
SWEP.Primary.Delay = 0.23
SWEP.Recoil = 1.72
SWEP.Primary.ClipSize = 8
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "buckshot"
GAMEMODE:SetupDefaultClip(SWEP.Primary)
SWEP.SelfKnockBackForce = 100
SWEP.ConeMax = 0.07
SWEP.ConeMin = 0.05
SWEP.MovingConeOffset = 0.1
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)

SWEP.WalkSpeed = SPEED_SLOWER
SWEP.ReloadSpeed = 0.75

function SWEP:SecondaryAttack()
end
