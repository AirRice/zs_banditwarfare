AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.InsertingPlayers = {}

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

function ENT:CalcSurroundingTeam()
	local bnum = 0
	local hnum = 0

	local playersToRemoveFromInsertingPlayers = player.GetAll()
	
	for _, pl in pairs(ents.FindInSphere(self:GetPos(), 200 )) do
		if pl:IsPlayer() then
			if pl:Team() == TEAM_HUMAN and pl:Alive() then
				hnum = hnum + 1
			elseif pl:Team() == TEAM_BANDIT and pl:Alive() then
				bnum = bnum + 1
			end

			self.InsertingPlayers[pl] = (self.InsertingPlayers[pl] or -1) + 1

			for k, v in pairs(playersToRemoveFromInsertingPlayers) do
				if v == pl then
					table.remove(playersToRemoveFromInsertingPlayers, k)
					break
				end
			end
		end
	end

	for i, pl in pairs(playersToRemoveFromInsertingPlayers) do
		self.InsertingPlayers[pl] = (self.InsertingPlayers[pl] or 1) - 1
		if self.InsertingPlayers[pl] <= 0 then
			self.InsertingPlayers[pl] = nil
		end
	end

	if not (bnum > 0 and hnum > 0) then
		if bnum > 0 then
			return TEAM_BANDIT
		elseif hnum > 0 then
			return TEAM_HUMAN
		end
	end
	return 0
end


function ENT:Think()
	if self:GetLastCalcedNearby() <= CurTime() - 1 and not GAMEMODE.SamplesEnd  then 
		local calcedTeam = self:CalcSurroundingTeam()
		self:SetLastCaptureTeam(calcedTeam)
		if (calcedTeam == TEAM_BANDIT or calcedTeam == TEAM_HUMAN) then
			for _, pl in pairs(ents.FindInSphere(self:GetPos(), 200 )) do
				if pl:IsPlayer() and pl:Team() == calcedTeam and pl:Alive() then
					local plysamples = pl:GetSamples()
					local togive = math.min(2 + (self.InsertingPlayers[pl] and self.InsertingPlayers[pl] or 0), plysamples)
					if togive > 0 then
						pl:TakeSamples(togive)
						pl:RestartGesture(ACT_GMOD_GESTURE_ITEM_GIVE)
						pl:EmitSound("weapons/physcannon/physcannon_drop.wav")
						gamemode.Call("PlayerAddedSamples", pl, calcedTeam, togive, self)
					end
				end
			end
		end
		self:SetLastCalcedNearby(CurTime())
	end
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end