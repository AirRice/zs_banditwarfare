GM.Name		=	"ZS:밴딧 워페어"
GM.Author	=	"Jooho \"air rice\" Lee"
GM.Email	=	""
GM.Website	=	""

-- No, adding a gun doesn't make your name worth being here.
GM.Credits = {
	{"William \"JetBoom\" Moodhe", "williammoodhe@gmail.com (www.noxiousnet.com)", "Original Mod Creator / Programmer"},
	{"11k", "tjd113@gmail.com", "Zombie view models"},
	{"Eisiger", "k2deseve@gmail.com", "Zombie kill icons"},
	{"Austin \"Little Nemo\" Killey", "austin_odyssey@yahoo.com", "Ambient music"},
	{"Zombie Panic: Source", "http://www.zombiepanic.org/", "Melee weapon sounds"},
	{"Samuel", "samuel_games@hotmail.com", "Board Kit model"},
	{"Typhon", "lukas-tinel@hotmail.com", "HUD textures"},
	{"Jooho 'air rice' Lee", "", "ZS:Bandit Warfare Programmer"},
	{"honsal", "", "Korean translation"}
}

include("nixthelag.lua")
include("buffthefps.lua")

function GM:GetNumberOfWaves()
	local default = self.NumberOfWaves
	local num = GetGlobalInt("numwaves", default) -- This is controlled by logic_waves.
	return num == -2 and default or num
end

function GM:GetWaveOneLength()
	return self.WaveOneLength
end

include("sh_translate.lua")
include("sh_colors.lua")
include("sh_serialization.lua")

include("sh_globals.lua")
include("sh_crafts.lua")
include("sh_util.lua")
include("sh_options.lua")
include("sh_animations.lua")
include("sh_channel.lua")

include("noxapi/noxapi.lua")

include("obj_vector_extend.lua")
include("obj_entity_extend.lua")
include("obj_player_extend.lua")
include("obj_weapon_extend.lua")

include("workshopfix.lua")

----------------------

GM.EndRound = false
GM.StartingWorth = 100
GM.BoughtEquipment = {}

team.SetUp(TEAM_BANDIT, "Bandits", Color(255, 160, 0, 255))
team.SetUp(TEAM_SURVIVORS, "Survivors", Color(0, 160, 255, 255))

local validmodels = player_manager.AllValidModels()
validmodels["tf01"] = nil
validmodels["tf02"] = nil

vector_tiny = Vector(0.001, 0.001, 0.001)

-- ogg/mp3 still doesn't work with SoundDuration() function
GM.SoundDuration = {
	["zombiesurvival/music_win.ogg"] = 33.149,
	["zombiesurvival/music_lose.ogg"] = 45.714,
	["zombiesurvival/lasthuman.ogg"] = 120.503,
	["music/HL2_song29.mp3"] = 136,
	["music/HL2_song20_submix0.mp3"] = 104,
	--["music/HL2_song15.mp3"] = 70,
	["music/HL2_song14.mp3"] = 160,
	--["music/HL2_song4.mp3"] = 66,
	--["music/HL2_song3.mp3"] = 91,
	["music/HL1_song15.mp3"] = 121,
	["music/HL1_song10.mp3"] = 105,
	["music/vlvx_song18.mp3"] = 185,
	["music/vlvx_song21.mp3"] = 170,
	["music/VLVX_song22.mp3"] = 194,
	["music/VLVX_song23.mp3"] = 167,
	["music/VLVX_song24.mp3"] = 128,
	["music/VLVX_song27.mp3"] = 210,
	["music/VLVX_song28.mp3"] = 193
}

function GM:AddCustomAmmo()
	game.AddAmmoType({name = "pulse"})
	game.AddAmmoType({name = "stone"})

	game.AddAmmoType({name = "spotlamp"})
	game.AddAmmoType({name = "manhack"})
	game.AddAmmoType({name = "manhack_saw"})
	game.AddAmmoType({name = "drone"})

	game.AddAmmoType({name = "dummy"})
	game.AddAmmoType({name = "grenlauncher"})
	game.AddAmmoType({name = "m249"})
	
	game.AddAmmoType({name = "twister"})
end

