AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "'바이오틱' 오웬스"
	SWEP.Description = "고기덩어리를 쏜다."
	SWEP.Slot = 1
	SWEP.SlotPos = 0
	
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "ValveBiped.square"
	SWEP.HUD3DPos = Vector(1.1, 0.25, -2)
	SWEP.HUD3DScale = 0.015
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "pistol"

SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_Pistol.Reload")
SWEP.Primary.Sound = Sound("Weapon_Pistol.NPC_Single")
SWEP.Primary.Damage = 6
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.2

SWEP.Primary.ClipSize = 12
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "alyxgun"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 0.1
SWEP.ConeMin = 0.04
SWEP.Recoil = 0.82
SWEP.IronSightsPos = Vector(-5.95, 3, 2.75)
SWEP.IronSightsAng = Vector(-0.15, -1, 2)

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	self:EmitFireSound()
	self:TakeAmmo()
	self.IdleAnimation = CurTime() + self:SequenceDuration()
	self:ShootBullets(self.Primary.Damage, self.Primary.NumShots, self:GetCone())
end

function SWEP:ShootBullets(dmg, numbul, cone)
	local owner = self.Owner
	--owner:MuzzleFlash()
	self:CalcRecoil()
	self:SendWeaponAnimation()
	owner:DoAttackEvent()
	self:SetShotsFired(self:GetShotsFired()+1)
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav", 72, math.Rand(85, 95))
	if CLIENT then return end
	local aimvec = owner:GetAimVector()
	for i=1, numbul do
	local ent = ents.Create("projectile_poisonegg")
	if ent:IsValid() then
		ent:SetOwner(owner)
		aimvec.z = math.max(aimvec.z, -0.25)
		aimvec:Normalize()
		local vStart = owner:GetShootPos()
		ent:SetPos(vStart)
		ent:Spawn()
		ent.Damage = self.Primary.Damage
		local phys = ent:GetPhysicsObject()
		if phys:IsValid() then
			local r1 = math.random(-40000*cone, 40000*cone) / 1000
			local r2 = math.random(-40000*cone, 40000*cone) / 1000
			local r3 = math.random(-40000*cone, 40000*cone) / 1000
			local ShotAng = (self.Owner:EyeAngles() + Angle(r1, r2, r3)):Forward()
			phys:Wake()
			phys:SetVelocityInstantaneous(ShotAng * 3000)
			phys:EnableGravity(false)
		end
	end
	end
end