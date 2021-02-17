
ITEMCAT_GUNS = 1
ITEMCAT_AMMO = 2
ITEMCAT_MELEE = 3
ITEMCAT_TOOLS = 4
ITEMCAT_OTHER = 5
--ITEMCAT_CONS = 6
--ITEMCAT_RETURNS = 7


GM.ItemCategories = {
	[ITEMCAT_GUNS] = "itemcategory_guns",
	[ITEMCAT_AMMO] = "itemcategory_ammo",
	[ITEMCAT_MELEE] = "itemcategory_melee",
	[ITEMCAT_TOOLS] = "itemcategory_tools",
	[ITEMCAT_OTHER] = "itemcategory_etc"
	--[ITEMCAT_CONS] = "사용물품",
	--[ITEMCAT_RETURNS] = "환불",	
}

GM.Items = {}
function GM:AddItem(tier, signature, name, desc, category, worth, swep, callback, model)
	local tab = { Tier = tier, Signature = signature, Name = name, Description = desc, Category = category, Worth = worth or 0, SWEP = swep, Callback = callback, Model = model}
	self.Items[#self.Items + 1] = tab

	return tab
end

function GM:AddPointShopItem(tier, signature, name, desc, category, points, worth, callback, model)
	return self:AddItem(tier, "ps_"..signature, name, desc, category, points, worth, callback, model)
end

function GM:AddPointShopWeapon(tier, signature, category, points, worth, callback, model)
	return self:AddItem(tier, "ps_"..signature, nil, nil, category, points, worth, callback, model)
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
GM.AmmoResupply["gaussenergy"] = 1
GM.AmmoResupply["sniperround"] = 1
GM.AmmoResupply["grenlauncher"] = 1

------------
-- Points --
------------
GM:AddPointShopWeapon(0,"btlax", ITEMCAT_GUNS, 10, "weapon_zs_battleaxe")
GM:AddPointShopWeapon(0,"pshtr", ITEMCAT_GUNS, 10, "weapon_zs_peashooter")
GM:AddPointShopWeapon(0,"owens", ITEMCAT_GUNS, 12, "weapon_zs_owens")
GM:AddPointShopWeapon(0,"doublebarrel", ITEMCAT_GUNS, 15, "weapon_zs_doublebarrel")
GM:AddPointShopWeapon(0,"tossr", ITEMCAT_GUNS, 15, "weapon_zs_tosser")
GM:AddPointShopWeapon(0,"stbbr", ITEMCAT_GUNS, 15, "weapon_zs_stubber")
GM:AddPointShopWeapon(0,"crklr", ITEMCAT_GUNS, 15, "weapon_zs_crackler")
GM:AddPointShopWeapon(0,"z9000", ITEMCAT_GUNS, 15, "weapon_zs_z9000")
GM:AddPointShopWeapon(0,"nailgun", ITEMCAT_GUNS, 17, "weapon_zs_nailgun").NoClassicMode = true

GM:AddPointShopWeapon(1,"medgun", ITEMCAT_GUNS, 55, "weapon_zs_medicgun")
GM:AddPointShopWeapon(1,"whirlwind", ITEMCAT_GUNS, 50, "weapon_zs_whirlwind")
GM:AddPointShopWeapon(1,"biorifle", ITEMCAT_GUNS, 45, "weapon_zs_bioticrifle")
GM:AddPointShopWeapon(1,"glock3", ITEMCAT_GUNS, 60, "weapon_zs_glock3")
GM:AddPointShopWeapon(1,"deagle", ITEMCAT_GUNS, 65, "weapon_zs_deagle")
GM:AddPointShopWeapon(1,"shredder", ITEMCAT_GUNS, 60, "weapon_zs_smg")
GM:AddPointShopWeapon(1,"annabelle", ITEMCAT_GUNS, 65, "weapon_zs_annabelle")
GM:AddPointShopWeapon(1,"kalash", ITEMCAT_GUNS, 75, "weapon_zs_kalash")
GM:AddPointShopWeapon(1,"sweeper", ITEMCAT_GUNS, 70, "weapon_zs_sweepershotgun")
GM:AddPointShopWeapon(1,"neutrino", ITEMCAT_GUNS, 65, "weapon_zs_neutrino")

GM:AddPointShopWeapon(2,"eraser", ITEMCAT_GUNS, 95, "weapon_zs_eraser")
GM:AddPointShopWeapon(2,"waraxe", ITEMCAT_GUNS, 95, "weapon_zs_waraxe")
GM:AddPointShopWeapon(2,"magnum", ITEMCAT_GUNS, 95, "weapon_zs_magnum")
GM:AddPointShopWeapon(2,"sprayer", ITEMCAT_GUNS, 115, "weapon_zs_sprayersmg")
GM:AddPointShopWeapon(2,"hunter", ITEMCAT_GUNS, 100, "weapon_zs_hunter")
GM:AddPointShopWeapon(2,"stalker", ITEMCAT_GUNS, 120, "weapon_zs_m4")
GM:AddPointShopWeapon(2,"bioshotgun", ITEMCAT_GUNS, 87, "weapon_zs_bioticshotgun")
GM:AddPointShopWeapon(2,"ioncannon", ITEMCAT_GUNS, 110, "weapon_zs_ioncannon")


GM:AddPointShopWeapon(3,"terminator", ITEMCAT_GUNS, 165, "weapon_zs_terminator")
GM:AddPointShopWeapon(3,"immortal", ITEMCAT_GUNS, 170, "weapon_zs_immortal")
GM:AddPointShopWeapon(3,"bulletstorm", ITEMCAT_GUNS, 175, "weapon_zs_bulletstorm")
GM:AddPointShopWeapon(3,"zeus", ITEMCAT_GUNS, 165, "weapon_zs_zeus")
GM:AddPointShopWeapon(3,"inferno", ITEMCAT_GUNS, 165, "weapon_zs_inferno")
GM:AddPointShopWeapon(3,"ender",  ITEMCAT_GUNS, 165, "weapon_zs_ender")
GM:AddPointShopWeapon(3,"practition", ITEMCAT_GUNS, 145, "weapon_zs_practition")
GM:AddPointShopWeapon(3,"pulserifle", ITEMCAT_GUNS, 185, "weapon_zs_pulserifle")
GM:AddPointShopWeapon(3,"inquisition", ITEMCAT_GUNS, 155, "weapon_zs_inquisition")

GM:AddPointShopWeapon(4,"silencer", ITEMCAT_GUNS, 220, "weapon_zs_silencer")
GM:AddPointShopWeapon(4,"redeemer", ITEMCAT_GUNS, 215, "weapon_zs_redeemers")
GM:AddPointShopWeapon(4,"reaper", ITEMCAT_GUNS, 220, "weapon_zs_reaper")
GM:AddPointShopWeapon(4,"tommy", ITEMCAT_GUNS, 270, "weapon_zs_tommy")
GM:AddPointShopWeapon(4,"sg550", ITEMCAT_GUNS, 245, "weapon_zs_sg550")
GM:AddPointShopWeapon(4,"blitz", ITEMCAT_GUNS, 255, "weapon_zs_blitz")
GM:AddPointShopWeapon(4,"boomstick", ITEMCAT_GUNS, 245, "weapon_zs_boomstick")
GM:AddPointShopWeapon(4,"slugrifle", ITEMCAT_GUNS, 255, "weapon_zs_slugrifle")
GM:AddPointShopWeapon(4,"crossbow", ITEMCAT_GUNS, 250, "weapon_zs_crossbow")
GM:AddPointShopWeapon(4,"positron", ITEMCAT_GUNS, 265, "weapon_zs_positron")

--GM:AddPointShopWeapon(2,"grenadelauncher", ITEMCAT_GUNS, 120, "weapon_zs_grenadelauncher")

--[[GM:AddPointShopItem(nil,"pistolammo", "권총 탄약", nil, ITEMCAT_AMMO, 3, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoResupply["pistol"] or 12, "pistol", true) end, "models/Items/BoxSRounds.mdl")
GM:AddPointShopItem(nil,"shotgunammo", "샷건 탄약", nil, ITEMCAT_AMMO, 6, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoResupply["buckshot"] or 8, "buckshot", true) end, "models/Items/BoxBuckshot.mdl")
GM:AddPointShopItem(nil,"smgammo", "SMG 탄약", nil, ITEMCAT_AMMO, 5, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoResupply["smg1"] or 30, "smg1", true) end, "models/Items/BoxMRounds.mdl")
GM:AddPointShopItem(nil,"assaultrifleammo", "돌격소총 탄약", nil, ITEMCAT_AMMO, 6, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoResupply["ar2"] or 30, "ar2", true) end, "models/Items/357ammobox.mdl")
GM:AddPointShopItem(nil,"rifleammo", "소총 탄약", nil, ITEMCAT_AMMO, 8, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoResupply["357"] or 10, "357", true) end, "models/Items/BoxSniperRounds.mdl")
GM:AddPointShopItem(nil,"crossbowammo", "크로스보우 화살 묶음", nil, ITEMCAT_AMMO, 4, nil, function(pl) pl:GiveAmmo(5, "XBowBolt", true) end, "models/Items/CrossbowRounds.mdl")
--GM:AddPointShopItem(nil,"biomaterial", "생체 폐기물", "이 탄약을 사용하는 무기는 떨어진 고기 조각을 수집해 보충할 수도 있다.", ITEMCAT_AMMO, 5, nil, function(pl) pl:GiveAmmo(15, "alyxgun", true) end, "models/gibs/hgibs.mdl")
GM:AddPointShopItem(nil,"pulseammo", "펄스건 탄약", nil, ITEMCAT_AMMO, 5, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoResupply["pulse"] or 40, "pulse", true) end, "models/Items/combine_rifle_ammo01.mdl")
GM:AddPointShopItem(nil,"medicammo", "메디컬 에너지", nil, ITEMCAT_AMMO, 4, nil, function(pl) pl:GiveAmmo(50, "Battery", true) end, "models/healthvial.mdl")
--GM:AddPointShopItem(nil,"glgrenade", "유탄", nil, ITEMCAT_AMMO, 9, nil, function(pl) pl:GiveAmmo(1, "grenlauncher", true) end, "models/items/ar2_grenade.mdl")
GM:AddPointShopItem(nil,"empround", "EMP 배터리", "EMP건의 추가 탄환이다.", ITEMCAT_AMMO, 10, nil, function(pl) pl:GiveAmmo(3, "gravity", true) end, "models/items/Battery.mdl").NoClassicMode = true
GM:AddPointShopItem(nil,"nails", "못 2개", nil, ITEMCAT_AMMO, 5, nil, function(pl) pl:GiveAmmo(2, "GaussEnergy", true) end, "models/crossbow_bolt.mdl").NoClassicMode = true
GM:AddPointShopItem(nil,"woodboards", "나무 판자 5개", nil, ITEMCAT_AMMO, 10, nil, function(pl) pl:GiveAmmo(5, "SniperRound", true) end, "models/props_debris/wood_board06a.mdl").NoClassicMode = true]]

