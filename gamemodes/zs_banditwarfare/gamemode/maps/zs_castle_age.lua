local banditspawns = {
	Vector(800, 1300, -936),
	Vector(700, 1300, -936),
	Vector(600, 1300, -936),
	Vector(800, 1400, -936),
	Vector(700, 1400, -936),
	Vector(600, 1400, -936),
	Vector(800, 1500, -936),
	Vector(700, 1500, -936),
	Vector(600, 1500, -936)
}

hook.Add("InitPostEntityMap", "Adding", function()
	for _, ent in pairs(ents.FindByClass("info_player_zombie")) do
		ent:Remove()
	end
	for _,vec in pairs(banditspawns) do 
		local newent = ents.Create("info_player_zombie")
		if newent:IsValid() then
			newent:SetPos(vec)
			newent:Spawn()
		end
	end
end)
