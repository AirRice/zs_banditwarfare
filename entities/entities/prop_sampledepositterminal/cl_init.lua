include("shared.lua")

function ENT:Initialize()
	self:SetRenderBounds(Vector(-72, -72, -72), Vector(72, 72, 128))
end

function ENT:Draw()
	self:DrawModel()

	if not MySelf:IsValid() or not (MySelf:Team() == TEAM_HUMAN or MySelf:Team() == TEAM_BANDIT) then return end
	local plyteam = self:GetOwnerTeam()
	local teamcolor = nil
	if plyteam and plyteam ~= nil then 
		teamcolor = team.GetColor(plyteam)
	end
	local vPos = self:GetPos() + self:GetUp()*60
	local vOffset = self:GetForward() * self:OBBMaxs().x
	local eyepos = EyePos()
	local ang = (eyepos - vPos):Angle()
	ang:RotateAroundAxis(ang:Right(), 270)
	ang:RotateAroundAxis(ang:Up(), 90)
end

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.Seed = 0
function ENT:Initialize()
	self:SetRenderBounds(Vector(-128, -128, -128), Vector(128, 128, 200))
	self.AmbientSound = CreateSound(self, "ambient/machines/combine_terminal_loop1.wav")
	self.Seed = math.Rand(0, 10)
end

function ENT:Think()
	if EyePos():Distance(self:GetPos()) <= 1000 then
		self.AmbientSound:PlayEx(1, 135)
	else
		self.AmbientSound:Stop()
	end
end

function ENT:OnRemove()
	self.AmbientSound:Stop()
end

ENT.Rotation = math.random(360)

local matBeam = Material("cable/new_cable_lit")
local cDrawWhite = Color(255, 255, 255)

function ENT:DrawTranslucent()
	self:RemoveAllDecals()
	local curtime = CurTime()
	local eyepos = EyePos()
	local eyeangles = EyeAngles()
	local teamcolor = nil
	if self:GetOwnerTeam() ~= nil then 
		teamcolor = team.GetColor(self:GetOwnerTeam())
	end
	render.SuppressEngineLighting(true)
	self:DrawModel()
	render.SuppressEngineLighting(false)

	local curtime = CurTime() + self.Seed
	if MySelf:IsValid() then
		local ringtime = (math.sin(curtime*2)+19)/20
		local ringsize = ringtime *200
		local beamsize = 6
		local up = self:GetUp()
		local ang = self:GetForward():Angle()
		ang.yaw = curtime * 30 % 360
		local ringpos = self:GetPos()

		render.SetMaterial(matBeam)
		render.StartBeam(40)
		for i=1, 40 do
			render.AddBeam(ringpos + ang:Forward() * ringsize, beamsize, beamsize, teamcolor ~= nil and teamcolor or COLOR_WHITE)
			ang:RotateAroundAxis(up, 20)
		end
		render.EndBeam()
	end

end