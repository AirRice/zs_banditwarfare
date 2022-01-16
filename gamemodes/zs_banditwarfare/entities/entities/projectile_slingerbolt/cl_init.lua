include("shared.lua")

function ENT:Initialize()
	local scale = Vector(0.3,1,1)
	local mat = Matrix()
	mat:Scale(scale)
	self:EnableMatrix("RenderMultiply", mat)
end