AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_boomstick_name"
	SWEP.TranslateDesc = "weapon_boomstick_desc"
	SWEP.Slot = 3
	SWEP.SlotPos = 0

	SWEP.HUD3DBone = "ValveBiped.Gun"
	SWEP.HUD3DPos = Vector(1.65, 0, -8)
	SWEP.HUD3DScale = 0.025
	
	SWEP.ViewModelFlip = false
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "shotgun"

SWEP.ViewModel = "models/weapons/c_shotgun.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false

SWEP.ReloadDelay = 0.55

SWEP.Primary.Sound = Sound("weapons/shotgun/shotgun_dbl_fire.wav")
SWEP.Primary.Recoil = 22.75
SWEP.Primary.Damage = 8
SWEP.Primary.NumShots = 6
SWEP.Primary.Delay = 0.5

SWEP.Primary.ClipSize = 4
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.DefaultClip = 16

SWEP.ConeMax = 0.18
SWEP.ConeMin = 0.1
SWEP.Recoil = 3.2
SWEP.WalkSpeed = SPEED_SLOWEST
SWEP.MovingConeOffset = 0.08
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
function SWEP:SetIronsights()
end

function SWEP:PrimaryAttack()
	if self:CanPrimaryAttack() then
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		self:EmitSound(self.Primary.Sound)

		local clip = self:Clip1()

		self:ShootBullets(self.Primary.Damage, self.Primary.NumShots * clip, self:GetCone())
		local kotime = 0.2+math.Clamp(clip-1,0,3)*0.5
		self:TakePrimaryAmmo(clip)
		self.Owner:ViewPunch(clip * 0.5 * self.Primary.Recoil * Angle(math.Rand(-0.1, -0.1), math.Rand(-0.1, 0.1), 0))
		if self.Owner and self.Owner:IsPlayer() and self.Owner:Alive() then 	
			self.Owner:KnockDown(kotime) 
		end
		self.Owner:SetGroundEntity(NULL)
		self.Owner:SetVelocity(-160 * clip * self.Owner:GetAimVector())

		self.IdleAnimation = CurTime() + self:SequenceDuration()
	end
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 5, "ReloadTimer")
	self:NetworkVar("Bool", 5, "IsReloading")
	if self.BaseClass.SetupDataTables then
		self.BaseClass.SetupDataTables(self)
	end
end

function SWEP:Reload()
	if self:GetReloadTimer() > 0 then return end

	if self:Clip1() < self.Primary.ClipSize and 0 < self.Owner:GetAmmoCount(self.Primary.Ammo) then
		self:SetNextPrimaryFire(CurTime() + math.max(self.ReloadDelay,self.Primary.Delay))
		self:SetIsReloading(true)
		self:SetReloadTimer(CurTime() + self.ReloadDelay)
		self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
		self:GetOwner():DoReloadEvent()
	end
	self:SetIronsights(false)
end

function SWEP:Think()
	if self:GetReloadTimer() > 0 and CurTime() >= self:GetReloadTimer() then
		self:DoReload()
	end
	if self:GetIronsights() and not self.Owner:KeyDown(IN_ATTACK2) then
		self:SetIronsights(false)
	end
	if self.BaseClass.Think then
		self.BaseClass.Think(self)
	end
	self:NextThink(CurTime())
	return true
end

function SWEP:DoReload()
	if not (self:Clip1() < self.Primary.ClipSize and 0 < self.Owner:GetAmmoCount(self.Primary.Ammo)) or self:GetOwner():KeyDown(IN_ATTACK) or (not self:GetIsReloading() and not self:GetOwner():KeyDown(IN_RELOAD)) then
		self:StopReloading()
		return
	end

	local delay = self.ReloadDelay
	self:SendWeaponAnim(ACT_VM_RELOAD)
	self:EmitSound("Weapon_Shotgun.Reload")
	self:GetOwner():RemoveAmmo(1, self.Primary.Ammo, false)
	self:SetClip1(self:Clip1() + 1)

	self:SetIsReloading(false)
	-- We always wanna call the reload function one more time. Forces a pump to take place.
	self:SetReloadTimer(CurTime() + delay)
	self:SetNextPrimaryFire(CurTime() + math.max(self.Primary.Delay, delay))
end

function SWEP:StopReloading()
	self:SetReloadTimer(0)
	self:SetIsReloading(false)
	self:SetNextPrimaryFire(CurTime() + math.max(self.Primary.Delay, self.ReloadDelay) * 0.75)
	if self:Clip1() > 0 then
		self:SendWeaponAnim(ACT_SHOTGUN_PUMP)
		self:EmitSound("Weapon_Shotgun.Special1")
	else
		self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
	end
end

function SWEP:CanPrimaryAttack()
	if self:GetOwner():IsHolding() or self:GetOwner():GetBarricadeGhosting() then return false end

	if self:Clip1() <= 0 then
		self:EmitSound("Weapon_Shotgun.Empty")
		self:SetNextPrimaryFire(CurTime() + 0.25)
		return false
	end

	if self:GetIsReloading() then
		self:StopReloading()
		return false
	end

	return self:GetNextPrimaryFire() <= CurTime()
end

function SWEP:SecondaryAttack()
end