local ScoreBoard
function GM:ScoreboardShow()
	gui.EnableScreenClicker(true)
	PlayMenuOpenSound()

	if not ScoreBoard then
		ScoreBoard = vgui.Create("ZSScoreBoard")
	end

	ScoreBoard:SetSize(math.min(ScrW(), ScrH()) * 0.8, ScrH() * 0.85)
	ScoreBoard:AlignTop(ScrH() * 0.05)
	ScoreBoard:CenterHorizontal()
	ScoreBoard:SetAlpha(0)
	ScoreBoard:AlphaTo(255, 0.5, 0)
	ScoreBoard:SetVisible(true)
end

function GM:ScoreboardHide()
	gui.EnableScreenClicker(false)

	if ScoreBoard then
		PlayMenuCloseSound()
		ScoreBoard:SetVisible(false)
	end
end

local PANEL = {}

PANEL.RefreshTime = 2
PANEL.NextRefresh = 0
PANEL.m_MaximumScroll = 0

local function BlurPaint(self)
	draw.SimpleTextBlur(self:GetValue(), self.Font, 0, 0, self:GetTextColor())

	return true
end
local function emptypaint(self)
	return true
end
local function scrollbuttonpaint( w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 100, 0 ))
end
function PANEL:Init()
	self.NextRefresh = RealTime() + 0.1

	self.m_TitleLabel = vgui.Create("DLabel", self)
	self.m_TitleLabel.Font = "ZSScoreBoardTitle"
	self.m_TitleLabel:SetFont(self.m_TitleLabel.Font)
	self.m_TitleLabel:SetText(GAMEMODE.Name)
	self.m_TitleLabel:SetTextColor(COLOR_GRAY)
	self.m_TitleLabel:SizeToContents()
	self.m_TitleLabel:NoClipping(true)
	self.m_TitleLabel.Paint = BlurPaint

	self.m_ServerNameLabel = vgui.Create("DLabel", self)
	self.m_ServerNameLabel.Font = "ZSScoreBoardSubTitle"
	self.m_ServerNameLabel:SetFont(self.m_ServerNameLabel.Font)
	self.m_ServerNameLabel:SetText(GetHostName())
	self.m_ServerNameLabel:SetTextColor(COLOR_GRAY)
	self.m_ServerNameLabel:SizeToContents()
	self.m_ServerNameLabel:NoClipping(true)
	self.m_ServerNameLabel.Paint = BlurPaint

	self.m_AuthorLabel = EasyLabel(self, translate.ClientFormat(self, "scoreboard_gamemode_author", GAMEMODE.Author, GAMEMODE.Email), "DefaultFontSmall", COLOR_GRAY)
	self.m_ContactLabel = EasyLabel(self, GAMEMODE.Website, "DefaultFontSmall", COLOR_GRAY)

	self.m_HumanHeading = vgui.Create("DTeamHeading", self)
	self.m_HumanHeading:SetTeam(TEAM_HUMAN)

	self.m_BanditHeading = vgui.Create("DTeamHeading", self)
	self.m_BanditHeading:SetTeam(TEAM_BANDIT)

	self.BanditList = vgui.Create("DScrollPanel", self)
	self.BanditList.Team = TEAM_BANDIT

	self.HumanList = vgui.Create("DScrollPanel", self)
	self.HumanList.Team = TEAM_HUMAN
	
	self.BottomArea = vgui.Create("DPanel",self)

	self.SpectatorsLabel = EasyLabel(self.BottomArea,translate.ClientGet(MySelf, "teamname_spectator")..":","ZSHUDFontSmallerNS",COLOR_GRAY)
	self.SpectatorsLabel:NoClipping(true)
	self.SpectatorsLabel:SizeToContents()
	
	self.SpectatorList = vgui.Create("DHorizontalScroller",self.BottomArea)
	self.SpectatorList:SetOverlap(-16)
	self:InvalidateLayout()
end

