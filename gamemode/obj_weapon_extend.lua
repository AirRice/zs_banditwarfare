local meta = FindMetaTable("Weapon")
if not meta then return end

meta.GetNextPrimaryAttack = meta.GetNextPrimaryFire
meta.GetNextSecondaryAttack = meta.GetNextSecondaryFire
meta.SetNextPrimaryAttack = meta.SetNextPrimaryFire
meta.SetNextSecondaryAttack = meta.SetNextSecondaryFire

function meta:EmptyAll(emptyclip)
	if self.Primary and string.lower(self.Primary.Ammo or "") ~= "none" then
		local owner = self:GetOwner()
		if owner:IsValid() then
			if self:Clip1() >= 1 then
				owner:GiveAmmo(self:Clip1(), self.Primary.Ammo, true)
			end
			owner:RemoveAmmo(self.Primary.DefaultClip, self.Primary.Ammo)
		end
		if emptyclip then
			self:SetClip1(0)
		end
	end
	if self.Secondary and string.lower(self.Secondary.Ammo or "") ~= "none" then
		local owner = self:GetOwner()
		if owner:IsValid() then
			if self:Clip2() >= 1 then
				owner:GiveAmmo(self:Clip2(), self.Secondary.Ammo, true)
			end
			owner:RemoveAmmo(self.Secondary.DefaultClip, self.Secondary.Ammo)
		end
		if emptyclip then
			self:SetClip2(0)
		end
	end
end

function meta:ValidPrimaryAmmo()
	local ammotype = self:GetPrimaryAmmoTypeString()
	if ammotype and ammotype ~= "none" and ammotype ~= "autocharging" and ammotype~= "dummy" then
		return ammotype
	end
end

function meta:ValidSecondaryAmmo()
	local ammotype = self:GetSecondaryAmmoTypeString()
	if ammotype and ammotype ~= "none" and ammotype ~= "autocharging" and ammotype~= "dummy" then
		return ammotype
	end
end

function meta:SetNextReload(fTime)
	self.m_NextReload = fTime
end

function meta:GetNextReload()
	return self.m_NextReload or 0
end

function meta:GetPrimaryAmmoCount()
	return self.Owner:GetAmmoCount(self.Primary.Ammo) + self:Clip1()
end

function meta:GetSecondaryAmmoCount()
	return self.Owner:GetAmmoCount(self.Secondary.Ammo) + self:Clip2()
end

function meta:HideViewAndWorldModel()
	self:HideViewModel()
	self:HideWorldModel()
end
meta.HideWorldAndViewModel = meta.HideViewAndWorldModel

if SERVER then
	function meta:HideWorldModel()
		self:DrawShadow(false)
	end

	function meta:HideViewModel()
	end
end

function meta:TakeCombinedPrimaryAmmo(amount)
	local ammotype = self.Primary.Ammo
	local owner = self.Owner
	local clip = self:Clip1()
	local reserves = owner:GetAmmoCount(ammotype)

	amount = math.min(reserves + clip, amount)

	local fromreserves = math.min(reserves, amount)
	if fromreserves > 0 then
		amount = amount - fromreserves
		self.Owner:RemoveAmmo(fromreserves, ammotype)
	end

	local fromclip = math.min(clip, amount)
	if fromclip > 0 then
		self:SetClip1(clip - fromclip)
	end
end

function meta:TakeCombinedSecondaryAmmo(amount)
	local ammotype = self.Secondary.Ammo
	local owner = self.Owner
	local clip = self:Clip2()
	local reserves = owner:GetAmmoCount(ammotype)

	amount = math.min(reserves + clip, amount)

	local fromreserves = math.min(reserves, amount)
	if fromreserves > 0 then
		amount = amount - fromreserves
		self.Owner:RemoveAmmo(fromreserves, ammotype)
	end

	local fromclip = math.min(clip, amount)
	if fromclip > 0 then
		self:SetClip2(clip - fromclip)
	end
end

local TranslatedAmmo = {}
TranslatedAmmo[-1] = "none"
TranslatedAmmo[0] = "none"
TranslatedAmmo[1] = "ar2"
TranslatedAmmo[2] = "alyxgun"
TranslatedAmmo[3] = "pistol"
TranslatedAmmo[4] = "smg1"
TranslatedAmmo[5] = "357"
TranslatedAmmo[6] = "xbowbolt"
TranslatedAmmo[7] = "buckshot"
TranslatedAmmo[8] = "rpg_round"
TranslatedAmmo[9] = "smg1_grenade"
TranslatedAmmo[10] = "sniperround"
TranslatedAmmo[11] = "sniperpenetratedround"
TranslatedAmmo[12] = "grenade"
TranslatedAmmo[13] = "thumper"
TranslatedAmmo[14] = "gravity"
TranslatedAmmo[14] = "battery"
TranslatedAmmo[15] = "gaussenergy"
TranslatedAmmo[16] = "combinecannon"
TranslatedAmmo[17] = "airboatgun"
TranslatedAmmo[18] = "striderminigun"
TranslatedAmmo[19] = "helicoptergun"
TranslatedAmmo[20] = "ar2altfire"
TranslatedAmmo[21] = "slam"

function meta:GetPrimaryAmmoTypeString()
	if self.Primary and self.Primary.Ammo then return string.lower(self.Primary.Ammo) end
	return TranslatedAmmo[self:GetPrimaryAmmoType()] or "none"
end

function meta:GetSecondaryAmmoTypeString()
	if self.Secondary and self.Secondary.Ammo then return string.lower(self.Secondary.Ammo) end
	return TranslatedAmmo[self:GetSecondaryAmmoType()] or "none"
