local function imgAdj(img, maximgx, maximgy)
	img:SizeToContents()
	local iwidth, height = img:GetSize()
	if height > maximgy then
		img:SetSize(maximgy / height * img:GetWide(), maximgy)
		iwidth, height = img:GetSize()
	end
	if iwidth > maximgx then
		img:SetWidth(maximgx)
	end
	img:Center()
end
	
local function WeaponIconFill(class,parent,islarge)
	islarge = islarge or false
	local ki = killicon.Get(class)
	local col = ki and Color(ki[#ki].r, ki[#ki].g, ki[#ki].b) or color_white
	if ki and #ki == 3 then
		local label = vgui.Create("DLabel", parent)
		label:SetText(ki[2])
		if islarge then
			label:SetFont(ki[1] and ki[1] .. "ws" or DefaultFont)
		else
			label:SetFont(ki[1] and ki[1] .. "ps" or DefaultFont)
		end
		label:SetTextColor(col)
		label:SizeToContents()
		label:SetContentAlignment(8)
		label:DockMargin(0, label:GetTall() * 0.1, 0, 0)
		label:Dock(FILL)
	elseif ki then
		local img = vgui.Create("DImage", parent)
		img:SetImage(ki[1])
		img:SetImageColor(col)
		imgAdj(img, parent:GetWide() - 6, parent:GetTall() - 3)
		img:Center()
		img:DockMargin(0, img:GetTall() * 0.05, 0, 0)
	end
end

local PANEL = {}
PANEL.m_ItemID = 0
PANEL.RefreshTime = 1
PANEL.NextRefresh = 0

function PANEL:Init()
	self:SetFont("DefaultFontLarge")
	self:AlignLeft(2)
	self:AlignBottom(2)
end

function PANEL:Think()
	if CurTime() >= self.NextRefresh then
		self.NextRefresh = CurTime() + self.RefreshTime
		self:Refresh()
	end
end

function PANEL:Refresh()
	local count = GAMEMODE:GetCurrentEquipmentCount(self:GetItemID(),LocalPlayer():Team())
	if count == 0 then
		self:SetText(" ")
	else
		self:SetText(count)
	end

	self:SizeToContents()
end

function PANEL:SetItemID(id) self.m_ItemID = id end
function PANEL:GetItemID() return self.m_ItemID end

vgui.Register("ItemAmountCounter", PANEL, "DLabel")

PANEL = {}

local function ItemButtonThink(self)
	local itemtab = FindItem(self.ID)
	if itemtab then 
		local newcost = GetItemCost(itemtab)
		if newcost ~= self.m_LastPrice then
			self.PriceLabel:SetText(tostring(math.ceil(newcost)).." Pts")	
			self.m_LastPrice = newcost
		end
		if self:IsHovered() or self.ID == GAMEMODE.m_PointsShop.CurrentID then
			local slot = GAMEMODE.m_PointsShop.m_LoadoutSlot
			local canpurchase, reasons = PlayerCanPurchasePointshopItem(MySelf,itemtab,slot,false)
			local canupgrade, upgradereasons = PlayerCanUpgradePointshopItem(MySelf,itemtab,slot)
			canupgrade = canupgrade and (GAMEMODE.ClassicModePurchasedThisWave[itemtab.SWEP] or GAMEMODE.ClassicModeInsuredWeps[itemtab.SWEP])
			if canpurchase ~= self.m_LastAbleToBuy then
				self.m_LastAbleToBuy = canpurchase
			end
			if canupgrade ~= self.m_LastAbleToUpgrade then
				self.m_LastAbleToUpgrade = canupgrade
			end
		end
	end
end

local function SetViewer(tab)
	local frame = GAMEMODE.m_PointsShop
	if not (frame.m_WeaponDescLabel and frame.m_WeaponDescLabel:Valid()) or not (frame.m_WeaponNameLabel and frame.m_WeaponNameLabel:Valid()) then return end
	local swepname = tab.SWEP
	local nametext = ""
	local desctext = ""
	if (swepname) then
		local sweptable = weapons.GetStored(swepname)
		if not sweptable then return end
		nametext = sweptable.TranslateName and translate.Get(sweptable.TranslateName) or swepname
		desctext = sweptable.TranslateDesc and translate.Get(sweptable.TranslateDesc) or ""
	else
		nametext = tab.TranslateName and translate.Get(tab.TranslateName) or ""
		desctext = tab.TranslateDesc and translate.Get(tab.TranslateDesc) or ""
	end
	
	frame.m_WeaponNameLabel:SetText(nametext)
	frame.m_WeaponNameLabel:SizeToContents()
	frame.m_WeaponNameLabel:CenterHorizontal()
	
	frame.m_WeaponDescLabel:SetText(desctext)
	frame.m_WeaponDescLabel:MoveBelow(frame.m_WeaponNameLabel,4)
	frame.m_WeaponDescLabel:CenterHorizontal()
	if (frame.m_WeaponFeatureLabels and istable(frame.m_WeaponFeatureLabels) and !table.IsEmpty(frame.m_WeaponFeatureLabels)) then
		for _, label in ipairs(frame.m_WeaponFeatureLabels) do
			label:Remove()
		end
	end
	frame.m_WeaponFeatureLabels = {}
	local features = GetWeaponFeatures(swepname)
	if (features and istable(features) and !table.IsEmpty(features)) then 
		local prevlabel = frame.m_WeaponDescLabel
		for _,v in ipairs(features) do
			local featureline = frame.m_RightScroller:Add("DWeaponStatsLine")
			local screenscale = BetterScreenScale()
			featureline:SetWide(math.min(ScrW(), 1000)*0.45 * screenscale - 8) 
			featureline:MoveBelow(prevlabel,1)
			featureline:SetValues(translate.Get(v[1]),v[2])
			prevlabel = featureline
			--featureline:CenterHorizontal()
			frame.m_WeaponFeatureLabels[_] = featureline;
		end
		frame.RefusePurchaseLabel:MoveBelow(prevlabel, 4)
	end
end

function PANEL:Init()
	local screenscale = BetterScreenScale()
	self:SetText("")
	self:DockMargin(0, 0, 0, 2)
	self:DockPadding(4, 4, 4, 4)
	self:SetTall(60*screenscale)
	self.IconFrame = vgui.Create("DEXRoundedPanel", self)
	self.IconFrame:SetWide(self:GetTall() *2)
	self.IconFrame:SetTall(self:GetTall()-8)
	self.IconFrame:Dock(LEFT)
	self.IconFrame:DockMargin(0, 0, 8, 0)
	self.IconFrame:SetMouseInputEnabled(false)
	
	self.NameLabel = EasyLabel(self, "", "ZSHUDFontSmallest")
	self.NameLabel:SetContentAlignment(4)
	self.NameLabel:Dock(TOP)
	self.NameLabel:DockMargin(4, 0, 0, 0)
	self.PriceLabel = EasyLabel(self, "", (screenscale > 0.9 and "ZSHUDFontSmallest" or "ZSHUDFontTiny"))
	self.PriceLabel:SetWide(100*screenscale)
	self.PriceLabel:SetContentAlignment(6)
	self.PriceLabel:Dock(BOTTOM)
	self.PriceLabel:DockMargin(8, 0, 4, 0)

	self.ItemCounter = vgui.Create("ItemAmountCounter", self.IconFrame)
	
	self.Think = ItemButtonThink
	self.m_LastAbleToBuy = true
	self.m_LastAbleToUpgrade = false
	self.m_LastPrice = nil
	self:SetupItemButton(nil,nil)
	self.m_LoadoutSlot = WEAPONLOADOUT_NULL
end

function PANEL:DoClick()
	local id = self.ID
	local tab = FindItem(id)
	if not tab then return end
	if !GAMEMODE.m_PointsShop or !GAMEMODE.m_PointsShop:Valid() then return end
	SetViewer(tab)
	surface.PlaySound("buttons/button17.wav")
	
	GAMEMODE.m_PointsShop.CurrentID = id
	GAMEMODE.m_PointsShop.m_LoadoutSlot = self.m_LoadoutSlot
end

function PANEL:SetupItemButton(id,slot)
	self.ID = id
	self.m_LoadoutSlot = slot
	local tab = FindItem(id)

	if not tab then
		self.IconFrame:SetVisible(false)
		self.ItemCounter:SetVisible(false)
		self.NameLabel:SetText("")
		return
	end
	local nametext = ""
	if tab.SWEP then
		self.IconFrame:SetVisible(true)
		WeaponIconFill(tab.SWEP,self.IconFrame)
		local sweptable = weapons.GetStored(tab.SWEP)
		if sweptable then 
			nametext = sweptable.TranslateName and translate.Get(sweptable.TranslateName) or tab.SWEP
			--[[if sweptable.Primary and sweptable.Base == "weapon_zs_base" and sweptable.Primary.Damage then
				nametext = " DPS: "..math.floor(sweptable.Primary.Damage*(sweptable.Primary.NumShots or 1)/sweptable.Primary.Delay)
			end]]
		end
	else
		self.IconFrame = nil
		nametext = tab.TranslateName and translate.Get(tab.TranslateName) or ""	
	end
	if tab.SWEP or tab.Countables then
		self.ItemCounter:SetItemID(id)
		self.ItemCounter:SetVisible(true)
	else
		self.ItemCounter:SetVisible(false)
	end
	
	self.NameLabel:SetText(nametext)

	self:SetAlpha(255)
end

function PANEL:Paint(w, h)
	local tab = FindItem(self.ID)
	local outline
	if not GAMEMODE.m_PointsShop and GAMEMODE.m_PointsShop:Valid() then return end
	if self.ID == GAMEMODE.m_PointsShop.CurrentID then
		outline = self.m_LastAbleToUpgrade and COLOR_LIGHTBLUE or (self.m_LastAbleToBuy and COLOR_LIMEGREEN or COLOR_RED)
	elseif self.Hovered then
		outline = self.m_LastAbleToUpgrade and COLOR_DARKBLUE or (self.m_LastAbleToBuy and COLOR_DARKGREEN or COLOR_DARKRED)
	else
		outline = COLOR_DARKGRAY
	end
	draw.RoundedBox(8, 0, 0, w, h, outline)
	draw.RoundedBox(4, 4, 4, w - 8, h - 8, color_black)
end

vgui.Register("ShopItemButton", PANEL, "DButton")

PANEL = {}

local function PurchaseButtonThink(self)
	local id = GAMEMODE.m_PointsShop.CurrentID
	local refusesellpanel = GAMEMODE.m_PointsShop.RefusePurchaseLabel
	local slot = GAMEMODE.m_PointsShop.m_LoadoutSlot
	local itemtab = FindItem(id)
	if itemtab then 
		local canpurchase, reasons = PlayerCanPurchasePointshopItem(MySelf,itemtab,slot,false)
		local canupgrade, upgradereasons = PlayerCanUpgradePointshopItem(MySelf,itemtab,slot)
		local ispurchasedweapon = true
		if GAMEMODE:IsClassicMode() then
			ispurchasedweapon = (GAMEMODE.ClassicModePurchasedThisWave[itemtab.SWEP] or GAMEMODE.ClassicModeInsuredWeps[itemtab.SWEP])
		end
		local canupgrade_combined = canupgrade and ispurchasedweapon
		if self.m_LastIsUpgradeBtn ~= canupgrade or canpurchase ~= self.m_LastAbleToBuy then
			self.BuyLabel:SetText(canupgrade and translate.Get("upgrade_item") or translate.Get("purchase_item"))
			self.m_LastIsUpgradeBtn = canupgrade
			self.m_LastAbleToBuy = canpurchase
			if canupgrade_combined or canpurchase then
				self:AlphaTo(255, 0.5, 0)
			else
				self:AlphaTo(75, 0.5, 0)
			end
		end
		local refusalreasons = ""
		if canupgrade then
			if !ispurchasedweapon then
				refusalreasons = translate.Get("weapon_is_not_owned")
			end
		elseif !canpurchase then
			refusalreasons = reasons
		end
		refusesellpanel:SetText(refusalreasons)
	else
		self.m_LastAbleToBuy = false
		self.m_LastIsUpgradeBtn = false
		self:AlphaTo(75, 0.1, 0)
	end
end

function PANEL:Init()
	local screenscale = BetterScreenScale()
	self:SetText("")

	self:DockPadding(4, 4, 4, 4)
	self:SetTall(60*screenscale)

	self.BuyLabel = EasyLabel(self, translate.Get("purchase_item"), "ZSHUDFontSmall")
	self.BuyLabel:SetContentAlignment(5)
	self.BuyLabel:Dock(FILL)

	self.Think = PurchaseButtonThink
	self.m_LastAbleToBuy = true
	self.m_LastPrice = nil
	self.m_LastIsUpgradeBtn = false
end

function PANEL:DoClick()
	if not (GAMEMODE.m_PointsShop and GAMEMODE.m_PointsShop:Valid()) then return end
	local id = GAMEMODE.m_PointsShop.CurrentID
	local tab = FindItem(id)
	if not tab then return end
	if self.m_LastIsUpgradeBtn or self.m_LastAbleToBuy then
		if self.m_LastIsUpgradeBtn then
			local ispurchasedweapon = true
			if GAMEMODE:IsClassicMode() then
				ispurchasedweapon = (GAMEMODE.ClassicModePurchasedThisWave[tab.SWEP] or GAMEMODE.ClassicModeInsuredWeps[tab.SWEP])
			end
			if ispurchasedweapon then
				surface.PlaySound("buttons/button17.wav")
				local shopframe = vgui.Create("DUpgradesShopFrame")
				shopframe:SetUpUpgradeMenu(id,GAMEMODE.m_PointsShop.m_LoadoutSlot)
				GAMEMODE.m_PointsShop:SetVisible(false)
			else
				surface.PlaySound("buttons/button8.wav")
			end
			return
		end
		surface.PlaySound("buttons/button17.wav")
		local loadoutslot = GAMEMODE.m_PointsShop.m_LoadoutSlot
		RunConsoleCommand("zsb_pointsshopbuy", id, loadoutslot)
		if not GAMEMODE:IsClassicMode() and (loadoutslot == WEAPONLOADOUT_SLOT1 or loadoutslot == WEAPONLOADOUT_SLOT2 or loadoutslot == WEAPONLOADOUT_MELEE or loadoutslot == WEAPONLOADOUT_TOOLS) then
			GAMEMODE.m_PointsShop:Close()
		end
	else
		surface.PlaySound("buttons/button8.wav")
	end
end 

function PANEL:Paint(w, h)
	local id = GAMEMODE.m_PointsShop.CurrentID
	local tab = FindItem(id)
	local ispurchasedweapon = true
	if GAMEMODE:IsClassicMode() and tab then
		ispurchasedweapon = (GAMEMODE.ClassicModePurchasedThisWave[tab.SWEP] or GAMEMODE.ClassicModeInsuredWeps[tab.SWEP])
	end
	local outline
	local isupgradeable = self.m_LastIsUpgradeBtn and ispurchasedweapon
	if self.Hovered then
		outline = isupgradeable and COLOR_DARKBLUE or (self.m_LastAbleToBuy and COLOR_DARKGREEN or COLOR_DARKRED)
	else
		outline = (isupgradeable and COLOR_GRAY or COLOR_DARKGRAY)
	end
	draw.RoundedBox(8, 0, 0, w, h, outline)
	draw.RoundedBox(4, 4, 4, w - 8, h - 8, color_black)
end

vgui.Register("BuySelectedButton", PANEL, "DButton")

local function pointscounterThink(self)
	local points = MySelf:GetPoints()
	if self.m_LastPoints ~= points then
		self.m_LastPoints = points
		self:SetText(points)
		self:SizeToContents()
		GAMEMODE.m_PointsShop.m_TopSpace.m_CostCounter:MoveRightOf(self,8)
	end
end

local function costcounterThink(self)
	local id = GAMEMODE.m_PointsShop.CurrentID
	local itemtab = FindItem(id)
	if itemtab then
		local cost = GetItemCost(itemtab)
		if self.m_LastCost ~= cost then
			self.m_LastCost = cost
			self:SetText("-"..cost)
			self:SizeToContents()
		end
	elseif self.m_LastCost then
		self.m_LastCost = nil
		self:SetText("")
		self:SizeToContents()
	end
end

local ammonames = {
	["pistol"] = "pistolammo",
	["buckshot"] = "shotgunammo",
	["smg1"] = "smgammo",
	["ar2"] = "assaultrifleammo",
	["357"] = "rifleammo",
	["XBowBolt"] = "crossbowammo",
	["pulse"] = "pulseammo",
	["Battery"] = "medicammo",
	["grenlauncher"] = "glgrenade",
	["alyxgun"] = "biomaterial",
	["SniperRound"] = "woodboards",
	["gravity"] = "empround",
	["GaussEnergy"] = "nails"
}

local function PointsShopThink(self)
	if GAMEMODE:GetWave() ~= GAMEMODE.m_LastWaveWarning and not GAMEMODE:GetWaveActive() and CurTime() >= GAMEMODE:GetWaveStart() - 10 and CurTime() > (GAMEMODE.m_LastWaveWarningTime or 0) + 11 then
		GAMEMODE.m_LastWaveWarning = GAMEMODE:GetWave()
		GAMEMODE.m_LastWaveWarningTime = CurTime()

		surface.PlaySound("ambient/alarms/klaxon1.wav")
		timer.Simple(0.6, function() surface.PlaySound("ambient/alarms/klaxon1.wav") end)
		timer.Simple(1.2, function() surface.PlaySound("ambient/alarms/klaxon1.wav") end)
		timer.Simple(2, function() surface.PlaySound("vo/npc/Barney/ba_hurryup.wav") end)
	end
end

local function helpDoClick()
	MakepHelp()
end

local function closeDoClick()
	if GAMEMODE.m_PointsShop and GAMEMODE.m_PointsShop:Valid() then
		PlayMenuOpenSound()
		GAMEMODE.m_PointsShop:Close()
	end
end

local function PointsShopOnClose()
	if GAMEMODE.m_UpgradesShop and GAMEMODE.m_UpgradesShop:Valid() then
		GAMEMODE.m_UpgradesShop:Close()
	end
end

function GM:ConfigureMenuTabs(tabs, tabhei, callback)
	local screenscale = BetterScreenScale()
	
	for _, tab in pairs(tabs) do
		tab:DockMargin(2,0,2,0)
		tab:SetFont(screenscale > 0.9 and "ZSIconFont" or "DefaultFont")
		tab.GetTabHeight = function()
			return tabhei + 2
		end
		tab.PerformLayout = function(me)
			me:ApplySchemeSettings()
			if not me.Image then return end
			me.Image:SetPos(7, me:GetTabHeight()/2 - me.Image:GetTall()/2 + 3)
			me.Image:SetImageColor(Color(255, 255, 255, not me:IsActive() and 125 or 255))
		end
		tab.DoClick = function(me)
			me:GetPropertySheet():SetActiveTab(me)
			if callback then callback(tab) end
		end
	end
end

GM.ItemCategories = {
	[ITEMCAT_GUNS] = "itemcategory_guns",
	[ITEMCAT_MELEE] = "itemcategory_melee",
	[ITEMCAT_TOOLS] = "itemcategory_tools",
	[ITEMCAT_CONS] = "itemcategory_etc"
}

PANEL = {}

function PANEL:PerformLayout()
	local screenscale = BetterScreenScale()
	local wid, hei = math.min(ScrW(), 1000) * screenscale, math.min(ScrH(), 800) * screenscale
	
	local sidemargin = 4
	
	self.m_TitleLabel:SizeToContents()
	self.m_TitleLabel:CenterHorizontal()
	
	local _, y = self.m_TitleLabel:GetPos()
	local topspacetall = y + self.m_TitleLabel:GetTall() +16
	self.m_TopSpace:SetWide(wid - 16)
	self.m_TopSpace:SetTall(topspacetall)
	self.m_TopSpace:Dock(TOP)
	self.m_TopSpace:CenterHorizontal()	
	
	self.m_BottomSpace:SetTall(60*screenscale)
	self.m_BottomSpace:Dock(BOTTOM)
	self.m_BottomSpace:CenterHorizontal()
	self.m_BottomSpace:SetOverlap(-8)
	self.m_BottomSpace:DockMargin(4,0,4,0)

	self.m_LeftPanel:SetWide(wid*0.5 - sidemargin*2)
	self.m_LeftPanel:DockMargin(sidemargin, 4, sidemargin, 4)
	self.m_LeftPanel:Dock(LEFT)
	
	self.m_RightPanel:SetWide(wid*0.5 - sidemargin*2)
	self.m_RightPanel:SetTall(self.m_LeftPanel:GetTall())
	self.m_RightPanel:DockMargin(sidemargin, 4, sidemargin, 4)
	self.m_RightPanel:DockPadding(8,0,8,0)
	self.m_RightPanel:Dock(RIGHT)
	self.m_RightScroller:Dock(FILL)
	
	self.m_TopSpace.m_PointsLabel:AlignLeft(32*screenscale)
	self.m_TopSpace.m_PointsLabel:SetContentAlignment(6)
	
	self.m_TopSpace.m_PointsCounter:MoveRightOf(self.m_TopSpace.m_PointsLabel,2)
	self.m_TopSpace.m_PointsCounter:SetContentAlignment(4)
	
	self.m_TopSpace.m_CostCounter:SetContentAlignment(6)
	
	self.m_CloseButton:SetTall(topspacetall)
	self.m_CloseButton:SetWide(128*screenscale)
	self.m_CloseButton:SetContentAlignment(5)
	self.m_CloseButton:AlignRight(32)
	
	self.m_HelpButton:SetTall(topspacetall)
	self.m_HelpButton:SetWide(128*screenscale)
	self.m_HelpButton:SetContentAlignment(5)
	self.m_HelpButton:MoveLeftOf(self.m_CloseButton, 8 )

	self.m_WeaponNameLabel:SetContentAlignment(8)
	self.m_WeaponNameLabel:AlignTop(4)
	self.m_WeaponNameLabel:CenterHorizontal()
	
	self.m_WeaponDescLabel:SetContentAlignment(7)
	self.m_WeaponDescLabel:SetTall(hei*0.4)
	self.m_WeaponDescLabel:SetWide(wid*0.45 - sidemargin*2)
	self.m_WeaponDescLabel:MoveBelow(self.m_WeaponNameLabel,4)
	self.m_WeaponDescLabel:CenterHorizontal()

	self.RefusePurchaseLabel:SetWide(wid*0.45 - sidemargin*2)
	self.RefusePurchaseLabel:CenterHorizontal()
	self.RefusePurchaseLabel:SetContentAlignment(8)	
	self.RefusePurchaseLabel:SetAutoStretchVertical(true)
	
	local pchsbtnmargin = math.min(wid*0.1,(wid*0.25 - sidemargin)-128*screenscale)
	self.PurchaseSelectedButton:DockMargin(pchsbtnmargin,0,pchsbtnmargin,0)
	self.PurchaseSelectedButton:Dock(BOTTOM)
	self.PurchaseSelectedButton:SetZPos(-1)
	self.PurchaseSelectedButton:MoveAbove(self.m_BottomSpace, 5)
end

function PANEL:Init()
	local screenscale = BetterScreenScale()
	local wid, hei = math.min(ScrW(), 1000) * screenscale, math.min(ScrH(), 800) * screenscale

	self:SetSize(wid, hei)
	self:SetDeleteOnClose(true)
	self:SetTitle(" ")
	self:SetDraggable(false)
	if self.btnClose and self.btnClose:Valid() then self.btnClose:SetVisible(false) end
	if self.btnMinim and self.btnMinim:Valid() then self.btnMinim:SetVisible(false) end
	if self.btnMaxim and self.btnMaxim:Valid() then self.btnMaxim:SetVisible(false) end
	self.Think = PointsShopThink
	self.OnClose = PointsShopOnClose
	
	local topspace = vgui.Create("DPanel", self)
	GAMEMODE.m_PointsShop = self
	
	local title = EasyLabel(topspace, translate.Get("pointshop_title"), "ZSHUDFontSmall", COLOR_WHITE)
	self.m_TitleLabel = title

	local pointslabel = EasyLabel(topspace, translate.Get("points"), "ZSHUDFontSmall", COLOR_WHITE)
	topspace.m_PointsLabel = pointslabel

	local pointscounter = EasyLabel(topspace, "0", "ZSHUDFontSmall", COLOR_GREEN)
	pointscounter.Think = pointscounterThink
	topspace.m_PointsCounter = pointscounter
	
	local costcounter = EasyLabel(topspace, "", "ZSHUDFontSmall", COLOR_RED)
	costcounter.Think = costcounterThink
	topspace.m_CostCounter = costcounter
	
	local closebutton = EasyButton(topspace, translate.Get("close_button"))
	closebutton:SetFont("ZSHUDFontSmaller")
	closebutton.DoClick = closeDoClick
	self.m_CloseButton = closebutton
	
	local help = EasyButton(topspace, translate.Get("button_help"))
	help:SetFont("ZSHUDFontSmaller")
	help.DoClick = helpDoClick
	self.m_HelpButton = help
	
	self.m_TopSpace = topspace
	
	local bottomspace = vgui.Create("DHorizontalScroller", self)
	self.m_BottomSpace = bottomspace
	
	local leftpanel = vgui.Create("DPanel",self)
	self.m_LeftPanel = leftpanel
	local rightinfopanel = vgui.Create("DPanel",self)
	self.m_RightPanel = rightinfopanel
	
	local rightinfolist = vgui.Create("DScrollPanel", self.m_RightPanel)
	rightinfolist:SetPaintBackground(false)
	self.m_RightScroller = rightinfolist
	
	local wepname = EasyLabel(rightinfopanel, "", (screenscale > 0.9 and "ZSHUDFontSmaller" or "ZSHUDFontSmallest"), COLOR_GRAY)
	local wepdesc = EasyLabel(rightinfopanel, "", (screenscale > 0.9 and "ZSHUDFontSmallest" or "ZSHUDFontTiny"), COLOR_GRAY)
	wepdesc:SetWrap(true)
	self.m_WeaponDescLabel = wepdesc
	self.m_WeaponNameLabel = wepname
	self.m_RightScroller:AddItem(self.m_WeaponNameLabel)
	self.m_RightScroller:AddItem(self.m_WeaponDescLabel)
	
	local refusesellpanel = EasyLabel(rightinfopanel, "", "ZSHUDFontSmaller", COLOR_RED)
	refusesellpanel:SetWrap(true)
	self.RefusePurchaseLabel = refusesellpanel
	self.m_RightScroller:AddItem(self.RefusePurchaseLabel)
	
	local purchasebutton = vgui.Create("BuySelectedButton", rightinfopanel)
	self.PurchaseSelectedButton = purchasebutton
	self.m_WeaponFeatureLabels = {}
	self.CurrentID = nil
	self:Center()
	self:MakePopup()
end

function PANEL:UpdatePointsShop(weaponslot)
	local currentweppanel = nil
	local currentweplist = nil
	local currentwepcatname = nil
	
	local wep = nil
	if GAMEMODE:IsClassicMode() or (weaponslot == WEAPONLOADOUT_NULL or not weaponslot) then
		local activewep = MySelf:GetActiveWeapon()
		if activewep and activewep:IsValid() then wep = activewep:GetClass() end
	elseif weaponslot == WEAPONLOADOUT_SLOT1 then
		self.m_TitleLabel:SetText(translate.Get("pointshop_title_guns1"))
		wep = MySelf:GetWeapon1()
	elseif weaponslot == WEAPONLOADOUT_SLOT2 then
		self.m_TitleLabel:SetText(translate.Get("pointshop_title_guns2"))
		wep = MySelf:GetWeapon2()
	elseif weaponslot == WEAPONLOADOUT_MELEE then
		self.m_TitleLabel:SetText(translate.Get("pointshop_title_melee"))
		wep = MySelf:GetWeaponMelee()
	elseif weaponslot == WEAPONLOADOUT_TOOLS then
		self.m_TitleLabel:SetText(translate.Get("pointshop_title_tools"))
		wep = MySelf:GetWeaponToolslot()	
	end	
	
	self.m_TitleLabel:SizeToContents()
	self.m_TitleLabel:CenterHorizontal()		
	
	if GAMEMODE:IsClassicMode() then 
		for catid, catname in ipairs(GAMEMODE.ItemCategories) do
			if !table.IsEmpty(self.m_PropSheet.scrollLists) and  ispanel(self.m_PropSheet.scrollLists[catid]) then
				self.m_PropSheet.scrollLists[catid]:Clear()
			end
		end
	else
		if self.m_ShopScrollList and ispanel(self.m_ShopScrollList) then
			self.m_ShopScrollList:Clear()
		end
	end
	
	local list = nil
	for i, tab in ipairs(GAMEMODE.Items) do
		if GAMEMODE:IsClassicMode() then
			if not (tab.NoClassicMode) and (!tab.Prerequisites or (tab.Prerequisites and table.IsEmpty(tab.Prerequisites)) or (tab.SWEP and MySelf:GetWeapon(tab.SWEP) and MySelf:GetWeapon(tab.SWEP):IsValid())) then 
				for catid, catname in ipairs(GAMEMODE.ItemCategories) do
					if tab.Category == catid then
						if !table.IsEmpty(self.m_PropSheet.scrollLists) and  ispanel(self.m_PropSheet.scrollLists[catid]) then
							list = self.m_PropSheet.scrollLists[catid]
							local itembut = vgui.Create("ShopItemButton")
							itembut:SetupItemButton(i,weaponslot)
							itembut:Dock(TOP)
							list:AddItem(itembut)
							if tab.SWEP == wep then 
								self.CurrentID = i
								SetViewer(tab)
								currentweppanel = itembut
								currentwepcatname = catname
								currentweplist = list
							end
						end
					end
				end
			end
		else
			if self.m_ShopScrollList and ispanel(self.m_ShopScrollList) then
				list = self.m_ShopScrollList
				local catid = nil
				local currentslotwep = ""
				if (weaponslot == WEAPONLOADOUT_SLOT1 or weaponslot == WEAPONLOADOUT_SLOT2) then
					currentslotwep = weaponslot == WEAPONLOADOUT_SLOT1 and MySelf:GetWeapon1() or MySelf:GetWeapon2()
					catid = ITEMCAT_GUNS 
				elseif weaponslot == WEAPONLOADOUT_MELEE then
					currentslotwep = MySelf:GetWeaponMelee()
					catid = ITEMCAT_MELEE 
				elseif weaponslot == WEAPONLOADOUT_TOOLS then
					currentslotwep = MySelf:GetWeaponToolslot()
					catid = ITEMCAT_TOOLS
				elseif (weaponslot == WEAPONLOADOUT_NULL or not weaponslot) then
					catid = ITEMCAT_CONS
				end
				
				if not (tab.NoSampleCollectMode and GAMEMODE:IsSampleCollectMode()) and 
				not (tab.SampleCollectModeOnly and not GAMEMODE:IsSampleCollectMode()) and (!tab.Prerequisites or (tab.Prerequisites and table.IsEmpty(tab.Prerequisites)) or (tab.SWEP and tab.SWEP == currentslotwep)) then 
					if tab.Category == catid then
						local itembut = vgui.Create("ShopItemButton")
						itembut:SetupItemButton(i,weaponslot)
						itembut:Dock(TOP)
						list:AddItem(itembut)
						if tab.SWEP == wep then 
							self.CurrentID = i
							SetViewer(tab)
							currentweppanel = itembut
							currentweplist = list
						end
					end
				end
			end
		end
	end

	if currentweppanel then
		if GAMEMODE:IsClassicMode() then
			self.m_PropSheet:SwitchToName(translate.Get(currentwepcatname))
		end
		if ispanel(currentweplist) then
			timer.Simple( 0.02, function() if (currentweplist and currentweplist:IsValid()) then currentweplist:ScrollToChild(currentweppanel) end end)
		end
	end
	
	self:InvalidateLayout()
end

function PANEL:SetUpPointsShop(weaponslot)
	local screenscale = BetterScreenScale()
	local tabhei = 26 * screenscale
	self.m_LoadoutSlot = weaponslot
	
	local leftpanel = self.m_LeftPanel
	if GAMEMODE:IsClassicMode() then
		propertysheet = vgui.Create("DPropertySheet", leftpanel)
		propertysheet:SetPadding(2)
		propertysheet:Dock(FILL)
		propertysheet.scrollLists = {}
		self.m_PropSheet = propertysheet
		
		for catid, catname in ipairs(GAMEMODE.ItemCategories) do
			local list = vgui.Create("DScrollPanel", self.m_PropSheet)
			list:SetPaintBackground(false)
			list:SetPadding(2)
			local sheet = self.m_PropSheet:AddSheet(translate.Get(catname), list, GAMEMODE.ItemCategoryIcons[catid], false, false)
			sheet.Panel:SetPos(0, tabhei + 2)
			self.m_PropSheet.scrollLists[catid] = list
			
			local scroller = self.m_PropSheet:GetChildren()[1]
			local dragbase = scroller:GetChildren()[1]
			local tabs = dragbase:GetChildren()
			gamemode.Call("ConfigureMenuTabs", tabs, tabhei)
		end
	else
		local list = vgui.Create("DScrollPanel", leftpanel)
		list:SetPaintBackground(false)
		list:SetPadding(2)
		list:Dock(FILL)
		self.m_ShopScrollList = list
	end

	for i, tab in ipairs(GAMEMODE.Items) do
		if tab.Category == ITEMCAT_OTHER then
			if not (GAMEMODE:IsClassicMode() and tab.NoClassicMode) and 
			not (tab.NoSampleCollectMode and GAMEMODE:IsSampleCollectMode()) and 
			not (tab.SampleCollectModeOnly and not GAMEMODE:IsSampleCollectMode())then 
				local itembut = vgui.Create("ShopItemButton",self.m_BottomSpace)
				itembut:SetupItemButton(i,WEAPONLOADOUT_NULL)
				itembut:SetWide(156*screenscale)
				self.m_BottomSpace:AddPanel(itembut)
			end
		end
	end	
	self:UpdatePointsShop(weaponslot)
end

vgui.Register("DPointShopFrame", PANEL, "DFrame")

PANEL = {}

local function UpgradeItemButtonThink(self)
	local itemtab = FindItem(self.ID)
	if itemtab then 
		local newcost = GetItemCost(itemtab)
		if newcost ~= self.m_LastPrice then
			self.PriceLabel:SetText(tostring(math.ceil(newcost)).." Pts")	
			self.m_LastPrice = newcost
		end
		if self:IsHovered() or self.ID == GAMEMODE.m_UpgradesShop.CurrentID then
			local slot = GAMEMODE.m_PointsShop.m_LoadoutSlot
			local canpurchase, reasons = PlayerCanPurchasePointshopUpgradeItem(MySelf,GAMEMODE.m_UpgradesShop.m_CurrentItemTab, itemtab,slot, GAMEMODE.m_UpgradesShop.m_IsRevertMode)
			if canpurchase ~= self.m_LastAbleToBuy then
				self.m_LastAbleToBuy = canpurchase
			end
		end
	end
end

local function SetViewer_upgrade(tab)
	local frame = GAMEMODE.m_UpgradesShop
	if not (frame.m_WeaponDescLabel and frame.m_WeaponDescLabel:Valid()) or not (frame.m_WeaponNameLabel and frame.m_WeaponNameLabel:Valid()) then return end
	local swepname = tab.SWEP
	local nametext = ""
	local desctext = ""
	if (swepname) then
		local sweptable = weapons.GetStored(swepname)
		if not sweptable then return end
		nametext = sweptable.TranslateName and translate.Get(sweptable.TranslateName) or swepname
		desctext = sweptable.TranslateDesc and translate.Get(sweptable.TranslateDesc) or ""
	else
		nametext = tab.TranslateName and translate.Get(tab.TranslateName) or ""
		desctext = tab.TranslateDesc and translate.Get(tab.TranslateDesc) or ""
	end
	frame.m_WeaponNameLabel:SetText(nametext)
	frame.m_WeaponNameLabel:SizeToContents()
	frame.m_WeaponNameLabel:CenterHorizontal()
	
	frame.m_WeaponDescLabel:SetText(desctext)
	frame.m_WeaponDescLabel:MoveBelow(frame.m_WeaponNameLabel,4)
	frame.m_WeaponDescLabel:CenterHorizontal()
	if (frame.m_WeaponFeatureLabels and istable(frame.m_WeaponFeatureLabels) and !table.IsEmpty(frame.m_WeaponFeatureLabels)) then
		for _, label in ipairs(frame.m_WeaponFeatureLabels) do
			label:Remove()
		end
	end
	frame.m_WeaponFeatureLabels = {}
	local original_swep = GAMEMODE.m_UpgradesShop.m_CurrentItemTab and GAMEMODE.m_UpgradesShop.m_CurrentItemTab.SWEP or nil
	local original_features = GetWeaponFeatures(original_swep)
	local features = GetWeaponFeatures(swepname)
	if (features and istable(features) and !table.IsEmpty(features) and original_features and istable(original_features) and !table.IsEmpty(original_features)) then 
		local prevlabel = frame.m_WeaponDescLabel
		for i,v in ipairs(features) do
			original_v = original_features[i]
			local featureline = frame.m_RightScroller:Add("DWeaponStatsLine")
			local screenscale = BetterScreenScale()
			featureline:SetWide(math.min(ScrW(), 1000)*0.35 * screenscale - 8)
			featureline:MoveBelow(prevlabel,1)
			featureline:SetValues(translate.Get(v[1]),(istable(original_v) and !table.IsEmpty(original_v) and original_swep ~= swepname) and original_v[2].." -> "..v[2] or v[2])
			prevlabel = featureline
			frame.m_WeaponFeatureLabels[i] = featureline;
		end
		frame.RefusePurchaseLabel:MoveBelow(prevlabel, 4)
	end
end

function PANEL:DoClick()
	local id = self.ID
	local tab = FindItem(id)
	if not tab then return end
	if !GAMEMODE.m_UpgradesShop or !GAMEMODE.m_UpgradesShop:Valid() then return end
	SetViewer_upgrade(tab)
	surface.PlaySound("buttons/button17.wav")
	
	GAMEMODE.m_UpgradesShop.CurrentID = id
	GAMEMODE.m_UpgradesShop.m_LoadoutSlot = self.m_LoadoutSlot
end

function PANEL:Paint(w, h)
	local tab = FindItem(self.ID)
	local outline
	if not GAMEMODE.m_UpgradesShop and GAMEMODE.m_UpgradesShop:Valid() then return end
	if self.ID == GAMEMODE.m_UpgradesShop.CurrentID then
		outline = self.m_LastAbleToBuy and COLOR_LIMEGREEN or COLOR_RED
	elseif self.Hovered then
		outline = self.m_LastAbleToBuy and COLOR_DARKGREEN or COLOR_DARKRED
	else
		outline = COLOR_DARKGRAY
	end
	draw.RoundedBox(8, 0, 0, w, h, outline)
	draw.RoundedBox(4, 4, 4, w - 8, h - 8, color_black)
end

function PANEL:Init()
	self.Think = UpgradeItemButtonThink
end

vgui.Register("UpgradeItemButton", PANEL, "ShopItemButton")

PANEL = {}

function PANEL:Init()
	local screenscale = BetterScreenScale()
	
	self:SetText("")
	self:DockMargin(0, 0, 0, 2)
	self:DockPadding(4, 4, 4, 4)
	self:SetTall(60*screenscale)
	self:SetWide(120*screenscale)
	
	self.IconFrame = vgui.Create("DEXRoundedPanel", self)
	self.IconFrame:SetTall(60*screenscale-8)
	self.IconFrame:SetWide(120*screenscale-8)
	self.IconFrame:Dock(FILL)
	self.IconFrame:DockMargin(0, 0, 8, 0)
	self.IconFrame:SetMouseInputEnabled(false)

	self.m_LoadoutSlot = WEAPONLOADOUT_NULL
	self:SetupItemLabel(nil)
end

function PANEL:SetupItemLabel(id)
	self.ID = id
	local tab = FindItem(id)
	if not tab then
		self.IconFrame:SetVisible(false)
		return
	end
	if tab.SWEP then
		self.IconFrame:SetVisible(true)
		WeaponIconFill(tab.SWEP,self.IconFrame)
	else
		self.IconFrame = nil
	end
	self:SetAlpha(255)
end

function PANEL:Paint(w, h)
	local outline = COLOR_GRAY
	draw.RoundedBox(8, 0, 0, w, h, outline)
	draw.RoundedBox(4, 4, 4, w - 8, h - 8, color_black)
end

vgui.Register("ShopUpgradeCurrentItemLabel", PANEL, "DLabel")

PANEL = {}

local function upgrade_PurchaseButtonThink(self)
	local id = GAMEMODE.m_UpgradesShop.CurrentID
	local refusesellpanel = GAMEMODE.m_UpgradesShop.RefusePurchaseLabel
	local slot = GAMEMODE.m_PointsShop.m_LoadoutSlot
	local itemtab = FindItem(id)
	if itemtab then 
		local canpurchase, reasons = PlayerCanPurchasePointshopUpgradeItem(MySelf,GAMEMODE.m_UpgradesShop.m_CurrentItemTab, itemtab,slot, GAMEMODE.m_UpgradesShop.m_IsRevertMode)
		if canpurchase ~= self.m_LastAbleToBuy then		
			self.m_LastAbleToBuy = canpurchase
			if canpurchase then
				self:AlphaTo(255, 0.5, 0)
			else
				self:AlphaTo(75, 0.5, 0)
			end
		end
		refusesellpanel:SetText(reasons)
	else
		self.m_LastAbleToBuy = false
		self:AlphaTo(75, 0.1, 0)
	end
end

--[[function PANEL:Init()
	self:SetText("")

	self:DockPadding(4, 4, 4, 4)
	self:SetTall(60)

	self.BuyLabel = EasyLabel(self, translate.Get("upgrade_item"), "ZSHUDFontSmall")
	self.BuyLabel:SetContentAlignment(5)
	self.BuyLabel:Dock(FILL)

	self.Think = upgrade_PurchaseButtonThink
	self.m_LastAbleToBuy = true
	self.m_LastPrice = nil
	self.m_LastIsUpgradeBtn = false
end]]

function PANEL:Init()
	self.Think = upgrade_PurchaseButtonThink
end

function PANEL:DoClick()
	if not (GAMEMODE.m_UpgradesShop and GAMEMODE.m_UpgradesShop:Valid()) then return end
	local id = GAMEMODE.m_UpgradesShop.CurrentID
	local tab = FindItem(id)
	if not tab then return end
	if self.m_LastAbleToBuy then
		surface.PlaySound("buttons/button17.wav")
		local loadoutslot = GAMEMODE.m_PointsShop.m_LoadoutSlot
		local originalid = GAMEMODE.m_UpgradesShop.m_CurrentItemTab.Signature
		local isrevertmode = GAMEMODE.m_UpgradesShop.m_IsRevertMode
		RunConsoleCommand("zsb_pointsshopupgrade", originalid, id, (isrevertmode and 1 or 0), loadoutslot)
		GAMEMODE.m_PointsShop:Close()
	else
		surface.PlaySound("buttons/button8.wav")
	end
end 

function PANEL:Paint(w, h)
	local outline
	if self.Hovered then
		outline = self.m_LastAbleToBuy and COLOR_DARKGREEN or COLOR_DARKRED
	else
		outline = COLOR_DARKGRAY
	end
	draw.RoundedBox(8, 0, 0, w, h, outline)
	draw.RoundedBox(4, 4, 4, w - 8, h - 8, color_black)
end

vgui.Register("UpgradeSelectedButton", PANEL, "BuySelectedButton")

PANEL = {}

local function upgradesCloseDoClick()
	if GAMEMODE.m_UpgradesShop and GAMEMODE.m_UpgradesShop:Valid() then
		PlayMenuOpenSound()
		GAMEMODE.m_UpgradesShop:Close()
	end
end

local function UpgradesOnClose()
	local ps = GAMEMODE.m_PointsShop
	if ps and ps:Valid() and ispanel(ps) then
		if not ps:IsVisible() then
			ps:SetVisible(true)
		end
		ps:UpdatePointsShop(ps.m_LoadoutSlot)
	end
end

local function upgrade_pointscounterThink(self)
	local points = MySelf:GetPoints()
	if self.m_LastPoints ~= points then
		self.m_LastPoints = points
		self:SetText(points)
		self:SizeToContents()
		GAMEMODE.m_UpgradesShop.m_TopSpace.m_CostCounter:MoveRightOf(self,8)
	end
end

local function upgrade_costcounterThink(self)
	local id = GAMEMODE.m_UpgradesShop.CurrentID
	local itemtab = FindItem(id)
	local curitemtab = GAMEMODE.m_UpgradesShop.m_CurrentItemTab
	local isrevertmode = GAMEMODE.m_UpgradesShop.m_IsRevertMode
	if itemtab then
		local cost = GetItemCost(isrevertmode and curitemtab or itemtab)
		if self.m_LastCost ~= cost then
			self.m_LastCost = cost
			self:SetText((isrevertmode and "+" or "-")..(isrevertmode and math.floor(cost/2) or cost))
			self:SetTextColor(isrevertmode and COLOR_LIMEGREEN or COLOR_RED)
			self:SizeToContents()
		end
	elseif self.m_LastCost then
		self.m_LastCost = nil
		self:SetText("")
		self:SizeToContents()
	end
end

local function upgrade_switchModeDoClick(self)
	GAMEMODE.m_UpgradesShop.m_IsRevertMode = !GAMEMODE.m_UpgradesShop.m_IsRevertMode
	surface.PlaySound("buttons/lever7.wav")
	local upgradeshop = GAMEMODE.m_UpgradesShop
	if upgradeshop and upgradeshop:IsValid() and ispanel(upgradeshop) then
		local tab = GAMEMODE.m_UpgradesShop.m_CurrentItemTab
		upgradeshop:SetCurrentUpgradeMode(GAMEMODE.m_UpgradesShop.m_IsRevertMode)
		upgradeshop.CurrentID = nil
		SetViewer_upgrade(tab)
		upgradeshop:PopulateUpgradeList(tab.Signature,GAMEMODE.m_PointsShop.m_LoadoutSlot,!GAMEMODE.m_UpgradesShop.m_IsRevertMode)
	end
end

function PANEL:SetCurrentUpgradeMode(isrevert)
	local tab = self.m_CurrentItemTab
	local swepname = tab and tab.SWEP or nil
	local nametext = ""
	local sweptable = weapons.GetStored(swepname)
	if sweptable then 
		nametext = sweptable.TranslateName and translate.Get(sweptable.TranslateName) or swepname
	end
	self.m_TitleLabel:SetText(translate.Format(isrevert and "reverting_x" or "upgrading_x",nametext))
	self.m_SwitchModeButton:SetText(translate.Get(isrevert and "switch_to_upgrade" or "switch_to_revert"))
	self.m_CenterImg:SetImageColor(isrevert and COLOR_RED or COLOR_LIMEGREEN)
	self.m_CenterImg:SetImage(isrevert and "gui/html/back" or "gui/html/forward")
	self.PurchaseSelectedButton.BuyLabel:SetText(isrevert and translate.Get("revert_item") or translate.Get("upgrade_item"))
end

function PANEL:PerformLayout()
	local screenscale = BetterScreenScale()
	local wid, hei = math.min(ScrW(), 1000) * screenscale, math.min(ScrH(), 800) * screenscale
	
	local sidemargin = 4
	
	self.m_TitleLabel:SizeToContents()
	self.m_TitleLabel:CenterHorizontal()
	
	local _, y = self.m_TitleLabel:GetPos()
	local topspacetall = y + self.m_TitleLabel:GetTall() +16
	self.m_TopSpace:SetWide(wid - 16)
	self.m_TopSpace:SetTall(topspacetall)
	self.m_TopSpace:Dock(TOP)
	self.m_TopSpace:CenterHorizontal()	
	
	self.m_BottomSpace:SetTall(60*screenscale)
	self.m_BottomSpace:Dock(BOTTOM)
	self.m_BottomSpace:CenterHorizontal()
	self.m_BottomSpace:DockMargin(4,0,4,0)
	
	self.m_LeftPanel:SetWide(wid*0.6 - sidemargin*2)
	self.m_LeftPanel:DockMargin(sidemargin, 4, sidemargin, 4)
	self.m_LeftPanel:Dock(LEFT)
	
	self.m_RightPanel:SetWide(wid*0.4 - sidemargin*2)
	self.m_RightPanel:SetTall(self.m_LeftPanel:GetTall())
	self.m_RightPanel:DockMargin(sidemargin, 4, sidemargin, 4)
	self.m_RightPanel:DockPadding(8,0,8,0)
	self.m_RightPanel:Dock(RIGHT)
	self.m_RightScroller:Dock(FILL)
	
	self.m_TopSpace.m_PointsLabel:AlignLeft(32*screenscale)
	self.m_TopSpace.m_PointsLabel:SetContentAlignment(6)
	
	self.m_TopSpace.m_PointsCounter:MoveRightOf(self.m_TopSpace.m_PointsLabel,2)
	self.m_TopSpace.m_PointsCounter:SetContentAlignment(4)
	
	self.m_TopSpace.m_CostCounter:SetContentAlignment(6)
	
	self.m_CurrentItemLabel:AlignLeft(4)
	self.m_CurrentItemLabel:CenterVertical()
	
	self.m_CenterImg:MoveRightOf(self.m_CurrentItemLabel,4)
	self.m_CenterImg:CenterVertical()	
	
	self.m_UpgradesScrollList:SetPadding(2)
	self.m_UpgradesScrollList:SetWide(self.m_LeftPanel:GetWide() - (self.m_CurrentItemLabel:GetWide() + self.m_CenterImg:GetWide()+16))
	self.m_UpgradesScrollList:MoveRightOf(self.m_CenterImg,4)
	self.m_UpgradesScrollList:CenterVertical()
	
	self.m_CloseButton:SetTall(topspacetall)
	self.m_CloseButton:SetWide(128*screenscale)
	self.m_CloseButton:SetContentAlignment(5)
	self.m_CloseButton:AlignRight(32)

	self.m_WeaponNameLabel:SetContentAlignment(8)
	self.m_WeaponNameLabel:AlignTop(4)
	self.m_WeaponNameLabel:CenterHorizontal()
	
	self.m_WeaponDescLabel:SetContentAlignment(7)
	self.m_WeaponDescLabel:SetTall(hei*0.4)
	self.m_WeaponDescLabel:SetWide(wid*0.35 - sidemargin*2)
	self.m_WeaponDescLabel:MoveBelow(self.m_WeaponNameLabel,4)
	self.m_WeaponDescLabel:CenterHorizontal()

	self.RefusePurchaseLabel:SetWide(wid*0.35 - sidemargin*2)
	self.RefusePurchaseLabel:SetContentAlignment(8)	
	self.RefusePurchaseLabel:CenterHorizontal()
	self.RefusePurchaseLabel:SetAutoStretchVertical(true)
	
	self.m_SwitchModeButton:SetTall(60*screenscale)
	self.m_SwitchModeButton:SetWide(256*screenscale)
	self.m_SwitchModeButton:SetContentAlignment(5)
	self.m_SwitchModeButton:AlignLeft(16)
	
	local pchsbtnmargin = math.min(wid*0.1,(wid*0.25 - sidemargin)-128*screenscale)
	self.PurchaseSelectedButton:DockMargin(pchsbtnmargin,0,pchsbtnmargin,0)
	self.PurchaseSelectedButton:Dock(BOTTOM)
	self.PurchaseSelectedButton:SetZPos(-1)
	self.PurchaseSelectedButton:MoveAbove(self.m_BottomSpace, 5)
end

function PANEL:Init()
	local screenscale = BetterScreenScale()
	local wid, hei = math.min(ScrW(), 1000) * screenscale, math.min(ScrH(), 800) * screenscale

	self:SetSize(wid, hei)

	self:SetDeleteOnClose(true)
	self:SetTitle(" ")
	self:SetDraggable(false)
	if self.btnClose and self.btnClose:Valid() then self.btnClose:SetVisible(false) end
	if self.btnMinim and self.btnMinim:Valid() then self.btnMinim:SetVisible(false) end
	if self.btnMaxim and self.btnMaxim:Valid() then self.btnMaxim:SetVisible(false) end
	self.OnClose = UpgradesOnClose
	
	GAMEMODE.m_UpgradesShop = self
	
	local topspace = vgui.Create("DPanel", self)
	local title = EasyLabel(topspace, "", "ZSHUDFontSmall", COLOR_WHITE)
	self.m_TitleLabel = title

	local pointslabel = EasyLabel(topspace, translate.Get("points"), "ZSHUDFontSmall", COLOR_WHITE)
	topspace.m_PointsLabel = pointslabel
	
	local pointscounter = EasyLabel(topspace, "0", "ZSHUDFontSmall", COLOR_GREEN)
	pointscounter.Think = upgrade_pointscounterThink
	topspace.m_PointsCounter = pointscounter
	
	local costcounter = EasyLabel(topspace, "", "ZSHUDFontSmall", COLOR_RED)
	costcounter.Think = upgrade_costcounterThink
	topspace.m_CostCounter = costcounter
	self.m_TopSpace = topspace
	
	local bottomspace = vgui.Create("DPanel", self)
	self.m_BottomSpace = bottomspace
	
	local upgradepanel = vgui.Create("DPanel",self)
	self.m_LeftPanel = upgradepanel
	
	local currentitemlabel = vgui.Create("ShopUpgradeCurrentItemLabel",upgradepanel)
	self.m_CurrentItemLabel = currentitemlabel
	
	local centerarrowimg = vgui.Create("DImage",upgradepanel)
	centerarrowimg:SetSize(48, 48)
	centerarrowimg:SetMouseInputEnabled(false)
	self.m_CenterImg = centerarrowimg
	
	local list = vgui.Create("DScrollPanel", upgradepanel)
	list:SetPaintBackground(false)
	self.m_UpgradesScrollList = list
	
	local rightinfopanel = vgui.Create("DPanel",self)
	self.m_RightPanel = rightinfopanel

	local closebutton = EasyButton(topspace, translate.Get("back_button"))
	closebutton:SetFont("ZSHUDFontSmaller")
	closebutton.DoClick = upgradesCloseDoClick
	self.m_CloseButton = closebutton
	
	local rightinfolist = vgui.Create("DScrollPanel", self.m_RightPanel)
	rightinfolist:SetPaintBackground(false)
	self.m_RightScroller = rightinfolist
	
	local wepname = EasyLabel(rightinfopanel, "", (screenscale > 0.9 and "ZSHUDFontSmaller" or "ZSHUDFontSmallest"), COLOR_GRAY)
	local wepdesc = EasyLabel(rightinfopanel, "", (screenscale > 0.9 and "ZSHUDFontSmallest" or "ZSHUDFontTiny"), COLOR_GRAY)
	wepdesc:SetWrap(true)
	self.m_WeaponDescLabel = wepdesc
	self.m_WeaponNameLabel = wepname
	self.m_RightScroller:AddItem(self.m_WeaponNameLabel)
	self.m_RightScroller:AddItem(self.m_WeaponDescLabel)
	
	local refusesellpanel = EasyLabel(rightinfopanel, "", "ZSHUDFontSmaller", COLOR_RED)
	refusesellpanel:SetWrap(true)
	self.RefusePurchaseLabel = refusesellpanel
	self.m_RightScroller:AddItem(self.RefusePurchaseLabel)
	
	local purchasebutton = vgui.Create("UpgradeSelectedButton", rightinfopanel)
	self.PurchaseSelectedButton = purchasebutton
	local switchmodebutton = EasyButton(bottomspace, "")
	switchmodebutton:SetFont("ZSHUDFontSmallest")
	switchmodebutton.DoClick = upgrade_switchModeDoClick
	self.m_SwitchModeButton = switchmodebutton
	
	self.m_WeaponFeatureLabels = {}
	self.m_IsRevertMode = false
	self.m_CurrentItemTab = nil
	self.CurrentID = nil	
	self:Center()
	self:MakePopup()
end

function PANEL:PopulateUpgradeList(id, weaponslot, upgrademode)
	local screenscale = BetterScreenScale()
	local tab = FindItem(id)
	if not tab then return end
	local itemslist = upgrademode and FindWeaponConsequents(id) or FindWeaponPrerequisites(id)
	if not istable(itemslist) then itemslist = {} end
	self.m_UpgradesScrollList:Clear()
	if !table.IsEmpty(itemslist) then
		local numitems = #itemslist
		self.m_UpgradesScrollList:SetTall((62*math.min(numitems,5))*screenscale)
		self.m_UpgradesScrollList:CenterVertical()
		for _, sig in ipairs(itemslist) do
			local itembut = vgui.Create("UpgradeItemButton")
			itembut:SetupItemButton(sig,weaponslot)
			itembut:Dock(TOP)
			self.m_UpgradesScrollList:AddItem(itembut)
		end
		self.RefusePurchaseLabel:SetText("")
	else
		self.RefusePurchaseLabel:SetText(self.m_IsRevertMode and translate.Get("weapon_has_no_prerequisites") or translate.Get("weapon_has_no_upgrades"))
	end
end

function PANEL:SetUpUpgradeMenu(id, weaponslot)
	local screenscale = BetterScreenScale()
	local tab = FindItem(id)
	if not tab then return end
	local swepname = tab.SWEP
	local nametext = ""
	local sweptable = weapons.GetStored(swepname)
	if sweptable then 
		nametext = sweptable.TranslateName and translate.Get(sweptable.TranslateName) or swepname
	end
	self.m_CurrentItemTab = tab
	self.m_TitleLabel:SetText(translate.Format("upgrading_x",nametext))
	self.PurchaseSelectedButton.BuyLabel:SetText(self.m_IsRevertMode and translate.Get("revert_item") or translate.Get("upgrade_item"))
	self.m_CurrentItemLabel:SetupItemLabel(tab.Signature)
	self.m_UpgradesScrollList:SetTall(60*screenscale)
	self:SetCurrentUpgradeMode(false)
	self:PopulateUpgradeList(id,weaponslot,true)
	SetViewer_upgrade(tab)
end

vgui.Register("DUpgradesShopFrame", PANEL, "DFrame")

function GM:OpenPointsShop(weaponslot)
	local oldpointshop = nil
	--[[if self.m_UpgradesShop and self.m_UpgradesShop:Valid() then
		self.m_UpgradesShop:Close()
	end]]
	if self.m_PointsShop and self.m_PointsShop:Valid() then
		oldpointshop = self.m_PointsShop
	end
	local shopframe = vgui.Create("DPointShopFrame")
	shopframe:SetUpPointsShop(weaponslot)
	if oldpointshop and oldpointshop:Valid() and ispanel(oldpointshop) then
		oldpointshop:Close()
	end
end

GM.OpenPointShop = GM.OpenPointsShop
