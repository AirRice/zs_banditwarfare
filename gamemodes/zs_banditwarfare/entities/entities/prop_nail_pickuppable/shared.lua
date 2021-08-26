ENT.Type = "anim"
ENT.Base = "prop_baseoutlined"

ENT.NoNails = true

function ENT:HumanHoldable(pl)
	return false
end

util.PrecacheModel("models/crossbow_bolt.mdl")
util.PrecacheSound("weapons/crossbow/reload1.wav")