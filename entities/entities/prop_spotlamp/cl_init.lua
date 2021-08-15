include("shared.lua")

function ENT:Initialize()
	self:SetRenderBounds(Vector(-72, -72, -72), Vector(72, 72, 128))

	self.PixVis = util.GetPixelVisibleHandle()
end

function ENT:SetObjectHealth(health)
	self:SetDTFloat(0, health)
end

local matLight = Material("sprites/light_ignorez")
function ENT:DrawTranslucent()
	local owner = self:GetObjectOwner()
	local hasowner = owner:IsValid() and owner:IsPlayer()
	local colTeam = Color(255,255,255,255)
	if  hasowner and (owner:Team() == TEAM_BANDIT or owner:Team()  == TEAM_HUMAN) then
		colTeam = team.GetColor(owner:Team())
	end
	render.SetColorModulation(colTeam.r/255,colTeam.g/255,colTeam.b/255)
	self:DrawModel()
	render.SetColorModulation(1,1,1)
	local epos = self:GetSpotLightPos()
	local LightNrm = self:GetSpotLightAngles():Forward()
	local ViewNormal = epos - EyePos()
	local Distance = ViewNormal:Length()
	ViewNormal:Normalize()
	local ViewDot = ViewNormal:Dot( LightNrm * -1 )

	if ViewDot >= 0 then
		local LightPos = epos + LightNrm * 5

		render.SetMaterial(matLight)
		local Visibile	= util.PixelVisible( LightPos, 16, self.PixVis )	

		if not Visibile then return end

		local Size = math.Clamp(Distance * Visibile * ViewDot * 1.1, 20, 220)

		Distance = math.Clamp(Distance, 32, 800)
		local Alpha = math.Clamp((1000 - Distance) * Visibile * ViewDot, 0, 100)
		colTeam.a = Alpha
		render.DrawSprite(LightPos, Size, Size, colTeam, Visibile * ViewDot)
	end
	local perc = math.Clamp(self:GetObjectHealth() / self:GetMaxObjectHealth(), 0, 1)

	cam.Start3D2D(self:LocalToWorld(Vector(self:OBBMaxs().x, 0, 1)), self:LocalToWorldAngles(Angle(180, 270, 180)), 0.05)
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

