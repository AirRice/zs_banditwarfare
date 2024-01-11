AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "status__base"

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.DamageReduction = 1
ENT.LifeTime = 5

function ENT:Initialize()
	self.BaseClass.Initialize(self)

	self:SetModel(self.Model)
	self:DrawShadow(false)

	if SERVER then
		hook.Add("EntityTakeDamage", self, self.EntityTakeDamage)
	end

	if CLIENT then
		hook.Add("PrePlayerDraw", self, self.PrePlayerDraw)
		hook.Add("PostPlayerDraw", self, self.PostPlayerDraw)
	end
	--self:EmitSound("beams/beamstart5.wav", 65, 140)
	self.DieTime = CurTime() + self.LifeTime
end

if SERVER then
	function ENT:EntityTakeDamage(ent, dmginfo)
		if ent ~= self:GetOwner() then return end

		local attacker = dmginfo:GetAttacker()
		local inflictor = (dmginfo:GetInflictor():IsWeapon() and dmginfo:GetInflictor())
		if attacker:IsValid() and attacker:IsPlayer() and ent:IsValid() and ent:IsPlayer() and attacker:Team() ~= ent:Team() and dmginfo:IsDamageType(DMG_BULLET) and not (inflictor and inflictor.IgnoreDamageScaling) then
			dmginfo:SetDamage(math.max(dmginfo:GetDamage() - self.DamageReduction,1))
		end
		local center = ent:LocalToWorld(ent:OBBCenter())
		local hitpos = ent:NearestPoint(dmginfo:GetDamagePosition())
		local effectdata = EffectData()
			effectdata:SetOrigin(center)
			effectdata:SetStart(ent:WorldToLocal(hitpos))
			effectdata:SetAngles((center - hitpos):Angle())
			effectdata:SetEntity(ent)
		util.Effect("shadedeflect", effectdata, true, true)
	end
end

if not CLIENT then return end

function ENT:PrePlayerDraw(pl)
	if pl ~= self:GetOwner() then return end

	local g = 1 - math.abs(math.sin((CurTime() + self:EntIndex()) * 3)) * 0.5
	render.SetColorModulation(0.4, g, g)
end

function ENT:PostPlayerDraw(pl)
	if pl ~= self:GetOwner() then return end

	render.SetColorModulation(1, 1, 1)
end