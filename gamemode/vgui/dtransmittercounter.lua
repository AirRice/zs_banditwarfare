local PANEL = {}

function PANEL:Init()
	self.TransmitterIcons = {}
	self.Transmitters = {}
	self:SetSize(math.min(ScrW(), ScrH()) * 0.4, ScrH() * 0.05)
	self:CenterHorizontal()
	self:AlignBottom(16)
	for i = 1, GAMEMODE.MaxTransmitters  do
		local icon = vgui.Create("DImage", self)
		icon:SetImage("vgui/circle")
		icon:SetVisible(false)
		table.insert(self.TransmitterIcons, icon)
	end
end

function PANEL:Paint()
	local spacing = self:GetWide() / math.max(1, #self.TransmitterIcons)
	local tall = self:GetTall()
	for i, icon in ipairs(self.TransmitterIcons) do
		icon:SetSize(48, 48)
		icon:SetPos((i - 1) * spacing + (spacing-48)*0.5, 0)
		icon:CenterVertical()
		if GAMEMODE:GetWaveActive() and not GAMEMODE:IsClassicMode() and not GAMEMODE.FilmMode and not GAMEMODE.IsInSuddenDeath and not GAMEMODE:IsSampleCollectMode() then
			icon:SetVisible(true)
		else 
			icon:SetVisible(false)
		end
	end
	return true
end

--[[function PANEL:PerformLayout()

end]]

function PANEL:UpdateTransmitterTeams(objtable)
	if not istable(objtable) then return end
	for i = 1, #self.TransmitterIcons  do
		local icon = self.TransmitterIcons[i]
		if objtable[i] != nil and (objtable[i] == TEAM_HUMAN or objtable[i] == TEAM_BANDIT) then
			icon:SetImageColor(team.GetColor(objtable[i]))
		else
			icon:SetImageColor(COLOR_WHITE)
		end
	end
end


vgui.Register("DTransmitterCounter", PANEL, "DPanel")