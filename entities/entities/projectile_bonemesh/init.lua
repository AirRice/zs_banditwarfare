AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.LifeTime = 1.5

function ENT:Initialize()
	self:SetModel("models/gibs/HGIBS_rib.mdl")
	self:PhysicsInitSphere(13)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetModelScale(2.6, 0)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	self:SetCustomCollisionCheck(true)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetMass(20)
		phys:SetBuoyancyRatio(0.002)
		phys:EnableMotion(true)
		phys:EnableGravity(false)
		phys:Wake()
	end

	self.DeathTime = CurTime() + 30
	self.ExplodeTime = CurTime() + self.LifeTime
end

function ENT:Think()
	if self.PhysicsData then
		self:Hit(self.PhysicsData.HitPos, self.PhysicsData.HitNormal, self.PhysicsData.HitEntity, self.PhysicsData.OurOldVelocity, self.PhysicsData.Speed)
	end
	
	if self.ExplodeTime <= CurTime() then
		self:Explode()
	end

	if self.DeathTime <= CurTime() then
		self:Remove()
	end
	
	local parent = self:GetParent()
	if parent:IsValid() and parent:IsPlayer() and not parent:Alive() then
		self:Remove()
	end
	
	self:NextThink(CurTime())
	return true
end

function ENT:Explode()
	if self.Exploded then return end
	self.Exploded = true
	self.DeathTime = 0

	local pos = self:GetPos()
	local owner = self:GetOwner()
	if not owner:IsValid() then owner = self end
	util.PoisonBlastDamage(self, owner, pos, 180, self.Damage)

	local effectdata = EffectData()
		effectdata:SetOrigin(pos)
	util.Effect("bonemeshexplode", effectdata)

	util.Blood(pos, 150, Vector(0, 0, 1), 300, true)
end

function ENT:Hit(vHitPos, vHitNormal, eHitEntity, vOldVelocity, speed)
	if self:GetHitTime() ~= 0 then return end
	if eHitEntity and eHitEntity:IsValid() then
		if eHitEntity:IsPlayer() and self:GetOwner():IsPlayer() and eHitEntity:Team() ~= self:GetOwner():Team() then
			self.ExplodeTime = CurTime() + 3
			self:SetHitTime(CurTime())
			eHitEntity:AddLegDamage(70)
			eHitEntity:PoisonDamage(self.Damage, self:GetOwner(), self)
			local pushvel = vOldVelocity*0.5
			pushvel.z = math.max(pushvel.z, 10)
			eHitEntity:SetGroundEntity(nil)
			eHitEntity:SetLocalVelocity(eHitEntity:GetVelocity() + pushvel)
			local owner = self:GetOwner()
			local team = owner:IsPlayer() and owner:Team() or nil
			if not owner:IsValid() then owner = self end

			vHitPos = vHitPos or self:GetPos()
			vHitNormal = (vHitNormal or Vector(0, 0, -1)) * -1

			self:SetSolid(SOLID_NONE)
			self:SetMoveType(MOVETYPE_NONE)

			self:SetPos(vHitPos + vHitNormal)

			if eHitEntity:IsValid() then
				self:AddEFlags(EFL_SETTING_UP_BONES)

				local followed = false
				local bonecount = eHitEntity:GetBoneCount()
				if bonecount and bonecount > 1 then
					local boneindex = eHitEntity:NearestBone(vHitPos)
					if boneindex and boneindex > 0 then
						self:FollowBone(eHitEntity, boneindex)
						self:SetPos((eHitEntity:GetBonePositionMatrixed(boneindex) * 2 + vHitPos) / 3)
						followed = true
					end
				end
				if not followed then
					self:SetParent(eHitEntity)
				end
				self:SetOwner(eHitEntity)
			end
			util.Blood(vHitPos, 60, vHitNormal, 150, true)
			self:SetAngles(vOldVelocity:Angle())
		else
			eHitEntity:PoisonDamage(self.Damage, self:GetOwner(), self)
			self.ExplodeTime = 0
			self:NextThink(CurTime())
		end
	elseif self.PhysicsObj and self.PhysicsObj:IsValid() then
		local normal = vOldVelocity:GetNormalized()
		local DotProduct = vHitNormal:Dot(normal * -1)
		self.PhysicsObj:SetVelocityInstantaneous((2 * DotProduct * vHitNormal + normal) * math.max(100, speed) * 0.9)
	end
end

function ENT:PhysicsCollide(data, physobj)
	if 20 < data.Speed and 0.2 < data.DeltaTime then
		self:EmitSound("physics/body/body_medium_impact_hard"..math.random(6)..".wav", 74, math.Rand(95, 105))
	end
	self.PhysicsData = data
	self.PhysicsObj = physobj
	self:NextThink(CurTime())
end
