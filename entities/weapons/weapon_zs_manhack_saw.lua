AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "톱날 맨핵"
	SWEP.Description = "톱날로 개조시킨 맨핵이다.\n더 많은 피해를 입히며 강력하다. 단, 조종이 더 힘들다."
end

SWEP.Base = "weapon_zs_manhack"

SWEP.DeployClass = "prop_manhack_saw"
SWEP.ControlWeapon = "weapon_zs_manhackcontrol_saw"

SWEP.Primary.Ammo = "manhack_saw"
