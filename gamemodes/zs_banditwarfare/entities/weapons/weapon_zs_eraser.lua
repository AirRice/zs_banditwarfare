AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_eraser_name"
	SWEP.TranslateDesc = "weapon_eraser_desc"

	SWEP.ViewModelFOV = 60
	SWEP.ViewModelFlip = false

	SWEP.Slot = 1
	SWEP.SlotPos = 1

	SWEP.HUD3DBone = "v_weapon.FIVESEVEN_PARENT"
	SWEP.HUD3DPos = Vector(-1, -2.5, -1)
	SWEP.HUD3DAng = Angle(0, 0, 0)
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "pistol"

SWEP.ViewModel = "models/weapons/cstrike/c_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fiveseven.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("weapons/ar2/npc_ar2_altfire.wav")
SWEP.Primary.Damage = 9
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.1
SWEP.Recoil = 0.52
SWEP.Primary.ClipSize = 12
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 0.025
SWEP.ConeMin = 0.007
SWEP.MovingConeOffset = 0.03
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
SWEP.m_HasDifferingDmgValues = true
SWEP.IronSightsPos = Vector(-5.95, 0, 2.5)

function SWEP:EmitFireSound()
	self:EmitSound(self.Primary.Sound, 80, 70 + (1 - (self:Clip1() / self.Primary.ClipSize)) * 90)
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end 
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	--self:SetNextReload(CurTime() + self.Primary.Delay)
	self:EmitFireSound()
	self:TakeAmmo()
	local dmg = self.Primary.Damage
	if self:Clip1() == 0 then
		dmg = dmg * 3
	else
		dmg = dmg + dmg * (1 - self:Clip1() / self.Primary.ClipSize)
	end
	self:ShootBullets(dmg, self.Primary.NumShots, self:GetCone())
	self.IdleAnimation = CurTime() + self:SequenceDuration()
end