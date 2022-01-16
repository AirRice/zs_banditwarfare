ENT.Type = "anim"
function ENT:ShouldNotCollide(ent)
	return ent:IsPlayer() and self:GetOwner():IsPlayer() and ent:Team() == self:GetOwner():Team()
end
AccessorFuncDT(ENT, "HitTime", "Float", 0)

util.PrecacheModel("models/weapons/w_knife_t.mdl")
util.PrecacheSound("weapons/crossbow/hitbod2.wav")
