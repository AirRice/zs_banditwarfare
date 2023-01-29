ENT.Type = "anim"
ENT.SameTeamNoCollide = true
AccessorFuncDT(ENT, "HitTime", "Float", 0)
ENT.m_IsProjectile = true
ENT.Armed = false

util.PrecacheModel("models/crossbow_bolt.mdl")
util.PrecacheSound("Weapon_Crossbow.BoltFly")
util.PrecacheSound("Weapon_Crossbow.BoltHitWorld")
util.PrecacheSound("Weapon_Crossbow.BoltHitBody")
