AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_wasteland/antlionhill.mdl")
	self:PhysicsInitBox(Vector(-20, -20, 0), Vector(20, 20, 80))
	self:SetCollisionBounds(Vector(-20, -20, 0), Vector(20, 20, 80))
	self:SetUseType(SIMPLE_USE)

	--self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
	self:SetCustomCollisionCheck(true)
	self:CollisionRulesChanged()

	--[[local mat = Matrix()
	mat:Scale(self.ModelScale)
	self:EnableMatrix("RenderMultiply", mat)]]
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetMaterial("flesh")
		phys:EnableMotion(false)
		phys:Wake()
	end
	self:SetNestMaxHealth(math.Clamp(math.floor(self.MaxHealthBase * player.GetCount()/GAMEMODE.LowPlayerCountThreshold),self.MaxHealthBase,200))
	self:SetNestHealth(self:GetNestMaxHealth())
end

function ENT:Use()
end

function ENT:OnTakeDamage(dmginfo)
	if self:GetNestHealth() <= 0 then return end

	local attacker = dmginfo:GetAttacker()
	if attacker:IsValid() and attacker:IsPlayer() and not (attacker:Team() == TEAM_HUMAN or attacker:Team() == TEAM_BANDIT) then return end

	self:SetNestHealth(self:GetNestHealth() - dmginfo:GetDamage())
	if self:GetNestHealth() <= 0 then
		if attacker:IsValid() and attacker:IsPlayer() and (attacker:Team() == TEAM_HUMAN or attacker:Team() == TEAM_BANDIT) then
			attacker:AddPoints(5)
			attacker:FloatingScore(self, "floatingscore", 5, FM_NONE)
			gamemode.Call("OnNestDestroyed",attacker)
		end
		self:Destroy()
	end
end

function ENT:Destroy()
	local lowPlayerCountThreshold = GAMEMODE.LowPlayerCountThreshold - 2

	local playersCount = math.min(lowPlayerCountThreshold, player.GetCount() - 2)

	local adder = math.ceil(GAMEMODE.LowPlayerCountSamplesMaxAdditionalCountNest * (1 - playersCount / lowPlayerCountThreshold))

	self.Destroyed = true
	self:DropSample(10 + adder)
	local pos = self:WorldSpaceCenter()

	local effectdata = EffectData()
		effectdata:SetEntity(self)
		effectdata:SetOrigin(pos)
	util.Effect("gib_player", effectdata, true, true)

	util.Blood(pos, 100, self:GetUp(), 256)

	self:Fire("kill", "", 0.01)
end

function ENT:OnRemove()
	if self.Destroyed then
		local pos = self:WorldSpaceCenter()
		for i=1, 8 do
			local ent = ents.CreateLimited("prop_playergib")
			if ent:IsValid() then
				ent:SetPos(pos + VectorRand() * 12)
				ent:SetAngles(VectorRand():Angle())
				ent:SetGibType(math.random(3, #GAMEMODE.HumanGibs))
				ent:Spawn()
			end
		end
	end
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end
