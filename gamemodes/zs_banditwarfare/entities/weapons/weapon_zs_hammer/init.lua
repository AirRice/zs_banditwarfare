AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function SWEP:Reload()
	if CurTime() < self:GetNextPrimaryFire() then return end

	local owner = self:GetOwner()
	if owner:GetBarricadeGhosting() then return end

	local tr = owner:CompensatedMeleeTrace(self.MeleeRange, self.MeleeSize)
	local trent = tr.Entity
	if not trent:IsValid() or not trent:IsNailed() or not trent:IsSameTeam(self:GetOwner()) then return end
	
	local ent
	local dist

	for _, e in pairs(ents.FindByClass("prop_nail")) do
		if not e.m_PryingOut and e:GetParent() == trent then
			local edist = e:GetActualPos():Distance(tr.HitPos)
			if not dist or edist < dist then
				ent = e
				dist = edist
			end
		end
	end

	if not ent or not gamemode.Call("CanRemoveNail", owner, ent) then return end

	local nailowner = ent:GetOwner()

	self:SetNextPrimaryFire(CurTime() + 1)

	ent.m_PryingOut = true -- Prevents infinite loops

	self:SendWeaponAnim(self.Alternate and ACT_VM_HITCENTER or ACT_VM_MISSCENTER)
	self.Alternate = not self.Alternate

	owner:DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE)

	owner:EmitSound("weapons/melee/crowbar/crowbar_hit-"..math.random(4)..".ogg")

	ent:GetParent():RemoveNail(ent, nil, self:GetOwner())

	if nailowner and nailowner:IsValid() and nailowner:IsPlayer() and owner:IsValid() and owner:IsPlayer() and nailowner ~= owner and nailowner:Team() == owner:Team() then

		if nailowner:NearestPoint(tr.HitPos):Distance(tr.HitPos) <= 768 and (nailowner:HasWeapon("weapon_zs_hammer") or nailowner:HasWeapon("weapon_zs_electrohammer")) then
			nailowner:GiveAmmo(1, self.Primary.Ammo)
		else
			owner:GiveAmmo(1, self.Primary.Ammo)
		end
	else
		owner:GiveAmmo(1, self.Primary.Ammo)
	end
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if hitent:IsValid() then
		local didrepair = false
		if hitent.HitByHammer and hitent:HitByHammer(self, self:GetOwner(), tr) then
			didrepair = true
		elseif hitent.HitByWrench and hitent:HitByWrench(self, self:GetOwner(), tr) then
			didrepair = true
		elseif hitent.GetObjectHealth and 
		(hitent.GetObjectOwner and hitent:GetObjectOwner():IsPlayer() and hitent:GetObjectOwner():Team() == self:GetOwner():Team() or 
		hitent.GetOwner and hitent:GetOwner():IsPlayer() and hitent:GetOwner():Team() == self:GetOwner():Team()) then
			local oldhealth = hitent:GetObjectHealth()
			if oldhealth <= 0 or oldhealth >= hitent:GetMaxObjectHealth() or hitent.m_LastDamaged and CurTime() < hitent.m_LastDamaged + 0.5 then return end
			hitent:SetObjectHealth(math.min(hitent:GetMaxObjectHealth(), hitent:GetObjectHealth() + healstrength/2))
			local healed = hitent:GetObjectHealth() - oldhealth
			gamemode.Call("PlayerRepairedObject", self:GetOwner(), hitent, healed / 2, self)
			didrepair = true
		end
		if didrepair then
			self:PlayRepairSound(hitent)
			local effectdata = EffectData()
				effectdata:SetOrigin(tr.HitPos)
				effectdata:SetNormal(tr.HitNormal)
				effectdata:SetMagnitude(1)
			util.Effect("nailrepaired", effectdata, true, true)
			return true
		end
	end
end

function SWEP:SecondaryAttack()
	if self:GetPrimaryAmmoCount() <= 0 or CurTime() < self:GetNextPrimaryFire() or self:GetOwner():GetBarricadeGhosting() then return end
	if GAMEMODE:IsClassicMode() then
		owner:PrintTranslatedMessage(HUD_PRINTCENTER, "cant_do_that_in_classic_mode")
		return
	end
	local owner = self:GetOwner()
	local tr = owner:CompensatedMeleeTrace(64, self.MeleeSize, nil, nil)
	if owner:AttemptNail(tr,true) then
		self:SendWeaponAnim(self.Alternate and ACT_VM_HITCENTER or ACT_VM_MISSCENTER)
		self.Alternate = not self.Alternate
		owner:DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE)
		self:SetNextPrimaryFire(CurTime() + 1)
		self:TakePrimaryAmmo(1)
	end
end
