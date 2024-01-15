if not killicon.GetFont then
	killicon.OldAddFont = killicon.AddFont
	killicon.OldAddAlias = killicon.AddAlias
	killicon.OldAdd = killicon.Add

	local storedfonts = {}
	local storedicons = {}

	function killicon.AddFont(sClass, sFont, sLetter, cColor)
		storedfonts[sClass] = {sFont, sLetter, cColor}
		return killicon.OldAddFont(sClass, sFont, sLetter, cColor)
	end

	function killicon.Add(sClass, sTexture, cColor)
		storedicons[sClass] = {sTexture, cColor}
		return killicon.OldAdd(sClass, sTexture, cColor)
	end

	function killicon.AddAlias(sClass, sBaseClass)
		if storedfonts[sClass] then
			return killicon.AddFont(sBaseClass, storedfonts[sClass][1], storedfonts[sClass][2], storedfonts[sClass][3])
		elseif storedicons[sClass] then
			return killicon.Add(sBaseClass, storedicons[sClass][1], storedicons[sClass][2])
		end
	end

	function killicon.Get(sClass)
		return killicon.GetFont(sClass) or killicon.GetIcon(sClass)
	end

	function killicon.GetFont(sClass)
		return storedfonts[sClass]
	end

	function killicon.GetIcon(sClass)
		return storedicons[sClass]
	end
end

killicon.AddFont("default", "zsdeathnoticecs", "C", color_white)
killicon.AddFont("suicide", "zsdeathnoticecs", "C", color_white)
killicon.AddFont("player", "zsdeathnoticecs", "C", color_white)
killicon.AddFont("worldspawn", "zsdeathnoticecs", "C", color_white)
killicon.AddFont("func_move_linear", "zsdeathnoticecs", "C", color_white)
killicon.AddFont("func_rotating", "zsdeathnoticecs", "C", color_white)
killicon.AddFont("trigger_hurt", "zsdeathnoticecs", "C", color_white)

killicon.AddFont("prop_physics", "zsdeathnotice", "9", color_white)
killicon.AddFont("prop_physics_respawnable", "zsdeathnotice", "9")
killicon.AddFont("prop_physics_multiplayer", "zsdeathnotice", "9", color_white)
killicon.AddFont("func_physbox", "zsdeathnotice", "9", color_white)
killicon.AddFont("weapon_smg1", "zsdeathnotice", "/", color_white)
killicon.AddFont("weapon_357", "zsdeathnotice", ".", color_white)
killicon.AddFont("weapon_ar2", "zsdeathnotice", "2", color_white)
killicon.AddFont("crossbow_bolt", "zsdeathnotice", "1", color_white)
killicon.AddFont("weapon_shotgun", "zsdeathnotice", "0", color_white)
killicon.AddFont("rpg_missile", "zsdeathnotice", "3", color_white)
killicon.AddFont("npc_grenade_frag", "zsdeathnotice", "4", color_white)
killicon.AddFont("weapon_pistol", "zsdeathnotice", "-", color_white)
killicon.AddFont("prop_combine_ball", "zsdeathnotice", "8", color_white)
killicon.AddFont("grenade_ar2", "zsdeathnotice", "7", color_white)
killicon.AddFont("weapon_stunstick", "zsdeathnotice", "!", color_white)
killicon.AddFont("weapon_slam", "zsdeathnotice", "*", color_white)
killicon.AddFont("weapon_crowbar", "zsdeathnotice", "6", color_white)

killicon.AddFont("headshot", "zsdeathnoticecs", "D", color_white)

killicon.Add("redeem", "killicon/redeem_v2", color_white)
killicon.Add("killstreak", "killicon/killstreak_stacks", color_white)
killicon.Add("projectile_poisonspit", "zombiesurvival/killicons/projectile_poisonspit", color_white)
killicon.Add("projectile_poisonflesh", "zombiesurvival/killicons/projectile_poisonflesh", color_white)
--killicon.Add("projectile_poisonpuke", "zombiesurvival/killicons/pukepus", color_white)
--killicon.Add("weapon_zs_special_wow", "sprites/glow04_noz", color_white)

