ENT.Type = "anim"

ENT.HealthRegen = 2
ENT.RegenDelay = 5

ENT.ModelScale = 1
ENT.Team = nil
ENT.m_NoNailUnfreeze = true
ENT.NoNails = true
ENT.IsBarricadeObject = true
ENT.NoDamageNumbers = true

AccessorFuncDT(ENT, "TransmitterCaptureProgress", "Float", 0)
AccessorFuncDT(ENT, "CanCommunicate", "Int", 0)
AccessorFuncDT(ENT, "TransmitterHealthRegen", "Float", 1)
AccessorFuncDT(ENT, "TransmitterLastDamaged", "Float", 2)
AccessorFuncDT(ENT, "TransmitterMaxHealth", "Float", 3)
AccessorFuncDT(ENT, "TransmitterTeam", "Int", 3)
AccessorFuncDT(ENT, "TransmitterNextRestart", "Float", 4)

function ENT:SetTransmitterHealth(health)
	self:SetTransmitterCaptureProgress(health)

	self:SetTransmitterLastDamaged(math.max(self:GetTransmitterLastDamaged(), self:GetTransmitterHealthRegen() - self.RegenDelay))
end

function ENT:GetTransmitterHealth()
	local base = self:GetTransmitterCaptureProgress()
	if base == 0 then return 0 end

	return math.Clamp(base + self:GetTransmitterHealthRegen() * math.max(0, CurTime() - (self:GetTransmitterLastDamaged() + self.RegenDelay)), 0, self:GetTransmitterMaxHealth())
end