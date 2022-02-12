--[[
Zombie Survival:Bandit Warfare
by Jooho "air rice" Lee

A total overhaul of Zombie Survival, focusing more on combat and PVP. Takes inspiration from CS and Battlefield and the like.
Much like how ZS was Jetboom's first gamemode, this one is mine.
]]
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

AddCSLuaFile("sh_translate.lua")
AddCSLuaFile("sh_colors.lua")
AddCSLuaFile("sh_serialization.lua")
AddCSLuaFile("sh_globals.lua")
AddCSLuaFile("sh_util.lua")
AddCSLuaFile("sh_options.lua")
AddCSLuaFile("sh_animations.lua")
AddCSLuaFile("sh_voiceset.lua")

AddCSLuaFile("cl_draw.lua")
AddCSLuaFile("cl_util.lua")
AddCSLuaFile("cl_options.lua")
AddCSLuaFile("cl_scoreboard.lua")
AddCSLuaFile("cl_targetid.lua")
AddCSLuaFile("cl_postprocess.lua")
AddCSLuaFile("cl_deathnotice.lua")
AddCSLuaFile("cl_floatingscore.lua")
AddCSLuaFile("cl_dermaskin.lua")
AddCSLuaFile("cl_hint.lua")

AddCSLuaFile("obj_vector_extend.lua")
AddCSLuaFile("obj_player_extend.lua")
AddCSLuaFile("obj_player_extend_cl.lua")
AddCSLuaFile("obj_weapon_extend.lua")
AddCSLuaFile("obj_entity_extend.lua")

AddCSLuaFile("vgui/dgamestate.lua")
AddCSLuaFile("vgui/dtransmittercounter.lua")
AddCSLuaFile("vgui/dteamcounter.lua")
AddCSLuaFile("vgui/dmodelpanelex.lua")
AddCSLuaFile("vgui/dweaponloadoutbutton.lua")

AddCSLuaFile("vgui/dpingmeter.lua")
AddCSLuaFile("vgui/dteamheading.lua")
AddCSLuaFile("vgui/dteamscores.lua")
AddCSLuaFile("vgui/dmodelkillicon.lua")

AddCSLuaFile("vgui/dexroundedpanel.lua")
AddCSLuaFile("vgui/dexroundedframe.lua")
AddCSLuaFile("vgui/dexrotatedimage.lua")
AddCSLuaFile("vgui/dexnotificationslist.lua")
AddCSLuaFile("vgui/dexchanginglabel.lua")

AddCSLuaFile("vgui/pmainmenu.lua")
AddCSLuaFile("vgui/poptions.lua")
AddCSLuaFile("vgui/phelp.lua")
AddCSLuaFile("vgui/pweapons.lua")
AddCSLuaFile("vgui/pendboard.lua")
AddCSLuaFile("vgui/ppointshop.lua")
AddCSLuaFile("vgui/zshealtharea.lua")

include("shared.lua")
include("sv_options.lua")
include("obj_entity_extend_sv.lua")
include("obj_player_extend_sv.lua")
include("mapeditor.lua")
include("sv_playerspawnentities.lua")
include("sv_profiling.lua")
include("sv_objectives.lua")

if file.Exists(GM.FolderName.."/gamemode/maps/"..game.GetMap()..".lua", "LUA") then
	include("maps/"..game.GetMap()..".lua")
end

function BroadcastLua(code)
	for _, pl in ipairs(player.GetAll()) do
		pl:SendLua(code)
	end
end

function GM:WorldHint(hint, pos, ent, lifetime, filter)
	net.Start("zs_worldhint")
		net.WriteString(hint)
		net.WriteVector(pos or ent and ent:IsValid() and ent:GetPos() or vector_origin)
		net.WriteEntity(ent or NULL)
		net.WriteFloat(lifetime or 8)
	if filter then
		net.Send(filter)
	else
		net.Broadcast()
	end
end