killicon.Add("prop_gunturret", "zombiesurvival/killicons/prop_gunturret", color_white)
killicon.Add("weapon_zs_gunturret", "zombiesurvival/killicons/prop_gunturret", color_white)
killicon.Add("weapon_zs_gunturretcontrol", "zombiesurvival/killicons/prop_gunturret", color_white)
killicon.AddFont("projectile_zsgrenade", "zsdeathnotice", "4", color_white)
killicon.AddFont("weapon_zs_grenade", "zsdeathnotice", "4", color_white)
killicon.AddFont("weapon_zs_stubber", "zsdeathnoticecs", "n", color_white)
killicon.AddFont("weapon_zs_hunter", "zsdeathnoticecs", "r", color_white)
killicon.AddFont("weapon_zs_tosser", "zsdeathnotice", "/", color_white)
killicon.AddFont("weapon_zs_owens", "zsdeathnotice", "-", color_white)

killicon.AddFont("weapon_zs_battleaxe", "zsdeathnoticecs", "c", color_white)
killicon.AddFont("weapon_zs_boomstick", "zsdeathnotice", "0", color_white)
killicon.AddFont("weapon_zs_silencer", "zsdeathnoticecs", "d", color_white)
killicon.AddFont("weapon_zs_eraser", "zsdeathnoticecs", "u", color_white)
killicon.AddFont("weapon_zs_sweepershotgun", "zsdeathnoticecs", "k", color_white)
killicon.AddFont("weapon_zs_barricadekit", "zsdeathnotice", "3", color_white)
killicon.AddFont("weapon_zs_bulletstorm", "zsdeathnoticecs", "m", color_white)

killicon.AddFont("weapon_zs_crossbow", "zsdeathnotice", "1", color_white)
killicon.AddFont("projectile_arrow", "zsdeathnotice", "1", color_white)

killicon.AddFont("weapon_zs_deagle", "zsdeathnoticecs", "f", color_white)
killicon.AddFont("weapon_zs_glock3", "zsdeathnoticecs", "c", color_white)
killicon.AddFont("weapon_zs_magnum", "zsdeathnotice", ".", color_white)
killicon.AddFont("weapon_zs_peashooter", "zsdeathnoticecs", "a", color_white)

killicon.AddFont("weapon_zs_slugrifle", "zsdeathnoticecs", "B", color_white)
killicon.AddFont("weapon_zs_smg", "zsdeathnoticecs", "x", color_white)
killicon.AddFont("weapon_zs_swissarmyknife", "zsdeathnoticecs", "j", color_white)
killicon.AddFont("weapon_zs_sprayersmg", "zsdeathnoticecs", "l", color_white)
killicon.AddFont("weapon_zs_inferno", "zsdeathnoticecs", "e", color_white)
killicon.AddFont("weapon_zs_m4", "zsdeathnoticecs", "w", color_white)
killicon.AddFont("weapon_zs_m4_silenced", "zsdeathnoticecs", "w", color_white)
killicon.AddFont("weapon_zs_m249","zsdeathnoticecs","z", color_white)
killicon.AddFont("weapon_zs_reaper", "zsdeathnoticecs", "q", color_white)
killicon.AddFont("weapon_zs_crackler", "zsdeathnoticecs", "t", color_white)
killicon.AddFont("weapon_zs_pulserifle", "zsdeathnotice", "2", color_white)
killicon.AddFont("weapon_zs_kalash", "zsdeathnoticecs", "b", color_white)
killicon.AddFont("weapon_zs_ender", "zsdeathnoticecs", "v", color_white)
killicon.AddFont("weapon_zs_redeemers", "zsdeathnoticecs", "s", color_white)
killicon.AddFont("weapon_zs_sg550", "zsdeathnoticecs", "o", color_white)

