AddCSLuaFile()

ENT.Base = "projectile__base"

ENT.LifeTime = 20
ENT.Damage = 25
ENT.FinishOffset = 1.5
ENT.m_bboxMins = Vector(-2, -0.02, -0.02)
ENT.m_bboxMaxs = Vector(4, 0.02, 0.02)

local flechettemdl = Model("models/props_phx/amraam.mdl")
function ENT:Initialize()
	if SERVER then
		self:SetupProjectile(true, flechettemdl, MOVETYPE_FLY, nil)
		self:SetMaterial("models/props_c17/chairchrome01")
        self:SetModelScale(0.08, 0)
		self:EmitSound("Weapon_Crossbow.BoltFly");
		self.DieTime = CurTime() + self.LifeTime
	end
end

function ENT:DoPlayerHit(ent, dmg, pos, normal, vel)
	local owner = self:GetOwner()
	if not (ent and ent:IsValid() and ent:IsPlayer() and owner and owner:IsPlayer() and ent:Team() ~= owner:Team()) then return end
	ent:EmitSound("Weapon_Crossbow.BoltHitBody")
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
            ent:DispatchProjectileTraceAttack(dmg*0.25, trace, owner, self, vel)    
            local bleed = ent:GetStatus("bleed")
            if bleed and bleed:IsValid() then
                bleed:AddDamage((self.Damage or 25)*0.75)
                bleed.Damager = owner
            else
                local stat = ent:GiveStatus("bleed")
                if stat and stat:IsValid() then
                    stat:SetDamage((dmg or 25)*0.75)
                    stat.Damager = owner
                end
            end
			return true
		end
	end
end