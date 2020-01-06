include("shared.lua")

function ENT:Initialize()
	self:SetRenderBounds(Vector(-72, -72, -72), Vector(72, 72, 72))

	self.AmbientSound = CreateSound(self, "npc/scanner/scanner_combat_loop1.wav")
	self.AmbientSound:Play()

	self.PixVis = util.GetPixelVisibleHandle()

	hook.Add("CreateMove", self, self.CreateMove)
	hook.Add("ShouldDrawLocalPlayer", self, self.ShouldDrawLocalPlayer)
	hook.Add("CalcView", self, self.CalcView)
end

function ENT:Think()
	self.AmbientSound:PlayEx(0.5, math.Clamp(75 + self:GetVelocity():Length() * 0.5, 75, 150))
end

function ENT:OnRemove()
	self.AmbientSound:Stop()
end

function ENT:SetObjectHealth(health)
	self:SetDTFloat(0, health)
end

local colLight = Color(255, 0, 0)
local colWhite = Color(255, 255, 255)
local colHealth = Color(255, 255, 255)
local matLight = Material("sprites/light_ignorez")
function ENT:DrawTranslucent()
	self:DrawModel()

	local lp = LocalPlayer()
	local owner = self:GetOwner()

	if owner:IsValid() and owner:IsPlayer() and lp:IsValid() and lp:Team() == owner:Team() then
		local ang = EyeAngles()
		ang.pitch = 0
		local right = ang:Right()
		ang:RotateAroundAxis(ang:Up(), 270)
		ang:RotateAroundAxis(ang:Forward(), 90)
		cam.Start3D2D(self:LocalToWorld(Vector(0, 0, 26)), ang, 0.025)
			draw.SimpleTextBlurry(owner:Name(), "ZS3D2DFont", 0, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			local perc = math.Clamp(self:GetObjectHealth() / self:GetMaxObjectHealth(), 0, 1)
			colHealth.r = 255
			colHealth.g = perc ^ 0.3 * 255
			colHealth.b = perc * 255
			draw.SimpleTextBlurry(math.ceil(perc * 100), "ZS3D2DFontBig", 0, 0, colHealth, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		cam.End3D2D()
	end

	local epos = self:GetRedLightPos()
	local LightNrm = self:GetRedLightAngles():Forward()
	local ViewNormal = epos - EyePos()
	local Distance = ViewNormal:Length()
	ViewNormal:Normalize()
	local ViewDot = math.min(1, ViewNormal:Dot( LightNrm * -1 ) + 0.25)

	if ViewDot > 0 then
		if owner:IsValid() and owner:IsPlayer() then
			local vcol = team.GetColor(owner:Team())
			if vcol then
				colLight.r = math.Clamp(vcol.r, 0, 255)
				colLight.g = math.Clamp(vcol.g, 0, 255)
				colLight.b = math.Clamp(vcol.b, 0, 255)
			end
		end

		local LightPos = epos + LightNrm * 5

		render.SetMaterial(matLight)
		local Visibile	= util.PixelVisible( LightPos, 16, self.PixVis )	

		if not Visibile then return end

		local Size = math.Clamp(Distance * Visibile * ViewDot, 25, 250)

		Distance = math.Clamp(Distance, 32, 800)
		local Alpha = math.Clamp((1000 - Distance) * Visibile * ViewDot, 0, 120)
		colLight.a = Alpha
		colWhite.a = Alpha

		render.DrawSprite(LightPos, Size, Size, colLight, Visibile * ViewDot)
		render.DrawSprite(LightPos, Size*0.4, Size*0.4, colWhite, Visibile * ViewDot)
	end
end

function ENT:CreateMove(cmd)
	if self:GetOwner() ~= LocalPlayer() then return end

	if not self:BeingControlled() then return end

	local buttons = cmd:GetButtons()

	cmd:ClearMovement()

	if bit.band(buttons, IN_JUMP) ~= 0 then
		buttons = buttons - IN_JUMP
		buttons = buttons + IN_BULLRUSH
	end

	if bit.band(buttons, IN_DUCK) ~= 0 then
		buttons = buttons - IN_DUCK
		buttons = buttons + IN_GRENADE1
	end

	cmd:SetButtons(buttons)
end

function ENT:ShouldDrawLocalPlayer(pl)
	if self:GetOwner() ~= LocalPlayer() then return end

	if self:BeingControlled() then
		return true
	end
end

local ViewHullMins = Vector(-4, -4, -4)
local ViewHullMaxs = Vector(4, 4, 4)
function ENT:CalcView(pl, origin, angles, fov, znear, zfar)
	if self:GetOwner() ~= pl then return end

	if not self:BeingControlled() then return end

	local filter = player.GetAll()
	filter[#filter + 1] = self
	local tr = util.TraceHull({start = self:GetPos(), endpos = self:GetPos() + angles:Forward() * -48, mask = MASK_SHOT, filter = filter, mins = ViewHullMins, maxs = ViewHullMaxs})

	return {origin = tr.HitPos + tr.HitNormal * 3}
end
