AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_bioticsmg_name"
	SWEP.TranslateDesc = "weapon_bioticsmg_desc"
	SWEP.Slot = 2
	SWEP.SlotPos = 0

	SWEP.HUD3DBone = "ValveBiped.base"
	SWEP.HUD3DPos = Vector(1.5, 0.25, -2)
	SWEP.HUD3DScale = 0.02

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "smg"

SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_SMG1.Reload")
SWEP.Primary.Sound = Sound("Weapon_AR2.NPC_Single")
SWEP.Primary.Damage = 8
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.13

SWEP.Primary.ClipSize = 24
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "alyxgun"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SMG1

SWEP.ConeMax = 0.065
SWEP.ConeMin = 0.029
SWEP.Recoil = 0.15
SWEP.WalkSpeed = SPEED_NORMAL

function SWEP:ShootBullets(dmg, numbul, cone)
	local owner = self.Owner
	--owner:MuzzleFlash()
	if SERVER then
		self:SetConeAndFire()
	end
	self:DoRecoil()
	self:SendWeaponAnimation()
	owner:DoAttackEvent()

	--self.Owner:EmitSound("weapons/crossbow/bolt_fly4.wav")
	self.Owner:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav", 72, math.Rand(85, 95))
	--self.Owner:EmitSound("npc/headcrab_poison/ph_scream"..math.random(1, 3)..".wav",72,math.Rand(130,150))
	if CLIENT then return end
	local aimvec = owner:GetAimVector()
	for i=1, numbul do
	local ent = ents.Create("projectile_poisonflesh")
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
			phys:SetVelocityInstantaneous(ShotAng * 2500)
			phys:EnableGravity(false)
		end
	end
	end
end

--SWEP.IronSightsPos = Vector(-6.42, 4, 2.53)
SWEP.IronSightsPos = Vector(-6.425, 5, 1.02)
