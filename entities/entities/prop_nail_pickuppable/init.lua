AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.DieTime = 0

function ENT:Initialize()
	if self.DieTime == 0 then
		self.DieTime = CurTime() + 30
	end
	self:SetModel("models/crossbow_bolt.mdl")
	self:SetCollisionBounds(Vector(-8,-0.1,-0.1), Vector(8,0.1,0.1))
	self:SetSolid(SOLID_BBOX)
	self:SetSkin(1)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
	self:SetTrigger(true)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
		phys:Wake()
	end
end

function ENT:Think()
	if self.DieTime >= 0 and self.DieTime <= CurTime() then
		self:Remove()
	end
end

function ENT:Use(activator, caller)
	if self.IgnoreUse then return end
	self:GiveToActivator(activator, caller)
end

function ENT:GiveToActivator(activator)
	if self.DieTime ~= 0 and activator:IsPlayer() and activator:Alive() and (activator:Team() == TEAM_HUMAN or activator:Team() == TEAM_BANDIT) then
		activator:GiveAmmo( 1, "GaussEnergy", false )
		self:EmitSound("weapons/crossbow/reload1.wav")
		self.DieTime = 0
	end
end

function ENT:StartTouch(ent)
	if self.DieTime ~= 0 and ent:IsPlayer() and ent:Alive() then
		self:GiveToActivator(ent)
	end
end