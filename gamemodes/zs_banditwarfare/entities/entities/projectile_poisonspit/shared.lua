ENT.Type = "anim"

function ENT:ShouldNotCollide(ent)
	return ent:IsPlayer() and ent:Team() == self:GetOwner():Team()
end

util.PrecacheModel("models/props/cs_italy/orange.mdl")
util.PrecacheSound("npc/antlion_grub/squashed.wav")
