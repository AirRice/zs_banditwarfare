AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "'터미네이터' 권총"
	SWEP.Description = "소총탄약을 추가로 사용하면 2배의 대미지를 입힐 수 있다."
	SWEP.Slot = 1
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "v_weapon.FIVESEVEN_PARENT"
	SWEP.HUD3DPos = Vector(-2.5, -2.5, -1)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	
	SWEP.VElements = {
		["Handle"] = { type = "Model", model = "models/weapons/w_pist_p228.mdl", bone = "v_weapon.FIVESEVEN_PARENT", rel = "", pos = Vector(0, 2.901, -1.494), angle = Angle(-90, 90, 0), size = Vector(0.944, 1.009, 0.944), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/furniturecupboard001a", skin = 0, bodygroup = {[3] = 2} },
		["SlideWings"] = { type = "Model", model = "models/props_wasteland/laundry_basket002.mdl", bone = "v_weapon.FIVESEVEN_PARENT", rel = "Handle", pos = Vector(5.763, 0, 4.423), angle = Angle(-90, 0, 0), size = Vector(0.041, 0.03, 0.112), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["underside"] = { type = "Model", model = "models/props_c17/furniturebathtub001a.mdl", bone = "v_weapon.FIVESEVEN_PARENT", rel = "Handle", pos = Vector(-2.586, 0, 4.994), angle = Angle(-100.652, 0, 0), size = Vector(0.043, 0.052, 0.043), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_trainstation/benchoutdoor01a", skin = 0, bodygroup = {} },
		["slide"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "v_weapon.FIVESEVEN_SLIDE", rel = "", pos = Vector(0, 3.648, -0.04), angle = Angle(0, 0, 90), size = Vector(0.157, 0.157, 0.157), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	}	
	SWEP.WElements = {
		["underside"] = { type = "Model", model = "models/props_c17/furniturebathtub001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Handle", pos = Vector(-2.586, 0, 4.994), angle = Angle(-100.652, 0, 0), size = Vector(0.043, 0.052, 0.043), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_trainstation/benchoutdoor01a", skin = 0, bodygroup = {} },
		["slide"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Handle", pos = Vector(3.72, 0, 6.06), angle = Angle(-90, 0, 0), size = Vector(0.15, 0.181, 0.143), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Handle"] = { type = "Model", model = "models/weapons/w_pist_p228.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 1.4, 2.5), angle = Angle(-3.3, -5.212, 180), size = Vector(0.88, 1.3, 0.88), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/furniturecupboard001a", skin = 0, bodygroup = {[3] = 2} },
		["SlideWings"] = { type = "Model", model = "models/props_wasteland/laundry_basket002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Handle", pos = Vector(5.763, 0, 4.423), angle = Angle(-90, 0, 0), size = Vector(0.041, 0.03, 0.112), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end


SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "revolver"

SWEP.ViewModel = "models/weapons/cstrike/c_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fiveseven.mdl"
SWEP.UseHands = true
SWEP.Primary.Sound = Sound("weapons/fiveseven/fiveseven-1.wav")
SWEP.Primary.Damage = 25
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.08
SWEP.Recoil = 1.36
SWEP.Primary.ClipSize = 3
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"
GAMEMODE:SetupDefaultClip(SWEP.Primary)
SWEP.ConeMax = 0.03
SWEP.ConeMin = 0.003
SWEP.IronSightsPos = Vector(-6.2, 0, 2.5)
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)

function SWEP:ShootRifledBullets()	
	local dmg = self.Primary.Damage*2
	local numbul = self.Primary.NumShots
	local cone = self:GetCone()
	if SERVER then
		self:SetConeAndFire()
	end
	self:DoRecoil()
	
	local owner = self.Owner
	--owner:MuzzleFlash()
	self:SendWeaponAnimation()
	owner:DoAttackEvent()
	
	if owner and owner:IsValid() and owner:IsPlayer() and self.IsFirearm and SERVER then
		owner.ShotsFired = owner.ShotsFired + numbul
		owner.LastShotWeapon = self:GetClass()
	end
	
	self:StartBulletKnockback()
	owner:FireBullets({Num = numbul, Src = owner:GetShootPos(), Dir = owner:GetAimVector(), Spread = Vector(cone, cone, 0), Tracer = 1, TracerName = "AirboatGunHeavyTracer", Force = dmg * 0.1, Damage = dmg, Callback = self.BulletCallback})
	self:DoBulletKnockback(self.Primary.KnockbackScale * 0.05)
	self:EndBulletKnockback()
end
function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	if self.Owner:GetAmmoCount("357") > 0 then
		self:EmitFireSound()
		self:EmitSound("weapons/gauss/fire1.wav",75,110,1,CHAN_AUTO)
		self:TakeAmmo()
		self.Owner:RemoveAmmo( 1, "357")
		self:ShootRifledBullets()
		self.IdleAnimation = CurTime() + self:SequenceDuration()
	else
		self:EmitFireSound()
		self:TakeAmmo()
		self:ShootBullets(self.Primary.Damage, self.Primary.NumShots, self:GetCone())
		self.IdleAnimation = CurTime() + self:SequenceDuration()
	end
end
if not CLIENT then return end

function SWEP:DrawHUD()

	surface.SetFont("ZSHUDFontSmall")
	local label = "소총탄: "
	local riflecount = self.Owner:GetAmmoCount("357")
	local text = label..riflecount
	local nTEXW, nTEXH = surface.GetTextSize(text)

	draw.SimpleTextBlurry(text, "ZSHUDFont", ScrW() - nTEXW * 0.5 - 56, ScrH() - nTEXH * 3, riflecount > 3 and COLOR_LIMEGREEN or COLOR_RED, TEXT_ALIGN_CENTER)

	if GetConVarNumber("crosshair") ~= 1 then return end
	self:DrawCrosshairDot()
	self:DrawCrosshair()

	if GAMEMODE.WeaponHUDMode >= 1 then
		self:Draw2DHUD()
	end
end