GM:AddPointShopWeapon(nil,"crphmr", ITEMCAT_MELEE, 20, "weapon_zs_hammer").NoClassicMode = true
--GM:AddPointShopItem(nil,"wrench", "메카닉의 렌치", nil, ITEMCAT_MELEE, 25, "weapon_zs_wrench").NoClassicMode = true
GM:AddPointShopWeapon(nil,"axe", ITEMCAT_MELEE, 35, "weapon_zs_axe")
GM:AddPointShopWeapon(nil,"crowbar", ITEMCAT_MELEE, 27, "weapon_zs_crowbar")
GM:AddPointShopWeapon(nil,"stunbaton", ITEMCAT_MELEE, 23, "weapon_zs_stunbaton")
GM:AddPointShopWeapon(nil,"knife", ITEMCAT_MELEE, 10, "weapon_zs_swissarmyknife")
--GM:AddPointShopWeapon(nil,"shovel", ITEMCAT_MELEE, 45, "weapon_zs_shovel")
GM:AddPointShopWeapon(nil,"sledgehammer", ITEMCAT_MELEE, 70, "weapon_zs_sledgehammer")
GM:AddPointShopWeapon(nil,"zpplnk", ITEMCAT_MELEE, 12, "weapon_zs_plank")
--GM:AddPointShopItem(nil,"zpfryp", "후라이팬", nil, ITEMCAT_MELEE, 31, "weapon_zs_fryingpan")
--GM:AddPointShopItem(nil,"zpcpot", "냄비", nil, ITEMCAT_MELEE, 32, "weapon_zs_pot")
GM:AddPointShopWeapon(nil,"butcher", ITEMCAT_MELEE, 29, "weapon_zs_butcherknife")
GM:AddPointShopWeapon(nil,"pipe", ITEMCAT_MELEE, 42, "weapon_zs_pipe")
GM:AddPointShopWeapon(nil,"hook", ITEMCAT_MELEE, 23, "weapon_zs_hook")
GM:AddPointShopWeapon(nil,"energysword", ITEMCAT_MELEE, 140, "weapon_zs_energysword")

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
item.NoClassicMode = true

