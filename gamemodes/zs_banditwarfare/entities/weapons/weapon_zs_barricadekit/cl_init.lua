include("shared.lua")

SWEP.TranslateName = "weapon_aegiskit_name"
SWEP.TranslateDesc = "weapon_aegiskit_desc"
SWEP.DrawCrosshair = false
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.HUD3DBone = "base"
SWEP.HUD3DPos = Vector(3.630, 0, 10)
SWEP.HUD3DScale = 0.025
SWEP.HUD3DAng = Angle(180, 0, 0)
SWEP.Slot = 4
SWEP.SlotPos = 0


function SWEP:DrawHUD()
	if GAMEMODE.WeaponHUDMode >= 1 then
		self:Draw2DHUD()
	end
	if GetConVarNumber("crosshair") == 1 then 
		self:DrawCrosshairDot()
	end
end


function SWEP:Deploy()
	self.IdleAnimation = CurTime() + self:SequenceDuration()

	return true
end

function SWEP:GetViewModelPosition(pos, ang)
	return pos, ang
end

function SWEP:DrawWeaponSelection(...)
	return self:BaseDrawWeaponSelection(...)
end

function SWEP:PrimaryAttack()
end

function SWEP:Think()
	if self.Owner:KeyDown(IN_ATTACK2) then
		self:RotateGhost(FrameTime() * 60)
	end
	if self.Owner:KeyDown(IN_RELOAD) then
		self:RotateGhost(FrameTime() * -60)
	end
end

local nextclick = 0
local kityaw = CreateClientConVar("zs_barricadekityaw", 90, false, true)
function SWEP:RotateGhost(amount)
	if nextclick <= RealTime() then
		surface.PlaySound("npc/headcrab_poison/ph_step4.wav")
		nextclick = RealTime() + 0.3
	end
	RunConsoleCommand("zs_barricadekityaw", math.NormalizeAngle(kityaw:GetFloat() + amount))
end

function SWEP:PostDrawViewModel(vm)
	if self.ShowViewModel == false then
		render.SetBlend(1)
	end

	if not self.HUD3DPos or GAMEMODE.WeaponHUDMode == 1 then return end

	local pos, ang = self:GetHUD3DPos(vm)
	if pos then
		self:Draw3DHUD(vm, pos, ang)
	end
end

function SWEP:GetHUD3DPos(vm)
	local bone = vm:LookupBone(self.HUD3DBone)
	if not bone then return end

	local m = vm:GetBoneMatrix(bone)
	if not m then return end

	local pos, ang = m:GetTranslation(), m:GetAngles()

	if self.ViewModelFlip then
		ang.r = -ang.r
	end

	local offset = self.HUD3DPos
	local aoffset = self.HUD3DAng

	pos = pos + ang:Forward() * offset.x + ang:Right() * offset.y + ang:Up() * offset.z

	if aoffset.yaw ~= 0 then ang:RotateAroundAxis(ang:Up(), aoffset.yaw) end
	if aoffset.pitch ~= 0 then ang:RotateAroundAxis(ang:Right(), aoffset.pitch) end
	if aoffset.roll ~= 0 then ang:RotateAroundAxis(ang:Forward(), aoffset.roll) end

	return pos, ang
end

local colBG = Color(16, 16, 16, 90)
local colRed = Color(220, 0, 0, 230)
local colYellow = Color(220, 220, 0, 230)
local colWhite = Color(220, 220, 220, 230)
local colAmmo = Color(255, 255, 255, 230)
local function GetAmmoColor(clip, maxclip)
	if clip == 0 then
		colAmmo.r = 255 colAmmo.g = 0 colAmmo.b = 0
	else
		local sat = clip / maxclip
		colAmmo.r = 255
		colAmmo.g = sat ^ 0.3 * 255
		colAmmo.b = sat * 255
	end
end

function SWEP:Draw2DHUD()
	local screenscale = BetterScreenScale()

	local wid, hei = 180 * screenscale, 64 * screenscale
	local x, y = ScrW() - wid - screenscale * 128, ScrH() - hei - screenscale * 72
	local clip = self.Owner:GetAmmoCount(self:GetPrimaryAmmoType())
	local maxclip = 5

	draw.RoundedBox(16, x, y, wid, hei, colBG)
	local font = "ZSHUDFontBig"
	if clip >= 1000 then
		font = "ZSHUDFontSmall"
	elseif clip >= 100 then
		font = "ZSHUDFont"
	end
	GetAmmoColor(clip, maxclip)
	draw.SimpleTextBlurry(clip, font, x + wid * 0.5, y + hei * 0.5, colAmmo, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

function SWEP:Draw3DHUD(vm, pos, ang)
	local wid, hei = 180, 200
	local x, y = wid * -0.6, hei * -0.5
	local clip = self.Owner:GetAmmoCount(self:GetPrimaryAmmoType())
	local maxclip = 5

	cam.Start3D2D(pos, ang, self.HUD3DScale / 2)
		draw.RoundedBoxEx(32, x, y, wid, hei, colBG, true, false, true, false)
		local font = "ZS3D2DFontBig"
		if clip >= 1000 then
			font = "ZS3D2DFontSmall"
		elseif clip >= 100 then
			font = "ZS3D2DFont"
		end
		GetAmmoColor(clip, maxclip)
		draw.SimpleTextBlurry(clip, font, x + wid * 0.5, y + hei * 0.5, colAmmo, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	cam.End3D2D()
end