function GM:CanRemoveOthersNail(pl, nailowner, ent)
	local plpoints = pl:Frags()
	local ownerpoints = nailowner:Frags()
	if plpoints >= 75 or ownerpoints < 75 then return true end

	pl:PrintTranslatedMessage(HUD_PRINTCENTER, "cant_remove_nails_of_superior_player")

	return false
end


function GM:SetComms(bamount,hamount)
	SetGlobalInt("banditcomms", bamount)
	SetGlobalInt("humancomms", hamount)
end

function GM:AddComms(bamount,hamount)
	horiginal = self:GetHumanComms()
	boriginal = self:GetBanditComms()
	SetGlobalInt("banditcomms", boriginal+bamount)
	SetGlobalInt("humancomms", horiginal+hamount)
end

function GM:GetHumanComms()
	return GetGlobalInt("humancomms", 0)
end

function GM:GetBanditComms()
	return GetGlobalInt("banditcomms", 0)
end


function GM:SetRedeemBrains(amount)
	SetGlobalInt("redeembrains", amount)
end

function GM:GetRedeemBrains()
	return GetGlobalInt("redeembrains", self.DefaultRedeem)
end

function GM:PlayerIsAdmin(pl)
	return pl:IsAdmin()
end

function GM:GetFallDamage(pl, fallspeed)
	return 0
end

function GM:ShouldRestartRound()
	if self.RoundLimit == -1 then return true end

	local roundlimit = self.RoundLimit

	if roundlimit > 0 and self.CurrentRound >= roundlimit then return false end

	return true
end

function GM:SetDynamicSpawning(onoff)
	SetGlobalBool("DynamicSpawningDisabled", not onoff)
	self.DynamicSpawning = onoff
end

function GM:ValidMenuLockOnTarget(pl, ent)
	if ent and ent:IsValid() and ent:IsPlayer() and ent:Team() == pl:Team() and ent:Alive() then
		local startpos = pl:EyePos()
		local endpos = ent:NearestPoint(startpos)
		if startpos:Distance(endpos) <= 48 and TrueVisible(startpos, endpos) then
			return true
		end
	end

	return false
end

function GM:GetHandsModel(pl)
	return player_manager.TranslatePlayerHands(pl:GetInfo("cl_playermodel"))
end

local playerheight = Vector(0, 0, 72)
local playermins = Vector(-17, -17, 0)
local playermaxs = Vector(17, 17, 4)
local SkewedDistance = util.SkewedDistance

GM.DynamicSpawnDistVisOld = 2048
GM.DynamicSpawnDistOld = 640
function GM:DynamicSpawnIsValidOld(zombie, humans, allplayers)
	-- I didn't make this check where trigger_hurt entities are. Rather I made it check the time since the last time you were hit with a trigger_hurt.
	-- I'm not sure if it's possible to check if a trigger_hurt is enabled or disabled through the Lua bindings.
	if SERVER and zombie.LastHitWithTriggerHurt and CurTime() < zombie.LastHitWithTriggerHurt + 2 then
		return false
	end

	-- Optional caching for these.
	if not humans then humans = team.GetPlayers(TEAM_HUMAN) end
	if not allplayers then allplayers = player.GetAll() end

	local pos = zombie:GetPos() + Vector(0, 0, 1)
	if zombie:Alive() and zombie:GetMoveType() == MOVETYPE_WALK and zombie:OnGround()
	and not util.TraceHull({start = pos, endpos = pos + playerheight, mins = playermins, maxs = playermaxs, mask = MASK_SOLID, filter = allplayers}).Hit then
		local vtr = util.TraceHull({start = pos, endpos = pos - playerheight, mins = playermins, maxs = playermaxs, mask = MASK_SOLID_BRUSHONLY})
		if not vtr.HitSky and not vtr.HitNoDraw then
			local valid = true

			for _, human in pairs(humans) do
				local hpos = human:GetPos()
				local nearest = zombie:NearestPoint(hpos)
				local dist = SkewedDistance(hpos, nearest, 2.75) -- We make it so that the Z distance between a human and a zombie is skewed if the zombie is below the human.
				if dist <= self.DynamicSpawnDistOld or dist <= self.DynamicSpawnDistVisOld and WorldVisible(hpos, nearest) then -- Zombies can't be in radius of any humans. Zombies can't be clearly visible by any humans.
					valid = false
					break
				end
			end

			return valid
		end
	end

	return false
