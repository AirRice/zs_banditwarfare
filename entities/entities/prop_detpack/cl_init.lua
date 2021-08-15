include("shared.lua")

ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:Draw()
	self:DrawModel()
end

local matGlow = Material("sprites/glow04_noz")
local colBlue = Color(100, 100, 255)
function ENT:DrawTranslucent()
	local owner = self:GetObjectOwner()
	local colTeam = Color(255,255,255,255)
	if owner:IsValid() and owner:IsPlayer() and (owner:Team() == TEAM_BANDIT or owner:Team()  == TEAM_HUMAN) then
		colTeam = team.GetColor(owner:Team())
		colTeam.a = 255
	end
	local lightpos = self:GetPos() + self:GetUp() * 8 - self:GetRight() * 2
	local size = GAMEMODE:GetWaveActive() and 16 or 4
	if not self:GetOwner():IsValid() then
		render.SetMaterial(matGlow)
		render.DrawSprite(lightpos, 16, 16, colBlue)
		render.DrawSprite(lightpos, 4, 4, COLOR_WHITE)
	elseif self:GetExplodeTime() == 0 then
		render.SetMaterial(matGlow)
		render.DrawSprite(lightpos, size, size, colTeam)
	else
		local size = (CurTime() * 2.5 % 1) * 24
		render.SetMaterial(matGlow)
		render.DrawSprite(lightpos, size, size, COLOR_RED)
		render.DrawSprite(lightpos, size / 4, size / 4, COLOR_DARKRED)
	end
end
