local humanspawns = {
	Vector(-2900, 25, -312),
	Vector(-2900, 125, -312),
	Vector(-2900, 225, -312),
	Vector(-2800, 25, -312),
	Vector(-2800, 125, -312),
	Vector(-2800, 225, -312),
	Vector(-2700, 25, -312),
	Vector(-2700, 125, -312),
	Vector(-2700, 225, -312),
}
hook.Add("InitPostEntityMap", "Adding", function()
	for _, ent in pairs(ents.FindByClass("info_player_counterterrorist")) do
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
 