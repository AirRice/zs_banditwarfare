ENT.Type = "anim"
ENT.Base = "status__base"
ENT.LifeTime = 5

function ENT:GetPower()
	local curtime = CurTime()
	local power = math.Clamp(math.min(self:GetDTFloat(1) - curtime, curtime - self:GetDTFloat(0))/((self:GetDTFloat(1)-self:GetDTFloat(0))/2),0,1)
	return power
end