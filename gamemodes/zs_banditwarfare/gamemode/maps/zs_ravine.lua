local newspawns = {
	Vector(-180, 3330, -143),
	Vector(-180, 3230, -143),
	Vector(-240, 3330, -143),
	Vector(-240, 3230, -143),
	Vector(-330, 3330, -143),
	Vector(-330, 3230, -143),
	Vector(-400, 3330, -143),
	Vector(-400, 3230, -143)
}


hook.Add("InitPostEntityMap", "Adding", function()
	for _, ent in pairs(ents.FindByClass("info_player_zombie")) do
		ent:Remove()
	end
	for _,vec in pairs(newspawns) do 
		local newent = ents.Create("info_player_zombie")
		if newent:IsValid() then
			newent:SetPos(vec)
			newent:Spawn()
		end
	end
end)
