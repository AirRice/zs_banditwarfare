ENT.Type = "anim"
ENT.RenderGroup = RENDERGROUP_BOTH

ENT.SearchDistance = 768
ENT.MinimumAimDot = 0.5
ENT.DefaultAmmo = 250
ENT.MaxAmmo = 1000

ENT.PosePitch = 0
ENT.PoseYaw = 0

ENT.m_NoNailUnfreeze = true
ENT.NoNails = true

ENT.CanPackUp = true

ENT.IsBarricadeObject = true
ENT.AlwaysGhostable = true

local NextCache = 0
local CachedFilter = {}

function ENT:ShouldNotCollide(ent)
	return ent:IsPlayer() and self:GetObjectOwner():IsPlayer() and ent:Team() == self:GetObjectOwner():Team()
end

function ENT:GetLocalAnglesToTarget(target)
	return self:WorldToLocalAngles(self:GetAnglesToTarget(target))
end

function ENT:GetAnglesToTarget(target)
	return self:GetAnglesToPos(self:GetTargetPos(target))
end

function ENT:GetLocalAnglesToPos(pos)
	return self:WorldToLocalAngles(self:GetAnglesToPos(pos))
end

function ENT:GetAnglesToPos(pos)
	return (pos - self:ShootPos()):Angle()
end

function ENT:IsValidTarget(target)
	if target:IsPlayer() then
		return self:GetObjectOwner():IsPlayer() and target:Team() ~= self:GetObjectOwner():Team() and target:Alive() and self:GetForward():Dot(self:GetAnglesToTarget(target):Forward()) >= self.MinimumAimDot and TrueVisible(self:ShootPos(), self:GetTargetPos(target), self)
	elseif (target:GetClass() == "prop_drone" or target:GetClass() == "prop_manhack") and not target:IsSameTeam(self:GetObjectOwner()) then
		return true
	elseif (target:IsNailed() or target.IsBarricadeObject) and not target:IsSameTeam(self:GetObjectOwner()) and not target:GetClass() == "prop_obj_sigil" then
		return true
	end
end

function ENT:GetManualTrace()
	local owner = self:GetObjectOwner()
	local filter = owner:GetMeleeFilter()
	table.insert(filter, self)
	return owner:TraceLine(4096, MASK_SOLID, filter)
end

function ENT:CalculatePoseAngles()
	local owner = self:GetObjectOwner()
	if not owner:IsValid() or self:GetAmmo() <= 0 or self:GetMaterial() ~= "" or not GAMEMODE:GetWaveActive() then
		self.PoseYaw = math.Approach(self.PoseYaw, 0, FrameTime() * 60)
		self.PosePitch = math.Approach(self.PosePitch, 15, FrameTime() * 30)
		return
	end

	if self:GetManualControl() then
		local ang = self:GetLocalAnglesToPos(self:GetManualTrace().HitPos)
		self.PoseYaw = math.Approach(self.PoseYaw, math.Clamp(math.NormalizeAngle(ang.yaw), -60, 60), FrameTime() * 140)
		self.PosePitch = math.Approach(self.PosePitch, math.Clamp(math.NormalizeAngle(ang.pitch), -15, 15), FrameTime() * 140)
	else
		local target = self:GetTarget()
		if target:IsValid() then
			local ang = self:GetLocalAnglesToTarget(target)
			self.PoseYaw = math.Approach(self.PoseYaw, math.Clamp(math.NormalizeAngle(ang.yaw), -60, 60), FrameTime() * 140)
			self.PosePitch = math.Approach(self.PosePitch, math.Clamp(math.NormalizeAngle(ang.pitch), -15, 15), FrameTime() * 100)
		else
			local ct = CurTime()
			self.PoseYaw = math.Approach(self.PoseYaw, math.sin(ct*1.8) * 75, FrameTime() * 60)
			self.PosePitch = math.Approach(self.PosePitch, math.cos(ct * 3) * 5+5, FrameTime() * 30)
		end
	end
end

