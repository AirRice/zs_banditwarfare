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

function ENT:Think()
	if self:GetLastCalcedNearby() <= CurTime() - 1 then 
		for _, pl in pairs(ents.FindInSphere(self:GetPos(), 200 )) do
			if pl:IsPlayer() and pl:Team() == self:GetOwnerTeam() and pl:Alive() then
				local plysamples = pl:GetSamples()
				local togive = math.min(5, plysamples)
				if togive > 0 then
					pl:TakeSamples(togive)
					pl:RestartGesture(ACT_GMOD_GESTURE_ITEM_GIVE)
					pl:EmitSound("weapons/physcannon/physcannon_drop.wav")
					gamemode.Call("PlayerAddedSamples", pl, self:GetOwnerTeam(), togive, self)
				end
			end
		end
		self:SetLastCalcedNearby(CurTime())
	end
end
