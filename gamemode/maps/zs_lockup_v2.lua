local humanspawns = {
	Vector(-1376, 160, 0),
	Vector(-1376, 96, 0),
	Vector(-1312, 96, 0),
	Vector(-1312, 160, 0),
	Vector(-1248, 160, 0),
	Vector(-1248, 96, 0),
	Vector(-1184, 96, 0),
	Vector(-1184, 160, 0),
	Vector(-1120, 160, 0),
	Vector(-1120, 96, 0),
	Vector(-1056, 160, 0)
}

local banditspawns = {
	Vector(-65, -3760, 8),
	Vector(15, -3760, 8),
	Vector(95, -3760, 8),
	Vector(-65, -3860, 8),
	Vector(15, -3860, 8),
	Vector(95, -3860, 8),
	Vector(-65, -3960, 8),
	Vector(15, -3960, 8),
	Vector(95, -3960, 8)
}

hook.Add("InitPostEntityMap", "Adding", function()
	for _, ent in pairs(ents.FindByClass("info_player_start")) do
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
	for _, ent in pairs(ents.FindInSphere(Vector(-154, -1750, 8), 400)) do
		if string.find(ent:GetClass(), "func_breakable") then
			ent:Remove()
		end
	end
	for _, ent in pairs(ents.FindInSphere(Vector(-812, -1753.4, 8), 400)) do
		if string.find(ent:GetClass(), "func_breakable") then
			ent:Remove()
		end
	end
	for _, ent in pairs(ents.FindByClass("func_breakable")) do
		ent:SetMaxHealth(10)
		ent:SetHealth(10)
	end
end)
