AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "status__base"

ENT.LifeTime = 6
ENT.OwnerPos = nil
function ENT:Initialize()
	self.BaseClass.Initialize(self)
	if CLIENT then
		hook.Add("PrePlayerDraw", self, self.PrePlayerDraw)
		hook.Add("PostPlayerDraw", self, self.PostPlayerDraw)
	end
	self.DieTime = CurTime() + self.LifeTime
end

if SERVER then 
function ENT:Think()
	local numoutsidespawns = 0
	local teamspawns = {}
	teamspawns = team.GetValidSpawnPoint(self:GetOwner():Team())
	for _, ent in pairs(teamspawns) do
		if ent:GetPos():Distance(self:GetOwner():GetPos()) >= 256 and self:GetOwner():Alive() then
			numoutsidespawns = numoutsidespawns + 1
		end
	end
	if (self.DieTime <= CurTime() and (self.OwnerPos != self:GetOwner():GetPos() and numoutsidespawns >= #teamspawns or GAMEMODE:IsClassicMode() or GAMEMODE.SuddenDeath)) or  (self:GetOwner():IsPlayer() and self:GetOwner():KeyPressed(IN_ATTACK)) then
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