end

function GM:GetEndRound()
	return self.RoundEnded
end

function GM:PrecacheResources()
	util.PrecacheSound("physics/body/body_medium_break2.wav")
	util.PrecacheSound("physics/body/body_medium_break3.wav")
	util.PrecacheSound("physics/body/body_medium_break4.wav")
	for name, mdl in pairs(player_manager.AllValidModels()) do
		util.PrecacheModel(mdl)
	end
end

function GM:ShouldCollide(enta, entb)
	if enta.ShouldNotCollide and enta:ShouldNotCollide(entb) or entb.ShouldNotCollide and entb:ShouldNotCollide(enta) then
		return false
	end

	return true
end

function GM:Move(pl, move)
	if pl:Team() == TEAM_HUMAN or pl:Team() == TEAM_BANDIT then
		if pl:GetBarricadeGhosting() then
			move:SetMaxSpeed(36)
			move:SetMaxClientSpeed(36)
		elseif move:GetForwardSpeed() < 0 then
			move:SetMaxSpeed(move:GetMaxSpeed() * 0.5)
			move:SetMaxClientSpeed(move:GetMaxClientSpeed() * 0.5)
		elseif move:GetForwardSpeed() == 0 then
			move:SetMaxSpeed(move:GetMaxSpeed() * 0.85)
			move:SetMaxClientSpeed(move:GetMaxClientSpeed() * 0.85)
		end
	end

	local legdamage = pl:GetLegDamage()
	if legdamage > 0 then
		local scale = 1 - math.min(1, legdamage * 0.33)
		move:SetMaxSpeed(move:GetMaxSpeed() * scale)
		move:SetMaxClientSpeed(move:GetMaxClientSpeed() * scale)
	end
end

function GM:OnPlayerHitGround(pl, inwater, hitfloater, speed)
	if inwater then return true end
	if SERVER then
		pl:PreventSkyCade()
	end
	local mul = 1
	if pl.BuffStrongShoes then
		mul = 0.75
	end
	pl:SetVelocity(- pl:GetVelocity() / 2)
	local damage = (0.1 * (speed - 525)) ^ 1.45
	damage = damage * mul
	if hitfloater then damage = damage / 2 end
	if math.floor(damage) > 0 then
		if SERVER then
			if damage >= 30 and damage < pl:Health() then
				pl:KnockDown(damage * 0.05*mul)
			end
			pl:TakeSpecialDamage(damage, DMG_FALL, game.GetWorld(), game.GetWorld(), pl:GetPos())
			pl:EmitSound("player/pl_fallpain"..(math.random(2) == 1 and 3 or 1)..".wav")
		end
	end

	return true
end

function GM:PlayerCanBeHealed(pl)
	return true
end

function GM:PlayerCanPurchase(pl)
	return (pl:Team() == TEAM_HUMAN or pl:Team() == TEAM_BANDIT) and pl:Alive() --and not self:GetWaveActive() and pl:NearArsenalCrate()
end

local TEAM_SPECTATOR = TEAM_SPECTATOR
function GM:PlayerCanHearPlayersVoice(listener, talker)
	return true
end

function GM:PlayerTraceAttack(pl, dmginfo, dir, trace)
end

function GM:ScalePlayerDamage(pl, hitgroup, dmginfo)
	if hitgroup == HITGROUP_HEAD and dmginfo:IsBulletDamage() then
		pl.m_LastHeadShot = CurTime()
	end
	
	if dmginfo:GetAttacker():IsPlayer() then
		local enemyteam = (dmginfo:GetAttacker():Team() == TEAM_HUMAN and TEAM_BANDIT or TEAM_HUMAN)
		if #team.GetPlayers(enemyteam) > #team.GetPlayers(dmginfo:GetAttacker():Team()) then
			dmginfo:SetDamage(dmginfo:GetDamage() * 1.2)
		end
	end
	if hitgroup == HITGROUP_HEAD then
		dmginfo:SetDamage(dmginfo:GetDamage() * 1.5)
	elseif hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG or hitgroup == HITGROUP_GEAR then
		dmginfo:SetDamage(dmginfo:GetDamage() * 0.5)
	elseif hitgroup == HITGROUP_STOMACH or hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM then
		dmginfo:SetDamage(dmginfo:GetDamage() )
	end

	if SERVER and (hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG) and self:PlayerShouldTakeDamage(pl, dmginfo:GetAttacker()) then
		pl:AddLegDamage(dmginfo:GetDamage()/2)
	end