function PANEL:PerformLayout()
	self.m_AuthorLabel:MoveBelow(self.m_TitleLabel)
	self.m_ContactLabel:MoveBelow(self.m_AuthorLabel)

	self.m_ServerNameLabel:SetPos(math.min(self:GetWide() - self.m_ServerNameLabel:GetWide(), self:GetWide() * 0.75 - self.m_ServerNameLabel:GetWide() * 0.5), 32 - self.m_ServerNameLabel:GetTall() / 2)

	self.m_HumanHeading:SetSize(self:GetWide() / 2 - 32, 28)
	self.m_HumanHeading:SetPos(self:GetWide() * 0.25 - self.m_HumanHeading:GetWide() * 0.5, 110 - self.m_HumanHeading:GetTall())

	self.m_BanditHeading:SetSize(self:GetWide() / 2 - 32, 28)
	self.m_BanditHeading:SetPos(self:GetWide() * 0.75 - self.m_BanditHeading:GetWide() * 0.5, 110 - self.m_BanditHeading:GetTall())

	self.HumanList:SetSize(self:GetWide() / 2 - 24, self:GetTall() - 150)
	self.HumanList:AlignBottom(16)
	self.HumanList:AlignLeft(8)

	self.BanditList:SetSize(self:GetWide() / 2 - 24, self:GetTall() - 150)
	self.BanditList:AlignBottom(16)
	self.BanditList:AlignRight(8)
	
	self.BottomArea:AlignBottom(8)
	self.BottomArea:SetSize(self:GetWide()-16,32)
	self.BottomArea:CenterHorizontal()
	
	self.SpectatorsLabel:AlignLeft(8)
	self.SpectatorsLabel:CenterVertical()	

	self.SpectatorList:MoveRightOf(self.SpectatorsLabel,2)
	self.SpectatorList:SetSize(self.BottomArea:GetWide()-(self.SpectatorsLabel:GetWide()+20),32)
end

function PANEL:Think()
	if RealTime() >= self.NextRefresh then
		self.NextRefresh = RealTime() + self.RefreshTime
		self:Refresh()
	end
end

function PANEL:Paint()
	local wid, hei = self:GetSize()
	local barw = 64

	surface.SetDrawColor(5, 5, 5, 180)
	surface.DrawRect(0, 64, wid, hei - 64)
	surface.SetDrawColor(90, 90, 90, 180)
	surface.DrawOutlinedRect(0, 64, wid, hei - 64)

	surface.SetDrawColor(5, 5, 5, 220)
	PaintGenericFrame(self, 0, 0, wid, 64, 32)

	surface.SetDrawColor(30, 30, 30, 200)
	local bottomx,bottomy = self.BottomArea:GetPos()
	surface.DrawRect(0, bottomy, wid, 32)
	surface.SetDrawColor(60, 60, 60, 200)
	surface.DrawOutlinedRect(0, bottomy, wid, 32)

	--[[surface.SetDrawColor(5, 5, 5, 160)
	surface.DrawRect(wid * 0.5 - 16, 64, 32, hei - 128)]]
end

function PANEL:GetPlayerPanel(pl)
	for _, panel in pairs(self.PlayerPanels) do
		if panel:Valid() and panel:GetPlayer() == pl then
			return panel
		end
	end
end

function PANEL:CreatePlayerPanel(pl)
	local curpan = self:GetPlayerPanel(pl)
	if curpan and curpan:Valid() then return curpan end

	local panel = vgui.Create("ZSPlayerPanel", self)
	--[[if pl:Team() == TEAM_BANDIT then
		panel:Dock(TOP)
		panel:SetParent(self.BanditList)
	elseif pl:Team() == TEAM_HUMAN then
		panel:Dock(TOP)
		panel:SetParent(self.HumanList)
	else
		panel:Dock(LEFT)
		panel:SetParent(self.SpectatorList)
	end]]
	panel:SetPlayer(pl)
	panel:DockMargin(8, 2, 8, 2)

	self.PlayerPanels[pl] = panel

	return panel
end

