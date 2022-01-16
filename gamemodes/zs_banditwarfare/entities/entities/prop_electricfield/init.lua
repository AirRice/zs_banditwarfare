AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.NextHurt = 0
ENT.DieTime = 0
ENT.NextEffect = 0
function ENT:Initialize()
	self:DrawShadow(false)
	self:SetModel("models/hunter/misc/shell2x2.mdl")
	self:PhysicsInit(SOLID_NONE)
	self:SetUseType(SIMPLE_USE)
	self:SetColor(Color(155, 208, 255, 255))
	self:SetModelScale(1.85,1)
	if self.DieTime == 0 then
		self.DieTime = CurTime() + self.LifeTime
	end
end

function ENT:Think()
	local owner = self:GetOwner()
	if CurTime() >= self.NextHurt then 
		for _, pl in pairs(ents.FindInSphere(self:GetPos(), 68 )) do
			if pl:IsPlayer() and owner:IsPlayer() and pl:Team() != owner:Team() and pl:Alive() then
				pl:TakeSpecialDamage(self.HurtTick, DMG_SHOCK, owner, self, self:GetPos(), self:GetPos())
				self.TotalHurt = self.TotalHurt - self.HurtTick
			elseif (pl:GetClass() == "prop_drone" or pl:GetClass() == "prop_manhack" or pl:IsNailed() or pl.IsBarricadeObject) and not pl:IsSameTeam(owner)then
				pl:TakeSpecialDamage(self.HurtTick, DMG_SHOCK, owner, self, self:GetPos(), self:GetPos())
			end
		end
		self:EmitSound("ambient/energy/zap"..math.random(5, 9)..".wav", 75, math.Rand(90, 110))
		self.NextHurt = CurTime() + 0.15
	end
	if CurTime() >= self.NextEffect then
		local effectdata = EffectData()
			effectdata:SetEntity(self)
			effectdata:SetMagnitude(11)
			effectdata:SetScale(5)
			util.Effect("TeslaHitBoxes", effectdata)
		self.NextEffect = CurTime() + 0.1
	end
	if self.DieTime >= 0 and self.DieTime <= CurTime() or self.TotalHurt <= 0 then
		self:Remove()
	end
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end