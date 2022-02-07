local banditspawns = {
	Vector(1100,-1320, 3),
	Vector(1010,-1320, 3),
	Vector(920,-1320, 3),
	Vector(830,-1320, 3),
	Vector(1100,-1440, 3),
	Vector(1010,-1440, 3),
	Vector(920,-1440, 3),
	Vector(830,-1440, 3),
	Vector(1100,-1560, 3),
	Vector(1010,-1560, 3),
	Vector(920,-1560, 3),
	Vector(830,-1560, 3)
}
local survivorspawns = {
	Vector(-1000,2635, 135),
	Vector(-900,2635, 135),
	Vector(-800,2635, 135),
	Vector(-1000,2732, 135),
	Vector(-900,2732, 135),
	Vector(-800,2732, 135),
	Vector(-1000,2829, 135),
	Vector(-900,2829, 135),
	Vector(-800,2829, 135)
}

hook.Add("InitPostEntityMap", "Adding", function()
	for _, ent in pairs(ents.FindByClass("info_player_zombie")) do
		ent:Remove()
	end
	for _, ent in pairs(ents.FindByClass("logic_waves")) do
		ent:Remove()
	end
	for _, ent in pairs(ents.FindByClass("logic_winlose")) do
		ent:Remove()
	end
	for _, ent in pairs(ents.FindByClass("info_player_human")) do
		ent:Remove()
	end
	for _,vec in pairs(banditspawns) do 
		local newent = ents.Create("info_player_bandit")
		if newent:IsValid() then
			newent:SetPos(vec)
			newent:Spawn()
		end
	end
	for _,vec in pairs(survivorspawns) do 
		local newent = ents.Create("info_player_human")
		if newent:IsValid() then
			newent:SetPos(vec)
			newent:Spawn()
		end
	end
end)