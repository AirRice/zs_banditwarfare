AddCSLuaFile()

ENT.Base = "projectile__base"

ENT.LifeTime = 20
ENT.Damage = 10
ENT.FinishOffset = 3

ENT.m_bboxMins = Vector(-2, -0.02, -0.02)
ENT.m_bboxMaxs = Vector(2, 0.02, 0.02)

function ENT:Initialize()
	if SERVER then
		self:SetupProjectile(true)
		self:SetSkin(1)
		self:SetMaterial("models/props_combine/metal_combinebridge001")
		self:EmitSound("Weapon_Crossbow.BoltFly");
		self.DieTime = CurTime() + self.LifeTime
	else
		local scale = Vector(0.3,1,1)
		local mat = Matrix()
		mat:Scale(scale)
		self:EnableMatrix("RenderMultiply", mat)
	end
end

if SERVER then
	function ENT:Hit(vHitPos, vHitNormal, eHitEntity, vOldVelocity)
		self:SetSkin(0)
		self.BaseClass.Hit(self, vHitPos, vHitNormal, eHitEntity, vOldVelocity)
	end
end