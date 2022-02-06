AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_crowbar_name"
	SWEP.TranslateDesc = "weapon_crowbar_desc"

	SWEP.ViewModelFOV = 65
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true

SWEP.HoldType = "melee"

SWEP.MeleeDamage = 45
SWEP.MeleeRange = 55
SWEP.MeleeSize = 1.5
SWEP.MeleeKnockBack = 10
SWEP.DamageType = DMG_CLUB
SWEP.Primary.Delay = 0.7

SWEP.SwingTime = 0.4
SWEP.SwingRotation = Angle(30, -30, -30)
SWEP.SwingHoldType = "grenade"

function SWEP:PlaySwingSound()
	self:EmitSound("Weapon_Crowbar.Single")
end

function SWEP:PlayHitSound()
	self:EmitSound("Weapon_Crowbar.Melee_HitWorld")
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("Weapon_Crowbar.Melee_Hit")
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if math.random(10) < 4 then
		if hitent:IsNailed() and not hitent:IsSameTeam(attacker) then
			if not hitent:IsValid() or not hitent:IsNailed() or hitent:IsSameTeam(attacker) then return end
			if not hitent or not gamemode.Call("CanRemoveNail", attacker, hitent) then return end
			local nailowner = hitent:GetOwner()
			if nailowner:IsValid() and nailowner:IsPlayer() and attacker:IsPlayer() and nailowner ~= attacker and nailowner:Team() == attacker:Team() then return end
			for _, e in pairs(ents.FindByClass("prop_nail")) do
				if not e.m_PryingOut and e:GetParent() == hitent and SERVER then
					hitent:RemoveNail(e, nil, attacker)
					e.m_PryingOut = true -- Prevents infinite loops	
					break
				end
			end
			if not hitent:IsNailed() then
				hitent:SetLocalVelocity( hitent:GetVelocity() + tr.Normal*200)
			end
		end
	end
end
