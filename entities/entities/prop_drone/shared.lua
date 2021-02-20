ENT.Type = "anim"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.m_NoNailUnfreeze = true
ENT.NoNails = true

ENT.WrenchRepairMultiplier = 1
ENT.ControllerClass = "weapon_zs_dronecontrol"
ENT.WeaponClass = "weapon_zs_drone"
ENT.HoverSpeed = 84
ENT.HoverHeight = 58
ENT.HoverForce = 64
ENT.Acceleration = 800
ENT.MaxSpeed = 260
ENT.TurnSpeed = 70
ENT.IdleDrag = 1

function ENT:ShouldNotCollide(ent)
	return (ent:IsPlayer() and self:GetOwner():IsPlayer() and ent:Team() == self:GetOwner():Team())
end

function ENT:SetObjectHealth(health)
	self:SetDTFloat(0, health)

	if health <= 0 and not self.Destroyed then
		self.Destroyed = true
	end
end

function ENT:BeingControlled()
	local owner = self:GetOwner()
	if owner:IsValid() then
		local wep = owner:GetActiveWeapon()
		return wep:IsValid() and wep:GetClass() == self.ControllerClass and wep:GetDTBool(0)
	end

	return false
end

function ENT:GetObjectHealth()
	return self:GetDTFloat(0)
end

function ENT:SetMaxObjectHealth(health)
	self:SetDTFloat(1, health)
end

function ENT:GetMaxObjectHealth()
	return self:GetDTFloat(1)
end

function ENT:GetRedLightPos()
	return self:LocalToWorld(Vector(3, 0, 13.75))
end

function ENT:GetRedLightAngles()
	return self:GetAngles()
end