killicon.AddFont("weapon_zs_blitz", "zsdeathnoticecs", "A", color_white)
killicon.AddFont("weapon_zs_zeus", "zsdeathnoticecs", "i", color_white)
killicon.AddFont("weapon_zs_stone", "zsdeathnotice", "8", color_white)

killicon.AddFont("weapon_zs_crowbar", "zsdeathnotice", "6", color_white)
killicon.AddFont("weapon_zs_stunbaton", "zsdeathnotice", "!", color_white)
killicon.AddFont("weapon_zs_bodyarmor", "zsdeathnoticecs", "p", color_white)
killicon.AddFont("weapon_zs_flashbang", "zsdeathnoticecs", "P", color_white)
killicon.AddFont("weapon_zs_smokegrenade", "zsdeathnoticecs", "Q", color_white)

-- PNG KILLICONS
killicon.Add("status_tox", "killicon/status_bleed", COLOR_LIMEGREEN)
killicon.Add("status_bleed", "killicon/status_bleed", COLOR_RED)

killicon.Add("weapon_zs_arbalest", "killicon/weapon_zs_arbalest", color_white)
killicon.Add("projectile_bouncebolt", "killicon/weapon_zs_arbalest", color_white)

killicon.Add("weapon_zs_albatross", "killicon/weapon_zs_albatross", color_white)
killicon.Add("weapon_zs_ammokit", "killicon/weapon_zs_ammobox", color_white)
killicon.Add("weapon_zs_annabelle", "killicon/weapon_zs_annabelle2", color_white)
killicon.Add("weapon_zs_bioticrifle", "killicon/weapon_zs_bioticrifle", color_white)
killicon.Add("projectile_poisonspit_rif", "killicon/weapon_zs_bioticrifle", color_white)
killicon.Add("weapon_zs_bioticshotgun", "killicon/weapon_zs_bioticshotgun", color_white)
killicon.Add("projectile_poisonflesh_shot", "killicon/weapon_zs_bioticshotgun", color_white)
killicon.Add("weapon_zs_bioticsmg", "killicon/weapon_zs_bioticsmg", color_white)
killicon.Add("projectile_poisonspit_smg", "killicon/weapon_zs_bioticsmg", color_white)
killicon.Add("weapon_zs_blightcaster", "killicon/weapon_zs_blightcaster", color_white)
killicon.Add("projectile_bonemesh_blightcaster", "killicon/weapon_zs_blightcaster", color_white)
killicon.Add("weapon_zs_combinesniper", "killicon/weapon_zs_combinesniper", color_white)

killicon.Add("prop_detpack", "killicon/weapon_zs_detpack2", color_white)
killicon.Add("weapon_zs_detpack", "killicon/weapon_zs_detpack2", color_white)
killicon.Add("weapon_zs_detpackremote", "killicon/weapon_zs_detpack2", color_white)

killicon.Add("weapon_zs_doublebarrel","killicon/weapon_zs_doublebarrel2", color_white)

killicon.Add("weapon_zs_drone", "killicon/weapon_zs_drone3.png", color_white)
killicon.Add("weapon_zs_dronecontrol", "killicon/weapon_zs_drone3.png", color_white)

killicon.Add("weapon_zs_empgun", "killicon/weapon_zs_empgun", color_white)

killicon.Add("weapon_zs_ffemitter", "killicon/weapon_zs_ffemitter", color_white)
killicon.Add("prop_ffemitter", "killicon/weapon_zs_ffemitter", color_white)
killicon.Add("prop_ffemitterfield", "killicon/weapon_zs_ffemitter", color_white)

killicon.Add("weapon_zs_spotlamp", "killicon/weapon_zs_spotlamp", color_white)
killicon.Add("prop_spotlamp", "killicon/weapon_zs_spotlamp", color_white)

