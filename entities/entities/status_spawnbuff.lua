AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "status__base"

ENT.LifeTime = 5
ENT.OwnerPos = nil
function ENT:Initialize()
	self.BaseClass.Initialize(self)
	if SERVER then
		hook.Add("PlayerShouldTakeDamage", self, self.PlayerShouldTakeDamage)
	end
	if CLIENT then
		hook.Add("PrePlayerDraw", self, self.PrePlayerDraw)
		hook.Add("PostPlayerDraw", self, self.PostPlayerDraw)
	end
	self.DieTime = CurTime() + self.LifeTime
end

function ENT:PlayerShouldTakeDamage( ply, attacker )
	if ply ~= self:GetOwner() then return true end
	return false
end
if SERVER then 
function ENT:Think()
	if self.DieTime <= CurTime() and self.OwnerPos != self:GetOwner():GetPos() then
		self:Remove()
		return
	end
	self.OwnerPos = self:GetOwner():GetPos()
end
end

if not CLIENT then return end
local matWhite = Material("models/debug/debugwhite")
function ENT:PrePlayerDraw(pl)
	if pl ~= self:GetOwner() then return end

	local r = math.abs(math.sin((CurTime() + self:EntIndex()) * 3)) * 0.6
	render.SetColorModulation(r, 0.1, 0.1)
	render.ModelMaterialOverride(matWhite)
end

function ENT:PostPlayerDraw(pl)
	if pl ~= self:GetOwner() then return end

	render.SetColorModulation(1, 1, 1)
	render.ModelMaterialOverride()
end
