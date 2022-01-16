include("shared.lua")

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.Seed = 0
function ENT:Initialize()
	self:SetRenderBounds(Vector(-128, -128, -128), Vector(128, 128, 200))
	self:SetModelScaleVector(Vector(1, 1, 1) * self.ModelScale)
	self.AmbientSound = CreateSound(self, "ambient/machines/combine_terminal_loop1.wav")
	self.Seed = math.Rand(0, 10)
end

function ENT:Think()
	if EyePos():Distance(self:GetPos()) <= 1000 and self:GetCanCommunicate() == 1 then
		self.AmbientSound:PlayEx(1, 75 + (self:GetTransmitterHealth() / self:GetTransmitterMaxHealth()) * 25)
	else
		self.AmbientSound:Stop()
	end
end

function ENT:OnRemove()
	self.AmbientSound:Stop()
end

ENT.NextEmit = 0
ENT.Rotation = math.random(360)

local matWhite = Material("models/debug/debugwhite")
local matGlow = Material("sprites/light_glow02_add")
local matBeam = Material("cable/new_cable_lit")
local cDraw = Color(255, 255, 255)
local cDrawWhite = Color(255, 255, 255)

function ENT:DrawTranslucent()
	self:RemoveAllDecals()
	local curtime = CurTime()
	local eyepos = EyePos()
	local eyeangles = EyeAngles()
	local healthperc = math.Clamp(self:GetTransmitterHealth() / self:GetTransmitterMaxHealth(),0,1)
	local waitingperc = math.Clamp((self:GetTransmitterNextRestart()-CurTime())/15,0,1)
	local teamcolor = nil
	if self:GetTransmitterTeam() ~= nil then 
		teamcolor = team.GetColor(self:GetTransmitterTeam())
	end
	local dlight = DynamicLight(self:EntIndex())
	if dlight then
		dlight.Pos = self:GetPos()
		if teamcolor ~= nil then
			dlight.r = teamcolor.r
			dlight.g = teamcolor.g
			dlight.b = teamcolor.b
		end
		dlight.Brightness = 3*healthperc
		dlight.Size = 200
		dlight.Decay = 200
		dlight.DieTime = curtime + 1
	end
	render.SuppressEngineLighting(true)

	local vPos = self:GetPos() + self:GetUp()*60
	local vOffset = self:GetForward() * self:OBBMaxs().x
	self:DrawModel()
	local eyepos = EyePos()
	local ang = (eyepos - vPos):Angle()
	ang:RotateAroundAxis(ang:Right(), 270)
	ang:RotateAroundAxis(ang:Up(), 90)
	--cam.IgnoreZ(true)
	cam.Start3D2D(vPos, Angle(0,ang.yaw,90), 0.05)
	self:DrawHealthBar(healthperc)
	draw.SimpleText(math.Round(self:GetTransmitterHealth()), "ZS3D2DFontBig", 0,280, COLOR_WHITE, TEXT_ALIGN_CENTER)
	if (self:GetTransmitterTeam() == TEAM_BANDIT or self:GetTransmitterTeam() == TEAM_HUMAN) then
		local teamname = translate.Get(self:GetTransmitterTeam() == TEAM_BANDIT and "teamname_bandit" or "teamname_human")
		draw.SimpleText(teamname, "ZS3D2DFontBig", 0, -100, teamcolor ~= nil and teamcolor or COLOR_WHITE, TEXT_ALIGN_CENTER)
		draw.RoundedBox( 40, -500, -900, 1000, 750, teamcolor ~= nil and teamcolor or COLOR_WHITE )
	end
	if self:GetCanCommunicate() ~= 1 then
		self:DrawWaitingBar(waitingperc)
		draw.SimpleText(translate.Get("comms_interrupted"), "ZS3D2DFontBig", 0, 80, COLOR_DARKRED, TEXT_ALIGN_CENTER)
	end
	cam.End3D2D()
	--cam.IgnoreZ(false)
	render.SuppressEngineLighting(false)
	render.SetColorModulation(1, 1, 1)
	if self:GetCanCommunicate() ~= 1 then return end
	local curtime = CurTime() + self.Seed
	local a = math.abs(math.sin(curtime)) ^ 3
	local hscale = 0.2 + a * 0.04
	if MySelf:IsValid() then
		local colRing = Color(0, 0, 0, 255)
		local frametime = FrameTime() * 500
		local ringtime = (math.sin(curtime*2)+29)/30
		local ringsize = ringtime *150
		local beamsize = 1
		local up = self:GetUp()
		local ang = self:GetForward():Angle()
		ang.yaw = curtime * 60 % 360
		local ringpos = self:GetPos() + up * -30

		render.SetMaterial(matBeam)
		render.StartBeam(19)
		for i=1, 19 do
			render.AddBeam(ringpos + ang:Forward() * ringsize, beamsize, beamsize, teamcolor ~= nil and teamcolor or COLOR_WHITE)
			ang:RotateAroundAxis(up, 20)
		end
		render.EndBeam()
	end

end

function ENT:DrawWaitingBar(percentage)
	local y = 50
	local maxbarwidth = 1028
	local barheight = 180
	local barwidth = maxbarwidth * percentage
	local startx = maxbarwidth * -0.5

	surface.SetDrawColor(0, 0, 0, 220)
	surface.DrawRect(startx, y, maxbarwidth, barheight)
	surface.SetDrawColor(255,255,255,220)
	surface.DrawRect(startx+4, y + 4, barwidth - 8, barheight - 8)
	surface.DrawOutlinedRect(startx, y, maxbarwidth, barheight)
end

function ENT:DrawHealthBar(percentage)
	local y = 250
	local maxbarwidth = 1028
	local barheight = 200
	local barwidth = maxbarwidth * percentage
	local startx = maxbarwidth * -0.5

	surface.SetDrawColor(0, 0, 0, 220)
	surface.DrawRect(startx, y, maxbarwidth, barheight)
	surface.SetDrawColor((1 - percentage) * 255, percentage * 255, 0, 220)
	surface.DrawRect(startx+4, y + 4, barwidth - 8, barheight - 8)
	surface.DrawOutlinedRect(startx, y, maxbarwidth, barheight)
end
