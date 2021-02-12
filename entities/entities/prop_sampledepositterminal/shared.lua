ENT.Type = "anim"

ENT.m_NoNailUnfreeze = true
ENT.NoNails = true

function ENT:SetOwnerTeam(id)
	self:SetDTInt(0, id)
end

function ENT:GetOwnerTeam()
	return self:GetDTInt(0)
end

AccessorFuncDT(ENT, "LastCalcedNearby", "Float", 1)