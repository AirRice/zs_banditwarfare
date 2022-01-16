AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
ENT.Damage = 10
ENT.Finished = false
function ENT:Initialize()
	self:SetModel(Model("models/crossbow_bolt.mdl"))
	self:SetMoveType(MOVETYPE_FLYGRAVITY);
	self:SetMoveCollide(MOVECOLLIDE_FLY_CUSTOM);
	self:PhysicsInitBox(Vector(-5,-0.02,-0.02), Vector(5,0.02,0.02))
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetMass(3)
		phys:SetBuoyancyRatio(0.002)
		phys:SetAngleDragCoefficient(30)
		phys:EnableMotion(true)
		--phys:EnableGravity(false)
		phys:Wake()	
	end
	self:SetSkin(1)
	self:EmitSound("Weapon_Crossbow.BoltFly");
	self:Fire("kill", "", 30)
end

function ENT:Think()
	if self.PhysicsData then
		self:Hit(self.PhysicsData.HitPos, self.PhysicsData.HitNormal, self.PhysicsData.HitEntity, self.PhysicsData.OurOldVelocity)
	end
	local parent = self:GetParent()
	if parent:IsValid() and parent:IsPlayer() and not parent:Alive() then
		self:Remove()
	end
end

function ENT:Hit(vHitPos, vHitNormal, eHitEntity, vOldVelocity)
	if (self:GetHitTime() ~= 0 and CurTime() - self:GetHitTime() <= 0.01) or self.Finished then return end
	self:SetHitTime(CurTime())

	local owner = self:GetOwner()
	if not owner:IsValid() then owner = self end
	vHitPos = vHitPos or self:GetPos()
	vHitNormal = (vHitNormal or Vector(0, 0, -1)) * -1
	vDirNormal = vOldVelocity:GetNormalized()
	local edata = EffectData()
		edata:SetOrigin(vHitPos)
		edata:SetNormal(vHitNormal)
		edata:SetScale(1)
		edata:SetMagnitude(2)
    util.Effect("ElectricSpark", edata)

	if eHitEntity:IsWorld() then
		util.Decal("ExplosiveGunshot", vHitPos-vDirNormal, vHitPos+vDirNormal, self )
	elseif eHitEntity:IsValid() then
		eHitEntity:TakeDamage(math.floor((self.Damage or 25) * 1.5^self.Bounces) , owner, self)
		if eHitEntity:IsPlayer() and owner:IsPlayer() and eHitEntity:Team() ~= self:GetOwner():Team() then
			eHitEntity:EmitSound("Weapon_Crossbow.BoltHitBody")
			util.Blood(vHitPos, 30, vHitNormal, math.Rand(10,30), true)
		end
		self:Fire("kill", "", 0)
	end
	if self.Bounces < self.MaxBounces then
		self.Bounces = self.Bounces + 1
		self.PhysicsData = nil
	else
		self:SetSolid(SOLID_NONE)
		self:SetMoveType(MOVETYPE_NONE)
		self:Fire("kill", "", 10)
		self:SetSkin(0)
		self.Finished = true
	end
	local bouncedir = 2 * vHitNormal * vHitNormal:Dot(vDirNormal * -1) + vDirNormal
	self:EmitSound("Weapon_Crossbow.BoltHitWorld")
	if self.Finished then
		self:SetAngles(vOldVelocity:Angle())
		self:SetPos(vHitPos-vDirNormal*4)
	else	
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:SetAngleVelocity(Vector(0,0,0))
			self:SetAngles(bouncedir:Angle())
			self:SetPos(vHitPos+bouncedir*4)
			phys:SetVelocityInstantaneous(bouncedir*vOldVelocity:Length())
		end
	end
end
	

function ENT:PhysicsCollide(data, phys)
	local ent = data.HitEntity
	if ent:GetCollisionGroup() == COLLISION_GROUP_BREAKABLE_GLASS then 
		ent:TakeDamage(self.Damage or 25, self:GetOwner(), self)
		self:SetAngles(data.OurOldVelocity:Angle())
		self:SetVelocity(data.OurOldVelocity)
		return 
	end
	if not self:HitFence(data, phys) then
		self.PhysicsData = data
	end
	self:NextThink(CurTime())
end
