AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.NextWaterDamage = 0

function ENT:Initialize()
	self:SetModel("models/combine_scanner.mdl")
	self:SetUseType(SIMPLE_USE)


	self:PhysicsInit(SOLID_VPHYSICS)
	
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetMaterial("metal")
		phys:SetMass(75)
		phys:EnableDrag(false)
		phys:EnableMotion(true)
		phys:Wake()
		phys:SetBuoyancyRatio(0.8)
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
		
		local Constraint = ents.Create("phys_keepupright")
		Constraint:SetAngles(Angle(0, 0, 0))
		Constraint:SetKeyValue("angularlimit", 2)
		Constraint:SetPhysConstraintObjects(phys, phys)
		Constraint:Spawn()
		Constraint:Activate()
		self:DeleteOnRemove(Constraint)
	end

	self:StartMotionController()

	self:SetMaxObjectHealth(75)
	self:SetObjectHealth(self:GetMaxObjectHealth())

	self.LastThink = CurTime()

	self:SetSequence(2)
	self:SetPlaybackRate(1)
	self:UseClientSideAnimation(true)

	self:CollisionRulesChanged()

	hook.Add("SetupPlayerVisibility", self, self.SetupPlayerVisibility)
end


function ENT:SetObjectHealth(health)
	self:SetDTFloat(0, health)

	if health <= 0 then
		self:Destroy()
	end
end

function ENT:OnTakeDamage(dmginfo)
	if dmginfo:GetDamage() <= 0 then return end

	local attacker = dmginfo:GetAttacker()
	if (attacker:IsValid() and attacker:IsPlayer() and self:GetOwner():IsPlayer() and attacker:Team() == self:GetOwner():Team()) then return end

	self:TakePhysicsDamage(dmginfo)

	self:SetObjectHealth(self:GetObjectHealth() - dmginfo:GetDamage())

	self:EmitSound("npc/scanner/scanner_pain"..math.random(2)..".wav", 65, math.Rand(120, 130))
	self:EmitSound("npc/manhack/gib.wav")

	local effectdata = EffectData()
		effectdata:SetOrigin(self:NearestPoint(dmginfo:GetDamagePosition()))
		effectdata:SetNormal(VectorRand():GetNormalized())
		effectdata:SetMagnitude(4)
		effectdata:SetScale(1.33)
	util.Effect("sparks", effectdata)
end

function ENT:Use(pl)
	if pl == self:GetOwner() and pl:Alive() and self:GetVelocity():Length() <= self.HoverSpeed and pl:Team() == self:GetOwner():Team() then
		self:OnPackedUp(pl)
	end
end


function ENT:PhysicsCollide(data, phys)
	self.HitData = data
	self:NextThink(CurTime())
end

function ENT:OnPackedUp(pl)
	pl:GiveEmptyWeapon(self.WeaponClass)
	pl:GiveAmmo(1, "drone")

	pl:PushPackedItem(self:GetClass(), self:GetObjectHealth())
	pl:StripWeapon(self.ControllerClass)
	self:Remove()
end


function ENT:PhysicsSimulate(phys, frametime)
	phys:Wake()

	local owner = self:GetOwner()
	if not owner:IsValid() then return SIM_NOTHING end

	local vel = phys:GetVelocity()
	local movedir = Vector(0, 0, 0)
	local eyeangles = owner:SyncAngles()
	local aimangles = owner:EyeAngles()

	if self:BeingControlled() and GAMEMODE:GetWaveActive() then
		if owner:KeyDown(IN_FORWARD) then
			movedir = movedir + aimangles:Forward()
		end
		if owner:KeyDown(IN_BACK) then
			movedir = movedir - aimangles:Forward()
		end
		if owner:KeyDown(IN_MOVERIGHT) then
			movedir = movedir + aimangles:Right()
		end
		if owner:KeyDown(IN_MOVELEFT) then
			movedir = movedir - aimangles:Right()
		end
		if owner:KeyDown(IN_BULLRUSH) then
			movedir = movedir + Vector(0, 0, 0.5)
		end
		if owner:KeyDown(IN_GRENADE1) then
			movedir = movedir - Vector(0, 0, 0.5)
		end
		local angdiff = math.AngleDifference(eyeangles.yaw, phys:GetAngles().yaw)
		if math.abs(angdiff) > 4 then
			phys:AddAngleVelocity(Vector(0, 0, math.Clamp(angdiff, -64, 64) * frametime * 100 - phys:GetAngleVelocity().z * 0.95))
		end
	end

	if movedir == vector_origin then
		vel = vel * (1 - frametime * self.IdleDrag)
	else
		movedir:Normalize()

		vel = vel + frametime * self.Acceleration * math.Clamp((self:GetObjectHealth() / self:GetMaxObjectHealth() + 1) / 2, 0.5, 1) * movedir
	end

	if vel:Length() > self.MaxSpeed then
		vel:Normalize()
		vel = vel * self.MaxSpeed
	end

	if movedir == vector_origin and vel:Length() <= self.HoverSpeed then
		local trace = {mask = MASK_HOVER, filter = self}
		trace.start = self:GetPos()
		trace.endpos = trace.start + Vector(0, 0, self.HoverHeight * -2)
		local tr = util.TraceLine(trace)

		local hoverdir = (trace.start - tr.HitPos):GetNormalized()
		local hoverfrac = (0.5 - tr.Fraction) * 2
		vel = vel + frametime * hoverfrac * self.HoverForce * hoverdir
	end

	phys:EnableGravity(false)
	phys:SetAngleDragCoefficient(20000)
	phys:SetVelocityInstantaneous(vel)

	return SIM_NOTHING
