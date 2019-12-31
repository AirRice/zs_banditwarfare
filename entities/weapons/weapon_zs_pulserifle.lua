AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "'아도니스' 펄스 돌격소총"
	SWEP.Description = "큰 피해를 입히며 적을 느리게 한다."
	SWEP.Slot = 2
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "Vent"
	SWEP.HUD3DPos = Vector(1, 0, 0)	
	SWEP.HUD3DScale = 0.018
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/c_irifle.mdl"
SWEP.WorldModel = "models/weapons/w_IRifle.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_SMG1.Reload")
SWEP.Primary.Sound = Sound("Airboat.FireGunHeavy")
SWEP.Primary.Damage = 26
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.2

SWEP.Primary.ClipSize = 20
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pulse"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 0.05
SWEP.ConeMin = 0.006
SWEP.Recoil = 0.42
SWEP.WalkSpeed = SPEED_SLOW

SWEP.IronSightsPos = Vector(-3, 1, 1)

SWEP.TracerName = "AR2Tracer"

function SWEP.BulletCallback(attacker, tr, dmginfo)
	local ent = tr.Entity
	if ent:IsValid() and ent:IsPlayer() and ent:Team() ~= attacker:Team() then
		ent:AddLegDamage(6)
	end

	local e = EffectData()
		e:SetOrigin(tr.HitPos)
		e:SetNormal(tr.HitNormal)
		e:SetRadius(8)
		e:SetMagnitude(1)
		e:SetScale(1)
	util.Effect("cball_bounce", e)

	GenericBulletCallback(attacker, tr, dmginfo)
end
