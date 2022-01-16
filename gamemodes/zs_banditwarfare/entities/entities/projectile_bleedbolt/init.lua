AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
ENT.Damage = 10
function ENT:Initialize()
	self:SetModel(Model("models/props_phx/amraam.mdl"))
	self:SetMaterial("models/props_c17/chairchrome01")
	self:SetModelScale(0.08, 0)
	self:SetMoveType(MOVETYPE_FLY);
	self:SetMoveCollide(MOVECOLLIDE_FLY_CUSTOM);
	self:PhysicsInitBox(Vector(-2,-0.02,-0.02), Vector(4,0.02,0.02))
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetMass(3)
		phys:SetBuoyancyRatio(0.002)
		phys:EnableMotion(true)
		phys:Wake()
		--phys:EnableGravity(false)
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
	if self:GetHitTime() ~= 0 then return end
	self:SetHitTime(CurTime())
	self:SetSkin(0)
	self:Fire("kill", "", 10)

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
	if eHitEntity:IsWorld() then
		util.Decal("ExplosiveGunshot", vHitPos-vDirNormal, vHitPos+vDirNormal, self )
	elseif eHitEntity:IsValid() then
		if eHitEntity:IsPlayer() and owner:IsPlayer() and eHitEntity:Team() ~= self:GetOwner():Team() then
			eHitEntity:TakeDamage((self.Damage or 25)*0.25, owner, self)
			eHitEntity:EmitSound("Weapon_Crossbow.BoltHitBody")
			util.Blood(vHitPos, 30, vHitNormal, math.Rand(10,30), true)
			local bleed = eHitEntity:GetStatus("bleed")
			if bleed and bleed:IsValid() then
				bleed:AddDamage((self.Damage or 25)*0.75)
				bleed.Damager = self:GetOwner()
			else
				local stat = eHitEntity:GiveStatus("bleed")
				if stat and stat:IsValid() then
					stat:SetDamage((self.Damage or 25)*0.75)
					stat.Damager = self:GetOwner()
				end
			end
		else
			eHitEntity:TakeDamage(self.Damage or 25, owner, self)
		end
		self:Fire("kill", "", 0)
	end
	self:EmitSound("npc/roller/blade_cut.wav")
	self:SetAngles(vOldVelocity:Angle())
	self:SetPos(vHitPos-vDirNormal*1.5)
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
