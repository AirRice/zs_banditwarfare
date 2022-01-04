function player.GetAllActive()
	local t = {}

	for _, pl in pairs(player.GetAll()) do
		if not pl:IsSpectator() then
			t[#t + 1] = pl
		end
	end

	return t
end

function player.GetAllSpectators()
	local t = {}

	for _, pl in pairs(player.GetAll()) do
		if pl:IsSpectator() then
			t[#t + 1] = pl
		end
	end

	return t
end

function FindItembyClass(class)
	if not class then return end

	local t
	for i, tab in pairs(GAMEMODE.Items) do
		if tab.SWEP == class then
			t = tab
			break
		end
	end

	return t
end

function FindItem(id)
	if not id then return end

	local t

	local num = tonumber(id)
	if num then
		t = GAMEMODE.Items[num]
	else
		for i, tab in pairs(GAMEMODE.Items) do
			if tab.Signature == id then
				t = tab
				break
			end
		end
	end

	return t
end

function FindWeaponConsequents(id)
	if not id then return end
	local num = tonumber(id)
	if num then
		id = GAMEMODE.Items[num].Signature
	end

	local consequents = {}
	for _, tab in ipairs(GAMEMODE.Items) do
		if tab.Prerequisites and istable(tab.Prerequisites) then
			for _, prereqsig in ipairs(tab.Prerequisites) do
				if prereqsig == id then
					table.insert(consequents, tab)
					break
				end
			end
		end
	end
	return consequents
end

function FindWeaponPrerequisites(id)
	if not id then return end
	local num = tonumber(id)
	if num then
		id = GAMEMODE.Items[num].Signature
	end
	return tab.Prerequisites
end

function PlayerCanUpgradePointshopItem(pl,itemtab,slot)
	if not (pl and pl:IsPlayer()) then return end
	if not itemtab then return end	
	local owned = false
	if not GAMEMODE:IsClassicMode() and not (slot == WEAPONLOADOUT_NULL or not slot) then 
		owned = (itemtab.SWEP and pl:GetWeapon1() == itemtab.SWEP and slot == WEAPONLOADOUT_SLOT1)
		or (itemtab.SWEP and pl:GetWeapon2() == itemtab.SWEP and slot == WEAPONLOADOUT_SLOT2)
		or (itemtab.SWEP and pl:GetWeaponMelee() == itemtab.SWEP and slot == WEAPONLOADOUT_MELEE)
		or (itemtab.SWEP and pl:GetWeaponToolslot() == itemtab.SWEP and slot == WEAPONLOADOUT_TOOLS)
	else
		owned = (itemtab.SWEP and pl:HasWeapon(itemtab.SWEP))
	end
	local results = FindWeaponConsequents(itemtab.Signature)
	local hasnexttier = !table.IsEmpty(results)
	local hasprevtier = !table.IsEmpty(itemtab.Prerequisites)
	
	return owned and (hasnexttier or hasprevtier)
end

function PlayerCanPurchasePointshopItem(pl,itemtab,slot)
	if not (pl and pl:IsPlayer()) then return end
	if not itemtab then return end
	
	local cost = itemtab.Worth
	cost = math.floor(cost * ((GAMEMODE:IsClassicMode() and itemtab.Category ~= ITEMCAT_OTHER) and 0.75 or 1))
	local enoughcost = pl:GetPoints() >= cost
	local notduplicate = true
	if not GAMEMODE:IsClassicMode() and not (slot == WEAPONLOADOUT_NULL or not slot) then 
		notduplicate = not (itemtab.SWEP and pl:GetWeapon1() == itemtab.SWEP)
		and not (itemtab.SWEP and pl:GetWeapon2() == itemtab.SWEP)
		and not (itemtab.SWEP and pl:GetWeaponMelee() == itemtab.SWEP)
		and not (itemtab.SWEP and pl:GetWeaponToolslot() == itemtab.SWEP)
	else
		notduplicate = not (itemtab.SWEP and pl:HasWeapon(itemtab.SWEP))
		and not (itemtab.ControllerWep and pl:HasWeapon(itemtab.ControllerWep))
	end
	
	local fitformode = not (itemtab.NoClassicMode and GAMEMODE:IsClassicMode()) and 
	not (itemtab.NoSampleCollectMode and GAMEMODE:IsSampleCollectMode()) and 
	not (itemtab.SampleCollectModeOnly and not GAMEMODE:IsSampleCollectMode())
	
	local auxreason = not (itemtab.CanPurchaseFunc and !itemtab.CanPurchaseFunc(pl))
	
	local finalresult = enoughcost and notduplicate and fitformode and auxreason

	local refusepurchasereasons = ""
	if !auxreason then
		refusepurchasereasons = itemtab.FailTranslateString and translate.ClientGet(pl,itemtab.FailTranslateString) or translate.ClientGet(pl,"cant_purchase_right_now")
	elseif !fitformode then
		refusepurchasereasons = translate.ClientGet(pl,"cant_purchase_in_this_mode")
	elseif !notduplicate then 
		refusepurchasereasons = translate.ClientGet(pl,"already_have_weapon")
	elseif !enoughcost then 
		refusepurchasereasons = translate.ClientGet(pl,"dont_have_enough_points")
	end
	return finalresult, refusepurchasereasons
end

function TrueVisible(posa, posb, filter)
	local filt = ents.FindByClass("projectile_*")
	filt = table.Add(filt, player.GetAll())
	if filter then
		filt[#filt + 1] = filter
	end

	return not util.TraceLine({start = posa, endpos = posb, filter = filt, mask = MASK_SHOT}).Hit
end

function TrueVisibleFilters(posa, posb, ...)
	local filt = ents.FindByClass("projectile_*")
	filt = table.Add(filt, player.GetAll())
	if ... ~= nil then
		for k, v in pairs({...}) do
			filt[#filt + 1] = v
		end
	end

	return not util.TraceLine({start = posa, endpos = posb, filter = filt, mask = MASK_SHOT}).Hit
end

MASK_SHOT_OPAQUE = bit.bor(MASK_SHOT, CONTENTS_OPAQUE)
-- Literally if photon particles can reach point b from point a.
local LightVisibleTrace = {mask = MASK_SHOT_OPAQUE}
function LightVisible(posa, posb, ...)
	local filter
	if ... ~= nil then
		filter = {...}
	end

	LightVisibleTrace.start = posa
	LightVisibleTrace.endpos = posb
	LightVisibleTrace.filter = filter

	return not util.TraceLine(LightVisibleTrace).Hit
end

local WorldVisibleTrace = {mask = MASK_SOLID_BRUSHONLY}
function WorldVisible(posa, posb)
	WorldVisibleTrace.start = posa
	WorldVisibleTrace.endpos = posb
	return not util.TraceLine(WorldVisibleTrace).Hit
end

function ValidFunction(ent, funcname, ...)
	if ent and ent:IsValid() and ent[funcname] then
		return ent[funcname](ent, ...)
	end
end

function CosineInterpolation(y1, y2, mu)
	local mu2 = (1 - math.cos(mu * math.pi)) / 2
	return y1 * (1 - mu2) + y2 * mu2
end

function string.AndSeparate(list)
	local length = #list
	if length <= 0 then return "" end
	if length == 1 then return list[1] end
	if length == 2 then return list[1].." and "..list[2] end

	return table.concat(list, ", ", 1, length - 1)..", and "..list[length]
end

function util.SkewedDistance(a, b, skew)
	if a.z > b.z then
		return math.sqrt((b.x - a.x) ^ 2 + (b.y - a.y) ^ 2 + ((a.z - b.z) * skew) ^ 2)
	end

	return a:Distance(b)
end

function util.Blood(pos, amount, dir, force, noprediction)
	local effectdata = EffectData()
		effectdata:SetOrigin(pos)
		effectdata:SetMagnitude(amount)
		effectdata:SetNormal(dir)
		effectdata:SetScale(math.max(128, force))
	util.Effect("bloodstream", effectdata, nil, noprediction)
end

-- I had to make this since the default function checks visibility vs. the entitiy's center and not the nearest position.
function util.BlastDamageEx(inflictor, attacker, epicenter, radius, damage, damagetype)
	local filter = inflictor
	for _, ent in pairs(ents.FindInSphere(epicenter, radius)) do
		if ent and ent:IsValid() then
			local nearest = ent:NearestPoint(epicenter)
			local ratio = 1
			if nearest:Distance(epicenter) > radius/2 then
				ratio = 0.5+0.5*math.Clamp((nearest:Distance(epicenter)-radius/2)/radius*2 ,0,1)
			end
			if TrueVisibleFilters(epicenter, nearest, inflictor, ent) then
				ent:TakeSpecialDamage(ratio * damage, damagetype, attacker, inflictor, nearest)
			end
		end
	end
end

function util.BlastDamage2(inflictor, attacker, epicenter, radius, damage)
	util.BlastDamageEx(inflictor, attacker, epicenter, radius, damage, DMG_BLAST)
end

function util.BlastDamageShredding(inflictor, attacker, epicenter, radius, damage)
	local filter = inflictor
	for _, ent in pairs(ents.FindInSphere(epicenter, radius)) do
		if ent and ent:IsValid() then
			local nearest = ent:NearestPoint(epicenter)
			local ratio = 1
			if ent:GetClass() == "prop_drone" or ent:GetClass() == "prop_manhack" or (ent:IsNailed() and not ent:IsSameTeam(self.Owner)) or (ent.IsBarricadeObject and not ent:IsSameTeam(self.Owner)) then
				ratio = ratio * 10
			end
			if nearest:Distance(epicenter) > radius/2 then
				ratio = 0.5+0.5*math.Clamp((nearest:Distance(epicenter)-radius/2)/radius*2 ,0,1)
			end
			if TrueVisibleFilters(epicenter, nearest, inflictor, ent) then
				ent:TakeSpecialDamage(ratio * damage, DMG_BLAST, attacker, inflictor, nearest)
			end
		end
	end
end


function util.FindValidInSphere(pos, radius)
	local ret = {}
	
	for _, ent in pairs(util.FindInSphere(pos, radius)) do
		if ent and ent:IsValid() then
			ret[#ret + 1] = ent
		end
	end

	return ret
end

function util.PoisonBlastDamage(inflictor, attacker, epicenter, radius, damage, noreduce)
	local filter = inflictor
	for _, ent in pairs(ents.FindInSphere(epicenter, radius)) do
		if ent and ent:IsValid() then
			local nearest = ent:NearestPoint(epicenter)
			if TrueVisibleFilters(epicenter, nearest, inflictor, ent) then
				ent:PoisonDamage(((radius - nearest:Distance(epicenter)) / radius) * damage, attacker, inflictor, nil, noreduce)
			end
		end
	end
end

function util.ToMinutesSeconds(seconds)
	local minutes = math.floor(seconds / 60)
	seconds = seconds - minutes * 60

    return string.format("%02d:%02d", minutes, math.floor(seconds))
end

function util.ToMinutesSecondsMilliseconds(seconds)
	local minutes = math.floor(seconds / 60)
	seconds = seconds - minutes * 60

	local milliseconds = math.floor(seconds % 1 * 100)

    return string.format("%02d:%02d.%02d", minutes, math.floor(seconds), milliseconds)
end

function util.RemoveAll(class)
	for _, ent in pairs(ents.FindByClass(class)) do
		ent:Remove()
	end
end

local function TooNear(spawn, tab, dist)
	local spawnpos = spawn:GetPos()
	for _, ent in pairs(tab) do
		if ent:GetPos():Distance(spawnpos) <= dist then
			return true
		end
	end

	return false
end
function team.GetSpawnPointGrouped(teamid, dist)
	dist = dist or 200

	local tab = {}
	local spawns = team.GetSpawnPoint(teamid)

	for _, spawn in pairs(spawns) do
		if not TooNear(spawn, tab, dist) then
			table.insert(tab, spawn)
		end
	end

	return tab
end

function AccessorFuncDT(tab, membername, type, id)
	local emeta = FindMetaTable("Entity")
	local setter = emeta["SetDT"..type]
	local getter = emeta["GetDT"..type]

	tab["Set"..membername] = function(me, val)
		setter(me, id, val)
	end

	tab["Get"..membername] = function(me)
		return getter(me, id)
	end
end

function team.GetValidSpawnPoint(teamid)
	local t = {}

	local spawns = team.GetSpawnPoint(teamid)
	if spawns then
		for _, ent in pairs(spawns) do
			if ent:IsValid() then
				t[#t + 1] = ent
			end
		end
	end

	return t
end

function timer.SimpleEx(delay, action, ...)
	if ... == nil then
		timer.Simple(delay, action)
	else
		local a, b, c, d, e, f, g, h, i, j, k = ...
		timer.Simple(delay, function() action(a, b, c, d, e, f, g, h, i, j, k) end)
	end
end

function timer.CreateEx(timername, delay, repeats, action, ...)
	if ... == nil then
		timer.Create(timername, delay, repeats, action)
	else
		local a, b, c, d, e, f, g, h, i, j, k = ...
		timer.Create(timername, delay, repeats, function() action(a, b, c, d, e, f, g, h, i, j, k) end)
	end
end

function table.ShuffleOrder(t)
  local tbl = {}
  for i = 1, #t do
    tbl[i] = t[i]
  end
  for i = #tbl, 2, -1 do
    local j = math.random(i)
    tbl[i], tbl[j] = tbl[j], tbl[i]
  end
  return tbl
end

function ents.CreateLimited(class, limit)
	if #ents.FindByClass(class) >= (limit or 200) then return NULL end

	return ents.Create(class)
end

function tonumbersafe(a)
	local n = tonumber(a)

	if n then
		if n == 0 or n < 0 or n > 0 then
			return n
		end

		-- NaN!
		return 0
	end

	return nil
end