local item = GM:AddPointShopWeapon(nil,"manhack", ITEMCAT_TOOLS, 55, "weapon_zs_manhack")
item.Countables = {"prop_manhack"}
item.NoClassicMode = true

local item = GM:AddPointShopWeapon(nil,"drone", ITEMCAT_TOOLS, 50, "weapon_zs_drone")
item.Countables = {"prop_drone"}
item.NoClassicMode = true
item.NoSampleCollectMode = true

GM:AddPointShopWeapon(nil,"ffemitter", ITEMCAT_TOOLS, 60, "weapon_zs_ffemitter").Countables = "prop_ffemitter"

GM:AddPointShopWeapon(nil,"barricadekit", ITEMCAT_TOOLS, 125, "weapon_zs_barricadekit").NoClassicMode = true
GM:AddPointShopWeapon(nil,"boardpack", ITEMCAT_TOOLS, 25, "weapon_zs_boardpack").NoClassicMode = true

--GM:AddPointShopItem(nil,"tracker", "송신기 추적장치", nil, ITEMCAT_OTHER, 5, "weapon_zs_objectiveradar").NoClassicMode = true

GM:AddPointShopWeapon(nil,"bodyarmor", ITEMCAT_OTHER, 35, "weapon_zs_bodyarmor")
GM:AddPointShopWeapon(nil,"extraspd", ITEMCAT_OTHER, 15, "weapon_zs_extraspeed")
GM:AddPointShopWeapon(nil,"grenade", ITEMCAT_OTHER, 15, "weapon_zs_grenade")
GM:AddPointShopWeapon(nil,"flashbang", ITEMCAT_OTHER, 10, "weapon_zs_flashbang")
GM:AddPointShopWeapon(nil,"smoke", ITEMCAT_OTHER, 7, "weapon_zs_smokegrenade")
GM:AddPointShopWeapon(nil,"detpck", ITEMCAT_OTHER, 40, "weapon_zs_detpack")