end

function GM:CanDamageNail(ent, attacker, inflictor, damage, dmginfo)
	return (attacker:IsPlayer() and not ent:IsSameTeam(attacker))
end

function GM:CanPlaceNail(pl, tr)
	return true
end

function GM:CanRemoveNail(pl, nail)
	if nail.m_NailUnremovable then 
		return false 
	else
		return true
	end
end

function GM:FindUseEntity(pl, ent)
	if not ent:IsValid() then
		local e = pl:TraceLine(90, MASK_SOLID, pl:GetMeleeFilter()).Entity
		if e:IsValid() then return e end
	end

	return ent
end

function GM:ShouldUseAlternateDynamicSpawn()
	return false
end

local temppos
local function SortByDistance(a, b)
	return a:GetPos():Distance(temppos) < b:GetPos():Distance(temppos)
end

function GM:GetClosestSpawnPoint(teamid, pos)
	temppos = pos
	local spawnpoints
	if type(teamid) == "table" then
		spawnpoints = teamid
	else
		spawnpoints = team.GetValidSpawnPoint(teamid)
	end
	table.sort(spawnpoints, SortByDistance)
	return spawnpoints[1]
end

local FEAR_RANGE = 768
local FEAR_PERINSTANCE = 0.075
local RALLYPOINT_THRESHOLD = 0.3

local function GetEpicenter(tab)
	local vec = Vector(0, 0, 0)
	if #tab == 0 then return vec end

	for k, v in pairs(tab) do
		vec = vec + v:GetPos()
	end

	return vec / #tab
end

