local PANEL = {}

PANEL.Spacing = 8

function PANEL:Init()
	self:SetPos(ScrW() - 1, 0)
	self.WeaponButtons = {}
	local wep1button = vgui.Create("DWeaponLoadoutPanel", self)
	wep1button:SetWeaponSlot(WEAPONLOADOUT_SLOT1)
	wep1button:SetParent(self)
	table.insert(self.WeaponButtons, wep1button)
	local wep2button = vgui.Create("DWeaponLoadoutPanel", self)
	wep2button:SetWeaponSlot(WEAPONLOADOUT_SLOT2)
	wep2button:SetParent(self)
	table.insert(self.WeaponButtons, wep2button)
	local wepmeleebutton = vgui.Create("DWeaponLoadoutPanel", self)
	wepmeleebutton:SetWeaponSlot(WEAPONLOADOUT_MELEE)
	wepmeleebutton:SetParent(self)
	table.insert(self.WeaponButtons, wepmeleebutton)
	local weptoolbutton = vgui.Create("DWeaponLoadoutPanel", self)
	weptoolbutton:SetWeaponSlot(WEAPONLOADOUT_TOOLS)
	weptoolbutton:SetParent(self)
	table.insert(self.WeaponButtons, weptoolbutton)
	local but = EasyButton(self, translate.Get("consumables_purchase_button"), 0, 0)
	but:SetFont("ZSHUDFontSmall")
	but:SetContentAlignment(5)
	but:SetTall(64)
	but:DockMargin(0,32,0,16)	
	but:Dock(TOP)
	but:SetZPos(1100)
	but.DoClick = 
	function() 
		GAMEMODE:OpenPointsShop(WEAPONLOADOUT_NULL)
		surface.PlaySound("buttons/button15.wav") 
	end
	self:RefreshSize()
end


function PANEL:RefreshSize()
	local screenscale = BetterScreenScale()
	self:SetSize(screenscale * 300, ScrH())
	for k, item in pairs(self.WeaponButtons) do
		if item and item:Valid() then
			item:SetWide(self:GetWide() - 16)
			item:SetTall(screenscale * 210)
		end
	end
end

function PANEL:OpenMenu()
	self:RefreshSize()
	self:SetPos(ScrW() - self:GetWide(), 0, 0, 0, 0)
	self:SetVisible(true)
	self:MakePopup()
	self.StartChecking = RealTime() + 0.1
end

function PANEL:CloseMenu()
	self:SetVisible(false)
end

local texRightEdge = surface.GetTextureID("gui/gradient")
function PANEL:Paint()
	surface.SetDrawColor(5, 5, 5, 180)
	surface.DrawRect(self:GetWide() * 0.4, 0, self:GetWide() * 0.6, self:GetTall())
	surface.SetTexture(texRightEdge)
	surface.DrawTexturedRectRotated(self:GetWide() * 0.2, self:GetTall() * 0.5, self:GetWide() * 0.4, self:GetTall(), 180)
end

function PANEL:PerformLayout()
	local y = ScrH() * 0.1
	for k, item in ipairs(self.WeaponButtons) do
		if item and item:Valid() then
			item:SetPos(0, y)
			item:CenterHorizontal()
			y = y + item:GetTall() + self.Spacing
		end
	end
end

vgui.Register("DSideMenu", PANEL, "DPanel")


local PANEL = {}

PANEL.NextRefresh = 0
PANEL.RefreshTime = 1


local function WeaponButtonDoClick(self)
	if self:GetParent().m_WeaponSlot == WEAPONLOADOUT_NULL then return end
	GAMEMODE:OpenPointsShop(self:GetParent().m_WeaponSlot)
	surface.PlaySound("buttons/button15.wav")
end

function PANEL:Think()
	local wepslot = self.m_WeaponSlot
	local wep
	if wepslot == WEAPONLOADOUT_SLOT1 then
		wep = MySelf:GetWeapon1()
	elseif wepslot == WEAPONLOADOUT_SLOT2 then
		wep = MySelf:GetWeapon2()
	elseif wepslot == WEAPONLOADOUT_MELEE then
		wep = MySelf:GetWeaponMelee()
	elseif wepslot == WEAPONLOADOUT_TOOLS then
		wep = MySelf:GetWeaponToolslot()	
	else return 
	end
	if self:GetWeapon() ~= wep then
		self:SetWeaponSlot(wepslot)
	end