killicon.Add("weapon_zs_fusilier", "killicon/weapon_zs_fusilier", color_white)
killicon.Add("weapon_zs_grenadelauncher", "killicon/weapon_zs_grenadelauncher", color_white)
killicon.Add("projectile_launchedgrenade", "killicon/weapon_zs_grenadelauncher", color_white)
killicon.Add("weapon_zs_immortal", "killicon/weapon_zs_immortal", color_white)
killicon.Add("weapon_zs_injector", "killicon/weapon_zs_injector", color_white)

killicon.Add("weapon_zs_inquisition", "killicon/weapon_zs_inquisition", color_white)
killicon.Add("projectile_tinyarrow", "killicon/weapon_zs_inquisition", color_white)

killicon.Add("weapon_zs_ioncannon", "killicon/weapon_zs_ioncannon", color_white)

killicon.Add("weapon_zs_lamp", "killicon/weapon_zs_lamp", color_white)
killicon.Add("weapon_zs_longsword", "killicon/weapon_zs_longsword", color_white)
killicon.Add("weapon_zs_cordlessdrill", "killicon/weapon_zs_cordlessdrill", color_white)
killicon.Add("weapon_zs_manhack", "killicon/weapon_zs_manhack", color_white)
killicon.Add("prop_manhack", "killicon/weapon_zs_manhack", color_white)
killicon.Add("weapon_zs_manhackcontrol", "killicon/weapon_zs_manhack", color_white)
killicon.Add("weapon_zs_manhack_saw", "killicon/weapon_zs_manhack", color_white)
killicon.Add("prop_manhack_saw", "killicon/weapon_zs_manhack", color_white)
killicon.Add("weapon_zs_manhackcontrol_saw", "killicon/weapon_zs_manhack", color_white)

killicon.Add("weapon_zs_medicgun", "killicon/weapon_zs_medicgun2", color_white)
killicon.Add("weapon_zs_medicrifle", "killicon/weapon_zs_medicrifle", color_white)
killicon.Add("weapon_zs_medicalkit", "killicon/weapon_zs_medkit", color_white)

killicon.Add("weapon_zs_nailgun", "killicon/weapon_zs_nailgun", color_white)
killicon.Add("weapon_zs_neutrino", "killicon/weapon_zs_neutrino", color_white)

killicon.Add("weapon_zs_palliator", "killicon/weapon_zs_palliator", color_white)

killicon.Add("weapon_zs_podvodny", "killicon/weapon_zs_podvodny", color_white)
killicon.Add("projectile_bleedbolt", "killicon/weapon_zs_podvodny", color_white)

killicon.Add("weapon_zs_positron", "killicon/weapon_zs_positron", color_white)
killicon.Add("weapon_zs_practition", "killicon/weapon_zs_practition", color_white)

killicon.Add("weapon_zs_renegade", "killicon/weapon_zs_renegade", color_white)
killicon.Add("prop_electricfield", "killicon/weapon_zs_renegade", color_white)

killicon.Add("weapon_zs_rupture", "killicon/weapon_zs_rupture", color_white)
killicon.Add("projectile_flechettearrow", "killicon/weapon_zs_rupture", color_white)

killicon.Add("weapon_zs_slinger", "killicon/weapon_zs_slinger", color_white)
killicon.Add("projectile_slingerbolt", "killicon/weapon_zs_slinger", color_white)

killicon.Add("weapon_zs_severance", "killicon/weapon_zs_severance", color_white)
killicon.Add("weapon_zs_terminator", "killicon/weapon_zs_terminator", color_white)
killicon.Add("weapon_zs_tommy", "killicon/weapon_zs_tommy", color_white)
killicon.Add("weapon_zs_trenchshotgun", "killicon/weapon_zs_trenchshotgun", color_white)
killicon.Add("weapon_zs_ventilator", "killicon/weapon_zs_ventilator", color_white)
killicon.Add("weapon_zs_waraxe", "killicon/weapon_zs_waraxe", color_white)
killicon.Add("weapon_zs_whirlwind", "killicon/weapon_zs_whirlwind", color_white)
killicon.Add("weapon_zs_wrench", "killicon/weapon_zs_wrench", color_white)
killicon.Add("weapon_zs_z9000", "killicon/weapon_zs_z9000", color_white)

