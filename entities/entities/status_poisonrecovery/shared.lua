ENT.Type = "anim"
ENT.Base = "status__base"

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetDTFloat(0, 1)
end

function ENT:AddDamage(damage)
	self:SetDamage(self:GetDamage() + damage)
end

function ENT:SetDamage(damage)
	self:SetDTFloat(0, math.min(75, damage))
end

function ENT:GetDamage()
	return self:GetDTFloat(0)
end
