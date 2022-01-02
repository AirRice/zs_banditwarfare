local PANEL = {}
PANEL.m_ItemID = 0
PANEL.RefreshTime = 1
PANEL.NextRefresh = 0

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

function PANEL:Init()
	self:SetFont("DefaultFontLarge")
	self:Dock(BOTTOM)
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
		local slot = GAMEMODE.m_PointsShop.m_WepSlot
		local canpurchase, reasons = PlayerCanPurchasePointshopItem(MySelf,itemtab,slot)
		local newcost = math.floor(itemtab.Worth * ((GAMEMODE:IsClassicMode() and itemtab.Category ~= ITEMCAT_OTHER) and 0.75 or 1))
		if newcost ~= self.m_LastPrice then
			self.PriceLabel:SetText(tostring(math.ceil(newcost)).." Pts")	
			self.m_LastPrice = newcost
		end
		if canpurchase ~= self.m_LastAbleToBuy then
			self.m_LastAbleToBuy = newstate
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

	frame.m_WeaponDescLabel:SetText(desctext)
	frame.m_WeaponNameLabel:SetText(nametext)
end

function PANEL:Init()
	self:SetText("")
	self:DockMargin(0, 0, 0, 2)
	self:DockPadding(4, 4, 4, 4)
	self:SetTall(60)

	self.IconFrame = vgui.Create("DEXRoundedPanel", self)
	self.IconFrame:SetWide(self:GetTall() *2)
	self.IconFrame:SetTall(self:GetTall()-8)
	self.IconFrame:Dock(LEFT)
	self.IconFrame:DockMargin(0, 0, 8, 0)

	self.NameLabel = EasyLabel(self, "", "ZSHUDFontSmallest")
	self.NameLabel:SetContentAlignment(4)
	self.NameLabel:Dock(TOP)

	self.PriceLabel = EasyLabel(self, "", "ZSHUDFontSmallest")
	self.PriceLabel:SetWide(100)
	self.PriceLabel:SetContentAlignment(6)
	self.PriceLabel:Dock(RIGHT)
	self.PriceLabel:DockMargin(8, 0, 4, 0)

	self.ItemCounter = vgui.Create("ItemAmountCounter", self)
	
	self.Think = ItemButtonThink
	self.m_LastAbleToBuy = true
	self.m_LastPrice = nil
	self.m_LoadoutSlot = WEAPONLOADOUT_NULL
	self:SetupItemButton(nil,nil)
end

function PANEL:DoClick()
	local id = self.ID
	local tab = FindItem(id)
	local consequents = FindWeaponConsequents(id)
	if not tab then return end
	if !GAMEMODE.m_PointsShop or !GAMEMODE.m_PointsShop:Valid() then return end
	SetViewer(tab)
	surface.PlaySound("buttons/button17.wav")
	
	GAMEMODE.m_PointsShop.CurrentID = id
	GAMEMODE.m_PointsShop.m_LoadoutSlot = self.m_LoadoutSlot
	--[[if not self.m_LastAbleToBuy then
		surface.PlaySound("buttons/button8.wav")
		return
	else
		surface.PlaySound("buttons/button17.wav")
		if (tab.Category == ITEMCAT_GUNS or tab.Category == ITEMCAT_MELEE or tab.Category == ITEMCAT_TOOLS) then
		Derma_Query("이 무기를 구매하시겠습니까?", tab.Name or "",
			"네", function() 
				RunConsoleCommand("zsb_pointsshopbuy", self.ID, self.m_LoadoutSlot)
				if not GAMEMODE:IsClassicMode() and (self.m_LoadoutSlot == WEAPONLOADOUT_SLOT1 or self.m_LoadoutSlot == WEAPONLOADOUT_SLOT2 or self.m_LoadoutSlot == WEAPONLOADOUT_MELEE or self.m_LoadoutSlot == WEAPONLOADOUT_TOOLS) then
					if GAMEMODE.m_PointsShop and GAMEMODE.m_PointsShop:Valid() then
						GAMEMODE.m_PointsShop:Close()
					end
				end
			end,
			"아니오", function() end)
		else
			RunConsoleCommand("zsb_pointsshopbuy", self.ID, self.m_LoadoutSlot)
		end
	end]]
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
	
	--[[if tab.Worth then
		self.PriceLabel:SetText(tostring(tab.Worth).." Pts")
		self.m_LastPrice = tab.Worth
	else
		self.PriceLabel:SetText("")
	end]]

	self:SetAlpha(255)
