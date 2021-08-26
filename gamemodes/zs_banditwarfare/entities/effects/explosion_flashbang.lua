EFFECT.LifeTime = 7

EFFECT.NextEmit = 0

function EFFECT:Init(data)
	local pos = data:GetOrigin()
	self:EmitSound("weapons/flashbang/flashbang_explode"..math.random(1,2)..".wav")
	local dlight = DynamicLight(0)
	if dlight then
		dlight.Pos = pos
		dlight.r = 255
		dlight.g = 255
		dlight.b = 255
		dlight.Brightness = 13
		dlight.Size = 700
		dlight.Decay = 4000
		dlight.DieTime = CurTime() + 0.5
	end
end