function GM:CreateGibs(pos, headoffset)
	headoffset = headoffset or 0

	local headpos = Vector(pos.x, pos.y, pos.z + headoffset)
	for i = 1, 2 do
		local ent = ents.CreateLimited("prop_playergib")
		if ent:IsValid() then
			ent:SetPos(headpos + VectorRand() * 5)
			ent:SetAngles(VectorRand():Angle())
			ent:SetGibType(i)
			ent:Spawn()
		end
	end

	for i = 1, 5 do
		local ent = ents.CreateLimited("prop_playergib")
		if ent:IsValid() then
			ent:SetPos(pos + VectorRand():GetNormalized() * math.Rand(1, 12))
			ent:SetAngles(VectorRand():Angle())
			ent:SetGibType(math.random(3, #GAMEMODE.HumanGibs))
			ent:Spawn()
		end
	end
end

function GM:TryHumanPickup(pl, entity)
	if pl.NoObjectPickup or not pl:Alive() or not (pl:Team() == TEAM_BANDIT or pl:Team() == TEAM_HUMAN) then return end

	if entity:IsValid() and not entity.m_NoPickup then
		local entclass = string.sub(entity:GetClass(), 1, 12)
		if (entclass == "prop_physics" or entclass == "func_physbox" or entity.HumanHoldable and entity:HumanHoldable(pl)) and not entity:IsNailed() and entity:GetMoveType() == MOVETYPE_VPHYSICS and entity:GetPhysicsObject():IsValid() and entity:GetPhysicsObject():GetMass() <= CARRY_MAXIMUM_MASS and entity:GetPhysicsObject():IsMoveable() and entity:OBBMins():Length() + entity:OBBMaxs():Length() <= CARRY_MAXIMUM_VOLUME then
			local holder, status = entity:GetHolder()
			if not holder and not pl:IsHolding() and CurTime() >= (pl.NextHold or 0)
			and pl:GetShootPos():Distance(entity:NearestPoint(pl:GetShootPos())) <= 64 and pl:GetGroundEntity() ~= entity then
				local newstatus = ents.Create("status_human_holding")
				if newstatus:IsValid() then
					pl.NextHold = CurTime() + 0.25
					pl.NextUnHold = CurTime() + 0.05
					newstatus:SetPos(pl:GetShootPos())
					newstatus:SetOwner(pl)
					newstatus:SetParent(pl)
					newstatus:SetObject(entity)
					newstatus:Spawn()
				end
			end
		end
	end
end

function GM:AddResources()
	resource.AddFile("resource/fonts/typenoksidi_v2.ttf")
	resource.AddFile("resource/fonts/hidden_v2.ttf")

	for _, filename in pairs(file.Find("materials/zombiesurvival/*.vmt", "GAME")) do
		resource.AddFile("materials/zombiesurvival/"..filename)
	end

	for _, filename in pairs(file.Find("materials/zombiesurvival/killicons/*.vmt", "GAME")) do
		resource.AddFile("materials/zombiesurvival/killicons/"..filename)
	end
	for _, filename in pairs(file.Find("materials/killicon/*.vmt", "GAME")) do
		resource.AddFile("materials/killicon/"..filename)
	end
	resource.AddFile("materials/refract_ring.vmt")
	resource.AddFile("materials/killicon/weapon_zs_tv.png")
	resource.AddFile("materials/killicon/weapon_zs_drone3.png")
	resource.AddFile("materials/killicon/weapon_zs_energysword.png")
	resource.AddFile("materials/models/weapons/w_annabelle/gun.vtf")
	resource.AddFile("materials/models/weapons/sledge.vmt")
	resource.AddFile("materials/models/weapons/temptexture/handsmesh1.vmt")
	resource.AddFile("materials/models/weapons/hammer2.vmt")
	resource.AddFile("materials/models/weapons/hammer.vmt")
	resource.AddFile("materials/models/weapons/v_hand/armtexture.vmt")
	
	resource.AddFile("models/weapons/c_annabelle.mdl")	
	resource.AddFile("models/weapons/w_sledgehammer.mdl")
	resource.AddFile("models/weapons/v_sledgehammer/c_sledgehammer.mdl")
	resource.AddFile("models/weapons/w_hammer.mdl")
	resource.AddFile("models/weapons/v_hammer/c_hammer.mdl")
	resource.AddFile("models/weapons/c_aegiskit.mdl")

	resource.AddFile("sound/weapons/melee/golfclub/golf_hit-01.ogg")
	resource.AddFile("sound/weapons/melee/golfclub/golf_hit-02.ogg")
	resource.AddFile("sound/weapons/melee/golfclub/golf_hit-03.ogg")
	resource.AddFile("sound/weapons/melee/golfclub/golf_hit-04.ogg")
	resource.AddFile("sound/weapons/melee/crowbar/crowbar_hit-1.ogg")
	resource.AddFile("sound/weapons/melee/crowbar/crowbar_hit-2.ogg")
	resource.AddFile("sound/weapons/melee/crowbar/crowbar_hit-3.ogg")
	resource.AddFile("sound/weapons/melee/crowbar/crowbar_hit-4.ogg")
	resource.AddFile("sound/weapons/melee/shovel/shovel_hit-01.ogg")
	resource.AddFile("sound/weapons/melee/shovel/shovel_hit-02.ogg")
	resource.AddFile("sound/weapons/melee/shovel/shovel_hit-03.ogg")
	resource.AddFile("sound/weapons/melee/shovel/shovel_hit-04.ogg")
	resource.AddFile("sound/weapons/melee/frying_pan/pan_hit-01.ogg")
	resource.AddFile("sound/weapons/melee/frying_pan/pan_hit-02.ogg")
	resource.AddFile("sound/weapons/melee/frying_pan/pan_hit-03.ogg")
	resource.AddFile("sound/weapons/melee/frying_pan/pan_hit-04.ogg")
	resource.AddFile("sound/weapons/melee/keyboard/keyboard_hit-01.ogg")
	resource.AddFile("sound/weapons/melee/keyboard/keyboard_hit-02.ogg")
	resource.AddFile("sound/weapons/melee/keyboard/keyboard_hit-03.ogg")
	resource.AddFile("sound/weapons/melee/keyboard/keyboard_hit-04.ogg")
	
	resource.AddFile("sound/bandit/hitsound.wav")

	resource.AddFile("sound/killstreak/2kills.wav")
	resource.AddFile("sound/killstreak/3kills.wav")
	resource.AddFile("sound/killstreak/4kills.wav")
	resource.AddFile("sound/killstreak/5kills.wav")
	resource.AddFile("sound/killstreak/6kills.wav")
	resource.AddFile("sound/killstreak/7kills.wav")
	resource.AddFile("sound/killstreak/8kills.wav")
	
	resource.AddFile("materials/noxctf/sprite_bloodspray1.vmt")
	resource.AddFile("materials/noxctf/sprite_bloodspray2.vmt")
	resource.AddFile("materials/noxctf/sprite_bloodspray3.vmt")
	resource.AddFile("materials/noxctf/sprite_bloodspray4.vmt")
	resource.AddFile("materials/noxctf/sprite_bloodspray5.vmt")
	resource.AddFile("materials/noxctf/sprite_bloodspray6.vmt")
	resource.AddFile("materials/noxctf/sprite_bloodspray7.vmt")
	resource.AddFile("materials/noxctf/sprite_bloodspray8.vmt")

	resource.AddFile("sound/music/bandit/lasthuman.ogg")
	resource.AddFile("sound/music/bandit/music_humanwin_vrts.ogg")
	resource.AddFile("sound/music/bandit/music_banditwin_vrts_2.ogg")
	resource.AddFile("sound/music/bandit/music_lose.ogg")
end

function GM:Initialize()
	self:RegisterPlayerSpawnEntities()
	self:AddResources()
	self:PrecacheResources()
	self:AddCustomAmmo()
	self:AddNetworkStrings()
	local roundmodecvar = GetConVar("zsb_roundgamemode"):GetInt()
	if roundmodecvar == ROUNDMODE_CLASSIC or roundmodecvar == ROUNDMODE_TRANSMISSION or roundmodecvar == ROUNDMODE_SAMPLES then
		self:SetRoundMode(roundmodecvar)
	else
		self:SetRoundMode(0)
	end
	
	game.ConsoleCommand("fire_dmgscale 1\n")
	game.ConsoleCommand("mp_flashlight 1\n")
	game.ConsoleCommand("sv_gravity 600\n")
end

function GM:AddNetworkStrings()
	util.AddNetworkString("zs_gamestate")
	util.AddNetworkString("zs_wavestart")
	util.AddNetworkString("zs_waveend")
	util.AddNetworkString("zs_suddendeath")

	util.AddNetworkString("zs_gamemodecall")
	util.AddNetworkString("zs_roundendcampos")
	util.AddNetworkString("zs_endround")
	util.AddNetworkString("zs_wavewonby")
	util.AddNetworkString("zs_centernotify")
	util.AddNetworkString("zs_topnotify")
	util.AddNetworkString("zs_playerrespawntime")
	util.AddNetworkString("zs_killstreak")	
	util.AddNetworkString("zs_playerredeemed")
	util.AddNetworkString("zs_dohulls")
	
	util.AddNetworkString("zs_nextresupplyuse")
	util.AddNetworkString("zs_lifestats")
	util.AddNetworkString("zs_lifestatsbd")
	util.AddNetworkString("zs_lifestatshd")
	util.AddNetworkString("zs_lifestatskills")
	util.AddNetworkString("zs_commission")
	util.AddNetworkString("zs_capture")
	
	util.AddNetworkString("zs_healother")
	util.AddNetworkString("zs_repairobject")
	util.AddNetworkString("zs_worldhint")
	util.AddNetworkString("zs_honmention")
	util.AddNetworkString("zs_floatscore")
	util.AddNetworkString("zs_floatscore_vec")

	util.AddNetworkString("zs_insure_weapon")
	util.AddNetworkString("zs_remove_insured_weapon")
	util.AddNetworkString("zs_weapon_toinsure")
	
	util.AddNetworkString("zs_dmg")
	util.AddNetworkString("zs_dmg_prop")
	util.AddNetworkString("zs_legdamage")
	util.AddNetworkString("zs_bodyarmor")
	util.AddNetworkString("zs_currenttransmitters")
	util.AddNetworkString("zs_hitmarker")
	
	util.AddNetworkString("zs_pl_kill_pl")
	util.AddNetworkString("zs_pls_kill_pl")
	util.AddNetworkString("zs_pl_kill_self")
	util.AddNetworkString("zs_death")
	
	util.AddNetworkString("bw_fire")
end

function GM:CenterNotifyAll(...)
	net.Start("zs_centernotify")
		net.WriteTable({...})
	net.Broadcast()
end
GM.CenterNotify = GM.CenterNotifyAll

function GM:TopNotifyAll(...)
	net.Start("zs_topnotify")
		net.WriteTable({...})
	net.Broadcast()
end
GM.TopNotify = GM.TopNotifyAll

function GM:ShowHelp(pl)
	pl:SendLua("GAMEMODE:ShowHelp()")
end

function GM:ShowTeam(pl)
	if pl:Alive() and (pl:Team() == TEAM_HUMAN or pl:Team() == TEAM_BANDIT) then
		pl:SendLua("GAMEMODE:OpenPointsShop("..WEAPONLOADOUT_NULL..")")
	end
end

function GM:ShowSpare1(pl)
	if pl:Team() == TEAM_HUMAN or pl:Team() == TEAM_BANDIT then
		if not (pl:IsValid() and pl:IsConnected() and pl:Alive()) then return end
		pl:DropActiveWeapon()
	end
end

function GM:ShowSpare2(pl)
	pl:SendLua("MakepOptions()")
end

function GM:SetupSpawnPoints()
	-- This uses the same logic as in ZS, but zombie spawns are now bandit spawns instead.
	local btab = ents.FindByClass("info_player_bandit")
	btab = table.Add(btab, ents.FindByClass("info_player_zombie"))
	btab = table.Add(btab, ents.FindByClass("info_player_rebel"))

	local htab = ents.FindByClass("info_player_human")
	htab = table.Add(htab, ents.FindByClass("info_player_combine"))

	local mapname = string.lower(game.GetMap())
	-- Terrorist spawns are usually in some kind of house or a main base in CS_  in order to guard the hosties. Put the humans there.
	if string.sub(mapname, 1, 3) == "cs_" or string.sub(mapname, 1, 3) == "zs_" then
		btab = table.Add(btab, ents.FindByClass("info_player_counterterrorist"))
		htab = table.Add(htab, ents.FindByClass("info_player_terrorist"))
	else -- Otherwise, this is probably a DE_, ZM_, or ZH_ map. In DE_ maps, the T's spawn away from the main part of the map and are zombies in zombie plugins so let's do the same.
		btab = table.Add(btab, ents.FindByClass("info_player_terrorist"))
		htab = table.Add(htab, ents.FindByClass("info_player_counterterrorist"))
	end

	-- Add all the old ZS spawns from GMod9.
	for _, oldspawn in pairs(ents.FindByClass("gmod_player_start")) do
		if oldspawn.BlueTeam then
			table.insert(htab, oldspawn)
		else
			table.insert(btab, oldspawn)
		end
	end

	-- You shouldn't play a DM map since spawns are shared but whatever. Let's make sure that there aren't team spawns first.
	if #htab == 0 then
		htab = ents.FindByClass("info_player_start")
		htab = table.Add(htab, ents.FindByClass("info_player_deathmatch")) -- Zombie Master
	end
	if #btab == 0 then
		btab = ents.FindByClass("info_player_start")
		btab = table.Add(btab, ents.FindByClass("info_zombiespawn")) -- Zombie Master
	end

	team.SetSpawnPoint(TEAM_BANDIT, btab)
	team.SetSpawnPoint(TEAM_HUMAN, htab)
	team.SetSpawnPoint(TEAM_SPECTATOR, htab)
end

function GM:PlayerPointsAdded(pl, amount)
end

local weaponmodelstoweapon = {}
weaponmodelstoweapon["models/props/cs_office/computer_keyboard.mdl"] = "weapon_zs_keyboard"
weaponmodelstoweapon["models/props_c17/computer01_keyboard.mdl"] = "weapon_zs_keyboard"
weaponmodelstoweapon["models/props_c17/metalpot001a.mdl"] = "weapon_zs_pot"
weaponmodelstoweapon["models/props_interiors/pot02a.mdl"] = "weapon_zs_fryingpan"
weaponmodelstoweapon["models/props_c17/metalpot002a.mdl"] = "weapon_zs_fryingpan"
weaponmodelstoweapon["models/props_junk/shovel01a.mdl"] = "weapon_zs_shovel"
weaponmodelstoweapon["models/props/cs_militia/axe.mdl"] = "weapon_zs_axe"
weaponmodelstoweapon["models/props_c17/tools_wrench01a.mdl"] = "weapon_zs_hammer"
weaponmodelstoweapon["models/weapons/w_knife_t.mdl"] = "weapon_zs_swissarmyknife"
weaponmodelstoweapon["models/weapons/w_knife_ct.mdl"] = "weapon_zs_swissarmyknife"
weaponmodelstoweapon["models/weapons/w_crowbar.mdl"] = "weapon_zs_crowbar"
weaponmodelstoweapon["models/weapons/w_stunbaton.mdl"] = "weapon_zs_stunbaton"
weaponmodelstoweapon["models/props_interiors/furniture_lamp01a.mdl"] = "weapon_zs_lamp"
weaponmodelstoweapon["models/props_junk/rock001a.mdl"] = "weapon_zs_stone"
weaponmodelstoweapon["models/props_c17/canister01a.mdl"] = "weapon_zs_oxygentank"
weaponmodelstoweapon["models/props_canal/mattpipe.mdl"] = "weapon_zs_pipe"
weaponmodelstoweapon["models/props_junk/meathook001a.mdl"] = "weapon_zs_hook"
function GM:InitPostEntity()
	gamemode.Call("InitPostEntityMap")
	RunConsoleCommand("mapcyclefile", "mapcycle_zsb.txt")
end

function GM:SetupProps()
	for _, ent in pairs(ents.FindByClass("prop_physics*")) do
		local mdl = ent:GetModel()
		if mdl then
			mdl = string.lower(mdl)
			if table.HasValue(self.BannedProps, mdl) then
				ent:Remove()
			elseif weaponmodelstoweapon[mdl] then
				ent:Remove()
				--[[
				Removing these for now for balancing purposes.
				local wep = ents.Create("prop_weapon")
				if wep:IsValid() then
					wep:SetPos(ent:GetPos())
					wep:SetAngles(ent:GetAngles())
					wep:SetWeaponType(weaponmodelstoweapon[mdl])
					wep:SetShouldRemoveAmmo(false)
					wep:Spawn()

					ent:Remove()
				end]]
				
			elseif ent:GetMaxHealth() == 1 and ent:Health() == 0 and ent:GetKeyValues().damagefilter ~= "invul" and ent:GetName() == "" then
				local health = math.min(800, math.ceil((ent:OBBMins():Length() + ent:OBBMaxs():Length()) * 10))
				local hmul = self.PropHealthMultipliers[mdl]
				if hmul then
					health = health * hmul
				end

				ent.PropHealth = health
				ent.TotalHealth = health
			else
				ent:SetHealth(math.ceil(ent:Health() * 3))
				ent:SetMaxHealth(ent:Health())
			end
		end
	end
end

local ammotoremove = {
	"item_ammo_357",
	"item_ammo_357_large",
	"item_ammo_pistol",
	"item_ammo_pistol_large",
	"item_ammo_buckshot",
	"item_ammo_ar2",
	"item_ammo_ar2_large",
	"item_ammo_ar2_altfire",
	"item_ammo_crossbow",
	"item_ammo_smg1",
	"item_ammo_smg1_large",
	"item_box_buckshot"
}

function GM:RemoveUnusedEntities()
	-- Causes a lot of needless lag.
	util.RemoveAll("prop_ragdoll")

	-- Remove NPCs because first of all this game is PvP and NPCs can cause crashes.
	util.RemoveAll("npc_maker")
	util.RemoveAll("npc_template_maker")
	util.RemoveAll("npc_zombie")
	util.RemoveAll("npc_zombie_torso")
	util.RemoveAll("npc_fastzombie")
	util.RemoveAll("npc_headcrab")
	util.RemoveAll("npc_headcrab_fast")
	util.RemoveAll("npc_headcrab_black")
	util.RemoveAll("npc_poisonzombie")

	-- Such a headache. Just remove them all.
	util.RemoveAll("item_ammo_crate")
	-- This is no longer a zombie mod.
	util.RemoveAll("zombiegasses")
	-- ...and uses CS maps but don't use buy zones.
	util.RemoveAll("func_buyzone")
	-- Shouldn't exist.
	util.RemoveAll("item_suitcharger")
	util.RemoveAll("item_healthcharger")
	
	
	util.RemoveAll("item_healthkit")
	util.RemoveAll("item_healthvial")	
	util.RemoveAll("item_battery")
	
	-- Remove all ammo in the map.
	for _, ammotype in ipairs(ammotoremove) do
		for _, ent in pairs(ents.FindByClass(ammotype)) do
			ent:Remove()
		end
	end
	util.RemoveAll("item_item_crate")
	
	-- Remove all map-placed weapons. This is unbalanced, what were you thinking??
	for _, ent in pairs(ents.FindByClass("weapon_*")) do
		--[[local wepclass = ent:GetClass()
		if string.sub(wepclass, 1, 10) == "weapon_zs_" then
			local wep = ents.Create("prop_weapon")
			if wep:IsValid() then
				wep:SetPos(ent:GetPos())
				wep:SetAngles(ent:GetAngles())
				wep:SetWeaponType(ent:GetClass())
				wep:SetShouldRemoveAmmo(false)
				wep:Spawn()
				wep.IsPreplaced = true
			end
		end]]
		ent:Remove()
	end
	
	-- Same with the prop versions of ammo & weapons.
	for _, ent in pairs(ents.FindByClass("prop_ammo")) do 
		ent:Remove() 
	end
	for _, ent in pairs(ents.FindByClass("prop_weapon")) do 
		ent:Remove() 
	end
end

function GM:IsClassicMode()
	return self:GetRoundMode() == ROUNDMODE_CLASSIC
end

function GM:IsSampleCollectMode()
	return self:GetRoundMode() == ROUNDMODE_SAMPLES
end

function GM:IsTransmissionMode()
	return self:GetRoundMode() == ROUNDMODE_TRANSMISSION
end

function GM:GetRoundMode()
	local cvarvalue = GetConVar("zsb_roundgamemode"):GetInt()
	local curvalue = GetGlobalInt("roundgamemode",0)
	if cvarvalue != curvalue then
		self:SetRoundMode(cvarvalue)
	end
	return cvarvalue
end

function GM:SetRoundMode(mode)
	if not (mode == ROUNDMODE_TRANSMISSION or mode == ROUNDMODE_SAMPLES or mode == ROUNDMODE_CLASSIC) then return end
	local cm = GetConVar("zsb_roundgamemode")
	SetGlobalInt("roundgamemode",mode)
	cm:SetInt(mode)
end

local playermins = Vector(-17, -17, 0)
local playermaxs = Vector(17, 17, 4)
local LastSpawnPoints = {}

function GM:PlayerSelectSpawn(pl)
	local spawninplayer = false
	local teamid = pl:Team()
	local tab
	local epicenter

	if not tab or #tab == 0 then tab = team.GetValidSpawnPoint(teamid) end

	local count = #tab
	if count > 0 then
		local spawn = table.Random(tab)
		if spawn then
			LastSpawnPoints[teamid] = spawn
			pl.SpawnedOnSpawnPoint = true
			return spawn
		end
	end

	pl.SpawnedOnSpawnPoint = true

	-- Fallback.
	return LastSpawnPoints[teamid] or #tab > 0 and table.Random(tab)
end
function GM:PrintSpawnPoints(teamid)
	PrintTable(team.GetValidSpawnPoint(teamid))
end
local NextTick = 0

function GM:AllPlayersLoaded()
	if player.GetCount() <= self.CurrentMapLoadedPlayers then
		return true
	else
		return false
	end
end

function GM:IsTeamImbalanced()
	local shouldshuffle = math.abs(#team.GetPlayers(TEAM_BANDIT) - #team.GetPlayers(TEAM_HUMAN)) >= 2 
	if shouldshuffle then
		timer.Simple(5, function() gamemode.Call("ShuffleTeams",false) end)	
		if shouldshuffle then 
			PrintTranslatedMessage(HUD_PRINTCENTER, "teambalance_shuffle_in_5_seconds")
		end
	end
	return shouldshuffle
end

local function SortByKillAdvantage(a, b)
	if a:IsPlayer() then
		if b:IsPlayer() then
			return (a:Frags() - a:Deaths()) > (b:Frags() - b:Deaths())
		else
			return true
		end
	else
		return false
	end
end

function GM:ShuffleTeams(initial)
	local newbandit,newhuman = 0,0
	local allplys = table.ShuffleOrder(player.GetAllActive())
	if !initial then
		table.sort(allplys,SortByKillAdvantage)
	end
	for _, pl in pairs(allplys) do
		if newbandit == newhuman then
			pl:ChangeTeam(math.random(3,4))
			if pl:Team() == TEAM_BANDIT then newbandit = newbandit+1
			elseif pl:Team() == TEAM_HUMAN then newhuman = newhuman+1
			end
		elseif newbandit > newhuman then
			pl:ChangeTeam(TEAM_HUMAN)
			newhuman = newhuman+1
		elseif newbandit < newhuman then
			pl:ChangeTeam(TEAM_BANDIT)
			newbandit = newbandit+1
		end		
	end
end

function GM:Move(pl, move)
	if (pl:Team() == TEAM_HUMAN or pl:Team() == TEAM_BANDIT) then
		if pl:GetBarricadeGhosting() then
			move:SetMaxClientSpeed(64)
		end
		local wep = pl:GetActiveWeapon()
		if wep.Move then
			wep:Move(move) 
		end
	end
	local legdamage = pl:GetLegDamage()
	if legdamage > 0 then
		local scale = 1 - math.min(1, legdamage/self.MaxLegDamage)
		move:SetMaxClientSpeed(move:GetMaxClientSpeed() * scale)
	end
end

function GM:FinishMove(pl, move)
	-- Simple anti bunny hopping. Flag is set in OnPlayerHitGround
	if pl.LandSlow then
		pl.LandSlow = false
		vel = move:GetVelocity()
		vel.x = vel.x * 0.75
		vel.y = vel.y * 0.75
		move:SetVelocity(vel)
	end
end

function GM:Think()
	local time = CurTime()
	
	if not self.RoundEnded then
		if self:GetWaveActive() then
			if self:GetWaveEnd() <= time and self:GetWaveEnd() ~= -1 then
				gamemode.Call("SetWaveActive", false)
			end
			if not self:IsClassicMode() and not self.SuddenDeath and self:IsTransmissionMode() then
				gamemode.Call("TransmitterCommsThink")
			elseif not self:IsClassicMode() and not self.SuddenDeath and self:IsSampleCollectMode() then
				gamemode.Call("SamplesThink")
			end
		elseif self:GetWaveStart() ~= -1 then
			if self:GetWave() == 0 and not (self.CurrentRound > 1) and self:GetWaveStart() - time <= self.WaveZeroLength - self.WaveIntermissionLength then
				if !self.ShuffledPlayersThisRound then
					if self:AllPlayersLoaded() then
						self.ShuffledPlayersThisRound = true
						gamemode.Call("ShuffleTeams",true)
					else
						gamemode.Call("SetWaveStart", CurTime()+self.WaveIntermissionLength)
					end
				end
			end
			if self:GetWaveStart() <= time then
				if player.GetCount() >= 2 and !self:IsTeamImbalanced() then
					gamemode.Call("SetWaveActive", true)
				else
					gamemode.Call("SetWaveStart", CurTime()+self.WaveIntermissionLength)
				end
			end
		end
	end
	
	local allplayers = player.GetAll()
	for _, pl in ipairs(allplayers) do
		if pl:GetLegDamage() > 0 and pl.LastLegDamageThink + self.LegDamageDecayTime <= time then
			pl:SetLegDamage(math.max(0,pl:GetLegDamage()-self.LegDamageDecay))
			pl.LastLegDamageThink = time
		end
		if pl:GetBarricadeGhosting() then
			pl:BarricadeGhostingThink()
		end
		if pl:IsSpectator() then
			self:SpectatorThink(pl)
		elseif not self.RoundEnded and not self:GetWaveActive() and not self:GetWaveStart() ~= -1 and self:GetWaveStart() > time then
			local numoutsidespawns = 0
			local teamspawns = {}
			teamspawns = team.GetValidSpawnPoint(pl:Team())
			for _, ent in pairs(teamspawns) do
				if ent:GetPos():Distance(pl:GetPos()) >= 156 and pl:Alive() then
					numoutsidespawns = numoutsidespawns + 1
				end
			end
			if numoutsidespawns >= #teamspawns then
				pl:SetPos(teamspawns[ math.random(#teamspawns) ]:GetPos())
				pl:SetAbsVelocity(Vector(0,0,0))
				pl:CenterNotify(COLOR_RED, translate.ClientGet(pl, "before_wave_cant_go_outside_spawn"))
			end
		end
		if pl.m_PointQueue >= 1 and time >= pl.m_LastDamageDealt + 2 then
			pl:PointCashOut((pl.m_LastDamageDealtPosition or pl:GetPos()) + Vector(0, 0, 32), FM_NONE)
		end
	end

	if NextTick <= time then
		NextTick = time + 1
		
		for _, pl in ipairs(allplayers) do
			if pl:Alive() then
				if pl:WaterLevel() >= 3 and not (pl.status_drown and pl.status_drown:IsValid()) then
					pl:GiveStatus("drown")
				end
				pl:PreventSkyCade()
			end
		end
	end
end

function GM:OnNPCKilled(ent, attacker, inflictor)
end

function GM:PlayerHealedTeamMember(pl, other, health, wep)
	if self:GetWave() == 0 then return end

	pl.HealedThisRound = pl.HealedThisRound + health
	pl.CarryOverHealth = (pl.CarryOverHealth or 0) + health
	
	local hpperpoint = self.MedkitHealPerPoint
	if hpperpoint <= 0 then return end

	local points = math.floor(pl.CarryOverHealth / hpperpoint)
	local mult = 1
	if self:IsClassicMode() then
		mult = 2
	end
	if 1 <= points then
		pl:AddPoints(points * mult)

		pl.CarryOverHealth = pl.CarryOverHealth - points * hpperpoint

		net.Start("zs_healother")
			net.WriteEntity(other)
			net.WriteUInt(points*mult, 16)
		net.Send(pl)
	end
end

function GM:ObjectPackedUp(pack, packer, owner)
end

function GM:PlayerRepairedObject(pl, other, health, wep)
	if self:GetWave() == 0 then return end

	pl.RepairedThisRound = pl.RepairedThisRound + health
	pl.CarryOverRepair = (pl.CarryOverRepair or 0) + health

	local hpperpoint = self.RepairHealthPerPoint
	if hpperpoint <= 0 then return end

	local points = math.floor(pl.CarryOverRepair / hpperpoint)
	local mult = 1
	if self:IsClassicMode() then
		mult = 2
	end
	if 1 <= points then
		pl:AddPoints(points * mult)

		pl.CarryOverRepair = pl.CarryOverRepair - points * hpperpoint

		net.Start("zs_repairobject")
			net.WriteEntity(other)
			net.WriteUInt(points * mult, 16)
		net.Send(pl)
	end
end

function GM:CacheHonorableMentions()
	if self.CachedHMs then return end

	self.CachedHMs = {}

	for i, hm in ipairs(self.HonorableMentions) do
		if hm.GetPlayer then
			local pl, magnitude = hm.GetPlayer(self)
			if pl then
				self.CachedHMs[i] = {pl, i, magnitude or 0}
			end
		end
	end

	gamemode.Call("PostDoHonorableMentions")
end

function GM:DoHonorableMentions(filter)
	self:CacheHonorableMentions()

	for i, tab in pairs(self.CachedHMs) do
		net.Start("zs_honmention")
			net.WriteEntity(tab[1])
			net.WriteUInt(tab[2], 8)
			net.WriteInt(tab[3], 32)
		if filter then
			net.Send(filter)
		else
			net.Broadcast()
		end
	end
end

function GM:PostDoHonorableMentions()
end

function GM:PostEndRound(winner)
end

-- You can override or hook and return false in case you have your own map change system.
local function RealMap(map)
	return string.match(map, "(.+)%.bsp")
end

function GM:LoadNextMap()
	-- Just in case.
	timer.Simple(5, game.LoadNextMap)
	timer.Simple(10, function() RunConsoleCommand("changelevel", game.GetMap()) end)
end

function GM:PreRestartRound()
	for _, pl in ipairs(player.GetAll()) do
		pl:StripWeapons()
		pl:Spectate(OBS_MODE_ROAMING)
		pl:SetTeam(TEAM_UNASSIGNED)
		pl:GodDisable()
	end
end

function GM:ResetPlayerTeams()
	for _, pl in ipairs(player.GetAll()) do
		pl:SetTeam(TEAM_UNASSIGNED)
	end
end

GM.CurrentRound = 1
GM.CurrentMapLoadedPlayers = 0
GM.ShuffledPlayersThisRound = false
function GM:RestartRound()
	self.CurrentRound = self.CurrentRound + 1

	self:RestartLua()
	self:RestartGame()
	
	net.Start("zs_gamemodecall")
		net.WriteString("RestartRound")
	net.Broadcast()
end
GM.TiedWaves = 0
GM.PreviouslyDied = {}
GM.PreviousTeam = {}
GM.PreviousPoints = {}
GM.CurrentTransmitterTable = {}
GM.BulletsDmg = {}
GM.CommsEnd = false
GM.SamplesEnd = false
GM.SuddenDeath = false
GM.CurrentWaveWinner = nil
GM.NextNestSpawn = nil
function GM:RestartLua()
	self.CachedHMs = nil
	self.UseTransmitters = nil
	self:SetComms(0,0)
	self:SetSamples(0,0)
	self.NextNestSpawn = nil
	self.CommsEnd = false
	self.SamplesEnd = false
	self.SuddenDeath = false
	net.Start("zs_suddendeath")
		net.WriteBool( false )
	net.Broadcast()
	self.CurrentTransmitterTable = {}
	self:SetCurrentWaveWinner(nil)

	
	self.PreviouslyDied = {}
	self.PreviousTeam = {}
	self.PreviousPoints = {}

	ROUNDWINNER = nil

	hook.Remove("PlayerShouldTakeDamage", "EndRoundShouldTakeDamage")
end

-- I don't know.
local function CheckBroken()
	for _, pl in ipairs(player.GetAll()) do
		if pl:Alive() and (pl:Health() <= 0 or pl:GetObserverMode() ~= OBS_MODE_NONE or pl:OBBMaxs().x ~= 16) then
			pl:SetObserverMode(OBS_MODE_NONE)
			pl:UnSpectateAndSpawn()
		end
	end
end

function GM:DoRestartGame()
	self.RoundEnded = nil

	for _, ent in pairs(ents.FindByClass("prop_weapon")) do
		ent:Remove()
	end

	for _, ent in pairs(ents.FindByClass("prop_ammo")) do
		ent:Remove()
	end
	self.CurrentMapLoadedPlayers = 0
	self.ShuffledPlayersThisRound = false
	net.Start("zs_currenttransmitters")
		for i=1, self.MaxTransmitters do
			net.WriteInt(0,4)
		end
	net.Broadcast()
	self.CurrentTransmitterTable = {}
	self:SetWave(0)
	self:SetHumanScore(0)
	self:SetBanditScore(0)
	self:SetTieScore(0)
	self:SetWaveStart(CurTime() + self.WaveZeroLength)
	self:SetWaveEnd(self:GetWaveStart() + self:GetWaveOneLength())
	self:SetWaveActive(false)
	
	SetGlobalInt("numwaves", -2)

	timer.Create("CheckBroken", 10, 1, CheckBroken)

	game.CleanUpMap(false, self.CleanupFilter)
	gamemode.Call("InitPostEntityMap")
	for _, pl in pairs(player.GetAll()) do
		pl:GodDisable()
		gamemode.Call("PlayerInitialSpawnRound", pl)
		pl:UnSpectateAndSpawn()
		gamemode.Call("PlayerReadyRound", pl)
	end
end

function GM:RestartGame()
	for _, pl in pairs(player.GetAll()) do
		pl:StripWeapons()
		pl:StripAmmo()
		pl:SetFrags(0)
		pl:SetDeaths(0)
	end
	--[[self:SetWave(0)
	self:SetWaveStart(CurTime() + self.WaveZeroLength)
	self:SetWaveEnd(self:GetWaveStart() + self:GetWaveOneLength())]]
	
	self:SetWaveActive(false)
	self.SuddenDeath = false
	SetGlobalInt("numwaves", -2)
	if GetGlobalString("hudoverride"..TEAM_BANDIT, "") ~= "" then
		SetGlobalString("hudoverride"..TEAM_BANDIT, "")
	end
	if GetGlobalString("hudoverride"..TEAM_HUMAN, "") ~= "" then
		SetGlobalString("hudoverride"..TEAM_HUMAN, "")
	end

	timer.Simple(0.25, function() GAMEMODE:DoRestartGame() end)
end

function GM:InitPostEntityMap()
	pcall(gamemode.Call, "LoadMapEditorFile")

	gamemode.Call("SetupSpawnPoints")
	gamemode.Call("RemoveUnusedEntities")
	gamemode.Call("SetupProps")
end

local function EndRoundPlayerShouldTakeDamage(pl, attacker) 
	if attacker:IsPlayer() and attacker ~= pl and attacker:Team() == pl:Team() then 
		return false 
	end
	return true
end

local function EndRoundPlayerCanSuicide(pl) return true end

local function EndRoundSetupPlayerVisibility(pl)
	if GAMEMODE.RoundEndCamPos and GAMEMODE.RoundEnded then
		AddOriginToPVS(GAMEMODE.RoundEndCamPos)
	else
		hook.Remove("SetupPlayerVisibility", "EndRoundSetupPlayerVisibility")
	end
end

function GM:EndRound(winner)
	if self.RoundEnded then return end
	self.RoundEnded = true
	self.RoundEndedTime = CurTime()
	ROUNDWINNER = winner

	game.SetTimeScale(0.25)
	timer.Simple(2, function() game.SetTimeScale(1) end)

	hook.Add("SetupPlayerVisibility", "EndRoundSetupPlayerVisibility", EndRoundSetupPlayerVisibility)

	local mapname = string.lower(game.GetMapNext())

	if self:ShouldRestartRound() then
		timer.Simple(self.EndGameTime - 3, function() gamemode.Call("PreRestartRound") end)
		timer.Simple(self.EndGameTime, function() gamemode.Call("RestartRound") end)
		mapname = string.lower(game.GetMap())
	else
		timer.Simple(self.EndGameTime, function() gamemode.Call("LoadNextMap") end)
	end
	
	
	if table.HasValue(self.MapWhitelist, mapname) and self:MapHasEnoughObjectives(mapname) and player.GetCount() >= 6 and self.AutoModeChange then
		local decider = math.random(1,4)
		if not self:IsClassicMode() and decider == 1 then
			self:SetRoundMode(ROUNDMODE_CLASSIC)
		elseif decider <= 2 then
			self:SetRoundMode(ROUNDMODE_SAMPLES)
		else
			self:SetRoundMode(ROUNDMODE_TRANSMISSION)
		end
	else
		self:SetRoundMode(ROUNDMODE_CLASSIC)
	end
	-- Get rid of some lag.
	util.RemoveAll("prop_ammo")
	util.RemoveAll("prop_weapon")
	
	hook.Add("PlayerShouldTakeDamage", "EndRoundShouldTakeDamage", EndRoundPlayerShouldTakeDamage)
	
	timer.Simple(5, function() gamemode.Call("DoHonorableMentions") end)

	net.Start("zs_endround")
		net.WriteUInt(winner or -1, 8)
		net.WriteString(game.GetMapNext())
	net.Broadcast()

	if winner == TEAM_HUMAN then
		for _, ent in pairs(ents.FindByClass("logic_winlose")) do
			ent:Input("onhwin")
		end
	elseif winner == TEAM_BANDIT then
		for _, ent in pairs(ents.FindByClass("logic_winlose")) do
			ent:Input("onbwin")
		end
	else
		for _, ent in pairs(ents.FindByClass("logic_winlose")) do
			ent:Input("onlose")
		end
	end

	gamemode.Call("PostEndRound", winner)

	self:SetWaveStart(CurTime() + 9999)
end

function GM:WaveEndWithWinner(winner)
	if self:IsClassicMode() or self.SamplesEnd or self.CommsEnd then 
		self:SetCurrentWaveWinner(winner)
		local endtime = self:IsClassicMode() and 5 or 3.5
		--if self:GetWaveEnd() - CurTime() > endtime then
			gamemode.Call("SetWaveEnd",CurTime()+endtime)
		--end
	end
end
function GM:GetCurrentWaveWinner()
	return self.CurrentWaveWinner
end
function GM:SetCurrentWaveWinner(winner)
	self.CurrentWaveWinner = winner
end
function GM:PlayerReady(pl)
	gamemode.Call("PlayerReadyRound", pl)
end

function GM:PlayerReadyRound(pl)
	if not pl:IsValid() then return end

	self:FullGameUpdate(pl)

	if self.RoundEnded then
		pl:SendLua("gamemode.Call(\"EndRound\", "..tostring(ROUNDWINNER)..", \""..game.GetMapNext().."\")")
		gamemode.Call("DoHonorableMentions", pl)
	end
	pl:SendLua("MakepHelp()")
	pl:SendLua("SetGlobalInt(\"roundgamemode\", "..GetGlobalInt("roundgamemode",0)..")")
end

function GM:FullGameUpdate(pl)
	net.Start("zs_gamestate")
		net.WriteInt(self:GetWave(), 16)
		net.WriteFloat(self:GetWaveStart())
		net.WriteFloat(self:GetWaveEnd())
	if pl then
		net.Send(pl)
	else
		net.Broadcast()
	end
end

concommand.Add("initpostentity", function(sender, command, arguments)
	if not sender.DidInitPostEntity then
		sender.DidInitPostEntity = true

		gamemode.Call("PlayerReady", sender)
	end
end)

local playerheight = Vector(0, 0, 72)
local playermins = Vector(-17, -17, 0)
local playermaxs = Vector(17, 17, 4)
local function groupsort(a, b)
	return #a > #b
end

function GM:PlayerInitialSpawn(pl)
	gamemode.Call("PlayerInitialSpawnRound", pl)
end

local primaryguns = {
	"weapon_zs_tosser",
	"weapon_zs_crackler",
	"weapon_zs_doublebarrel",
	"weapon_zs_stubber",
}
local secondaryguns = {
	"weapon_zs_peashooter",
	"weapon_zs_battleaxe",
	"weapon_zs_slinger"
}
local meleeslot = {
	"weapon_zs_swissarmyknife",
	"weapon_zs_lamp",
	"weapon_zs_plank"
}
function GM:PlayerInitialSpawnRound(pl)
	pl:SprintDisable()
	--pl:RemoveSuit()
	if pl:KeyDown(IN_WALK) then
		pl:ConCommand("-walk")
	end

	pl:SetCanWalk(false)
	pl:SetCanZoom(false)
	pl:SetNoCollideWithTeammates(true)
	pl:SetCustomCollisionCheck(true)
	pl:DoHulls()

	pl.BountyModifier = 0
	pl.EnemyKilledAssists = 0
	pl.MeleeKilled = 0
	pl.ShotsFired = 0
	pl.ShotsHit = 0
	pl.LastShotWeapon = nil
	pl.HeadshotKilled = 0
	pl.ResupplyBoxUsedByOthers = 0
	
	pl.WaveJoined = self:GetWave()
	
	pl.BarricadeDamage = 0

	pl.NextPainSound = 0

	pl.LegDamage = 0
	pl:SendLua("LocalPlayer().BodyArmor = 0")
	pl.BodyArmor = 0
	pl.LastLegDamageThink = 0
	
	pl.DamageDealt = 0
	pl.TimeCapping = 0
	pl.LifeBarricadeDamage = 0
	pl.LifeEnemyDamage = 0
	pl.LifeEnemyKills = 0
	pl.HighestLifeEnemyKills = 0
	
	pl.m_PointQueue = 0
	pl.m_LastDamageDealt = 0
	pl.m_PreRespawn = nil

	pl.HealedThisRound = 0
	pl.CarryOverHealth = 0
	local nosend = not pl.DidInitPostEntity

	pl.RepairedThisRound = 0
	pl.CarryOverRepair = 0
	pl.PointsSpent = 0
	pl.CarryOverCommision = 0
	pl.BackdoorsUsed = 0
	
	pl.SpawnedTime = CurTime()
	if pl:GetInfo("zsb_spectator") == "1" then
		pl:Flashlight(false)
		pl:ChangeTeam(TEAM_SPECTATOR)
		pl:StripWeapons()
		pl:Spectate( OBS_MODE_ROAMING )
		return false;
	end
	
	pl:SetPoints(0)
	pl:SetFullPoints(0)
	if self.PreviousPoints[pl:SteamID64()] then
		pl:AddPoints(self.PreviousPoints[pl:SteamID64()])
	elseif self:GetWave() > 0 then
		pl:AddPoints(self:GetTeamPoints(pl:Team())/math.max(team.NumPlayers(pl:Team())-1,1))
	else
		pl:AddPoints(20)
	end
	
	if #team.GetPlayers(TEAM_BANDIT) == #team.GetPlayers(TEAM_HUMAN) then
		if self:GetTeamKillAdvantage(TEAM_HUMAN) > self:GetTeamKillAdvantage(TEAM_BANDIT) then
			pl:ChangeTeam(TEAM_BANDIT)
		elseif self:GetTeamKillAdvantage(TEAM_HUMAN) < self:GetTeamKillAdvantage(TEAM_BANDIT) then
			pl:ChangeTeam(TEAM_HUMAN)
		else
			if self:GetTeamPoints(TEAM_HUMAN) < self:GetTeamPoints(TEAM_BANDIT) then 
				pl:ChangeTeam(TEAM_HUMAN)
			elseif self:GetTeamPoints(TEAM_HUMAN) > self:GetTeamPoints(TEAM_BANDIT) then 
				pl:ChangeTeam(TEAM_BANDIT)
			else
				pl:ChangeTeam(math.random(3,4))
			end
		end
		if self.PreviousTeam[pl:SteamID64()] then
			pl:ChangeTeam(self.PreviousTeam[pl:SteamID64()])
		end
	elseif #team.GetPlayers(TEAM_BANDIT) > #team.GetPlayers(TEAM_HUMAN) then
		pl:ChangeTeam(TEAM_HUMAN)
	elseif #team.GetPlayers(TEAM_BANDIT) < #team.GetPlayers(TEAM_HUMAN) then
		pl:ChangeTeam(TEAM_BANDIT)
	end
	if self:GetWave() == 0 then
		self.CurrentMapLoadedPlayers = self.CurrentMapLoadedPlayers + 1;
	end

	pl.ClassicModeInsuredWeps = {}
	pl.ClassicModeNextInsureWeps = {}
	pl.ClassicModeRemoveInsureWeps = {}
	pl:SendLua("GAMEMODE.ClassicModeInsuredWeps = {}")
	pl:SendLua("GAMEMODE.ClassicModePurchasedThisWave = {}")
	pl:SetWeapon1(primaryguns[math.random(#primaryguns)])
	pl:SetWeapon2(secondaryguns[math.random(#secondaryguns)])
	pl:SetWeaponToolslot("weapon_zs_enemyradar")
	pl:SetWeaponMelee(meleeslot[math.random(#meleeslot)])
	if self:IsClassicMode() then
		table.ForceInsert(pl.ClassicModeInsuredWeps,pl:GetWeapon2())
		table.ForceInsert(pl.ClassicModeInsuredWeps,pl:GetWeaponMelee())
	end
	if (self:IsClassicMode() or self.SuddenDeath) and self:GetWaveActive() then
		timer.Simple(0.2, function() pl:Kill() end)
	end
end

function GM:PlayerDisconnected(pl)
	pl.Disconnecting = true

	local uid = pl:SteamID64()

	self.PreviouslyDied[uid] = CurTime()
	self.PreviousTeam[uid] = pl:Team()
	self.PreviousPoints[uid] = pl:GetPoints()
	pl:DropAll()
	if not pl:IsSpectator() then
		local lastattacker = pl:GetLastAttacker()
		if IsValid(lastattacker) then
			PrintTranslatedMessage(HUD_PRINTCONSOLE, "disconnect_killed", pl:Name(), lastattacker:Name())
		end
	end
	pl:Kill()
end

function GM:OnNestDestroyed(attacker)
	for _, pl in pairs(player.GetAll()) do
		pl:CenterNotify({killicon = "default"}, " ", COLOR_RED, translate.ClientFormat(pl, "nest_destroyed_by_x",attacker:Name()), {killicon = "default"})
	end
end

function GM:OnNestSpawned()
	for _, pl in pairs(player.GetAll()) do
		pl:CenterNotify({killicon = "default"}, " ", COLOR_RED, translate.ClientGet(pl, "nest_spawned"), {killicon = "default"})
	end
end

-- Reevaluates a prop and its constraint system (or all props if no arguments) to determine if they should be frozen or not from nails.
function GM:EvaluatePropFreeze(ent, neighbors)
	if not ent then
		for _, e in pairs(ents.GetAll()) do
			if e and e:IsValid() then
				self:EvaluatePropFreeze(e)
			end
		end

		return
	end

	if ent:IsNailedToWorldHierarchy() then
		ent:SetNailFrozen(true)
	elseif ent:GetNailFrozen() then
		ent:SetNailFrozen(false)
	end

	neighbors = neighbors or {}
	table.insert(neighbors, ent)

	for _, nail in pairs(ent:GetNails()) do
		if nail:IsValid() then
			local baseent = nail:GetBaseEntity()
			local attachent = nail:GetAttachEntity()
			if baseent:IsValid() and not baseent:IsWorld() and not table.HasValue(neighbors, baseent) then
				self:EvaluatePropFreeze(baseent, neighbors)
			end
			if attachent:IsValid() and not attachent:IsWorld() and not table.HasValue(neighbors, attachent) then
				self:EvaluatePropFreeze(attachent, neighbors)
			end
		end
	end
end

-- A nail takes some damage. isdead is true if the damage is enough to remove the nail. The nail is invalid after this function call if it dies.
function GM:OnNailDamaged(ent, attacker, inflictor, damage, dmginfo)
end

-- A nail is removed between two entities. The nail is no longer considered valid right after this function and is not in the entities' Nails tables. remover may not be nil if it was removed with the hammer's unnail ability.
local function evalfreeze(ent)
	if ent and ent:IsValid() then
		gamemode.Call("EvaluatePropFreeze", ent)
	end
end
function GM:OnNailRemoved(nail, ent1, ent2, remover)
	if ent1 and ent1:IsValid() and not ent1:IsWorld() then
		timer.Simple(0, function() evalfreeze(ent1) end)
		timer.Simple(0.2, function() evalfreeze(ent1) end)
	end
	if ent2 and ent2:IsValid() and not ent2:IsWorld() then
		timer.Simple(0, function() evalfreeze(ent2) end)
		timer.Simple(0.2, function() evalfreeze(ent2) end)
	end

	if remover and remover:IsValid() and remover:IsPlayer() then
		local deployer = nail:GetDeployer()
		if deployer:IsValid() and deployer ~= remover and (deployer:Team() == TEAM_HUMAN or deployer:Team() == TEAM_BANDIT) then
			PrintTranslatedMessage(HUD_PRINTCONSOLE, "nail_removed_by", remover:Name(), deployer:Name())
		end
	end
end

-- A nail is created between two entities.
function GM:OnNailCreated(ent1, ent2, nail)
	if ent1 and ent1:IsValid() and not ent1:IsWorld() then
		timer.Simple(0, function() evalfreeze(ent1) end)
	end
	if ent2 and ent2:IsValid() and not ent2:IsWorld() then
		timer.Simple(0, function() evalfreeze(ent2) end)
	end
end

function GM:RemoveUnusedAmmo(pl)
	local AmmoCounts = {}

	for _, wep in ipairs(pl:GetWeapons()) do
		if wep.Primary then
			local ammotype = wep:ValidPrimaryAmmo()
			if ammotype and wep.Primary.DefaultClip > 0 then
				AmmoCounts[ammotype] = (AmmoCounts[ammotype] or 0) + 1
			end
			local ammotype2 = wep:ValidSecondaryAmmo()
			if ammotype2 and wep.Secondary.DefaultClip > 0 then
				AmmoCounts[ammotype2] = (AmmoCounts[ammotype2] or 0) + 1
			end
		end
	end
	for _, ammotype in ipairs(game.GetAmmoTypes()) do
		ammotype = string.lower(ammotype)
		if not (AmmoCounts[ammotype] and AmmoCounts[ammotype] > 0) and pl:GetAmmoCount(ammotype) > 0 then
			pl:RemoveAmmo(pl:GetAmmoCount(ammotype), ammotype)
		end
	end
end

function GM:PlayerUpgradePointshopItem(pl,originaltab,itemtab,revertmode,slot)
	if not itemtab or not originaltab or not (pl:Team() == TEAM_HUMAN or pl:Team() == TEAM_BANDIT) then return end
	local canupgrade, reasons = PlayerCanPurchasePointshopUpgradeItem(pl,originaltab,itemtab,slot,revertmode)
	if not canupgrade then
		pl:CenterNotify(COLOR_RED, reasons)
		pl:SendLua("surface.PlaySound(\"buttons/button10.wav\")")
		return
	end
	local originswep = originaltab.SWEP or ""
	local targetswep = itemtab.SWEP or ""
	if self:IsClassicMode() then
		--[[if itemtab.ControllerWep and pl:HasWeapon(itemtab.ControllerWep) then
			pl:CenterNotify(COLOR_RED, translate.ClientGet(pl, "already_have_weapon"))
			pl:SendLua("surface.PlaySound(\"buttons/button10.wav\")")
			return
		end]]
		local cangive = false
		local tempinsuredindex = nil
		for i,wepname in ipairs(pl.ClassicModeInsuredWeps) do
			if isstring(wepname) and isstring(originswep) and string.lower(wepname) == string.lower(originswep) then
				cangive = true
				break
			end
		end
		for i,wepname in ipairs(pl.ClassicModeNextInsureWeps) do
			if isstring(wepname) and isstring(originswep) and string.lower(wepname) == string.lower(originswep) then
				cangive = true
				tempinsuredindex = i
				break
			end
		end
		if cangive then
			local wep = pl:Give(targetswep)
			if wep and wep:IsValid() then
				pl:SelectWeapon(targetswep)
				if not (wep.IsConsumable or wep.AmmoIfHas) then
					if not table.HasValue(pl.ClassicModeNextInsureWeps,targetswep) then
						table.insert(pl.ClassicModeNextInsureWeps,targetswep)
					end
					for i,wepname in ipairs(pl.ClassicModeRemoveInsureWeps) do
						if isstring(wepname) and isstring(targetswep) and string.lower(wepname) == string.lower(targetswep) then
							table.remove(pl.ClassicModeRemoveInsureWeps,i)
						end
					end
					net.Start("zs_weapon_toinsure")
						net.WriteString(targetswep)
					net.Send(pl)
				end
				if tempinsuredindex != nil then
					table.remove(pl.ClassicModeNextInsureWeps,tempinsuredindex)
				end
				table.insert(pl.ClassicModeRemoveInsureWeps,originswep)
				pl:StripWeapon(originswep)
			end
		else
			pl:CenterNotify(COLOR_RED, translate.ClientGet(pl,"weapon_is_not_owned"))
			pl:SendLua("surface.PlaySound(\"buttons/button10.wav\")")
			return
		end
	else
		if itemtab.SWEP then
			if ((slot == WEAPONLOADOUT_SLOT1 or slot == WEAPONLOADOUT_SLOT2) and itemtab.Category == ITEMCAT_GUNS) 
			or (slot == WEAPONLOADOUT_TOOLS  and itemtab.Category == ITEMCAT_TOOLS) 
			or (slot == WEAPONLOADOUT_MELEE  and itemtab.Category == ITEMCAT_MELEE) then	
				local oldwep = nil
				if slot == WEAPONLOADOUT_SLOT1 then 
					oldwep = pl:GetWeapon1()
				elseif slot == WEAPONLOADOUT_SLOT2 then 
					oldwep = pl:GetWeapon2() 
				elseif slot == WEAPONLOADOUT_TOOLS then
					oldwep = pl:GetWeaponToolslot()
				elseif slot == WEAPONLOADOUT_MELEE then
					oldwep = pl:GetWeaponMelee()
				end
				if isstring(oldwep) and isstring(originswep) and string.lower(oldwep) != string.lower(originswep) then
					return
				end
				if slot == WEAPONLOADOUT_SLOT1 then 
					pl:SetWeapon1(itemtab.SWEP)
				elseif slot == WEAPONLOADOUT_SLOT2 then 
					pl:SetWeapon2(itemtab.SWEP)
				elseif slot == WEAPONLOADOUT_TOOLS then
					pl:SetWeaponToolslot(itemtab.SWEP)
				elseif slot == WEAPONLOADOUT_MELEE then
					pl:SetWeaponMelee(itemtab.SWEP)
				end
				if not self:GetWaveActive() and pl:Alive() then
					local newweptab = weapons.GetStored(itemtab.SWEP)
					if newweptab then
						local oldweptab = pl:GetWeapon(oldwep)
						local givenwep = pl:Give(itemtab.SWEP)
						if oldweptab and oldweptab.Primary then
							if oldweptab.Primary.DefaultClip > 0 and givenwep and givenwep:IsValid() and givenwep:IsWeapon() then
								local oldAmmoType = oldweptab:ValidPrimaryAmmo()
								local oldAmmoAmount = math.min(oldweptab.Primary.DefaultClip - oldweptab:GetMaxClip1(),pl:GetAmmoCount(oldAmmoType))
								local newAmmoType = givenwep:ValidPrimaryAmmo()
								local newAmmoAmount = givenwep.Primary.DefaultClip - givenwep:GetMaxClip1()
								if oldAmmoType and oldAmmoAmount and newAmmoType and newAmmoAmount and newAmmoType == oldAmmoType then
									if oldAmmoAmount < newAmmoAmount then
										pl:RemoveAmmo(oldAmmoAmount, oldAmmoType)
									else
										pl:RemoveAmmo(newAmmoAmount, oldAmmoType)
									end
								end
							end
							pl:StripWeapon(oldwep)
						end
						pl:SelectWeapon(itemtab.SWEP)
						self:RemoveUnusedAmmo(pl)
					end
				else
					pl:PrintTranslatedMessage(HUD_PRINTTALK, "will_appear_after_respawn")
				end
			end
		elseif itemtab.Callback then
			itemtab.Callback(pl)
		end
	end
	
	local cost = GetItemCost(itemtab)
	if revertmode then
		cost = math.floor(GetItemCost(originaltab)/2)
		pl:RefundPoints(cost)
	else
		pl:TakePoints(cost)
		pl.PointsSpent = pl.PointsSpent + cost
	end
	pl:PrintTranslatedMessage(HUD_PRINTTALK, revertmode and "refunded_and_given_x_points" or "upgraded_for_x_points", cost)
	pl:SendLua("surface.PlaySound(\"ambient/levels/labs/coinslot1.wav\")")
end

function GM:PlayerPurchasePointshopItem(pl,itemtab,slot)
	if not itemtab or not (pl:Team() == TEAM_HUMAN or pl:Team() == TEAM_BANDIT) then return end	
	if itemtab.Prerequisites and istable(itemtab.Prerequisites) and !table.IsEmpty(itemtab.Prerequisites) then
		pl:CenterNotify(COLOR_RED, translate.ClientGet(pl,"cant_purchase_right_now"))
		pl:SendLua("surface.PlaySound(\"buttons/button10.wav\")")
		return
	end
	local canpurchase, reasons = PlayerCanPurchasePointshopItem(pl,itemtab,slot,false)
	if not canpurchase then
		pl:CenterNotify(COLOR_RED, reasons)
		pl:SendLua("surface.PlaySound(\"buttons/button10.wav\")")
		return
	end
	
	if not self:IsClassicMode() then
		if slot == WEAPONLOADOUT_NULL or not slot then
			if not pl:Alive() then
				pl:CenterNotify(COLOR_RED, translate.ClientGet(pl, "cant_purchase_right_now"))
				pl:SendLua("surface.PlaySound(\"buttons/button10.wav\")")
				return
			end
			if itemtab.Category == ITEMCAT_GUNS or itemtab.Category == ITEMCAT_MELEE or itemtab.Category == ITEMCAT_TOOLS then return end
			if itemtab.Callback then
				itemtab.Callback(pl)
			elseif itemtab.SWEP then
				pl:Give(itemtab.SWEP)
			else
				return
			end		
		else
			if itemtab.SWEP then
				if ((slot == WEAPONLOADOUT_SLOT1 or slot == WEAPONLOADOUT_SLOT2) and itemtab.Category == ITEMCAT_GUNS) or (slot == WEAPONLOADOUT_TOOLS  and itemtab.Category == ITEMCAT_TOOLS) or (slot == WEAPONLOADOUT_MELEE  and itemtab.Category == ITEMCAT_MELEE) then	
					local oldwep = nil
					if slot == WEAPONLOADOUT_SLOT1 then 
						oldwep = pl:GetWeapon1()
						pl:SetWeapon1(itemtab.SWEP)
					elseif slot == WEAPONLOADOUT_SLOT2 then 
						oldwep = pl:GetWeapon2() 
						pl:SetWeapon2(itemtab.SWEP)
					elseif slot == WEAPONLOADOUT_TOOLS then
						oldwep = pl:GetWeaponToolslot()
						pl:SetWeaponToolslot(itemtab.SWEP)
					elseif slot == WEAPONLOADOUT_MELEE then
						oldwep = pl:GetWeaponMelee()
						pl:SetWeaponMelee(itemtab.SWEP)
					end
					if not self:GetWaveActive() and pl:Alive() then
						local newweptab = weapons.GetStored(itemtab.SWEP)
						if newweptab then
							local oldweptab = pl:GetWeapon(oldwep)
							local givenwep = pl:Give(itemtab.SWEP)
							if oldweptab and oldweptab.Primary then
								if oldweptab.Primary.DefaultClip > 0 and givenwep and givenwep:IsValid() and givenwep:IsWeapon() then
									local oldAmmoType = oldweptab:ValidPrimaryAmmo()
									local oldAmmoAmount = math.min(oldweptab.Primary.DefaultClip - oldweptab:GetMaxClip1(),pl:GetAmmoCount(oldAmmoType))
									local newAmmoType = givenwep:ValidPrimaryAmmo()
									local newAmmoAmount = givenwep.Primary.DefaultClip - givenwep:GetMaxClip1()
									if oldAmmoType and oldAmmoAmount and newAmmoType and newAmmoAmount and newAmmoType == oldAmmoType then
										if oldAmmoAmount < newAmmoAmount then
											pl:RemoveAmmo(oldAmmoAmount, oldAmmoType)
										else
											pl:RemoveAmmo(newAmmoAmount, oldAmmoType)
										end
									end
								end
								pl:StripWeapon(oldwep)
							end
							pl:SelectWeapon(itemtab.SWEP)
							self:RemoveUnusedAmmo(pl)
						end
					else
						pl:PrintTranslatedMessage(HUD_PRINTTALK, "will_appear_after_respawn")
					end
				end
			elseif itemtab.Callback then
				itemtab.Callback(pl)
			end
		end
	else
		if itemtab.ControllerWep and pl:HasWeapon(itemtab.ControllerWep) then
			pl:CenterNotify(COLOR_RED, translate.ClientGet(pl, "already_have_weapon"))
			pl:SendLua("surface.PlaySound(\"buttons/button10.wav\")")
			return
		end
		if itemtab.SWEP then
			local wep = pl:Give(itemtab.SWEP)
			if wep and wep:IsValid() then
				pl:SelectWeapon(itemtab.SWEP)
				if not (wep.IsConsumable or wep.AmmoIfHas) then
					if not table.HasValue(pl.ClassicModeNextInsureWeps,itemtab.SWEP) then
						table.insert(pl.ClassicModeNextInsureWeps,itemtab.SWEP)
					end
					for i,wepname in ipairs(pl.ClassicModeRemoveInsureWeps) do
						if isstring(wepname) and isstring(itemtab.SWEP) and string.lower(wepname) == string.lower(itemtab.SWEP) then
							table.remove(pl.ClassicModeRemoveInsureWeps,i)
						end
					end
					net.Start("zs_weapon_toinsure")
						net.WriteString(itemtab.SWEP)
					net.Send(pl)
				end
			end
		elseif itemtab.Callback then
			itemtab.Callback(pl)
		else
			return
		end
	end
	
	local cost = GetItemCost(itemtab)
	pl:TakePoints(cost)
	pl.PointsSpent = pl.PointsSpent + cost
	pl:PrintTranslatedMessage(HUD_PRINTTALK, "purchased_for_x_points", cost)
	pl:SendLua("surface.PlaySound(\"ambient/levels/labs/coinslot1.wav\")")
end

local function TimedOut(pl)
	if pl:IsValid() and pl:Alive() and (pl:Team() == TEAM_HUMAN or pl:Team() == TEAM_BANDIT) then
		--gamemode.Call("GiveRandomEquipment", pl)
	end
end

concommand.Add("zsb_dropactiveweapon", function(sender, command)
	if not (sender:IsValid() and sender:IsConnected() and sender:Alive()) then return end
	sender:DropActiveWeapon()
end)

concommand.Add("zsb_pointsshopbuy", function(sender, command, arguments)
	if not (sender:IsValid() and sender:IsConnected()) or #arguments == 0 then return end
	
	local id = arguments[1]
	local slot = tonumber(arguments[2])
	local itemtab = FindItem(id)

	gamemode.Call("PlayerPurchasePointshopItem",sender,itemtab,slot)
end)

concommand.Add("zsb_pointsshopupgrade", function(sender, command, arguments)
	if not (sender:IsValid() and sender:IsConnected()) or #arguments == 0 then return end
	local prev_id = arguments[1]
	local toupgrade_id = arguments[2]
	local revertmode = tobool(tonumber(arguments[3]))
	local slot = tonumber(arguments[4])
	local originaltab = FindItem(prev_id)
	local itemtab = FindItem(toupgrade_id)
	gamemode.Call("PlayerUpgradePointshopItem",sender,originaltab,itemtab,revertmode,slot)
end)

function GM:SpectatorThink(pl)
	if pl:GetObserverMode() == OBS_MODE_CHASE or pl:GetObserverMode() == OBS_MODE_IN_EYE then
		local target = pl:GetObserverTarget()
		if not target or not target:IsValid() or not target:IsPlayer() then
			pl:StripWeapons()
			pl:Spectate(OBS_MODE_ROAMING)
			pl:SpectateEntity(NULL)
		end
	end
	if pl:GetObserverMode() == OBS_MODE_NONE then -- Not in spectator yet.
		if self:GetWaveActive() then -- During wave.
			if not pl.StartSpectating or CurTime() >= pl.StartSpectating then
				pl.StartSpectating = nil
				pl:StripWeapons()
				pl:Spectate(OBS_MODE_ROAMING)
				pl:SpectateEntity(NULL)
			end			
		end
	end
end

function GM:PlayerDeathThink(pl)
	if self.RoundEnded then return end

	if pl:GetObserverMode() == OBS_MODE_CHASE or pl:GetObserverMode() == OBS_MODE_IN_EYE then
		local target = pl:GetObserverTarget()
		if not target or not target:IsValid() or not target:IsPlayer() then
			pl:StripWeapons()
			pl:Spectate(OBS_MODE_DEATHCAM)
			pl:SpectateEntity(NULL)
		end
	end
	if pl.NextSpawnTime and pl.NextSpawnTime <= CurTime() and pl:KeyDown(IN_ATTACK) then -- Force spawn.
		net.Start("zs_playerrespawntime")
			net.WriteFloat(-1)
			net.WriteEntity(pl)
		net.Broadcast()
		if not self:IsClassicMode() and not self.SuddenDeath then 
		pl.m_PreRespawn = true
		local teamspawns = {}
		teamspawns = team.GetValidSpawnPoint(pl:Team())
		pl:SetPos(teamspawns[ math.random(#teamspawns) ]:GetPos())
		pl:SetAbsVelocity(Vector(0,0,0))
		pl:UnSpectateAndSpawn()
		pl.m_PreRespawn = nil
		pl.SpawnedTime = CurTime()
		pl.NextSpawnTime = nil
		net.Start("zs_playerredeemed")
			net.WriteEntity(pl)
			net.WriteString(pl:Name())
		net.Broadcast()	
		end
	elseif pl:GetObserverMode() == OBS_MODE_NONE then -- Not in spectator yet.
		if self:GetWaveActive() then -- During wave.
			if not pl.StartSpectating or CurTime() >= pl.StartSpectating then
				pl.StartSpectating = nil
				pl:StripWeapons()
				pl:Spectate(OBS_MODE_DEATHCAM)
				pl:SpectateEntity(NULL)
			end
		end
	end
end

function GM:CanRespawnQuicker(ply)
	if ply == nil or not ply:IsPlayer() or self:IsSampleCollectMode() then return false end
	local banditobjs, humanobjs = 0,0
	for _, ent in pairs(ents.FindByClass("prop_obj_transmitter")) do
		if ent:GetTransmitterCaptureProgress() > 0 then
			if ent:GetTransmitterTeam() == TEAM_BANDIT then
				banditobjs = banditobjs + 1
			elseif ent:GetTransmitterTeam() == TEAM_HUMAN then
				humanobjs = humanobjs + 1
			end
		end
	end
	if (banditobjs < humanobjs and ply:Team() == TEAM_BANDIT) or (humanobjs < banditobjs and ply:Team() == TEAM_HUMAN) then
		--ply:CenterNotify(COLOR_RED, translate.ClientGet(pl, "respawn_quicker"))
		return true
	else
		return false
	end
end

function GM:PropBreak(attacker, ent)
	gamemode.Call("PropBroken", ent, attacker)
end

function GM:PropBroken(ent, attacker)
end

function GM:EntityTakeDamage(ent, dmginfo)
	local attacker, inflictor = dmginfo:GetAttacker(), dmginfo:GetInflictor()

	if attacker == inflictor and attacker:IsProjectile() and dmginfo:GetDamageType() == DMG_CRUSH then -- Fixes projectiles doing physics-based damage.
		dmginfo:SetDamage(0)
		dmginfo:ScaleDamage(0)
		return
	end

	if ent._BARRICADEBROKEN then
		dmginfo:SetDamage(dmginfo:GetDamage() * 3)
	end

	if ent.GetObjectHealth then
		ent.m_LastDamaged = CurTime()
	end

	if ent.ProcessDamage and ent:ProcessDamage(dmginfo) then return end
	attacker, inflictor = dmginfo:GetAttacker(), dmginfo:GetInflictor()

	-- Don't allow blowing up props during wave 0.
	if self:GetWave() <= 0 and string.sub(ent:GetClass(), 1, 12) == "prop_physics" and inflictor.NoPropDamageDuringWave0 then
		dmginfo:SetDamage(0)
		dmginfo:SetDamageType(DMG_BULLET)
		return
	end

	-- We need to stop explosive chains team killing.
	if inflictor:IsValid() then
		local dmgtype = dmginfo:GetDamageType()
		if dmgtype == DMG_BLAST or dmgtype == DMG_BURN or dmgtype == DMG_SLOWBURN then
			if ent:IsPlayer() then

				if inflictor.LastExplosionTeam == ent:Team() and inflictor.LastExplosionAttacker ~= ent and inflictor.LastExplosionTime and CurTime() < inflictor.LastExplosionTime + 10 then -- Player damaged by physics object explosion / fire.
					dmginfo:SetDamage(0)
					dmginfo:ScaleDamage(0)
					return
				end
			elseif inflictor ~= ent and string.sub(ent:GetClass(), 1, 12) == "prop_physics" and string.sub(inflictor:GetClass(), 1, 12) == "prop_physics" then -- Physics object damaged by physics object explosion / fire.
				ent.LastExplosionAttacker = inflictor.LastExplosionAttacker
				ent.LastExplosionTeam = inflictor.LastExplosionTeam
				ent.LastExplosionTime = CurTime()
			end
		elseif inflictor:IsPlayer() and string.sub(ent:GetClass(), 1, 12) == "prop_physics" then -- Physics object damaged by player.
			if ent:IsPlayer() and inflictor:Team() == ent:Team() then
				local phys = ent:GetPhysicsObject()
				if phys:IsValid() and phys:HasGameFlag(FVPHYSICS_PLAYER_HELD) and inflictor:GetCarry() ~= ent or ent._LastDropped and CurTime() < ent._LastDropped + 3 and ent._LastDroppedBy ~= inflictor then -- Human player damaged a physics object while it was being carried or recently carried. They weren't the carrier.
					dmginfo:SetDamage(0)
					dmginfo:ScaleDamage(0)
					return
				end
			end

			ent.LastExplosionAttacker = inflictor
			ent.LastExplosionTeam = inflictor:Team()
			ent.LastExplosionTime = CurTime()
		end
	end

	-- Prop is nailed. Forward damage to the nails.
	if ent:DamageNails(attacker, inflictor, dmginfo:GetDamage(), dmginfo) then return end

	local dispatchdamagedisplay = false

	local entclass = ent:GetClass()
	if ent:IsPlayer() then
		dispatchdamagedisplay = true
		if attacker:IsValid() then
			if attacker:IsPlayer() then
				ent:SetLastAttacker(attacker)

				local myteam = attacker:Team()
				local otherteam = ent:Team()
				if myteam ~= otherteam then
					damage = math.min(dmginfo:GetDamage(), ent:Health())
					if damage > 0 then
						attacker.DamageDealt = attacker.DamageDealt + damage

						attacker:AddLifeEnemyDamage(damage)
						ent.DamagedBy[attacker] = (ent.DamagedBy[attacker] or 0) + damage
						attacker.m_PointQueue = attacker.m_PointQueue + math.max(math.Clamp(damage / ent:GetMaxHealth(),0,1) * (ent:GetBounty()+ math.Clamp(math.floor(ent:GetFullPoints()/100),0,50)),0)
						local pos = ent:GetPos()
						pos.z = pos.z + 32
						attacker.m_LastDamageDealtPosition = pos
						attacker.m_LastDamageDealt = CurTime()
					end
				end
			elseif attacker:GetClass() == "trigger_hurt" then
				ent.LastHitWithTriggerHurt = CurTime()
			end
		end
	elseif ent.PropHealth then -- A prop that was invulnerable and converted to vulnerable.
		if self.NoPropDamageFromHumanMelee and attacker:IsPlayer() and (attacker:Team() == TEAM_HUMAN or attacker:Team() == TEAM_BANDIT) and inflictor.IsMelee then
			dmginfo:SetDamage(0)
			return
		end

		ent.PropHealth = ent.PropHealth - dmginfo:GetDamage()

		dispatchdamagedisplay = true

		if ent.PropHealth <= 0 then
			local effectdata = EffectData()
				effectdata:SetOrigin(ent:GetPos())
			util.Effect("Explosion", effectdata, true, true)
			ent:Fire("break")

			gamemode.Call("PropBroken", ent, attacker)
		else
			local brit = math.Clamp(ent.PropHealth / ent.TotalHealth, 0, 1)
			local col = ent:GetColor()
			col.r = 255
			col.g = 255 * brit
			col.b = 255 * brit
			ent:SetColor(col)
		end
	elseif entclass == "func_door_rotating" then
		if ent:GetKeyValues().damagefilter == "invul" or ent.Broken then return end

		if not ent.Heal then
			local br = ent:BoundingRadius()
			--if br > 80 then return end -- Don't break these kinds of doors that are bigger than this.

			local health = br * 15
			ent.Heal = health
			ent.TotalHeal = health
		end

		if dmginfo:GetDamage() >= 20 and attacker:IsPlayer() and (attacker:Team() == TEAM_HUMAN or attacker:Team() == TEAM_BANDIT) then
			ent:EmitSound(math.random(2) == 1 and "npc/zombie/zombie_pound_door.wav" or "ambient/materials/door_hit1.wav")
		end

		ent.Heal = ent.Heal - dmginfo:GetDamage()
		local brit = math.Clamp(ent.Heal / ent.TotalHeal, 0, 1)
		local col = ent:GetColor()
		col.r = 255
		col.g = 255 * brit
		col.b = 255 * brit
		ent:SetColor(col)

		dispatchdamagedisplay = true

		if ent.Heal <= 0 then
			ent.Broken = true

			ent:EmitSound("Breakable.Metal")
			ent:Fire("unlock", "", 0)
			ent:Fire("open", "", 0.01) -- Trigger any area portals.
			ent:Fire("break", "", 0.1)
			ent:Fire("kill", "", 0.15)
		end
	elseif entclass == "prop_door_rotating" then
		--if ent:GetKeyValues().damagefilter == "invul" or ent:HasSpawnFlags(2048) or ent.Broken then return end

		ent.Heal = ent.Heal or ent:BoundingRadius() * 15
		ent.TotalHeal = ent.TotalHeal or ent.Heal

		if dmginfo:GetDamage() >= 20 and attacker:IsPlayer() then
			ent:EmitSound(math.random(2) == 1 and "npc/zombie/zombie_pound_door.wav" or "ambient/materials/door_hit1.wav")
		end

		ent.Heal = ent.Heal - dmginfo:GetDamage()
		local brit = math.Clamp(ent.Heal / ent.TotalHeal, 0, 1)
		local col = ent:GetColor()
		col.r = 255
		col.g = 255 * brit
		col.b = 255 * brit
		ent:SetColor(col)

		dispatchdamagedisplay = true

		if ent.Heal <= 0 then
			ent.Broken = true

			ent:EmitSound("Breakable.Metal")
			ent:Fire("unlock", "", 0)
			ent:Fire("open", "", 0.01) -- Trigger any area portals.
			ent:Fire("break", "", 0.1)
			ent:Fire("kill", "", 0.15)

			local physprop = ents.Create("prop_physics")
			if physprop:IsValid() then
				physprop:SetPos(ent:GetPos())
				physprop:SetAngles(ent:GetAngles())
				physprop:SetSkin(ent:GetSkin() or 0)
				physprop:SetMaterial(ent:GetMaterial())
				physprop:SetModel(ent:GetModel())
				physprop:Spawn()
				physprop:SetPhysicsAttacker(attacker)
				if attacker:IsValid() then
					local phys = physprop:GetPhysicsObject()
					if phys:IsValid() then
						phys:SetVelocityInstantaneous((physprop:NearestPoint(attacker:EyePos()) - attacker:EyePos()):GetNormalized() * math.Clamp(dmginfo:GetDamage() * 3, 40, 300))
					end
				end
				if physprop:GetMaxHealth() == 1 and physprop:Health() == 0 then
					local health = math.ceil((physprop:OBBMins():Length() + physprop:OBBMaxs():Length()) * 2)
					if health < 2000 then
						physprop.PropHealth = health
						physprop.TotalHealth = health
					end
				end
			end
		end
	elseif string.sub(entclass, 1, 12) == "func_physbox" then
		local holder, status = ent:GetHolder()
		if holder then status:Remove() end

		if ent:GetKeyValues().damagefilter == "invul" then return end

		ent.Heal = ent.Heal or ent:BoundingRadius() * 15
		ent.TotalHeal = ent.TotalHeal or ent.Heal

		ent.Heal = ent.Heal - dmginfo:GetDamage()
		local brit = math.Clamp(ent.Heal / ent.TotalHeal, 0, 1)
		local col = ent:GetColor()
		col.r = 255
		col.g = 255 * brit
		col.b = 255 * brit
		ent:SetColor(col)

		dispatchdamagedisplay = true

		if ent.Heal <= 0 then
			local foundaxis = false
			local entname = ent:GetName()
			local allaxis = ents.FindByClass("phys_hinge")
			for _, axis in pairs(allaxis) do
				local keyvalues = axis:GetKeyValues()
				if keyvalues.attach1 == entname or keyvalues.attach2 == entname then
					foundaxis = true
					axis:Remove()
					ent.Heal = ent.Heal + 120
				end
			end

			if not foundaxis then
				ent:Fire("break", "", 0)
			end
		end
	elseif entclass == "func_breakable" then
		if ent:GetKeyValues().damagefilter == "invul" then return end

		if ent:Health() == 0 and ent:GetMaxHealth() == 1 then return end

		local brit = math.Clamp(ent:Health() / ent:GetMaxHealth(), 0, 1)
		local col = ent:GetColor()
		col.r = 255
		col.g = 255 * brit
		col.b = 255 * brit
		ent:SetColor(col)

		dispatchdamagedisplay = true
	elseif ent:IsBarricadeProp() and attacker:IsPlayer() and not ent.NoDamageNumbers and not ent:IsSameTeam(attacker)then
		dispatchdamagedisplay = true
	end
	if dmginfo:GetDamage() > 0 then
		local holder, status = ent:GetHolder()
		if holder then status:Remove() end

		if attacker:IsPlayer() and dispatchdamagedisplay then
			self:DamageFloater(attacker, ent, dmginfo)
		end
	end
end

function GM:DamageFloater(attacker, victim, dmginfo)
	local dmgpos = dmginfo:GetDamagePosition()
	if dmgpos == vector_origin then dmgpos = victim:NearestPoint(attacker:EyePos()) end

	net.Start(victim:IsPlayer() and "zs_dmg" or "zs_dmg_prop")
		if INFDAMAGEFLOATER then
			INFDAMAGEFLOATER = nil
			net.WriteUInt(9999, 16)
		else
			net.WriteUInt(math.ceil(dmginfo:GetDamage()), 16)
		end
		net.WriteVector(dmgpos)
	net.Send(attacker)
end

function GM:PlayerChangedTeam(pl, oldteam, newteam)
	local uid = pl:SteamID64()
	if newteam == TEAM_HUMAN or newteam == TEAM_BANDIT then
		pl.DamagedBy = {}
		self.PreviouslyDied[uid] = nil
		pl:SetBarricadeGhosting(false)
		timer.Simple(0.25, function() pl:RefreshPlayerModel() end)
	elseif newteam == TEAM_SPECTATOR then
		self.PreviousTeam[uid] = oldteam
		self.PreviousPoints[uid] = pl:GetPoints()
	end
	pl:SetLastAttacker(nil)
	for _, p in pairs(player.GetAll()) do
		if p.LastAttacker == pl then
			p.LastAttacker = nil
		end
	end

	pl.m_PointQueue = 0
end

function GM:AllowPlayerPickup(pl, ent)
	return false
end

function GM:PlayerShouldTakeDamage(pl, attacker)
	if attacker.PBAttacker and attacker.PBAttacker:IsValid() and CurTime() < attacker.NPBAttacker then -- Protection against prop_physbox team killing. physboxes don't respond to SetPhysicsAttacker()
		attacker = attacker.PBAttacker
	end
	local status = pl:GetStatus("spawnbuff")
	if status and status:IsValid() then
		return false
	end
	if attacker:IsPlayer() and attacker ~= pl and attacker:Team() == pl:Team() then return false end

	return true
end

function GM:PlayerHurt(victim, attacker, healthremaining, damage)
	if 0 < healthremaining then
		victim:PlayPainSound()
	end
end

function GM:WeaponDeployed(pl, wep)
	pl:ResetSpeed()
end

function GM:KeyPress(pl, key)
	if (not pl:Alive() or pl:Team() != TEAM_BANDIT and pl:Team() != TEAM_HUMAN) and pl:GetObserverMode() ~= OBS_MODE_NONE then
		if key == IN_ATTACK2 then
			pl.SpectatedPlayerKey = (pl.SpectatedPlayerKey or 0) + 1
			local living = {}
			if pl:IsSpectator() then
				for _, v in pairs(player.GetAll()) do
					if v:Alive() then table.insert(living, v) end
				end
			elseif pl:Team() == TEAM_HUMAN or pl:Team() == TEAM_BANDIT then
				for _, v in pairs(team.GetPlayers(pl:Team())) do
					if v:Alive() then table.insert(living, v) end
				end
			end	
			pl:StripWeapons()

			if pl.SpectatedPlayerKey > #living then
				pl.SpectatedPlayerKey = 1
			end
			local specplayer = living[pl.SpectatedPlayerKey]
			if specplayer and specplayer:IsPlayer() and specplayer:Alive() then
				local lastspecmode = pl:GetObserverMode()
				if (lastspecmode != OBS_MODE_CHASE and lastspecmode != OBS_MODE_IN_EYE) then 
					lastspecmode = OBS_MODE_CHASE
				end
				pl:Spectate(lastspecmode)
				pl:SpectateEntity(specplayer)
				pl:SetupHands(specplayer)
			end
		elseif key == IN_DUCK then 
			local specplayer = pl:GetObserverTarget()
			if specplayer and specplayer:IsPlayer() and specplayer:Alive() then
				if pl:GetObserverMode() == OBS_MODE_CHASE then
					pl:Spectate(OBS_MODE_IN_EYE)
					pl:SpectateEntity(specplayer)
					pl:SetupHands(specplayer)
				elseif pl:GetObserverMode() == OBS_MODE_IN_EYE then
					pl:Spectate(OBS_MODE_CHASE)
					pl:SpectateEntity(specplayer)
				end
			end
		elseif key == IN_JUMP then
			if pl:IsSpectator() and pl:GetObserverMode() != OBS_MODE_ROAMING then
				pl:Spectate(OBS_MODE_ROAMING)
				pl:SpectateEntity(nil)
				pl.SpectatedPlayerKey = nil
			end
		end
	end
	if key == IN_USE then
		if (pl:Team() == TEAM_HUMAN or pl:Team() == TEAM_BANDIT) and pl:Alive() then
			if pl:IsCarrying() then
				pl.status_human_holding:RemoveNextFrame()
			else
				self:TryHumanPickup(pl, pl:TraceLine(64).Entity)
			end
		end
	elseif key == IN_SPEED then
		if pl:Alive() then
			if (pl:Team() == TEAM_HUMAN or pl:Team() == TEAM_BANDIT) then
				pl:DispatchAltUse()
			end
		end
	--elseif key == IN_WALK then
	elseif key == IN_ZOOM then
		if (pl:Team() == TEAM_HUMAN or pl:Team() == TEAM_BANDIT) and pl:Alive() and pl:IsOnGround() then
			pl:SetBarricadeGhosting(true)
		end
	end
end

function GM:GetNearestSpawn(pos, teamid)
	local nearest = NULL

	local nearestdist = math.huge
	for _, ent in pairs(team.GetValidSpawnPoint(teamid)) do
		if ent.Disabled then continue end

		local dist = ent:GetPos():Distance(pos)
		if dist < nearestdist then
			nearestdist = dist
			nearest = ent
		end
	end

	return nearest
end

function GM:EntityWouldBlockSpawn(ent)
	local spawnpoint = self:GetNearestSpawn(ent:GetPos(), TEAM_BANDIT)

	if spawnpoint:IsValid() then
		local spawnpos = spawnpoint:GetPos()
		if spawnpos:Distance(ent:NearestPoint(spawnpos)) <= 40 then return true end
	end

	return false
end

function GM:GetNearestSpawnDistance(pos, teamid)
	local nearest = self:GetNearestSpawn(pos, teamid)
	if nearest:IsValid() then
		return nearest:GetPos():Distance(pos)
	end

	return -1
end

function GM:PlayerUse(pl, ent)
	if not pl:Alive() or pl:GetBarricadeGhosting() then return false end

	if pl:IsHolding() and pl:GetHolding() ~= ent then return false end

	local entclass = ent:GetClass()
	if entclass == "prop_door_rotating" then
		if CurTime() < (ent.m_AntiDoorSpam or 0) then -- Prop doors can be glitched shut by mashing the use button.
			return false
		end
		ent.m_AntiDoorSpam = CurTime() + 1
	elseif (pl:Team() == TEAM_HUMAN or pl:Team() == TEAM_BANDIT) and not pl:IsCarrying() and pl:KeyPressed(IN_USE) then
		self:TryHumanPickup(pl, ent)
	end

	return true
end

function GM:PlayerDeath(pl, inflictor, attacker)
	pl.NextSpawnTime = nil
	if self.PreviouslyDied[pl:SteamID64()]<=CurTime() or pl.NextSpawnTime == nil and not self:IsClassicMode() and not self.SuddenDeath then
		local mult = 1
		if self:IsSampleCollectMode() then
			mult = 0.7
		end
		if self:CanRespawnQuicker(pl) then mult = mult - 0.3 end
		if pl:LessPlayersOnTeam() then mult = mult - 0.25 end
		pl.NextSpawnTime = CurTime()+14*mult
		net.Start("zs_playerrespawntime")
			net.WriteFloat(pl.NextSpawnTime)
			net.WriteEntity(pl)
		net.Broadcast()
	end
	if self:IsClassicMode() then
		self.RoundEndCamPos = pl:WorldSpaceCenter()
		net.Start("zs_roundendcampos")
			net.WriteVector(self.RoundEndCamPos)
		net.Broadcast()
	end
	if self:GetWaveActive() and (self:IsClassicMode() or self.SuddenDeath) then 
		local banditcount = 0
		local humancount = 0
		for _, bandit in pairs(team.GetPlayers(TEAM_BANDIT)) do
			if bandit:Alive() then banditcount = banditcount +1 end
		end
		for _, human in pairs(team.GetPlayers(TEAM_HUMAN)) do
			if human:Alive() then humancount = humancount +1 end
		end
		if humancount == 0 or banditcount == 0 then
			self.SuddenDeath = false
			net.Start("zs_suddendeath")
				net.WriteBool( false )
			net.Broadcast()
			if humancount >=1 then
				gamemode.Call("WaveEndWithWinner", TEAM_HUMAN)
				for _, pl in pairs(player.GetAll()) do
					pl:CenterNotify(COLOR_DARKGREEN, translate.ClientFormat(pl, "x_killed_all_enemies",translate.ClientGet(pl,"teamname_human")))
				end
			elseif banditcount >=1 then			
				gamemode.Call("WaveEndWithWinner", TEAM_BANDIT)
				for _, pl in pairs(player.GetAll()) do
					pl:CenterNotify(COLOR_DARKGREEN, translate.ClientFormat(pl, "x_killed_all_enemies",translate.ClientGet(pl,"teamname_bandit")))
				end
			else
				gamemode.Call("WaveEndWithWinner", nil)
				for _, pl in pairs(player.GetAll()) do
					pl:CenterNotify(COLOR_DARKRED, translate.ClientFormat(pl, "all_dead"))
				end
			end
		end
	end
end

function GM:PostPlayerDeath(pl)
end

function GM:PlayerDeathSound()
	return true
end

local function SortDist(a, b)
	return a._temp < b._temp
end

function GM:CanPlayerSuicide(pl)
	if self.RoundEnded then return false end
	return pl:GetObserverMode() == OBS_MODE_NONE and pl:Alive()
end

function GM:PlayerKilledEnemy(pl, attacker, inflictor, dmginfo, headshot, suicide)
	local totaldamage = 0
	for otherpl, dmg in pairs(pl.DamagedBy) do
		if otherpl:IsValid() and otherpl:Team() ~= pl:Team() then
			totaldamage = totaldamage + dmg
		end
	end

	local mostassistdamage = 0
	local halftotaldamage = totaldamage / 2
	local mostdamager
	for otherpl, dmg in pairs(pl.DamagedBy) do
		if otherpl ~= attacker and otherpl:IsValid() and otherpl:Team() ~= pl:Team() and dmg > mostassistdamage and dmg >= halftotaldamage then
			mostassistdamage = dmg
			mostdamager = otherpl
		end
	end
	
	attacker:AddLifeEnemyKills(1)
	if attacker.HighestLifeEnemyKills and attacker.HighestLifeEnemyKills < attacker.LifeEnemyKills then
		attacker.HighestLifeEnemyKills = attacker.LifeEnemyKills
	end
	attacker:AddFrags(1)
	if inflictor.IsMelee then
		attacker.MeleeKilled = attacker.MeleeKilled + 1
	end
	if headshot then
		attacker.HeadshotKilled = attacker.HeadshotKilled + 1
	end
	local bountymult = 	self:IsClassicMode() and 2 or 1
	if pl.BountyModifier > 0 then
		pl.BountyModifier = math.max(0,pl.BountyModifier - 2 * bountymult)
	else
		pl.BountyModifier = math.max(self.PointsPerKill* bountymult*-1,pl.BountyModifier - math.abs(math.ceil(pl.BountyModifier*bountymult/self.PointsPerKill)))
	end
	if attacker.BountyModifier < 0 then
		attacker.BountyModifier = ((attacker.BountyModifier < -3*bountymult) and attacker.BountyModifier + 2 or 0)
	else
		attacker.BountyModifier = attacker.BountyModifier + 2
	end
	if mostdamager then
		attacker:PointCashOut(pl, FM_LOCALKILLOTHERASSIST)
		mostdamager:PointCashOut(pl, FM_LOCALASSISTOTHERKILL)

		mostdamager.EnemyKilledAssists = mostdamager.EnemyKilledAssists + 1
	else
		attacker:PointCashOut(pl, FM_NONE)
	end
	local killerstreak = attacker.LifeEnemyKills

	net.Start("zs_killstreak")
		net.WriteEntity(attacker)
		net.WriteInt(killerstreak,16)
		net.WriteString(attacker:Name())
	net.Broadcast()	
	gamemode.Call("PostPlayerKilledEnemy", pl, attacker, inflictor, dmginfo, mostdamager, mostassistdamage, headshot)

	return mostdamager
end

function GM:PostPlayerKilledEnemy(pl, attacker, inflictor, dmginfo, assistpl, assistamount, headshot)
end

function GM:DoPlayerDeath(pl, attacker, dmginfo)
	pl:PurgeStatusEffects()
	local inflictor = dmginfo:GetInflictor()
	local plteam = pl:Team()
	local ct = CurTime()
	local suicide = attacker == pl or attacker:IsWorld()
	pl:Freeze(false)

	local headshot = pl:WasHitInHead() and not inflictor.IgnoreDamageScaling 
	if suicide then attacker = pl:GetLastAttacker() or attacker end
	pl:SetLastAttacker()
	
	if inflictor == NULL then inflictor = attacker end

	if inflictor == attacker and attacker:IsPlayer() then
		local wep = attacker:GetActiveWeapon()
		if wep:IsValid() then
			inflictor = wep
		end
	end

	if headshot and not (dmginfo:GetDamageType() == DMG_CLUB) then
		local effectdata = EffectData()
			effectdata:SetOrigin(dmginfo:GetDamagePosition())
			local force = dmginfo:GetDamageForce()
			effectdata:SetMagnitude(force:Length() * 3)
			effectdata:SetNormal(force:GetNormalized())
			effectdata:SetEntity(pl)
		util.Effect("headshot", effectdata, true, true)
		if dmginfo:GetDamageType() == DMG_SLASH then
			local headbonei = pl:LookupBone("ValveBiped.Bip01_Head1")
			local headpos, headang = pl:GetBonePosition(headbonei)
			if headpos == pl:GetPos() then
				headpos = pl:GetBoneMatrix(headbonei):GetTranslation()
			end
			local ent = ents.CreateLimited("prop_playergib")
			if ent:IsValid() then
				ent:SetPos(headpos)
				ent:SetAngles(headang)
				ent:SetGibType(1)
				ent:Spawn()
			end
		end
	end
	if pl:Health() <= -70 and not pl.NoGibs then
		pl:Gib(dmginfo)
	else
		pl:CreateRagdoll()
	end

	pl:RemoveStatus("overridemodel", false, true)

	local assistpl
	
	pl:PlayDeathSound()
	if (pl.LifeBarricadeDamage ~= 0 or pl.LifeEnemyDamage ~= 0 or pl.LifeEnemyKills ~= 0) then
		net.Start("zs_lifestats")
			net.WriteUInt(math.ceil(pl.LifeBarricadeDamage or 0), 24)
			net.WriteUInt(math.ceil(pl.LifeEnemyDamage or 0), 24)
			net.WriteUInt(pl.LifeEnemyKills or 0, 16)
		net.Send(pl)
	end
	local samplestodrop = 0
	if attacker:IsValid() and attacker:IsPlayer() and attacker ~= pl then
		assistpl = gamemode.Call("PlayerKilledEnemy", pl, attacker, inflictor, dmginfo, headshot, suicide)
		if self:IsSampleCollectMode() then
			-- Increases sample drop count when there are fewer playes online than the specified threshold
			local lowPlayerCountThreshold = GAMEMODE.LowPlayerCountThreshold - 2

			local playersCount = math.min(lowPlayerCountThreshold, player.GetCount() - 2)

			samplestodrop = samplestodrop + 3 + math.ceil(GAMEMODE.LowPlayerCountSamplesMaxAdditionalCountPlayer * (1 - playersCount / lowPlayerCountThreshold))
			
			if headshot then 
				samplestodrop = samplestodrop * 2
			end
		end
	end
	if self:IsClassicMode() then
		pl.ClassicModeNextInsureWeps = {}
		pl.ClassicModeRemoveInsureWeps = {}
	end
	if self:IsSampleCollectMode() then
		if pl:GetSamples() > 0 then
			samplestodrop = samplestodrop + pl:GetSamples()	
		end
		if samplestodrop > 0 then
			pl:DropSample(samplestodrop)
		end
	end
	pl:DropAll()
	pl:AddDeaths(1)
	self.PreviouslyDied[pl:SteamID64()] = CurTime()
	if self:GetWave() == 0 then
		pl.DiedDuringWave0 = true
	end

	if pl.SpawnedTime then
		pl.SurvivalTime = math.max(ct - pl.SpawnedTime, pl.SurvivalTime or 0)
		pl.SpawnedTime = nil
	end
			
	local hands = pl:GetHands()
	if IsValid(hands) then
		hands:Remove()
	end
	--if pl.NextSpawnTime
	if attacker == pl then
		net.Start("zs_pl_kill_self")
			net.WriteEntity(pl)
			net.WriteUInt(plteam, 16)
		net.Broadcast()
	elseif attacker:IsPlayer() then
		if assistpl then
			net.Start("zs_pls_kill_pl")
				net.WriteEntity(pl)
				net.WriteEntity(attacker)
				net.WriteEntity(assistpl)
				net.WriteString(inflictor:GetClass())
				net.WriteUInt(plteam, 16)
				net.WriteUInt(attacker:Team(), 16) -- Assuming assistants are always on the same team.
				net.WriteBit(headshot)
			net.Broadcast()

			gamemode.Call("PlayerKilledByPlayer", pl, assistpl, inflictor, headshot, dmginfo, true)
		else
			net.Start("zs_pl_kill_pl")
				net.WriteEntity(pl)
				net.WriteEntity(attacker)
				net.WriteString(inflictor:GetClass())
				net.WriteUInt(plteam, 16)
				net.WriteUInt(attacker:Team(), 16)
				net.WriteBit(headshot)
			net.Broadcast()
		end

		gamemode.Call("PlayerKilledByPlayer", pl, attacker, inflictor, headshot, dmginfo)
	else
		net.Start("zs_death")
			net.WriteEntity(pl)
			net.WriteString(inflictor:GetClass())
			net.WriteString(attacker:GetClass())
			net.WriteUInt(plteam, 16)
		net.Broadcast()
	end
end

function GM:PlayerKilledByPlayer(pl, attacker, inflictor, headshot, dmginfo)
end

function GM:PlayerCanPickupWeapon(pl, ent)
	if pl:IsSpectator() then return false end

	return ent:GetClass() ~= "weapon_stunstick"
end

function GM:PlayerFootstep(pl, vPos, iFoot, strSoundName, fVolume, pFilter)
end

function GM:PlayerStepSoundTime(pl, iType, bWalking)
	local fStepTime = 350

	if iType == STEPSOUNDTIME_NORMAL or iType == STEPSOUNDTIME_WATER_FOOT then
		local fMaxSpeed = pl:GetMaxSpeed()
		if fMaxSpeed <= 100 then
			fStepTime = 400
		elseif fMaxSpeed <= 300 then
			fStepTime = 350
		else
			fStepTime = 250
		end
	elseif iType == STEPSOUNDTIME_ON_LADDER then
		fStepTime = 450
	elseif iType == STEPSOUNDTIME_WATER_KNEE then
		fStepTime = 600
	end

	if pl:Crouching() then
		fStepTime = fStepTime + 50
	end

	return fStepTime
end

function GM:GetTeamPoints(teamid)
	local total = 0
	for _, v in pairs(team.GetPlayers(teamid)) do
		total = total + v:GetFullPoints()
	end
	return total
end

function GM:GetTeamKillAdvantage(teamid)
	return team.TotalFrags(teamid) - team.TotalDeaths(teamid)
end

function GM:PlayerSpawn(pl)
	pl:StripWeapons()
	--pl:RemoveSuit()
	pl:PurgeStatusEffects()
	if pl:GetMaterial() ~= "" then
		pl:SetMaterial("")
	end
	pl:UnSpectate()

	pl.StartSpectating = nil
	pl.Gibbed = nil

	pl.SpawnNoSuicide = CurTime() + 1
	pl.SpawnedTime = CurTime()
	pl.NextSpawnTime = nil
	
	pl:ShouldDropWeapon(false)

	pl:SetBodyArmor(0)
	pl:SetLegDamage(0)
	pl:SetSamples(0)
	pl:SetLastAttacker()
	if (pl:IsSpectator()) then
		if pl:GetInfo("zsb_spectator") == "1" then
			pl:StripWeapons( )
			pl:Spectate( OBS_MODE_ROAMING )
			return false;
		else
			gamemode.Call("PlayerInitialSpawnRound", pl)
		end
	end
	pl:RemoveStatus("overridemodel", false, true)
	self.PreviouslyDied[pl:SteamID64()] = nil 
			
	if (pl:Team() == TEAM_HUMAN or pl:Team() == TEAM_BANDIT) then
		pl.HighestLifeEnemyKills = 0
		pl.LifeBarricadeDamage = 0
		pl.LifeEnemyDamage = 0
		pl.LifeEnemyKills = 0
		pl.DamagedBy = {}
		pl.m_PointQueue = 0
		pl.PackedItems = {}
		pl:RefreshPlayerModel()
		pl:ResetSpeed()
		pl:SetJumpPower(DEFAULT_JUMP_POWER)
		pl:SetCrouchedWalkSpeed(0.65)
		pl:DoHulls()
		
		pl:SetNoTarget(false)
		
		pl:SetMaxHealth(100)

		local nosend = not pl.DidInitPostEntity
		pl.HumanRepairMultiplier = nil
		pl.HumanHealMultiplier = nil
		pl.HumanSpeedAdder = 0
		
		pl.NoObjectPickup = nil
		pl.DamageVulnerability = nil
			
		pl:SetupHands()

		if self:IsClassicMode() then
			for _, wep in pairs(pl.ClassicModeInsuredWeps) do
				local storedwep = weapons.GetStored(wep)
				if storedwep then
					local given = pl:Give(wep)
					if given then
						net.Start("zs_insure_weapon")
							net.WriteString(wep)
							net.WriteBool(false)
						net.Send(pl)
					end
				end
			end
		else
			pl:UpdateWeaponLoadouts()
			if not self.SuddenDeath then
				local buff = pl:GiveStatus("spawnbuff")
				if buff and IsValid(buff) then
					buff:SetOwner(pl)
				end
			end
		end
	end

	local pcol = Vector(pl:GetInfo("cl_playercolor"))
	pcol.x = math.Clamp(pcol.x, 0, 2.5)
	pcol.y = math.Clamp(pcol.y, 0, 2.5)
	pcol.z = math.Clamp(pcol.z, 0, 2.5)
	pl:SetPlayerColor(pcol)

	local wcol = Vector(pl:GetInfo("cl_weaponcolor"))
	wcol.x = math.Clamp(wcol.x, 0, 2.5)
	wcol.y = math.Clamp(wcol.y, 0, 2.5)
	wcol.z = math.Clamp(wcol.z, 0, 2.5)
	pl:SetWeaponColor(wcol)
end

function GM:SetWave(wave)
	SetGlobalInt("wave", wave)
end

function GM:WaveStateChanged(newstate)
	if newstate then
		local players = player.GetAllActive()
		for _, pl in pairs(players) do
			if not pl:Alive() then
				pl.m_PreRespawn = true
				local teamspawns = {}
				teamspawns = team.GetValidSpawnPoint(pl:Team())
				pl:SetPos(teamspawns[ math.random(#teamspawns) ]:GetPos())
				pl:SetAbsVelocity(Vector(0,0,0))
				pl:UnSpectateAndSpawn()
				pl.m_PreRespawn = nil
				pl.SpawnedTime = CurTime()
				pl.NextSpawnTime = nil
				net.Start("zs_playerredeemed")
					net.WriteEntity(pl)
					net.WriteString(pl:Name())
				net.Broadcast()	
			end
		end
		self.RoundEndCamPos = nil
			
		local prevwave = self:GetWave()

		if prevwave >= self:GetNumberOfWaves() and not self.SuddenDeath then return end
		if not self:IsClassicMode() and not self.SuddenDeath then
			if self:IsTransmissionMode() then
				gamemode.Call("CreateObjectives","prop_obj_transmitter",false)
			elseif self:IsSampleCollectMode() then
				gamemode.Call("CreateObjectives","prop_sampledepositterminal",true)
			end
		end
		gamemode.Call("SetWave", prevwave + 1)
		gamemode.Call("SetWaveStart", CurTime())
		self.NextNestSpawn = CurTime() + 45
		gamemode.Call("SetWaveEnd", self:GetWaveStart() + self:GetWaveOneLength() * (self:IsClassicMode() and 0.5 or 1) - (self:GetWave() - 1) * self.TimeLostPerWave* (self:IsClassicMode() and 0 or 1) )

		net.Start("zs_wavestart")
			net.WriteInt(self:GetWave(), 16)
			net.WriteFloat(self:GetWaveEnd())
		net.Broadcast()


		local curwave = self:GetWave()
		for _, ent in pairs(ents.FindByClass("logic_waves")) do
			if ent.Wave == curwave or ent.Wave == -1 then
				ent:Input("onwavestart", ent, ent, curwave)
			end
		end
	else
		if not self.SuddenDeath then
			if self:GetCurrentWaveWinner() == TEAM_HUMAN then
				self:SetHumanScore(self:GetHumanScore()+1)
			elseif self:GetCurrentWaveWinner() == TEAM_BANDIT then
				self:SetBanditScore(self:GetBanditScore()+1)
			elseif self:GetCurrentWaveWinner() == nil then
				self:SetTieScore(self:GetTieScore()+1)
			end
			if self:GetHumanScore() == self:GetBanditScore() then
		
			elseif (self:GetHumanScore() >= math.ceil((self:GetNumberOfWaves()-self:GetTieScore()+1)/2)) then
				gamemode.Call("EndRound", TEAM_HUMAN)
				return
			elseif (self:GetBanditScore() >= math.ceil((self:GetNumberOfWaves()-self:GetTieScore()+1)/2))then
				gamemode.Call("EndRound", TEAM_BANDIT)
				return
			end
			if self:GetWave() >= self:GetNumberOfWaves() then -- Last wave is over
				if self:GetHumanScore() > self:GetBanditScore() then
					gamemode.Call("EndRound", TEAM_HUMAN)
				elseif self:GetHumanScore() < self:GetBanditScore() then
					gamemode.Call("EndRound", TEAM_BANDIT)
				elseif self:GetWave() > self:GetNumberOfWaves() then
					gamemode.Call("EndRound", nil)
				else	
					self.SuddenDeath = true
					self:SetCurrentWaveWinner(nil)
					net.Start("zs_suddendeath")
						net.WriteBool( true )
					net.Broadcast()
				end
				local curwave = self:GetWave()
				for _, ent in pairs(ents.FindByClass("logic_waves")) do
					if ent.Wave == curwave or ent.Wave == -1 then
						ent:Input("onwaveend", ent, ent, curwave)
					end
				end
			end
		else
			if self:GetCurrentWaveWinner() == nil then
				gamemode.Call("EndRound", nil)
			end
		end
		self.NextNestSpawn = nil
		self:SetComms(0,0)
		self:SetSamples(0,0)
		self.CommsEnd = false
		self.SamplesEnd = false
		--self.SuddenDeath = false
		gamemode.Call("SetWaveStart", CurTime() + self.WaveIntermissionLength)
		for _, pl in ipairs(player.GetAll()) do
			if self.SuddenDeath or self:IsClassicMode() then
				pl:RemoveStatus("spawnbuff", false, true)
			end
			local teamspawns = {}
			teamspawns = team.GetValidSpawnPoint(pl:Team())
			if pl:GetInfo("zsb_spectator") == "1" then
				pl:Flashlight(false)
				if pl:Team() != TEAM_SPECTATOR then
					pl:ChangeTeam(TEAM_SPECTATOR)
				end
				pl:StripWeapons()
				if pl:GetObserverMode() != OBS_MODE_ROAMING then
					pl:Spectate(OBS_MODE_ROAMING)
				end
			elseif pl:Alive() then
				if not self:IsClassicMode() then
					pl:UpdateWeaponLoadouts()
				else
					for _,wep in ipairs(pl.ClassicModeNextInsureWeps) do
						if pl:HasWeapon(wep) and not table.HasValue(pl.ClassicModeInsuredWeps,wep) and not table.HasValue(pl.ClassicModeRemoveInsureWeps,wep) then
							table.insert(pl.ClassicModeInsuredWeps,wep)
							net.Start("zs_insure_weapon")
								net.WriteString(wep)
								net.WriteBool(true)
							net.Send(pl)
						end
					end
					for i,wep in ipairs(pl.ClassicModeInsuredWeps) do
						if table.HasValue(pl.ClassicModeRemoveInsureWeps,wep) then
							table.remove(pl.ClassicModeInsuredWeps,i)
							net.Start("zs_remove_insured_weapon")
								net.WriteString(wep)
							net.Send(pl)
						end
					end
					pl.ClassicModeNextInsureWeps = {}
					pl.ClassicModeRemoveInsureWeps = {}
				end
				pl.LifeBarricadeDamage = 0
				pl.LifeEnemyDamage = 0
				pl.LifeEnemyKills = 0
				pl:SetPos(teamspawns[ math.random(#teamspawns) ]:GetPos())
				pl:SetAbsVelocity(Vector(0,0,0))
			else
				pl:UnSpectateAndSpawn()	
			end
			pl:PurgeStatusEffects()
			pl:SetSamples(0)
			pl:SetHealth(pl:GetMaxHealth())
			local toadd = 10*(1+self:GetWave())
			if (self:GetCurrentWaveWinner() == TEAM_HUMAN and pl:Team() == TEAM_BANDIT) or (self:GetCurrentWaveWinner() == TEAM_BANDIT and pl:Team() == TEAM_HUMAN) then
				pl:AddPoints(toadd)
				pl:PrintTranslatedMessage(HUD_PRINTTALK, "loser_points_added", toadd)
			elseif 
				(self:GetCurrentWaveWinner() == TEAM_HUMAN and pl:Team() == TEAM_HUMAN) or (self:GetCurrentWaveWinner() == TEAM_BANDIT and pl:Team() == TEAM_BANDIT) then
				pl:AddPoints(toadd/2)
				pl:PrintTranslatedMessage(HUD_PRINTTALK, "winner_points_added", toadd/2)
			elseif
				(self:GetCurrentWaveWinner() == nil and pl:Team() == TEAM_HUMAN or pl:Team() == TEAM_BANDIT) then
				pl:AddPoints(toadd*0.8)
				pl:PrintTranslatedMessage(HUD_PRINTTALK, "draw_points_added", toadd*0.8)
			end
			if (team.NumPlayers(TEAM_BANDIT) > team.NumPlayers(TEAM_HUMAN) and pl:Team() == TEAM_HUMAN) or (team.NumPlayers(TEAM_BANDIT) < team.NumPlayers(TEAM_HUMAN) and pl:Team() == TEAM_BANDIT) then
				pl:AddPoints(toadd/5)
				pl:PrintTranslatedMessage(HUD_PRINTTALK, "less_players_points_added", toadd/5)
			end
		end
		
		net.Start("zs_waveend")
			net.WriteInt(self:GetWave(), 16)
			net.WriteFloat(self:GetWaveStart())
			net.WriteUInt(self:GetCurrentWaveWinner() or -1, 8)
		net.Broadcast()
		net.Start("zs_currenttransmitters")
			for i=1, self.MaxTransmitters do
				net.WriteInt(0,4)
			end
		net.Broadcast()
		self.CurrentTransmitterTable = {}
		util.RemoveAll("prop_ammo")
		util.RemoveAll("prop_weapon")
		util.RemoveAll("prop_obj_transmitter")
		util.RemoveAll("prop_obj_nest")
		util.RemoveAll("prop_obj_sample")
		util.RemoveAll("prop_sampledepositterminal")
		local deployables = ents.FindByClass("prop_drone")
		table.Merge(deployables, ents.FindByClass("prop_manhack"))
		for _, ent in pairs(deployables) do
			if ent.GetOwner and ent:GetOwner():IsPlayer() and (ent:GetOwner():Team() == TEAM_BANDIT or ent:GetOwner():Team() == TEAM_HUMAN) then
				ent:OnPackedUp(ent:GetOwner())
			else
				ent:Destroy()
			end
		end

		timer.Simple(1, function() self:SetCurrentWaveWinner(nil) end)
	end
	gamemode.Call("OnWaveStateChanged")
end
function GM:AddPlayerCaptime(pl)
	if pl:IsPlayer() then pl.TimeCapping = pl.TimeCapping +1 end
end

function GM:OnPlayerUsedBackdoor(pl)
	if pl:IsPlayer() then pl.BackdoorsUsed = pl.BackdoorsUsed +1 end
end

function GM:PlayerSwitchFlashlight(pl, newstate)
	return (pl:Team() == TEAM_HUMAN or pl:Team() == TEAM_BANDIT)
end

function GM:PlayerStepSoundTime(pl, iType, bWalking)
	return 350
end
