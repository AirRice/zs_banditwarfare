AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "status__base"
ENT.LifeTime = 1
function ENT:Initialize()
	self.BaseClass.Initialize(self)
	if CLIENT then
		hook.Add("RenderScreenspaceEffects", self, self.RenderScreenspaceEffects)
	end
	self.DieTime = CurTime() + self.LifeTime
end
if SERVER then
	function ENT:PlayerSet(pPlayer, bExists)
		pPlayer:Freeze(true)
	end

	function ENT:OnRemove()
		local parent = self:GetParent()
		if parent:IsValid() then
			parent:Freeze(false)
		end
	end
end
if not CLIENT then return end

function ENT:Draw()
end

function ENT:GetPower()
	return math.Clamp(self.DieTime - CurTime(), 0, 1)
end

function ENT:RenderScreenspaceEffects()
	if LocalPlayer() ~= self:GetOwner() then return end
	DrawMotionBlur(0.1, self:GetPower() * 0.1, 0.01)
end
