AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	self.DieTime = CurTime() + self.LifeTime
end

function ENT:PlayerSet(pPlayer, bExists)
	pPlayer.Confusion = self
	pPlayer:SetDSP(12)
	self:SetDTFloat(0, CurTime())
	self:SetDTFloat(1, self.DieTime)
end

function ENT:Think()
	local owner = self:GetOwner()
	if CurTime() >= self:GetDTFloat(1) then
		self:Remove()
	end
end

function ENT:OnRemove()
	local owner = self:GetOwner()
	if owner.Confusion == self then
		owner.Confusion = nil
		owner:SetDSP(0)
	end
end
