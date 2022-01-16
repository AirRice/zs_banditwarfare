local humanspawns = {
	Vector(1160, -1570, 95),
	Vector(1020, -1570, 95),
	Vector(980, -1570, 95),
	Vector(840, -1570, 95),
	Vector(1160, -1450, 95),
	Vector(1020, -1450, 95),
	Vector(980, -1450, 95),
	Vector(840, -1450, 95),	
	Vector(1160, -1330, 95),
	Vector(1020, -1330, 95),
	Vector(980, -1330, 95),
	Vector(840, -1330, 95),	
	Vector(1160, -1210, 95),
	Vector(1020, -1210, 95),
	Vector(980, -1210, 95),
	Vector(840, -1210, 95)
}
local banditspawns = {
	Vector(-540, 710, 82),
	Vector(-435, 710, 82),
	Vector(-330, 710, 82),
	Vector(-540, 605, 82),
	Vector(-435, 605, 82),
	Vector(-330, 605, 82),
	Vector(-540, 500, 82),
	Vector(-435, 500, 82),
	Vector(-330, 500, 82)
}

hook.Add("InitPostEntityMap", "Adding", function()
	for _, ent in pairs(ents.FindByClass("info_player_human")) do
		ent:Remove()
	end
	for _, ent in pairs(ents.FindByClass("info_player_zombie")) do
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
		local newent = ents.Create("info_player_bandit")
		if newent:IsValid() then
			newent:SetPos(vec)
			newent:Spawn()
		end
	end
end)