AddCSLuaFile()

ENT.Type = "anim"
ENT.LifeTime = 2

ENT.NoPropDamageDuringWave0 = true
ENT.NextEmit = 0
ENT.m_IsProjectile = true

util.PrecacheSound("physics/metal/metal_grenade_impact_hard1.wav")
util.PrecacheSound("physics/metal/metal_grenade_impact_hard2.wav")
util.PrecacheSound("physics/metal/metal_grenade_impact_hard3.wav")

function ENT:Initialize()
	self.DieTime = CurTime() + self.LifeTime
	if SERVER then
		self:SetModel("models/weapons/w_eq_smokegrenade_thrown.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
		end
	end
end

function ENT:Explode()
   if CLIENT then
		self:CreateSmoke()
   else
		if self.Exploded then return end
		local owner = self:GetOwner()
		self:EmitSound("HL1/ambience/steamburst1.wav")
		self.Exploded = true
		self:Remove()
   end
end

function ENT:PhysicsCollide(data, phys)
	if 20 < data.Speed and 0.25 < data.DeltaTime then
		self:EmitSound("physics/metal/metal_grenade_impact_hard"..math.random(1,3)..".wav")
	end
end

function ENT:Think()
	if self.Exploded then
		self:Remove()
	elseif self.DieTime <= CurTime() then
		self:Explode()
	end
	if CLIENT then
		local curtime = CurTime()

		if curtime >= self.NextEmit then
			self.NextEmit = curtime + 0.05
			local pos = self:GetPos() + self:GetUp() * 8
			local emitter = ParticleEmitter(pos)
			emitter:SetNearClip(16, 24)

			local particle = emitter:Add("particles/smokey", pos)
			particle:SetVelocity(VectorRand():GetNormalized() * math.Rand(1, 14))
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
end

if CLIENT then
function ENT:CreateSmoke()
    local pos = self:GetPos()
	local emitter = ParticleEmitter(pos)
	emitter:SetNearClip(16, 24)
    local r = 20
	local prpos = VectorRand() * r
	prpos.z = prpos.z + 32
	
    for i=1, 10 do
		local gray = math.random(75, 200)
		local particle = emitter:Add("particle/particle_smokegrenade", pos+ prpos)
		particle:SetVelocity(VectorRand():GetNormalized() * math.Rand(500, 1500))
		particle:SetLifeTime(0)
		particle:SetDieTime(math.Rand(50, 70))
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(250)
		particle:SetStartSize(math.random(180, 210))
		particle:SetEndSize(math.random(1, 40))
		particle:SetRoll(math.random(-180, 180))
		particle:SetColor(gray, gray, gray)
		particle:SetAirResistance(600)
		particle:SetCollide(true)
		particle:SetBounce(0.4)
		particle:SetLighting(false)
	end
	emitter:Finish()
end

function ENT:Draw()
	self:DrawModel()
end
end