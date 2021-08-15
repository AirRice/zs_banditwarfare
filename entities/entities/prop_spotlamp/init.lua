AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local function RefreshCrateOwners(pl)
	for _, ent in pairs(ents.FindByClass("prop_spotlamp")) do
		if ent:IsValid() and ent:GetObjectOwner() == pl then
			ent:SetObjectOwner(NULL)
		end
	end
end
hook.Add("PlayerDisconnected", "SpotLamp.PlayerDisconnected", RefreshCrateOwners)
hook.Add("OnPlayerChangedTeam", "SpotLamp.OnPlayerChangedTeam", RefreshCrateOwners)

function ENT:Initialize()
	self:SetModel("models/props_combine/combine_light001a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end

	self:SetMaxObjectHealth(100)
	self:SetObjectHealth(self:GetMaxObjectHealth())
	local ent = ents.Create("env_projectedtexture")
	if ent:IsValid() then
		ent:SetPos(self:GetSpotLightPos())
		ent:SetAngles(self:GetSpotLightAngles())
		ent:SetKeyValue("enableshadows", 0)
		ent:SetKeyValue("farz", 1500)
		ent:SetKeyValue("nearz", 8)
		ent:SetKeyValue("lightfov", 120)
		ent:SetKeyValue("brightness", 10)
		local owner = self:GetObjectOwner()
		if owner:IsValid() and owner:IsPlayer() then
			local vcol = team.GetColor(owner:Team())
			if vcol then
				ent:SetKeyValue("lightcolor", vcol.r.." "..vcol.g.." "..vcol.b.." 255")
			else
				ent:SetKeyValue("lightcolor", "200 220 255 255")
			end
		else
			ent:SetKeyValue("lightcolor", "200 220 255 255")
		end
		ent:SetParent(self)
		ent:Spawn()
		ent:Input("SpotlightTexture", NULL, NULL, "effects/flashlight001")
	end
end

function ENT:SetObjectHealth(health)
	self:SetDTFloat(0, health)

	if health <= 0 and not self.Destroyed then
		self.Destroyed = true

		local effectdata = EffectData()
			effectdata:SetOrigin(self:LocalToWorld(self:OBBCenter()))
		util.Effect("Explosion", effectdata, true, true)
	end
end

function ENT:OnTakeDamage(dmginfo)
	self:TakePhysicsDamage(dmginfo)

	local attacker = dmginfo:GetAttacker()
	if not (attacker:IsValid() and attacker:IsPlayer() and self:GetObjectOwner():IsPlayer() and attacker:Team() == self:GetObjectOwner():Team()) then
		self:SetObjectHealth(self:GetObjectHealth() - dmginfo:GetDamage())
		self:ResetLastBarricadeAttacker(attacker, dmginfo)
	end
end

function ENT:AltUse(activator, tr)
	self:PackUp(activator)
end

function ENT:OnPackedUp(pl)
	pl:GiveEmptyWeapon("weapon_zs_spotlamp")
	pl:GiveAmmo(1, "spotlamp")

	pl:PushPackedItem(self:GetClass(), self:GetObjectHealth())

	self:Remove()
end


function ENT:Attack(proj)
	if (!proj.Twister or proj.Twister == nil or !IsValid(proj.Twister)) and proj:IsValid() then
		self:EmitSound("weapons/stunstick/alyx_stunner"..math.random(2)..".wav",75,130,1)
		self:EmitSound("weapons/flaregun/fire.wav",75,150,0.75,CHAN_AUTO+20)
		proj.Twister = self
		local projcenter = proj:GetPos()
		local LightNrm = self:GetSpotLightAngles():Forward()
		local fireorigin = self:GetSpotLightPos() + LightNrm*5
		local firevec = ( projcenter - fireorigin ):GetNormalized()
		local ed = EffectData()
			ed:SetOrigin(proj:GetPos())
			ed:SetNormal(firevec*-1)
			ed:SetRadius(2)
			ed:SetMagnitude(3)
			ed:SetScale(1)
		util.Effect("MetalSpark", ed)
			ed:SetEntity(self)
			ed:SetMagnitude(11)
			ed:SetScale(5)
		util.Effect("TeslaHitBoxes", ed)
		self:FireBullets({Num = 1, Src = fireorigin, Dir = firevec, Spread = Vector(0, 0, 0), Tracer = 1, TracerName = "ToolTracer", Force = 0.1, Damage = 1, Callback = nil})
		proj:Remove()
		self:TakeDamage(5, self,self)
	end
end

function ENT:Think()
	local curTime = CurTime()
	if self.Destroyed then
		self:Remove()
	end
	if (self.LastAttack + self.AttackDelay <= curTime ) then
		local center = self:GetSpotLightPos()
		for _, ent in ipairs(ents.FindInSphere(center, 1000)) do
			if (ent ~= self and ent:IsProjectile() and ent:GetMoveType() ~= MOVETYPE_NONE ) then
				local dot = (ent:GetPos() - center):GetNormalized():Dot(self:GetSpotLightAngles():Forward())
				if dot >= 0.5 and (LightVisible(center, ent:GetPos(), self, ent)) then
					self:Attack(ent)
					self.LastAttack = curTime
				end
			end
		end
	end
end
