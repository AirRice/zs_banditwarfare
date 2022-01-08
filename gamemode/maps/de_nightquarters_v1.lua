local banditspawns = {
	Vector(-2160, 1040, 410),
	Vector(-2240, 1040, 410),
	Vector(-2320, 1040, 410),
	Vector(-2400, 1040, 410),
	Vector(-2160, 1120, 410),
	Vector(-2240, 1120, 410),
	Vector(-2320, 1120, 410),
	Vector(-2400, 1120, 410),
	Vector(-2160, 1200, 410),
	Vector(-2240, 1200, 410),
	Vector(-2320, 1200, 410),
	Vector(-2400, 1200, 410)
}
local humanspawns = {
	Vector(1240, 1580, 474),
	Vector(1320, 1580, 474),	
	Vector(1400, 1580, 474),
	Vector(1240, 1670, 474),
	Vector(1320, 1670, 474),	
	Vector(1400, 1670, 474),
	Vector(1240, 1760, 474),
	Vector(1320, 1760, 474),	
	Vector(1400, 1760, 474),
	Vector(1240, 1850, 474),
	Vector(1320, 1850, 474),	
	Vector(1400, 1850, 474)	
}

hook.Add("InitPostEntityMap", "Adding", function()
	
	for _, ent in pairs(ents.FindByClass("info_player_terrorist")) do
		ent:Remove()
	end
	for _, ent in pairs(ents.FindByClass("info_player_counterterrorist")) do
		ent:Remove()
	end
	for _,vec in pairs(banditspawns) do 
		local newent = ents.Create("info_player_bandit")
		if newent:IsValid() then
			newent:SetPos(vec)
			newent:Spawn()
		end
	end
	for _,vec in pairs(humanspawns) do 
		local newent = ents.Create("info_player_human")
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
 