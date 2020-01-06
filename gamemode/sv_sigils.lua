
function GM:OnSigilTaken(ent, justtakenby)
	local sigils = {}
	local sigilteams = {}

	for _, ent in pairs(ents.FindByClass("prop_obj_sigil")) do
		sigils[#sigils + 1] = ent
		sigilteams[#sigilteams + 1] = ent:GetSigilTeam()
	end
	--PrintTable(sigils)
	net.Start("zs_currentsigils")
		net.WriteTable(sigilteams)
	net.Broadcast()
	self.CurrentSigilTable = sigils

	local translatestring = nil

	for _, pl in pairs(player.GetAll()) do
		if justtakenby == TEAM_BANDIT then
			translatestring = translate.ClientGet(pl,"teamname_bandit")
		elseif justtakenby == TEAM_HUMAN then
			translatestring = translate.ClientGet(pl,"teamname_human")
		end
		pl:CenterNotify(COLOR_DARKGREEN, translate.ClientFormat(pl, "one_sigil_taken_by_x",translatestring))
	end
	--[[if self.SuddenDeath then 
		for _, pl in pairs(player.GetAll()) do
			if justtakenby == TEAM_BANDIT then
				translatestring = translate.ClientGet(pl,"teamname_bandit")
			elseif justtakenby == TEAM_HUMAN then
				translatestring = translate.ClientGet(pl,"teamname_human")
			end
			pl:CenterNotify({killicon = "default"}, " ", COLOR_RED, translate.ClientFormat(pl, "sigil_comms_finished_by_x",translatestring), {killicon = "default"})
		end
		timer.Simple(2, function() gamemode.Call("WaveEndWithWinner", justtakenby) end)
	end]]
end
GM.LastCommLink = 0
function GM:SigilCommsThink()
	--PrintTable(self.CurrentSigilTable)
	local sigilteams = self.CurrentSigilTable
	local bnum = 0
	local hnum = 0
	for _, sigil in pairs(sigilteams) do
		if sigil:GetSigilTeam() == TEAM_BANDIT and sigil:GetCanCommunicate() == 1 then
			bnum = bnum +1
		elseif sigil:GetSigilTeam() == TEAM_HUMAN and sigil:GetCanCommunicate() == 1 then
			hnum = hnum +1
		end
	end

	if self:GetBanditComms() < 200 and self:GetHumanComms() < 200 and self.LastCommLink <= CurTime() then
		self:AddComms(bnum,hnum)
		self.LastCommLink = CurTime() + 1
	elseif not self.CommsEnd then 
		local timetoWin = math.min(3.5,self:GetWaveEnd()-CurTime()-0.1)
		if self:GetBanditComms() >= 200 and self:GetHumanComms() >= 200 then
			--self.SuddenDeath = true
			self.CommsEnd = true
			--[[net.Start("zs_suddendeath")
				net.WriteBool( true )
			net.Broadcast()]]
			for _, pl in pairs(player.GetAll()) do
				pl:CenterNotify({killicon = "default"}, " ", COLOR_RED, translate.ClientGet(pl, "sigil_comms_tied"), {killicon = "default"})
			end
			timer.Simple(timetoWin, function() gamemode.Call("WaveEndWithWinner", nil) end)
		elseif self:GetBanditComms() >= 200 then
			for _, pl in pairs(player.GetAll()) do
				pl:CenterNotify({killicon = "default"}, " ", COLOR_RED, translate.ClientFormat(pl, "sigil_comms_finished_by_x",translate.ClientGet(pl,"teamname_bandit")), {killicon = "default"})
			end
			timer.Simple(timetoWin, function() gamemode.Call("WaveEndWithWinner", TEAM_BANDIT) end)
			self.CommsEnd = true
		elseif self:GetHumanComms() >= 200 then
			for _, pl in pairs(player.GetAll()) do
				pl:CenterNotify({killicon = "default"}, " ", COLOR_RED, translate.ClientFormat(pl, "sigil_comms_finished_by_x",translate.ClientGet(pl,"teamname_human")), {killicon = "default"})
			end
			timer.Simple(timetoWin, function() gamemode.Call("WaveEndWithWinner", TEAM_HUMAN) end)
			self.CommsEnd = true
		end
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

function GM:CreateSigils()
	print ("creating sigils")
	if #self.ProfilerNodes < self.MaxSigils then
		self:SetClassicMode(false)
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
	for i=1, self.MaxSigils do
		local id
		local sigs = ents.FindByClass("prop_obj_sigil")
		local flag = false
		for __, sig in pairs(sigs) do
			for _, n in pairs(nodes) do
				if n.v:Distance(sig.NodePos) <= 512 then
					table.remove(nodes, _)
				end
			end
		end
		
		-- Sort the nodes by their distances.
		-- Select node with algorithm that randomly selects while selecting closer ids more
		local id = 1
		if #nodes >=self.MaxSigils*3 then
			if math.random(1,4) == 1 then
				id = math.random(math.floor(#nodes/3),math.floor(#nodes/3)*2)
			elseif math.random(1,4) == 4 then
				id = math.random(4,math.floor(#nodes/3))
			else
				id = math.random(1,3)
			end
		else
			id = math.random(1,#nodes)
		end

		-- Remove the chosen point from the temp table and make the sigil.
		local point = nodes[id].v
		table.remove(nodes, id)
		local ent = ents.Create("prop_obj_sigil")

		if ent:IsValid() then
			ent:SetPos(point)
			ent:Spawn()
			ent.NodePos = point
		end
	end
	GAMEMODE.Objectives = {}
end