killicon.Add("weapon_zs_backdoor", "killicon/weapon_zs_detpack2", color_white)
killicon.Add("weapon_zs_boardpack", "killicon/weapon_zs_boardpack", color_white)
killicon.Add("weapon_zs_bust", "killicon/weapon_zs_bust", color_white)
killicon.Add("weapon_zs_extendingbaton", "killicon/weapon_zs_extendingbaton", color_white)
killicon.Add("weapon_zs_greataxe", "killicon/weapon_zs_greataxe", color_white)

killicon.Add("weapon_zs_enemyradar", "killicon/weapon_zs_tv.png", color_white)
killicon.Add("weapon_zs_signalbooster", "killicon/weapon_zs_tv.png", color_white)

killicon.Add("weapon_zs_hook", "killicon/weapon_zs_hook2", color_white)
killicon.Add("weapon_zs_axe", "killicon/weapon_zs_axe", color_white)
killicon.Add("weapon_zs_sawhack", "killicon/weapon_zs_sawhack", color_white)
killicon.Add("weapon_zs_pipe", "killicon/weapon_zs_pipe", color_white)
killicon.Add("weapon_zs_sledgehammer", "killicon/weapon_zs_sledgehammer", color_white)
killicon.Add("weapon_zs_megamasher", "killicon/weapon_zs_megamasher", color_white)
killicon.Add("weapon_zs_shovel", "killicon/weapon_zs_shovel", color_white)
killicon.Add("weapon_zs_plank", "killicon/weapon_zs_plank", color_white)
killicon.Add("weapon_zs_keyboard", "killicon/weapon_zs_keyboard", color_white)
killicon.Add("weapon_zs_butcherknife", "killicon/weapon_zs_butcherknife2", color_white)
killicon.Add("weapon_zs_energysword", "killicon/weapon_zs_energysword.png", color_white)
--killicon.Add("weapon_zs_fryingpan", "killicon/zs_fryingpan", color_white)
--killicon.Add("weapon_zs_pot", "killicon/zs_pot", color_white)

killicon.Add("weapon_zs_hammer", "killicon/weapon_zs_hammer2", color_white)
killicon.Add("weapon_zs_electrohammer", "killicon/weapon_zs_electrohammer", color_white)

net.Receive("zs_pl_kill_pl", function(length)
	local victim = net.ReadEntity()
	local attacker = net.ReadEntity()

	local inflictor = net.ReadString()

	local victimteam = net.ReadUInt(16)
	local attackerteam = net.ReadUInt(16)

	local headshot = net.ReadBit() == 1

	if victim:IsValid() and attacker:IsValid() then
		local attackername = attacker:Name()
		local victimname = victim:Name()

		if victim == MySelf then
			if victimteam == TEAM_HUMAN or victimteam == TEAM_BANDIT then
				gamemode.Call("LocalPlayerDied", attackername)
			end
		elseif attacker == MySelf then
			if attacker:Team() == TEAM_BANDIT or attacker:Team() == TEAM_HUMAN then
				gamemode.Call("FloatingScore", victim, "floatingscore_kill", 1, 0)
			end
		end
		
		print(attackername.." killed "..victimname.." with "..inflictor..".")

		--gamemode.Call("AddDeathNotice", attackername, attackerteam, inflictor, victimname, victimteam, headshot)
		GAMEMODE:TopNotify(attacker, " ", {killicon = inflictor, headshot = headshot}, " ", victim)
	end
end)

