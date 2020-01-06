local banditspawns = {
	Vector(-1800, 700, 217),
	Vector(-1700, 700, 217),
	Vector(-1800, 800, 217),
	Vector(-1700, 800, 217),
	Vector(-2000, 900, 217),
	Vector(-1900, 900, 217),
	Vector(-1800, 900, 217),
	Vector(-1700, 900, 217)
}


hook.Add("InitPostEntityMap", "Adding", function()
	
	for _, ent in pairs(ents.FindByClass("info_player_counterterrorist")) do
		ent:Remove()
	end
	for _,vec in pairs(banditspawns) do 
		local newent = ents.Create("info_player_zombie")
		if newent:IsValid() then
			newent:SetPos(vec)
			newent:Spawn()
		end
	end
	local ent2 = ents.Create("env_fire")
	if ent2:IsValid() then
		ent2:SetPos(Vector(-341.7814, -380.7280, 345.9983))
		ent2:SetKeyValue("damagescale", 30)
		ent2:SetKeyValue("firesize", 200)
		ent2:Spawn()
		ent2:Fire("Enable", "", 0)
		ent2:Fire("StartFire", "", 0.1)
	end
end)
