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
	
local function WeaponIconModel(class,parent,islarge)
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
		label:DockMargin(0, label:GetTall() * 0.05, 0, 0)
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
		local newcost = itemtab.Worth * (GAMEMODE:IsClassicMode() and 0.75 or 1)
		if newcost ~= self.m_LastPrice then
			self.PriceLabel:SetText(tostring(math.ceil(newcost)).." Pts")	
			self.m_LastPrice = newcost
		end
		local newstate = (MySelf:GetPoints() >= self.m_LastPrice
		and not (itemtab.SWEP and MySelf:HasWeapon(itemtab.SWEP))
		and not (not GAMEMODE:IsClassicMode() and itemtab.SWEP and MySelf:GetWeapon1() == itemtab.SWEP)
		and not (not GAMEMODE:IsClassicMode() and itemtab.SWEP and MySelf:GetWeapon2() == itemtab.SWEP)
		and not (not GAMEMODE:IsClassicMode() and itemtab.SWEP and MySelf:GetWeaponMelee() == itemtab.SWEP)
		and not (not GAMEMODE:IsClassicMode() and itemtab.SWEP and MySelf:GetWeaponToolslot() == itemtab.SWEP)
		and not (itemtab.NoClassicMode and GAMEMODE:IsClassicMode()) and 
		not (itemtab.NoSampleCollectMode and GAMEMODE:IsSampleCollectMode()) and 
		not (itemtab.SampleCollectModeOnly and not GAMEMODE:IsSampleCollectMode()))
		if newstate ~= self.m_LastAbleToBuy then
			self.m_LastAbleToBuy = newstate
		end
	end
end

function PANEL:Init()
	self:SetText("")

	self:DockPadding(4, 4, 4, 4)
	self:SetTall(60)

	self.IconFrame = vgui.Create("DEXRoundedPanel", self)
	self.IconFrame:SetWide(self:GetTall() *2)
	self.IconFrame:SetTall(self:GetTall()-8)
	self.IconFrame:Dock(LEFT)
	self.IconFrame:DockMargin(0, 0, 20, 0)

	self.NameLabel = EasyLabel(self, "", "ZSHUDFontSmaller")
	self.NameLabel:SetContentAlignment(4)
	self.NameLabel:Dock(TOP)

	self.PriceLabel = EasyLabel(self, "", "ZSHUDFontSmaller")
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

local function SetWeaponViewerSWEP(swep)
	local sweptable = weapons.GetStored(swep)
	if not sweptable then return end
	local frame = GAMEMODE.m_PointsShop
	if frame.m_WeaponViewer and frame.m_WeaponViewer:Valid() then
		frame.m_WeaponViewer:Remove()
	end
	local wid, hei = math.min(ScrW(), 760), ScrH() * 0.7
	local weaponviewer = vgui.Create("DPanel", frame)
	weaponviewer:SetSize(wid*0.4, hei*0.6)
	weaponviewer:DockPadding(8, 0, 8, 0)
	if frame.m_TopSpace then
		weaponviewer:MoveBelow(frame.m_TopSpace, 4)
	end
	weaponviewer:AlignRight(0)
	frame.m_WeaponViewer = weaponviewer
	
	local title = EasyLabel(weaponviewer, sweptable.TranslateName and translate.Get(sweptable.TranslateName) or swep, "ZSHUDFontSmall", COLOR_GRAY)
	title:SetContentAlignment(8)
	title:Dock(TOP)
	local text = ""

	if sweptable.TranslateDesc then
		text = text..translate.Get(sweptable.TranslateDesc)
	end

	local desc = EasyLabel(weaponviewer, text, "ZSHUDFontSmallest", COLOR_GRAY)
	desc:SetMultiline(true)
	desc:SetContentAlignment(7)
	desc:SetWrap(true)
	desc:Dock(FILL)
end


