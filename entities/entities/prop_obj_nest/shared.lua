ENT.Type = "anim"

ENT.MaxHealthBase = 100

ENT.ModelScale = Vector(0.2, 0.2, 0.5)

ENT.m_NoNailUnfreeze = true
ENT.NoNails = true

AccessorFuncDT(ENT, "NestHealth", "Float", 0)

function ENT:GetNestMaxHealth()
	return self.MaxHealthBase
end
