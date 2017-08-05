include("shared.lua")

ENT.NextEmit = 0

function ENT:Draw()
	self:DrawModel()
	local curtime = CurTime()
	if curtime >= self.NextEmit then
		self.NextEmit = curtime + 0.05

		local pos = self:GetPos() + self:GetUp() * 8
		local emitter = ParticleEmitter(pos)
		emitter:SetNearClip(16, 24)

		local particle = emitter:Add("particles/smokey", pos)
		particle:SetVelocity(VectorRand():GetNormalized() * math.Rand(2, 14))
		particle:SetDieTime(math.Rand(0.6, 0.74))
		particle:SetStartAlpha(math.Rand(200, 220))
		particle:SetEndAlpha(0)
		particle:SetStartSize(1)
		particle:SetEndSize(math.Rand(8, 10))
		particle:SetRoll(math.Rand(-0.2, 0.2))
		particle:SetColor(50, 50, 50)

		emitter:Finish()
	end
end
