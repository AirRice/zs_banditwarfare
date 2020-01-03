local PANEL = {}

PANEL.NextRefresh = 0
PANEL.RefreshTime = 1

local col2 = Color(5, 5, 5, 180)

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
	self.m_WeaponModelButton:Dock(FILL)
	self.m_WeaponModelButton:SetModel("error.mdl")
	self.m_WeaponModelButton:SetZPos(1000)
	self.m_WeaponModelButton.DoClick = WeaponButtonDoClick
	function self.m_WeaponModelButton:LayoutEntity( Entity ) return end 
	
	self.m_WeaponNameLabel = EasyLabel(self.m_WeaponModelButton, "", "ZSHUDFontSmall", COLOR_GRAY)
	self.m_WeaponNameLabel:SetContentAlignment(8)
	self.m_WeaponNameLabel:Dock(TOP)
	self.m_WeaponModelButton:SetZPos(1100)
	
	self.m_WeaponSlot = WEAPONLOADOUT_NULL
end

function PANEL:OnCursorEntered()
	self.m_WeaponNameLabel:SetAlpha(255)
end

function PANEL:OnCursorExited()
	self.m_WeaponNameLabel:SetAlpha(180)
end

function PANEL:Paint()
	local colBG = team.GetColor(MySelf:Team())
	self:SetBackgroundColor(colBG)
	local tall = self:GetTall()
	local wide = self:GetWide()
	draw.RoundedBox(8, 0, 0, wide, tall, col2)
	draw.RoundedBox(8, 8,8, wide-16, tall-16, colBG)

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
	self:SetTooltip(sweptable.Description)
	self.m_Weapon = wep
	local wepmodel = "error.mdl"
	if not sweptable.WorldModel and (sweptable.Base ~= "weapon_zs_base" and sweptable.Base ~= "weapon_zs_basemelee") then
		wepmodel = sweptable.BaseClass.WorldModel
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
	self.m_WeaponNameLabel:SetText(sweptable.PrintName or wep)
	self.m_WeaponNameLabel:SizeToContents()

	self:Refresh()
end

function PANEL:GetWeapon()
	return self.m_Weapon
end

vgui.Register("DWeaponLoadoutPanel", PANEL, "DPanel")