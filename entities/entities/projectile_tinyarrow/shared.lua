ENT.Type = "anim"
function ENT:ShouldNotCollide(ent)
	return ent:IsPlayer() and self.Owner:IsPlayer() and ent:Team() == self.Owner:Team()
end
AccessorFuncDT(ENT, "HitTime", "Float", 0)

util.PrecacheModel("models/Items/CrossbowRounds.mdl")
util.PrecacheSound("weapons/crossbow/bolt_fly4.wav")
util.PrecacheSound("physics/metal/sawblade_stick1.wav")
util.PrecacheSound("physics/metal/sawblade_stick2.wav")
util.PrecacheSound("physics/metal/sawblade_stick3.wav")
util.PrecacheSound("weapons/crossbow/hitbod1.wav")
util.PrecacheSound("weapons/crossbow/hitbod2.wav")
