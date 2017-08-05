include("shared.lua")

SWEP.PrintName = "수류탄"
SWEP.Description = "기본적인 고폭 수류탄.\n적절히 사용하면 수많은 적들을 죽일 수 있다."

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
