include("shared.lua")

SWEP.TranslateName = "weapon_hegrenade_name"
SWEP.TranslateDesc = "weapon_hegrenade_desc"
SWEP.ViewModelFOV = 60

SWEP.Slot = 4
SWEP.SlotPos = 0

--[[function SWEP:GetViewModelPosition(pos, ang)
	if self:GetPrimaryAmmoCount() <= 0 then
		return pos + ang:Forward() * -256, ang
	end

	return pos, ang
end]]

function SWEP:DrawWeaponSelection(...)
	return self:BaseDrawWeaponSelection(...)
end
