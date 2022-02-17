
function GM:OnTransmitterTaken(objent, justtakenby)
	local objs = {}
	local objteams = {}
	for _, ent in pairs(ents.FindByClass("prop_obj_transmitter")) do
		objs[#objs + 1] = ent
		objteams[#objteams + 1] = ent:GetTransmitterTeam()
	end
	
	net.Start("zs_currenttransmitters")
		for i=1, self.MaxTransmitters do
			net.WriteInt(objteams[i],4)
		end
	net.Broadcast()
	
	self.CurrentObjectives = objs

	local translatestring = nil
	local allSameTeam = true
	for i,team in ipairs(objteams) do
		if team != justtakenby then
			allSameTeam = false
			break
		end
	end
	for _, pl in pairs(player.GetAll()) do
		if justtakenby == TEAM_BANDIT then
			translatestring = translate.ClientGet(pl,"teamname_bandit")
		elseif justtakenby == TEAM_HUMAN then
			translatestring = translate.ClientGet(pl,"teamname_human")
		end
		pl:CenterNotify(COLOR_DARKGREEN, translate.ClientFormat(pl, allSameTeam and "all_transmitters_taken_by_x" or "one_transmitter_taken_by_x",translatestring))
	end
end

GM.LastCommLink = 0
function GM:TransmitterCommsThink()
	if self.RoundEnded then return end
	local obj_tbl = self.CurrentObjectives
	local bnum = 0
	local hnum = 0
	local selectedcamtransmitter = nil
	for _, obj in pairs(obj_tbl) do
		if obj:GetClass() == "prop_obj_transmitter" then
			if obj:GetTransmitterTeam() == TEAM_BANDIT and obj:GetCanCommunicate() == 1 then
				if not (selectedcamtransmitter and IsValid(selectedcamtransmitter)) and self:GetBanditComms() >= self:GetHumanComms() then
					selectedcamtransmitter = obj
				end
				bnum = bnum +1
			elseif obj:GetTransmitterTeam() == TEAM_HUMAN and obj:GetCanCommunicate() == 1 then
				if not (selectedcamtransmitter and IsValid(selectedcamtransmitter)) and self:GetHumanComms() >= self:GetHumanComms() then
					selectedcamtransmitter = obj
				end
				hnum = hnum +1
			end
			if (selectedcamtransmitter and IsValid(selectedcamtransmitter)) then
				self.RoundEndCamPos = selectedcamtransmitter:WorldSpaceCenter()
				net.Start("zs_roundendcampos")
					net.WriteVector(self.RoundEndCamPos)
				net.Broadcast()
			end
		end
	end

	if not self.CommsEnd then 
		if self:GetBanditComms() < 200 and self:GetHumanComms() < 200 and self.LastCommLink <= CurTime() then
			self:AddComms(bnum,hnum)
			self.LastCommLink = CurTime() + 1
		elseif self:GetBanditComms() >= 200 and self:GetHumanComms() >= 200 then
			gamemode.Call("WaveEndWithWinner", nil)
			for _, pl in pairs(player.GetAll()) do
				pl:CenterNotify({killicon = "default"}, " ", COLOR_RED, translate.ClientGet(pl, "transmitter_comms_tied"), {killicon = "default"})
			end
		elseif self:GetBanditComms() >= 200 then
			gamemode.Call("WaveEndWithWinner", TEAM_BANDIT)
			for _, pl in pairs(player.GetAll()) do
				pl:CenterNotify({killicon = "default"}, " ", COLOR_RED, translate.ClientFormat(pl, "transmitter_comms_finished_by_x",translate.ClientGet(pl,"teamname_bandit")), {killicon = "default"})
			end
		elseif self:GetHumanComms() >= 200 then
			gamemode.Call("WaveEndWithWinner", TEAM_HUMAN)
			for _, pl in pairs(player.GetAll()) do
				pl:CenterNotify({killicon = "default"}, " ", COLOR_RED, translate.ClientFormat(pl, "transmitter_comms_finished_by_x",translate.ClientGet(pl,"teamname_human")), {killicon = "default"})
			end
		end
	end
end
GM.LastNestSpawnTime = GM.BaseNestSpawnTime
GM.ActivatedInitialTerminal = nil
function GM:SamplesThink()
	if self.RoundEnded then return end
	if not self.SamplesEnd then 
		if self:GetWaveStart() + 10 <= CurTime() and not self.ActivatedInitialTerminal then
			self.ActivatedInitialTerminal = true
			self:SwitchCurrentlyActiveTerminal()
		end
		if self.NextNestSpawn and self.NextNestSpawn <= CurTime() then
			gamemode.Call("CreateZombieNest")
			local closetowinning = (self:GetBanditSamples() > 75 and self:GetHumanSamples() > 75)
			if !closetowinning then
				self.LastNestSpawnTime = math.max(self.LastNestSpawnTime - self.NestSpawnTimeReduction, self.MinNestSpawnTime)
			end
			self.NextNestSpawn = CurTime() + (closetowinning and self.BaseNestSpawnTime or self.LastNestSpawnTime)
		end
		local timetoWin = math.min(3.5,self:GetWaveEnd()-CurTime()-0.1)
		if self:GetBanditSamples() >= 100 and self:GetHumanSamples() >= 100 then
			gamemode.Call("WaveEndWithWinner", nil)
			for _, pl in pairs(player.GetAll()) do
				pl:CenterNotify({killicon = "default"}, " ", COLOR_RED, translate.ClientGet(pl, "samples_tied"), {killicon = "default"})
			end
		elseif self:GetBanditSamples() >= 100 then
			gamemode.Call("WaveEndWithWinner", TEAM_BANDIT)
			for _, pl in pairs(player.GetAll()) do
				pl:CenterNotify({killicon = "default"}, " ", COLOR_RED, translate.ClientFormat(pl, "samples_finished_by_x",translate.ClientGet(pl,"teamname_bandit")), {killicon = "default"})
			end
		elseif self:GetHumanSamples() >= 100 then
			gamemode.Call("WaveEndWithWinner", TEAM_HUMAN)
			for _, pl in pairs(player.GetAll()) do
				pl:CenterNotify({killicon = "default"}, " ", COLOR_RED, translate.ClientFormat(pl, "samples_finished_by_x",translate.ClientGet(pl,"teamname_human")), {killicon = "default"})
			end
		end
	end
end

function GM:SwitchCurrentlyActiveTerminal(entoverride)
	if !self:IsSampleCollectMode() then return end
	local obj_tbl = self.CurrentObjectives
	local hasoverride = entoverride and entoverride:IsValid() and entoverride:GetClass() == "prop_sampledepositterminal" and entoverride.SetIsActive
	obj_tbl = table.ShuffleOrder(obj_tbl)
	local activated = false
	for _, obj in ipairs(obj_tbl) do
		if obj:GetClass() == "prop_sampledepositterminal" then
			if obj:GetIsActive() then
				obj:SetIsActive(false)
			elseif not hasoverride then
				if not activated then
					obj:SetIsActive(true)
					activated = true
				end
			end
		end
	end
	if hasoverride then
		entoverride:SetIsActive(true)
	end
	for _, pl in pairs(player.GetAll()) do
		pl:CenterNotify({killicon = "default"}, " ", COLOR_RED, translate.ClientGet(pl, "sample_deposit_terminal_changed"), {killicon = "default"})
	end
end

function GM:PlayerAddedSamples(player, team, togive, ent)
	if self:GetBanditSamples() < 100 and self:GetHumanSamples() < 100 then
		if team == TEAM_BANDIT then
			self:AddSamples(togive,0)
		elseif team == TEAM_HUMAN then
			self:AddSamples(0,togive)
		end
	end
		
	local pointstogive = math.ceil(togive/2)
	player:AddPoints(pointstogive)
	net.Start("zs_commission")
		net.WriteEntity(ent)
		net.WriteEntity(player)
		net.WriteUInt(pointstogive, 16)
	net.Send(player)
	if self:IsSampleCollectMode() then
		self.RoundEndCamPos = ent:WorldSpaceCenter()
		net.Start("zs_roundendcampos")
			net.WriteVector(self.RoundEndCamPos)
		net.Broadcast()
	end
end

local function SortDistFromLast(a, b)
	if a.diff then
		if b.diff then
			return a.diff < b.diff
		else
			return true
		end
	else
		return false
	end
end

function GM:CreateZombieNest()
	local nodes = {}
	for _, node in pairs(self.ProfilerNodes) do
		local vec = Vector()
		vec:Set(node)
		nodes[#nodes + 1] = {v = vec}
	end
	nodes = table.ShuffleOrder(nodes)
	local point 
	local avoid = player.GetAllActive()
	table.Add(avoid,ents.FindByClass("prop_obj_nest"))
	table.Add(avoid,ents.FindByClass("prop_sampledepositterminal"))
	for _, node in pairs(nodes) do 
		local overlapped = false
		for _, ent in pairs(avoid) do
			local entdist = ent:GetPos():Distance(node.v)
			if entdist < 128 then
				overlapped = true
				break
			end
		end
		if !overlapped then 
			point = node.v
			break
		end
	end
	if point and isvector(point) then
		local ent = ents.Create("prop_obj_nest")
		if ent:IsValid() then
			ent:SetPos(point)
			ent:Spawn()
			ent.NodePos = point
			gamemode.Call("OnNestSpawned")
		end
	end
end

function GM:CreateObjectives(entname,nocollide)
	if #self.ProfilerNodes < self.MaxTransmitters then
		return
	end
	local nodes = {}
	for _, node in pairs(self.ProfilerNodes) do
		local vec = Vector()
		vec:Set(node)
		nodes[#nodes + 1] = {v = vec}
	end

	-- Arrange by absolute minimum distance difference between both teams' spawnpoints
	local bspawns = {}
	local hspawns = {}
	table.Add(bspawns,team.GetValidSpawnPoint(TEAM_BANDIT))
	table.Add(hspawns,team.GetValidSpawnPoint(TEAM_HUMAN))
	for _, n in pairs(nodes) do
		n.hd = 999999
		n.bd = 999999
		n.diff = 999999
		for __, spawn in pairs(hspawns) do
			n.hd = math.min(n.hd, n.v:Distance(spawn:GetPos()))
		end
		for __, spawn in pairs(bspawns) do
			n.bd = math.min(n.bd, n.v:Distance(spawn:GetPos()))
		end
		n.diff = math.abs(n.bd-n.hd)
			
		if n.diff > 3000 then 
			table.remove(nodes, _)
		end
	end
	
	local created_objectives = {}
	table.sort(nodes, SortDistFromLast)

	for i=1, self.MaxTransmitters do
		-- Sort the nodes by their distances.
		-- Select node with algorithm that randomly selects while selecting closer ids more
		local id = 1
		if #nodes >=self.MaxTransmitters*2 then
			for __, sig in pairs(created_objectives) do
				for _, n in pairs(nodes) do
					if n.v:Distance(sig.NodePos) <= 800 then
						table.remove(nodes, _)
					end
				end
			end
			local decider = math.random(1,5)
			if #nodes <= self.MaxTransmitters or decider > 2 then
				id = math.random(1,self.MaxTransmitters)
			else
				id = math.random(self.MaxTransmitters+1,#nodes)
			end
		else
			id = math.random(1,#nodes)
		end
		-- Remove the chosen point from the temp table and make the transmitter.
		local point = nodes[id].v
		table.remove(nodes, id)
		local ent = ents.Create(entname)
		if ent:IsValid() then
			ent:SetPos(point)
			ent:Spawn()
			if nocollide then
				ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
			end
			ent.NodePos = point
			created_objectives[i] = ent
		end
	end
	self.CurrentObjectives = created_objectives
end