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
include("sh_util.lua")
include("sh_options.lua")
include("sh_animations.lua")
include("sh_channel.lua")
include("sh_voiceset.lua")

include("obj_vector_extend.lua")
include("obj_entity_extend.lua")
include("obj_player_extend.lua")
include("obj_weapon_extend.lua")

include("workshopfix.lua")

----------------------

GM.EndRound = false
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
	["zombiesurvival/lasthuman.ogg"] = 122,
	["music/HL2_song29.mp3"] = 136,
	["music/HL2_song3.mp3"] = 90,
	["music/HL2_song31.mp3"] = 98,
	["music/HL2_song20_submix0.mp3"] = 104,
	["music/HL2_song20_submix4.mp3"] = 140,
	["music/HL2_song16.mp3"] = 170,
	["music/HL2_song15.mp3"] = 70,
	["music/HL2_song14.mp3"] = 160,
	["music/HL2_song4.mp3"] = 66,
	["music/HL2_song3.mp3"] = 91,
	["music/HL1_song15.mp3"] = 121,
	["music/HL1_song17.mp3"] = 124,
	["music/HL1_song10.mp3"] = 105
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
	game.AddAmmoType({name = "autocharging"})
end

function GM:SetSamples(bamount,hamount)
	SetGlobalInt("banditsamples", bamount)
	SetGlobalInt("humansamples", hamount)
end

function GM:AddSamples(bamount,hamount)
	horiginal = self:GetHumanSamples()
	boriginal = self:GetBanditSamples()
	SetGlobalInt("banditsamples", boriginal+bamount)
	SetGlobalInt("humansamples", horiginal+hamount)
end

function GM:GetHumanSamples()
	return GetGlobalInt("humansamples", 0)
end

function GM:GetBanditSamples()
	return GetGlobalInt("banditsamples", 0)
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
	if (pl:Team() == TEAM_HUMAN or pl:Team() == TEAM_BANDIT) then
		if pl:GetBarricadeGhosting() then
			move:SetMaxSpeed(36)
			move:SetMaxClientSpeed(36)
		--[[elseif move:GetForwardSpeed() < 0 then
			move:SetMaxSpeed(move:GetMaxSpeed() * 0.5)
			move:SetMaxClientSpeed(move:GetMaxClientSpeed() * 0.5)
		elseif move:GetForwardSpeed() == 0 then
			move:SetMaxSpeed(move:GetMaxSpeed() * 0.95)
			move:SetMaxClientSpeed(move:GetMaxClientSpeed() * 0.95)]]
		end
	end

	local legdamage = pl:GetLegDamage()
	if legdamage > 0 then
		local scale = 1 - math.min(1, legdamage/self.MaxLegDamage)
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

	pl:SetVelocity(- pl:GetVelocity() / 4)
	local damage = math.max(0,0.165*(speed-512))
	damage = damage * mul
	if hitfloater then damage = damage / 2 end
	if math.floor(damage) > 0 then
		if SERVER then
			print(damage)
			local groundent = pl:GetGroundEntity()
			local tohurt = pl
			local isgoomba = false
			if groundent:IsValid() && groundent:IsPlayer() && groundent:Team() && groundent:Team() != pl:Team() then
				tohurt = groundent
				isgoomba = true
			end
			if pl:GetActiveWeapon().CapFallDamage && !isgoomba then damage = math.Clamp(damage,0,30) end
			if isgoomba then damage = damage * 2 end
			tohurt:TakeSpecialDamage(damage, DMG_FALL, isgoomba and pl or game.GetWorld(), game.GetWorld(), pl:GetPos())
			if damage >= 30 and damage < pl:Health() then
				tohurt:KnockDown(damage * 0.05*mul)
			end
			tohurt:EmitSound("player/pl_fallpain"..(math.random(2) == 1 and 3 or 1)..".wav")
		end
	end

	return true
end

function GM:PlayerCanBeHealed(pl)
	return true
end

local TEAM_SPECTATOR = TEAM_SPECTATOR
function GM:PlayerCanHearPlayersVoice(listener, talker)
	return true
end

function GM:PlayerTraceAttack(pl, dmginfo, dir, trace)
end

function GM:ScalePlayerDamage(pl, hitgroup, dmginfo)
	
	local attacker = dmginfo:GetAttacker()
	local attackweapon = dmginfo:GetAttacker():GetActiveWeapon()
	local headshot = hitgroup == HITGROUP_HEAD
	if attackweapon.IgnoreDamageScaling then return end
	if hitgroup == HITGROUP_HEAD and dmginfo:IsBulletDamage() then
		pl.m_LastHeadShot = CurTime()
	end
	if headshot then
		dmginfo:ScaleDamage(1.5)
	elseif hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG or hitgroup == HITGROUP_GEAR then
		dmginfo:ScaleDamage(0.5)
	elseif hitgroup == HITGROUP_STOMACH or hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM then
		dmginfo:ScaleDamage(1)
	end
	if SERVER and (hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG) and self:PlayerShouldTakeDamage(pl, dmginfo:GetAttacker()) then
		pl:AddLegDamage(dmginfo:GetDamage())
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