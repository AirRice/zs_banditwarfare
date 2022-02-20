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

function IsValidRoundMode(mode)
	if mode == ROUNDMODE_TRANSMISSION or mode == ROUNDMODE_SAMPLES or mode == ROUNDMODE_CLASSIC then
		return true
	end
	return false
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
					table.insert(consequents, tab.Signature)
					break
				end
			end
		end
	end
	return consequents
end

function FindWeaponPrerequisites(id)
	if not id then return {} end
	local num = tonumber(id)
	if num then
		id = GAMEMODE.Items[num].Signature
	end
	local tab = FindItem(id)
	if not tab then return {} end
	return tab.Prerequisites
end

function PlayerCanPurchasePointshopUpgradeItem(pl,originaltab,itemtab,slot,revertmode)
	if not (pl and pl:IsPlayer()) then return end
	if not itemtab or not originaltab then return end
	local upgradeable, upgradereasons = PlayerCanUpgradePointshopItem(pl,originaltab,slot)
	if not upgradeable then
		return false, upgradereasons
	else
		local normalpurchase, reasons = PlayerCanPurchasePointshopItem(pl,itemtab,slot,revertmode)
		if normalpurchase then
			local isupgradetreeorder = false
			local prevs = {}
			if revertmode then
				prevs = originaltab.Prerequisites
				isupgradetreeorder = (prevs and istable(prevs) and !table.IsEmpty(prevs) and itemtab.Signature and table.HasValue(prevs,itemtab.Signature))
			else
				prevs = itemtab.Prerequisites
				isupgradetreeorder = (prevs and istable(prevs) and !table.IsEmpty(prevs) and originaltab.Signature and table.HasValue(prevs,originaltab.Signature))
			end
			local invalidreason = isupgradetreeorder and "" or translate.ClientGet(pl,"cant_purchase_right_now")
			return isupgradetreeorder, invalidreason
		else
			return false, reasons
		end
	end
end

function PlayerCanUpgradePointshopItem(pl,itemtab,slot)
	if not (pl and pl:IsPlayer()) then return end
	if not itemtab then return end	
	local owned = false
	if not GAMEMODE:IsClassicMode() and not (slot == WEAPONLOADOUT_NULL or not slot) then 
		owned = (itemtab.SWEP and pl:GetWeaponLoadoutBySlot(slot) == itemtab.SWEP)
	else
		owned = (itemtab.SWEP and pl:HasWeapon(itemtab.SWEP))
	end
	local results = FindWeaponConsequents(itemtab.Signature)
	local hasnexttier = !table.IsEmpty(results)
	local hasprevtier = !table.IsEmpty(itemtab.Prerequisites)
	
	local finalresult = owned and (hasnexttier or hasprevtier)
	local refuseupgradereasons = ""
	if !owned then
		refuseupgradereasons = translate.ClientGet(pl,"dont_own_prerequisite")
	end
	
	return finalresult,refuseupgradereasons
end

function GetItemCost(itemtab)
	if not itemtab then return nil end
	local cost = itemtab.Worth
	local cat = itemtab.Category
	if not (cost and cat) then return nil end
	cost = math.floor(cost * ((GAMEMODE:IsClassicMode() and cat ~= ITEMCAT_OTHER) and GAMEMODE.ClassicModeDiscountMultiplier or 1))
	return cost
end

function PlayerCanPurchasePointshopItem(pl,itemtab,slot,ignorecost)
	if not (pl and pl:IsPlayer()) then return end
	if not itemtab then return end
	local cost = GetItemCost(itemtab)
	local enoughcost = pl:GetPoints() >= cost or ignorecost
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

local weaponfeatures = {
	{"WalkSpeed", "stat_walkspeed"},
	{"MeleeDamage", "stat_meleedmg",1},
	{"MeleeRange", "stat_meleerange"},

	{"ClipSize", "stat_clipsize", 1, "Primary"},
	{"DefaultClip", "stat_defaultgiven", 1, "Primary"},
	{"Damage", "stat_gundmg", 1, "Primary"},
	{"NumShots", "stat_numshots", 1, "Primary"},
	{"Delay", "stat_firedelay", 0.001, "Primary"}
}

