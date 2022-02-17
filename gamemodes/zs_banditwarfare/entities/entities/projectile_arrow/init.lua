AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')
ENT.Damage = 100
function ENT:Initialize()
	self.Touched = {}
	self.Damaged = {}
	self.HurtOrder = {}
	self.LastHitNum = 1
	self:SetModel(Model("models/crossbow_bolt.mdl"))
	self:SetMoveType(MOVETYPE_FLYGRAVITY);
	self:SetMoveCollide(MOVECOLLIDE_FLY_CUSTOM);
	self:PhysicsInitBox(Vector(-4,-0.02,-0.02), Vector(8,0.02,0.02))
	self:SetTrigger(true)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetMass(3)
		phys:SetBuoyancyRatio(0.002)
		phys:EnableMotion(true)
		phys:Wake()
	end
	self:SetSkin(1)
	self:EmitSound("Weapon_Crossbow.BoltFly");
end

local temp_pen_ents = {}
local temp_me = NULL
local myteammates = {}
local function ArrowFilter(ent)
	if ent == temp_me or temp_pen_ents[ent] or table.HasValue(myteammates,ent) then
		return false
	end

	return true
end

function ENT:PhysicsUpdate(phys)
	local vel = self.PreVel or phys:GetVelocity()
	if self.PreVel then self.PreVel = nil end

	temp_me = self
	temp_pen_ents = {}
	myteammates = self:GetOwner():IsPlayer() and team.GetPlayers(self:GetOwner():Team()) or {}
	for i = 1, 5 do
		if not self.NoColl then
			local velnorm = vel:GetNormalized()
			local ahead = (vel:LengthSqr() * FrameTime()) / 1200
			local fwd = velnorm * ahead
			local start = self:GetPos() - fwd
			local side = vel:Angle():Right() * 5
			
			local proj_trace = {mask = MASK_SHOT, filter = ArrowFilter}

			proj_trace.start = start - side
			proj_trace.endpos = start - side + fwd

			local tr = util.TraceLine(proj_trace)
			
			proj_trace.start = start + side
			proj_trace.endpos = start + side + fwd

			local tr2 = util.TraceLine(proj_trace)
			for _, trace in pairs({tr,tr2}) do
				if trace.Hit and not self.Touched[trace.Entity] then
					local ent = trace.Entity
					if ent ~= self:GetOwner() and (ent:IsPlayer() and ent:Team() ~= self:GetOwner():Team() and ent:Alive()) then
						self.Touched[ent] = trace
						table.insert(self.HurtOrder,self.LastHitNum,ent)
						temp_pen_ents[ent] = true
						self.LastHitNum = self.LastHitNum + 1
						break
					end
				end
			end
		end
	end
end

function ENT:Hit(vHitPos, vHitNormal, eHitEntity, vOldVelocity)
	if self.Done then return end
	local owner = self:GetOwner()
	if not owner:IsValid() then owner = self end
	if eHitEntity:GetClass() == "func_breakable_surf" then 
		eHitEntity:TakeDamage(self.Damage or 25, owner, self)
		self:SetAngles(vOldVelocity:Angle())
		self:SetVelocity(vOldVelocity)
		return 
	end
	self.Done = true
	self:EmitSound("physics/metal/sawblade_stick"..math.random(3)..".wav", 75, 60)
	self:SetSkin(0)
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
    util.Effect("cball_explode", edata)
	if eHitEntity:IsWorld() then
		util.Decal("ExplosiveGunshot", vHitPos-vDirNormal, vHitPos+vDirNormal, self )
		self:EmitSound("Weapon_Crossbow.BoltHitWorld")
		self:SetAngles(vOldVelocity:Angle())
		self:SetPos(vHitPos-vDirNormal*8)
		self:Fire("kill", "", 10)
	elseif eHitEntity:IsValid() then -- Only for props, player damage calculated by Touched
		eHitEntity:TakeDamage(self.Damage or 25, owner, self)
		self:Fire("kill", "", 0)
	end
end

function ENT:Think()
	-- Do this out of the physics collide hook.

	
	if self.PhysicsData then
		self:Hit(self.PhysicsData.HitPos, self.PhysicsData.HitNormal, self.PhysicsData.HitEntity, self.PhysicsData.OurOldVelocity)
	end

	local owner = self:GetOwner()
	if not owner:IsValid() then owner = self end

	for i, ent in ipairs(self.HurtOrder) do
		if self.Touched[ent] and not self.Damaged[ent] then
			local damage = (self.Damage or 100)
			local processed_dmg = math.max(damage-(i-1)*25,1)

			self.Damaged[ent] = true
			ent:EmitSound("weapons/crossbow/hitbod"..math.random(2)..".wav")
			util.Blood(ent:WorldSpaceCenter(), math.max(0, 30 - table.Count(self.Damaged) * 2), -self:GetForward(), math.Rand(100, 300), true)
			ent:DispatchProjectileTraceAttack(processed_dmg, self.Touched[ent], owner, self, self:GetVelocity())
		end
	end
	self:NextThink(CurTime())
	return true
end

function ENT:PhysicsCollide(data, phys)
	if self.Done then return end
	if not self:HitFence(data, phys) then
		self.PhysicsData = data
	end

	self:NextThink(CurTime())
end