ENT.Type = "anim"

ENT.CanPackUp = true

ENT.m_NoNailUnfreeze = true
ENT.NoNails = true

function ENT:CustomNoCollideRules(ent)
	if ent:IsProjectile() then 
		return true 
	elseif (ent:GetClass() == "prop_drone") or (ent:GetClass() == "prop_manhack") then
		return true
	else
		return false
	end
end