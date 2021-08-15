include("shared.lua")

local vOffset = Vector(-1, 0, 8)
local aOffset = Angle(180, 90, 90)
function ENT:Draw()
	self:DrawModel()
	local perc = math.Clamp(self:GetObjectHealth() / self:GetMaxObjectHealth(), 0, 1)
	cam.Start3D2D(self:LocalToWorld(vOffset), self:LocalToWorldAngles(aOffset), 0.075)
		local y = -50
		local maxbarwidth = 560
		local barheight = 30
		local barwidth = maxbarwidth
		local startx = barwidth * -0.5

		surface.SetDrawColor(0, 0, 0, 220)
		surface.DrawRect(startx, y, barwidth, barheight)
		surface.SetDrawColor(255 - perc * 255, perc * 255, 0, 220)
		surface.DrawRect(startx + 4, y + 4, barwidth * perc - 8, barheight - 8)
		surface.DrawOutlinedRect(startx, y, barwidth, barheight)
	cam.End3D2D()
end