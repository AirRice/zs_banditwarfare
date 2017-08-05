local PANEL = {}

function PANEL:Init()
	self.SigilIcons = {}
	self.SigilTeams = {}
	self.Sigils = {}
	self:SetTall(64)
	for i = 1, GAMEMODE.MaxSigils  do
		local sigilicon = vgui.Create("DImage", self)
		sigilicon:SetImage("vgui/circle")
		table.insert(self.SigilIcons, sigilicon)
		--sigilicon:SetImageColor(self.SigilTeams[i])
		sigilicon:SetVisible(true)
	end
end

--[[function PANEL:PerformLayout()

end]]

--[[function PANEL:Think()
	if #GAMEMODE.Objectives < GAMEMODE.MaxSigils then return end
	for i = 1, #GAMEMODE.Objectives do
		self.SigilTeams[i] = GAMEMODE.Objectives[i]:GetSigilTeam()
		print(GAMEMODE.Objectives[i]:GetSigilTeam())
	end
	for i = 1, #self.SigilIcons  do
		local sigilicon = self.SigilIcons[i]
		if self.SigilTeams[i] != nil and (self.SigilTeams[i] == TEAM_HUMAN or self.SigilTeams[i] == TEAM_BANDIT) then
			sigilicon:SetImageColor(self.SigilTeams[i])
		else
			sigilicon:SetImageColor(COLOR_WHITE)
		end
	end
end]]

function PANEL:Paint()
	local spacing = self:GetWide() / math.max(1, #self.SigilIcons)
	local tall = self:GetTall()
	for i, sigilicon in ipairs(self.SigilIcons) do
		sigilicon:SetSize(48, 48)
		sigilicon:SetPos((i - 1) * spacing + spacing * 0.5 - (spacing-48) * 0.5  , -48)
		sigilicon:CenterVertical()
	end
end

vgui.Register("PSigilsCounter", PANEL, "Panel")
