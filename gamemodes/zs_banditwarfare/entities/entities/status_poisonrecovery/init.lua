AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:PlayerSet(pPlayer, bExists)
	pPlayer.PoisonRecovery = self
end

function ENT:Think()
	local owner = self:GetOwner()

	if self:GetDamage() <= 0 or not(owner:Team() == TEAM_BANDIT or owner:Team() == TEAM_HUMAN) then
		self:Remove()
		return
	end

	owner:SetHealth(math.min(owner:GetMaxHealth(), owner:Health() + 1))
	self:AddDamage(-1)
	self:NextThink(CurTime() + 0.085)
	return true
end

function ENT:OnRemove()
	local owner = self:GetOwner()
	if self:GetDamage() > 0 and (owner:Team() == TEAM_BANDIT or owner:Team() == TEAM_HUMAN) then
		owner:SetHealth(math.min(owner:GetMaxHealth(), owner:Health() + self:GetDamage()))
	end
end