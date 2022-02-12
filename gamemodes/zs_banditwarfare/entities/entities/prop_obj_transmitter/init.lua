AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

--models/props_wasteland/antlionhill.mdl models/props_wasteland/medbridge_post01.mdl
function ENT:Initialize()
	self:DrawShadow(false)
	
	self:SetModel("models/props_lab/reciever_cart.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetPos( Vector( self:GetPos().x, self:GetPos().y, self:GetPos().z+35.3 ))
	local lowPlayerCountThreshold = GAMEMODE.LowPlayerCountThreshold - 2

	local playersCount = math.min(lowPlayerCountThreshold, player.GetCount() - 2)

	local lessPlayersReduction = math.ceil(4 * (1 - playersCount / lowPlayerCountThreshold))
	
	local adder = math.min(5 * math.floor(math.max(player.GetCount()/GAMEMODE.LowPlayerCountThreshold-1,0)),10)
	
	local transmittercalcedhealth = 10 + adder - lessPlayersReduction
	
	self:SetTransmitterMaxHealth(transmittercalcedhealth)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
		phys:Wake()
	end
	self:SetTransmitterCaptureProgress(self:GetTransmitterMaxHealth())
	self:SetTransmitterHealthRegen(self.HealthRegen)
	self:SetTransmitterLastDamaged(0)
	self:SetTransmitterNextRestart(0)
	self:SetTransmitterTeam(0)
	self:SetCanCommunicate(1)
end

function ENT:CalcClosePlayers()
	local bnum = 0
	local hnum = 0
	local nearbyents = util.FindInSphereBiasZ(self:GetPos(), 150 ,0.35)
	for _, pl in pairs(nearbyents) do
		if pl:IsPlayer() then
			local doubleSpeed = pl:GetActiveWeapon().DoubleCapSpeed
			local skipPlayer = pl:GetActiveWeapon().SkipForCommsCalc
			if not skipPlayer then
				if pl:Team() == TEAM_HUMAN and pl:Alive() then
						hnum = hnum + (doubleSpeed and 2 or 1)
				elseif pl:Team() == TEAM_BANDIT and pl:Alive() then
						bnum = bnum + (doubleSpeed and 2 or 1)
				end
			end
		elseif pl:GetClass() == "prop_drone" then
			if pl:GetOwner():IsPlayer() and not table.HasValue(nearbyents,pl:GetOwner()) then 
				if pl:GetOwner():Team() == TEAM_HUMAN and pl:GetObjectHealth() > 0 then
					hnum = hnum + 1
				elseif pl:GetOwner():Team() == TEAM_BANDIT and pl:GetObjectHealth() > 0 then
					bnum = bnum + 1
				end
			end
		end
	end
	if not (bnum > 0 and hnum > 0) then
		if bnum > 0 then
			return TEAM_BANDIT , bnum
		elseif hnum > 0 then
			return TEAM_HUMAN , hnum
		end
	end
	return 0 , 0
end

function ENT:Think()
	local cappingteam, cappers = self:CalcClosePlayers()
	if self:GetTransmitterNextRestart() <= CurTime() then
		self:SetCanCommunicate(1)
	end
	
	local oldhealth = self:GetTransmitterHealth()
	if self:GetTransmitterTeam() ~= cappingteam and (cappingteam == TEAM_HUMAN or cappingteam == TEAM_BANDIT) and self:GetTransmitterLastDamaged() <= CurTime() - 1 then 
		for _, pl in pairs(ents.FindInSphere(self:GetPos(), 150 )) do
			if pl:IsPlayer() and pl:Team() == cappingteam and pl:Alive() then
				pl:AddPoints(1)
				gamemode.Call("AddPlayerCaptime",pl)
				net.Start("zs_capture")
					net.WriteEntity(self)
					net.WriteUInt(1, 16)
				net.Send(pl)
			end
		end
					
		self:SetTransmitterCaptureProgress(oldhealth - math.Clamp(cappers,0,5))
		self:EmitSound("buttons/blip1.wav")
		self:SetTransmitterLastDamaged(CurTime())
		if self:GetTransmitterHealth() <= 0 then
			self:SetTransmitterTeam(cappingteam)
			self:SetTransmitterCaptureProgress(self:GetTransmitterMaxHealth())
			self:EmitSound("ambient/machines/thumper_startup1.wav")
			gamemode.Call("OnTransmitterTaken", self, cappingteam)
		end
	end
end
function ENT:DoStopComms()
	self:EmitSound("npc/scanner/cbot_energyexplosion1.wav")
	local effectdata = EffectData()
		effectdata:SetOrigin(self:LocalToWorld(self:OBBCenter()))
	util.Effect("Explosion", effectdata, true, true)
	self:SetCanCommunicate(0)
	self:SetTransmitterNextRestart(CurTime() + 15)
end

function ENT:DoDamageComms(team,pl)
	self:EmitSound("npc/scanner/cbot_energyexplosion1.wav")
	if pl:IsPlayer() and pl:Alive() then gamemode.Call("OnPlayerUsedBackdoor",pl) end
	local effectdata = EffectData()
		effectdata:SetOrigin(self:LocalToWorld(self:OBBCenter()))
	util.Effect("Explosion", effectdata, true, true)
	local translatestring = nil
	for _, pl in pairs(player.GetAll()) do
		if team == TEAM_BANDIT then
			translatestring = translate.ClientGet(pl,"teamname_human")
		elseif team == TEAM_HUMAN then
			translatestring = translate.ClientGet(pl,"teamname_bandit")
		end
		pl:CenterNotify(COLOR_DARKRED, translate.ClientFormat(pl, "transmitter_comms_disrupted_x",translatestring))
	end
	self:SetTransmitterTeam(team)
	self:SetTransmitterCaptureProgress(self:GetTransmitterMaxHealth())
	self:EmitSound("ambient/machines/thumper_startup1.wav")
	gamemode.Call("OnTransmitterTaken", self, team)
	if team == TEAM_BANDIT then
		gamemode.Call("AddComms", 0,-10)
	elseif team == TEAM_HUMAN then
		gamemode.Call("AddComms", -10,0)
	end
end

function ENT:Destroy()
	local effectdata = EffectData()
		effectdata:SetOrigin(self:LocalToWorld(self:OBBCenter()))
	util.Effect("Explosion", effectdata, true, true)

	self:Fire("kill", "", 0.01)
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end
