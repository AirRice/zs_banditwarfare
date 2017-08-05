include("shared.lua")

SWEP.PrintName = "판자 묶음"
SWEP.Description = "판자들의 묶음이다.\n주변에 물품이 없을 때 바리케이드를 설치하기에 유용하다.\n망치와 못이 있어야 고정시킬 수 있다."
SWEP.ViewModelFOV = 45
SWEP.ViewModelFlip = false

SWEP.Slot = 4
SWEP.SlotPos = 0

function SWEP:Deploy()
	self.IdleAnimation = CurTime() + self:SequenceDuration()

	return true
end

function SWEP:DrawWorldModel()
	local owner = self.Owner
	if owner:IsValid() and self:GetReplicatedAmmo() > 0 then
		local id = owner:LookupAttachment("anim_attachment_RH")
		if id and id > 0 then
			local attch = owner:GetAttachment(id)
			if attch then
				cam.Start3D(EyePos() + (owner:GetPos() - attch.Pos + Vector(0, 0, 24)), EyeAngles())
					self:DrawModel()
				cam.End3D()
			end
		end
	end
end
SWEP.DrawWorldModelTranslucent = SWEP.DrawWorldModel

function SWEP:Initialize()
	self:SetDeploySpeed(1.1)
end

function SWEP:GetViewModelPosition(pos, ang)
	if self:GetPrimaryAmmoCount() <= 0 then
		return pos + ang:Forward() * -256, ang
	end

	return pos, ang
end

function SWEP:DrawWeaponSelection(...)
	return self:BaseDrawWeaponSelection(...)
end
