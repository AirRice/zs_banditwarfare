AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "status__base"
ENT.LifeTime = 1

function ENT:Initialize()
	self.BaseClass.Initialize(self)
	local owner = self:GetOwner()
	if owner:IsValid() then
		owner.Stunned = self
	end
	if CLIENT then
		hook.Add("RenderScreenspaceEffects", self, self.RenderScreenspaceEffects)
		self.AmbientSound = CreateSound(self, "player/pl_pain6.wav")
		if owner == MySelf then
			self.AmbientSound:Play()
		end
	end
	self.DieTime = CurTime() + self.LifeTime
end

if SERVER then
	function ENT:PlayerSet(pPlayer, bExists)
		pPlayer:Freeze(true)
		pPlayer:SetDSP(31)
		self:SetDTFloat(0, CurTime())
		self:SetDTFloat(1, self.DieTime)
	end
end

function ENT:OnRemove()
	local owner = self:GetOwner()
	if owner.Stunned == self then
		owner.Stunned = nil
	end
	owner:SetDSP(0)
	if SERVER then 
		owner:Freeze(false)
	elseif CLIENT then
		self.AmbientSound:Stop()
	end
end

if not CLIENT then return end

function ENT:Draw()
end

function ENT:CalcView(pl, pos, ang, fov, znear, zfar)
	if self:GetDuration() >= 1 then
		local cycles = math.max(math.ceil(self:GetDuration()/1.5) * 4,1)
		ang.roll = ang.roll + math.ease.InSine(math.Clamp((self:GetDTFloat(1) - CurTime())/self:GetDuration(),0,1) * cycles) * 2
	end
end

function ENT:GetDuration()
	return (self:GetDTFloat(1)-self:GetDTFloat(0))
end

function ENT:GetPower()
	return math.Clamp((self:GetDTFloat(1) - CurTime())/self:GetDuration(), 0, 1)
end

local colModStun = {
	["$pp_colour_colour"] = 1,
	["$pp_colour_brightness"] = 0,
	["$pp_colour_contrast"] = 1.2,
	["$pp_colour_mulr"]	= 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0,
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0
}

function ENT:RenderScreenspaceEffects()
	if LocalPlayer() ~= self:GetOwner() then return end
	DrawMotionBlur(0.4*(self:GetPower()+0.5), 0.5*(self:GetPower()+0.5), 0.01)
	DrawSharpen(2.5*self:GetPower(),1.5*self:GetPower())
	colModStun["$pp_colour_brightness"] = 0.1 - 0.1*(1-self:GetPower())
	colModStun["$pp_colour_contrast"] = 1 + self:GetPower()*0.2
	DrawColorModify(colModStun)
end
