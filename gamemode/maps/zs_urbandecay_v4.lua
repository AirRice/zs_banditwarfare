local humanspawns = {
	Vector(620, -235, -7),
	Vector(715, -235, -7),
	Vector(810, -235, -7),
	Vector(620, -385, -7),
	Vector(715, -385, -7),
	Vector(810, -385, -7),
	Vector(620, -535, -7),
	Vector(715, -535, -7),
	Vector(810, -535, -7)
}

local banditspawns = {
	Vector(2500, -3230, 62),
	Vector(2350, -3230, 62),
	Vector(2200, -3230, 62),
	Vector(2500, -3080, 62),
	Vector(2350, -3080, 62),
	Vector(2200, -3080, 62),
	Vector(2500, -2930, 62),
	Vector(2350, -2930, 62),
	Vector(2200, -2930, 62)
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
		local newent = ents.Create("info_player_zombie")
		if newent:IsValid() then
			newent:SetPos(vec)
			newent:Spawn()
		end
	end
end)