function PANEL:DoClick()
	local id = self.ID
	local tab = FindItem(id)
	if not tab then return end
	if !GAMEMODE.m_PointsShop or !GAMEMODE.m_PointsShop:Valid() then return end
	if not tab.SWEP then return end
	surface.PlaySound("buttons/button17.wav")
	SetWeaponViewerSWEP(tab.SWEP)
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
	if tab.SWEP then
		self.IconFrame:SetVisible(true)
		WeaponIconModel(tab.SWEP,self.IconFrame)
	end
	if tab.SWEP or tab.Countables then
		self.ItemCounter:SetItemID(id)
		self.ItemCounter:SetVisible(true)
	else
		self.ItemCounter:SetVisible(false)
	end
	
	self.NameLabel:SetText(weapons.GetStored(tab.SWEP).TranslateName and translate.Get(weapons.GetStored(tab.SWEP).TranslateName) or "")
	
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
	local itemtab = FindItem(id)
	if itemtab then 
		local newcost = itemtab.Worth * (GAMEMODE:IsClassicMode() and 0.75 or 1)
		if newcost ~= self.m_LastPrice then
			self.m_LastPrice = newcost
		end
		local enoughcost = MySelf:GetPoints() >= self.m_LastPrice
		local notduplicate = not (itemtab.SWEP and MySelf:HasWeapon(itemtab.SWEP))
		and not (not GAMEMODE:IsClassicMode() and itemtab.SWEP and MySelf:GetWeapon1() == itemtab.SWEP)
		and not (not GAMEMODE:IsClassicMode() and itemtab.SWEP and MySelf:GetWeapon2() == itemtab.SWEP)
		and not (not GAMEMODE:IsClassicMode() and itemtab.SWEP and MySelf:GetWeaponMelee() == itemtab.SWEP)
		and not (not GAMEMODE:IsClassicMode() and itemtab.SWEP and MySelf:GetWeaponToolslot() == itemtab.SWEP)
		local fitformode = not (itemtab.NoClassicMode and GAMEMODE:IsClassicMode()) and 
		not (itemtab.NoSampleCollectMode and GAMEMODE:IsSampleCollectMode()) and 
		not (itemtab.SampleCollectModeOnly and not GAMEMODE:IsSampleCollectMode())
		local newstate = enoughcost and notduplicate and fitformode
		if newstate ~= self.m_LastAbleToBuy then
			self.m_LastAbleToBuy = newstate
			if newstate then
				self:AlphaTo(255, 0.5, 0)
			else
				self:AlphaTo(75, 0.5, 0)
			end
		end
		local refusepurchasereasons = ""
		if !fitformode then
			refusepurchasereasons = translate.Get("cant_purchase_in_this_mode")
		elseif !notduplicate then 
			refusepurchasereasons = translate.Get("already_have_weapon")
		elseif !enoughcost then 
			refusepurchasereasons = translate.Get("dont_have_enough_points") .."\n".."("..translate.Format("require_x_more_points",self.m_LastPrice-MySelf:GetPoints())..")"
		end
		refusesellpanel:SetText(refusepurchasereasons)
	else
		self.m_LastAbleToBuy = false
		self:AlphaTo(75, 0.1, 0)
	end
end

function PANEL:Init()
	self:SetText("")

	self:DockPadding(4, 4, 4, 4)
	self:SetTall(60)

	self.BuyLabel = EasyLabel(self, translate.Get("purchase_item"), "ZSHUDFont")
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

if tab and tab.Worth <= MySelf:GetPoints() then return end

local function pointscounterThink(self)
	local points = MySelf:GetPoints()
	if self.m_LastPoints ~= points then
		self.m_LastPoints = points
		self:SetText(points)
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
local function currentAmmoDoClick()
	if not ammonames[tostring(MySelf:GetActiveWeapon().Primary.Ammo)] then return end
	RunConsoleCommand("zsb_pointsshopbuy", "ps_"..ammonames[tostring(MySelf:GetActiveWeapon().Primary.Ammo)])
end

local function PointsShopOnClose()
	if GAMEMODE.HumanMenuPanel and GAMEMODE.HumanMenuPanel:Valid() then
		GAMEMODE.HumanMenuPanel:CloseMenu()
	end
end

