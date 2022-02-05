AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "status__base"

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.DamageScale = 1.3
ENT.LifeTime = 5

ENT.Model = Model("models/gibs/HGIBS.mdl")

function ENT:Initialize()
	self.BaseClass.Initialize(self)

	self:SetModel(self.Model)
	self:DrawShadow(false)

	if SERVER then
		hook.Add("EntityTakeDamage", self, self.EntityTakeDamage)
		hook.Add("PlayerHurt", self, self.PlayerHurt)
	end

	if CLIENT then
		hook.Add("PrePlayerDraw", self, self.PrePlayerDraw)
		hook.Add("PostPlayerDraw", self, self.PostPlayerDraw)
		hook.Add("RenderScreenspaceEffects", self, self.RenderScreenspaceEffects)
	end
	self:EmitSound("beams/beamstart5.wav", 65, 140)
	self.DieTime = CurTime() + self.LifeTime
end

if SERVER then
	function ENT:EntityTakeDamage(ent, dmginfo)
		if ent ~= self:GetOwner() then return end

		local attacker = dmginfo:GetAttacker()
		if attacker:IsValid() and attacker:IsPlayer() and ent:IsValid() and ent:IsPlayer() and attacker:Team() ~= ent:Team() then
			dmginfo:SetDamage(dmginfo:GetDamage() * self.DamageScale)
		end
	end

	function ENT:PlayerHurt(pl, attacker, healthleft, damage)
		if attacker:IsValid() and attacker:IsPlayer() and attacker ~= pl and attacker:Team() ~= pl:Team() then
			local attributeddamage = damage
			if healthleft < 0 then
				attributeddamage = attributeddamage + healthleft
			end

			if attributeddamage > 0 then
				local myteam = pl:Team()

				attributeddamage = attributeddamage * (self.DamageScale - 1)

				attacker.DamageDealt = attacker.DamageDealt + attributeddamage
				attacker:AddLifeEnemyDamage(attributeddamage)
			end
		end
	end
end

if not CLIENT then return end

function ENT:DrawTranslucent()
	local owner = self:GetOwner()
	if not owner:IsValid() then return end

	render.SetColorModulation(1, 0, 0)
	render.SetBlend(0.95)
	render.SuppressEngineLighting(true)

	self:SetRenderOrigin(owner:GetPos() + Vector(0, 0, owner:OBBMaxs().z + math.abs(math.sin(CurTime() * 2)) * 4))
	self:SetRenderAngles(Angle(0, CurTime() * 270, 0))
	self:DrawModel()

	render.SuppressEngineLighting(false)
	render.SetBlend(1)
	render.SetColorModulation(1, 1, 1)
end

function ENT:PrePlayerDraw(pl)
	if pl ~= self:GetOwner() then return end

	local r = 1 - math.abs(math.sin((CurTime() + self:EntIndex()) * 3)) * 0.2
	render.SetColorModulation(r, 0.1, 0.1)
end

function ENT:PostPlayerDraw(pl)
	if pl ~= self:GetOwner() then return end

	render.SetColorModulation(1, 1, 1)
end

function ENT:GetPower()
	return math.Clamp((self.DieTime - CurTime())/self.LifeTime, 0, 1)
end

local colModRedVision = {
	["$pp_colour_colour"] = 1.5,
	["$pp_colour_brightness"] = -0.1,
	["$pp_colour_contrast"] = 1,
	["$pp_colour_mulr"]	= 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0,
	["$pp_colour_addr"] = 0.1,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0
}

function ENT:RenderScreenspaceEffects()
	if LocalPlayer() ~= self:GetOwner() then return end
	DrawSharpen( 0.6+self:GetPower()*0.6, 1.2 )
	DrawMotionBlur(0.1, self:GetPower() * 0.35, 0.01)
	colModRedVision["$pp_colour_addr"] = self:GetPower()*0.1
	DrawColorModify(colModRedVision)
end
