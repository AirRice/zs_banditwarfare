include("shared.lua")

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()
	self.Seed = math.Rand(0, 10)
	self:SetRenderMode(RENDERMODE_GLOW)
	self:DrawShadow(false)

	self.AmbientSound = CreateSound(self, "ambient/machines/combine_shield_touch_loop1.wav")
	self.AmbientSound:PlayEx(0.1, 100)
end

function ENT:Think()
	self.AmbientSound:PlayEx(0.1, 100 + RealTime() % 1)
end

function ENT:OnRemove()
	self.AmbientSound:Stop()
end

local matGlow = Material("models/props_combine/stasisshield_sheet")
--Material("models/props_combine/com_shield001a")
--Material("Models/props_combine/combine_fenceglow")
function ENT:DrawTranslucent()
	render.ModelMaterialOverride(matGlow)
	self:DrawModel()
	render.ModelMaterialOverride(0)
end
