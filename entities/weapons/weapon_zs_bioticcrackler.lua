AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "'크래클러' 돌격 소총"
	SWEP.Slot = 2
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "v_weapon.famas"
	SWEP.HUD3DPos = Vector(1.1, -3.5, 10)
	SWEP.HUD3DScale = 0.02
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/cstrike/c_rif_famas.mdl"
SWEP.WorldModel = "models/weapons/w_rif_famas.mdl"
SWEP.UseHands = true

SWEP.ReloadSound = Sound("Weapon_FAMAS.Clipout")
SWEP.Primary.Sound = Sound("Weapon_FAMAS.Single")
SWEP.Primary.Damage = 13
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.135

SWEP.Primary.ClipSize = 22
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "alyxgun"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 0.047
SWEP.ConeMin = 0.021
SWEP.Recoil = 0.475

SWEP.WalkSpeed = SPEED_SLOW

SWEP.IronSightsPos = Vector(-3, 3, 2)

function SWEP:ShootBullets(dmg, numbul, cone)
	local owner = self.Owner
	--owner:MuzzleFlash()
	self:CalcRecoil()
	self:SendWeaponAnimation()
	owner:DoAttackEvent()
	self:SetShotsFired(self:GetShotsFired()+1)
	self:EmitSound("weapons/slam/throw.wav", 70, math.random(78, 82))
	if CLIENT then return end
	local aimvec = owner:GetAimVector()
	for i=1, numbul do
	local ent = ents.Create("prop_thrownbaby")
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
			phys:SetVelocityInstantaneous(ShotAng * 6000)
		end
	end
	end
end
