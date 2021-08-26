ENT.Type = "anim"

function ENT:ShouldNotCollide(ent)
	return ent:IsPlayer() and ent:Team() == self.Owner:Team()
end
AccessorFuncDT(ENT, "HitTime", "Float", 0)
util.PrecacheModel("models/Gibs/HGIBS.mdl")