end

function PANEL:Paint(w, h)
	local tab = FindItem(self.ID)
	local outline
	if not GAMEMODE.m_PointsShop and GAMEMODE.m_PointsShop:Valid() then return end
	if self.ID == GAMEMODE.m_PointsShop.CurrentID then
		outline = self.m_LastAbleToBuy and COLOR_LIMEGREEN or COLOR_RED
	elseif self.Hovered then
		outline = self.m_LastAbleToBuy and COLOR_DARKGREEN or COLOR_DARKRED
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
	local slot = GAMEMODE.m_PointsShop.m_WepSlot
	local itemtab = FindItem(id)
	if itemtab then 
		local canpurchase, reasons = PlayerCanPurchasePointshopItem(MySelf,itemtab,slot)
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

function PANEL:Init()
	self:SetText("")

	self:DockPadding(4, 4, 4, 4)
	self:SetTall(60)

	self.BuyLabel = EasyLabel(self, translate.Get("purchase_item"), "ZSHUDFontSmall")
	self.BuyLabel:SetContentAlignment(5)
	self.BuyLabel:Dock(FILL)

	self.Think = PurchaseButtonThink
	self.m_LastAbleToBuy = true
	self.m_LastPrice = nil
end

function PANEL:DoClick()
	local id = GAMEMODE.m_PointsShop.CurrentID
	local tab = FindItem(id)
	if not tab then return end
	if not self.m_LastAbleToBuy then
		surface.PlaySound("buttons/button8.wav")
		return
	else
		surface.PlaySound("buttons/button17.wav")
		if GAMEMODE.m_PointsShop and GAMEMODE.m_PointsShop:Valid() then
			local loadoutslot = GAMEMODE.m_PointsShop.m_LoadoutSlot
			if (tab.Category == ITEMCAT_GUNS or tab.Category == ITEMCAT_MELEE or tab.Category == ITEMCAT_TOOLS) then
				RunConsoleCommand("zsb_pointsshopbuy", id, loadoutslot)
				if not GAMEMODE:IsClassicMode() and (loadoutslot == WEAPONLOADOUT_SLOT1 or loadoutslot == WEAPONLOADOUT_SLOT2 or loadoutslot == WEAPONLOADOUT_MELEE or loadoutslot == WEAPONLOADOUT_TOOLS) then
					GAMEMODE.m_PointsShop:Close()
				end
			else
				RunConsoleCommand("zsb_pointsshopbuy", id, self)
			end
		end
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

vgui.Register("BuySelectedButton", PANEL, "DButton")

PANEL = {}

vgui.Register("UpgradeButton", PANEL, "DButton")

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
		local cost = itemtab.Worth
		cost = math.floor(cost * ((GAMEMODE:IsClassicMode() and itemtab.Category ~= ITEMCAT_OTHER) and 0.75 or 1))
		if self.m_LastCost ~= cost then
			self.m_LastCost = cost
			self:SetText("-"..cost)
			self:SizeToContents()
		end
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
	if GAMEMODE.HumanMenuPanel and GAMEMODE.HumanMenuPanel:Valid() then
		GAMEMODE.HumanMenuPanel:CloseMenu()
	end
end

function GM:ConfigureMenuTabs(tabs, tabhei, callback)
	local screenscale = BetterScreenScale()

	for _, tab in pairs(tabs) do
		tab:DockMargin(2,0,2,0)
		tab:SetFont(screenscale > 0.85 and "ZSIconFont" or "DefaultFontAA")
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

