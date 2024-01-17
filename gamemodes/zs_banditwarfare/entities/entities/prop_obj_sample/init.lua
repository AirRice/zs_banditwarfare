AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.DieTime = 0

function ENT:Initialize()
	if self.DieTime == 0 then
		self.DieTime = CurTime() + 30
	end
	self:SetModel("models/props_combine/breenbust.mdl")
	self:SetModelScale(1, 0)
	self:SetMaterial("models/shiny")
	self:SetColor( Color( 0, 255, 0, 255 ) ) 
	self:SetRenderMode(RENDERMODE_GLOW)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
	self:SetTrigger(true)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetDamping(1000,1000)
		phys:EnableMotion(true)
		phys:Wake()
	end
end

function ENT:Think()
	if self.DieTime >= 0 and self.DieTime <= CurTime() then
		local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos())
			effectdata:SetNormal(self:GetAngles():Up())
		util.Effect("fatexplosion", effectdata)
		self:Remove()
	end
end

function ENT:Use(activator, caller)
	if self.IgnoreUse then return end
	self:GiveToActivator(activator, caller)
end

function ENT:GiveToActivator(activator)
	local isdrone = false
	local droneent = nil
	local togiveent = nil
	if not GAMEMODE:IsSampleCollectMode() or  self.DieTime == 0 then return end
	if activator:GetClass() == "prop_drone" and IsValid(activator:GetOwner()) then
		isdrone = true
		droneent = activator
		togiveent = activator:GetOwner()
	else
		togiveent = activator
	end
	if togiveent:IsPlayer() and togiveent:Alive() and (togiveent:Team() == TEAM_HUMAN or togiveent:Team() == TEAM_BANDIT) then
		if isdrone then
			droneent:AddSamples(self.SampleAmount or 1)
		else
			togiveent:AddSamples(self.SampleAmount or 1)
		end
	else
		return
	end
	self:EmitSound("physics/flesh/flesh_bloody_break.wav")
	util.Blood(self:GetPos(), math.random(2), Vector(0, 0, 1), 100, self:GetDTInt(0), true)
	self.DieTime = 0
end

function ENT:StartTouch(ent)
	if self.DieTime ~= 0 and (ent:IsPlayer() and ent:Alive()) or (ent:GetClass() == "prop_drone") then
		self:GiveToActivator(ent)
	end
end