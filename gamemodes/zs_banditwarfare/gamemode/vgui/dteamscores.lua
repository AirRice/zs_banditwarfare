local PANEL = {}


function PANEL:Init()
	self.m_ScoreLabelH = EasyLabel(self, "", "ZSHUDFont", team.GetColor(TEAM_HUMAN))
	self.m_ScoreLabelH:NoClipping(true)
	
	self.m_ProgressBarH = vgui.Create("DGameProgressBar", self)
	self.m_ProgressBarH:SetTeam(TEAM_HUMAN)
	self.m_ProgressBarH:NoClipping(true)
	self.m_ProgressBarH:SetVisible(true)

	self.m_ScoreLabelB = EasyLabel(self, "", "ZSHUDFont", team.GetColor(TEAM_BANDIT))
	self.m_ScoreLabelB:NoClipping(true)

	self.m_ProgressBarB = vgui.Create("DGameProgressBar", self)
	self.m_ProgressBarB:SetTeam(TEAM_BANDIT)
	self.m_ProgressBarB:NoClipping(true)
	self.m_ProgressBarB.Reverse = true
	self.m_ProgressBarB:SetVisible(true)
	 
	self:Refresh()
end

function PANEL:PerformLayout()
	local screenscale = BetterScreenScale()
	local wid = 128 * screenscale
	local hei = 40 * screenscale
	local centremargin = 32 * screenscale
	local parentwidth = self:GetWide()
	local ypos = self:GetY() + 4
	self.m_ProgressBarH:SetSize(wid, hei)
	self.m_ProgressBarH:SetPos(parentwidth*0.5 - centremargin - wid, ypos)
	self.m_ScoreLabelH:SetContentAlignment(6)
	self.m_ScoreLabelH:SizeToContents()

	self.m_ProgressBarB:SetSize(wid, hei)
	self.m_ProgressBarB:SetPos(parentwidth*0.5 + centremargin, ypos)
	self.m_ScoreLabelB:SetContentAlignment(4)
	self.m_ScoreLabelB:SizeToContents()

	self.m_ScoreLabelB:MoveRightOf( self.m_ProgressBarB, 8 )
	self.m_ScoreLabelH:MoveLeftOf( self.m_ProgressBarH, 8 )
end

function PANEL:Paint()
	self.m_ScoreLabelH:SetText(translate.Get("teamname_human").." "..GAMEMODE:GetHumanScore())
	self.m_ScoreLabelB:SetText(GAMEMODE:GetBanditScore().." "..translate.Get("teamname_bandit"))
	if GAMEMODE:GetWaveActive() and not GAMEMODE:IsClassicMode() and not GAMEMODE.IsInSuddenDeath then
		self.m_ProgressBarB:SetVisible(true)
		self.m_ProgressBarH:SetVisible(true)
	else
		self.m_ProgressBarB:SetVisible(false)
		self.m_ProgressBarH:SetVisible(false)
	end
end

function PANEL:Refresh()
	self:InvalidateLayout()
end

vgui.Register("DTeamScores", PANEL, "DPanel")

local PANEL = {}

PANEL.Team = 0
PANEL.Samples = 0
PANEL.Comms = 0
PANEL.Reverse = false
PANEL.MaxComms = 100
PANEL.MaxSamples = 100
function PANEL:SetTeam(team) self.Team = team end
function PANEL:GetTeam() return self.Team end
function PANEL:SetComms(comms) self.Comms = comms end
function PANEL:GetComms() return self.Comms end
function PANEL:SetSamples(samps) self.Samples = samps end
function PANEL:GetSamples() return self.Samples end

function PANEL:Think()
	if GAMEMODE:IsSampleCollectMode() then
		if self:GetTeam() == TEAM_HUMAN then
			self:SetSamples(GAMEMODE:GetHumanSamples())
		elseif self:GetTeam() == TEAM_BANDIT then
			self:SetSamples(GAMEMODE:GetBanditSamples())
		end
	else
		if self:GetTeam() == TEAM_HUMAN then
			self:SetComms(GAMEMODE:GetHumanComms()/2)
		elseif self:GetTeam() == TEAM_BANDIT then
			self:SetComms(GAMEMODE:GetBanditComms()/2)
		end
	end
end

function PANEL:Paint()
	local value = math.Clamp(self:GetComms(),self.Comms,self.MaxComms)
	local col = team.GetColor(self:GetTeam())
	local max = self.MaxComms
	local w, h = self:GetSize()
	local appendstring = "%"
	if GAMEMODE:IsSampleCollectMode() then 
		value = math.Clamp(self:GetSamples(),self.Samples,self.MaxSamples) 
		max = self.MaxSamples
		appendstring = "%"
	end
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(col)
	surface.DrawOutlinedRect(0, 0, w, h)

	local t1 = math.ceil(value)	
	if self.Reverse then 
		surface.DrawRect((1 - math.Clamp(value / max, 0, 1))*(w - 6)+3, 3, (w - 6) * math.Clamp(value / max, 0, 1), h - 6)
		draw.SimpleText(t1..appendstring, "ZSHUDFontSmallNS", 4, h / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	else
		surface.DrawRect(3, 3, (w - 6) * math.Clamp(value / max, 0, 1), h - 6)
		draw.SimpleText(t1..appendstring, "ZSHUDFontSmallNS", w - 4, h / 2, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
	end
end
vgui.Register("DGameProgressBar", PANEL, "Panel")