function GM:OpenPointsShop(weaponslot)
	if self.m_PointsShop and self.m_PointsShop:Valid() then
		self.m_PointsShop:Close()
		if not self:IsClassicMode() then
			gamemode.Call("HumanMenu")
		end
	end
	
	local screenscale = BetterScreenScale()
	local wid, hei = math.min(ScrW(), 1000) * screenscale, math.min(ScrH(), 800) * screenscale
	local tabhei = 26 * screenscale	
	
	local frame = vgui.Create("DFrame")
	frame:SetSize(wid, hei)
	frame:Center()
	frame:SetDeleteOnClose(true)
	frame:SetTitle(" ")
	frame:SetDraggable(false)
	if frame.btnClose and frame.btnClose:Valid() then frame.btnClose:SetVisible(false) end
	if frame.btnMinim and frame.btnMinim:Valid() then frame.btnMinim:SetVisible(false) end
	if frame.btnMaxim and frame.btnMaxim:Valid() then frame.btnMaxim:SetVisible(false) end
	frame.Think = PointsShopThink
	frame.OnClose = PointsShopOnClose
	
	frame.m_WepSlot = weaponslot
	
	local topspace = vgui.Create("DPanel", frame)
	topspace:SetWide(wid - 16)
	self.m_PointsShop = frame
	local title = EasyLabel(topspace, translate.Get("pointshop_title"), "ZSHUDFontSmall", COLOR_WHITE)
	local wep = nil
	if self:IsClassicMode() and (weaponslot == WEAPONLOADOUT_NULL or not weaponslot) then
		local activewep = MySelf:GetActiveWeapon()
		if activewep and activewep:IsValid() then wep = activewep:GetClass() end
	elseif weaponslot == WEAPONLOADOUT_SLOT1 then
		title:SetText(translate.Get("pointshop_title_guns1"))
		wep = MySelf:GetWeapon1()
	elseif weaponslot == WEAPONLOADOUT_SLOT2 then
		title:SetText(translate.Get("pointshop_title_guns2"))
		wep = MySelf:GetWeapon2()
	elseif weaponslot == WEAPONLOADOUT_MELEE then
		title:SetText(translate.Get("pointshop_title_melee"))
		wep = MySelf:GetWeaponMelee()
	elseif weaponslot == WEAPONLOADOUT_TOOLS then
		title:SetText(translate.Get("pointshop_title_tools"))
		wep = MySelf:GetWeaponToolslot()	
	end
	title:SizeToContents()
	title:CenterHorizontal()

	local _, y = title:GetPos()
	topspace:SetTall(y + title:GetTall() +16)
	topspace:Dock(TOP)
	topspace:CenterHorizontal()
	
	local pointslabel = EasyLabel(topspace, translate.Get("points"), "ZSHUDFontSmall", COLOR_WHITE)
	pointslabel:AlignLeft(32)
	pointslabel:SetContentAlignment(6)
	local pointscounter = EasyLabel(topspace, "0", "ZSHUDFontSmall", COLOR_GREEN)
	pointscounter:MoveRightOf(pointslabel,2)
	pointscounter:SetContentAlignment(4)
	pointscounter.Think = pointscounterThink
	topspace.m_PointsCounter = pointscounter
	local costcounter = EasyLabel(topspace, "", "ZSHUDFontSmall", COLOR_RED)
	costcounter:SetContentAlignment(6)
	costcounter.Think = costcounterThink
	topspace.m_CostCounter = costcounter
	local closebutton = EasyButton(topspace, translate.Get("close_button"))
	closebutton:SetTall(topspace:GetTall())
	closebutton:SetWide(128)
	closebutton:SetContentAlignment(5)
	closebutton:SetFont("ZSHUDFontSmaller")
	closebutton:AlignRight(32)
	closebutton.DoClick = closeDoClick
	
	local help = EasyButton(topspace, translate.Get("button_help"))
	help:SetTall(topspace:GetTall())
	help:SetWide(128)
	help:SetFont("ZSHUDFontSmaller")
	help:SetContentAlignment(5)
	help:MoveLeftOf(closebutton, 8 )
	help.DoClick = helpDoClick
	
	frame.m_TopSpace = topspace
	
	local bottomspace = vgui.Create("DHorizontalScroller", frame)
	bottomspace:SetTall(60)
	bottomspace:Dock(BOTTOM)
	bottomspace:CenterHorizontal()
	bottomspace:SetOverlap(-8)
	bottomspace:DockMargin(4,0,4,0)
	
	frame.m_BottomSpace = bottomspace

	local sidemargin = 4
	
	local propertysheet = vgui.Create("DPropertySheet", frame)
	propertysheet:SetWide(wid*0.5 - sidemargin*2)
	propertysheet:DockMargin(sidemargin, 4, sidemargin, 4)
	propertysheet:Dock(LEFT)
	propertysheet:SetPadding(2)
	
	local rightinfopanel = vgui.Create("DPanel",frame)
	rightinfopanel:SetWide(wid*0.5 - sidemargin*2)
	rightinfopanel:SetTall(propertysheet:GetTall())
	rightinfopanel:DockMargin(sidemargin, 4, sidemargin, 4)
	rightinfopanel:DockPadding(8,0,8,0)
	rightinfopanel:Dock(RIGHT)


	local wepname = EasyLabel(rightinfopanel, "", "ZSHUDFontSmaller", COLOR_GRAY)
	wepname:SetContentAlignment(8)
	wepname:Dock(TOP)
	wepname:SetBGColor(255,255,255,255)
	local wepdesc = EasyLabel(rightinfopanel, "", "ZSHUDFontSmallest", COLOR_GRAY)
	wepdesc:SetMultiline(true)
	wepdesc:SetContentAlignment(7)
	wepdesc:SetWrap(true)
	wepdesc:Dock(FILL)
	wepdesc:SetBGColor(255,255,255,255)
	frame.m_WeaponDescLabel = wepdesc
	frame.m_WeaponNameLabel = wepname
	
	local refusesellpanel = EasyLabel(rightinfopanel, "", "ZSHUDFontSmaller", COLOR_RED)
	refusesellpanel:Dock(BOTTOM)
	refusesellpanel:SetMultiline(true)
	refusesellpanel:SetContentAlignment(8)
	refusesellpanel:SetWrap(true)
	refusesellpanel:MoveBelow(wepdesc, 5)
	frame.RefusePurchaseLabel = refusesellpanel
	
	
	local purchasebutton = vgui.Create("BuySelectedButton", rightinfopanel)
	local pchsbtnmargin = math.min(wid*0.1,(wid*0.25 - sidemargin)-128)
	purchasebutton:DockMargin(pchsbtnmargin,0,pchsbtnmargin,0)
	purchasebutton:Dock(BOTTOM)
	purchasebutton:SetZPos(-1)
	purchasebutton:MoveAbove(bottomspace, 5)
	
	local sweptable = nil
	frame.CurrentID = nil
	
	if GAMEMODE:IsClassicMode() then
		for catid, catname in ipairs(GAMEMODE.ItemCategories) do
			local hasitems = false
			for i, tab in ipairs(GAMEMODE.Items) do
				if tab.Category == catid then
					hasitems = true
					break
				end
			end
			local currentweppanel = nil
			local currentwepcatname = nil
			if hasitems then
				local list = vgui.Create("DScrollPanel", propertysheet)
				list:SetPaintBackground(false)
				list:SetPadding(2)
				for i, tab in ipairs(GAMEMODE.Items) do
					if not (tab.NoClassicMode) then--and (!tab.Prerequisites) then 
						local weptab = weapons.GetStored(tab.SWEP) or tab
						if tab.Category == catid then
							local itembut = vgui.Create("ShopItemButton")
							itembut:SetupItemButton(i,weaponslot)
							itembut:Dock(TOP)
							list:AddItem(itembut)
							if tab.SWEP == wep then 
								frame.CurrentID = i
								SetViewer(tab)
								currentweppanel = itembut
								currentwepcatname = catname
							end
						end
					end
				end
				local sheet = propertysheet:AddSheet(translate.Get(catname), list, GAMEMODE.ItemCategoryIcons[catid], false, false)
				sheet.Panel:SetPos(0, tabhei + 2)
				if currentweppanel then
					propertysheet:SwitchToName(translate.Get(currentwepcatname))
					timer.Simple( 0.02, function() list:ScrollToChild(currentweppanel) end)
				end
				local scroller = propertysheet:GetChildren()[1]
				local dragbase = scroller:GetChildren()[1]
				local tabs = dragbase:GetChildren()
				self:ConfigureMenuTabs(tabs, tabhei)
			end
		end
	else
		local catid = nil
		if (weaponslot == WEAPONLOADOUT_SLOT1 or weaponslot == WEAPONLOADOUT_SLOT2) then
			catid = ITEMCAT_GUNS 
		elseif weaponslot == WEAPONLOADOUT_MELEE then
			catid = ITEMCAT_MELEE 
		elseif weaponslot == WEAPONLOADOUT_TOOLS then
			catid = ITEMCAT_TOOLS
		elseif (weaponslot == WEAPONLOADOUT_NULL or not weaponslot) then
			catid = ITEMCAT_CONS
		end
		local hasitems = false
		for i, tab in ipairs(GAMEMODE.Items) do
			if tab.Category == catid then
				hasitems = true
				break
			end
		end
		if not hasitems then return end
		local currentweppanel = nil
		local list = vgui.Create("DScrollPanel", propertysheet)
		list:SetPaintBackground(false)
		list:SetPadding(2)
		for i, tab in ipairs(GAMEMODE.Items) do
			if not (tab.NoSampleCollectMode and GAMEMODE:IsSampleCollectMode()) and 
			not (tab.SampleCollectModeOnly and not GAMEMODE:IsSampleCollectMode()) then--and (!tab.Prerequisites) then 
				local weptab = weapons.GetStored(tab.SWEP) or tab
				if tab.Category == catid then
					local itembut = vgui.Create("ShopItemButton")
					itembut:SetupItemButton(i,weaponslot)
					itembut:Dock(TOP)
					list:AddItem(itembut)
					if tab.SWEP == wep then 
						frame.CurrentID = i
						SetViewer(tab)
						currentweppanel = itembut
					end
				end
			end
		end
		local sheet = propertysheet:AddSheet(translate.Get(GAMEMODE.ItemCategories[catid]), list, GAMEMODE.ItemCategoryIcons[catid], false, false)
		sheet.Panel:SetPos(0, tabhei + 2)
		if currentweppanel then
			timer.Simple( 0.02, function() list:ScrollToChild(currentweppanel) end)
		end
		local scroller = propertysheet:GetChildren()[1]
		local dragbase = scroller:GetChildren()[1]
		local tabs = dragbase:GetChildren()
		self:ConfigureMenuTabs(tabs, tabhei)
	end

	for i, tab in ipairs(GAMEMODE.Items) do
		if tab.Category == ITEMCAT_OTHER then
			if not (GAMEMODE:IsClassicMode() and tab.NoClassicMode) and 
			not (tab.NoSampleCollectMode and GAMEMODE:IsSampleCollectMode()) and 
			not (tab.SampleCollectModeOnly and not GAMEMODE:IsSampleCollectMode())then 
				local itembut = vgui.Create("ShopItemButton",bottomspace)
				itembut:SetupItemButton(i,WEAPONLOADOUT_NULL)
				itembut:SetWide(156)
				bottomspace:AddPanel(itembut)
			end
		end
	end	
	frame:MakePopup()
end

GM.OpenPointShop = GM.OpenPointsShop