end
meta.OldGetPrintName = FindMetaTable("Weapon").GetPrintName
function meta:GetPrintName()
	if CLIENT then
		if self.TranslateName then
			self.PrintName = translate.Get(self.TranslateName)
		end
	end
	return self.PrintName and self.PrintName or self:GetClass()
end
if not CLIENT then return end

function meta:DrawCrosshair()
	if GetConVarNumber("crosshair") ~= 1 then return end

	self:DrawCrosshairCross()
	self:DrawCrosshairDot()
end

local ironsightscrosshair = CreateClientConVar("zs_ironsightscrosshair", "0", true, false):GetBool()
cvars.AddChangeCallback("zs_ironsightscrosshair", function(cvar, oldvalue, newvalue)
	ironsightscrosshair = tonumber(newvalue) == 1
end)

local CrossHairScale = 1
local function DrawDot(x, y)
	surface.SetDrawColor(GAMEMODE.CrosshairColor)
	surface.DrawRect(x - 2, y - 2, 4, 4)
	surface.SetDrawColor(0, 0, 0, 220)
	surface.DrawOutlinedRect(x - 2, y - 2, 4, 4)
end
local matGrad = Material("VGUI/gradient-r")
local function DrawLine(x, y, rot)
	rot = 270 - rot
	surface.SetMaterial(matGrad)
	surface.SetDrawColor(0, 0, 0, 220)
	surface.DrawTexturedRectRotated(x, y, 14, 4, rot)
	surface.SetDrawColor(GAMEMODE.CrosshairColor)
	surface.DrawTexturedRectRotated(x, y, 12, 2, rot)
end
local baserot = 0
function meta:DrawCrosshairCross()
	local x = ScrW() * 0.5
	local y = ScrH() * 0.5

	local ironsights = self.GetIronsights and self:GetIronsights()

	local owner = self.Owner

	local cone = self:GetCone()

	if cone <= 0 or ironsights and not ironsightscrosshair then return end

	cone = ScrH() / 76.8 * cone

	CrossHairScale = math.Approach(CrossHairScale, cone, FrameTime() * math.max(5, math.abs(CrossHairScale - cone) * 0.02))

	local midarea = 40 * CrossHairScale

	local vel = LocalPlayer():GetVelocity()
	local len = vel:Length()
	if GAMEMODE.NoCrosshairRotate then
		baserot = 0
	else
		baserot = math.NormalizeAngle(baserot + vel:GetNormalized():Dot(EyeAngles():Right()) * math.min(10, len / 200))
	end

	--[[if baserot ~= 0 then
		render.PushFilterMag(TEXFILTER.ANISOTROPIC)
		render.PushFilterMin(TEXFILTER.ANISOTROPIC)
	end]]

	local ang = Angle(0, 0, baserot)
	for i=0, 359, 360 / 4 do
		ang.roll = baserot + i
		local p = ang:Up() * midarea
		DrawLine(math.Round(x + p.y), math.Round(y + p.z), ang.roll)
	end

	--[[if baserot ~= 0 then
		render.PopFilterMag()
		render.PopFilterMin()
	end]]
end

function meta:DrawCrosshairDot()
	local x = ScrW() * 0.5
	local y = ScrH() * 0.5

	surface.SetDrawColor(GAMEMODE.CrosshairColor2)
	surface.DrawRect(x - 2, y - 2, 4, 4)
	surface.SetDrawColor(0, 0, 0, 220)
	surface.DrawOutlinedRect(x - 2, y - 2, 4, 4)
end
local insuredcolor = Color(0, 180, 255)
function meta:BaseDrawWeaponSelection(x, y, wide, tall, alpha)
	--killicon.Draw(x + wide * 0.5, y + tall * 0.5, self:GetClass(), 255)
	-- Doesn't work with pngs...
	local ki = killicon.Get(self:GetClass())
	local cols = ki and ki[#ki] or ""

	if ki and #ki == 3 then
		draw.SimpleText(ki[2], ki[1] .. "ws", x + wide * 0.5, y + tall * 0.5 + 18 * BetterScreenScale(), Color(cols.r, cols.g, cols.b, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	elseif ki then
		local material = Material(ki[1])
		local wid, hei = material:Width(), material:Height()
		surface.SetMaterial(material)
		surface.SetDrawColor(cols.r, cols.g, cols.b, alpha )
		surface.DrawTexturedRect(x + wide * 0.5 - wid * 0.5, y + tall * 0.5 - hei * 0.5, wid, hei)
		
	end
	local isinsured = GAMEMODE.ClassicModeInsuredWeps[self:GetClass()]
	surface.SetDrawColor(color_black_alpha220)
	surface.DrawRect(x, y + tall * 0.65, wide, tall * 0.2)
	drawcol = isinsured and insuredcolor or COLOR_RED
	draw.SimpleText(self:GetPrintName(), "ZSHUDFontSmallNS", x + wide * 0.5, y + tall * 0.75, drawcol, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	if isinsured then
		draw.SimpleText("!", "ZSIconFont", x + wide -12, y + 12, drawcol, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	return true
end
local function empty() end
local function NULLViewModelPosition(self, pos, ang)
	return pos + ang:Forward() * -256, ang
end

function meta:HideWorldModel()
	self:DrawShadow(false)
	self.DrawWorldModel = empty
	self.DrawWorldModelTranslucent = empty
end

function meta:HideViewModel()
	self.GetViewModelPosition = NULLViewModelPosition
end
