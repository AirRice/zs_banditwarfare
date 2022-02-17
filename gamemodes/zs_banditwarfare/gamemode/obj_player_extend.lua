local meta = FindMetaTable("Player")
if not meta then return end

function meta:SetWeapon1(weaponstring)
	self:SetDTString(0, weaponstring)
end

function meta:GetWeapon1()
	return self:GetDTString(0)
end

function meta:SetWeapon2(weaponstring)
	self:SetDTString(1, weaponstring)
end

function meta:GetWeapon2()
	return self:GetDTString(1)
end

function meta:SetWeaponMelee(weaponstring)
	self:SetDTString(2, weaponstring)
end

function meta:GetWeaponMelee()
	return self:GetDTString(2)
end

function meta:SetWeaponToolslot(weaponstring)
	self:SetDTString(3, weaponstring)
end

function meta:GetWeaponToolslot()
	return self:GetDTString(3)
end

function meta:SetPoints(points)
	self:SetDTInt(1, points)
end

function meta:GetPoints()
	return self:GetDTInt(1)
end

function meta:SetFullPoints(points)
	self:SetDTInt(2, points)
end

function meta:GetFullPoints()
	return self:GetDTInt(2)
end

function meta:SetSamples(samples)
	self:SetDTInt(3, samples)
end

function meta:GetSamples()
	return self:GetDTInt(3)
end

function meta:GetMaxHealthEx()
	return self:GetMaxHealth()
end

function meta:ActiveWeaponCanBeRefilled()
	local wep = self:GetActiveWeapon()
	return wep:IsValid() and GAMEMODE.AmmoResupply[wep:GetPrimaryAmmoTypeString()]
end

function meta:LessPlayersOnTeam()
	if self:Team() == TEAM_BANDIT then
		return #team.GetPlayers(self:Team()) < #team.GetPlayers(TEAM_HUMAN)
	elseif self:Team() == TEAM_HUMAN then
		return #team.GetPlayers(self:Team()) < #team.GetPlayers(TEAM_BANDIT)
	else return false end
end

function meta:Dismember(dismembermenttype)
	local effectdata = EffectData()
		effectdata:SetOrigin(self:EyePos())
		effectdata:SetEntity(self)
		effectdata:SetScale(dismembermenttype)
	util.Effect("dismemberment", effectdata, true, true)
end

function meta:ApplyAdrenaline()
	self.HumanSpeedAdder = (self.HumanSpeedAdder or 0) +20
	self:ResetSpeed() 
	if SERVER then 
		self:SetMaxHealth(self:GetMaxHealth()-10)
		if self:Health() > self:GetMaxHealth() then
			self:SetHealth(self:GetMaxHealth())
		end
	end
	self:EmitSound("player/suit_sprint.wav")	
	return true
end

function meta:WearBodyArmor()
	self.HumanSpeedAdder = (self.HumanSpeedAdder or 0) -25
	self:ResetSpeed() 
	self:SetBodyArmor(100)
	self:EmitSound("npc/combine_soldier/gear"..math.random(6)..".wav")
	return true
end


function meta:NearestDismemberableBone(pos)
	local dismemberables = {"ValveBiped.Bip01_Head1", "ValveBiped.Bip01_L_Calf","ValveBiped.Bip01_R_Calf", "ValveBiped.Bip01_L_Forearm","ValveBiped.Bip01_R_Forearm"}
	local Dismembers = {DISMEMBER_HEAD, DISMEMBER_LEFTLEG, DISMEMBER_RIGHTLEG, DISMEMBER_LEFTARM, DISMEMBER_RIGHTARM}
	local nearest
	local nearestdist

	for id = 1, 5 do
		local bonepos, boneang = self:GetBonePositionMatrixed(self:LookupBone(dismemberables[id]))
		local dist = bonepos:Distance(pos)

		if not nearest or dist < nearestdist then
			nearest = id
			nearestdist = dist
		end
	end

	return Dismembers[nearest]
end

local TEAM_SPECTATOR = TEAM_SPECTATOR
function meta:IsSpectator()
	return self:Team() == TEAM_SPECTATOR
end

function meta:GetPoisonDamage()
	return self.PoisonRecovery and self.PoisonRecovery:IsValid() and self.PoisonRecovery:GetDamage() or 0
