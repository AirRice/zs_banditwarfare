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
	local isspectated = (self:GetOwner():IsPlayer() and MySelf:GetObserverMode() == OBS_MODE_IN_EYE and MySelf:GetObserverTarget() == self.Owner)
	if GAMEMODE.WeaponHUDMode >= 1 and not isspectated then
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
	local isspectated = (self.Owner:IsPlayer() and MySelf:GetObserverMode() == OBS_MODE_IN_EYE and MySelf:GetObserverTarget() == self.Owner)
	if not self.HUD3DPos or GAMEMODE.WeaponHUDMode == 1 or isspectated then return end

	local pos, ang = GetHUD3DPos(self, vm)
	if pos then
		self:Draw3DHUD(vm, pos, ang)
	end
end

function SWEP:Draw3DHUD(vm, pos, ang)
	local wid, hei = 180, 200
	local x, y = wid * -0.6, hei * -0.5
	local spare = self:Ammo1()
	local maxclip = 5
	draw.DrawAmmoHud(nil,spare,maxclip,wid,hei,x,y,1,true,false,2,true,pos,ang,self.HUD3DScale)
end

function SWEP:Draw2DHUD()
	local screenscale = BetterScreenScale()
	local wid, hei = 180 * screenscale, 64 * screenscale
	local x, y = ScrW() - wid - screenscale * 128, ScrH() - hei - screenscale * 72
	local spare = self:Ammo1()
	local maxclip = 5
	draw.DrawAmmoHud(nil,spare,maxclip,wid,hei,x,y,1,true,false,2,false)
end

