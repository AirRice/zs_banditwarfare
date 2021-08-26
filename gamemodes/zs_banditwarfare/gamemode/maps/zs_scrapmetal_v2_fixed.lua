local newspawns = {
	Vector(-250, -2850, -391),
	Vector(-350, -2850, -391),
	Vector(-450, -2850, -391),
	Vector(-250, -2700, -391),
	Vector(-350, -2700, -391),
	Vector(-450, -2700, -391)
}


hook.Add("InitPostEntityMap", "Adding", function()
	for _, ent in pairs(ents.FindByClass("info_player_human")) do
		ent:Remove()
	end
	for _, ent in pairs(ents.FindByClass("info_player_terrorist")) do
		ent:Remove()
	end
	for _,vec in pairs(newspawns) do 
		local newent = ents.Create("info_player_human")
		if newent:IsValid() then
			newent:SetPos(vec)
			newent:Spawn()
		end
	end
end)
