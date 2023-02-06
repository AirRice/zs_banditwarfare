function MakepPlayerModel()
	if GAMEMODE.m_pPlayerModel and GAMEMODE.m_pPlayerModel:Valid() then GAMEMODE.m_pPlayerModel:Close() end

	PlayMenuOpenSound()

	GAMEMODE.m_pPlayerModel = vgui.Create("DModelSelectFrame")
end

PANEL = {}

local function resetPlayerModelDoClick()
	if GAMEMODE.m_pPlayerModel and GAMEMODE.m_pPlayerModel:IsValid() then
		local pmpanel = GAMEMODE.m_pPlayerModel
		surface.PlaySound("buttons/button17.wav")
		RunConsoleCommand("zsb_preferredsurvivormodel", "")
		RunConsoleCommand("zsb_preferredbanditmodel", "")
		pmpanel.m_HumanPanel.m_ModelDropDown:SetText("")
		pmpanel.m_BanditPanel.m_ModelDropDown:SetText("")
		pmpanel.m_HumanPanel:UpdateSelectedModel("")
		pmpanel.m_BanditPanel:UpdateSelectedModel("")
	end
end

function PANEL:PerformLayout()
	local screenscale = BetterScreenScale()
	local wid = math.min(ScrW(), 1000) * screenscale
	local sidemargin = 4

	self.m_TopSpace:SetWide(wid)
	self.m_TopSpace:SetTall(36)
	self.m_TopSpace:Dock(TOP)
	self.m_TopSpace:CenterHorizontal()	
	
	self.m_TopSpaceLabel:SetTall(36)
	self.m_TopSpaceLabel:SetWide(256*screenscale)
	self.m_TopSpaceLabel:SetContentAlignment(4)
	self.m_TopSpaceLabel:AlignLeft(8)
	self.btnClose:SetTall(36)
	self.btnClose:SetWide(128*screenscale)
	self.btnClose:SetContentAlignment(5)
	self.btnClose:AlignRight(8)

	self.m_ResetPMButton:SetTall(36)
	self.m_ResetPMButton:SetWide(256*screenscale)
	self.m_ResetPMButton:SetContentAlignment(5)
	self.m_ResetPMButton:MoveLeftOf(self.btnClose, 8)

	self.m_HumanPanel:SetWide(wid*0.5 - sidemargin*2)
	self.m_HumanPanel:DockMargin(sidemargin, 4, sidemargin, 4)
	self.m_HumanPanel:Dock(LEFT)
	
	self.m_BanditPanel:SetWide(wid*0.5 - sidemargin*2)
	self.m_BanditPanel:SetTall(self.m_HumanPanel:GetTall())
	self.m_BanditPanel:DockMargin(sidemargin, 4, sidemargin, 4)
	self.m_BanditPanel:Dock(RIGHT)
end

function PANEL:Init()
	local screenscale = BetterScreenScale()
	local wid, hei = math.min(ScrW(), 1000) * screenscale, math.min(ScrH(), 600) * screenscale
	self.ColorOverride = Color(30, 30, 30, 255)
	self:SetSize(wid, hei)
	self:SetDeleteOnClose(true)
	self:SetTitle(" ")
	self:SetDraggable(false)
	if self.btnClose and self.btnClose:Valid() then self.btnClose:SetVisible(false) end
	if self.btnMinim and self.btnMinim:Valid() then self.btnMinim:SetVisible(false) end
	if self.btnMaxim and self.btnMaxim:Valid() then self.btnMaxim:SetVisible(false) end

	local closeclick = self.btnClose.DoClick

	local topspace = vgui.Create("DPanel", self)
	self.m_TopSpace = topspace

	self.m_TopSpaceLabel = EasyLabel(topspace, translate.Get("select_playermodel"), "ZSHUDFontSmallNS", color_white)

	local closebutton = EasyButton(topspace, translate.Get("close_button"))
	closebutton:SetFont("ZSHUDFontSmallest")
	closebutton.DoClick = function() closeclick() end
	self.btnClose = closebutton

	local resetpmbutton = EasyButton(topspace, translate.Get("reset_playermodel_button"))
	resetpmbutton:SetFont("ZSHUDFontSmallest")
	resetpmbutton.DoClick = resetPlayerModelDoClick
	self.m_ResetPMButton = resetpmbutton


	local humanpanel = vgui.Create("DTeamModelSelect",self)
	self.m_HumanPanel = humanpanel
	self.m_HumanPanel.Team = TEAM_HUMAN

	local banditpanel = vgui.Create("DTeamModelSelect",self)
	self.m_BanditPanel = banditpanel
	self.m_BanditPanel.Team = TEAM_BANDIT

	self:Center()
	self:MakePopup()
