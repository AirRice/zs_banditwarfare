ENT.Type = "anim"
ENT.Damage = 64
ENT.NoPropDamageDuringWave0 = true

function ENT:ShouldNotCollide(ent)
	return ent:IsPlayer() and self:GetOwner():IsPlayer() and ent:Team() == self:GetOwner():Team()
end

util.PrecacheModel("models/items/ar2_grenade.mdl")
