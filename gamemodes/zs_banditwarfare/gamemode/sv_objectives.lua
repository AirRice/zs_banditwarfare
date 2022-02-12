
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
	
	self.CurrentTransmitterTable = objs

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
	
	if self:IsTransmissionMode() then
		self.RoundEndCamPos = objent:WorldSpaceCenter()
		net.Start("zs_roundendcampos")
			net.WriteVector(self.RoundEndCamPos)
		net.Broadcast()
	end
end

GM.LastCommLink = 0
function GM:TransmitterCommsThink()
	if self.RoundEnded then return end
	local objteams = self.CurrentTransmitterTable
	local bnum = 0
	local hnum = 0
	for _, obj in pairs(objteams) do
		if obj:GetTransmitterTeam() == TEAM_BANDIT and obj:GetCanCommunicate() == 1 then
			bnum = bnum +1
		elseif obj:GetTransmitterTeam() == TEAM_HUMAN and obj:GetCanCommunicate() == 1 then
			hnum = hnum +1
		end
	end

	if not self.CommsEnd then 
		if self:GetBanditComms() < 200 and self:GetHumanComms() < 200 and self.LastCommLink <= CurTime() then
			self:AddComms(bnum,hnum)
			self.LastCommLink = CurTime() + 1
		elseif self:GetBanditComms() >= 200 and self:GetHumanComms() >= 200 then
			self.CommsEnd = true
			for _, pl in pairs(player.GetAll()) do
				pl:CenterNotify({killicon = "default"}, " ", COLOR_RED, translate.ClientGet(pl, "transmitter_comms_tied"), {killicon = "default"})
			end
			gamemode.Call("WaveEndWithWinner", nil)
		elseif self:GetBanditComms() >= 200 then
			self.CommsEnd = true
			for _, pl in pairs(player.GetAll()) do
				pl:CenterNotify({killicon = "default"}, " ", COLOR_RED, translate.ClientFormat(pl, "transmitter_comms_finished_by_x",translate.ClientGet(pl,"teamname_bandit")), {killicon = "default"})
			end
			gamemode.Call("WaveEndWithWinner", TEAM_BANDIT)
		elseif self:GetHumanComms() >= 200 then
			self.CommsEnd = true
			for _, pl in pairs(player.GetAll()) do
				pl:CenterNotify({killicon = "default"}, " ", COLOR_RED, translate.ClientFormat(pl, "transmitter_comms_finished_by_x",translate.ClientGet(pl,"teamname_human")), {killicon = "default"})
			end
			gamemode.Call("WaveEndWithWinner", TEAM_HUMAN)
		end
	end
end
function GM:SamplesThink()
	if self.RoundEnded then return end
	if not self.SamplesEnd then 
		if self.NextNestSpawn and self.NextNestSpawn <= CurTime() then
			gamemode.Call("CreateZombieNest")
			self.NextNestSpawn = CurTime() + 45
		end
		local timetoWin = math.min(3.5,self:GetWaveEnd()-CurTime()-0.1)
		if self:GetBanditSamples() >= 100 and self:GetHumanSamples() >= 100 then
			self.SamplesEnd = true
			for _, pl in pairs(player.GetAll()) do
				pl:CenterNotify({killicon = "default"}, " ", COLOR_RED, translate.ClientGet(pl, "samples_tied"), {killicon = "default"})
			end
			gamemode.Call("WaveEndWithWinner", nil)
		elseif self:GetBanditSamples() >= 100 then
			self.SamplesEnd = true
			for _, pl in pairs(player.GetAll()) do
				pl:CenterNotify({killicon = "default"}, " ", COLOR_RED, translate.ClientFormat(pl, "samples_finished_by_x",translate.ClientGet(pl,"teamname_bandit")), {killicon = "default"})
			end
			gamemode.Call("WaveEndWithWinner", TEAM_BANDIT)
		elseif self:GetHumanSamples() >= 100 then
			self.SamplesEnd = true
			for _, pl in pairs(player.GetAll()) do
				pl:CenterNotify({killicon = "default"}, " ", COLOR_RED, translate.ClientFormat(pl, "samples_finished_by_x",translate.ClientGet(pl,"teamname_human")), {killicon = "default"})
			end
			gamemode.Call("WaveEndWithWinner", TEAM_HUMAN)
		end
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
	player:AddPoints(togive)
	net.Start("zs_commission")
		net.WriteEntity(ent)
		net.WriteEntity(player)
		net.WriteUInt(1, 16)
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

	local id = 1
	local chosen = false
	while !chosen do
		id = math.random(1,#nodes)
		local avoid = player.GetAllActive()
		table.Merge(avoid,ents.FindByClass("prop_obj_nest"))
		table.Merge(avoid,ents.FindByClass("prop_sampledepositterminal"))
		local playerswithin = false
		for _, pl in pairs(avoid) do
			if pl:GetPos():Distance(nodes[id].v) < 128 then
				playerswithin = true
				break
			end
		end
		chosen = !playerswithin
	end
	-- Remove the chosen point from the temp table and make the nest.
	local point = nodes[id].v
	local ent = ents.Create("prop_obj_nest")
	if ent:IsValid() then
		ent:SetPos(point)
		ent:Spawn()
		ent.NodePos = point
		gamemode.Call("OnNestSpawned")
	end
end

function GM:CreateObjectives(entname,nocollide)
	if #self.ProfilerNodes < self.MaxTransmitters then
		return
	end

	-- Copy
	local nodes = {}
	for _, node in pairs(self.ProfilerNodes) do
		local vec = Vector()
		vec:Set(node)
		nodes[#nodes + 1] = {v = vec}
	end

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
	table.sort(nodes, SortDistFromLast)
	for i=1, self.MaxTransmitters do
		local id
		local sigs = ents.FindByClass(entname)
		local flag = false
		for __, sig in pairs(sigs) do
			for _, n in pairs(nodes) do
				if n.v:Distance(sig.NodePos) <= 800 or (math.random(2) == 1 and WorldVisible(n.v,sig.NodePos)) then
					table.remove(nodes, _)
				end
			end
		end
		
		-- Sort the nodes by their distances.
		-- Select node with algorithm that randomly selects while selecting closer ids more
		local id = 1
		if #nodes >=self.MaxTransmitters*2 then
			local decider = math.random(1,5)
			if decider > 2 then
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
		end
	end
end