local PANEL = {}

function PANEL:Init()
	self.SigilIcons = {}
	self.Sigils = {}
	self:SetSize(math.min(ScrW(), ScrH()) * 0.4, ScrH() * 0.05)
	self:CenterHorizontal()
	self:AlignBottom(16)
	for i = 1, GAMEMODE.MaxSigils  do
		local sigilicon = vgui.Create("DImage", self)
		sigilicon:SetImage("vgui/circle")
		table.insert(self.SigilIcons, sigilicon)
		--sigilicon:SetImageColor(self.SigilTeams[i])
		sigilicon:SetVisible(false)
	end
end

function PANEL:Paint()
	local spacing = self:GetWide() / math.max(1, #self.SigilIcons)
	local tall = self:GetTall()
	for i, sigilicon in ipairs(self.SigilIcons) do
		sigilicon:SetSize(48, 48)
		sigilicon:SetPos((i - 1) * spacing + (spacing-48)*0.5, 0)
		sigilicon:CenterVertical()
		if GAMEMODE:GetWaveActive() and not GAMEMODE:IsClassicMode() and not GAMEMODE.FilmMode then
			sigilicon:SetVisible(true)
		else 
			sigilicon:SetVisible(false)
		end
	end
	return true
end

vgui.Register("DSigilCounter", PANEL, "DPanel")



--[[function PANEL:PerformLayout()

end]]

function PANEL:UpdateSigilTeams(sigiltable)
	if not istable(sigiltable) then return end
	for i = 1, #self.SigilIcons  do
		local sigilicon = self.SigilIcons[i]
		if sigiltable[i] != nil and (sigiltable[i] == TEAM_HUMAN or sigiltable[i] == TEAM_BANDIT) then
			sigilicon:SetImageColor(team.GetColor(sigiltable[i]))
		else
			sigilicon:SetImageColor(COLOR_WHITE)
		end
	end
end

