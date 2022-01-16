local meta = FindMetaTable("Player")
if not meta then return end

function meta:FloatingScore(victim, effectname, frags, flags)
	if MySelf == self then
		gamemode.Call("FloatingScore", victim, effectname, frags, flags)
	end
end

function meta:FixModelAngles(velocity)
	local eye = self:EyeAngles()
	self:SetLocalAngles(eye)
	self:SetRenderAngles(eye)
	self:SetPoseParameter("move_yaw", math.NormalizeAngle(velocity:Angle().yaw - eye.y))
end

function meta:RemoveAllStatus(bSilent, bInstant)
end

function meta:RemoveStatus(sType, bSilent, bInstant, sExclude)
end

function meta:GetStatus(sType)
	local ent = self["status_"..sType]
	if ent and ent:IsValid() and ent:GetOwner() == self then return ent end
end

function meta:GiveStatus(sType, fDie)
end

function meta:IsFriend()
	return self.m_IsFriend
end

timer.Create("checkfriend", 5, 0, function()
	-- This probably isn't the fastest function in the world so I cache it.
	for _, pl in pairs(player.GetAll()) do
		pl.m_IsFriend = pl:GetFriendStatus() == "friend"
	end
end)

if not meta.SetGroundEntity then
	function meta:SetGroundEntity(ent) end
end

if not meta.Kill then
	function meta:Kill() end
end

if not meta.HasWeapon then
	function meta:HasWeapon(class)
		for _, wep in pairs(self:GetWeapons()) do
			if wep:GetClass() == class then return true end
		end

		return false
	end
end

function meta:SetMaxHealth(num)
	self:SetDTInt(0, math.ceil(num))
end

meta.OldGetMaxHealth = FindMetaTable("Entity").GetMaxHealth
function meta:GetMaxHealth()
	return self:GetDTInt(0)
end

function meta:DoHulls()
	self:SetIK(true)

	self:SetModelScale(DEFAULT_MODELSCALE, 0)
	self:ResetHull()
	self:SetViewOffset(DEFAULT_VIEW_OFFSET)
	self:SetViewOffsetDucked(DEFAULT_VIEW_OFFSET_DUCKED)
	self:SetStepSize(DEFAULT_STEP_SIZE)
	self:SetJumpPower(DEFAULT_JUMP_POWER)

	if self.ClientsideModelScale then
		self.ClientsideModelScale = nil
		self:DisableMatrix("RenderMultiply")
	end

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetMass(DEFAULT_MASS)
	end
end

net.Receive("zs_dohulls", function(length)
	local ent = net.ReadEntity()
	if ent:IsValid() then
		ent:DoHulls()
	end
end)

net.Receive("zs_floatscore", function(length)
	local victim = net.ReadEntity()
	local effectname = net.ReadString()
	local frags = net.ReadInt(24)
	local flags = net.ReadUInt(8)

	if victim and victim:IsValid() then
		MySelf:FloatingScore(victim, effectname, frags, flags)
	end
end)

net.Receive("zs_floatscore_vec", function(length)
	local pos = net.ReadVector()
	local effectname = net.ReadString()
	local frags = net.ReadInt(24)
	local flags = net.ReadUInt(8)

	MySelf:FloatingScore(pos, effectname, frags, flags)
end)
