include("shared.lua")

local matTrail = Material("Effects/laser1.vmt")
local colTrail = Color(255, 0, 155)

function ENT:Initialize()
	local scale = Vector(0.4,1.3,1.3)
	local mat = Matrix()
	mat:Scale(scale)
	self:EnableMatrix("RenderMultiply", mat)
	self.Trailing = CurTime() + 1
	self.TrailPositions = {}
end

function ENT:Draw()
	render.SetColorModulation(1,0,0.6)
	self:DrawModel()
	render.SetColorModulation(1, 1, 1)

	local vOffset = self.Entity:GetPos()

	render.SetMaterial(matTrail)
	for i=1, #self.TrailPositions do
		if self.TrailPositions[i+1] then
			render.DrawBeam(self.TrailPositions[i], self.TrailPositions[i+1], 7, 1, 0, colTrail)
		end
	end
end


function ENT:Think()
	if self.Entity:GetVelocity():Length() <= 0 and self.Trailing < CurTime() then
		function self:Draw() 	
			render.SetColorModulation(1,0,0.6) 
			self:DrawModel() 
			render.SetColorModulation(1, 1, 1) 
		end
		function self:Think() end
	else
		table.insert(self.TrailPositions, 1, self.Entity:GetPos())
		if self.TrailPositions[23] then
			table.remove(self.TrailPositions, 23)
		end
		local dist = 0
		local mypos = self.Entity:GetPos()
		for i=1, #self.TrailPositions do
			if self.TrailPositions[i]:Distance(mypos) > dist then
				self.Entity:SetRenderBoundsWS(self.TrailPositions[i], mypos, Vector(16, 16, 16))
				dist = self.TrailPositions[i]:Distance(mypos)
			end
		end
	end
end

function ENT:OnRemove()
end
