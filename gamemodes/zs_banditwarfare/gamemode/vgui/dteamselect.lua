local function TeamButtonDoClick(self)
	if not (self.Team == TEAM_HUMANS or self.Team == TEAM_BANDITS or self.Team == TEAM_SPECTATOR) then return end
	if self.CannotChoose then 
		surface.PlaySound("buttons/button8.wav")
		GAMEMODE:CenterNotify(COLOR_DARKRED, translate.Get("selected_team_is_full"))
		return 
	end
	surface.PlaySound("buttons/button15.wav")
	RunConsoleCommand("zsb_selectteam", self.Team)
	GAMEMODE:CloseTeamSelectMenu()
end

local PANEL = {}

PANEL.Spacing = 8

local function TeamSelectPaint(self)
	Derma_DrawBackgroundBlur(self, self.Created)
	Derma_DrawBackgroundBlur(self, self.Created)
end

function PANEL:PerformLayout()
	local screenscale = BetterScreenScale()
	self:SetSize(screenscale * 1240, screenscale * 800)
	self:Center()

	self.m_BottomSpace:SetSize(screenscale * 1240, 48)

	self.m_SpecTeamButton:SizeToContents()
	self.m_SpecTeamButton:SetWide(screenscale * 300)
	self.m_SpecTeamButton:SetTall(48)
	self.m_SpecTeamButton:CenterHorizontal()
end


function PANEL:Init()	
	self.Paint = TeamSelectPaint
	self.Created = SysTime()
	local screenscale = BetterScreenScale()

	self.m_BottomSpace = vgui.Create("Panel",self)
	self.m_BottomSpace:DockMargin(0,8,0,0)
	self.m_BottomSpace:Dock(BOTTOM)

    self.m_HTeamButton = vgui.Create("DTeamSelectButton",self)
	self.m_HTeamButton:SetTeam(TEAM_HUMANS)
	self.m_HTeamButton:Dock(LEFT)
    self.m_BTeamButton = vgui.Create("DTeamSelectButton",self)
	self.m_BTeamButton:SetTeam(TEAM_BANDITS)
	self.m_BTeamButton:Dock(RIGHT)

	
	self.m_SpecTeamButton = vgui.Create("DButton", self.m_BottomSpace)
	self.m_SpecTeamButton:SetFont("ZSHUDFontSmaller")
	self.m_SpecTeamButton:SetText(translate.Get("teamname_spectator"))
	self.m_SpecTeamButton.Team = TEAM_SPECTATOR
	self.m_SpecTeamButton.DoClick = TeamButtonDoClick

	self:MakePopup()
end

vgui.Register("DTeamSelectMenu", PANEL, "DPanel")

local PANEL = {}

PANEL.Team = TEAM_UNASSIGNED
PANEL.CannotChoose = false

function PANEL:Think()
	if not GAMEMODE:PlayerCanChooseTeam(MySelf,self.Team) then
		self.CannotChoose = true
	else
		self.CannotChoose = false
	end
end

function PANEL:SetTeam(t)
	if not (t == TEAM_BANDITS or t == TEAM_HUMANS or t == TEAM_SPECTATOR) then return end
	self.Team = t
	self.m_TeamNameLabel:SetText(translate.GetTranslatedTeamName(t))
	local totranslate = ""
	if t == TEAM_BANDITS then
		totranslate = "team_desc_bandit"
	elseif t == TEAM_HUMANS then
		totranslate = "team_desc_human"
	end
	self.m_TeamDescLabel:SetText(translate.Get(totranslate))
end

function PANEL:Init()
	self:DockPadding(4, 8, 4, 8)
	self.DoClick = TeamButtonDoClick	

	self.m_TeamNameLabel = EasyLabel(self, "", "ZSHUDFont", COLOR_WHITE)
	self.m_TeamNameLabel:SetContentAlignment(8)

	self.m_TeamDescLabel = EasyLabel(self, "text", "ZSHUDFontSmallest", COLOR_WHITE)
	self.m_TeamDescLabel:SetContentAlignment(7)
	self.m_TeamDescLabel:SetMultiline(true)
	self.m_TeamDescLabel:SetWrap(true)
end

function PANEL:PerformLayout()
	local screenscale = BetterScreenScale()
	self:SetWide(screenscale * 580)

	self.m_TeamNameLabel:AlignTop(4)
	self.m_TeamNameLabel:SizeToContents()
	self.m_TeamNameLabel:CenterHorizontal()

	self.m_TeamDescLabel:SetWide(screenscale * 500)
	self.m_TeamDescLabel:SetTall(self:GetTall()-(screenscale * 500+self.m_TeamNameLabel:GetTall()+32))
	self.m_TeamDescLabel:MoveBelow(self.m_TeamNameLabel,(screenscale * 500 + 16))
	self.m_TeamDescLabel:CenterHorizontal()
end

function PANEL:Paint()
	local outlinecol
	if self:IsHovered() then
		if self.CannotChoose then
			outlinecol = COLOR_DARKRED
		else
			outlinecol = COLOR_DARKGREEN
		end
	else
		outlinecol = COLOR_DARKGRAY
	end
	draw.RoundedBox(16, 0, 0, self:GetWide(), self:GetTall(), outlinecol)
	draw.RoundedBox(16, 4, 4, self:GetWide()-8, self:GetTall()-8, COLOR_DARKGRAY)
	return true
end

local survivorsthumbnail = Material("vgui/survivors_thumbnail")
local banditsthumbnail = Material("vgui/bandits_thumbnail")
local survivorsthumbnaildisabled = Material("vgui/survivors_thumbnail_disabled")
local banditsthumbnaildisabled = Material("vgui/bandits_thumbnail_disabled")
function PANEL:PaintOver()
	local screenscale = BetterScreenScale()
	local parentteam = self.Team
	if (parentteam == TEAM_HUMANS or parentteam == TEAM_BANDITS) then
		local material = self.CannotChoose and (parentteam == TEAM_HUMANS and survivorsthumbnaildisabled or banditsthumbnaildisabled) or (parentteam == TEAM_HUMANS and survivorsthumbnail or banditsthumbnail)
		local wid = screenscale * 500
		local sidepadding = (screenscale * 580 - screenscale * 500) / 2
		surface.SetMaterial(material)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(sidepadding, self.m_TeamNameLabel:GetTall()+8, wid, wid)
	end
end

vgui.Register("DTeamSelectButton", PANEL, "DButton")

function GM:ShowTeamSelectMenu()
	if self.TeamSelectMenu and self.TeamSelectMenu:Valid() then
		self.TeamSelectMenu:Remove()
	end

	PlayMenuOpenSound()

	self.TeamSelectMenu = vgui.Create("DTeamSelectMenu")
	self.TeamSelectMenu:Center()
end

function GM:CloseTeamSelectMenu()
	if self.TeamSelectMenu and self.TeamSelectMenu:Valid() then
		self.TeamSelectMenu:Remove()
	end
end