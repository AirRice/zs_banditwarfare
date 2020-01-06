local humanspawns = {
	Vector(1600, 2000, 0),
	Vector(1500, 2000, 0),
	Vector(1400, 2000, 0),
	Vector(1300, 2000, 0),
	Vector(1600, 1800, 0),
	Vector(1500, 1800, 0),
	Vector(1400, 1800, 0),
	Vector(1300, 1800, 0),
	Vector(1600, 1600, 0),
	Vector(1500, 1600, 0),
	Vector(1400, 1600, 0),
	Vector(1300, 1600, 0)
}

local banditspawns = {
	Vector(-1760, 2600, 0),
	Vector(-1660, 2600, 0),
	Vector(-1560, 2600, 0),
	Vector(-1760, 2400, 0),
	Vector(-1660, 2400, 0),
	Vector(-1560, 2400, 0),
	Vector(-1760, 2200, 0),
	Vector(-1660, 2200, 0),
	Vector(-1560, 2200, 0)
}

hook.Add("InitPostEntityMap", "Adding", function()
	for _, ent in pairs(ents.FindByClass("info_player_counterterrorist")) do
		ent:Remove()
	end
	for _, ent in pairs(ents.FindByClass("info_player_terrorist")) do
		ent:Remove()
	end
	for _, ent in pairs(ents.FindByClass("trigger_teleport")) do
		ent:Remove()
	end
	for _, ent in pairs(ents.FindByClass("func_illusionary")) do
		ent:Remove()
	end
	for _,vec in pairs(humanspawns) do 
		local newent = ents.Create("info_player_human")
		if newent:IsValid() then
			newent:SetPos(vec)
			newent:Spawn()
		end
	end
	for _,vec in pairs(banditspawns) do 
		local newent = ents.Create("info_player_zombie")
		if newent:IsValid() then
			newent:SetPos(vec)
			newent:Spawn()
		end
	end
end)
