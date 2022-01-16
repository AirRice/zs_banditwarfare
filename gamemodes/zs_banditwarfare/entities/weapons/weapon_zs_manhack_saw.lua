AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_manhack_saw_name"
	SWEP.TranslateDesc = "weapon_manhack_saw_desc"
end

SWEP.Base = "weapon_zs_manhack"

SWEP.DeployClass = "prop_manhack_saw"
SWEP.ControlWeapon = "weapon_zs_manhackcontrol_saw"

SWEP.Primary.Ammo = "manhack_saw"
