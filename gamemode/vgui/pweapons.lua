local PANEL = {}

function PANEL:Init()
	local screenscale = BetterScreenScale()
	self:DockPadding(2, 0, 2, 0)
	
	self.FeatureLabel = EasyLabel(self, "", "ZSHUDFontTiny")
	self.FeatureLabel:SetContentAlignment(4)
	self.FeatureLabel:Dock(LEFT)
	
	self.ValueLabel = EasyLabel(self, "", "ZSHUDFontTiny")
	self.ValueLabel:SetContentAlignment(6)
	self.ValueLabel:Dock(RIGHT)	
end

function PANEL:SetValues(k,v)
	self.FeatureLabel:SetText(k)
	self.FeatureLabel:SizeToContents()
	self.ValueLabel:SetText(v)
	self.ValueLabel:SizeToContents()
end

vgui.Register("DWeaponStatsLine", PANEL, "DPanel")

function GM:MakeWeaponInfo(swep)
	local screenscale = BetterScreenScale()
	local wid, hei = 600*screenscale, 500*screenscale
	local scrwid = ScrW()
	local scrhei = ScrH()
	local frame = vgui.Create("DFrame")
	frame:ShowCloseButton(false)
	frame:SetDeleteOnClose(true)
	frame:SetSize(wid, hei)
	frame:SetPos(scrwid*0.18, ScrH()-hei-40) 
	frame:SetTitle(" ")
	frame:DockPadding(8, 4, 8, 4)
	self.m_weaponInfoFrame = frame

	if not swep then return end
	local sweptable = weapons.GetStored(swep)
	if not sweptable then return end
	local features = GetWeaponFeatures(swep)
	if not (features and istable(features) and !table.IsEmpty(features)) then return end
	
	local title = sweptable.TranslateName and translate.Get(sweptable.TranslateName) or swep
	local text = ""
	if sweptable.TranslateDesc then
		text = translate.Get(sweptable.TranslateDesc)
	end
	
	local titlelabel = EasyLabel(frame, title, (screenscale > 0.9 and "ZSHUDFontSmall" or "ZSHUDFontSmaller"), COLOR_GRAY)
	titlelabel:SetContentAlignment(8)
	titlelabel:AlignTop(4)
	titlelabel:CenterHorizontal()
	
	local desclabel = EasyLabel(frame, text, (screenscale > 0.9 and "ZSHUDFontSmallest" or "ZSHUDFontTiny"), COLOR_GRAY)
	desclabel:SetContentAlignment(7)
	desclabel:SetMultiline(true)
	desclabel:SetWrap(true)
	desclabel:SetTall(frame:GetTall()*0.5)
	desclabel:SetWide(wid*0.95)
	desclabel:MoveBelow(titlelabel,4)
	desclabel:CenterHorizontal()
	local prevlabel = desclabel
	for _,v in ipairs(features) do
		local featureline = vgui.Create( "DWeaponStatsLine", frame )
		featureline:SetWide(wid*0.95)
		featureline:SetValues(translate.Get(v[1]),v[2])
		featureline:MoveBelow(prevlabel,1)
		prevlabel = featureline
		featureline:CenterHorizontal()
	end
	--featureslist:SizeToContents()
	--frame:SizeToContents()
end
