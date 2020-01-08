include("shared.lua")

function ENT:Initialize()
	self:SetRenderBounds(Vector(-72, -72, -72), Vector(72, 72, 128))
end

function ENT:Draw()
	self:DrawModel()

	if not MySelf:IsValid() or not (MySelf:Team() == TEAM_HUMAN or MySelf:Team() == TEAM_BANDIT) then return end
	local plyteam = self:GetOwnerTeam()
	local teamcolor = nil
	if plyteam and plyteam ~= nil then 
		teamcolor = team.GetColor(plyteam)
	end
	local vPos = self:GetPos() + self:GetUp()*60
	local vOffset = self:GetForward() * self:OBBMaxs().x
	local eyepos = EyePos()
	local ang = (eyepos - vPos):Angle()
	ang:RotateAroundAxis(ang:Right(), 270)
	ang:RotateAroundAxis(ang:Up(), 90)
end
