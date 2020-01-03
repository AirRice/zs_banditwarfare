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
		phys:SetMass(4)
		phys:SetMaterial("metal")
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
	local owner = self.Owner
	self:EmitSound("weapons/flashbang/flashbang_explode"..math.random(1,2)..".wav")
	if owner:IsValid() and owner:IsPlayer() and (owner:Team() == TEAM_HUMAN or owner:Team() == TEAM_BANDIT) then	
		for _, pl in pairs(player.GetAll()) do
		if pl:Alive() or pl==owner then
			local pos = self:GetPos()
			local dist = pl:NearestPoint(pos):Distance(pos)
			if dist <= 256 then
				local tr = util.TraceLine {
					start = pos,
					endpos = pl:EyePos(),
					mask = bit.bor( CONTENTS_SOLID , CONTENTS_MOVEABLE , CONTENTS_DEBRIS , CONTENTS_MONSTER ),
					filter = owner					
				}
				if (!tr.HitWorld)  or (tr.Fraction == 1 or tr.Entity == pEntity) then
					pl:PlayEyePoisonedSound()
					if pl:Team() ~= owner:Team() and math.random(4) == 1 then
						--pl:KnockDown(2)
					end
					pl:SetDSP( 36 , false )
					pl:ScreenFade( SCREENFADE.IN , COLOR_WHITE, 1 , 3 )
				end
			end
		end
		end
		local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos())
		util.Effect("RPGShotDown", effectdata)
	end
	self.Exploded = true
end