function PANEL:Refresh()
	self.m_ServerNameLabel:SetText(GetHostName())
	self.m_ServerNameLabel:SizeToContents()
	self.m_ServerNameLabel:SetPos(math.min(self:GetWide() - self.m_ServerNameLabel:GetWide(), self:GetWide() * 0.75 - self.m_ServerNameLabel:GetWide() * 0.5), 32 - self.m_ServerNameLabel:GetTall() / 2)
	
	if self.PlayerPanels == nil then self.PlayerPanels = {} end

	for pl, panel in pairs(self.PlayerPanels) do
		if not panel:Valid() then
			self:RemovePlayerPanel(panel)
		end
	end

	for _, pl in pairs(player.GetAll()) do
		self:CreatePlayerPanel(pl)
	end
end

function PANEL:RemovePlayerPanel(panel)
	if panel:Valid() then
		self.PlayerPanels[panel:GetPlayer()] = nil
		panel:Remove()
	end
end

vgui.Register("ZSScoreBoard", PANEL, "Panel")

local PANEL = {}

PANEL.RefreshTime = 1

PANEL.m_Player = NULL
PANEL.NextRefresh = 0

local function MuteDoClick(self)
	local pl = self:GetParent():GetPlayer()
	if pl:IsValid() then
		pl:SetMuted(not pl:IsMuted())
		self:GetParent().NextRefresh = RealTime()
	end
end

local function AvatarDoClick(self)
	local pl = self.PlayerPanel:GetPlayer()
	if pl:IsValid() and pl:IsPlayer() then
		pl:ShowProfile()
	end
end

local function empty() end

function PANEL:Init()
	self:SetTall(32)

	self.m_AvatarButton = self:Add("DButton", self)
	self.m_AvatarButton:SetText(" ")
	self.m_AvatarButton:SetSize(32, 32)
	self.m_AvatarButton:Center()
	self.m_AvatarButton.DoClick = AvatarDoClick
	self.m_AvatarButton.Paint = empty
	self.m_AvatarButton.PlayerPanel = self

	self.m_Avatar = vgui.Create("AvatarImage", self.m_AvatarButton)
	self.m_Avatar:SetSize(32, 32)
	self.m_Avatar:SetVisible(false)
	self.m_Avatar:SetMouseInputEnabled(false)

	self.m_SpecialImage = vgui.Create("DImage", self)
	self.m_SpecialImage:SetSize(16, 16)
	self.m_SpecialImage:SetMouseInputEnabled(true)
	self.m_SpecialImage:SetVisible(false)

	self.m_PlayerLabel = EasyLabel(self, " ", "ZSScoreBoardPlayer", COLOR_WHITE)
	self.m_ScoreLabel = EasyLabel(self, " ", "ZSScoreBoardPlayerSmall", COLOR_WHITE)

	self.m_PingMeter = vgui.Create("DPingMeter", self)
	self.m_PingMeter.PingBars = 5

	self.m_Mute = vgui.Create("DImageButton", self)
	self.m_Mute.DoClick = MuteDoClick
end

local colTemp = Color(255, 255, 255, 220)
function PANEL:Paint()
	local col = color_black_alpha220
	local mul = 0.5
	local pl = self:GetPlayer()
	if pl:IsValid() then
		if (pl:Team() != TEAM_BANDIT and pl:Team() != TEAM_HUMAN) then
			col = COLOR_GRAY
		else
			col = team.GetColor(pl:Team())
			if (GAMEMODE:IsClassicMode() or GAMEMODE.IsInSuddenDeath) and not pl:Alive() then 
				mul = 0.1
			elseif pl == MySelf then
				mul = 0.8
			end
		end
	end

	if self.Hovered then
		mul = math.min(1, mul * 1.5)
	end

	colTemp.r = col.r * mul
	colTemp.g = col.g * mul
	colTemp.b = col.b * mul
	draw.RoundedBox(8, 0, 0, self:GetWide(), self:GetTall(), colTemp)

	return true
end

function PANEL:DoClick()
	local pl = self:GetPlayer()
	if pl:IsValid() then
		gamemode.Call("ClickedPlayerButton", pl, self)
	end
end