net.Receive("zs_pls_kill_pl", function(length)
	local victim = net.ReadEntity()
	local attacker = net.ReadEntity()
	local assister = net.ReadEntity()

	local inflictor = net.ReadString()

	local victimteam = net.ReadUInt(16)
	local attackerteam = net.ReadUInt(16)

	local headshot = net.ReadBit() == 1

	if victim:IsValid() and attacker:IsValid() and assister:IsValid() then
		local victimname = victim:Name()
		local attackername = attacker:Name()
		local assistername = assister:Name()

		if victim == MySelf then
			if victimteam == TEAM_HUMAN or victimteam == TEAM_BANDIT then
				gamemode.Call("LocalPlayerDied", attackername..", "..assistername)
			end
		elseif attacker == MySelf or assister == MySelf then
			if attacker:Team() == TEAM_BANDIT or attacker:Team() == TEAM_HUMAN then
				gamemode.Call("FloatingScore", victim, "floatingscore_kill", 1, 0)
			end
		end
		
		print(attackername.." and "..assistername.." killed "..victimname.." with "..inflictor..".")

		--gamemode.Call("AddDeathNotice", attackername.." and "..assistername, attackerteam, inflictor, victimname, victimteam, headshot)
		GAMEMODE:TopNotify(attacker, "/", assister, " ", {killicon = inflictor, headshot = headshot}, " ", victim)
	end
end)

net.Receive("zs_pl_kill_self", function(length)
	local victim = net.ReadEntity()
	local victimteam = net.ReadUInt(16)

	if victim:IsValid() then
		if victim == MySelf and (victimteam == TEAM_HUMAN or victimteam == TEAM_BANDIT) then
			gamemode.Call("LocalPlayerDied")
		end

		local victimname = victim:Name()

		print(victimname.." died mysteriously")
		--gamemode.Call("AddDeathNotice", nil, 0, "suicide", victimname, victimteam)
		GAMEMODE:TopNotify({killicon = "suicide"}, " ", victim)
	end
end)

net.Receive("zs_playerredeemed", function(length)
	local pl = net.ReadEntity()
	local name = net.ReadString()

	--gamemode.Call("AddDeathNotice", nil, 0, "redeem", name, TEAM_HUMAN)

	if pl:IsValid() then
		GAMEMODE:TopNotify(pl, " "..translate.Get("x_respawned"), {killicon = "redeem"})

		if pl == MySelf then
			GAMEMODE:CenterNotify(COLOR_CYAN, translate.Get("you_respawned"))
		end
	end
end)

net.Receive("zs_killstreak", function(length)
	local pl = net.ReadEntity()
	local kills = net.ReadInt(16)
	local name = net.ReadString()
	if kills <=2 then return end
	--gamemode.Call("AddDeathNotice", nil, 0, "redeem", name, TEAM_HUMAN)
	if GAMEMODE.KillstreakSounds then
	if kills >= 14 then
		surface.PlaySound("killstreak/8kills.wav")
	elseif kills == 12 then
		surface.PlaySound("killstreak/7kills.wav")
	elseif kills == 10 then
		surface.PlaySound("killstreak/6kills.wav")
	elseif kills == 8 then
		surface.PlaySound("killstreak/5kills.wav")
	elseif kills == 6 then
		surface.PlaySound("killstreak/4kills.wav")
	elseif kills == 4 then
		surface.PlaySound("killstreak/3kills.wav")
	end
	end
	if pl:IsValid() then
		GAMEMODE:TopNotify(pl, " ", {killicon = "killstreak"}, " ",kills, translate.Get("consecutive_kills"))
	end
end)

net.Receive("zs_death", function(length)
	local victim = net.ReadEntity()
	local inflictor = net.ReadString()
	local attacker = "#" .. net.ReadString()
	local victimteam = net.ReadUInt(16)

	if victim:IsValid() then
		if victim == MySelf and victimteam == TEAM_HUMAN then
			gamemode.Call("LocalPlayerDied")
		end

		local victimname = victim:Name()
		
		print(victimname.." was killed by "..attacker.." with "..inflictor..".")

		--gamemode.Call("AddDeathNotice", attacker, -1, inflictor, victimname, victimteam)
		GAMEMODE:TopNotify(COLOR_RED, attacker, " ", {deathicon = inflictor}, " ", victim)
	end
end)

-- Handled above.
function GM:AddDeathNotice()
end
