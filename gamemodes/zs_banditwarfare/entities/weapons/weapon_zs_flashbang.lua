AddCSLuaFile()
if CLIENT then
	SWEP.TranslateName = "weapon_flashbang_name"
	SWEP.TranslateDesc = "weapon_flashbang_desc"
	SWEP.ViewModelFOV = 60

	SWEP.Slot = 4
	SWEP.SlotPos = 0
	--[[function SWEP:GetViewModelPosition(pos, ang)
		if self:GetPrimaryAmmoCount() <= 0 then
			return pos + ang:Forward() * -256, ang
		end

		return pos, ang
	end]]

	function SWEP:DrawWeaponSelection(...)
		return self:BaseDrawWeaponSelection(...)
	end
end

SWEP.ViewModel = "models/weapons/cstrike/c_eq_flashbang.mdl"
SWEP.WorldModel = "models/weapons/w_eq_flashbang.mdl"
SWEP.UseHands = true

SWEP.AmmoIfHas = true

SWEP.Primary.ClipSize = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "rpg_round"
SWEP.Primary.Delay = 1.25
SWEP.Primary.DefaultClip = 1

SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Ammo = "dummy"

SWEP.WalkSpeed = SPEED_FAST
SWEP.IsConsumable = true

function SWEP:Initialize()
	self:SetWeaponHoldType("grenade")
	self:SetDeploySpeed(1.1)
	if CLIENT then
		if self.TranslateName then
			self.PrintName = translate.Get(self.TranslateName)
		end
	end
end

function SWEP:Precache()
	util.PrecacheSound("WeaponFrag.Throw")
end

function SWEP:CanPrimaryAttack()
	if self:GetOwner():IsHolding() or self:GetOwner():GetBarricadeGhosting() then return false end

	if self:GetPrimaryAmmoCount() <= 0 then
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		return false
	end

	return true
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	local owner = self:GetOwner()
	self:SendWeaponAnim(ACT_VM_THROW)
	owner:DoAttackEvent()

	self:TakePrimaryAmmo(1)
	self.NextDeploy = CurTime() + 1

	if SERVER then
		local eyeang = owner:EyeAngles()
		local eyeforward = eyeang:Forward()
		local eyeright = eyeang:Right()
		local throworigin = owner:EyePos() + eyeforward * 18 + eyeright * 8;

		local tossvel = owner:GetVelocity()
		tossvel = tossvel + owner:GetAimVector() * 1300;

		local ent = ents.Create("projectile_zsflashbang")
		if ent:IsValid() then
			ent:SetPos(throworigin)
			ent:SetOwner(owner)
			ent:Spawn()
			ent:EmitSound("WeaponFrag.Throw")
			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then
				phys:Wake()
				phys:AddAngleVelocity(Vector(600,math.random(-1200,1200),0))
				phys:SetVelocityInstantaneous(tossvel)
			end
		end
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:CanSecondaryAttack()
	return false
end

function SWEP:Reload()
	return false
end

function SWEP:Deploy()
	GAMEMODE:WeaponDeployed(self:GetOwner(), self)

	if self:GetPrimaryAmmoCount() <= 0 then
		self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
	end

	return true
end

function SWEP:Holster()
	self.NextDeploy = nil
	return true
end

function SWEP:Think()
	if self.NextDeploy and self.NextDeploy <= CurTime() then
		self.NextDeploy = nil

		if 0 < self:GetPrimaryAmmoCount() then
			self:SendWeaponAnim(ACT_VM_DRAW)
		else
			self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)

			if SERVER then
				self:GetOwner():StripWeapon(self:GetClass())
			end
		end
	elseif SERVER and self:GetPrimaryAmmoCount() <= 0 then
		self:GetOwner():StripWeapon(self:GetClass())
	end
end