end


function ENT:Destroy(noexplosion)
	if self.Destroyed then return end
	self.Destroyed = true
	noexplosion = noexplosion or false
	local pos = self:LocalToWorld(self:OBBCenter())

	self:EmitSound("npc/scanner/scanner_explode_crash2.wav")

	local effectdata = EffectData()
		effectdata:SetOrigin(pos)
		effectdata:SetNormal(Vector(0, 0, 1))
		effectdata:SetMagnitude(5)
		effectdata:SetScale(1.5)
	util.Effect("sparks", effectdata)

	local owner = self:GetOwner()
	if owner:IsPlayer() and not noexplosion then
		effectdata = EffectData()
			effectdata:SetOrigin(pos)
			effectdata:SetNormal(Vector(0, 0, -1))
		util.Effect("HelicopterMegaBomb", effectdata, true, true)
		self:EmitSound("npc/env_headcrabcanister/explosion.wav", 100, 100)
		util.BlastDamage2(self, owner, pos, 128, 32)
	end
end

local function RefreshDroneOwners(pl)
	for _, ent in pairs(ents.FindByClass("prop_drone")) do
		if ent:IsValid() and ent:GetOwner() == pl then
			ent:Destroy(true)
		end
	end
end

hook.Add("PlayerDisconnected", "Drone.PlayerDisconnected", RefreshDroneOwners)
hook.Add("PlayerChangedTeam", "Drone.PlayerChangedTeam", RefreshDroneOwners)

ENT.PhysDamageImmunity = 0
function ENT:Think()
	if self.Destroyed then
		if not self.CreatedDebris then
			self.CreatedDebris = true

			local ent = ents.Create("prop_physics")
			if ent:IsValid() then
				ent:SetPos(self:GetPos())
				ent:SetAngles(self:GetAngles())
				ent:SetModel(self:GetModel())
				ent:Spawn()
				local phys = ent:GetPhysicsObject()
				if phys:IsValid() then
					phys:SetVelocityInstantaneous(self:GetVelocity())
				end

				ent:Fire("break")
				ent:Fire("kill", "", 0.05)
			end
		end

		self:Remove()
		return
	end

	local owner = self:GetOwner()
	if owner:IsValid() then
		self:SetPhysicsAttacker(owner)

		if not owner:Alive() then
			self:Destroy()
			return
		end
	else
		self:Destroy()
		return
	end

	if self:WaterLevel() >= 2 and CurTime() >= self.NextWaterDamage then
		self.NextWaterDamage = CurTime() + 0.2

		self:TakeDamage(10)
	end

	local data = self.HitData
	if not data then return end
	self.HitData = nil

	if data.Speed > self.HoverSpeed then
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			local dir = self:GetPos() - data.HitPos
			dir:Normalize()
			phys:AddVelocity(dir * 20)
		end
	end

	if data.Speed >= self.MaxSpeed * 0.75 and ent and ent:IsWorld() and CurTime() >= self.PhysDamageImmunity then
		self:TakeDamage(math.Clamp(data.Speed * 0.1, 0, 40))
		self.PhysDamageImmunity = CurTime() + 0.5
	end
end

function ENT:SetupPlayerVisibility(pl)
	if pl ~= self:GetOwner() then return end

	AddOriginToPVS(self:GetPos())
end