function GM:GetTeamRallyGroups(teamid)
	local groups = {}
	local ingroup = {}

	local plys = team.GetPlayers(teamid)

	for _, pl in pairs(plys) do
		if not ingroup[pl] and pl:Alive() then
			local plpos = pl:GetPos()
			local group = {pl}

			for __, otherpl in pairs(plys) do
				if otherpl ~= pl and not ingroup[otherpl] and otherpl:Alive() then
					group[#group + 1] = otherpl
				end
			end

			if #group * FEAR_PERINSTANCE >= RALLYPOINT_THRESHOLD then
				for k, v in pairs(group) do
					ingroup[v] = true
				end
				groups[#groups + 1] = group
			end
		end
	end

	return groups
end

function GM:GetTeamRallyPoints(teamid)
	local points = {}

	for _, group in pairs(self:GetTeamRallyGroups(teamid)) do
		points[#points + 1] = {GetEpicenter(group), math.min(1, (#group * FEAR_PERINSTANCE - RALLYPOINT_THRESHOLD) / (1 - RALLYPOINT_THRESHOLD))}
	end

	return points
end

local CachedEpicentreTimes = {}
local CachedEpicentres = {}
function GM:GetTeamEpicentre(teamid, nocache)
	if not nocache and CachedEpicentres[teamid] and CurTime() < CachedEpicentreTimes[teamid] then
		return CachedEpicentres[teamid]
	end

	local plys = team.GetPlayers(teamid)
	local vVec = Vector(0, 0, 0)
	for _, pl in pairs(plys) do
		if pl:Alive() then
			vVec = vVec + pl:GetPos()
		end
	end

	local epicentre = vVec / #plys
	if not nocache then
		CachedEpicentreTimes[teamid] = CurTime() + 0.5
		CachedEpicentres[teamid] = epicentre
	end

	return epicentre
end
GM.GetTeamEpicenter = GM.GetTeamEpicentre

function GM:GetCurrentEquipmentCount(id,countteam)
	local count = 0

	local item = self.Items[id]
	if item then
		if item.Countables then
			if type(item.Countables) == "table" then
				for k, v in pairs(item.Countables) do
					count = count + #ents.FindByClass(v)
				end
			else
				count = count + #ents.FindByClass(item.Countables)
			end
		end

		if item.SWEP then
			for k,v in pairs(ents.FindByClass(item.SWEP)) do
				if v.Owner:IsPlayer() and v.Owner:Team() == countteam then
					count = count + 1
				end
			end
		end
	end

	return count
end


function GM:GetRagdollEyes(pl)
	local Ragdoll = pl:GetRagdollEntity()
	if not Ragdoll then return end

	local att = Ragdoll:GetAttachment(Ragdoll:LookupAttachment("eyes"))
	if att then
		att.Pos = att.Pos + att.Ang:Forward() * -2
		att.Ang = att.Ang

		return att.Pos, att.Ang
	end
end

function GM:PlayerNoClip(pl, on)
	if pl:IsAdmin() then
		if SERVER then
			PrintMessage(HUD_PRINTCONSOLE, translate.Format(on and "x_turned_on_noclip" or "x_turned_off_noclip", pl:Name()))
		end

		if SERVER then
			pl:MarkAsBadProfile()
		end

		return true
	end

	return false
end

function GM:IsSpecialPerson(pl, image)
	local img, tooltip

	if pl:SteamID() == "STEAM_0:1:3307510" then
		img = "VGUI/steam/games/icon_sourcesdk"
		tooltip = "JetBoom\nCreator of Zombie Survival!"
	elseif pl:SteamID() == "STEAM_0:1:41282672" then
		img = "VGUI/steam/games/icon_dedicated"
		tooltip = "air rice\n밴딧 워페어 개발자"
	elseif pl:IsAdmin() then
		img = "VGUI/servers/icon_robotron"
		tooltip = "Admin"
	elseif pl:IsNoxSupporter() then
		img = "noxiousnet/noxicon.png"
		tooltip = "Nox Supporter"
	end

	if img then
		if CLIENT then
			image:SetImage(img)
			image:SetTooltip(tooltip)
		end

		return true
	end

	return false
end

function GM:GetWaveEnd()
	return GetGlobalFloat("waveend", 0)
end

function GM:SetWaveEnd(wave)
	SetGlobalFloat("waveend", wave)
end

function GM:GetWaveStart()
	return GetGlobalFloat("wavestart", self.WaveZeroLength)
end

function GM:SetWaveStart(wave)
	SetGlobalFloat("wavestart", wave)
end

function GM:GetWave()
	return GetGlobalInt("wave", 0)
end

if GM:GetWave() == 0 then
	GM:SetWaveStart(GM.WaveZeroLength)
	GM:SetWaveEnd(GM.WaveZeroLength + GM:GetWaveOneLength())
end

function GM:GetWaveActive()
	return GetGlobalBool("waveactive", false)
end

function GM:PlayerSwitchWeapon(pl, old, new)
	if !IsValid(pl) then
		return
	end
	
	if (IsValid(new)) then
		if (pl.BuffTightGrip and !new.IsMelee and new.Recoil and !new.BuffTightGrip) then
			new.BuffTightGrip = true
			new.Primary.Delay = new.Primary.Delay * 1.05
		end
	end
end

function GM:SetWaveActive(active)
	if self.RoundEnded then return end

	if self:GetWaveActive() ~= active then
		SetGlobalBool("waveactive", active)

		if SERVER then
			gamemode.Call("WaveStateChanged", active)
		end
	end
end

if not FixedSoundDuration then
FixedSoundDuration = true
local OldSoundDuration = SoundDuration
function SoundDuration(snd)
	if snd then
		local ft = string.sub(snd, -4)
		if ft == ".mp3" then
			return OldSoundDuration(snd) * 2.25
		end
		if ft == ".ogg" then
			return OldSoundDuration(snd) * 3
		end
	end

	return OldSoundDuration(snd)
end
end

function GM:VehicleMove()
end

function GM:SetTieScore(score)
	SetGlobalInt("tiescore", score)
end

function GM:GetTieScore()
	return GetGlobalInt("tiescore",0)
end

function GM:SetBanditScore(score)
	SetGlobalInt("banditscore", score)
end

function GM:SetHumanScore(score)
	SetGlobalInt("humanscore", score)
end

function GM:GetBanditScore()
	return GetGlobalInt("banditscore",0)
end

function GM:GetHumanScore()
	return GetGlobalInt("humanscore", 0)
end