-- These are the honorable mentions that come at the end of the round.

local function genericcallback(pl, magnitude) return pl:Name(), magnitude end
GM.HonorableMentions = {}
GM.HonorableMentions[HM_MOSTENEMYKILLED] = {Name = "살인마", String = "%s - %d명의 적을 죽였다.", Callback = genericcallback}
GM.HonorableMentions[HM_MOSTDAMAGETOENEMY] = {Name = "전쟁광", String = "%s - 전체 %d 대미지를 적에게 주었다.", Callback = genericcallback}
GM.HonorableMentions[HM_KILLSTREAK] = {Name = "특전사", String = "%s - 죽지 않고 연속으로 적 %d명을 죽였다.", Callback = genericcallback}
GM.HonorableMentions[HM_PACIFIST] = {Name = "비폭력주의자", String = "%s - 한 명의 적도 죽이지 않았다.", Callback = genericcallback}
GM.HonorableMentions[HM_MOSTHELPFUL] = {Name = "조력자", String = "%s - 동료가 %d명의 적을 죽일 수 있도록 도왔다.", Callback = genericcallback, Color = COLOR_YELLOW}
GM.HonorableMentions[HM_USEFULTOOPPOSITE] = {Name = "자살특공대", String = "%s는 적에게 %d번 죽었다.", Callback = genericcallback, Color = COLOR_DARKRED}
GM.HonorableMentions[HM_BLACKCOW] = {Name = "흑우", String = "%s - 물건을 사는 데 %d포인트를 사용했다.", Callback = genericcallback}
GM.HonorableMentions[HM_HACKER] = {Name = "어나니머스", String = "%s - 백도어 장치를 이용해 %d개의 송신기를 탈환했다.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_COMMSUNIT] = {Name = "통신병", String = "%s - 송신기 점령에 %d초를 소비했다.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_GOODDOCTOR] = {Name = "의사양반", String = "%s - 팀의 체력을 %d만큼 책임졌다.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_HANDYMAN] = {Name = "공돌이", String = "%s - %d만큼 바리케이드를 수리했다.", Callback = genericcallback, Color = COLOR_WHITE}
GM.HonorableMentions[HM_BARRICADEDESTROYER] = {Name = "철거단원", String = "%s - 바리케이드에 %d의 대미지를 주었다.", Callback = genericcallback}
GM.HonorableMentions[HM_WARRIOR] = {Name = "백병전 마스터", String = "%s는 근접전에서 %d명의 적을 사살하였다.", Callback = genericcallback}
GM.HonorableMentions[HM_HEADSHOTS] = {Name = "헤드헌터", String = "%s - 적 %d명의 머리를 뚫어버렸다.", Callback = genericcallback}
GM.HonorableMentions[HM_BESTAIM] = {Name = "정확한 에임", String = "%s - 발사한 탄환의 %d%%가 명중하였다.", Callback = genericcallback}

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
	
GM.MaxSigils = CreateConVar("zsb_maxsigils", "3", FCVAR_ARCHIVE + FCVAR_NOTIFY, "How many sigils to spawn. 0 for none."):GetInt()
cvars.AddChangeCallback("zsb_maxsigils", function(cvar, oldvalue, newvalue)
	GAMEMODE.MaxSigils = math.Clamp(tonumber(newvalue) or 0, 0, 10)
end)

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
GM.WaveIntermissionLength = 35

-- For Classic Mode
GM.WaveIntermissionLengthClassic = 25

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
