function GM:AddHonorableMention(pl, mentionid, ...)
	if not (pEndBoard and pEndBoard:Valid()) then
		MakepEndBoard(ROUNDWINNER)
	end

	local mentiontab = self.HonorableMentions[mentionid]
	if not mentiontab then return end

	local pan = vgui.Create("DEndBoardPlayerPanel", pEndBoard.List)
	pan:SetPlayer(pl, mentiontab.Color and mentiontab.Color or team.GetColor(pl:Team()), translate.Format(mentiontab.TranslateString, mentiontab.Callback(pl, ...)), nil, translate.Format(mentiontab.TranslateName))
	pEndBoard.List:AddItem(pan)
end

function MakepEndBoard(winner)
	if pEndBoard and pEndBoard:IsValid() then
		pEndBoard:Remove()
		pEndBoard = nil
	end

	local wid = 640

	local frame = vgui.Create("DFrame")
	frame:SetWide(wid)
	frame:SetKeyboardInputEnabled(false)
	frame:SetDeleteOnClose(false)
	frame:SetCursor("pointer")
	frame:SetTitle(" ")
	pEndBoard = frame

	local y = 8

	local heading
	local subheading
	if winner == TEAM_HUMAN then
		surface.PlaySound("beams/beamstart5.wav")
		heading = EasyLabel(frame, translate.Get("survivors_victory"), "ZSHUDFont", team.GetColor(TEAM_HUMAN))
		subheading = EasyLabel(frame, translate.Get("survivors_victory_desc"), "ZSHUDFontSmaller", COLOR_WHITE)
	elseif winner == TEAM_BANDIT then
		surface.PlaySound("ambient/levels/streetwar/city_battle"..math.random(3, 5)..".wav")
		heading = EasyLabel(frame, translate.Get("bandits_victory"), "ZSHUDFont", team.GetColor(TEAM_BANDIT))
		subheading = EasyLabel(frame, translate.Get("bandits_victory_desc"), "ZSHUDFontSmaller", COLOR_WHITE)
	else
		surface.PlaySound("ambient/levels/citadel/strange_talk"..math.random(3, 11)..".wav")
		heading = EasyLabel(frame, translate.Get("no_victory"), "ZSHUDFont", COLOR_GRAY)
		subheading = EasyLabel(frame, translate.Get("no_victory_desc"), "ZSHUDFontSmall", COLOR_WHITE)
	end
	heading:SetPos(wid * 0.5 - heading:GetWide() * 0.5, y)
	y = y + heading:GetTall() + 4

	subheading:SetPos(wid * 0.5 - subheading:GetWide() * 0.5, y)
	y = y + subheading:GetTall() + 8

	local starty = y

	local svpan = EasyLabel(frame, "최고의 플레이", "ZSHUDFontSmall", COLOR_WHITE)
	svpan:SetPos(wid * 0.5 - svpan:GetWide() * 0.5, y)
	y = y + svpan:GetTall() + 4

	local list = vgui.Create("DPanelList", frame)
	list:SetSize(wid - 16, 420)
	list:SetPos(8, y)
	list:SetPadding(2)
	list:SetSpacing(2)
	list:EnableVerticalScrollbar()
	y = y + list:GetTall() + 8

	frame.List = list

	frame:SetTall(y)
	frame:Center()

	frame:MakePopup()

	return frame
end

local PANEL = {}
function PANEL:OnMousePressed(mc)
	if mc == MOUSE_LEFT then
		local pl = self:GetPlayer()
		if pl:IsValid() then
			gamemode.Call("ClickedEndBoardPlayerButton", pl, self)
		end
	end
end

function PANEL:Init()
	self:SetSize(200, 40)
end

function PANEL:GetPlayer()
	return self.m_Player or NULL
end

function PANEL:SetPlayer(pl, col, misc, misccol, overridename)
	if self.m_pAvatar then
		self.m_pAvatar:Remove()
		self.m_pAvatar = nil
	end
	if self.m_pName then
		self.m_pName:Remove()
		self.m_pName = nil
	end
	if self.m_pMisc then
		self.m_pMisc:Remove()
		self.m_pMisc = nil
	end

	if pl:IsValid() and pl:IsPlayer() then
		local name = overridename or pl:Name()

		local avatar = vgui.Create("AvatarImage", self)
		avatar:SetPos(4, 4)
		avatar:SetSize(32, 32)
		avatar:SetPlayer(pl)
		self.m_pAvatar = avatar

		local namelab = EasyLabel(self, name, "ZSHUDFontTiny", col)
		namelab:SetPos(40, 4)
		self.m_pName = namelab

		if misc then
			local misclab = EasyLabel(self, misc, nil, misccol)
			misclab:SetPos(40, self:GetTall() - 4 - misclab:GetTall())
		end
	end
end
vgui.Register("DEndBoardPlayerPanel", PANEL, "DPanel")