end

function meta:GetBleedDamage()
	return self.Bleed and self.Bleed:IsValid() and self.Bleed:GetDamage() or 0
end

function meta:HealHealth(toheal,healer, wep)
	local oldhealth = self:Health()
	local newhealth = math.min(self:GetMaxHealth(),oldhealth + toheal)
	self:SetHealth(newhealth)
	if healer:IsPlayer() and healer~=self and newhealth != oldhealth and healer:Team() == self:Team() then
		if SERVER and toheal > 5 then
			self:PurgeStatusEffects()
		end
		gamemode.Call("PlayerHealedTeamMember", healer, self, newhealth - oldhealth, wep)
	end
end

function meta:CallWeaponFunction(funcname, ...)
	local wep = self:GetActiveWeapon()
	if wep:IsValid() and wep[funcname] then
		return wep[funcname](wep, self, ...)
	end
end

function meta:ClippedName()
	local name = self:Name()
	if #name > 16 then
		name = string.sub(name, 1, 14)..".."
	end

	return name
end

function meta:DispatchAltUse()
	local tr = self:CompensatedMeleeTrace(64, 4, nil, nil, nil, true)
	local ent = tr.Entity
	if ent and ent:IsValid() then
		if ent.AltUse then
			return ent:AltUse(self, tr)
		end
	end
end

function meta:MeleeViewPunch(damage)
	local maxpunch = (damage + 25) * 0.5
	local minpunch = -maxpunch
	self:ViewPunch(Angle(math.Rand(minpunch, maxpunch), math.Rand(minpunch, maxpunch), math.Rand(minpunch, maxpunch)))
end


function meta:AddLegDamage(damage)
	self:SetLegDamage(self:GetLegDamage() + damage)
end

function meta:SetLegDamage(damage)
	self.LegDamage = math.Clamp(damage,0,GAMEMODE.MaxLegDamage)
	if SERVER then
		self:UpdateLegDamage()
	end
end

function meta:SetBodyArmor(armor)
	self.BodyArmor = armor
	if SERVER then
		self:UpdateBodyArmor()
	end
end

function meta:AddBodyArmor(armor)
	self:SetBodyArmor(math.Clamp(self:GetBodyArmor()+armor,0,GAMEMODE.MaxBodyArmor))
end

function meta:GetBodyArmor()
	return math.max(0, (self.BodyArmor or 0))
end

function meta:GetLegDamage()
	return math.max(0, (self.LegDamage or 0))
end

function meta:WouldDieFrom(damage, hitpos)
	return self:Health() <= damage
end

function meta:KnockDown(time)
	if self:Team() == TEAM_HUMAN or self:Team() == TEAM_BANDIT then
		self:GiveStatus("knockdown", time or 2)
	end
end

function meta:TraceLine(distance, mask, filter, start)
	start = start or self:GetShootPos()
	return util.TraceLine({start = start, endpos = start + self:GetAimVector() * distance, filter = filter or self, mask = mask})
end

function meta:TraceHull(distance, mask, size, filter, start)
	start = start or self:GetShootPos()
	return util.TraceHull({start = start, endpos = start + self:GetAimVector() * distance, filter = filter or self, mask = mask, mins = Vector(-size, -size, -size), maxs = Vector(size, size, size)})
end

