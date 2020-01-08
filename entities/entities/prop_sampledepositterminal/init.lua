AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_combine/breenconsole.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	self:CollisionRulesChanged()

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end
end

function ENT:Use(activator, caller)
	if activator:IsPlayer() and activator:Team() ~= self:GetOwnerTeam() then return end
	local plysamples = activator:GetSamples()
	local togive = math.min(2, plysamples)
	if togive > 0 then
		activator:TakeSamples(togive)
		activator:RestartGesture(ACT_GMOD_GESTURE_ITEM_GIVE)
		self:EmitSound("weapons/physcannon/physcannon_drop.wav")
		gamemode.Call("PlayerAddedSamples", activator, self:GetOwnerTeam(), togive, self)
	end
end