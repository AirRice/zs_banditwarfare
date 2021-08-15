CreateConVar("zsb_roundgamemode", "0", FCVAR_ARCHIVE, "Gamemode for the round. 0 = Transmission mode, 1 = Collection mode, 2 = kill everyone to win mode.")
cvars.AddChangeCallback("zsb_roundgamemode", function(cvar, oldvalue, newvalue)
	if tonumber(newvalue) == 0 or tonumber(newvalue) == 1 or tonumber(newvalue) == 2 then
		SetGlobalInt("roundgamemode",tonumber(newvalue))
	else
		SetGlobalInt("roundgamemode",0)
	end
end)

GM.GibLifeTime = CreateConVar("zs_giblifetime", "25", FCVAR_ARCHIVE, "Specifies how many seconds player gibs will stay in the world if not eaten or destroyed."):GetFloat()
cvars.AddChangeCallback("zs_giblifetime", function(cvar, oldvalue, newvalue)
	GAMEMODE.GibLifeTime = tonumber(newvalue) or 1
end)

GM.MaxPropsInBarricade = CreateConVar("zs_maxpropsinbarricade", "8", FCVAR_ARCHIVE + FCVAR_NOTIFY, "Limits the amount of props that can be in one 'contraption' of nails."):GetInt()
cvars.AddChangeCallback("zs_maxpropsinbarricade", function(cvar, oldvalue, newvalue)
	GAMEMODE.MaxPropsInBarricade = tonumber(newvalue) or 8
end)

GM.MaxDroppedItems = CreateConVar("zs_maxdroppeditems", "128", FCVAR_ARCHIVE + FCVAR_NOTIFY, "Maximum amount of dropped items. Prevents spam or lag when lots of people die."):GetInt()
cvars.AddChangeCallback("zs_maxdroppeditems", function(cvar, oldvalue, newvalue)
	GAMEMODE.MaxDroppedItems = tonumber(newvalue) or 128
end)

GM.NailHealthPerRepair = CreateConVar("zs_nailhealthperrepair", "40", FCVAR_ARCHIVE + FCVAR_NOTIFY, "How much health a nail gets when being repaired."):GetInt()
cvars.AddChangeCallback("zs_nailhealthperrepair", function(cvar, oldvalue, newvalue)
	GAMEMODE.NailHealthPerRepair = tonumber(newvalue) or 1
end)

GM.NoPropDamageFromHumanMelee = CreateConVar("zs_nopropdamagefromhumanmelee", "1", FCVAR_ARCHIVE + FCVAR_NOTIFY, "Melee from humans doesn't damage props."):GetBool()
cvars.AddChangeCallback("zs_nopropdamagefromhumanmelee", function(cvar, oldvalue, newvalue)
	GAMEMODE.NoPropDamageFromHumanMelee = tonumber(newvalue) == 1
end)

GM.MedkitPointsPerHealth = 5

GM.RepairPointsPerHealth = 40

local function GetMostKey(key, top)
	if toppl and top > 0 then
		return toppl, top
	end
	local top = 0
	local toppl
	for _, pl in pairs(player.GetAll()) do
		if pl[key] and pl[key] > top then
			top = pl[key]
			toppl = pl
		end
	end
	if toppl and top >= 1 then
		return toppl, math.ceil(top)
	end
end

local function GetMostFunc(func, top)
	top = top or 0
	local toppl
	for _, pl in pairs(player.GetAll()) do
		local amount = pl[func](pl)
		if amount > top then
			top = amount
			toppl = pl
		end
	end

	if toppl and top > 0 then
		return toppl, top
	end
end

GM.HonorableMentions[HM_MOSTENEMYKILLED].GetPlayer = function(self)
	local pl, mag = GetMostFunc("Frags")
	return pl, mag
end

GM.HonorableMentions[HM_MOSTDAMAGETOENEMY].GetPlayer = function(self)
	local top = 0
	local toppl
	for _, pl in pairs(player.GetAll()) do
		if pl.DamageDealt and pl.DamageDealt > top then
			top = pl.DamageDealt
			toppl = pl
		end
	end

	if toppl and top >= 1 then
		return toppl, math.ceil(top)
	end
end

GM.HonorableMentions[HM_PACIFIST].GetPlayer = function(self)
	for _, pl in pairs(player.GetAll()) do
		if pl:Frags() == 0 and not pl:IsSpectator() then return pl end
	end
end

GM.HonorableMentions[HM_MOSTHELPFUL].GetPlayer = function(self)
	return GetMostKey("EnemyKilledAssists")
end

GM.HonorableMentions[HM_USEFULTOOPPOSITE].GetPlayer = function(self)
	local pl, mag = GetMostFunc("Deaths")
	if mag and mag >= 10 then
		return pl, mag
	end
end

GM.HonorableMentions[HM_BLACKCOW].GetPlayer = function(self)
	local pl, amount = GetMostKey("PointsSpent")
	if pl and amount then
		return pl, math.ceil(amount)
	end
end

GM.HonorableMentions[HM_HACKER].GetPlayer = function(self)
	local pl, amount = GetMostKey("BackdoorsUsed")
	if pl and amount then
		return pl, math.ceil(amount)
	end
end

GM.HonorableMentions[HM_COMMSUNIT].GetPlayer = function(self)
	local top = 0
	local toppl
	for _, pl in pairs(player.GetAll()) do
		if pl.TimeCapping and pl.TimeCapping > top then
			top = pl.TimeCapping
			toppl = pl
		end
	end

	if toppl and top >= 1 then
		return toppl, math.ceil(top)
	end
end

GM.HonorableMentions[HM_GOODDOCTOR].GetPlayer = function(self)
	local pl, amount = GetMostKey("HealedThisRound")
	if pl and amount then
		return pl, math.ceil(amount)
	end
end

GM.HonorableMentions[HM_HANDYMAN].GetPlayer = function(self)
	local pl, amount = GetMostKey("RepairedThisRound")
	if pl and amount then
		return pl, math.ceil(amount)
	end
end

GM.HonorableMentions[HM_BARRICADEDESTROYER].GetPlayer = function(self)
	return GetMostKey("BarricadeDamage")
end


GM.HonorableMentions[HM_KILLSTREAK].GetPlayer = function(self)
	local pl, amount = GetMostKey("HighestLifeEnemyKills")
	if pl and amount and amount >= 4 then
		return pl, amount
	end
end

GM.HonorableMentions[HM_WARRIOR].GetPlayer = function(self)
	local pl, amount = GetMostKey("MeleeKilled")
	if pl and amount and amount >= 3 then
		return pl, amount
	end
end

GM.HonorableMentions[HM_HEADSHOTS].GetPlayer = function(self)
	local pl, amount = GetMostKey("HeadshotKilled")
	if pl and amount and amount >= 3 then
		return pl, amount
	end
end

GM.HonorableMentions[HM_BESTAIM].GetPlayer = function(self)
	local pl, mag = GetMostFunc("GetAimAccuracy")
	if mag and mag >= 10 then
		return pl, mag
	end
end
