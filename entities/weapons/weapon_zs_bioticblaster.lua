AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "바이오틱 산탄총"
	SWEP.Slot = 3
	SWEP.SlotPos = 0
	
	SWEP.ViewModelFlip = false

	SWEP.HUD3DPos = Vector(4, -3.5, -1.2)
	SWEP.HUD3DAng = Angle(90, 0, -30)
	SWEP.HUD3DScale = 0.02
	SWEP.HUD3DBone = "SS.Grip.Dummy"
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "shotgun"

SWEP.ViewModel = "models/weapons/v_supershorty/v_supershorty.mdl"
SWEP.WorldModel = "models/weapons/w_supershorty.mdl"

SWEP.ReloadDelay = 0.4

SWEP.Primary.Sound = Sound("Weapon_Shotgun.Single")
SWEP.Primary.Damage = 5
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.7

SWEP.Primary.ClipSize = 3
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "alyxgun"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 0.27
SWEP.ConeMin = 0.155
SWEP.Recoil = 0.88
SWEP.WalkSpeed = SPEED_SLOWER

SWEP.reloadtimer = 0
SWEP.nextreloadfinish = 0
SWEP.PukeLeft = 0
SWEP.NextPuke = 0
function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	self:EmitFireSound()
	self:TakeAmmo()
	if SERVER then
		self:SetConeAndFire()
	end
	self:DoRecoil()

	local owner = self.Owner
	self:SendWeaponAnimation()
	owner:DoAttackEvent()
	self.PukeLeft = 8 
	self.Owner:EmitSound("npc/barnacle/barnacle_die2.wav")
	self.Owner:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav", 72, math.Rand(85, 95))
	self.IdleAnimation = CurTime() + self:SequenceDuration()
end

function SWEP:Reload()
	if self.reloading then return end

	if self:Clip1() < self.Primary.ClipSize and 0 < self.Owner:GetAmmoCount(self.Primary.Ammo) then
		self:SetNextPrimaryFire(CurTime() + self.ReloadDelay)
		self.reloading = true
		self.reloadtimer = CurTime() + self.ReloadDelay
		self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
		self.Owner:RestartGesture(ACT_HL2MP_GESTURE_RELOAD_SHOTGUN)
	end

	self:SetIronsights(false)
	self:ResetConeAdder()
end

function SWEP:Think()
	if self.reloading and self.reloadtimer < CurTime() then
		self.reloadtimer = CurTime() + self.ReloadDelay
		self:SendWeaponAnim(ACT_VM_RELOAD)

		self.Owner:RemoveAmmo(1, self.Primary.Ammo, false)
		self:SetClip1(self:Clip1() + 1)
		self:EmitSound("Weapon_Shotgun.Reload")

		if self.Primary.ClipSize <= self:Clip1() or self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then
			self.nextreloadfinish = CurTime() + self.ReloadDelay
			self.reloading = false
			self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		end
	end

	local nextreloadfinish = self.nextreloadfinish
	if nextreloadfinish ~= 0 and nextreloadfinish < CurTime() then
		self:EmitSound("Weapon_M3.Pump")
		self:SendWeaponAnim(ACT_SHOTGUN_PUMP)
		self.nextreloadfinish = 0
	end

	if self:GetIronsights() and not self.Owner:KeyDown(IN_ATTACK2) then
		self:SetIronsights(false)
	end

	local pl = self.Owner
	local cone = self:GetCone()
	if self.PukeLeft > 0 and CurTime() >= self.NextPuke and SERVER then
		self.PukeLeft = self.PukeLeft - 1
		self.NextEmit = CurTime() + 0.1

		local ent = ents.Create("projectile_poisonflesh")
		if ent:IsValid() then
			ent:SetPos(pl:GetShootPos())
			ent:SetOwner(pl)
			ent:Spawn()
			ent.Damage = self.Primary.Damage
			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then
				local r1 = math.random(-40000*cone, 40000*cone) / 1000
				local r2 = math.random(-40000*cone, 40000*cone) / 1000
				local r3 = math.random(-40000*cone, 40000*cone) / 1000
				local ShotAng = (self.Owner:EyeAngles() + Angle(r1, r2, r3)):Forward()
				phys:Wake()
				phys:SetVelocityInstantaneous(ShotAng * 2500)
				--phys:EnableGravity(false)
			end
		end
	end

	if self.BaseClass.Think then
		self.BaseClass.Think(self)
	end
end

function SWEP:CanPrimaryAttack()
	if self.Owner:IsHolding() or self.Owner:GetBarricadeGhosting() then return false end

	if self:Clip1() <= 0 then
		self:EmitSound("Weapon_Shotgun.Empty")
		self:SetNextPrimaryFire(CurTime() + 0.25)
		return false
	end

	if self.reloading then
		if 0 < self:Clip1() then
			self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
		else
			self:SendWeaponAnim(ACT_VM_IDLE)
		end
		self.reloading = false
		self:SetNextPrimaryFire(CurTime() + 0.25)
		return false
	end

	return true
end
