ENT.Type = "anim"
ENT.Base = "projectile__base"

function ENT:ShouldNotCollide(ent)
	return ent:IsPlayer()
end

AccessorFuncDT(ENT, "HitTime", "Float", 0)

ENT.Bounces = 0
ENT.MaxBounces = 3

util.PrecacheModel("models/crossbow_bolt.mdl")
util.PrecacheSound("Weapon_Crossbow.BoltFly")
util.PrecacheSound("Weapon_Crossbow.BoltHitWorld")
util.PrecacheSound("Weapon_Crossbow.BoltHitBody")
