local PANEL = {}
PANEL.m_ItemID = 0
PANEL.RefreshTime = 1
PANEL.NextRefresh = 0

function PANEL:Init()
	self:SetFont("DefaultFontSmall")
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
		local newstate = (MySelf:GetPoints() >= itemtab.Worth * (GAMEMODE:IsClassicMode() and 0.75 or 1)
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
			if newstate then
				self:AlphaTo(255, 0.5, 0)
			else
				self:AlphaTo(75, 0.5, 0)
			end
		end
		local newcost = itemtab.Worth * (GAMEMODE:IsClassicMode() and 0.75 or 1)
		if newcost ~= self.m_LastPrice then
			self.PriceLabel:SetText(tostring(math.ceil(newcost)).." 포인트")	
			self.m_LastPrice = newcost
		end
	end
end

function PANEL:Init()
	self:SetText("")

	self:DockPadding(4, 4, 4, 4)
	self:SetTall(60)

	local mdlframe = vgui.Create("DEXRoundedPanel", self)
	mdlframe:SetWide(self:GetTall() - 8)
	mdlframe:Dock(LEFT)
	mdlframe:DockMargin(0, 0, 20, 0)

	self.ModelPanel = vgui.Create("DModelPanel", mdlframe)
	self.ModelPanel:Dock(FILL)
	self.ModelPanel:DockPadding(0, 0, 0, 0)
	self.ModelPanel:DockMargin(0, 0, 0, 0)

	self.NameLabel = EasyLabel(self, "", "ZSHUDFontSmall")
	self.NameLabel:SetContentAlignment(4)
	self.NameLabel:Dock(FILL)

	self.PriceLabel = EasyLabel(self, "", "ZSHUDFontTiny")
	self.PriceLabel:SetWide(120)
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
	if not tab then return end
	if not self.m_LastAbleToBuy then
		surface.PlaySound("buttons/button8.wav")
		return
	else
		surface.PlaySound("buttons/button17.wav")
		if (tab.Category == ITEMCAT_GUNS or tab.Category == ITEMCAT_MELEE or tab.Category == ITEMCAT_TOOLS) then
		Derma_Query("이 무기를 구매하시겠습니까?", tab.Name or "",
			"네", function() 
				RunConsoleCommand("zs_pointsshopbuy", self.ID, self.m_LoadoutSlot)
			end,
			"아니오", function() end)
		else
			RunConsoleCommand("zs_pointsshopbuy", self.ID, self.m_LoadoutSlot)
		end
	end
end

function PANEL:SetupItemButton(id,slot)
	self.ID = id
	self.m_LoadoutSlot = slot
	local tab = FindItem(id)

	if not tab then
		self.ModelPanel:SetVisible(false)
		self.ItemCounter:SetVisible(false)
		self.NameLabel:SetText("")
		return
	end

	local mdl = tab.Model or (weapons.GetStored(tab.SWEP) or tab).WorldModel
	if mdl then
		self.ModelPanel:SetModel(mdl)
		local mins, maxs = self.ModelPanel.Entity:GetRenderBounds()
		self.ModelPanel:SetCamPos(mins:Distance(maxs)*Vector(1,1,0.75))
		self.ModelPanel:SetLookAt((mins + maxs) / 2)
		self.ModelPanel:SetVisible(true)
	else
		self.ModelPanel:SetVisible(false)
	end

	if tab.SWEP or tab.Countables then
		self.ItemCounter:SetItemID(id)
		self.ItemCounter:SetVisible(true)
	else
		self.ItemCounter:SetVisible(false)
	end
	
	self.NameLabel:SetText(tab.Name or "")
	
	if tab.Worth then
		self.PriceLabel:SetText(tostring(tab.Worth).." 포인트")
		self.m_LastPrice = tab.Worth
	else
		self.PriceLabel:SetText("")
	end
	if tab.Description then
		self:SetTooltip(tab.Description)
	end
	

	self:SetAlpha(255)
end

function PANEL:Paint(w, h)
	local tab = FindItem(self.ID)
	local outline
	if self.Hovered then
		outline = self.m_LastAbleToBuy and COLOR_DARKGREEN or COLOR_DARKRED
	else
		outline = COLOR_DARKGRAY
	end

	draw.RoundedBox(8, 0, 0, w, h, outline)
	draw.RoundedBox(4, 4, 4, w - 8, h - 8, color_black)
end

vgui.Register("ShopItemButton", PANEL, "DButton")

if tab and tab.Worth <= MySelf:GetPoints() then return end

local function pointslabelThink(self)
	local points = MySelf:GetPoints()
	if self.m_LastPoints ~= points then
		self.m_LastPoints = points

		self:SetText("포인트: "..points)
		self:SizeToContents()
	end
end

local function PointsShopCenterMouse(self)
	local x, y = self:GetPos()
	local w, h = self:GetSize()
	gui.SetMousePos(x + w * 0.5, y + h * 0.5)
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
	if GAMEMODE:GetWave() ~= self.m_LastWaveWarning and not GAMEMODE:GetWaveActive() and CurTime() >= GAMEMODE:GetWaveStart() - 10 and CurTime() > (self.m_LastWaveWarningTime or 0) + 11 then
		self.m_LastWaveWarning = GAMEMODE:GetWave()
		self.m_LastWaveWarningTime = CurTime()

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
	RunConsoleCommand("zs_pointsshopbuy", "ps_"..ammonames[tostring(MySelf:GetActiveWeapon().Primary.Ammo)])
end


function GM:OpenPointsShop(weaponslot)
	if self.m_PointsShop and self.m_PointsShop:Valid() then
		self.m_PointsShop:SetVisible(true)
		self.m_PointsShop:CenterMouse()
		return
	end

	local wid, hei = math.min(ScrW(), 560), ScrH() * 0.7

	local frame = vgui.Create("DFrame")
	frame:SetSize(wid, hei)
	frame:Center()
	frame:SetDeleteOnClose(true)
	frame:SetTitle(" ")
	frame:SetDraggable(false)
	--if frame.btnClose and frame.btnClose:Valid() then frame.btnClose:SetVisible(false) end
	if frame.btnMinim and frame.btnMinim:Valid() then frame.btnMinim:SetVisible(false) end
	if frame.btnMaxim and frame.btnMaxim:Valid() then frame.btnMaxim:SetVisible(false) end
	frame.CenterMouse = PointsShopCenterMouse
	frame.Think = PointsShopThink
	self.m_PointsShop = frame

	local topspace = vgui.Create("DPanel", frame)
	topspace:SetWide(wid - 128)

	local title = EasyLabel(topspace, "포인트 상점", "ZSHUDFontSmall", COLOR_WHITE)
	if weaponslot == WEAPONLOADOUT_SLOT1 then
		title:SetText("무기 1 구매")
	elseif weaponslot == WEAPONLOADOUT_SLOT2 then
		title:SetText("무기 2 구매")
	elseif weaponslot == WEAPONLOADOUT_MELEE then
		title:SetText("근접 무기 구매")
	elseif weaponslot == WEAPONLOADOUT_TOOLS then
		title:SetText("도구 구매")
	end
	title:SizeToContents()
	title:CenterHorizontal()
	

	
	local _, y = title:GetPos()
	topspace:SetTall(y + title:GetTall() +16)
	topspace:AlignTop(8)
	topspace:CenterHorizontal()
	
	local help = EasyButton(topspace, "<도움말>", 8, 4)
	help:AlignRight(8)
	help:AlignTop(8)
	help.DoClick = helpDoClick

	local bottomspace = vgui.Create("DPanel", frame)
	bottomspace:SetWide(topspace:GetWide())

	local pointslabel = EasyLabel(bottomspace, "포인트: 0", "ZSHUDFontSmall", COLOR_GREEN)
	pointslabel:AlignTop(4)
	pointslabel:SetTall(40)
	pointslabel:AlignLeft(8)
	pointslabel.Think = pointslabelThink

	local currammo = EasyButton(bottomspace, "현재 무기 탄약 구매", 40, 8)
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
	propertysheet:SetSize(wid - 8, boty - topy - 8 - topspace:GetTall())
	propertysheet:MoveBelow(topspace, 4)
	propertysheet:CenterHorizontal()

	
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
			propertysheet:AddSheet(catname, list, GAMEMODE.ItemCategoryIcons[catid], false, false)
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
						local namelab = EasyLabel(tierheading,1+tab.Tier.."티어", "ZSHUDFontSmall", COLOR_WHITE)
						namelab:SetPos(tierheading:GetWide() * 0.5- namelab:GetWide() * 0.5, tierheading:GetTall() * 0.5 - namelab:GetTall() * 0.5)
						currenttier = currenttier + 1
					end
					local itembut = vgui.Create("ShopItemButton")
					itembut:SetupItemButton(i,weaponslot)
					if tab.NoClassicMode and isclassic then
						itembut:SetAlpha(120)
					end
					list:AddItem(itembut)
				end
				end
			end
		end
	end

	frame:MakePopup()
	frame:CenterMouse()
end

GM.OpenPointShop = GM.OpenPointsShop
