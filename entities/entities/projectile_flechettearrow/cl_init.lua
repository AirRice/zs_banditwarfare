include("shared.lua")

local base_mat = Material("models/weapons/flare/shellside")
function ENT:Draw()
	render.ModelMaterialOverride(base_mat)
	render.SetColorModulation(0.5,0.5,1)
	self:DrawModel()
	render.ModelMaterialOverride()
	render.SetColorModulation(1, 1, 1)
end
