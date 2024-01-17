AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function SWEP:OnRepair(hitent, tr)
	if hitent:IsValid() then
		local healstrength = GAMEMODE.NailHealthPerRepair * (self:GetOwner().HumanRepairMultiplier or 1) * (self.HealStrength or 1)
		local didrepair = false
		if hitent.HitByHammer and hitent:HitByHammer(self, self:GetOwner(), tr)  or hitent:DefaultHitByHammer(self, self:GetOwner(), tr) then
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