function PANEL:PerformLayout()
	self.m_AvatarButton:AlignLeft(16)
	self.m_AvatarButton:CenterVertical()

	self.m_PlayerLabel:SizeToContents()
	self.m_PlayerLabel:MoveRightOf(self.m_AvatarButton, 4)
	self.m_PlayerLabel:CenterVertical()

	self.m_ScoreLabel:SizeToContents()
	self.m_ScoreLabel:SetPos(self:GetWide() * 0.666 - self.m_ScoreLabel:GetWide() / 2, 0)
	self.m_ScoreLabel:CenterVertical()

	self.m_SpecialImage:CenterVertical()

	local pingsize = self:GetTall() - 4

	self.m_PingMeter:SetSize(pingsize, pingsize)
	self.m_PingMeter:AlignRight(8)
	self.m_PingMeter:CenterVertical()

	self.m_Mute:SetSize(16, 16)
	self.m_Mute:MoveLeftOf(self.m_PingMeter, 8)
	self.m_Mute:CenterVertical()
end

function PANEL:Refresh()
	local pl = self:GetPlayer()
	if not pl:IsValid() then
		self:Remove()
		return
	end
	local namelen = 18
	if (self._LastTeam == TEAM_HUMAN or self._LastTeam == TEAM_BANDIT) then
		if GAMEMODE.SimpleScoreBoard or pl:Team() ~= LocalPlayer():Team() then
			self.m_ScoreLabel:SetText(translate.ClientFormat(self, "x_kills_x_deaths", pl:Frags(), pl:Deaths()))
		else
			self.m_ScoreLabel:SetText(translate.ClientFormat(self, "x_kills_x_deaths_x_points", pl:Frags(), pl:Deaths(), pl:GetPoints()))
		end
	else
		namelen = 9
		self.m_ScoreLabel:SetText("")
	end
	
	local name = pl:Name()
	if #name > namelen then
		name = string.sub(name, 1, namelen-2)..".."
	end
	self.m_PlayerLabel:SetText(name)
	
	if pl == LocalPlayer() then
		self.m_Mute:SetVisible(false)
	else
		if pl:IsMuted() then
			self.m_Mute:SetImage("icon16/sound_mute.png")
		else
			self.m_Mute:SetImage("icon16/sound.png")
		end
	end
 
	self:SetZPos(-pl:GetPoints())

	if pl:Team() ~= self._LastTeam then
		local prevparent = self:GetParent()
		self._LastTeam = pl:Team()
		if self._LastTeam == TEAM_HUMAN then
			self:SetWide(ScoreBoard.HumanList:GetWide())
			self:SetParent(ScoreBoard.HumanList)
			self:Dock(TOP)
		elseif self._LastTeam == TEAM_BANDIT then
			self:SetWide(ScoreBoard.BanditList:GetWide())
			self:SetParent(ScoreBoard.BanditList)
			self:Dock(TOP)
		else
			self:SetWide(math.max(ScoreBoard.SpectatorList:GetWide()/4,192))
			ScoreBoard.SpectatorList:AddPanel(self)
			self:Dock(NODOCK)
		end
		prevparent:InvalidateLayout()
	end
	self:InvalidateLayout()
end

function PANEL:Think()
	if RealTime() >= self.NextRefresh then
		self.NextRefresh = RealTime() + self.RefreshTime
		self:Refresh()
	end
end

function PANEL:SetPlayer(pl)
	self.m_Player = pl or NULL

	if pl:IsValid() and pl:IsPlayer() then
		self.m_Avatar:SetPlayer(pl)
		self.m_Avatar:SetVisible(true)

		if gamemode.Call("IsSpecialPerson", pl, self.m_SpecialImage) then
			self.m_SpecialImage:SetVisible(true)
		else
			self.m_SpecialImage:SetTooltip()
			self.m_SpecialImage:SetVisible(false)
		end
	else
		self.m_Avatar:SetVisible(false)
		self.m_SpecialImage:SetVisible(false)
	end

	self.m_PingMeter:SetPlayer(pl)

	self:Refresh()
end

function PANEL:GetPlayer()
	return self.m_Player
end

vgui.Register("ZSPlayerPanel", PANEL, "Button")