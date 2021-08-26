AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.Heal = 5
ENT.ToxicDamage = 2
ENT.ToxicTick = 0.3
ENT.ToxDuration = 1.5

function ENT:Initialize()
	self:SetModel("models/Items/CrossbowRounds.mdl")
	self:SetModelScale(0.5, 0)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetMass(3)
		phys:SetBuoyancyRatio(0.002)
		phys:EnableMotion(true)
		phys:Wake()
	end

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
	if self:GetHitTime() ~= 0 then return end
	self:SetHitTime(CurTime())

	self:Fire("kill", "", 10)

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

		if eHitEntity:IsPlayer() and (eHitEntity:Team() == TEAM_HUMANS or eHitEntity:Team() == TEAM_BANDIT) then
			if eHitEntity:Team() == team then
				eHitEntity:GiveStatus("healdartboost").DieTime = CurTime() + 10
				local tox = eHitEntity:GetStatus("tox")
				if (tox and tox:IsValid()) then
					tox:SetTime(0)
				end
				local bleed = eHitEntity:GetStatus("bleed")
				if (bleed and bleed:IsValid()) then
					bleed:SetDamage(1)
				end
				for _, hook in pairs(ents.FindInSphere(self:GetPos(), 60 )) do
					if hook:GetClass() == "prop_meathook" and hook:GetParent() == eHitEntity then
						hook.TicksLeft = 0
					end
				end
				local oldhealth = eHitEntity:Health()
				local newhealth = math.min(oldhealth + self.Heal, eHitEntity:GetMaxHealth())
				if oldhealth ~= newhealth then
					eHitEntity:SetHealth(newhealth)

					if owner:IsPlayer() then
						gamemode.Call("PlayerHealedTeamMember", owner, eHitEntity, newhealth - oldhealth, self)
					end
				end
			else	
				local tox = eHitEntity:GetStatus("tox")
				if (tox and tox:IsValid()) then
					tox:AddTime(self.ToxDuration)
					tox.Owner = eHitEntity
					tox.Damage = self.ToxicDamage
					tox.Damager = owner
					tox.TimeInterval = self.ToxicTick
				else
					stat = eHitEntity:GiveStatus("tox")
					stat:SetTime(self.ToxDuration)
					stat.Owner = eHitEntity
					stat.Damage = self.ToxicDamage
					stat.Damager = owner
					stat.TimeInterval = self.ToxicTick
				end
			end
		end
	end

	self:SetAngles(vOldVelocity:Angle())

	local effectdata = EffectData()
		effectdata:SetOrigin(vHitPos)
		effectdata:SetNormal(vHitNormal)
		if eHitEntity:IsValid() then
			effectdata:SetEntity(eHitEntity)
		else
			effectdata:SetEntity(NULL)
		end
	util.Effect("hit_healdart", effectdata)
end

function ENT:PhysicsCollide(data, phys)
	if not self:HitFence(data, phys) then
		self.PhysicsData = data
	end

	self:NextThink(CurTime())
end
