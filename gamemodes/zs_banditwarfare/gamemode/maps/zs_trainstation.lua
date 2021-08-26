local humanspawns = {
	Vector(730, -390, 203),
	Vector(620, -390, 203),
	Vector(510, -390, 203),
	Vector(730, -480, 203),
	Vector(620, -480, 203),
	Vector(510, -480, 203),
	Vector(730, -570, 203),
	Vector(620, -570, 203),
	Vector(510, -570, 203)
}

hook.Add("InitPostEntityMap", "Adding", function()
	for _, ent in pairs(ents.FindByClass("info_player_human")) do
		ent:Remove()
	end

	for _,vec in pairs(humanspawns) do 
		local newent = ents.Create("info_player_human")
		if newent:IsValid() then
			newent:SetPos(vec)
			newent:Spawn()
		end
	end

end)