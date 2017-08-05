function EFFECT:Init(data)
	local pos = data:GetOrigin()
	local norm = data:GetNormal()

	for i=0, math.random(2, 3) do
		timer.SimpleEx(i * math.Rand(0.1, 0.3), sound.Play, "ambient/energy/zap"..math.random(5, 9)..".wav", pos, 77, math.Rand(90, 110))
	end

	local emitter = ParticleEmitter(pos)

	for i=1, 12 do
		local particle = emitter:Add("effects/stunstick", pos)
		local heading = VectorRand():GetNormalized()
		particle:SetVelocity(heading * 256 + VectorRand() * 46)
		particle:SetDieTime(math.Rand(0.5, 1.5))
		particle:SetStartAlpha(240)
		particle:SetEndAlpha(0)
		particle:SetStartSize(math.Rand(13, 14))
		particle:SetEndSize(math.Rand(10, 12))
		particle:SetRoll(180)
		particle:SetDieTime(3)
		particle:SetColor(255, 255, 255)
		particle:SetLighting(true)
	end

	local particle = emitter:Add("effects/stunstick", pos)
	local heading = VectorRand():GetNormalized()
	particle:SetVelocity(heading * 256 + VectorRand() * 46)
	particle:SetDieTime(math.Rand(0.25, 1))
	particle:SetStartAlpha(240)
	particle:SetEndAlpha(0)
	particle:SetStartSize(math.Rand(28, 32))
	particle:SetEndSize(math.Rand(14, 28))
	particle:SetRoll(180)
	particle:SetColor(255, 255, 255)
	particle:SetLighting(true)

	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
