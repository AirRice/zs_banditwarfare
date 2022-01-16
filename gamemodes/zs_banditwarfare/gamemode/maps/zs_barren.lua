local humanspawns = {
	Vector(-480, -1100, 200),
	Vector(-355, -1100, 200),
	Vector(-230, -1100, 200),
	Vector(-480, -875, 200),
	Vector(-355, -875, 200),
	Vector(-230, -875, 200),
	Vector(-480, -650, 200),
	Vector(-355, -650, 200),
	Vector(-230, -650, 200)
}

local banditspawns = {
	Vector(3900, 2200, 64),
	Vector(3800, 2200, 64),
	Vector(3700, 2200, 64),
	Vector(3600, 2200, 64),
	Vector(3900, 2325, 64),
	Vector(3800, 2325, 64),
	Vector(3700, 2325, 64),
	Vector(3600, 2325, 64),
	Vector(3900, 2450, 64),
	Vector(3800, 2450, 64),
	Vector(3700, 2450, 64),
	Vector(3600, 2450, 64)
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
	local ent2 = ents.Create("prop_dynamic_override")
	if ent2:IsValid() then
		ent2:SetPos(Vector(3097, 2040, 93))
		ent2:SetAngles(Angle(0, 175, 0))
		ent2:SetKeyValue("solid", "6")
		ent2:SetModel(Model("models/props_vehicles/car005b.mdl"))
		ent2:Spawn()
	end
end)
