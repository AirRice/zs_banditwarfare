AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.Damage = 10

function ENT:Initialize()
	self:SetupProjectile(nil, nil, nil, nil, true)
	self.DieTime = CurTime() + self.LifeTime
end

local temp_me = NULL
local myteammates = {}
local function ArrowFilter(ent)
	if ent == temp_me or table.HasValue(myteammates,ent) or (ent.ShouldNotCollide and ent:ShouldNotCollide(temp_me)) then
		return false
	end

	return true
end

function ENT:SetupProjectile(gravity, model, movetype, movecoll, mass, angledrag)
	self:SetModel(model or Model("models/crossbow_bolt.mdl"))
	self:SetMoveType(movetype or MOVETYPE_FLYGRAVITY);
	self:SetMoveCollide(movecoll or MOVECOLLIDE_FLY_CUSTOM);
	self:PhysicsInitBox(self.m_bboxMins, self.m_bboxMaxs)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetMass(mass or 3)
		phys:SetBuoyancyRatio(0.002)
		phys:EnableMotion(true)
		phys:SetAngleDragCoefficient(angledrag or 1.5)
		if not gravity then
			phys:EnableGravity(false)
		end
		phys:Wake()
	end
end

function ENT:Think()
	if self:GetHitTime() ~= 0 and not self.NoColl and self.PhysicsData then
		self.NoColl = true
		self:Hit(self.PhysicsData.HitPos, self.PhysicsData.HitNormal, self.PhysicsData.HitEntity, self.PhysicsData.OurOldVelocity)
	elseif self.NoColl then
		self:SetSolid(SOLID_NONE)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	end

	local parent = self:GetParent()
	if self.DieTime <= CurTime() or (parent:IsValid() and parent:IsPlayer() and not parent:Alive()) then
		self:Remove()
	end
	self:NextThink(CurTime())
	return true
end

function ENT:Hit(vHitPos, vHitNormal, eHitEntity, vOldVelocity)
	self.DieTime = CurTime() + 10

	local owner = self:GetOwner()
	if not owner:IsValid() then owner = self end
	vHitPos = vHitPos or self:GetPos()
	vHitNormal = (vHitNormal or Vector(0, 0, -1)) * -1
	vDirNormal = vOldVelocity:GetNormalized()
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end
	self:SetAngles(vOldVelocity:Angle())
	self:SetPos(vHitPos-vDirNormal*self.FinishOffset)
	
	local edata = EffectData()
		edata:SetOrigin(vHitPos)
		edata:SetNormal(vHitNormal)
		edata:SetScale(1)
		edata:SetMagnitude(2)
    util.Effect("ElectricSpark", edata)	
	self:EmitSound("Weapon_Crossbow.BoltHitWorld")	
	
	if self.ParentEnt then
		self:SetParent(self.ParentEnt)
		return
	end

	if eHitEntity:IsWorld() then
		util.Decal("ExplosiveGunshot", vHitPos-vDirNormal, vHitPos+vDirNormal, self )
	elseif eHitEntity:IsValid() then
		local damage = (self.Damage or 10)
		if not (eHitEntity:IsPlayer() and self:DoPlayerHit(eHitEntity, damage, vHitPos, vHitNormal, vOldVelocity)) then
			eHitEntity:TakeDamage(damage, owner, self)
		end
		self.DieTime = CurTime()
	end
end
	
function ENT:DoPlayerHit(ent, dmg, pos, normal, vel)
	local owner = self:GetOwner()
	if not (ent and ent:IsValid() and ent:IsPlayer() and owner and owner:IsPlayer() and ent:Team() ~= owner:Team()) then return end
	ent:EmitSound("weapons/crossbow/hitbod"..math.random(2)..".wav")
	util.Blood(pos, math.Clamp(math.floor(dmg*0.3),0,30), normal, math.Rand(10,30), true)
	temp_me = self
	myteammates = self:GetOwner():IsPlayer() and team.GetPlayers(self:GetOwner():Team()) or {}

	local velnorm = vel:GetNormalized()

	local ahead = (vel:LengthSqr() * FrameTime()) / 1200
	local fwd = velnorm * ahead
	local start = self:GetPos() - fwd*0.5
	local side = vel:Angle():Right() * 3

	local proj_trace = {mask = MASK_SHOT, filter = ArrowFilter}

	proj_trace.start = start - side
	proj_trace.endpos = start - side + fwd
	local tr = util.TraceLine(proj_trace)
	
	proj_trace.start = start + side
	proj_trace.endpos = start + side + fwd
	local tr2 = util.TraceLine(proj_trace)
	local trs = {tr,tr2}
	for _, trace in pairs(trs) do
		if trace.Hit and trace.Entity == ent then
			ent:DispatchProjectileTraceAttack(dmg, trace, owner, self, vel)
			return true
		end
	end
end

function ENT:PhysicsCollide(data, phys)
	if self:GetHitTime() ~= 0 then return end
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
			if hitphys:IsValid() and hitphys:IsMoveable() and not ent:IsPlayer() then
				self.ParentEnt = ent
			end
		end
	end
	self:NextThink(CurTime())
end