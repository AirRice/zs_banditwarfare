EFFECT.Delta = 0

function EFFECT:Init( data )
	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()

	self.StartPos = self:GetTracerShootPos(self.Position, self.WeaponEnt, self.Attachment)
	self.EndPos = data:GetOrigin()

	self.DieTime = CurTime() + 3

	self:SetRenderBoundsWS( self.StartPos, self.EndPos )

	local emitter = ParticleEmitter(self.StartPos)
	emitter:SetNearClip(12, 24)

	for i=1, 2 do
		local particle = emitter:Add("effects/rollerglow", self.StartPos)
		particle:SetDieTime(0.5)
		particle:SetColor(135,135,135)
		particle:SetStartAlpha(178)
		particle:SetEndAlpha(0)
		particle:SetStartSize(0)
		particle:SetEndSize(45)
		particle:SetVelocity(VectorRand():GetNormal() * 1)
	end

	emitter:Finish() emitter = nil collectgarbage("step", 64)
end

function EFFECT:Think( )
	self.Delta = math.Clamp((self.DieTime - CurTime())/3,0,1)
	return CurTime() < self.DieTime
end

local beammat = Material("trails/smoke")
local beam1mat = Material("sprites/tp_beam001")

function EFFECT:Render()
	local texcoord = math.Rand(0, 1)

	local emitter = ParticleEmitter(self.EndPos)
	emitter:SetNearClip(24, 32)
	if self.Delta > 0.9 then
		local particle = emitter:Add("sprites/heatwave", self.EndPos - (self.EndPos - self.StartPos) * math.Clamp(self.Delta-0.9,0,0.1)*10)
		local vel = Vector( 0, 0, 1 )
		particle:SetDieTime(1)
		particle:SetColor(66, 197, 255)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(10)
		particle:SetEndSize(0)
	end
	emitter:Finish() emitter = nil collectgarbage("step", 64)
	
	local norm = (self.StartPos - self.EndPos)
	local nlen = norm:Length()
	render.SetMaterial(beammat)
	render.DrawBeam(self.StartPos, self.EndPos, 8, texcoord, texcoord + nlen / 128, Color(55, 55, 55, 205 * self.Delta))
	render.SetMaterial(beam1mat)
	render.DrawBeam(self.StartPos, self.EndPos, 4, texcoord, texcoord + nlen / 128, Color(66, 197, 255, 255 * self.Delta))
end