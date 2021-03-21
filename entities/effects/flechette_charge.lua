EFFECT.LifeTime = 0.1
EFFECT.Size = 32

function EFFECT:Init(data)
	self.DieTime = CurTime() + self.LifeTime

	local normal = data:GetNormal()
	local pos = data:GetOrigin()
	local mag = data:GetMagnitude()

	pos = pos + normal * 2
	self.Pos = pos
	self.Normal = normal
	self.Magnitude = mag
end

function EFFECT:Think()
	return CurTime() < self.DieTime
end

local matRefraction	= Material("refract_ring")
local matGlow = Material("effects/tesla_glow_noz")
local colGlow = Color(255, 35, 35)
function EFFECT:Render()
	local delta = math.Clamp((self.DieTime - CurTime()) / self.LifeTime, 0, 1)
	local rdelta = 1 - delta
	local size = rdelta ^ 0.5 * self.Size
	colGlow.a = rdelta * 255
	colGlow.r = delta * 255
	colGlow.b = colGlow.r - 255

	render.SetMaterial(matGlow)
	render.DrawSprite(self.Pos, self.Size, self.Size, colGlow)
	matRefraction:SetFloat("$refractamount", delta*0.5)
	render.SetMaterial(matRefraction)
	render.UpdateRefractTexture()
	render.DrawSprite(self.Pos, size, size, color_white)
end
