AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_stunstick_name"
	SWEP.TranslateDesc = "weapon_stunstick_desc"
	SWEP.ViewModelFOV = 50
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/weapons/w_stunbaton.mdl"
SWEP.UseHands = true

SWEP.HoldType = "melee"

SWEP.MeleeDamage = 20
SWEP.StunDamage = 30
SWEP.MeleeRange = 49
SWEP.MeleeSize = 1.5
SWEP.Primary.Delay = 0.9
SWEP.DamageType = DMG_CLUB

SWEP.SwingTime = 0.25
SWEP.SwingRotation = Angle(60, 0, 0)
SWEP.SwingOffset = Vector(0, -50, 0)
SWEP.SwingHoldType = "grenade"

function SWEP:PlaySwingSound()
	self:EmitSound("Weapon_StunStick.Swing")
end

function SWEP:PlayHitSound()
	self:EmitSound("Weapon_StunStick.Melee_HitWorld")
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("Weapon_StunStick.Melee_Hit")
end

function SWEP:PlayerHitUtil(owner, damage, hitent, dmginfo)
	hitent:MeleeViewPunch(damage*0.1)
	hitent:AddLegDamage(self.StunDamage)
	local invuln = hitent:GetStatus("spawnbuff")
	if not (invuln and invuln:IsValid()) then
		hitent:GiveStatus("stunned", 0.3)
	end
end