function GM:OpenPointsShop(weaponslot)
	if self.m_PointsShop and self.m_PointsShop:Valid() then
		self.m_PointsShop:Close()
		if not self:IsClassicMode() then
			gamemode.Call("HumanMenu")
		end
	end

	local wid, hei = math.min(ScrW(), 760), ScrH() * 0.7
	
	local frame = vgui.Create("DFrame")
	frame:SetSize(wid, hei)
	frame:Center()
	frame:SetDeleteOnClose(true)
	frame:SetTitle(" ")
	frame:SetDraggable(false)
	--if frame.btnClose and frame.btnClose:Valid() then frame.btnClose:SetVisible(false) end
	if frame.btnMinim and frame.btnMinim:Valid() then frame.btnMinim:SetVisible(false) end
	if frame.btnMaxim and frame.btnMaxim:Valid() then frame.btnMaxim:SetVisible(false) end
	frame.Think = PointsShopThink
	frame.CurrentID = nil
	frame.OnClose = PointsShopOnClose
	self.m_PointsShop = frame
	local topspace = vgui.Create("DPanel", frame)
	topspace:SetWide(wid - 64)
	frame.m_TopSpace = topspace
	
	local title = EasyLabel(topspace, translate.Get("pointshop_title"), "ZSHUDFontSmall", COLOR_WHITE)
	local wep = nil
	if weaponslot == WEAPONLOADOUT_SLOT1 then
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
	topspace:AlignTop(8)
	topspace:CenterHorizontal()
	
	local pointslabel = EasyLabel(topspace, translate.Get("points"), "ZSHUDFontSmall", COLOR_WHITE)
	local pointscounter = EasyLabel(topspace, "0", "ZSHUDFontSmall", COLOR_GREEN)
	pointscounter.Think = pointscounterThink
	
	local div = vgui.Create( "DHorizontalDivider", topspace )
	div:SetLeft( pointslabel )
	div:SetRight( pointscounter )
	div:SetDividerWidth( 2 )
	div:SizeToContents()
	div:SetRightMin( 20 )
	div:SetLeftWidth( 100 )
	div:AlignTop(4)
	div:SetTall(40)
	div:SetWide(256)
	div:AlignLeft(4)
	
	local help = EasyButton(topspace, translate.Get("button_help"), 14, 6)
	help:SetFont("ZSHUDFontSmaller")
	help:AlignRight(8)
	help:AlignTop(8)
	help.DoClick = helpDoClick

	local bottomspace = vgui.Create("DPanel", frame)
	bottomspace:SetWide(topspace:GetWide())
	frame.m_BottomSpace = bottomspace
	
	local currammo = EasyButton(bottomspace, translate.Get("button_buyammo"), 40, 8)
	currammo:SetFont("ZSHUDFontSmaller")
	currammo:AlignRight(8)
	currammo:AlignTop(0)
	currammo.DoClick = currentAmmoDoClick
	
	local _, y = pointslabel:GetPos()
	bottomspace:SetTall(40)
	bottomspace:AlignBottom(8)
	bottomspace:CenterHorizontal()

	local topx, topy = topspace:GetPos()
	local botx, boty = bottomspace:GetPos()

	local propertysheet = vgui.Create("DPropertySheet", frame)
	propertysheet:SetSize(wid*0.6, boty - topy - 8 - topspace:GetTall())
	propertysheet:MoveBelow(topspace, 4)
	propertysheet:AlignLeft(0)
	
	local purchasebutton = vgui.Create("BuySelectedButton", frame)
	purchasebutton:SetWide(wid*0.3)
	purchasebutton:AlignRight(wid*0.05)
	purchasebutton:MoveAbove(bottomspace,10)
	
	local refusesellpanel = EasyLabel(frame, "", "ZSHUDFontSmaller", COLOR_RED)
	refusesellpanel:SetWide(wid*0.4)
	refusesellpanel:SetTall(hei*0.2)
	refusesellpanel:AlignRight(0)
	refusesellpanel:MoveAbove(purchasebutton,10)
	refusesellpanel:SetMultiline(true)
	refusesellpanel:SetContentAlignment(7)
	refusesellpanel:SetWrap(true)
	frame.RefusePurchaseLabel = refusesellpanel
	local sweptable = nil
	for catid, catname in ipairs(GAMEMODE.ItemCategories) do
		local hasitems = false
		for i, tab in ipairs(GAMEMODE.Items) do
			if tab.Category == catid then
				hasitems = true
				break
			end
		end

		if hasitems and 
		((weaponslot == WEAPONLOADOUT_SLOT1 or weaponslot == WEAPONLOADOUT_SLOT2) and catid == ITEMCAT_GUNS 
		or weaponslot == WEAPONLOADOUT_MELEE and catid == ITEMCAT_MELEE 
		or weaponslot == WEAPONLOADOUT_TOOLS and catid == ITEMCAT_TOOLS
		or (weaponslot == WEAPONLOADOUT_NULL or not weaponslot) and (GAMEMODE:IsClassicMode() or (catid ~= ITEMCAT_MELEE and catid ~= ITEMCAT_GUNS and catid ~= ITEMCAT_TOOLS))) then
			local list = vgui.Create("DPanelList", propertysheet)
			list:SetPaintBackground(false)
			propertysheet:AddSheet(translate.Get(catname), list, GAMEMODE.ItemCategoryIcons[catid], false, false)
			list:EnableVerticalScrollbar(true)
			list:SetWide(propertysheet:GetWide() - 16)
			list:SetSpacing(2)
			list:SetPadding(2)
			local currenttier = -1
			for i, tab in ipairs(GAMEMODE.Items) do
				if not (GAMEMODE:IsClassicMode() and tab.NoClassicMode) and 
				not (tab.NoSampleCollectMode and GAMEMODE:IsSampleCollectMode()) and 
				not (tab.SampleCollectModeOnly and not GAMEMODE:IsSampleCollectMode())then 
				local weptab = weapons.GetStored(tab.SWEP) or tab
				if tab.Category == catid then
					if tab.Category == ITEMCAT_GUNS and weptab and tab.Tier ~= nil and (currenttier == nil  or currenttier < tab.Tier) then
						local tierheading = vgui.Create("DPanel")
						tierheading:SetSize(list:GetWide(), 40)
						list:AddItem(tierheading)
						local namelab = EasyLabel(tierheading,translate.Format("tier_x",1+tab.Tier), "ZSHUDFontSmall", COLOR_WHITE)
						namelab:SetPos(tierheading:GetWide() * 0.5- namelab:GetWide() * 0.5, tierheading:GetTall() * 0.5 - namelab:GetTall() * 0.5)
						currenttier = currenttier + 1
					end
					local itembut = vgui.Create("ShopItemButton")
					itembut:SetupItemButton(i,weaponslot)
					if tab.SWEP == wep then 
						frame.CurrentID = i
						SetWeaponViewerSWEP(tab.SWEP)
					end
					if tab.NoClassicMode and isclassic then
						itembut:SetAlpha(120)
					end
					sweptable = weapons.GetStored(tab.SWEP)
					list:AddItem(itembut)
				end
				end
			end
		end
	end
	
	frame:MakePopup()
end

GM.OpenPointShop = GM.OpenPointsShop
