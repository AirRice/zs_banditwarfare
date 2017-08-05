ENT.Type = "anim"

function ENT:ShouldNotCollide(ent)
	return ent:IsPlayer() and ent:Team() == self.Owner:Team()
end

util.PrecacheModel("models/Gibs/HGIBS.mdl")
