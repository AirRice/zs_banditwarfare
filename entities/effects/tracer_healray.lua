function EFFECT:Init( data )
	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	self.Mode = data:GetFlags()
	self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )
	self.EndPos = data:GetOrigin()

	self.Life = 0

	self:SetRenderBoundsWS( self.StartPos, self.EndPos )
end

function EFFECT:Think( )
	self.Life = self.Life + FrameTime() * 3 -- Effect should dissipate before the next one.
	self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )

	return (self.Life < 1)
end

local beamcoremat = Material("trails/plasma")
local beammat = Material("trails/smoke")
local glowmat = Material("sprites/light_glow02_add")
EFFECT.LastEmit = 0
function EFFECT:Render()
	local norm = (self.StartPos - self.EndPos) * self.Life
	local nlen = norm:Length()
	local beamspeed = nlen/100
	local alpha = (1 - self.Life) * 0.2

	local vec = Vector(math.cos(CurTime() * 0.75) * 4, math.sin(CurTime() * 0.75) * 6, 0)
	local cubicone = CosineInterpolation(self.StartPos - vec * 1, self.EndPos, 0.3)
	local cubictwo = CosineInterpolation(cubicone, self.EndPos - vec * 1, 0.4)

	local cubiconenorm = (cubicone - cubictwo)
	local colr = self.Mode == 1 and 150 or 255
	local colg = self.Mode == 1 and 255 or 150
	--render.DepthRange( 0, 0.01 )
	render.SetMaterial(beamcoremat)
	for i = 0, 4 do
		render.DrawBeam(self.StartPos, cubicone, 8, CurTime()*beamspeed, CurTime()*beamspeed-1, Color(colr, colg, 130, 255 * alpha))
		render.DrawBeam(cubicone, cubictwo, 8, CurTime()*beamspeed, CurTime()*beamspeed-1, Color(colr, colg, 130, 255 * alpha))
		render.DrawBeam(cubictwo, self.EndPos, 8, CurTime()*beamspeed, CurTime()*beamspeed-1, Color(colr, colg, 130, 255 * alpha))
	end
	render.SetMaterial(beammat)
	render.DrawBeam(self.StartPos, cubicone, 14, CurTime()*beamspeed, CurTime()*beamspeed-2, Color(colr, colg, 190, 180 * alpha))
	render.DrawBeam(cubicone, cubictwo, 14, CurTime()*beamspeed, CurTime()*beamspeed-2, Color(colr, colg, 190, 180 * alpha))
	render.DrawBeam(cubictwo, self.EndPos, 14, CurTime()*beamspeed, CurTime()*beamspeed-2, Color(colr, colg, 190, 180 * alpha))
	render.SetMaterial(glowmat)
	render.DrawSprite(self.StartPos, 30, 30, Color(colr, colg, 190, 148 * alpha))
	--render.DepthRange( 0, 1)
	render.DrawSprite(self.EndPos, 30, 30, Color(colr, colg, 190, 148 * alpha))

end
