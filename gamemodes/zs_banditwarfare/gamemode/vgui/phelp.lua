GM.Help = {
{Name = "help_cat_introduction",
Content = "help_cont_introduction"},

{Name = "help_cat_keys",
Content = "help_cont_keys"},

{Name = "help_cat_upgrades",
Content = "help_cont_upgrades"},

{Name = "help_cat_tips",
Content = "help_cont_tips"},

{Name = "help_cat_barricading",
Content = "help_cont_barricading"}
}

GM.RoundModeHelp = {
	[ROUNDMODE_TRANSMISSION] = "help_cont_introduction_transmission",
	[ROUNDMODE_SAMPLES] = "help_cont_introduction_collection",
	[ROUNDMODE_CLASSIC] = "help_cont_introduction_deathmatch"
}

function MakepCredits()
	PlayMenuOpenSound()
	local screenscale = BetterScreenScale()
	local wid = math.min(ScrW(), 800) * screenscale

	local y = 8

	local frame = vgui.Create("DEXRoundedFrame")
	frame:SetColorAlpha(250)
	frame:SetWide(wid)
	frame:SetTitle(" ")
	frame:SetKeyboardInputEnabled(false)

	local label = EasyLabel(frame, translate.Get("credits_window_title"), "ZSHUDFontNS", color_white)
	label:AlignTop(y)
	label:CenterHorizontal()
	y = y + label:GetTall() + 8

	for authorindex, authortab in ipairs(GAMEMODE.Credits) do
		local lineleft = EasyLabel(frame, string.Replace(translate.Get(authortab[1]), "@", "(at)"), "ZSHUDFontSmallestNS", color_white)
		local linemid = EasyLabel(frame, "-", "ZSHUDFontSmallestNS", color_white)
		local lineright = EasyLabel(frame, translate.Get(authortab[3]), "ZSHUDFontSmallestNS", color_white)
		local linesub
		if authortab[2] then
			linesub = EasyLabel(frame, authortab[2], "DefaultFont", color_white)
		end

		lineleft:AlignLeft(8)
		lineleft:AlignTop(y)
		lineright:AlignRight(8)
		lineright:AlignTop(y)
		linemid:CenterHorizontal()
		linemid:AlignTop(y)

		y = y + lineleft:GetTall()
		if linesub then
			linesub:AlignTop(y)
			linesub:AlignLeft(8)
			y = y + linesub:GetTall()
		end
		y = y + 10
	end

	frame:SetTall(y + 8)
	frame:Center()
	frame:SetAlpha(0)
	frame:AlphaTo(255, 0.5, 0)
	frame:MakePopup()
end

function MakepHelp()
	PlayMenuOpenSound()

	if pHelp then
		pHelp:SetAlpha(0)
		pHelp:AlphaTo(255, 0.5, 0)
		pHelp:SetVisible(true)
		pHelp:MakePopup()
		return
	end

	local wide, tall = math.min(ScrW(), 1024), math.min(ScrH(), 768)

	local Window = vgui.Create("DFrame")
	Window:SetSize(wide, tall)
	Window:Center()
	Window:SetTitle(" ")
	Window:SetDraggable(false)
	Window:SetDeleteOnClose(false)
	Window:SetKeyboardInputEnabled(false)
	Window:SetCursor("pointer")
	pHelp = Window

	local label = EasyLabel(Window, translate.Get("button_help"), "ZSHUDFont", color_white)
	label:CenterHorizontal()
	label:AlignTop(8)

	local propertysheet = vgui.Create("DPropertySheet", Window)
	propertysheet:StretchToParent(12, 52, 12, 64)

	for _, helptab in ipairs(GAMEMODE.Help) do
		local content_translated = (helptab.Name == "help_cat_introduction") and (translate.Get(helptab.Content)..translate.Get(GAMEMODE.RoundModeHelp[GetGlobalInt("roundgamemode", 0)])) or translate.Get(helptab.Content)
		local htmlpanel = vgui.Create("DHTML", propertysheet)
		htmlpanel:StretchToParent(4, 4, 4, 24)
		htmlpanel:SetHTML([[<html>
		<head>
		<style type="text/css">
		body
		{
			font-family:tahoma;
			font-size:16px;
			color:white;
			background-color:black;
			width:]].. htmlpanel:GetWide() - 48 ..[[px;
		}
		div p
		{
			margin:10px;
			padding:2px;
		}
		ul li{
			margin:10px 0px 10px 0px;
		}
		table{
			width: 100%;
			margin-left: auto;
			margin-right: auto;
			text-align:center;
			border-collapse: collapse;
		}
		th, td{
			border: 2px solid white;
		}
		table caption{
			font-size:200%;
		}
		</style>
		</head>
		<body>
<center><span style="font-size:26px;font-weight:bold;color:limegreen;text-decoration:underline;">ZS:Bandit Warfare</span><br>
]]..translate.Get(helptab.Name)..[[</center><br><br><div>]]..content_translated..[[</div>
</body>
</html>]])
		propertysheet:AddSheet(translate.Get(helptab.Name), htmlpanel, helptab.Icon, false, false)
	end

	Window:Center()
	Window:MakePopup()

	local button = EasyButton(Window, "Credits", 8, 4)
	button:SetPos(wide - button:GetWide() - 12, tall - button:GetTall() - 12)
	button:SetText(translate.Get("credits_button"))
	button.DoClick = function(btn) MakepCredits() end

	gamemode.Call("BuildHelpMenu", Window, propertysheet)

	Window:SetAlpha(0)
	Window:AlphaTo(255, 0.5, 0)
	Window:MakePopup()
end

function GM:BuildHelpMenu(window, propertysheet)
end
