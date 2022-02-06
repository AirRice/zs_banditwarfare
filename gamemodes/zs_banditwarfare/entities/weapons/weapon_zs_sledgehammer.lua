AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_sledgehammer_name"
	SWEP.TranslateDesc = "weapon_sledgehammer_desc"
	SWEP.ViewModelFOV = 75
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.HoldType = "melee2"

SWEP.DamageType = DMG_CLUB

SWEP.ViewModel = "models/weapons/v_sledgehammer/c_sledgehammer.mdl"
SWEP.WorldModel = "models/weapons/w_sledgehammer.mdl"
SWEP.UseHands = true

SWEP.MeleeDamage = 80
SWEP.MeleeRange = 64
SWEP.MeleeSize = 1.75
SWEP.MeleeKnockBack = 70

SWEP.Primary.Delay = 1.15

SWEP.WalkSpeed = SPEED_SLOWEST

SWEP.SwingRotation = Angle(60, 0, -80)
SWEP.SwingOffset = Vector(0, -30, 0)
SWEP.SwingTime = 0.75
SWEP.SwingHoldType = "melee"

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(35, 45))
end

function SWEP:PlayHitSound()
	self:EmitSound("physics/metal/metal_canister_impact_hard"..math.random(3)..".wav", 75, math.Rand(86, 90))
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav", 75, math.Rand(86, 90))
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if IsValid(hitent) then
		if not hitent:IsPlayer() and self:GetOwner():IsPlayer() then
			if hitent:GetClass() == "prop_drone" or hitent:GetClass() == "prop_manhack" and not hitent:IsSameTeam(self:GetOwner()) and SERVER then
				hitent:Destroy()
			elseif (hitent:IsNailed() and not hitent:IsSameTeam(self:GetOwner())) or (hitent.IsBarricadeObject and not hitent:IsSameTeam(self:GetOwner()) and SERVER) then
				hitent:TakeSpecialDamage(self.MeleeDamage * 2, DMG_DIRECT, self:GetOwner(), self, tr.HitPos)
			end
		end
	end
end