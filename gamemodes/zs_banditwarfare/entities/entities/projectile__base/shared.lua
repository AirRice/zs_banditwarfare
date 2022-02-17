ENT.Type = "anim"
ENT.m_IsProjectile = true
ENT.LifeTime = 30
ENT.DieTime = 0
ENT.FinishOffset = 8

ENT.m_bboxMins = Vector(-4,-0.02,-0.02)
ENT.m_bboxMaxs = Vector(8, 0.02, 0.02)
function ENT:ShouldNotCollide(ent)
	return ent:IsPlayer() and self:GetOwner():IsPlayer() and ent:Team() == self:GetOwner():Team()
end
AccessorFuncDT(ENT, "HitTime", "Float", 0)

util.PrecacheModel("models/crossbow_bolt.mdl")
util.PrecacheSound("Weapon_Crossbow.BoltFly")
util.PrecacheSound("Weapon_Crossbow.BoltHitWorld")
util.PrecacheSound("Weapon_Crossbow.BoltHitBody")