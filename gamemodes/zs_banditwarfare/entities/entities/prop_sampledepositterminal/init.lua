AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.PlayerAdditionalInsertCount = {}
ENT.NearbyPlayers = {}
function ENT:Initialize()
	self:SetModel("models/props_combine/breenconsole.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	self:CollisionRulesChanged()
	
	self:SetSamplesSinceReset(0)
	self:SetLastInsertTime(CurTime())
	
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end
end

function ENT:CalcSurroundingTeam()
	local bnum = 0
	local hnum = 0

	self.NearbyPlayers = {}
 	for _, pl in pairs(util.FindInSphereBiasZ(self:GetPos(), 200 ,0.25)) do
 		if pl:IsPlayer() and pl:Alive() then
			local pl_uid = pl:SteamID64()
 			if pl:Team() == TEAM_HUMAN then
 				hnum = hnum + 1
 			elseif pl:Team() == TEAM_BANDIT then
 				bnum = bnum + 1
 			end
			self.NearbyPlayers[pl_uid] = true
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
	local switchawayfrom = false
	if not GAMEMODE.SamplesEnd then 
		if self:GetLastInsertTime() + 60 < CurTime() then
			switchawayfrom = true
		end
		if self:GetLastCalcedNearby() <= CurTime() - 1 and self:GetIsActive() then
			local calcedTeam = self:CalcSurroundingTeam()
			self:SetLastCaptureTeam(calcedTeam)
			for k, pl in pairs(player.GetAllActive()) do
				local pl_uid = pl:SteamID64()
				if self.NearbyPlayers[pl_uid] and pl:IsPlayer() and pl:Alive() then
					if (calcedTeam == TEAM_BANDIT or calcedTeam == TEAM_HUMAN) then
						local plysamples = pl:GetSamples()
						self.PlayerAdditionalInsertCount[pl_uid] = (self.PlayerAdditionalInsertCount[pl_uid] or 0)
						local togive = math.min(2 + self.PlayerAdditionalInsertCount[pl_uid], plysamples)
						if plysamples > 0 and pl:Team() == calcedTeam then
							pl:TakeSamples(togive)
							pl:RestartGesture(ACT_GMOD_GESTURE_ITEM_GIVE)
							pl:EmitSound("weapons/physcannon/physcannon_drop.wav")
							gamemode.Call("PlayerAddedSamples", pl, calcedTeam, togive, self)
							self:SetSamplesSinceReset(self:GetSamplesSinceReset() + togive)
							self.PlayerAdditionalInsertCount[pl_uid] = math.min(self.PlayerAdditionalInsertCount[pl_uid] + 1,8)
							self:SetLastInsertTime(CurTime())
							if not switchawayfrom and self:GetSamplesSinceReset() > GAMEMODE.SamplesBeforeChangeTerminal then
								switchawayfrom = true
							end
						else
							self.PlayerAdditionalInsertCount[pl_uid] = 0
						end
						if self.PlayerAdditionalInsertCount[pl_uid] <= 0 then
							self.PlayerAdditionalInsertCount[pl_uid] = nil
						end
					end
				else
					self.PlayerAdditionalInsertCount[pl_uid] = nil
				end
			end
			self:SetLastCalcedNearby(CurTime())
		end
		if switchawayfrom and GAMEMODE:GetBanditSamples() < 100 and GAMEMODE:GetHumanSamples() < 100 and self:GetIsActive() then
			gamemode.Call("SwitchCurrentlyActiveTerminal")
		end
	end
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end