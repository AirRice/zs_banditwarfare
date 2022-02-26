local PANEL = {}

PANEL.Spacing = 8

function PANEL:Init()
	self:SetPos(ScrW() - 1, 0)
	local but = EasyButton(self, translate.Get("consumables_purchase_button"), 0, 0)
	but:SetFont("ZSHUDFontSmall")
	but:SetContentAlignment(5)
	but:SetTall(64)
	but:DockMargin(0,8,0,8)	
	but:Dock(TOP)
	--but:SetZPos(1100)
	but.DoClick = 
	function() 
		GAMEMODE:OpenPointsShop(WEAPONLOADOUT_NULL)
		surface.PlaySound("buttons/button15.wav") 
	end
	self.WeaponButtons = {}
	local wep1button = vgui.Create("DWeaponLoadoutButton", self)
	wep1button:SetWeaponSlot(WEAPONLOADOUT_SLOT1)
	wep1button:SetParent(self)
	wep1button:Dock(TOP)
	table.insert(self.WeaponButtons, wep1button)
	local wep2button = vgui.Create("DWeaponLoadoutButton", self)
	wep2button:SetWeaponSlot(WEAPONLOADOUT_SLOT2)
	wep2button:SetParent(self)
	wep2button:Dock(TOP)
	table.insert(self.WeaponButtons, wep2button)
	local wepmeleebutton = vgui.Create("DWeaponLoadoutButton", self)
	wepmeleebutton:SetWeaponSlot(WEAPONLOADOUT_MELEE)
	wepmeleebutton:SetParent(self)
	wepmeleebutton:Dock(TOP)
	table.insert(self.WeaponButtons, wepmeleebutton)
	local weptoolbutton = vgui.Create("DWeaponLoadoutButton", self)
	weptoolbutton:SetWeaponSlot(WEAPONLOADOUT_TOOLS)
	weptoolbutton:SetParent(self)
	weptoolbutton:Dock(TOP)
	table.insert(self.WeaponButtons, weptoolbutton)
	self:RefreshSize()
end


function PANEL:RefreshSize()
	local screenscale = BetterScreenScale()
	self:SetSize(screenscale * 300, ScrH())
	for k, item in pairs(self.WeaponButtons) do
		if item and item:Valid() then
			item:SetWide(self:GetWide() - 16)
			item:SetTall(screenscale * 140)
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
	--self:Remove()
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

function PANEL:Think()
	if not input.LookupBinding("+menu", true) then return end
	if (MySelf:Team() == TEAM_HUMAN or MySelf:Team() == TEAM_BANDIT) and not GAMEMODE:IsClassicMode() and not (GAMEMODE.m_PointsShop and GAMEMODE.m_PointsShop:Valid() and ispanel(GAMEMODE.m_PointsShop)) then
		if not input.IsKeyDown(input.GetKeyCode(input.LookupBinding("+menu", true))) then
			self:CloseMenu()
		end
	end
end

vgui.Register("DSideMenu", PANEL, "DPanel")

local PANEL = {}

PANEL.NextRefresh = 0
PANEL.RefreshTime = 1


local function WeaponButtonDoClick(self)
	if self.m_WeaponSlot == WEAPONLOADOUT_NULL then return end
	GAMEMODE:OpenPointsShop(self.m_WeaponSlot)
	surface.PlaySound("buttons/button15.wav")
end

function PANEL:Think()
	local wepslot = self.m_WeaponSlot
	local wep = MySelf:GetWeaponLoadoutBySlot(wepslot)
	if not wep or not isstring(wep) then
		return 
	end
	if self:GetWeapon() ~= wep then
		self:SetWeaponSlot(wepslot)
	end
end

function PANEL:Init()
	self:DockPadding(0, 8, 0, 0)
	self:DockMargin(0,8,0,0)
	self.DoClick = WeaponButtonDoClick	

	self.m_WeaponNameLabel = EasyLabel(self, "", "ZSHUDFontSmallest", COLOR_WHITE)
	self.m_WeaponNameLabel:SetContentAlignment(8)
	self.m_WeaponNameLabel:Dock(TOP)
	self.m_WeaponNameLabel:DockPadding(0, 8, 0, 0)
	self.m_WeaponNameLabel:SetZPos(1100)
	
	self.m_WeaponSlot = WEAPONLOADOUT_NULL
end

function PANEL:Paint()
	local outlinecol
	if self:IsHovered() then
		outlinecol = COLOR_DARKGREEN
	else
		outlinecol = COLOR_DARKGRAY
	end
	draw.RoundedBox(8, 0, 0, self:GetWide(), self:GetTall(), outlinecol)
	return true
end

function PANEL:PaintOver()
	local tall = self:GetTall()
	local wide = self:GetWide()
	local colBG = team.GetColor(MySelf:Team())
	colBG.a = 110
	draw.RoundedBox(8, 8,32, wide-16, tall-40, colBG)
	if self.m_Weapon then
		local ki = killicon.Get(self:GetWeapon())
		local cols = ki and ki[#ki] or ""

		if ki and #ki == 3 then
			draw.SimpleText(ki[2], ki[1] .. "ws", wide * 0.5, tall * 0.5 + 40 * BetterScreenScale(), Color(cols.r, cols.g, cols.b, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		elseif ki then
			local material = Material(ki[1])
			local wid, hei = material:Width(), material:Height()
			surface.SetMaterial(material)
			surface.SetDrawColor(cols.r, cols.g, cols.b, alpha )
			surface.DrawTexturedRect(wide * 0.5 - wid * 0.5, tall * 0.5 - hei * 0.5 + 10 * BetterScreenScale(), wid, hei)
		end
	end
end

function PANEL:SetWeaponSlot(wepslot)
	if not wepslot or wepslot < 1 or wepslot > 4 then return end
	local wep = MySelf:GetWeaponLoadoutBySlot(wepslot)
	if not wep or not isstring(wep) then 
		return 
	end
	self.m_WeaponSlot = wepslot
	local sweptable = weapons.GetStored(wep)
	if not sweptable then return end
	self.m_Weapon = wep

	self.m_WeaponNameLabel:SetText(sweptable.TranslateName and translate.Get(sweptable.TranslateName) or wep)
	self.m_WeaponNameLabel:SizeToContents()
	self:Refresh()
end

function PANEL:GetWeapon()
	return self.m_Weapon
end

vgui.Register("DWeaponLoadoutButton", PANEL, "DButton")