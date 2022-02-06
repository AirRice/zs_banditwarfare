include("shared.lua")

function ENT:Initialize()
	self:DrawShadow(false)

	local owner = self:GetOwner()
	if owner:IsValid() then
		owner.Confusion = self
	end
	hook.Add("CreateMove", self, self.CreateMove)
	hook.Add("RenderScreenspaceEffects", self, self.RenderScreenspaceEffects)

	self.Seed = math.Rand(0, 10)
	self.AmbientSound = CreateSound(self, "player/heartbeat1.wav")
	if owner == MySelf then
		self.AmbientSound:Play()
	end
end

function ENT:Draw()
end

function ENT:CreateMove(cmd)
	if LocalPlayer() ~= self:GetOwner() then return end

	local curtime = CurTime()
	local frametime = FrameTime()
	local power = self:GetPower()

	local ang = cmd:GetViewAngles()
	ang.pitch = math.Clamp(ang.pitch + math.sin(curtime*2) * 20 * frametime * power, -89, 89)
	ang.yaw = math.NormalizeAngle(ang.yaw + math.cos((curtime + self.Seed)*3) * 30 * frametime * power)

	cmd:SetViewAngles(ang)
end
local colModDimVision = {
	["$pp_colour_colour"] = 1,
	["$pp_colour_brightness"] = 0,
	["$pp_colour_contrast"] = 1,
	["$pp_colour_mulr"]	= 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0,
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0
}

function ENT:RenderScreenspaceEffects()
	if LocalPlayer() ~= self:GetOwner() then return end
	local power = self:GetPower()

	local time = CurTime() * 1.5
	local sharpenpower = power * 0.2
	DrawSharpen(sharpenpower, math.sin(time) * 128)
	DrawMotionBlur(0.1 * power, 0.3 * power, 0.01)
	colModDimVision["$pp_colour_brightness"] = -power*0.15
	DrawColorModify(colModDimVision)
end

function ENT:OnRemove()
	local owner = self:GetOwner()
	if owner.Confusion == self then
		owner.Confusion = nil
	end
	if owner == MySelf then
		self.AmbientSound:Stop()
	end

	self.BaseClass.OnRemove(self)
end
