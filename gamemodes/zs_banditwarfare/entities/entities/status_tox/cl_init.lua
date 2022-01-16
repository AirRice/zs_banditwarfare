include("shared.lua")
ENT.NextEmit = 0
local function GetRandomBonePos(pl)
	if pl ~= MySelf or pl:ShouldDrawLocalPlayer() then
		local bone = pl:GetBoneMatrix(math.random(0,25))
		if bone then
			return bone:GetTranslation()
		end
	end

	return pl:GetShootPos()
end

function ENT:Draw()
	local ent = self:GetOwner()
	if not ent:IsValid() then return end
	
	local pos
	if ent == MySelf and not ent:ShouldDrawLocalPlayer() then
		local aa, bb = ent:WorldSpaceAABB()
		pos = Vector(math.Rand(aa.x, bb.x), math.Rand(aa.y, bb.y), math.Rand(aa.z, bb.z))
	else
		pos = GetRandomBonePos(ent)
	end

	local emitter = ParticleEmitter(self:GetPos())
	emitter:SetNearClip(24, 32)
	local particle = emitter:Add("particle/smokestack", pos)
	particle:SetVelocity(ent:GetVelocity())
	particle:SetDieTime(math.Rand(0.75, 1.25))
	particle:SetStartAlpha(255)
	particle:SetEndAlpha(0)
	particle:SetStartSize(0)
	particle:SetEndSize(10)
	particle:SetColor(10, 255, 10)
	particle:SetRoll(math.Rand(180, 360))
	particle:SetRollDelta(math.Rand(-4, 4))
	particle:SetGravity(Vector(0, 0, -10))
	particle:SetAirResistance(100)
	
	emitter:Finish()
end
