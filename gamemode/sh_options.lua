
ITEMCAT_GUNS = 1
ITEMCAT_MELEE = 2
ITEMCAT_TOOLS = 3
ITEMCAT_CONS = 4
ITEMCAT_OTHER = 5
--ITEMCAT_RETURNS = 7


GM.ItemCategories = {
	[ITEMCAT_GUNS] = "itemcategory_guns",
	[ITEMCAT_MELEE] = "itemcategory_melee",
	[ITEMCAT_TOOLS] = "itemcategory_tools",
	[ITEMCAT_CONS] = "itemcategory_etc"
	--[ITEMCAT_CONS] = "사용물품",
	--[ITEMCAT_RETURNS] = "환불",	
}

GM.Items = {}
function GM:AddItem(tier, signature, name, desc, category, worth, swep, callback, canbuy, failtobuystr)
	local tab = { Tier = tier, Signature = signature, TranslateName = name, TranslateDesc = desc, Category = category, Worth = worth or 0, SWEP = swep, Callback = callback, CanPurchaseFunc = canbuy, FailTranslateString = failtobuystr}
	self.Items[#self.Items + 1] = tab
	return tab
end

function GM:AddPointShopItem(tier, signature, name, desc, category, points, callback, canbuy, failtobuystr)
	return self:AddItem(tier, "ps_"..signature, name, desc, category, points, nil, callback, canbuy, failtobuystr)
end

function GM:AddPointShopWeapon(tier, signature, category, points, swep)
	return self:AddItem(tier, "ps_"..signature, nil, nil, category, points, swep, nil,nil,nil)
end

-- These ammo types are available at ammunition boxes.
-- The amount is the ammo to give them.
-- If the player isn't holding a weapon that uses one of these then they will get smg1 ammo.
GM.AmmoResupply = {}
GM.AmmoResupply["ar2"] = 20
GM.AmmoResupply["pistol"] = 12
GM.AmmoResupply["smg1"] = 20
GM.AmmoResupply["357"] = 6
GM.AmmoResupply["xbowbolt"] = 2
GM.AmmoResupply["buckshot"] = 8
GM.AmmoResupply["battery"] = 30
GM.AmmoResupply["pulse"] = 30
GM.AmmoResupply["gravity"] = 1 -- EMP Charge.
GM.AmmoResupply["sniperround"] = 1
GM.AmmoResupply["grenlauncher"] = 1

------------
-- Points --
------------
GM:AddPointShopWeapon(0,"btlax", ITEMCAT_GUNS, 10, "weapon_zs_battleaxe")
GM:AddPointShopWeapon(0,"pshtr", ITEMCAT_GUNS, 10, "weapon_zs_peashooter")
GM:AddPointShopWeapon(0,"owens", ITEMCAT_GUNS, 10, "weapon_zs_owens")
GM:AddPointShopWeapon(0,"z9000", ITEMCAT_GUNS, 10, "weapon_zs_z9000")
GM:AddPointShopWeapon(0,"doublebarrel", ITEMCAT_GUNS, 15, "weapon_zs_doublebarrel")
GM:AddPointShopWeapon(0,"tossr", ITEMCAT_GUNS, 15, "weapon_zs_tosser")
GM:AddPointShopWeapon(0,"stbbr", ITEMCAT_GUNS, 15, "weapon_zs_stubber")
GM:AddPointShopWeapon(0,"crklr", ITEMCAT_GUNS, 15, "weapon_zs_crackler")
GM:AddPointShopWeapon(0,"medgun", ITEMCAT_GUNS, 45, "weapon_zs_medicgun")
GM:AddPointShopWeapon(0,"whirlwind", ITEMCAT_GUNS, 40, "weapon_zs_whirlwind")
GM:AddPointShopWeapon(0,"nailgun", ITEMCAT_GUNS, 20, "weapon_zs_nailgun").NoClassicMode = true

GM:AddPointShopWeapon(1,"bioshotgun", ITEMCAT_GUNS, 55, "weapon_zs_bioticshotgun")
GM:AddPointShopWeapon(1,"deagle", ITEMCAT_GUNS, 65, "weapon_zs_deagle")
GM:AddPointShopWeapon(1,"shredder", ITEMCAT_GUNS, 60, "weapon_zs_smg")
GM:AddPointShopWeapon(1,"annabelle", ITEMCAT_GUNS, 75, "weapon_zs_annabelle")
GM:AddPointShopWeapon(1,"kalash", ITEMCAT_GUNS, 75, "weapon_zs_kalash")
GM:AddPointShopWeapon(1,"sweeper", ITEMCAT_GUNS, 70, "weapon_zs_sweepershotgun")
GM:AddPointShopWeapon(1,"neutrino", ITEMCAT_GUNS, 70, "weapon_zs_neutrino")
GM:AddPointShopWeapon(1,"rupture", ITEMCAT_GUNS, 70, "weapon_zs_rupture")

GM:AddPointShopWeapon(2,"glock3", ITEMCAT_GUNS, 115, "weapon_zs_glock3")
GM:AddPointShopWeapon(2,"eraser", ITEMCAT_GUNS, 120, "weapon_zs_eraser")
GM:AddPointShopWeapon(2,"magnum", ITEMCAT_GUNS, 120, "weapon_zs_magnum")
GM:AddPointShopWeapon(2,"biosmg", ITEMCAT_GUNS, 120, "weapon_zs_bioticsmg")
GM:AddPointShopWeapon(2,"ioncannon", ITEMCAT_GUNS, 125, "weapon_zs_ioncannon")
GM:AddPointShopWeapon(2,"hunter", ITEMCAT_GUNS, 115, "weapon_zs_hunter")
GM:AddPointShopWeapon(2,"practition", ITEMCAT_GUNS, 135, "weapon_zs_practition")
GM:AddPointShopWeapon(2,"sprayer", ITEMCAT_GUNS, 125, "weapon_zs_sprayersmg")
GM:AddPointShopWeapon(2,"stalker", ITEMCAT_GUNS, 130, "weapon_zs_m4")
GM:AddPointShopWeapon(2,"inquisition", ITEMCAT_GUNS, 130, "weapon_zs_inquisition")


GM:AddPointShopWeapon(3,"terminator", ITEMCAT_GUNS, 185, "weapon_zs_terminator")
GM:AddPointShopWeapon(2,"biorifle", ITEMCAT_GUNS, 185, "weapon_zs_bioticrifle")
GM:AddPointShopWeapon(3,"immortal", ITEMCAT_GUNS, 190, "weapon_zs_immortal")
GM:AddPointShopWeapon(3,"bulletstorm", ITEMCAT_GUNS, 195, "weapon_zs_bulletstorm")
GM:AddPointShopWeapon(3,"zeus", ITEMCAT_GUNS, 185, "weapon_zs_zeus")
GM:AddPointShopWeapon(3,"blockdown", ITEMCAT_GUNS, 200, "weapon_zs_combinesniper")
GM:AddPointShopWeapon(3,"inferno", ITEMCAT_GUNS, 185, "weapon_zs_inferno")
GM:AddPointShopWeapon(3,"ender",  ITEMCAT_GUNS, 185, "weapon_zs_ender")
GM:AddPointShopWeapon(3,"pulserifle", ITEMCAT_GUNS, 205, "weapon_zs_pulserifle")

GM:AddPointShopWeapon(4,"waraxe", ITEMCAT_GUNS, 255, "weapon_zs_waraxe")
GM:AddPointShopWeapon(4,"silencer", ITEMCAT_GUNS, 260, "weapon_zs_silencer")
--GM:AddPointShopWeapon(4,"redeemer", ITEMCAT_GUNS, 265, "weapon_zs_redeemers")
GM:AddPointShopWeapon(4,"reaper", ITEMCAT_GUNS, 270, "weapon_zs_reaper")
GM:AddPointShopWeapon(4,"tommy", ITEMCAT_GUNS, 285, "weapon_zs_tommy")
GM:AddPointShopWeapon(4,"sg550", ITEMCAT_GUNS, 275, "weapon_zs_sg550")
GM:AddPointShopWeapon(4,"blitz", ITEMCAT_GUNS, 285, "weapon_zs_blitz")
GM:AddPointShopWeapon(4,"boomstick", ITEMCAT_GUNS, 275, "weapon_zs_boomstick")
GM:AddPointShopWeapon(4,"slugrifle", ITEMCAT_GUNS, 285, "weapon_zs_slugrifle")
GM:AddPointShopWeapon(4,"crossbow", ITEMCAT_GUNS, 280, "weapon_zs_crossbow")
GM:AddPointShopWeapon(4,"positron", ITEMCAT_GUNS, 310, "weapon_zs_positron")

--GM:AddPointShopWeapon(2,"grenadelauncher", ITEMCAT_GUNS, 120, "weapon_zs_grenadelauncher")

GM:AddPointShopWeapon(nil,"crphmr", ITEMCAT_MELEE, 20, "weapon_zs_hammer").NoClassicMode = true
GM:AddPointShopWeapon(nil,"axe", ITEMCAT_MELEE, 25, "weapon_zs_axe")
GM:AddPointShopWeapon(nil,"crowbar", ITEMCAT_MELEE, 22, "weapon_zs_crowbar")
GM:AddPointShopWeapon(nil,"stunbaton", ITEMCAT_MELEE, 23, "weapon_zs_stunbaton")
GM:AddPointShopWeapon(nil,"knife", ITEMCAT_MELEE, 10, "weapon_zs_swissarmyknife")
GM:AddPointShopWeapon(nil,"sledgehammer", ITEMCAT_MELEE, 50, "weapon_zs_sledgehammer")
GM:AddPointShopWeapon(nil,"zpplnk", ITEMCAT_MELEE, 15, "weapon_zs_plank")
--GM:AddPointShopWeapon(nil,"shovel", ITEMCAT_MELEE, 45, "weapon_zs_shovel")
--GM:AddPointShopItem(nil,"zpfryp", "후라이팬", nil, ITEMCAT_MELEE, 31, "weapon_zs_fryingpan")
--GM:AddPointShopItem(nil,"zpcpot", "냄비", nil, ITEMCAT_MELEE, 32, "weapon_zs_pot")
GM:AddPointShopWeapon(nil,"butcher", ITEMCAT_MELEE, 35, "weapon_zs_butcherknife")
GM:AddPointShopWeapon(nil,"pipe", ITEMCAT_MELEE, 35, "weapon_zs_pipe")
GM:AddPointShopWeapon(nil,"hook", ITEMCAT_MELEE, 23, "weapon_zs_hook")
GM:AddPointShopWeapon(nil,"energysword", ITEMCAT_MELEE, 40, "weapon_zs_energysword")

local item = GM:AddPointShopWeapon(nil,"empgun", ITEMCAT_TOOLS, 55, "weapon_zs_empgun")
item.NoClassicMode = true
item.NoSampleCollectMode = true

local item = GM:AddPointShopWeapon(nil,"backdoor", ITEMCAT_TOOLS, 45, "weapon_zs_backdoor")
item.NoClassicMode = true
item.NoSampleCollectMode = true

local item = GM:AddPointShopWeapon(nil,"sgnlboost", ITEMCAT_TOOLS, 20, "weapon_zs_signalbooster")
item.NoClassicMode = true
item.NoSampleCollectMode = true
GM:AddPointShopWeapon(nil,"enemytracker", ITEMCAT_TOOLS, 15, "weapon_zs_enemyradar")
GM:AddPointShopWeapon(nil,"medkit", ITEMCAT_TOOLS, 40, "weapon_zs_medicalkit")
GM:AddPointShopWeapon(nil,"ammokit", ITEMCAT_TOOLS, 30, "weapon_zs_ammokit")

local item = GM:AddPointShopWeapon(nil,"infturret", ITEMCAT_TOOLS, 60, "weapon_zs_gunturret")
item.Countables = {"prop_gunturret"}
--item.ControllerWep = "weapon_zs_gunturretcontrol"
--item.NoClassicMode = true

local item = GM:AddPointShopWeapon(nil,"manhack", ITEMCAT_TOOLS, 55, "weapon_zs_manhack")
item.Countables = {"prop_manhack","weapon_zs_manhackcontrol"}
item.ControllerWep = "weapon_zs_manhackcontrol"
--item.NoClassicMode = true

local item = GM:AddPointShopWeapon(nil,"drone", ITEMCAT_TOOLS, 50, "weapon_zs_drone")
item.Countables = {"prop_drone","weapon_zs_dronecontrol"}
item.ControllerWep = "weapon_zs_dronecontrol"
item.NoClassicMode = true
item.NoSampleCollectMode = true

GM:AddPointShopWeapon(nil,"ffemitter", ITEMCAT_TOOLS, 60, "weapon_zs_ffemitter").Countables = "prop_ffemitter"

GM:AddPointShopWeapon(nil,"barricadekit", ITEMCAT_TOOLS, 125, "weapon_zs_barricadekit").NoClassicMode = true
GM:AddPointShopWeapon(nil,"boardpack", ITEMCAT_TOOLS, 25, "weapon_zs_boardpack").NoClassicMode = true

GM:AddPointShopWeapon(nil,"grenade", ITEMCAT_CONS, 15, "weapon_zs_grenade")
GM:AddPointShopWeapon(nil,"flashbang", ITEMCAT_CONS, 10, "weapon_zs_flashbang")
GM:AddPointShopWeapon(nil,"smoke", ITEMCAT_CONS, 7, "weapon_zs_smokegrenade")
GM:AddPointShopWeapon(nil,"detpck", ITEMCAT_CONS, 40, "weapon_zs_detpack")

local item = GM:AddPointShopItem(nil,"bodyarmor", "shopitem_bodyarmor_name", "shopitem_bodyarmor_desc",ITEMCAT_OTHER, 25,function(pl) pl:WearBodyArmor() end, function(pl) return (pl.GetBodyArmor and pl:GetBodyArmor() < 100) end,"shopitem_bodyarmor_alreadyhave")

local item = GM:AddPointShopItem(nil,"extraspd", "shopitem_adrenaline_name", "shopitem_adrenaline_desc", ITEMCAT_OTHER, 10,function(pl) pl:ApplyAdrenaline() end, function(pl) return not (pl:GetMaxHealth() < 60) end,"shopitem_adrenaline_toomuch")

local item = GM:AddPointShopItem(nil,"ammopurchase", "shopitem_ammo_name", "shopitem_ammo_desc", ITEMCAT_OTHER, 20, function(pl) pl:RefillActiveWeapon() end, function(pl) return pl:ActiveWeaponCanBeRefilled() end, "shopitem_ammo_invalid")

-- These are the honorable mentions that come at the end of the round.

local function genericcallback(pl, magnitude) return pl:Name(), magnitude end
GM.HonorableMentions = {}
GM.HonorableMentions[HM_MOSTENEMYKILLED] = {TranslateName = "hm_mostenemykilled_name", TranslateString = "hm_mostenemykilled_desc", Callback = genericcallback}
GM.HonorableMentions[HM_MOSTDAMAGETOENEMY] = {TranslateName = "hm_mostdamagetoenemy_name", TranslateString = "hm_mostdamagetoenemy_desc", Callback = genericcallback}
GM.HonorableMentions[HM_KILLSTREAK] = {TranslateName = "hm_killstreaks_name", TranslateString = "hm_killstreaks_desc", Callback = genericcallback}
GM.HonorableMentions[HM_PACIFIST] = {TranslateName = "hm_pacifist_name", TranslateString = "hm_pacifist_desc", Callback = genericcallback}
GM.HonorableMentions[HM_MOSTHELPFUL] = {TranslateName = "hm_mosthelpful_name", TranslateString = "hm_mosthelpful_desc", Callback = genericcallback, Color = COLOR_YELLOW}
GM.HonorableMentions[HM_USEFULTOOPPOSITE] = {TranslateName = "hm_usefultoopposite_name", TranslateString = "hm_usefultoopposite_desc", Callback = genericcallback, Color = COLOR_DARKRED}
GM.HonorableMentions[HM_BLACKCOW] = {TranslateName = "hm_mostpurchases_name", TranslateString = "hm_mostpurchases_desc", Callback = genericcallback}
GM.HonorableMentions[HM_HACKER] = {TranslateName = "hm_mosthacking_name", TranslateString = "hm_mosthacking_desc", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_COMMSUNIT] = {TranslateName = "hm_mosttransmission_name", TranslateString = "hm_mosttransmission_desc", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_GOODDOCTOR] = {TranslateName = "hm_mosthealing_name", TranslateString = "hm_mosthealing_desc", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_HANDYMAN] = {TranslateName = "hm_mostrepairing_name", TranslateString = "hm_mostrepairing_desc", Callback = genericcallback, Color = COLOR_WHITE}
GM.HonorableMentions[HM_BARRICADEDESTROYER] = {TranslateName = "hm_barricadedestroyer_name", TranslateString = "hm_barricadedestroyer_desc", Callback = genericcallback}
GM.HonorableMentions[HM_WARRIOR] = {TranslateName = "hm_warrior_name", TranslateString = "hm_warrior_desc", Callback = genericcallback}
GM.HonorableMentions[HM_HEADSHOTS] = {TranslateName = "hm_mostheadshots_name", TranslateString = "hm_mostheadshots_desc", Callback = genericcallback}
GM.HonorableMentions[HM_BESTAIM] = {TranslateName = "hm_bestaim_name", TranslateString = "hm_bestaim_desc", Callback = genericcallback}

-- Zombine: has no head.
-- Skeleton: doesn't have flesh therefore making the hitboxes seem wonky

GM.RestrictedModels = {
	"models/player/zombine.mdl",
	"models/player/zombie_soldier.mdl",
	"models/player/skeleton.mdl",
	"models/player/charple.mdl",
	"models/player/zombie_classic.mdl",
	"models/player/zombie_fast.mdl"
	--"models/player/corpse1.mdl"
}
GM.MapWhitelist = {
	--"cs_assault", Assault is way more fun in classic mode.
	"cs_compound",
	"cs_galleria",
	--"cs_havana", Because of how this map is laid out it can become impossible to get to transmitters
	"cs_italy",
	"cs_miami_css",
	"cs_militia",
	"cs_office",
	--"de_aztec", This map may be too CT-sided at this current stage.
	"de_cbble", 
	"de_chateau",
	"de_detroit_v2",
	"de_dust",
	"de_dust2",
	"de_inferno",
	"de_kismayo",
	"de_nightfever",
	"de_nightquarters_v1",
	"de_nuke",
	"de_piranesi",
	"de_port",
	--"de_prodigy", Map is too small to really do a non-classic mode on.
	"de_school",
	"de_tides",
	"de_train",
	--"zm_4ngry_quaruntine", Map is too small to really do a non-classic mode on.
	"zm_ryan_valley02",
	"zm_tx_highschoolbeta7_d_vh",
	"zm_stab_aroundtown_v3c",
	"zsb_minecraft_ricetown_b2",
	"zsb_streetwar01a",
	"zsb_hallways",
	--"zsb_ravenholm_pre_b1", map is too one way to ever allow for fun gameplay. Might need a remake.
	"zs_barren",
	"zs_lockup_v2",
	"zs_outpost_gold_v2",
	"zs_ravine",
	"zs_castle_age",
	"zs_scrapmetal_v2_fixed",
	"zs_airport_panic_bobpoblo2",
	"zs_slugde_fixed",
	"zs_trainstation",
	"zs_urbandecay_v4"
}
GM.RandomSurvivorModels = {
	"female01",
	"female02",
	"female03",
	"female04",
	"female05",
	"female06",
	"female07",
	"female08",
	"female09",
	"female10",
	"female11",
	"female12",
	"male01",
	"male02",
	"male03",
	"male04",
	"male05",
	"male06",
	"male07",
	"male08",
	"male09",
	"male10",
	"male11",
	"male12",
	"male13",
	"male14",
	"male15",
	"male16",
	"male17",
	"male18"
}

GM.RandomBanditModels = {
	"police",
	"policefem",
	"stripped",
	"combine",
	"combineelite",
	"combineprison",
	"corpse",
	"css_arctic",
	"css_gasmask",
	"css_guerilla",
	"css_leet",
	"css_phoenix",
	"css_riot",
	"css_swat",
	"css_urban",
	"css_arctic"
}

-- If a person has no player model then use one of these (auto-generated).
GM.RandomPlayerModels = {}
for name, mdl in pairs(player_manager.AllValidModels()) do
	if not table.HasValue(GM.RestrictedModels, string.lower(mdl)) then
		table.insert(GM.RandomPlayerModels, name)
	end
end

-- Utility function to setup a weapon's DefaultClip.
function GM:SetupDefaultClip(tab)
	tab.DefaultClip = math.max(math.ceil(tab.ClipSize * self.SurvivalClips),30)
end

-- Utility function to setup weapon default aim stats.
function GM:SetupAimDefaults(tab,primtab)
	tab.AimExpandUnit = math.Round((tab.ConeMax - tab.ConeMin)/math.min(primtab.Delay*primtab.ClipSize,1.3),4)
	tab.AimCollapseUnit = (tab.ConeMax - tab.ConeMin)*4
	tab.AimExpandStayDuration = tab.Primary.Delay*0.75
end
	
GM.MaxSigils = 3
GM.NumberOfWaves = CreateConVar("zsb_numberofwaves", "9", FCVAR_REPLICATED + FCVAR_ARCHIVE + FCVAR_NOTIFY, "Number of waves in a game."):GetInt()
cvars.AddChangeCallback("zsb_numberofwaves", function(cvar, oldvalue, newvalue)
	GAMEMODE.NumberOfWaves = tonumber(newvalue) or 1
end)

GM.RoundLimit = CreateConVar("zsb_roundlimit", "3", FCVAR_ARCHIVE + FCVAR_NOTIFY, "How many times the game can be played on the same map. -1 means infinite or only use time limit. 0 means once."):GetInt()
cvars.AddChangeCallback("zsb_roundlimit", function(cvar, oldvalue, newvalue)
	GAMEMODE.RoundLimit = tonumber(newvalue) or 3
end)

-- Static values that don't need convars...

-- Initial length for wave 1.
GM.WaveOneLength = 420

-- For Classic Mode
GM.WaveOneLengthClassic = 120

-- Every wave is this much shorter 
GM.TimeLostPerWave = 15

-- How long 'wave 0' should last in seconds. This is the time you should give for new players to join and get ready.
GM.WaveZeroLength = 60

-- Time players have between waves to do stuff.
GM.WaveIntermissionLength = 30

-- Time in seconds between end round and next map.
GM.EndGameTime = 25

-- How many clips of ammo guns from the menu start with. The default clip is given as larger of the weapon's clip multiplied by this or 40.
GM.SurvivalClips = 3

-- End of round music
GM.SuddenDeathSound = Sound("music/bandit/lasthuman.ogg")
GM.AllLoseSound = Sound("music/bandit/music_lose.ogg")
GM.HumanWinSound = Sound("music/bandit/music_humanwin.ogg")
GM.BanditWinSound = Sound("music/bandit/music_banditwin.ogg")
-- Sound played to a person when they die as a human.
GM.DeathSound = Sound("music/stingers/HL1_stinger_song28.mp3")
