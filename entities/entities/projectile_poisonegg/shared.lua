ENT.Type = "anim"
ENT.Damage = 8
function ENT:ShouldNotCollide(ent)
	return ent:IsPlayer() and ent:Team() == self.Owner:Team()
end

util.PrecacheModel("models/props/cs_italy/orange.mdl")