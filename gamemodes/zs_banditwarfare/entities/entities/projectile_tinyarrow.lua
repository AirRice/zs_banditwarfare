AddCSLuaFile()

ENT.Base = "projectile__base"

ENT.LifeTime = 20
ENT.Damage = 10

if SERVER then
	function ENT:Initialize()
		self:SetupProjectile(true)
		self:SetSkin(1)
		self:EmitSound("Weapon_Crossbow.BoltFly");
		self.DieTime = CurTime() + self.LifeTime
	end
	
	function ENT:Hit(vHitPos, vHitNormal, eHitEntity, vOldVelocity)
		self:SetSkin(0)
		self.BaseClass.Hit(self, vHitPos, vHitNormal, eHitEntity, vOldVelocity)
	end
end