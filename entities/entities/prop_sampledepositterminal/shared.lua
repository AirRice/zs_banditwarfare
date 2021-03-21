ENT.Type = "anim"

ENT.m_NoNailUnfreeze = true
ENT.NoNails = true

function ENT:SetLastCaptureTeam(id)
	self:SetDTInt(0, id)
end

function ENT:GetLastCaptureTeam()
	return self:GetDTInt(0)
end

AccessorFuncDT(ENT, "LastCalcedNearby", "Float", 1)