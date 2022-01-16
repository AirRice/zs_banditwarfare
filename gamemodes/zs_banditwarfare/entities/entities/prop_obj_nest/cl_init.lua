include("shared.lua")

ENT.Seed = 0
ENT.Tall = 0
ENT.NextSound = 0
function ENT:Initialize()
	self:SetRenderBounds(Vector(-128, -128, -128), Vector(128, 128, 512))
	self:ManipulateBoneScale(0, self.ModelScale)	
	self.AmbientSound = CreateSound(self, "ambient/levels/citadel/citadel_drone_loop5.wav")
	self.Seed = math.Rand(0, 10)
end

local EmitSounds = {
	Sound("physics/flesh/flesh_squishy_impact_hard1.wav"),
	Sound("physics/flesh/flesh_squishy_impact_hard2.wav"),
	Sound("physics/flesh/flesh_squishy_impact_hard3.wav"),
	Sound("physics/flesh/flesh_squishy_impact_hard4.wav"),
	Sound("npc/barnacle/barnacle_die1.wav"),
	Sound("npc/barnacle/barnacle_die2.wav"),
	Sound("npc/barnacle/barnacle_digesting1.wav"),
	Sound("npc/barnacle/barnacle_digesting2.wav"),
	Sound("npc/barnacle/barnacle_gulp1.wav"),
	Sound("npc/barnacle/barnacle_gulp2.wav")
}

function ENT:Think()
	self.Tall = math.Approach(self.Tall, math.Clamp(self:GetNestHealth() / self:GetNestMaxHealth()*0.7+0.3, 0.3, 1), FrameTime())
	if math.random(10) == 1 and self.NextSound <= CurTime() then
		self:EmitSound(EmitSounds[math.random(#EmitSounds)], 65, math.random(95, 105))
		self.NextSound = CurTime() + 1
	end
	self.AmbientSound:PlayEx(0.6, 100 + CurTime() % 1)
end

function ENT:OnRemove()
	self.AmbientSound:Stop()
end

ENT.NextEmit = 0
local gravParticle = Vector(0, 0, -200)
local matFlesh = Material("models/flesh")
local matWhite = Material("models/debug/debugwhite")
local matGlow = Material("sprites/light_glow02_add")
local matBeam = Material("cable/new_cable_lit")
local r, g = 0, 0
local colRing = Color(0, 0, 0, 255)
function ENT:Draw()
	local curtime = CurTime() + self.Seed
	local a = math.abs(math.sin(curtime)) ^ 3
	local hscale = 0.2 + a * 0.04
	local dlight = DynamicLight(self:EntIndex())
	if dlight then
		dlight.Pos = self:GetPos()
		if teamcolor ~= nil then
			dlight.r = 255
			dlight.g = 0
			dlight.b = 0
		end
		dlight.Brightness = 3
		dlight.Size = 200
		dlight.Decay = 200
		dlight.DieTime = curtime + 1
	end
	render.ModelMaterialOverride(matFlesh)

	self:ManipulateBoneScale(0, Vector(hscale, hscale, (0.2 - a * 0.005) * self.Tall))
	self:DrawModel()

	render.SetColorModulation(1, 1, 1)
	render.ModelMaterialOverride()

	if MySelf:IsValid() then
		local colRing = Color(0, 0, 0, 255)
		local frametime = FrameTime() * 500
		local ringtime = (math.sin(curtime*2)+4)/5
		local ringsize = ringtime *150
		local beamsize = 10
		local up = self:GetUp()
		local ang = self:GetForward():Angle()
		ang.yaw = curtime * 360 % 360
		local ringpos = self:GetPos() + up * 4

		render.SetMaterial(matBeam)
		render.StartBeam(19)
		for i=1, 19 do
			render.AddBeam(ringpos + ang:Forward() * ringsize, beamsize, beamsize, COLOR_DARKRED)
			ang:RotateAroundAxis(up, 20)
		end
		render.EndBeam()
	end
end