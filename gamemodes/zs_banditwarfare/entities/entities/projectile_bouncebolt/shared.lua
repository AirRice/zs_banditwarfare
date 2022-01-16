ENT.Type = "anim"
function ENT:ShouldNotCollide(ent)
	return ent:IsPlayer() and self:GetOwner():IsPlayer() and ent:Team() == self:GetOwner():Team()
end
AccessorFuncDT(ENT, "HitTime", "Float", 0)

ENT.Bounces = 0
ENT.MaxBounces = 3

util.PrecacheModel("models/crossbow_bolt.mdl")
util.PrecacheSound("Weapon_Crossbow.BoltFly")
util.PrecacheSound("Weapon_Crossbow.BoltHitWorld")
util.PrecacheSound("Weapon_Crossbow.BoltHitBody")
