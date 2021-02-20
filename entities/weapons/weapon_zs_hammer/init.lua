AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function SWEP:Reload()
	if CurTime() < self:GetNextPrimaryFire() then return end

	local owner = self.Owner
	if owner:GetBarricadeGhosting() then return end

	local tr = owner:MeleeTrace(self.MeleeRange, self.MeleeSize, owner:GetMeleeFilter())
	local trent = tr.Entity
	if not trent:IsValid() or not trent:IsNailed() or not trent:IsSameTeam(self.Owner) then return end
	
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

	ent:GetParent():RemoveNail(ent, nil, self.Owner)

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
		if hitent.HitByHammer and hitent:HitByHammer(self, self.Owner, tr) then
			return
		end
		if hitent.HitByWrench and hitent:HitByWrench(self, self.Owner, tr) then
			return
		end
		local didrepair = false
		if hitent:IsNailed() and hitent:IsSameTeam(self.Owner) then
			local healstrength = GAMEMODE.NailHealthPerRepair * (self.Owner.HumanRepairMultiplier or 1) * self.HealStrength
			local oldhealth = hitent:GetBarricadeHealth()
			if oldhealth <= 0 or oldhealth >= hitent:GetMaxBarricadeHealth() or hitent:GetBarricadeRepairs() <= 0 then return end

			hitent:SetBarricadeHealth(math.min(hitent:GetMaxBarricadeHealth(), hitent:GetBarricadeHealth() + math.min(hitent:GetBarricadeRepairs(), healstrength)))
			local healed = hitent:GetBarricadeHealth() - oldhealth
			hitent:SetBarricadeRepairs(math.max(hitent:GetBarricadeRepairs() - healed, 0))
			self:PlayRepairSound(hitent)
			gamemode.Call("PlayerRepairedObject", self.Owner, hitent, healed, self)
			didrepair = true
		elseif hitent:GetClass() == "prop_gunturret" and hitent:GetObjectOwner():IsPlayer() and hitent:GetObjectOwner():Team() == self.Owner:Team() and hitent:GetObjectHealth() >= hitent:GetMaxObjectHealth() then 
			local curammo = hitent:GetAmmo()
			hitent:SetAmmo(curammo + 20)
			hitent:EmitSound("npc/turret_floor/click1.wav")
			gamemode.Call("PlayerRepairedObject", self.Owner, hitent, 20, self)
		elseif hitent.GetObjectHealth and 
		(hitent.GetObjectOwner and hitent:GetObjectOwner():IsPlayer() and hitent:GetObjectOwner():Team() == self.Owner:Team() or 
		hitent.GetOwner and hitent:GetOwner():IsPlayer() and hitent:GetOwner():Team() == self.Owner:Team()) then
			local oldhealth = hitent:GetObjectHealth()
			if oldhealth <= 0 or oldhealth >= hitent:GetMaxObjectHealth() or hitent.m_LastDamaged and CurTime() < hitent.m_LastDamaged + 4 then return end

			local healstrength = (self.Owner.HumanRepairMultiplier or 1) * self.HealStrength * (hitent.WrenchRepairMultiplier or 1)

			hitent:SetObjectHealth(math.min(hitent:GetMaxObjectHealth(), hitent:GetObjectHealth() + healstrength))
			local healed = hitent:GetObjectHealth() - oldhealth
			self:PlayRepairSound(hitent)
			gamemode.Call("PlayerRepairedObject", self.Owner, hitent, healed / 2, self)

			didrepair = true
		elseif hitent:GetClass() == "prop_obj_sigil" and hitent:GetSigilTeam() == self.Owner:Team() and not hitent:GetCanCommunicate() then
			gamemode.Call("PlayerRepairedObject", self.Owner, hitent, 20, self)
			hitent:SetSigilNextRestart(hitent:GetSigilNextRestart() - 3)
			didrepair = true
		end
		if didrepair then
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
	if self:GetPrimaryAmmoCount() <= 0 or CurTime() < self:GetNextPrimaryFire() or self.Owner:GetBarricadeGhosting() then return end
	if GAMEMODE:IsClassicMode() then
		owner:PrintTranslatedMessage(HUD_PRINTCENTER, "cant_do_that_in_classic_mode")
		return
	end
	local owner = self.Owner
	local tr = owner:TraceLine(64, MASK_SOLID, owner:GetMeleeFilter())
	if owner:AttemptNail(tr,true) then
		self:SendWeaponAnim(self.Alternate and ACT_VM_HITCENTER or ACT_VM_MISSCENTER)
		self.Alternate = not self.Alternate
		owner:DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE)
		self:SetNextPrimaryFire(CurTime() + 1)
		self:TakePrimaryAmmo(1)
	end
end