function GetWeaponFeatures(swep)
	if not swep then return end
	local sweptable = weapons.Get(swep)
	if not sweptable then return end
	
	local output = {}
	for i, featuretab in ipairs(weaponfeatures) do
		local touse
		if featuretab[4] then
			touse = sweptable[ featuretab[4] ]
		else
			touse = sweptable
		end
		local value = touse[ featuretab[1] ]
		if value and value > 0 then
			table.insert(output,{featuretab[2],value})
		end
	end
	return output
end

function TrueVisible(posa, posb, filter)
	local filt = ents.FindByClass("projectile_*")
	filt = table.Add(filt, player.GetAll())
	if filter then
		filt[#filt + 1] = filter
	end

	return not util.TraceLine({start = posa, endpos = posb, filter = filt, mask = MASK_SHOT}).Hit
end

function util.DoBulletEffects(shooter,wep,bullet_tr,tracername,dmg,hitwater,waterpos,waternormal,slime,recipientfilter)
	if not (shooter and IsValid(shooter) and shooter:IsPlayer()) then return end
	if not (wep and IsValid(wep) and wep:IsWeapon()) then return end
	if not bullet_tr then return end
	
	local ent = bullet_tr.Entity
	if IsFirstTimePredicted() then
		local effectdata = EffectData()
		effectdata:SetOrigin(bullet_tr.HitPos)
		effectdata:SetStart(shooter:GetShootPos())
		effectdata:SetNormal(bullet_tr.HitNormal)
		if hitwater then
			-- We may not impact, but we DO need to affect ragdolls on the client
			util.Effect("RagdollImpact", effectdata,true,recipientfilter)
			local edata = EffectData()
			edata:SetOrigin(waterpos)
			edata:SetNormal(waternormal)
			edata:SetScale(math.Clamp(dmg * 0.25, 5, 30))
			edata:SetFlags(slime)
			util.Effect("gunshotsplash", edata, true, recipientfilter)
		elseif not bullet_tr.HitSky and bullet_tr.Fraction < 1 then
			effectdata:SetSurfaceProp(bullet_tr.SurfaceProps)
			effectdata:SetDamageType(DMG_BULLET)
			effectdata:SetHitBox(bullet_tr.HitBox)
			effectdata:SetEntity(ent)
			util.Effect("Impact", effectdata, true, recipientfilter)
		end
		
		if ent and ent:IsValid() and ent:IsPlayer() then
			effectdata:SetColor(0)
			effectdata:SetScale(dmg)
			util.Effect("BloodImpact", effectdata, true, recipientfilter)
		end
		
		if shooter:IsPlayer() and wep:IsValid() then
			effectdata:SetFlags( 0x0003 ) --TRACER_FLAG_USEATTACHMENT + TRACER_FLAG_WHIZ
			effectdata:SetEntity(wep)
			effectdata:SetAttachment(1)
		else
			effectdata:SetEntity(shooter)
			effectdata:SetFlags( 0x0001 ) -- TRACER_FLAG_WHIZ
		end
		effectdata:SetScale(5000) -- Tracer travel speed
		util.Effect(tracername or "Tracer", effectdata, true, recipientfilter)
	end
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

function CircularGaussianSpread(vecDir, vecSpread)
	local x, y, z;
	
	local flatness = 0.5

	repeat
		x = math.Rand(-1,1) * flatness + math.Rand(-1,1) * (1 - flatness);
		y = math.Rand(-1,1) * flatness + math.Rand(-1,1) * (1 - flatness);
		z = x*x+y*y;
	until z <= 1
	local vecRight = vecDir:Angle():Right()
	local vecUp = vecDir:Angle():Up()
	vecResult = vecDir + x * vecSpread.x * vecRight + y * vecSpread.y * vecUp;

	return vecResult;
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
			if ent:GetClass() == "prop_drone" or ent:GetClass() == "prop_manhack" or (ent:IsNailed() and not ent:IsSameTeam(attacker)) or (ent.IsBarricadeObject and not ent:IsSameTeam(attacker)) then
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
	
	for _, ent in pairs(ents.FindInSphere(pos, radius)) do
		if ent and ent:IsValid() then
			ret[#ret + 1] = ent
		end
	end

	return ret
end

function util.FindInSphereBiasZ(pos, radius, zmult)
	local ret = {}
	zmult = zmult or 1
	for _, ent in pairs(ents.FindInSphere(pos, radius)) do
		local entpos = ent:GetPos()
		if math.abs(entpos.z - pos.z) <= radius*zmult then
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
