AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Think()
	local owner = self:GetOwner()

	if self:GetDamage() <= 0 or not (owner:IsPlayer() and owner:Alive()) then
		self:Remove()
		return
	end
	if self.NextBleedTick <= CurTime() then
		local dmg = math.min(self:GetDamage(),math.random(1, 3))
 
		owner:TakeDamage(dmg, self.Damager and self.Damager:IsValid() and self.Damager:IsPlayer() and self.Damager:Team() ~= owner:Team() and self.Damager or owner, self)
		owner:AddLegDamage(dmg)
		self:AddDamage(-dmg)		
		local dir = VectorRand()
		dir:Normalize()
		util.Blood(owner:WorldSpaceCenter(), 6, dir, 64)
		self.NextBleedTick = CurTime() + 0.55
	end
	if self.NextStopBleedingTick <= CurTime() then
		local notmoving = (owner:GetVelocity():Length() <= 32)
		if notmoving then
			self:AddDamage(-2)	
		end
		self.NextStopBleedingTick = CurTime() + 0.1
	end

end
