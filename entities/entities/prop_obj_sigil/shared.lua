ENT.Type = "anim"

ENT.HealthRegen = 2
ENT.RegenDelay = 5

ENT.ModelScale = 1 --ENT.ModelScale = 0.5
ENT.Team = nil
ENT.m_NoNailUnfreeze = true
ENT.NoNails = true
ENT.IsBarricadeObject = true

AccessorFuncDT(ENT, "SigilCaptureProgress", "Float", 0)
AccessorFuncDT(ENT, "CanCommunicate", "Int", 0)
AccessorFuncDT(ENT, "SigilHealthRegen", "Float", 1)
AccessorFuncDT(ENT, "SigilLastDamaged", "Float", 2)
AccessorFuncDT(ENT, "SigilMaxHealth", "Float", 3)
AccessorFuncDT(ENT, "SigilTeam", "Int", 3)

function ENT:SetSigilHealth(health)
	self:SetSigilCaptureProgress(health)

	self:SetSigilLastDamaged(math.max(self:GetSigilLastDamaged(), self:GetSigilHealthRegen() - self.RegenDelay))
end

function ENT:GetSigilHealth()
	local base = self:GetSigilCaptureProgress()
	if base == 0 then return 0 end

	return math.Clamp(base + self:GetSigilHealthRegen() * math.max(0, CurTime() - (self:GetSigilLastDamaged() + self.RegenDelay)), 0, self:GetSigilMaxHealth())
end