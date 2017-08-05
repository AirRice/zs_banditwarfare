-- This profile gets rid of exploitable doors and teleporters.

hook.Add("InitPostEntityMap", "Adding", function()
	
	for _,spawns in pairs(ents.FindByClass("info_player_*")) do
		spawns:Remove()
	end
	for _, door in pairs(ents.FindByClass("func_door_rotating")) do
		door:Fire("open", "", 0)
		door:Fire("kill", "", 1)
	end

	for _, ent in pairs(ents.FindByClass("trigger_teleport")) do
		ent:Remove()
	end
	
	local bspawn = ents.Create("info_player_zombie")
	if bspawn:IsValid() then
		bspawn:SetPos(Vector(2142, -282, 154))
		bspawn:Spawn()
	end
end)