function meta:AttemptNail(tr,showmessages)
	if CLIENT then return end
	showmessages = showmessages or false
	local trent = tr.Entity
	if not trent:IsValid()
	or not util.IsValidPhysicsObject(trent, tr.PhysicsBone)
	or tr.Fraction == 0
	or trent:GetMoveType() ~= MOVETYPE_VPHYSICS and not trent:GetNailFrozen()
	or trent.NoNails
	or trent:IsNailed() and (#trent.Nails >= 8 or trent:GetPropsInContraption() >= GAMEMODE.MaxPropsInBarricade)
	or trent:GetMaxHealth() == 1 and trent:Health() == 0 and not trent.TotalHealth
	or not trent:IsNailed() and not trent:GetPhysicsObject():IsMoveable() 
	or (trent:IsNailed() and trent:GetNailedPropOwner():IsPlayer() and trent:GetNailedPropOwner():Team() ~= self:Team())
	then return false end

	if not gamemode.Call("CanPlaceNail", self, tr) then return false end

	local count = 0
	for _, nail in pairs(trent:GetNails()) do
		if nail:GetDeployer() == self then
			count = count + 1
			if count >= 3 then
				return false
			end
		end
	end
	
	if tr.MatType == MAT_GRATE or tr.MatType == MAT_CLIP then
		if showmessages then self:PrintTranslatedMessage(HUD_PRINTCENTER, "impossible") end
		return false
	end
	if tr.MatType == MAT_GLASS then
		if showmessages then self:PrintTranslatedMessage(HUD_PRINTCENTER, "trying_to_put_nails_in_glass") end
		return false
	end

	if trent:IsValid() then
		for _, nail in pairs(ents.FindByClass("prop_nail")) do
			if nail:GetParent() == trent and nail:GetActualPos():Distance(tr.HitPos) <= 16 then
				if showmessages then self:PrintTranslatedMessage(HUD_PRINTCENTER, "too_close_to_another_nail") end
				return false
			end
		end

		if trent:GetBarricadeHealth() <= 0 and trent:GetMaxBarricadeHealth() > 0 then
			if showmessages then self:PrintTranslatedMessage(HUD_PRINTCENTER, "object_too_damaged_to_be_used") end
			return false
		end
	end

	local aimvec = (tr.HitPos-tr.StartPos):GetNormalized()
	local trtwo = util.TraceLine({start = tr.HitPos, endpos = tr.HitPos + aimvec * 24, filter = {self, trent}, mask = MASK_SOLID})

	if trtwo.HitSky then return false end

	local ent = trtwo.Entity
	if trtwo.HitWorld
	or ent:IsValid() and util.IsValidPhysicsObject(ent, trtwo.PhysicsBone) and (ent:GetMoveType() == MOVETYPE_VPHYSICS or ent:GetNailFrozen()) and not ent.NoNails and not (not ent:IsNailed() and not ent:GetPhysicsObject():IsMoveable()) and not (ent:GetMaxHealth() == 1 and ent:Health() == 0 and not ent.TotalHealth) then
		if trtwo.MatType == MAT_GRATE or trtwo.MatType == MAT_CLIP then
			if showmessages then self:PrintTranslatedMessage(HUD_PRINTCENTER, "impossible") end
			return false
		end
		if trtwo.MatType == MAT_GLASS then
			if showmessages then self:PrintTranslatedMessage(HUD_PRINTCENTER, "trying_to_put_nails_in_glass") end
			return false
		end

		if ent and ent:IsValid() and (ent.NoNails or ent:IsNailed() and (#ent.Nails >= 8 or ent:GetPropsInContraption() >= GAMEMODE.MaxPropsInBarricade)) then return end

		if ent:GetBarricadeHealth() <= 0 and ent:GetMaxBarricadeHealth() > 0 then
			if showmessages then self:PrintTranslatedMessage(HUD_PRINTCENTER, "object_too_damaged_to_be_used") end
			return false
		end

		if GAMEMODE:EntityWouldBlockSpawn(ent) then return false end

		local cons = constraint.Weld(trent, ent, tr.PhysicsBone, trtwo.PhysicsBone, 0, true)
		if cons ~= nil then
			for _, oldcons in pairs(constraint.FindConstraints(trent, "Weld")) do
				if oldcons.Ent1 == ent or oldcons.Ent2 == ent then
					cons = oldcons.Constraint
					break
				end
			end
		end

		if not cons then return false end

		trent:EmitSound("weapons/melee/crowbar/crowbar_hit-"..math.random(4)..".ogg")
		trent:SetNWEntity("LastNailOwner", self)
		local nail = ents.Create("prop_nail")
		if nail:IsValid() then
			nail:SetActualOffset(tr.HitPos, trent)
			nail:SetPos(tr.HitPos - aimvec * 8)
			nail:SetAngles(aimvec:Angle())
			nail:AttachTo(trent, ent, tr.PhysicsBone, trtwo.PhysicsBone)
			nail:Spawn()
			nail:SetDeployer(self)
			
			cons:DeleteOnRemove(nail)

			gamemode.Call("OnNailCreated", trent, ent, nail)
			return true
		end
	end
end

function meta:SetSpeed(speed)
	if not speed then speed = SPEED_NORMAL end

	self:SetWalkSpeed(speed)
	self:SetRunSpeed(speed)
	self:SetMaxSpeed(speed)
end

function meta:ResetSpeed(noset)
	if not self:IsValid() then return end
	noset = noset or false
	local wep = self:GetActiveWeapon()
	local speed

	if wep:IsValid() and wep.GetWalkSpeed then
		speed = wep:GetWalkSpeed()
	end

	if not speed then
		speed = wep.WalkSpeed or SPEED_NORMAL
	end
	
	if self:GetBodyArmor() > 0 then
		speed = speed - 25
	end
	
	if self.HumanSpeedAdder and (self:Team() == TEAM_HUMAN or self:Team() == TEAM_BANDIT) and 32 < speed then
		speed = speed + self.HumanSpeedAdder
	end

	if not noset then
		self:SetSpeed(speed)
	end

	return speed
end

function meta:ResetJumpPower(noset)
	local power = DEFAULT_JUMP_POWER

	if self:Team() == TEAM_HUMAN or self:Team() == TEAM_BANDIT then
		if self:GetBarricadeGhosting() then
			power = power * 0.25
			if not noset then
				self:SetJumpPower(power)
			end

			return power
		end
	end

	local wep = self:GetActiveWeapon()
	if wep and wep.ResetJumpPower then
		power = wep:ResetJumpPower(power) or power
	end

	if not noset then
		self:SetJumpPower(power)
	end

	return power
end

function meta:SetBarricadeGhosting(b)
	self:SetDTBool(0, b)
	self:CollisionRulesChanged()

	self:ResetJumpPower()
end

function meta:GetBarricadeGhosting()
	return self:GetDTBool(0)
end
meta.IsBarricadeGhosting = meta.GetBarricadeGhosting

function meta:ShouldBarricadeGhostWith(ent)
	return ent:IsBarricadeProp()
end

function meta:BarricadeGhostingThink()
	if self:KeyDown(IN_ZOOM) or self:ActiveBarricadeGhosting() then 
		if self.FirstGhostThink then 
			self:SetLocalVelocity( Vector( 0, 0, 0 ) ) 
			self.FirstGhostThink = false 
		end
		return 
	end
	self.FirstGhostThink = true
	self:SetBarricadeGhosting(false)
end

function meta:ShouldNotCollide(ent)
	if ent:IsValid() then
		if ent:IsPlayer() then
			return self:Team() == ent:Team()
		end
		return (self:Team() == TEAM_HUMAN or self:Team() == TEAM_BANDIT) and ent:GetPhysicsObject():IsValid() and ent:GetPhysicsObject():HasGameFlag(FVPHYSICS_PLAYER_HELD)
	end

	return false
end

function meta:GetFirstNail()
	if self.Nails then
		for i, nail in ipairs(self.Nails) do
			if nail and nail:IsValid() and not nail:GetAttachEntity():IsValid() then return nail end
		end
		for i, nail in ipairs(self.Nails) do
			if nail and nail:IsValid() then return nail end
		end
	end
end

local function nocollidetimer(self, timername)
	if self:IsValid() then
		for _, e in pairs(ents.FindInBox(self:WorldSpaceAABB())) do
			if e and e:IsValid() and e:IsPlayer() and e ~= self and GAMEMODE:ShouldCollide(self, e) then
				return
			end
		end

		self:SetCollisionGroup(COLLISION_GROUP_PLAYER)
	end

	timer.Destroy(timername)
end

function meta:TemporaryNoCollide(force)
	if self:GetCollisionGroup() ~= COLLISION_GROUP_PLAYER and not force then return end

	for _, e in pairs(ents.FindInBox(self:WorldSpaceAABB())) do
		if e and e:IsValid() and e:IsPlayer() and e ~= self and GAMEMODE:ShouldCollide(self, e) then
			self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)

			local timername = "TemporaryNoCollide"..self:SteamID64()
			timer.CreateEx(timername, 0, 0, nocollidetimer, self, timername)

			return
		end
	end

	self:SetCollisionGroup(COLLISION_GROUP_PLAYER)
end

meta.OldSetHealth = FindMetaTable("Entity").SetHealth
function meta:SetHealth(health)
	self:OldSetHealth(health)
end

function meta:AirBrake()
	local vel = self:GetVelocity()

	vel.x = vel.x * 0.15
	vel.y = vel.y * 0.15
	if vel.z > 0 then
		vel.z = vel.z * 0.15
	end

	self:SetLocalVelocity(vel)
end

local temp_attacker = NULL
local temp_attacker_team = -1
local temp_pen_ents = {}

local function MeleeTraceFilter(ent)
	if ent == temp_attacker
	or ent:IsPlayer() and ent:Team() == temp_attacker_team
	or temp_pen_ents[ent] then
		return false
	end
	return true
end

local function MeleeTraceFilterHitTeam(ent)
	if temp_pen_ents[ent] then
		return false
	end

	return ent ~= temp_attacker
end

local function SimpleTraceFilter(ent)
	if ent.IgnoreTraces or ent:IsPlayer() then
		return false
	end

	return true
end

function meta:GetSimpleTraceFilter()
	return SimpleTraceFilter
end

local melee_trace = {filter = MeleeTraceFilter, mask = MASK_SOLID, mins = Vector(), maxs = Vector()}

function meta:MeleeTrace(distance, size, start, dir, hit_team_members, override_mask, override_filter)
	start = start or self:GetShootPos()
	dir = dir or self:GetAimVector()

	local tr

	temp_attacker = self
	temp_attacker_team = self:Team()
	melee_trace.start = start
	melee_trace.endpos = start + dir * distance
	melee_trace.mask = override_mask or MASK_SOLID
	melee_trace.mins.x = -size
	melee_trace.mins.y = -size
	melee_trace.mins.z = -size
	melee_trace.maxs.x = size
	melee_trace.maxs.y = size
	melee_trace.maxs.z = size
	melee_trace.filter = hit_team_members and MeleeTraceFilterHitTeam or MeleeTraceFilter

	tr = util.TraceLine(melee_trace)

	if tr.Hit then
		return tr
	end

	return util.TraceHull(melee_trace)
end

local function InvalidateCompensatedTrace(tr, start, distance)
	-- Need to do this or people with 300 ping will be hitting people across rooms
	if tr.Entity:IsValid() and tr.Entity:IsPlayer() and tr.HitPos:DistToSqr(start) > distance * distance + 144 then -- Give just a little bit of leeway
		tr.Hit = false
		tr.HitNonWorld = false
		tr.Entity = NULL
	end
end

function meta:CompensatedMeleeTrace(distance, size, start, dir, hit_team_members)
	start = start or self:GetShootPos()
	dir = dir or self:GetAimVector()

	self:LagCompensation(true)
	local tr = self:MeleeTrace(distance, size, start, dir, hit_team_members)
	self:LagCompensation(false)

	InvalidateCompensatedTrace(tr, start, distance)

	return tr
end

function meta:CompensatedPenetratingMeleeTrace(distance, size, start, dir, hit_team_members)
	start = start or self:GetShootPos()
	dir = dir or self:GetAimVector()

	self:LagCompensation(true)
	local t = self:PenetratingMeleeTrace(distance, size, start, dir, hit_team_members)
	self:LagCompensation(false)

	for _, tr in pairs(t) do
		InvalidateCompensatedTrace(tr, start, distance)
	end

	return t
end

function meta:PenetratingMeleeTrace(distance, size, start, dir)
	start = start or self:GetShootPos()
	dir = dir or self:GetAimVector()

	local tr, ent

	temp_attacker = self
	temp_attacker_team = self:Team()
	temp_pen_ents = {}
	melee_trace.start = start
	melee_trace.endpos = start + dir * distance
	melee_trace.mask = MASK_SOLID
	melee_trace.mins.x = -size
	melee_trace.mins.y = -size
	melee_trace.mins.z = -size
	melee_trace.maxs.x = size
	melee_trace.maxs.y = size
	melee_trace.maxs.z = size

	local t = {}
	local onlyhitworld
	for i=1, 50 do
		tr = util.TraceLine(melee_trace)

		if not tr.Hit then
			tr = util.TraceHull(melee_trace)
		end

		if not tr.Hit then break end

		if tr.HitWorld then
			table.insert(t, tr)
			break
		end

		if onlyhitworld then break end

		ent = tr.Entity
		if ent:IsValid() then
			if not ent:IsPlayer() then
				melee_trace.mask = MASK_SOLID_BRUSHONLY
				onlyhitworld = true
			end

			table.insert(t, tr)
			temp_pen_ents[ent] = true
		end
	end

	temp_pen_ents = {}

	return t, onlyhitworld
end

function meta:ActiveBarricadeGhosting(override)
	if not (self:Team() == TEAM_HUMAN or self:Team() == TEAM_BANDIT) and not override or not self:GetBarricadeGhosting() then return false end
	
	local aabbmin, aabbmax = self:WorldSpaceAABB()
	aabbmin.x = aabbmin.x + 1
	aabbmin.y = aabbmin.y + 1

	aabbmax.x = aabbmax.x - 1
	aabbmax.y = aabbmax.y - 1
	
	for _, ent in pairs(ents.FindInBox(aabbmin,aabbmax)) do
		if ent and ent:IsValid() and self:ShouldBarricadeGhostWith(ent) then return true end
	end

	return false
end

function meta:IsHolding()
	return self:GetHolding():IsValid()
end
meta.IsCarrying = meta.IsHolding

function meta:GetHolding()
	local status = self.status_human_holding
	if status and status:IsValid() then
		local obj = status:GetObject()
		if obj:IsValid() then return obj end
	end

	return NULL
end

local oldmaxhealth = FindMetaTable("Entity").GetMaxHealth
function meta:GetMaxHealth()
	return oldmaxhealth(self)
end

if not meta.OldAlive then
	meta.OldAlive = meta.Alive
	function meta:Alive()
		return self:GetObserverMode() == OBS_MODE_NONE and self:OldAlive()
	end
end

function meta:PlayEyePoisonedSound()
	local snds = GAMEMODE.VoiceSets[self.VoiceSet].EyePoisonedSounds
	if snds then
		self:EmitSound(snds[math.random(1, #snds)])
	end
end

function meta:PlayGiveAmmoSound()
	local snds = GAMEMODE.VoiceSets[self.VoiceSet].GiveAmmoSounds
	if snds then
		self:EmitSound(snds[math.random(1, #snds)])
	end
end

function meta:PlayDeathSound()
	local snds = GAMEMODE.VoiceSets[self.VoiceSet].DeathSounds
	if snds then
		self:EmitSound(snds[math.random(1, #snds)])
	end
end

function meta:PlayPainSound()
	if CurTime() < self.NextPainSound then return end

	local snds
	
	if (self:Team() == TEAM_BANDIT or self:Team() == TEAM_HUMAN) then
		local set = GAMEMODE.VoiceSets[self.VoiceSet]
		if set then
			local health = self:Health()
			if 70 <= health then
				snds = set.PainSoundsLight
			elseif 35 <= health then
				snds = set.PainSoundsMed
			else
				snds = set.PainSoundsHeavy
			end
		end
	end
	if snds then
		local snd = snds[math.random(#snds)]
		if snd then
			self:EmitSound(snd)
			self.NextPainSound = CurTime() + SoundDuration(snd) - 0.1
		end
	end
end

local ViewHullMins = Vector(-8, -8, -8)
local ViewHullMaxs = Vector(8, 8, 8)
function meta:GetThirdPersonCameraPos(origin, angles)
	local allplayers = player.GetAll()
	local tr = util.TraceHull({start = origin, endpos = origin + angles:Forward() * -math.max(48, self:BoundingRadius()), mask = MASK_SHOT, filter = allplayers, mins = ViewHullMins, maxs = ViewHullMaxs})
	return tr.HitPos + tr.HitNormal * 3
end

-- Override these because they're different in 1st person and on the server.
function meta:SyncAngles()
	local ang = self:EyeAngles()
	ang.pitch = 0
	ang.roll = 0
	return ang
end
meta.GetAngles = meta.SyncAngles

function meta:GetForward()
	return self:SyncAngles():Forward()
end

function meta:GetUp()
	return self:SyncAngles():Up()
end

function meta:GetRight()
	return self:SyncAngles():Right()
end
