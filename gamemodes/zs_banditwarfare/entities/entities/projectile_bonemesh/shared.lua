ENT.Type = "anim"

function ENT:ShouldNotCollide(ent)
	return ent:IsPlayer() and ent:Team() == self:GetOwner():Team()
end
AccessorFuncDT(ENT, "HitTime", "Float", 0)
util.PrecacheModel("models/Gibs/HGIBS.mdl")
