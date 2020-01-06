local newspawns = {
	Vector(3750, -1200, -319),
	Vector(3900, -1200, -319),
	Vector(3750, -1100, -319),
	Vector(3900, -1100, -319),
	Vector(3750, -1000, -319),
	Vector(3900, -1000, -319)
}

hook.Add("InitPostEntityMap", "Adding", function()
	for _, ent in pairs(ents.FindByClass("info_player_human")) do
		ent:Remove()
	end
	for _,vec in pairs(newspawns) do 
		local newent = ents.Create("info_player_human")
		if newent:IsValid() then
			newent:SetPos(vec)
			newent:Spawn()
		end
	end
	local ent = ents.Create("prop_dynamic_override")
	if ent:IsValid() then
		ent:SetPos(Vector(3648, -1480, -260))
		ent:SetAngles(Angle(0, 105, 0))
		ent:SetKeyValue("solid", "6")
		ent:SetModel(Model("models/props_wasteland/cargo_container01.mdl"))
		ent:Spawn()
	end
end)
