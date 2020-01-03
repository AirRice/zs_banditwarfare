AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "'Z9000' 펄스 권총"
	SWEP.Description = "이 펄스 권총은 큰 피해를 입히진 않지만, 대상을 느려지게 한다."
	SWEP.Slot = 1
	SWEP.SlotPos = 0
	
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "ValveBiped.square"
	SWEP.HUD3DPos = Vector(1.1, 0.25, -2)
	SWEP.HUD3DScale = 0.015

	SWEP.ShowViewModel = false

	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/weapons/w_alyx_gun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7, 2, -4.092), angle = Angle(170, 10, 10), size = Vector(1.1, 1.1, 1.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "pistol"

SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_alyx_gun.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_Alyx_Gun.Reload")
SWEP.Primary.Sound = Sound("Weapon_Alyx_Gun.Single")
SWEP.Primary.Damage = 17
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.14

SWEP.Primary.ClipSize = 10
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pulse"
SWEP.Primary.DefaultClip = 50

SWEP.ConeMax = 0.02
SWEP.ConeMin = 0.01
SWEP.Recoil = 0.08
SWEP.MovingConeOffset = 0.02
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
SWEP.IronSightsPos = Vector(-5.95, 3, 2.75)
SWEP.IronSightsAng = Vector(-0.15, -1, 2)

SWEP.TracerName = "AR2Tracer"

function SWEP.BulletCallback(attacker, tr, dmginfo)
	local ent = tr.Entity
	if ent:IsValid() and ent:IsPlayer() and ent:Team() ~= attacker:Team() then
		ent:AddLegDamage(20)
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
