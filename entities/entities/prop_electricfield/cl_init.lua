include("shared.lua")

ENT.RenderGroup = RENDERGROUP_BOTH
ENT.NextEmit = 0

function ENT:Initialize()
	self.Seed = math.Rand(0, 10)
	self:DrawShadow(false)

	self.AmbientSound = CreateSound(self, "ambient/energy/force_field_loop1.wav")
	self.AmbientSound:PlayEx(0.1, 100)
end

function ENT:Think()
	self.AmbientSound:PlayEx(0.1, 100 + RealTime() % 1)
end

function ENT:OnRemove()
	self.AmbientSound:Stop()
end

local matGlow = Material("Models/effects/comball_sphere")
function ENT:DrawTranslucent()
	render.ModelMaterialOverride(matGlow)
	self:DrawModel()
	render.ModelMaterialOverride(0)
end

function ENT:Draw()
	local time = CurTime()
	local pos = self:GetPos()

	if time < self.NextEmit then return end
	self.NextEmit = time + 1
	self.DoEmit = true

	local emitter = ParticleEmitter(pos)
	emitter:SetNearClip(12, 16)

	for i=1, 30 do
		local dir = VectorRand():GetNormalized()
		particle = emitter:Add("sprites/glow04_noz", pos)
		particle:SetVelocity(dir * 205)
		particle:SetGravity(dir * -210)
		particle:SetDieTime(0.7)
		particle:SetColor(155, 208, 255)
		particle:SetStartAlpha(80)
		particle:SetEndAlpha(0)
		particle:SetStartSize(5)
		particle:SetEndSize(15)
		particle:SetCollide(false)
		particle:SetBounce(0)
	end

	for i=1, 5 do
		local dir = VectorRand():GetNormalized()
		particle = emitter:Add("sprites/glow04_noz", pos)
		particle:SetDieTime(math.Rand(1.8, 2.5))
		particle:SetColor(145,155,255)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(35)
		particle:SetEndSize(0)
		particle:SetGravity(dir * -6)
		particle:SetVelocity(dir * 5)
	end
	emitter:Finish() emitter = nil collectgarbage("step", 64)
end