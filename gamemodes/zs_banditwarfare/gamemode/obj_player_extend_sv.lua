local meta = FindMetaTable("Player")
if not meta then return end

function meta:UpdateWeaponLoadouts()
	self:StripNonLoadoutWeapons()
	
	local wep1 = self:GetWeapon1()
	local storedwep1 = weapons.GetStored(wep1)
	if storedwep1 then
		self:Give(wep1)
	end
	local wep2 = self:GetWeapon2()
	local storedwep2 = weapons.GetStored(wep2)
	if storedwep2 then
		self:Give(wep2)
	end
	local weptool = self:GetWeaponToolslot()
	local storedweptool = weapons.GetStored(weptool)
	if storedweptool then
		self:Give(weptool)
	end
	local wepmelee = self:GetWeaponMelee()	
	local storedwepmelee = weapons.GetStored(wepmelee)
	if storedwepmelee then
		self:Give(wepmelee)
	end
end

local function AddToClassicInsuredList(wepname, pl)
	storedwep = weapons.GetStored(wepname)
	shoptab = FindItembyClass(wepname)
	if storedwep and not (shoptab.NoClassicMode) then
		table.ForceInsert(pl.ClassicModeInsuredWeps,wepname)
	end
end

function meta:ResetLoadout()
	local wepdefaults = {}
	wepdefaults[WEAPONLOADOUT_SLOT1] = GAMEMODE.PossiblePrimaryGuns
	wepdefaults[WEAPONLOADOUT_SLOT2] = GAMEMODE.PossibleSecondaryGuns
	wepdefaults[WEAPONLOADOUT_MELEE] = GAMEMODE.PossibleMelees
	wepdefaults[WEAPONLOADOUT_TOOLS] = {"weapon_zs_enemyradar"}

	for slot=WEAPONLOADOUT_SLOT1, WEAPONLOADOUT_TOOLS do
		local wepname = self:GetWeaponLoadoutBySlot(slot)
		storedwep = weapons.GetStored(wepname)
		shoptab = FindItembyClass(wepname)
		local shoptabnotvalid = (storedwep and ((newmode == ROUNDMODE_SAMPLES) and (shoptab.NoSampleCollectMode) or (newmode == ROUNDMODE_TRANSMISSION) and (shoptab.NoTransmissionMode)))
		if not shoptabnotvalid then
			local possibleguns = wepdefaults[slot]
			self:SetWeaponLoadoutBySlot(possibleguns[math.random(#possibleguns)],slot)
		end
	end

	if GAMEMODE:IsClassicMode() then
		self.ClassicModeInsuredWeps = {}
		self.ClassicModeNextInsureWeps = {}
		self.ClassicModeRemoveInsureWeps = {}
		self:SendLua("GAMEMODE.ClassicModeInsuredWeps = {}")
		self:SendLua("GAMEMODE.ClassicModePurchasedThisWave = {}")

		table.ForceInsert(self.ClassicModeInsuredWeps,self:GetWeapon2())
		table.ForceInsert(self.ClassicModeInsuredWeps,self:GetWeaponMelee())

		for _, wep in pairs(self.ClassicModeInsuredWeps) do
			local storedwep = weapons.GetStored(wep)
			if storedwep then
				local given = self:Give(wep)
				if given then
					net.Start("zs_insure_weapon")
						net.WriteString(wep)
						net.WriteBool(false)
					net.Send(self)
				end
			end
		end
	else
		self:UpdateWeaponLoadouts()
	end
end

function meta:LoadoutToClassicInventory()
	if not (GAMEMODE:IsSampleCollectMode() or GAMEMODE:IsTransmissionMode()) then return end
	self:StripWeapons()
	self.ClassicModeInsuredWeps = {}
	self.ClassicModeNextInsureWeps = {}
	self.ClassicModeRemoveInsureWeps = {}
	self:SendLua("GAMEMODE.ClassicModeInsuredWeps = {}")
	self:SendLua("GAMEMODE.ClassicModePurchasedThisWave = {}")
	for slot=WEAPONLOADOUT_SLOT1, WEAPONLOADOUT_TOOLS do
		local wep = self:GetWeaponLoadoutBySlot(slot)
		AddToClassicInsuredList(wep, self)
	end
	for _, wep in pairs(self.ClassicModeInsuredWeps) do
		local storedwep = weapons.GetStored(wep)
		if storedwep then
			local given = self:Give(wep)
			if given then
				net.Start("zs_insure_weapon")
					net.WriteString(wep)
					net.WriteBool(false)
				net.Send(self)
			end
		end
	end
end

function meta:ClassicInventoryToLoadout()
	if not GAMEMODE:IsClassicMode() then return end
	local wep1 = nil 
	local wep2 = nil
	local wepmelee = nil
	local weptool = nil
	local insuredweps = self.ClassicModeInsuredWeps
	table.Add(insuredweps, self.ClassicModeNextInsureWeps)
	for i,wep in ipairs(self:GetWeapons()) do
		local weptab = wep:GetClass()
		local shoptab = FindItembyClass(weptab)
		if shoptab and (shoptab.Category == ITEMCAT_GUNS or shoptab.Category == ITEMCAT_MELEE or shoptab.Category == ITEMCAT_TOOLS) and table.HasValue(insuredweps, weptab) and not (GAMEMODE:IsSampleCollectMode() and shoptab.NoSampleCollectMode) then
			if (shoptab.Category == ITEMCAT_GUNS) then
				if not wep2 and weptab != self:GetWeapon1() then
					wep2 = weptab
					self:SetWeapon2(weptab)		
				elseif not wep1 and weptab != self:GetWeapon2()  then
					wep1 = weptab
					self:SetWeapon1(weptab)
				end
			elseif (shoptab.Category == ITEMCAT_MELEE) then
				if not wepmelee then
					wepmelee = weptab
					self:SetWeaponMelee(weptab)				
				end	
			elseif (shoptab.Category == ITEMCAT_TOOLS) then
				if not weptool then
					weptool = weptab
					self:SetWeaponToolslot(weptab)				
				end	
			end
		end
	end
	self:StripWeapons()
	self.ClassicModeInsuredWeps = {}
	self.ClassicModeNextInsureWeps = {}
	self.ClassicModeRemoveInsureWeps = {}
	self:SendLua("GAMEMODE.ClassicModeInsuredWeps = {}")
	self:SendLua("GAMEMODE.ClassicModePurchasedThisWave = {}")
	self:UpdateWeaponLoadouts()
end

function meta:HandleRoundModeChangeLoadout(oldmode, newmode)
	if oldmode == ROUNDMODE_CLASSIC and (newmode == ROUNDMODE_SAMPLES or newmode == ROUNDMODE_TRANSMISSION) then
		self:ClassicInventoryToLoadout()
	elseif (oldmode == ROUNDMODE_SAMPLES or oldmode == ROUNDMODE_TRANSMISSION) and newmode == ROUNDMODE_CLASSIC then
		self:LoadoutToClassicInventory()
	elseif (oldmode == ROUNDMODE_UNASSIGNED) then
		self:ResetLoadout() -- Start from scratch
	end
end

function meta:StripNonLoadoutWeapons()
	for _, wep in pairs(self:GetWeapons()) do
		local wep1 = self:GetWeapon1()
		local wep2 = self:GetWeapon2()
		local weptool = self:GetWeaponToolslot()
		local wepmelee = self:GetWeaponMelee()
		local wepclass = wep:GetClass()
		local shoptab = FindItembyClass(wepclass)
		if shoptab and (shoptab.Category == ITEMCAT_GUNS or shoptab.Category == ITEMCAT_MELEE or shoptab.Category == ITEMCAT_TOOLS) and 
		not (wepclass==wep1 || wepclass==wep2 || wepclass==weptool || wepclass==wepmelee) then
			self:StripWeapon(wepclass)
		end
	end
end

function meta:FakeDeath(sequenceid, modelscale, length)
	for _, ent in pairs(ents.FindByClass("fakedeath")) do
		if ent:GetOwner() == self then
			ent:Remove()
		end
	end

	local ent = ents.Create("fakedeath")
	if ent:IsValid() then
		ent:SetOwner(self)
		ent:SetModel(self:GetModel())
		ent:SetSkin(self:GetSkin())
		ent:SetColor(self:GetColor())
		ent:SetMaterial(self:GetMaterial())
		ent:SetPos(self:GetPos() + Vector(0, 0, 64))
		ent:Spawn()
		ent:SetModelScale(modelscale or self:GetModelScale(), 0)

		ent:SetDeathSequence(sequenceid or 0)
		ent:SetDeathAngles(self:GetAngles())
		ent:SetDeathSequenceLength(length or 1)

		self:DeleteOnRemove(ent)
	end

	return ent
end

function meta:SetupHands( ply )
	local oldhands = self:GetHands()
	if IsValid(oldhands) then
		oldhands:Remove()
	end
	local hands = ents.Create("zs_hands")
	if hands:IsValid() then
		hands:DoSetup(self, ply)
		hands:Spawn()
	end
end

function meta:RefreshPlayerModel()
	local randommodel = nil
	local preferredmodel = nil
	if (self:Team() == TEAM_HUMAN) then
		preferredmodel = self:GetInfo("zsb_preferredsurvivormodel")
		randommodel = GAMEMODE.RandomSurvivorModels[math.random(#GAMEMODE.RandomSurvivorModels)]
	elseif (self:Team() == TEAM_BANDIT) then
		preferredmodel = self:GetInfo("zsb_preferredbanditmodel")
		randommodel = GAMEMODE.RandomBanditModels[math.random(#GAMEMODE.RandomBanditModels)]
	end
	
	if preferredmodel == nil then
		preferredmodel = randommodel
	end
	
	local modelname = player_manager.TranslatePlayerModel(preferredmodel)
	self:SetModel(modelname)
	self:SetupHands(self)
	-- Cache the voice set.

	local lowermodelname = string.lower(modelname)
	if GAMEMODE.VoiceSetTranslate[lowermodelname] then
		self.VoiceSet = GAMEMODE.VoiceSetTranslate[lowermodelname]
	elseif string.find(lowermodelname, "female", 1, true) then
		self.VoiceSet = "female"
	else
		self.VoiceSet = "male"
	end
end

function meta:ChangeTeam(teamid)
	self:SetTeam(teamid)
	self:CollisionRulesChanged()
end

function meta:ProcessDamage(dmginfo)
	local attacker, inflictor = dmginfo:GetAttacker(), dmginfo:GetInflictor()
	local attackweapon = (attacker:IsPlayer() and attacker:GetActiveWeapon() or nil)
	local lasthitgroup = self:LastHitGroup()
	if attacker:IsPlayer() then
		if attacker ~= self and GAMEMODE:PlayerShouldTakeDamage(self,attacker) then
			local head = (self:WasHitInHead())
			net.Start( "zs_hitmarker" )
				net.WriteBool( self:IsPlayer() )
				net.WriteBool( head )
			net.Send( attacker )
		end
		if attacker:LessPlayersOnTeam() and attackweapon and not attackweapon.NoScaleToLessPlayers and not attackweapon.IgnoreDamageScaling then
			dmginfo:ScaleDamage(1.25)
		end
		if self:GetBodyArmor() and self:GetBodyArmor() > 0 then
			local ratio = 0.75
			if dmginfo:IsDamageType(DMG_BLAST) then
				ratio = ratio * 0.75
				dmginfo:ScaleDamage(0.25)
			elseif (dmginfo:IsDamageType(DMG_BULLET) or dmginfo:IsDamageType(DMG_CLUB) or dmginfo:IsDamageType(DMG_SLASH)) 
			and not (attackweapon and attackweapon.IgnoreDamageScaling) and not (self:WasHitInHead()) then
				ratio = ratio * 0.6
				dmginfo:ScaleDamage(0.4)
			end
			self:AddBodyArmor(dmginfo:GetDamage()*-ratio)
		end
		if self:GetActiveWeapon() and IsValid(self:GetActiveWeapon()) and self:GetActiveWeapon().ProcessDamage then
			self:GetActiveWeapon():ProcessDamage(dmginfo)
		end
	end
	if self.DamageVulnerability then
		dmginfo:SetDamage(dmginfo:GetDamage() * self.DamageVulnerability)
	end
end

function meta:WasHitInHead()
	return self.m_LastHitInHead and CurTime() <= self.m_LastHitInHead + 0.1
end

function meta:SetWasHitInHead()
	self.m_LastHitInHead = CurTime()
end

function meta:AddLifeBarricadeDamage(amount)
	self.LifeBarricadeDamage = self.LifeBarricadeDamage + amount

	if not self:Alive() then
		net.Start("zs_lifestatsbd")
			net.WriteUInt(self.LifeBarricadeDamage, 24)
		net.Send(self)
	end
end

function meta:AddLifeEnemyDamage(amount)
	self.LifeEnemyDamage = self.LifeEnemyDamage + amount

	if not self:Alive() then
		net.Start("zs_lifestatshd")
			net.WriteUInt(math.ceil(self.LifeEnemyDamage), 24)
		net.Send(self)
	end
end

function meta:AddLifeEnemyKills(amount)
	self.LifeEnemyKills = self.LifeEnemyKills + amount

	if not self:Alive() then
		net.Start("zs_lifestatskills")
			net.WriteUInt(self.LifeEnemyKills, 16)
		net.Send(self)
	end
end

function meta:FloatingScore(victimorpos, effectname, frags, flags)
	if type(victimorpos) == "Vector" then
		net.Start("zs_floatscore_vec")
			net.WriteVector(victimorpos)
			net.WriteString(effectname)
			net.WriteInt(frags, 24)
			net.WriteUInt(flags, 8)
		net.Send(self)
	else
		net.Start("zs_floatscore")
			net.WriteEntity(victimorpos)
			net.WriteString(effectname)
			net.WriteInt(frags, 24)
			net.WriteUInt(flags, 8)
		net.Send(self)
	end
end

function meta:CenterNotify(...)
	net.Start("zs_centernotify")
		net.WriteTable({...})
	net.Send(self)
end

function meta:TopNotify(...)
	net.Start("zs_topnotify")
		net.WriteTable({...})
	net.Send(self)
end

function meta:PushPackedItem(class, ...)
	if self.PackedItems and ... ~= nil then
		local packed = {...}

		self.PackedItems[class] = self.PackedItems[class] or {}

		table.insert(self.PackedItems[class], packed)
	end
end

function meta:PopPackedItem(class)
	if self.PackedItems and self.PackedItems[class] and self.PackedItems[class][1] ~= nil then
		local index = #self.PackedItems[class]
		local data = self.PackedItems[class][index]
		table.remove(self.PackedItems[class], index)

		return data
	end
end

function meta:GiveEmptyWeapon(weptype)
	if not self:HasWeapon(weptype) then
		local wep = self:Give(weptype)
		if wep and wep:IsValid() and wep:IsWeapon() then
			wep:EmptyAll(true)
		end

		return wep
	end
end

local OldGive = meta.Give
function meta:Give(weptype)
	if not (self:Team() == TEAM_HUMAN or self:Team() == TEAM_BANDIT) then
		return OldGive(self, weptype)
	end

	local weps = self:GetWeapons()
	local autoswitch = #weps == 1 and weps[1]:IsValid() and weps[1].AutoSwitchFrom

	local ret = OldGive(self, weptype)

	if autoswitch then
		self:SelectWeapon(weptype)
	end

	return ret
end

function meta:DispatchProjectileTraceAttack(dmg, tr, attacker, inflictor, vel)
	dmg = dmg or 0
	if dmg <= 0 then return end
	if not (tr and tr.HitPos and tr.Hit and tr.HitGroup) then return end
	
	local damageinfo = DamageInfo()
	damageinfo:SetDamageType(DMG_BULLET)
	damageinfo:SetDamage(dmg)
	damageinfo:SetDamagePosition(tr.HitPos)
	damageinfo:SetAttacker(attacker)
	damageinfo:SetInflictor(inflictor)
	damageinfo:SetDamageForce(vel:GetNormalized())
	if (tr.Hit and tr.HitGroup == HITGROUP_HEAD) then
		self:SetLastHitGroup(HITGROUP_HEAD)
		self:SetWasHitInHead()
	end
	self:DispatchTraceAttack(damageinfo, tr)
	if vel and attacker:IsPlayer() and attacker ~= self then
		self:SetLocalVelocity(vel:GetNormalized() * math.min(dmg,10))
	end
end

function meta:UpdateLegDamage()
	net.Start("zs_legdamage")
		net.WriteFloat(self.LegDamage)
	net.Send(self)
end

function meta:UpdateBodyArmor()
	net.Start("zs_bodyarmor")
		net.WriteFloat(self.BodyArmor)
	net.Send(self)
end

function meta:SendHint()
end

local function RemoveSkyCade(groundent, timername)
	if not groundent:IsValid() or not (groundent.IsBarricadeObject or groundent:IsNailedToWorldHierarchy()) then
		timer.Destroy(timername)
		return
	end

	for _, pl in pairs(player.GetAll()) do
		if pl:Alive() and pl:GetGroundEntity() == groundent then
			groundent:TakeDamage(150, groundent, groundent)
			pl:ViewPunch(Angle(math.Rand(-15, 15), math.Rand(-15, 15), math.Rand(-15, 15)))
			groundent:EmitSound("physics/metal/metal_box_impact_hard"..math.random(3)..".wav", 80, 255)
			return
		end
	end

	timer.Destroy(timername)
end
local checkoffset = Vector(0, 0, -128)
function meta:PreventSkyCade()
	local groundent = self:GetGroundEntity()
	if groundent:IsValid() then
		if groundent:IsNailedToWorldHierarchy() then
			local phys = groundent:GetPhysicsObject()
			if phys:IsValid() and phys:GetMass() <= CARRY_DRAG_MASS then
				local timername = "RemoveSkyCade"..tostring(groundent)
				local start = groundent:WorldSpaceCenter()
				if not timer.Exists(timername) and not util.TraceHull({start = start,
										endpos = start + checkoffset,
										mins = groundent:OBBMins() * 0.85, maxs = groundent:OBBMaxs() * 0.85,
										mask = MASK_SOLID_BRUSHONLY}).Hit then
					timer.Create(timername, 0.5, 0, function() RemoveSkyCade(groundent, timername) end) -- Oh dear.
				end
			end
		end
	end
end

function meta:FixModelAngles(velocity)
	local eye = self:EyeAngles()
	self:SetLocalAngles(eye)
	self:SetPoseParameter("move_yaw", math.NormalizeAngle(velocity:Angle().yaw - eye.y))
end

function meta:RemoveAllStatus(bSilent, bInstant)
	if bInstant then
		for _, ent in pairs(ents.FindByClass("status_*")) do
			if not ent.NoRemoveOnDeath and ent:GetOwner() == self then
				ent:Remove()
			end
		end
	else
		for _, ent in pairs(ents.FindByClass("status_*")) do
			if not ent.NoRemoveOnDeath and ent:GetOwner() == self then
				ent.SilentRemove = bSilent
				ent:SetDie()
			end
		end
	end
end

function meta:PurgeStatusEffects()
	for _, hook in pairs(ents.FindByClass("prop_meathook")) do
		if hook:GetClass() == "prop_meathook" and hook:GetParent() == self then
			hook.TicksLeft = 0
		end
	end
	self:RemoveStatus("confusion", false, true)
	self:RemoveStatus("marked", false, true)
	self:RemoveStatus("bleed", false, true)
	self:RemoveStatus("poisonrecovery", false, true)
	self:RemoveStatus("tox", false, true)
	self:RemoveStatus("stunned", false, true)
	self:RemoveStatus("knockdown", false, true)
end

function meta:RemoveStatus(sType, bSilent, bInstant, sExclude)
	local removed

	for _, ent in pairs(ents.FindByClass("status_"..sType)) do
		if ent:GetOwner() == self and not (sExclude and ent:GetClass() == "status_"..sExclude) then
			if bInstant then
				ent:Remove()
			else
				ent.SilentRemove = bSilent
				ent:SetDie()
			end
			removed = true
		end
	end

	return removed
end

function meta:GetStatus(sType)
	local ent = self["status_"..sType]
	if ent and ent:IsValid() and ent:GetOwner() == self then return ent end
end

function meta:GiveStatus(sType, fDie)
	local cur = self:GetStatus(sType)
	if cur then
		if fDie then
			cur:SetDie(fDie)
		end
		cur:SetPlayer(self, true)
		return cur
	else
		local ent = ents.Create("status_"..sType)
		if ent:IsValid() then
			ent:Spawn()
			if fDie then
				ent:SetDie(fDie)
			end
			ent:SetPlayer(self)
			return ent
		end
	end
end

local oldSpectate = meta.Spectate
function meta:Spectate(type)
	oldSpectate(self, type)
	if type == OBS_MODE_ROAMING then
		self:SetMoveType(MOVETYPE_NOCLIP)
	elseif type ~= OBS_MODE_NONE then
		self:SetMoveType(MOVETYPE_OBSERVER)
	end
end

meta.OldUnSpectate = meta.OldUnSpectate or meta.UnSpectate
function meta:UnSpectate()
	if self:GetObserverMode() ~= OBS_MODE_NONE then
		self:OldUnSpectate(obsm)
	end
end


function meta:UnSpectateAndSpawn()
	self:UnSpectate()
	self:Spawn()
end

function meta:DropAll()
	self:DropAllAmmo()
	self:DropAllWeapons()
end

local function CreateRagdoll(pl)
	if pl:IsValid() then pl:OldCreateRagdoll() end
end
local function SetModel(pl, mdl)
	if pl:IsValid() then
		pl:SetModel(mdl)
		timer.Simple(0, function() CreateRagdoll(pl) end)
	end
end

meta.OldCreateRagdoll = meta.OldCreateRagdoll or meta.CreateRagdoll
function meta:CreateRagdoll()
	local status = self.status_overridemodel
	if status and status:IsValid() then
		local mdl = status:GetModel()
		timer.Simple(0, function() SetModel(self, mdl) end)
		status:SetRenderMode(RENDERMODE_NONE)
	else
		self:OldCreateRagdoll()
	end
end

function meta:DropActiveWeapon()
	local vPos = self:GetPos()
	local vAng = self:EyeAngles()
	local zmax = self:OBBMaxs().z * 0.75
	local currentwep = self:GetActiveWeapon()
	if currentwep:IsValid() then
		local shoptab = FindItembyClass(currentwep:GetClass())
		local shoulddrop = true
		if GAMEMODE:IsClassicMode() then 
			for _, insuredwep in ipairs(self.ClassicModeInsuredWeps) do
				if insuredwep == currentwep:GetClass() then
					shoulddrop = false
					break
				end
			end
			for i, insuredwep in ipairs(self.ClassicModeNextInsureWeps) do
				if insuredwep == currentwep:GetClass() then
					table.remove(self.ClassicModeNextInsureWeps,i)
				end
			end
		else
			local shoptab = FindItembyClass(currentwep:GetClass())
			if shoptab and (shoptab.Category == ITEMCAT_GUNS or shoptab.Category == ITEMCAT_MELEE or shoptab.Category == ITEMCAT_TOOLS) then
				shoulddrop = false
			end
		end
		if shoulddrop then
			local ent = self:DropWeaponByType(currentwep:GetClass())
			if ent and ent:IsValid() then
				self:EmitSound("weapons/slam/throw.wav", 65, math.random(95, 105))
				ent:SetPos(vPos + Vector(math.Rand(-16, 16), math.Rand(-16, 16), math.Rand(2, zmax)))
				ent:SetAngles(VectorRand():Angle())
				local phys = ent:GetPhysicsObject()
				if IsValid(phys) then
					phys:ApplyForceCenter(vAng:Forward() * 400)
				end
			end
		end
	end
end

function meta:DropWeaponByType(class)
	local wep = self:GetWeapon(class)
	if wep and wep:IsValid() and not wep.Undroppable then
		local ent = ents.Create("prop_weapon")
		if ent:IsValid() then
			ent:SetWeaponType(class)
			ent:Spawn()

			if wep.AmmoIfHas then
				local ammocount = wep:GetPrimaryAmmoCount()
				local desiredrop = math.min(ammocount, wep.Primary.ClipSize) - wep:Clip1()
				if desiredrop > 0 then
					wep:TakeCombinedPrimaryAmmo(desiredrop)
					wep:SetClip1(desiredrop)
				end
			end
			ent:SetClip1(wep:Clip1())
			ent:SetClip2(wep:Clip2())
			ent.DroppedTime = CurTime()

			self:StripWeapon(class)
			return ent
		end
	end
end
function meta:DropAllWeapons()
	local vPos = self:GetPos()
	local vVel = self:GetVelocity()
	local zmax = self:OBBMaxs().z * 0.75
	for _, wep in pairs(self:GetWeapons()) do
		if wep:IsValid() then
			if GAMEMODE:IsClassicMode() then 
				for _, insuredwep in pairs(self.ClassicModeInsuredWeps) do
					if weapons.GetStored(insuredwep) then
						self:StripWeapon(insuredwep)
					end
				end
				local ent = self:DropWeaponByType(wep:GetClass())
				if ent and ent:IsValid() then
					ent:SetPos(vPos + Vector(math.Rand(-16, 16), math.Rand(-16, 16), math.Rand(2, zmax)))
					ent:SetAngles(VectorRand():Angle())
					local phys = ent:GetPhysicsObject()
					if phys:IsValid() then
						phys:AddAngleVelocity(Vector(math.Rand(-720, 720), math.Rand(-720, 720), math.Rand(-720, 720)))
						phys:ApplyForceCenter(phys:GetMass() * (math.Rand(32, 328) * VectorRand():GetNormalized() + vVel))
					end
				end
			else
				local shoptab = FindItembyClass(wep:GetClass())
				if shoptab and (shoptab.Category == ITEMCAT_GUNS or shoptab.Category == ITEMCAT_MELEE or shoptab.Category == ITEMCAT_TOOLS) then
					self:StripWeapon(wep:GetClass())
				else
				local ent = self:DropWeaponByType(wep:GetClass())
				if ent and ent:IsValid() then
					ent:SetPos(vPos + Vector(math.Rand(-16, 16), math.Rand(-16, 16), math.Rand(2, zmax)))
					ent:SetAngles(VectorRand():Angle())
					local phys = ent:GetPhysicsObject()
					if phys:IsValid() then
						phys:AddAngleVelocity(Vector(math.Rand(-720, 720), math.Rand(-720, 720), math.Rand(-720, 720)))
						phys:ApplyForceCenter(phys:GetMass() * (math.Rand(32, 328) * VectorRand():GetNormalized() + vVel))
					end
				end
				end
			end
		end
	end
end

function meta:StripAmmoByType(ammotype)
	local mycount = self:GetAmmoCount(ammotype)
	if not mycount or mycount <= 0 then return end
	self:RemoveAmmo(mycount, ammotype)
end

function meta:DropAmmoByType(ammotype, amount)
	local mycount = self:GetAmmoCount(ammotype)
	amount = math.min(mycount, amount or mycount)
	if not amount or amount <= 0 then return end
	self:RemoveAmmo(amount, ammotype)
	if GAMEMODE.AmmoResupply[ammotype] ~= nil and GAMEMODE.AmmoResupply[ammotype] > 0 then
		local ent = ents.Create("prop_ammo")
		if ent:IsValid() then
			ent:SetAmmoType(ammotype)
			ent:SetAmmo(amount)
			ent:Spawn()
			return ent
		end
	end
end

function meta:DropAllAmmo()
	local vPos = self:GetPos()
	local vVel = self:GetVelocity()
	local zmax = self:OBBMaxs().z * 0.75
	for i,ammotype in ipairs(game.GetAmmoTypes()) do
		local ent = self:DropAmmoByType(string.lower(ammotype))
		if ent and ent:IsValid() then
			ent:SetPos(vPos + Vector(math.Rand(-16, 16), math.Rand(-16, 16), math.Rand(2, zmax)))
			ent:SetAngles(VectorRand():Angle())
			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then
				phys:AddAngleVelocity(Vector(math.Rand(-720, 720), math.Rand(-720, 720), math.Rand(-720, 720)))
				phys:ApplyForceCenter(phys:GetMass() * (math.Rand(32, 328) * VectorRand():GetNormalized() + vVel))
			end
		end
	end
end

function meta:RefillActiveWeapon()
	if not self:ActiveWeaponCanBeRefilled() then return end
	local wep = self:GetActiveWeapon()
	local ammotype = wep:GetPrimaryAmmoTypeString()
	local togive = wep.Primary.DefaultClip and wep.Primary.DefaultClip or GAMEMODE.AmmoResupply[ammotype] * 3 
	self:GiveAmmo(togive, ammotype)
end

-- Lets other players know about our maximum health.
meta.OldSetMaxHealth = FindMetaTable("Entity").SetMaxHealth
function meta:SetMaxHealth(num)
	num = math.ceil(num)
	self:SetDTInt(0, num)
	self:OldSetMaxHealth(num)
end

function meta:GetAimAccuracy()
	if self.ShotsFired and self.ShotsHit then
		if self.ShotsFired >= self.ShotsHit then
			return math.Round(100*self.ShotsHit/self.ShotsFired,1)
		else
			print("wtf how did he hit more shots than he shot")
			return -1
		end
	else
		return -1
	end
end

function meta:GetBounty()
	local mult = GAMEMODE:IsClassicMode() and 2 or 1
	if self.BountyModifier ~= nil then
		return math.max(GAMEMODE.PointsPerKill * mult + self.BountyModifier,1)
	else
		return GAMEMODE.PointsPerKill * mult
	end
end

function meta:PointCashOut(ent, fmtype)
	if self.m_PointQueue >= 1 and (self:Team() == TEAM_HUMAN or self:Team() == TEAM_BANDIT) then
		local points = math.floor(self.m_PointQueue)
		self.m_PointQueue = self.m_PointQueue - points

		self:AddPoints(points)
		self:FloatingScore(ent or self.m_LastDamageDealtPosition or vector_origin, "floatingscore", points, fmtype or FM_NONE)
	end
end

function meta:AddSamples(samples)
	self:SetSamples(self:GetSamples() + samples)
end

function meta:TakeSamples(samples)
	self:SetSamples(self:GetSamples() - samples)
end

function meta:AddPoints(points)
	--self:AddFrags(points)
	self:SetPoints(self:GetPoints() + points)
	self:SetFullPoints(self:GetFullPoints() + points)
	gamemode.Call("PlayerPointsAdded", self, points)
end

function meta:TakePoints(points)
	self:SetPoints(self:GetPoints() - points)
end

function meta:RefundPoints(points)
	self:SetFullPoints(math.max(self:GetPoints() + points,self:GetFullPoints()))
	self:SetPoints(self:GetPoints() + points)
end

function meta:CreateAmbience(class)
	class = "status_"..class

	for _, ent in pairs(ents.FindByClass(class)) do
		if ent:GetOwner() == self then return end
	end

	local ent = ents.Create(class)
	if ent:IsValid() then
		ent:SetPos(self:LocalToWorld(self:OBBCenter()))
		self[class] = ent
		ent:SetOwner(self)
		ent:SetParent(self)
		ent:Spawn()
	end
end

function meta:DoHulls()
	self:SetModelScale(DEFAULT_MODELSCALE, 0)
	self:ResetHull()
	self:SetViewOffset(DEFAULT_VIEW_OFFSET)
	self:SetViewOffsetDucked(DEFAULT_VIEW_OFFSET_DUCKED)
	self:SetStepSize(DEFAULT_STEP_SIZE)
	self:SetJumpPower(DEFAULT_JUMP_POWER)
	self:SetBloodColor(BLOOD_COLOR_RED)
	self:DrawShadow(true)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetMass(DEFAULT_MASS)
	end
	net.Start("zs_dohulls")
		net.WriteEntity(self)
	net.Broadcast()

	self:CollisionRulesChanged()
end

function meta:Redeem()
	gamemode.Call("PlayerRedeemed", self)
end

function meta:RedeemNextFrame()
	timer.Simple(0, function()
		if IsValid(self) then
			self:CheckRedeem(true)
		end
	end)
end
--[[
function meta:TakeBrains(amount)
	self:AddFrags(-amount)
	self.BrainsEaten = self.BrainsEaten - 1
end

function meta:AddBrains(amount)
	self:AddFrags(amount)
	self.BrainsEaten = self.BrainsEaten + 1
	self:CheckRedeem()
end

meta.GetBrains = meta.Frags
]]
--[[function meta:CheckRedeem(instant)
	if not self:IsValid() or self:Team() ~= TEAM_BANDIT
	or GAMEMODE:GetRedeemBrains() <= 0 or self:GetBrains() < GAMEMODE:GetRedeemBrains()
	or GAMEMODE.NoRedeeming or self.NoRedeeming or self:GetZombieClassTable().Boss then return end

	if GAMEMODE:GetWave() ~= GAMEMODE:GetNumberOfWaves() or not GAMEMODE.ObjectiveMap and GAMEMODE:GetNumberOfWaves() == 1 and CurTime() < GAMEMODE:GetWaveEnd() - 300 then
		if instant then
			self:Redeem()
		else
			self:RedeemNextFrame()
		end
	end
end]]

--[[function meta:GiveWeaponByType(weapon, plyr, ammo)
	if ammo then
		local wep = self:GetActiveWeapon()
		if not wep or not wep:IsValid() or not wep.Primary then return end

		local ammotype = wep:ValidPrimaryAmmo()
		local ammocount = wep:GetPrimaryAmmoCount()
		if ammotype and ammocount then
			local desiredgive = math.min(ammocount, math.ceil((GAMEMODE.AmmoResupply[ammotype] or wep.Primary.ClipSize) * 5))
			if desiredgive >= 1 then
				wep:TakeCombinedPrimaryAmmo(desiredgive)
				plyr:GiveAmmo(desiredgive, ammotype)

				self:PlayGiveAmmoSound()
				self:RestartGesture(ACT_GMOD_GESTURE_ITEM_GIVE)
			end
		end
	end

	local wep = self:GetActiveWeapon()
	if wep:IsValid() then
		local primary = wep:ValidPrimaryAmmo()
		if primary and 0 < wep:Clip1() then
			self:GiveAmmo(wep:Clip1(), primary, true)
			wep:SetClip1(0)
		end
		local secondary = wep:ValidSecondaryAmmo()
		if secondary and 0 < wep:Clip2() then
			self:GiveAmmo(wep:Clip2(), secondary, true)
			wep:SetClip2(0)
		end

		self:StripWeapon(weapon:GetClass())
		
		local wep2 = plyr:Give(weapon:GetClass())
		if wep2 and wep2:IsValid() then
			if wep2.Primary then
				local primary = wep2:ValidPrimaryAmmo()
				if primary then
					wep2:SetClip1(0)
					plyr:RemoveAmmo(math.max(0, wep2.Primary.DefaultClip - wep2.Primary.ClipSize), primary)
				end
			end
			if wep2.Secondary then
				local secondary = wep2:ValidSecondaryAmmo()
				if secondary then
					wep2:SetClip2(0)
					plyr:RemoveAmmo(math.max(0, wep2.Secondary.DefaultClip - wep2.Secondary.ClipSize), secondary)
				end
			end
		end
	end
end]]

function meta:Gib()
	local pos = self:WorldSpaceCenter()
	local headoffset = self:LocalToWorld(self:OBBMaxs()).z - pos.z

	local effectdata = EffectData()
		effectdata:SetEntity(self)
		effectdata:SetOrigin(pos)
	util.Effect("gib_player", effectdata, true, true)

	self.Gibbed = CurTime()

	timer.Simple(0, function() GAMEMODE:CreateGibs(pos, pos2) end)
end

function meta:GetLastAttacker()
	local ent = self.LastAttacker
	if ent and ent:IsValid() and CurTime() <= self.LastAttacked + 10 then
		return ent
	end
	--self:SetLastAttacker()
end

function meta:SetLastAttacker(ent)
	if ent then
		if ent ~= self then
			self.LastAttacker = ent
			self.LastAttacked = CurTime()
		end
	else
		self.LastAttacker = nil
		self.LastAttacked = nil
	end
end