end

function PANEL:Init()
	self.m_WeaponModelButton = vgui.Create("DModelPanel", self)
	self.m_WeaponModelButton:DockPadding(0, 8, 0, 0)
	self.m_WeaponModelButton:Dock(FILL)
	self.m_WeaponModelButton:SetModel("error.mdl")
	self.m_WeaponModelButton:SetZPos(1000)
	self.m_WeaponModelButton.DoClick = WeaponButtonDoClick
	function self.m_WeaponModelButton:LayoutEntity( Entity ) return end 
	
	self.m_WeaponNameLabel = EasyLabel(self, "", "ZSHUDFontSmallest", COLOR_WHITE)
	self.m_WeaponNameLabel:SetContentAlignment(8)
	self.m_WeaponNameLabel:Dock(TOP)
	self.m_WeaponModelButton:SetZPos(1100)
	
	self.m_WeaponSlot = WEAPONLOADOUT_NULL
end

function PANEL:Paint()
	local colBG = team.GetColor(MySelf:Team())
	local outlinecol
	--self:SetBackgroundColor(colBG)
	local tall = self:GetTall()
	local wide = self:GetWide()
	if self.m_WeaponModelButton:IsHovered() then
		outlinecol = COLOR_DARKGREEN
	else
		outlinecol = COLOR_DARKGRAY
	end
	draw.RoundedBox(8, 0, 0, wide, tall, outlinecol)
	draw.RoundedBox(8, 8,32, wide-16, tall-40, colBG)
	return true
end
 
function PANEL:SetWeaponSlot(wepslot)
	if not wepslot or wepslot < 1 or wepslot > 4 then return end
	local wep = ""
	if wepslot == WEAPONLOADOUT_SLOT1 then
		wep = MySelf:GetWeapon1()
	elseif wepslot == WEAPONLOADOUT_SLOT2 then
		wep = MySelf:GetWeapon2()
	elseif wepslot == WEAPONLOADOUT_MELEE then
		wep = MySelf:GetWeaponMelee()
	elseif wepslot == WEAPONLOADOUT_TOOLS then
		wep = MySelf:GetWeaponToolslot()
	else return 
	end
	self.m_WeaponSlot = wepslot
	local sweptable = weapons.GetStored(wep)
	if not sweptable then return end
	self.m_Weapon = wep
	local wepmodel = "error.mdl"
	if not sweptable.WorldModel and sweptable.Base and (sweptable.Base ~= "weapon_zs_base" and sweptable.Base ~= "weapon_zs_basemelee") then
		local basesweptable = weapons.GetStored(sweptable.Base)
		if basesweptable.WorldModel then wepmodel = basesweptable.WorldModel end
	else
		wepmodel = sweptable.WorldModel
	end
	self.m_WeaponModelButton:SetModel(wepmodel)
	local wepent = self.m_WeaponModelButton.Entity
	if IsValid(wepent) then
		local mins, maxs = wepent:GetRenderBounds()
		local campos = mins:Distance(maxs) * Vector(0.75, 0.75, 1)
		local lookat = (mins + maxs) / 2
		local ang = (lookat - campos):Angle()
		self.m_WeaponModelButton:SetCamPos(campos)
		self.m_WeaponModelButton:SetLookAt((mins + maxs) / 2)
		self.m_WeaponModelButton:SetLookAng(ang)
		self.m_WeaponModelButton.LayoutEntity = function(ent) return end
	end
	self.m_WeaponNameLabel:SetText(sweptable.TranslateName and translate.Get(sweptable.TranslateName) or wep)
	self.m_WeaponNameLabel:SizeToContents()

	self:Refresh()
end

function PANEL:GetWeapon()
	return self.m_Weapon
end

vgui.Register("DWeaponLoadoutPanel", PANEL, "DPanel")