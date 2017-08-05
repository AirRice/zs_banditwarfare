AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "'블리츠' SG552"
	SWEP.Description ="주변에 동료가 많을수록 입히는 대미지가 증가한다."
	SWEP.Slot = 2
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "v_weapon.sg552_Parent"
	SWEP.HUD3DPos = Vector(-2.791, -5.597, -2.984)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.02
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/cstrike/c_rif_sg552.mdl"
SWEP.WorldModel = "models/weapons/w_rif_sg552.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_SG552.Single")
SWEP.Primary.Damage = 22
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.1
SWEP.Primary.ClipSize = 30

SWEP.Recoil = 0.5
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "ar2"

GAMEMODE:SetupDefaultClip(SWEP.Primary)

function SWEP:IsScoped()
	return self:GetIronsights() and self.fIronTime and self.fIronTime + 0.25 <= CurTime()
end

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_AR2

SWEP.ConeMax = 0.09
SWEP.ConeMin = 0.019

SWEP.WalkSpeed = SPEED_SLOW
SWEP.IronSightsPos = Vector(-2.52, 3.819, 3.599)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.Count = 0
SWEP.DetectRange = 256

function SWEP:Think()
	local owner = self.Owner
	local pos = owner:GetPos()
	local count = 0
	for _, pl in pairs(player.GetAll()) do
		if owner:IsPlayer() and pl:Team() == owner:Team() and pl:Alive() and pl~=owner then
			local dist = pl:NearestPoint(pos):Distance(pos)
			if dist <= self.DetectRange then
				count = count+1
			end
		end
	end
	self.Count = count
	if self.BaseClass.Think then
		self.BaseClass.Think(self)
	end
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	self:EmitFireSound()
	self:TakeAmmo()
	local dmgmul = 0
	if self.Count != 0 then
		dmgmul = math.min(2.5*self.Count,30)*0.01
	end
	self:ShootBullets(self.Primary.Damage+self.Primary.Damage*dmgmul, self.Primary.NumShots, self:GetCone())
	self.IdleAnimation = CurTime() + self:SequenceDuration()
end
function SWEP:IsScoped()
	return self:GetIronsights() and self.fIronTime and self.fIronTime + 0.25 <= CurTime()
end
if CLIENT then
SWEP.IronsightsMultiplier = 0.25
	function SWEP:GetViewModelPosition(pos, ang)
		if self:IsScoped() then
			return pos + ang:Up() * 256, ang
		end

		return self.BaseClass.GetViewModelPosition(self, pos, ang)
	end

	local matScope = Material("zombiesurvival/scope")
	function SWEP:DrawHUDBackground()
		if self:IsScoped() then
			local scrw, scrh = ScrW(), ScrH()
			local size = math.min(scrw, scrh)
			surface.SetMaterial(matScope)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect((scrw - size) * 0.5, (scrh - size) * 0.5, size, size)
			surface.SetDrawColor(0, 0, 0, 255)
			if scrw > size then
				local extra = (scrw - size) * 0.5
				surface.DrawRect(0, 0, extra, scrh)
				surface.DrawRect(scrw - extra, 0, extra, scrh)
			end
			if scrh > size then
				local extra = (scrh - size) * 0.5
				surface.DrawRect(0, 0, scrw, extra)
				surface.DrawRect(0, scrh - extra, scrw, extra)
			end
		end
	end
	function SWEP:DrawHUD()
	surface.SetFont("ZSHUDFontSmall")
	local counter = "거리 "..self.DetectRange.." 내 동료 "..self.Count.."명"
	local nTEXW, nTEXH = surface.GetTextSize(counter)
	draw.SimpleTextBlurry(counter, "ZSHUDFontSmall", ScrW() - nTEXW * 0.5 - 24, ScrH() - nTEXH * 8, COLOR_WHITE, TEXT_ALIGN_CENTER)
	if self.Count != 0 then
		local finalmul =  "대미지 +"..math.min(5*self.Count,50).."%"
		draw.SimpleTextBlurry(finalmul, "ZSHUDFontBig", ScrW() - 150, ScrH() - 216, COLOR_YELLOW, TEXT_ALIGN_CENTER)
	end
	if self.BaseClass.DrawHUD then
		self.BaseClass.DrawHUD(self)
	end
end
end

