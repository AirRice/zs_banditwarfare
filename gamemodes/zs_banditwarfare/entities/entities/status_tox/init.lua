AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Think()
	local owner = self:GetOwner()

	if self:GetTime() <= 0 or not owner:Alive() or (owner:Team() == self.Damager:Team() and owner ~= self.Damager) then
		self:Remove()
		return
	end

	local dmg = self.Damage
	owner:EmitSound("ambient/machines/steam_release_2.wav", 70, 125)
	owner:TakeSpecialDamage(dmg, DMG_NERVEGAS, self.Damager and self.Damager:IsValid() and self.Damager:IsPlayer() and self.Damager:Team() ~= owner:Team() and self.Damager or owner, self)
	self:AddTime(-self.TimeInterval)
	self:NextThink(CurTime() + self.TimeInterval)
	return true
end
