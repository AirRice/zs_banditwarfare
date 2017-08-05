hook.Add("InitPostEntityMap", "Adding", function()

	for _,spawns in pairs(ents.FindByClass("info_player_*")) do
		spawns:Remove()
	end

	local bspawn = ents.Create("info_player_zombie")
	if bspawn:IsValid() then
		bspawn:SetPos(Vector(-1585, 754, 102))
		bspawn:Spawn()
	end
	
	local hspawn = ents.Create("info_player_human")
	if hspawn:IsValid() then
		hspawn:SetPos(Vector(1786, 1834, 100))
		hspawn:Spawn()
	end
	
	for _, ent in pairs(ents.FindByClass("func_door_rotating")) do
		ent:Remove()
	end
end)