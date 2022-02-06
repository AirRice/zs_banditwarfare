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

function ENT:HitByHammer(wep, pl, tr)
	if not (IsValid(pl) and pl:IsPlayer()) then return end
	if self:GetTransmitterTeam() == pl:Team() and not self:GetCanCommunicate() then
		self:SetTransmitterNextRestart(math.min(self:GetTransmitterNextRestart() - 3,CurTime()))
		return true
	end
	return false
end

function ENT:HitByWrench(wep, pl, tr)
	if not (IsValid(pl) and pl:IsPlayer()) then return end
	if self:GetTransmitterTeam() != pl:Team() and (pl:Team() == TEAM_HUMAN or pl:Team() == TEAM_BANDIT) and (self:GetTransmitterTeam() == TEAM_BANDIT or self:GetTransmitterTeam() == TEAM_HUMAN) then
		if SERVER then
			self:DoStopComms()
		end
		return true
	end
	return false
end