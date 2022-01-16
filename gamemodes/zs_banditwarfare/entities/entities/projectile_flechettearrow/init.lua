AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
ENT.Damage = 10
function ENT:Initialize()
	self:SetModel("models/Items/CrossbowRounds.mdl")
	self:SetModelScale(0.5, 0)
	self:SetMoveType(MOVETYPE_FLY);
	self:SetMoveCollide(MOVECOLLIDE_FLY_CUSTOM);
	self:PhysicsInitBox(Vector(-4,-0.05,-0.05), Vector(4,0.05,0.05))
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	self:UpdateTransmitState(TRANSMIT_PVS)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetMass(3)
		phys:SetBuoyancyRatio(0.002)
		phys:EnableMotion(true)
		phys:EnableGravity(false)
		phys:Wake()
	end
	self:EmitSound("Weapon_Crossbow.BoltFly");
	self:Fire("kill", "", 30)
end

ENT.LastEmit = 0
function ENT:Think()
	if self.Exploded then
		self:Remove()
	elseif self.Armed and self.DieTime <= CurTime() then
		self:Explode()
	end
	
	if self.PhysicsData then
		self:Hit(self.PhysicsData.HitPos, self.PhysicsData.HitNormal, self.PhysicsData.HitEntity, self.PhysicsData.OurOldVelocity)
	end

	local parent = self:GetParent()
	if parent:IsValid() and parent:IsPlayer() and not parent:Alive() then
		self:Remove()
	end
	
	if self.Armed and self.LastEmit <= CurTime() then
		local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos() + self:GetAngles():Forward()*-3)
			effectdata:SetNormal(self:GetAngles():Forward())
		util.Effect("flechette_charge", effectdata)
		self.LastEmit = CurTime() + 0.2
	end
end

function ENT:Hit(vHitPos, vHitNormal, eHitEntity, vOldVelocity)
	if self:GetHitTime() ~= 0 then return end
	self:SetHitTime(CurTime())

	local owner = self:GetOwner()
	if not owner:IsValid() then owner = self end
	vHitPos = vHitPos or self:GetPos()
	vHitNormal = (vHitNormal or Vector(0, 0, -1)) * -1
	vDirNormal = vOldVelocity:GetNormalized()
	self:SetSolid(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	local edata = EffectData()
		edata:SetOrigin(vHitPos)
		edata:SetNormal(vHitNormal)
		edata:SetScale(1)
		edata:SetMagnitude(2)
    util.Effect("ElectricSpark", edata)
	if eHitEntity:IsValid() then
		local bonecount = eHitEntity:GetBoneCount()
		if bonecount and bonecount <= 1 then
			self:SetParent(eHitEntity)
		end
	end
	local shoulddestroy = false
	if eHitEntity:IsWorld() then
		util.Decal("ExplosiveGunshot", vHitPos-vDirNormal, vHitPos+vDirNormal, self )
	elseif eHitEntity:IsValid() then
		if !eHitEntity:IsPlayer() then
			eHitEntity:TakeDamage(5, owner, self)
		elseif owner:IsPlayer() and eHitEntity:Team() ~= self:GetOwner():Team() then
			eHitEntity:TakeDamage(10, owner, self)
			eHitEntity:EmitSound("Weapon_Crossbow.BoltHitBody")
			util.Blood(vHitPos, 3, vHitNormal, math.Rand(2,5), true)
			self:Fire("kill", "", 0)
			shoulddestroy = true
		end
	end
	if not shoulddestroy then
		self:SetAngles(vOldVelocity:Angle())
		self:SetPos(vHitPos)
		self.DieTime = CurTime()+2
		self.Armed = true
		self:EmitSound("weapons/cguard/charging.wav",75, 50,0.5,CHAN_VOICE)
	end
end
	
function ENT:Explode()
	if self.Exploded then return end
	self.Exploded = true

	local owner = self:GetOwner()
	if owner:IsValid() and owner:IsPlayer() and (owner:Team() == TEAM_HUMAN or owner:Team() == TEAM_BANDIT) then
		local pos = self:GetPos()
		util.BlastDamage2(self, owner, pos, 96, self.Damage)

		local effectdata = EffectData()
			effectdata:SetOrigin(pos)
		util.Effect("Explosion", effectdata)
		self:EmitSound("npc/roller/mine/rmine_explode_shock1.wav",75,120,1,CHAN_VOICE)
	end
end

function ENT:PhysicsCollide(data, phys)
	local ent = data.HitEntity
	if ent:GetCollisionGroup() == COLLISION_GROUP_BREAKABLE_GLASS then 
		ent:TakeDamage(self.Damage or 15, self:GetOwner(), self)
		self:SetAngles(data.OurOldVelocity:Angle())
		self:SetVelocity(data.OurOldVelocity)
		return 
	end
	if not self:HitFence(data, phys) then
		self.PhysicsData = data
	end
	
	self:NextThink(CurTime())
end
