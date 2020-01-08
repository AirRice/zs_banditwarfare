AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.DieTime = 0

function ENT:Initialize()
	if self.DieTime == 0 then
		self.DieTime = CurTime() + 30
	end
	self:SetModel("models/props_combine/breenbust.mdl")
	self:SetModelScale(0.5, 0)
	self:SetMaterial("models/flesh")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
	self:SetTrigger(true)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
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
	if self.DieTime ~= 0 and activator:IsPlayer() and activator:Alive() and (activator:Team() == TEAM_HUMAN or activator:Team() == TEAM_BANDIT) and GAMEMODE:IsSampleCollectMode() then
		activator:AddSamples(self.SampleAmount or 1)
		self:EmitSound("physics/flesh/flesh_bloody_break.wav")
		util.Blood(self:GetPos(), math.random(2), Vector(0, 0, 1), 100, self:GetDTInt(0), true)
		self.DieTime = 0
	end
end

function ENT:StartTouch(ent)
	if self.DieTime ~= 0 and ent:IsPlayer() and ent:Alive() then
		self:GiveToActivator(ent)
	end
end