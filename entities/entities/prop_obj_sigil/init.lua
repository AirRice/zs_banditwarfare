AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
ENT.LastStopped = 0

--models/props_wasteland/antlionhill.mdl models/props_wasteland/medbridge_post01.mdl
function ENT:Initialize()
	self:DrawShadow(false)
	
	self:SetModel("models/props_lab/reciever_cart.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetPos( Vector( self:GetPos().x, self:GetPos().y, self:GetPos().z+35.3 )) 
	self:SetSigilMaxHealth(10+5*(math.floor(#player.GetAll()/5)))
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
		phys:Wake()
	end
	self:SetSigilCaptureProgress(self:GetSigilMaxHealth())
	self:SetSigilHealthRegen(self.HealthRegen)
	self:SetSigilLastDamaged(0)
	self:SetSigilTeam(0)
	self:SetCanCommunicate(1)
end

function ENT:CalcClosePlayers()
	local bnum = 0
	local hnum = 0
	for _, pl in pairs(ents.FindInSphere(self:GetPos(), 128 )) do
		if util.SkewedDistance(pl:GetPos(),self:GetPos(), 2.75) <= 128 then
		if pl:IsPlayer() then
			if pl:Team() == TEAM_HUMAN and pl:Alive() then
					hnum = hnum + 1
			elseif pl:Team() == TEAM_BANDIT and pl:Alive() then
					bnum = bnum + 1
			end
		elseif pl:GetClass() == "prop_drone" then
			if pl:GetOwner():IsPlayer() then 
				if pl:GetOwner():Team() == TEAM_HUMAN and pl:GetObjectHealth() > 0 then
					hnum = hnum + 0.5
				elseif pl:GetOwner():Team() == TEAM_BANDIT and pl:GetObjectHealth() > 0 then
					bnum = bnum + 0.5
				end
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
	if self.LastStopped <= CurTime() then
		self:SetCanCommunicate(1)
	end
	
	local oldhealth = self:GetSigilHealth()
	--[[for _, pl in pairs(ents.FindInSphere(self:GetPos(), 200 )) do
		if pl:IsPlayer() and pl:Team() == cappingteam then
			cappers = cappers +1
		end
	end]]
	if self:GetSigilTeam() ~= cappingteam and (cappingteam == TEAM_HUMAN or cappingteam == TEAM_BANDIT) and self:GetSigilLastDamaged() <= CurTime() - 1 then 
		for _, pl in pairs(ents.FindInSphere(self:GetPos(), 200 )) do
			if pl:IsPlayer() and pl:Team() == cappingteam then
				pl:AddPoints(2)
				net.Start("zs_capture")
					net.WriteEntity(self)
					net.WriteUInt(2, 16)
				net.Send(pl)
			end
		end
		
		self:SetSigilCaptureProgress(oldhealth - math.Clamp(cappers,0,5))
		self:EmitSound("buttons/blip1.wav")
		self:SetSigilLastDamaged(CurTime())
		if self:GetSigilHealth() <= 0 then
			self:SetSigilTeam(cappingteam)
			for _, pl in pairs(ents.FindInSphere(self:GetPos(), 128 )) do
				if pl:IsPlayer() and pl:Team() == cappingteam then
					gamemode.Call("SetObjectiveSigilsTaken",pl,pl.ObjectiveSigilsTaken+1)
				end
			end
			--print(dmginfo:GetAttacker().ObjectiveSigilsTaken)
			self:SetSigilCaptureProgress(self:GetSigilMaxHealth())
			self:EmitSound("ambient/machines/thumper_startup1.wav")
			gamemode.Call("OnSigilTaken", self, cappingteam)
		end
	end
end
function ENT:DoStopComms()
	self:EmitSound("npc/scanner/cbot_energyexplosion1.wav")
	local effectdata = EffectData()
		effectdata:SetOrigin(self:LocalToWorld(self:OBBCenter()))
	util.Effect("Explosion", effectdata, true, true)
	self:SetCanCommunicate(0)
	self.LastStopped = CurTime() + 10
	--gamemode.Call("OnSigilStopped", self)
end
function ENT:DoDamageComms(team)
	self:EmitSound("npc/scanner/cbot_energyexplosion1.wav")
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
		pl:CenterNotify(COLOR_DARKRED, translate.ClientFormat(pl, "sigil_comms_disrupted_x",translatestring))
	end
	self:SetSigilTeam(team)
	self:SetSigilCaptureProgress(self:GetSigilMaxHealth())
	self:EmitSound("ambient/machines/thumper_startup1.wav")
	gamemode.Call("OnSigilTaken", self, team)
	if team == TEAM_BANDIT then
		gamemode.Call("AddComms", 0,-10)
	elseif team == TEAM_HUMAN then
		gamemode.Call("AddComms", -10,0)
	end
end
--[[function ENT:OnTakeDamage(dmginfo)
	if self:GetSigilHealth() <= 0 then return end

	local attacker = dmginfo:GetAttacker()
	if not (attacker:IsValid() and attacker:IsPlayer() and (attacker:Team() == TEAM_BANDIT or attacker:Team() == TEAM_HUMAN) and dmginfo:GetDamage() > 2) then return end
	if self:GetSigilTeam() != nil and attacker:IsValid() and attacker:IsPlayer() and attacker:Team() == self:GetSigilTeam() then return end
	local oldhealth = self:GetSigilHealth()
	self:SetSigilLastDamaged(CurTime())
	self:SetSigilHealthBase(oldhealth - dmginfo:GetDamage())
	self:EmitSound("npc/scanner/cbot_energyexplosion1.wav")
	if self:GetSigilHealth() <= 0 then
		if dmginfo:GetAttacker():IsValid() and dmginfo:GetAttacker():IsPlayer() then 
			self:SetSigilTeam(dmginfo:GetAttacker():Team())
			gamemode.Call("SetObjectiveSigilsTaken",dmginfo:GetAttacker(),dmginfo:GetAttacker().ObjectiveSigilsTaken+1)
			--print(dmginfo:GetAttacker().ObjectiveSigilsTaken)
		else 
			self:SetSigilTeam(nil)
		end
		self:SetSigilHealthBase(self:GetSigilMaxHealth())
		self:EmitSound("ambient/machines/thumper_startup1.wav")
		gamemode.Call("OnSigilTaken", self, dmginfo)
	end
end]]

function ENT:Destroy()
	local effectdata = EffectData()
		effectdata:SetOrigin(self:LocalToWorld(self:OBBCenter()))
	util.Effect("Explosion", effectdata, true, true)

	self:Fire("kill", "", 0.01)
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end
