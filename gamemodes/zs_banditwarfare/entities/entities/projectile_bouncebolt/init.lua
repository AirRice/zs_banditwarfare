AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
ENT.Damage = 10
ENT.Finished = false
ENT.Touched = nil
ENT.Damaged = nil
function ENT:Initialize()
	self:SetupProjectile(true, nil, nil, nil, nil, 30)
	self:SetSkin(1)
	self:EmitSound("Weapon_Crossbow.BoltFly");
	self.DieTime = CurTime() + self.LifeTime
end

local temp_me = NULL
local myteammates = {}
local function BounceArrowFilter(ent)
	if ent == temp_me or table.HasValue(myteammates,ent) then
		return false
	end

	return true
end

function ENT:PhysicsUpdate(phys)
	local vel = self.PreVel or phys:GetVelocity()
	if self.PreVel then self.PreVel = nil end

	temp_me = self
	myteammates = self:GetOwner():IsPlayer() and team.GetPlayers(self:GetOwner():Team()) or {}
	if not self.Finished then
		local velnorm = vel:GetNormalized()
		local ahead = (vel:LengthSqr() * FrameTime()) / 1200
		local fwd = velnorm * ahead
		local start = self:GetPos() - fwd
		
		local proj_trace = {mask = MASK_SHOT, filter = BounceArrowFilter}

		proj_trace.start = start
		proj_trace.endpos = start + fwd

		local tr = util.TraceLine(proj_trace)

		if tr.Hit and not self.Touched then
			local ent = tr.Entity
			if ent ~= self:GetOwner() and (ent:IsPlayer() and ent:Team() ~= self:GetOwner():Team() and ent:Alive()) then
				self.Touched = tr
			end
		end
	end
end

function ENT:Think()
	if self.PhysicsData then
		self:Hit(self.PhysicsData.HitPos, self.PhysicsData.HitNormal, self.PhysicsData.HitEntity, self.PhysicsData.OurOldVelocity)
	end

	if self.DieTime <= CurTime() then
		self:Remove()
	end
	if self.Touched and not self.Damaged then
		local damage = (self.Damage or 100)
		local processed_dmg = math.floor((self.Damage or 25) * 1.5^(self.Bounces - (self:GetHitTime() + 0.3 > CurTime() and 1 or 0)))
		self.Damaged = true
		local ent = self.Touched.Entity
		if (ent and ent:IsValid() and ent:IsPlayer() and self:GetOwner() and self:GetOwner():IsPlayer() and self:GetOwner():Team() ~= ent:Team()) then
			ent:EmitSound("weapons/crossbow/hitbod"..math.random(2)..".wav")
			util.Blood(ent:WorldSpaceCenter(), math.min(10*(self.Bounces+1),30), -self:GetForward(), math.Rand(10, 30), true)
			ent:DispatchProjectileTraceAttack(processed_dmg, self.Touched, self:GetOwner(), self)
		end
		self.DieTime = CurTime()
	end
	self:NextThink(CurTime())
	return true
end

function ENT:Hit(vHitPos, vHitNormal, eHitEntity, vOldVelocity)
	if (self:GetHitTime() ~= 0 and CurTime() - self:GetHitTime() <= 0.01) or self.Finished then return end

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
	end
	
	if self.Bounces < self.MaxBounces then
		self.Bounces = self.Bounces + 1
		self.PhysicsData = nil
	else
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:EnableMotion(false)
		end
		self:SetSolid(SOLID_NONE)
		self:SetMoveType(MOVETYPE_NONE)
		self.DieTime = CurTime()
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
	if self.Finished then return end
	local ent = data.HitEntity
	if ent:GetCollisionGroup() == COLLISION_GROUP_BREAKABLE_GLASS then 
		ent:TakeDamage(self.Damage or 25, self:GetOwner(), self)
		self:SetAngles(data.OurOldVelocity:Angle())
		self:SetVelocity(data.OurOldVelocity)
		return 
	end
	if not self:HitFence(data, phys) then
		self.PhysicsData = data
		self:SetHitTime(CurTime())
		if ent and ent:IsValid() then
			local hitphys = ent:GetPhysicsObject()
			if hitphys:IsValid() and hitphys:IsMoveable() then
				self.ParentEnt = ent
			end
		end
	end
	self:NextThink(CurTime())
end