end

vgui.Register("DModelSelectFrame", PANEL, "DFrame")

PANEL = {}

local function OnModelOptionSelect(team, index, val, data)
	if not (team==TEAM_BANDIT or team==TEAM_HUMAN) then return end
	RunConsoleCommand("zsb_preferred"..(team==TEAM_HUMAN and "survivor" or "bandit").."model", val)
end

function PANEL:PerformLayout()
	self.m_TeamNameLabel:SetContentAlignment(5)
	self.m_TeamNameLabel:AlignTop(4)
	self.m_TeamNameLabel:SetTall(24)
	self.m_TeamNameLabel:SetWide(self:GetWide())
	self.m_TeamNameLabel:CenterHorizontal()

	self.m_ModelDropDown:MoveBelow(self.m_TeamNameLabel, 8)
	self.m_ModelDropDown:SetTall(32)
	self.m_ModelDropDown:SetWide(self:GetWide())
	self.m_ModelDropDown:CenterHorizontal()

	self.m_ModelViewer:MoveBelow(self.m_ModelDropDown, 8)
	self.m_ModelViewer:SetTall(self:GetTall() - self.m_TeamNameLabel:GetTall() - self.m_ModelDropDown:GetTall() - 32)
	self.m_ModelViewer:SetWide(self:GetWide())
	self.m_ModelViewer:CenterHorizontal()

	self.m_ModelViewerRandomLabel:MoveBelow(self.m_ModelDropDown, 8)
	self.m_ModelViewerRandomLabel:SetTall(self:GetTall() - self.m_TeamNameLabel:GetTall() - self.m_ModelDropDown:GetTall() - 32)
	self.m_ModelViewerRandomLabel:SetWide(self:GetWide())
	self.m_ModelViewerRandomLabel:CenterHorizontal()
	self.m_ModelViewerRandomLabel:SetContentAlignment(5)
end

function PANEL:Init()
	self.Team = TEAM_UNASSIGNED

	self.m_TeamNameLabel = EasyLabel(self, "", "ZSHUDFontSmallNS", color_white)

	local dropdown = vgui.Create("DComboBoxEx", self)
	dropdown:SetMouseInputEnabled(true)
	dropdown.OnSelect = function(me, index, value, data)
		OnModelOptionSelect(self.Team, index, value, data)
		self:UpdateSelectedModel(value)
	end
	self.m_ModelDropDown = dropdown

	local modelview = vgui.Create( "DModelPanel", self )

	self.m_ModelViewer = modelview

	self.m_ModelViewerRandomLabel = EasyLabel(self, translate.Get("random_model"), "ZSHUDFontNS", COLOR_WHITE)
end

function PANEL:UpdateSelectedModel(curmodelstr)
	if curmodelstr == "" then 
		self.m_ModelViewer:SetVisible(false)
		self.m_ModelViewerRandomLabel:SetVisible(true)
		return
	end

	self.m_ModelViewer:SetVisible(true)
	self.m_ModelViewerRandomLabel:SetVisible(false)
	local curmodel = player_manager.TranslatePlayerModel(curmodelstr)

	self.m_ModelViewer:SetModel(curmodel)

	local teamcol = team.GetColor(self.Team)
	local teamcolvec = Vector(teamcol.r/255, teamcol.g/255, teamcol.b/255)
	local modelentity = self.m_ModelViewer:GetEntity()
	function modelentity:GetPlayerColor() return teamcolvec end
end

function PANEL:Think()
	if self.Team == self.m_CachedTeam then 
		return
	elseif (self.Team == TEAM_BANDIT or self.Team == TEAM_HUMAN) then
		self.m_CachedTeam = self.Team
		self.m_TeamNameLabel:SetText((self.Team == TEAM_HUMAN and translate.Get("teamname_human") or translate.Get("teamname_bandit")))
		self.m_ModelDropDown:Clear()
		local modellist = (self.Team == TEAM_HUMAN and GAMEMODE.RandomSurvivorModels or GAMEMODE.RandomBanditModels)
		local curmodelstr = MySelf:GetInfo("zsb_preferred"..(self.Team==TEAM_HUMAN and "survivor" or "bandit").."model")
		for _, mdl in pairs(modellist) do
			self.m_ModelDropDown:AddChoice(mdl,nil,(curmodelstr ~= "" and mdl == curmodelstr))
		end

		self:UpdateSelectedModel(curmodelstr)
	end
end

vgui.Register("DTeamModelSelect", PANEL, "Panel")