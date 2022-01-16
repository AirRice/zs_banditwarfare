AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self.DieTime = CurTime() + self.LifeTime

	self:SetModel("models/weapons/w_eq_flashbang.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:PhysicsCollide(data, phys)
	if 20 < data.Speed and 0.25 < data.DeltaTime then
		self:EmitSound("physics/metal/metal_grenade_impact_hard"..math.random(1,3)..".wav")
	end
end

function ENT:Think()
	if self.Exploded then
		self:Remove()
	elseif self.DieTime <= CurTime() then
		self:Explode()
	end
end
function ENT:Explode()
	if self.Exploded then return end
	local owner = self:GetOwner()
	if owner:IsValid() and owner:IsPlayer() and (owner:Team() == TEAM_HUMAN or owner:Team() == TEAM_BANDIT) then	
		for _, pl in pairs(player.GetAll()) do
			if pl:Alive() then
				local pos = self:GetPos()
				local eyepos = pl:EyePos()
				local dist = eyepos:Distance(pos)
				if WorldVisible(eyepos, pos) then
					local power = math.Clamp(1 - dist / 1000,0,1)
					local dir = pos - eyepos
					dir:Normalize()
					power = power * (1 + (pl:EyeAngles():Forward():Dot(dir)) / 2)
					if not TrueVisible(eyepos, pos) then
						power = power * 0.66
					end
					if power > 0.5 then
						pl:PlayEyePoisonedSound()
						if math.random(4) == 1 then
							pl:KnockDown(power * 2)
						end
						pl:SetDSP(36)
					end
					pl:ScreenFade( SCREENFADE.IN , COLOR_WHITE, 1, power * 2)
				end
			end
		end
		local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos())
		util.Effect("explosion_flashbang", effectdata)
	end
	self.Exploded = true
end
