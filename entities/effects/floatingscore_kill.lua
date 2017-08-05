local messages = {"사살",
}

EFFECT.LifeTime = 3

function EFFECT:Init(data)
	self:SetRenderBounds(Vector(-64, -64, -64), Vector(64, 64, 64))

	self.Seed = math.Rand(0, 10)

	local pos = data:GetOrigin()
	local amount = math.Round(data:GetMagnitude())

	self.Pos = pos
	if amount > 1 then
		self.Message = amount.." 명 사살"
	else
		self.Message = messages[math.random(#messages)]
	end

	self.DeathTime = CurTime() + self.LifeTime
end

function EFFECT:Think()
	self.Pos.z = self.Pos.z + FrameTime() * 32
	return CurTime() < self.DeathTime
end

local col = Color(100, 100, 100, 255)
local col2 = Color(0, 0, 0, 255)
function EFFECT:Render()
	local delta = math.Clamp(self.DeathTime - CurTime(), 0, self.LifeTime) / self.LifeTime
	col.a = delta * 240
	col2.a = col.a
	local ang = EyeAngles()
	local right = ang:Right()
	ang:RotateAroundAxis(ang:Up(), -90)
	ang:RotateAroundAxis(ang:Forward(), 90)
	cam.IgnoreZ(true)
	cam.Start3D2D(self.Pos + math.sin(CurTime() + self.Seed) * 30 * delta * right, ang, (delta * 0.24 + 0.09) / 2)
		draw.SimpleText(self.Message, "ZS3D2DFont2", 0, -21, col, TEXT_ALIGN_CENTER)
	cam.End3D2D()
	cam.IgnoreZ(false)
end