function ENT:GetScanFilter()
	local scanteam = nil
	if self:GetObjectOwner():IsPlayer() then scanteam = self:GetObjectOwner():Team() end
	local filter = team.GetPlayers(scanteam)
	filter[#filter + 1] = self
	return filter
end

local NextCache = 0
function ENT:GetCachedScanFilter()
	if CurTime() < NextCache and self.CachedFilter then return self.CachedFilter end

	self.CachedFilter = self:GetScanFilter()
	NextCache = CurTime() + 1

	return self.CachedFilter
end

local tabSearch = {mask = MASK_SHOT}
function ENT:SearchForTarget()
	local shootpos = self:ShootPos()

	tabSearch.start = shootpos
	tabSearch.endpos = shootpos + self:GetGunAngles():Forward() * self.SearchDistance
	tabSearch.filter = self:GetCachedScanFilter()
	local tr = util.TraceLine(tabSearch)
	local ent = tr.Entity
	if ent and ent:IsValid() and self:IsValidTarget(ent) then
		return ent
	end
end

function ENT:GetTargetPos(target)
		local boneid = target:GetHitBoxBone(HITGROUP_HEAD, 0)
		if boneid and boneid > 0 then
			local p, a = target:GetBonePosition(boneid)
			if pl then
				return p
			end
		end

	return target:LocalToWorld(target:OBBCenter())
end

function ENT:HumanHoldable(pl)
	return true
end

function ENT:DefaultPos()
	return self:GetPos() + self:GetUp() * 55
end

function ENT:ShootPos()
	local attachid = self:LookupAttachment("eyes")
	if attachid then
		local attach = self:GetAttachment(attachid)
		if attach then return attach.Pos end
	end

	return self:DefaultPos()
end

function ENT:LaserPos()
	local attachid = self:LookupAttachment("light")
	if attachid then
		local attach = self:GetAttachment(attachid)
		if attach then return attach.Pos end
	end

	return self:DefaultPos()
end
ENT.LightPos = ENT.LaserPos

function ENT:GetGunAngles()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Right(), -self.PosePitch)
	ang:RotateAroundAxis(ang:Up(), self.PoseYaw)
	return ang
end

function ENT:SetAmmo(ammo)
	self:SetDTInt(0, ammo)
end

function ENT:GetAmmo()
	return self:GetDTInt(0)
end

function ENT:SetTarget(ent)
	if ent:IsValid() then
		self:SetTargetReceived(CurTime())
		if SERVER then
			self.LastHitSomething = CurTime()
		end
	else
		self:SetTargetLost(CurTime())
	end
	self:SetDTEntity(0, ent)
end

function ENT:GetObjectHealth()
	return self:GetDTFloat(3)
end

function ENT:SetMaxObjectHealth(health)
	self:SetDTInt(1, health)
end

function ENT:GetMaxObjectHealth()
	return self:GetDTInt(1)
end

function ENT:GetTarget()
	return self:GetDTEntity(0)
end

function ENT:SetObjectOwner(ent)
	self:SetDTEntity(1, ent)
end

function ENT:GetObjectOwner()
	return self:GetDTEntity(1)
end

function ENT:ClearObjectOwner()
	self:SetObjectOwner(NULL)
end

function ENT:ClearTarget()
	self:SetTarget(NULL)
end

function ENT:SetTargetReceived(tim)
	self:SetDTFloat(0, tim)
end

function ENT:GetTargetReceived()
	return self:GetDTFloat(0)
end

function ENT:SetTargetLost(tim)
	self:SetDTFloat(1, tim)
end

function ENT:GetTargetLost()
	return self:GetDTFloat(1)
end

function ENT:SetNextFire(tim)
	self:SetDTFloat(2, tim)
end

function ENT:GetNextFire()
	return self:GetDTFloat(2)
end

function ENT:SetFiring(onoff)
	self:SetDTBool(0, onoff)
end

function ENT:IsFiring()
	return self:GetDTBool(0)
end

function ENT:GetManualControl()
	local owner = self:GetObjectOwner()
	if owner:IsValid() and owner:Alive() and (owner:Team() == TEAM_HUMAN or owner:Team() == TEAM_BANDIT) and WorldVisible(self:DefaultPos(), owner:GetPos())then
		local wep = owner:GetActiveWeapon()
		if wep:IsValid() and wep:GetClass() == "weapon_zs_gunturretcontrol" and not wep:GetDTBool(0) then
			return true
		end
	end
	return false
end

function ENT:CanBePackedBy(pl)
	local owner = self:GetObjectOwner()
	if not pl:IsPlayer() or not owner:IsPlayer() then return false end
	return not owner:IsValid() or owner == pl or owner:Team() == pl:Team() or gamemode.Call("PlayerIsAdmin", pl)
end

util.PrecacheSound("npc/turret_floor/die.wav")
util.PrecacheSound("npc/turret_floor/active.wav")
util.PrecacheSound("npc/turret_floor/deploy.wav")
util.PrecacheSound("npc/turret_floor/shoot1.wav")
util.PrecacheSound("npc/turret_floor/shoot2.wav")
util.PrecacheSound("npc/turret_floor/shoot3.wav")
