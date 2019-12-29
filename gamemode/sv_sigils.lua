
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
	return a.d < b.d
end
function GM:CreateSigils()
	if #self.ProfilerNodes < self.MaxSigils then
		self:SetUseSigils(false)
		return
	end

	-- Copy
	local nodes = {}
	for _, node in pairs(self.ProfilerNodes) do
		local vec = Vector()
		vec:Set(node)
		nodes[#nodes + 1] = {v = vec}
	end

	local spawns = {}
	table.Add(spawns,team.GetSpawnPoint(TEAM_BANDIT))
	table.Add(spawns,team.GetSpawnPoint(TEAM_HUMAN))
	for i=1, self.MaxSigils do
		local id
		local sigs = ents.FindByClass("prop_obj_sigil")
		local nodeindex = 1
		for _, n in pairs(nodes) do
			n.d = 999999

			for __, spawn in pairs(spawns) do
				n.d = math.min(n.d, n.v:Distance(spawn:GetPos()))
			end
			local flag = false
			for __, sig in pairs(sigs) do
				if n.v:Distance(sig.NodePos) <= 512 then
					flag = true
				end
				n.d = math.min(n.d, n.v:Distance(sig.NodePos))
			end
			local tr = util.TraceLine({start = n.v + Vector(0, 0, 8), endpos = n.v + Vector(0, 0, 512), mask = MASK_SOLID_BRUSHONLY})
			n.d = n.d * (2 - tr.Fraction)
			if flag then 
				n.d = -99999
			end
			nodeindex = nodeindex+1
		end

		-- Sort the nodes by their distances.
		table.sort(nodes, SortDistFromLast)

		-- Now select a node using an exponential weight.
		-- We use a random float between 0 and 1 then sqrt it.
		-- This way we're much more likely to get a lower index but a higher index is still possible.
		id = math.Rand(0, 0.7) ^ 0.3
		id = math.Clamp(math.ceil(id * #nodes), 1, #nodes)

		-- Remove the chosen point from the temp table and make the sigil.
		if nodes[id].d > 0 then
			local point = nodes[id].v
			table.remove(nodes, id)
			local ent = ents.Create("prop_obj_sigil")

			if ent:IsValid() then
				ent:SetPos(point)
				ent:Spawn()
				ent.NodePos = point
			end
			--print(ent.NodePos)
		end
	end
	GAMEMODE.Objectives = {}
	self:SetUseSigils(#ents.FindByClass("prop_obj_sigil") > 0)
end

function GM:SetUseSigils(use)
	if self:GetUseSigils() ~= use then
		self.UseSigils = use
		SetGlobalBool("sigils", true)
	end
end

function GM:GetUseSigils(use)
	return self.UseSigils
end
