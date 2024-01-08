GM.WeaponClassItemCatRanges = {
	ITEMCAT_GUNS = {1,15},
	ITEMCAT_MELEE = {24, 29},
	ITEMCAT_TOOLS = {47},
	ITEMCAT_CONS = {48}
}

------------ WEAPON CLASS COLOURS ------------

GM.WeaponClassColors = {}

GM.WeaponClassColors[WEAPONCLASS_FASTPISTOL] = COLOR_CYAN
GM.WeaponClassColors[WEAPONCLASS_MAGNUMPISTOL] = COLOR_BLUE
GM.WeaponClassColors[WEAPONCLASS_SPLITPISTOL] = COLOR_LIGHTBLUE

GM.WeaponClassColors[WEAPONCLASS_SHOTGUN] = COLOR_CORAL
GM.WeaponClassColors[WEAPONCLASS_AUTOSHOTGUN] = COLOR_MAGENTA

GM.WeaponClassColors[WEAPONCLASS_ASSAULT] = COLOR_VERMILLION
GM.WeaponClassColors[WEAPONCLASS_SMG] = COLOR_ORANGE
GM.WeaponClassColors[WEAPONCLASS_ASSAULTSMG] = COLOR_AMBER
GM.WeaponClassColors[WEAPONCLASS_SNIPER] = COLOR_RED
GM.WeaponClassColors[WEAPONCLASS_MARKSMAN] = COLOR_DARKRED

GM.WeaponClassColors[WEAPONCLASS_CROSSBOW] = COLOR_PURPLE
GM.WeaponClassColors[WEAPONCLASS_BIO] = COLOR_DARKPURPLE

GM.WeaponClassColors[WEAPONCLASS_PULSE] = COLOR_YELLOW
GM.WeaponClassColors[WEAPONCLASS_MEDICAL] = COLOR_DARKGREEN

GM.WeaponClassColors[WEAPONCLASS_UTIL] = COLOR_LIMEGREEN
----------------------------------------------

GM.PossiblePrimaryGuns = {
	"weapon_zs_tosser",
	"weapon_zs_crackler",
	"weapon_zs_doublebarrel",
	"weapon_zs_stubber"
}
GM.PossibleSecondaryGuns = {
	"weapon_zs_peashooter",
	"weapon_zs_battleaxe",
	"weapon_zs_slinger"
}
GM.PossibleMelees = {
	"weapon_zs_swissarmyknife",
	"weapon_zs_lamp",
	"weapon_zs_plank"
}

GM.Items = {}
function GM:AddItem(tier, signature, name, desc, cost, swep, callback, canbuy, failtobuystr, wepclass)
	local prereqs = {}
	local category = ITEMCAT_OTHER
	if wepclass ~= nil then
		for k, v in pairs(self.WeaponClassItemCatRanges) do
			if ((v[1] && v[2]) && wepclass >= v[1] && wepclass <= v[2]) || v[1] && wepclass == v[1] then
				category = k
				break
			end
		end
	end
	local tab = { 
		ID = #self.Items + 1, 
		Tier = tier, 
		Signature = signature, 
		TranslateName = name, 
		TranslateDesc = desc, 
		Category = category, 
		Cost = cost or 0, 
		SWEP = swep, 
		Callback = callback, 
		CanPurchaseFunc = canbuy, 
		FailTranslateString = failtobuystr, 
		Prerequisites = prereqs,
		WeaponClass = wepclass
	}
	self.Items[#self.Items + 1] = tab
	return tab
end

function GM:AddPointShopItem(tier, signature, name, desc, points, callback, canbuy, failtobuystr)
	return self:AddItem(tier, "ps_"..signature, name, desc, points, nil, callback, canbuy, failtobuystr, nil)
end

function GM:AddPointShopWeapon(tier, signature, points, swep, wepclass)
	return self:AddItem(tier, "ps_"..signature, nil, nil, points, swep, nil,nil,nil, wepclass)
end

function GM:AddWeaponPrerequisite(wep,prereqsignature)
	if (wep.Prerequisites == nil) then 
		wep.Prerequisites = {} 
	end

	table.insert( wep.Prerequisites, "ps_"..prereqsignature)
end 

-- These ammo types are available at ammunition boxes.
-- The amount is the ammo to give them.
-- If the player isn't holding a weapon that uses one of these then they will get smg1 ammo.
GM.AmmoResupply = {}
--GM.AmmoResupply["alyxgun"] = 40
GM.AmmoResupply["ar2"] = 20
GM.AmmoResupply["pistol"] = 12
GM.AmmoResupply["smg1"] = 20
GM.AmmoResupply["357"] = 6
GM.AmmoResupply["xbowbolt"] = 2
GM.AmmoResupply["buckshot"] = 8
GM.AmmoResupply["battery"] = 30
GM.AmmoResupply["pulse"] = 30
GM.AmmoResupply["gaussenergy"] = 3
--GM.AmmoResupply["gravity"] = 1 -- EMP Charge.
GM.AmmoResupply["sniperround"] = 1
--GM.AmmoResupply["grenlauncher"] = 1

------------
-- Points --
------------

------------ WEAPONS ------------
/* 
ALL weapons need to be defined as AddPointShopWeapon(tier (int), unique id (string),points to purchase/ upgrade (int) , weapon classname (string), WEAPONCLASS enum)
*/
------------ GUNS --------------
------------ TIER 0 ------------

GM:AddPointShopWeapon(0,"btlax", 10, "weapon_zs_battleaxe", WEAPONCLASS_MAGNUMPISTOL)
GM:AddPointShopWeapon(0,"pshtr", 10, "weapon_zs_peashooter", WEAPONCLASS_FASTPISTOL)
GM:AddPointShopWeapon(0,"slngr", 10, "weapon_zs_slinger", WEAPONCLASS_CROSSBOW)
GM:AddPointShopWeapon(0,"tossr", 15, "weapon_zs_tosser", WEAPONCLASS_SMG)
GM:AddPointShopWeapon(0,"crklr", 15, "weapon_zs_crackler", WEAPONCLASS_ASSAULT)
GM:AddPointShopWeapon(0,"stbbr", 15, "weapon_zs_stubber", WEAPONCLASS_SNIPER)
GM:AddPointShopWeapon(0,"doublebarrel", 15, "weapon_zs_doublebarrel", WEAPONCLASS_SHOTGUN)
GM:AddPointShopWeapon(0,"jabbr", 20, "weapon_zs_injector", WEAPONCLASS_MEDICAL)

-- Conflicted about this one being here, but should be OK since it's non classic mode.
GM:AddPointShopWeapon(0,"nailgun", 30, "weapon_zs_nailgun", WEAPONCLASS_UTIL).NoClassicMode = true

------------ TIER 1 ------------

local item = GM:AddPointShopWeapon(1,"deagle", 65, "weapon_zs_deagle", WEAPONCLASS_MAGNUMPISTOL)
GM:AddWeaponPrerequisite(item,"btlax")

local item = GM:AddPointShopWeapon(1,"owens", 65, "weapon_zs_owens", WEAPONCLASS_SPLITPISTOL)
GM:AddWeaponPrerequisite(item,"btlax")

local item = GM:AddPointShopWeapon(1,"eraser", 65, "weapon_zs_eraser", WEAPONCLASS_FASTPISTOL)
GM:AddWeaponPrerequisite(item,"pshtr")

local item = GM:AddPointShopWeapon(1,"z9000", 70, "weapon_zs_z9000", WEAPONCLASS_PULSE)
GM:AddWeaponPrerequisite(item,"pshtr")
GM:AddWeaponPrerequisite(item,"btlax")

local item = GM:AddPointShopWeapon(1,"medgun", 60, "weapon_zs_medicgun", WEAPONCLASS_MEDICAL)
GM:AddWeaponPrerequisite(item,"jabbr")

local item = GM:AddPointShopWeapon(1,"bioshotgun", 65, "weapon_zs_bioticshotgun", WEAPONCLASS_BIO)
GM:AddWeaponPrerequisite(item,"doublebarrel")
GM:AddWeaponPrerequisite(item,"slngr")
local item = GM:AddPointShopWeapon(1,"trench", 70, "weapon_zs_trenchshotgun", WEAPONCLASS_SHOTGUN)
GM:AddWeaponPrerequisite(item,"doublebarrel")

local item = GM:AddPointShopWeapon(1,"shredder", 60, "weapon_zs_smg", WEAPONCLASS_SMG)
GM:AddWeaponPrerequisite(item,"tossr")

local item = GM:AddPointShopWeapon(1,"annabelle", 75, "weapon_zs_annabelle", WEAPONCLASS_SNIPER)
GM:AddWeaponPrerequisite(item,"stbbr")

local item = GM:AddPointShopWeapon(1,"kalash", 75, "weapon_zs_kalash", WEAPONCLASS_ASSAULT)
GM:AddWeaponPrerequisite(item,"crklr")

local item = GM:AddPointShopWeapon(1,"inquisition", 70, "weapon_zs_inquisition", WEAPONCLASS_CROSSBOW)
GM:AddWeaponPrerequisite(item,"slngr")
GM:AddWeaponPrerequisite(item,"nailgun")

------------ TIER 2 ------------

local item = GM:AddPointShopWeapon(2,"magnum", 140, "weapon_zs_magnum", WEAPONCLASS_MAGNUMPISTOL)
GM:AddWeaponPrerequisite(item,"deagle")

local item = GM:AddPointShopWeapon(2,"glock3", 135, "weapon_zs_glock3", WEAPONCLASS_SPLITPISTOL)
GM:AddWeaponPrerequisite(item,"owens")

local item = GM:AddPointShopWeapon(2,"terminator", 135, "weapon_zs_terminator", WEAPONCLASS_FASTPISTOL)
GM:AddWeaponPrerequisite(item,"eraser")

local item = GM:AddPointShopWeapon(2,"neutrino", 140, "weapon_zs_neutrino", WEAPONCLASS_PULSE)
GM:AddWeaponPrerequisite(item,"z9000")
GM:AddWeaponPrerequisite(item,"shredder")
local item = GM:AddPointShopWeapon(2,"ioncannon", 145, "weapon_zs_ioncannon", WEAPONCLASS_PULSE)
GM:AddWeaponPrerequisite(item,"z9000")
GM:AddWeaponPrerequisite(item,"trench")
local item = GM:AddPointShopWeapon(2,"rupture", 130, "weapon_zs_rupture", WEAPONCLASS_PULSE)
GM:AddWeaponPrerequisite(item,"z9000")
GM:AddWeaponPrerequisite(item,"inquisition")

local item = GM:AddPointShopWeapon(2,"practition", 145, "weapon_zs_practition", WEAPONCLASS_MEDICAL)
GM:AddWeaponPrerequisite(item,"medgun")

local item = GM:AddPointShopWeapon(2,"biosmg", 140, "weapon_zs_bioticsmg", WEAPONCLASS_BIO)
GM:AddWeaponPrerequisite(item,"bioshotgun")
local item = GM:AddPointShopWeapon(2,"sweeper", 145, "weapon_zs_sweepershotgun", WEAPONCLASS_SHOTGUN)
GM:AddWeaponPrerequisite(item,"trench")

local item = GM:AddPointShopWeapon(2,"sprayer", 145, "weapon_zs_sprayersmg", WEAPONCLASS_SMG)
GM:AddWeaponPrerequisite(item,"shredder")

local item = GM:AddPointShopWeapon(2,"hunter", 135, "weapon_zs_hunter", WEAPONCLASS_SNIPER)
GM:AddWeaponPrerequisite(item,"annabelle")
local item = GM:AddPointShopWeapon(2,"fusilier", 150, "weapon_zs_fusilier", WEAPONCLASS_MARKSMAN)
GM:AddWeaponPrerequisite(item,"annabelle")

local item = GM:AddPointShopWeapon(2,"stalker", 150, "weapon_zs_m4", WEAPONCLASS_ASSAULT)
GM:AddWeaponPrerequisite(item,"kalash")

local item = GM:AddPointShopWeapon(2,"podvodny", 145, "weapon_zs_podvodny", WEAPONCLASS_CROSSBOW)
GM:AddWeaponPrerequisite(item,"inquisition")

------------ TIER 3 ------------

local item = GM:AddPointShopWeapon(3,"immortal", 200, "weapon_zs_immortal", WEAPONCLASS_MAGNUMPISTOL)
GM:AddWeaponPrerequisite(item,"magnum")

local item = GM:AddPointShopWeapon(3,"waraxe", 200, "weapon_zs_waraxe", WEAPONCLASS_SPLITPISTOL)
GM:AddWeaponPrerequisite(item,"glock3")

local item = GM:AddPointShopWeapon(3,"redeemer", 200, "weapon_zs_redeemers", WEAPONCLASS_FASTPISTOL)
GM:AddWeaponPrerequisite(item,"terminator")

local item = GM:AddPointShopWeapon(3,"pulserifle", 215, "weapon_zs_pulserifle", WEAPONCLASS_PULSE)
GM:AddWeaponPrerequisite(item,"neutrino")
GM:AddWeaponPrerequisite(item,"ioncannon")
GM:AddWeaponPrerequisite(item,"stalker")
local item = GM:AddPointShopWeapon(3,"renegade", 210, "weapon_zs_renegade", WEAPONCLASS_PULSE)
GM:AddWeaponPrerequisite(item,"rupture")
GM:AddWeaponPrerequisite(item,"ioncannon")
GM:AddWeaponPrerequisite(item,"hunter")

local item = GM:AddPointShopWeapon(3,"medicrifle", 195, "weapon_zs_medicrifle", WEAPONCLASS_MEDICAL)
GM:AddWeaponPrerequisite(item,"practition")

local item = GM:AddPointShopWeapon(3,"biorifle", 195, "weapon_zs_bioticrifle", WEAPONCLASS_BIO)
GM:AddWeaponPrerequisite(item,"biosmg")
local item = GM:AddPointShopWeapon(3,"albatross", 195, "weapon_zs_albatross", WEAPONCLASS_AUTOSHOTGUN)
GM:AddWeaponPrerequisite(item,"sweeper")
local item = GM:AddPointShopWeapon(3,"severance", 200, "weapon_zs_severance", WEAPONCLASS_SHOTGUN)
GM:AddWeaponPrerequisite(item,"sweeper")

local item = GM:AddPointShopWeapon(3,"bulletstorm", 215, "weapon_zs_bulletstorm", WEAPONCLASS_SMG)
GM:AddWeaponPrerequisite(item,"sprayer")
local item = GM:AddPointShopWeapon(3,"reaper", 200, "weapon_zs_reaper", WEAPONCLASS_ASSAULTSMG)
GM:AddWeaponPrerequisite(item,"sprayer")

local item = GM:AddPointShopWeapon(3,"zeus", 205, "weapon_zs_zeus", WEAPONCLASS_MARKSMAN)
GM:AddWeaponPrerequisite(item,"fusilier")
local item = GM:AddPointShopWeapon(3,"blockdown", 210, "weapon_zs_combinesniper", WEAPONCLASS_SNIPER)
GM:AddWeaponPrerequisite(item,"hunter")

local item = GM:AddPointShopWeapon(3,"inferno", 205, "weapon_zs_inferno", WEAPONCLASS_ASSAULT)
GM:AddWeaponPrerequisite(item,"stalker")

local item = GM:AddPointShopWeapon(3,"silencedm4", 255, "weapon_zs_m4_silenced", WEAPONCLASS_ASSAULT)
GM:AddWeaponPrerequisite(item,"stalker")

local item = GM:AddPointShopWeapon(3,"arbalest", 200, "weapon_zs_arbalest", WEAPONCLASS_CROSSBOW)
GM:AddWeaponPrerequisite(item,"podvodny")

------------ TIER 4 ------------

local item = GM:AddPointShopWeapon(4,"ventilator", 285, "weapon_zs_ventilator", WEAPONCLASS_MAGNUMPISTOL)
GM:AddWeaponPrerequisite(item,"immortal")
GM:AddWeaponPrerequisite(item,"waraxe")

local item = GM:AddPointShopWeapon(4,"silencer", 290, "weapon_zs_silencer", WEAPONCLASS_FASTPISTOL)
GM:AddWeaponPrerequisite(item,"redeemer")

local item = GM:AddPointShopWeapon(4,"positron", 320, "weapon_zs_positron", WEAPONCLASS_PULSE)
GM:AddWeaponPrerequisite(item,"pulserifle")
GM:AddWeaponPrerequisite(item,"renegade")

local item = GM:AddPointShopWeapon(4,"palliator", 290, "weapon_zs_palliator", WEAPONCLASS_MEDICAL)
GM:AddWeaponPrerequisite(item,"medicrifle")

local item = GM:AddPointShopWeapon(4,"blightcaster", 280, "weapon_zs_blightcaster", WEAPONCLASS_BIO)
GM:AddWeaponPrerequisite(item,"biorifle")
local item = GM:AddPointShopWeapon(4,"boomstick", 285, "weapon_zs_boomstick", WEAPONCLASS_SHOTGUN)
GM:AddWeaponPrerequisite(item,"severance")
local item = GM:AddPointShopWeapon(4,"ender", 290, "weapon_zs_ender", WEAPONCLASS_AUTOSHOTGUN)
GM:AddWeaponPrerequisite(item,"albatross")

local item = GM:AddPointShopWeapon(4,"m249", 300, "weapon_zs_m249", WEAPONCLASS_SMG)
GM:AddWeaponPrerequisite(item,"bulletstorm")
local item = GM:AddPointShopWeapon(4,"tommy", 290, "weapon_zs_tommy", WEAPONCLASS_ASSAULTSMG)
GM:AddWeaponPrerequisite(item,"reaper")

local item = GM:AddPointShopWeapon(4,"sg550", 295, "weapon_zs_sg550", WEAPONCLASS_MARKSMAN)
GM:AddWeaponPrerequisite(item,"zeus")
local item = GM:AddPointShopWeapon(4,"slugrifle", 300, "weapon_zs_slugrifle", WEAPONCLASS_SNIPER)
GM:AddWeaponPrerequisite(item,"blockdown")

local item = GM:AddPointShopWeapon(4,"blitz", 295, "weapon_zs_blitz", WEAPONCLASS_ASSAULT)
GM:AddWeaponPrerequisite(item,"inferno")

local item = GM:AddPointShopWeapon(4,"crossbow", 300, "weapon_zs_crossbow", WEAPONCLASS_CROSSBOW)
GM:AddWeaponPrerequisite(item,"arbalest")


local item = GM:AddPointShopWeapon(0,"crphmr", 35, "weapon_zs_hammer", WEAPONCLASS_MELEE_UTIL)
item.NoClassicMode = true
local item = GM:AddPointShopWeapon(0,"wrench", 40, "weapon_zs_wrench", WEAPONCLASS_MELEE_UTIL)
item.NoClassicMode = true
item.NoSampleCollectMode = true
GM:AddPointShopWeapon(0,"zpplnk", 10, "weapon_zs_plank", WEAPONCLASS_MELEE_GENERIC)
GM:AddPointShopWeapon(0,"knife", 10, "weapon_zs_swissarmyknife", WEAPONCLASS_MELEE_GENERIC)
GM:AddPointShopWeapon(0,"zslamp", 10, "weapon_zs_lamp", WEAPONCLASS_MELEE_GENERIC)
GM:AddPointShopWeapon(0,"hook", 38, "weapon_zs_hook", WEAPONCLASS_MELEE_GENERIC)

local item = GM:AddPointShopWeapon(1,"electrohmr", 85, "weapon_zs_electrohammer", WEAPONCLASS_MELEE_GENERIC)
GM:AddWeaponPrerequisite(item,"crphmr")
item.NoClassicMode = true
local item = GM:AddPointShopWeapon(1,"breenbust", 65, "weapon_zs_bust", WEAPONCLASS_MELEE_GENERIC)
GM:AddWeaponPrerequisite(item,"zpplnk")
local item = GM:AddPointShopWeapon(1,"keyboard", 50, "weapon_zs_keyboard", WEAPONCLASS_MELEE_GENERIC)
GM:AddWeaponPrerequisite(item,"zpplnk")
local item = GM:AddPointShopWeapon(1,"crowbar", 52, "weapon_zs_crowbar", WEAPONCLASS_MELEE_GENERIC)
GM:AddWeaponPrerequisite(item,"zpplnk")
GM:AddWeaponPrerequisite(item,"zslamp")
local item = GM:AddPointShopWeapon(1,"shovel", 55, "weapon_zs_shovel", WEAPONCLASS_MELEE_GENERIC)
GM:AddWeaponPrerequisite(item,"zslamp")
GM:AddWeaponPrerequisite(item,"zpplnk")
local item = GM:AddPointShopWeapon(1,"axe", 55, "weapon_zs_axe", WEAPONCLASS_MELEE_GENERIC)
GM:AddWeaponPrerequisite(item,"knife")
GM:AddWeaponPrerequisite(item,"zslamp")
local item = GM:AddPointShopWeapon(1,"butcher", 55, "weapon_zs_butcherknife", WEAPONCLASS_MELEE_GENERIC)
GM:AddWeaponPrerequisite(item,"knife")

local item = GM:AddPointShopWeapon(2,"extbaton", 80, "weapon_zs_extendingbaton", WEAPONCLASS_MELEE_GENERIC)
GM:AddWeaponPrerequisite(item,"breenbust")
GM:AddWeaponPrerequisite(item,"keyboard")
local item = GM:AddPointShopWeapon(2,"sledgehammer", 90, "weapon_zs_sledgehammer", WEAPONCLASS_MELEE_GENERIC)
GM:AddWeaponPrerequisite(item,"crowbar")
GM:AddWeaponPrerequisite(item,"shovel")
local item = GM:AddPointShopWeapon(2,"pipe", 85, "weapon_zs_pipe", WEAPONCLASS_MELEE_GENERIC)
GM:AddWeaponPrerequisite(item,"crowbar")
GM:AddWeaponPrerequisite(item,"breenbust")
local item = GM:AddPointShopWeapon(2,"sawhack", 80, "weapon_zs_sawhack", WEAPONCLASS_MELEE_GENERIC)
GM:AddWeaponPrerequisite(item,"axe")
local item = GM:AddPointShopWeapon(2,"longsword", 85, "weapon_zs_longsword", WEAPONCLASS_MELEE_GENERIC)
GM:AddWeaponPrerequisite(item,"butcher")

local item = GM:AddPointShopWeapon(3,"megamasher", 150, "weapon_zs_megamasher", WEAPONCLASS_MELEE_GENERIC)
GM:AddWeaponPrerequisite(item,"sledgehammer")
GM:AddWeaponPrerequisite(item,"pipe")
local item = GM:AddPointShopWeapon(3,"stunbaton", 135, "weapon_zs_stunbaton", WEAPONCLASS_MELEE_GENERIC)
GM:AddWeaponPrerequisite(item,"extbaton")
local item = GM:AddPointShopWeapon(3,"energysword", 145, "weapon_zs_energysword", WEAPONCLASS_MELEE_GENERIC)
GM:AddWeaponPrerequisite(item,"longsword")
local item = GM:AddPointShopWeapon(3,"greataxe", 140, "weapon_zs_greataxe", WEAPONCLASS_MELEE_GENERIC)
GM:AddWeaponPrerequisite(item,"sawhack")

--GM:AddPointShopWeapon(nil,"zpfryp", ITEMCAT_MELEE, 31, "weapon_zs_fryingpan")
--GM:AddPointShopWeapon(nil,"zpcpot", ITEMCAT_MELEE, 32, "weapon_zs_pot")

GM:AddPointShopWeapon(nil,"barricadekit", 125, "weapon_zs_barricadekit", WEAPONCLASS_TOOL).NoClassicMode = true
local item = GM:AddPointShopWeapon(nil,"empgun", 55, "weapon_zs_empgun", WEAPONCLASS_TOOL)
item.NoClassicMode = true
item.NoSampleCollectMode = true

local item = GM:AddPointShopWeapon(nil,"grenadelauncher", 70, "weapon_zs_grenadelauncher", WEAPONCLASS_TOOL)
item.NoClassicMode = true
GM:AddPointShopWeapon(nil,"whirlwind", 70, "weapon_zs_whirlwind", WEAPONCLASS_TOOL)
local item = GM:AddPointShopWeapon(nil,"backdoor", 45, "weapon_zs_backdoor", WEAPONCLASS_TOOL)
item.NoClassicMode = true
item.NoSampleCollectMode = true

local item = GM:AddPointShopWeapon(nil,"sgnlboost", 20, "weapon_zs_signalbooster", WEAPONCLASS_TOOL)
item.NoClassicMode = true
item.NoSampleCollectMode = true

local item = GM:AddPointShopWeapon(nil,"infturret", 60, "weapon_zs_gunturret", WEAPONCLASS_TOOL)
item.Countables = {"prop_gunturret"}
--item.ControllerWep = "weapon_zs_gunturretcontrol"
--item.NoClassicMode = true

local item = GM:AddPointShopWeapon(nil,"manhack", 55, "weapon_zs_manhack", WEAPONCLASS_TOOL)
item.Countables = {"prop_manhack","weapon_zs_manhackcontrol"}
item.ControllerWep = "weapon_zs_manhackcontrol"
--item.NoClassicMode = true

local item = GM:AddPointShopWeapon(nil,"drone", 50, "weapon_zs_drone", WEAPONCLASS_TOOL)
item.Countables = {"prop_drone","weapon_zs_dronecontrol"}
item.ControllerWep = "weapon_zs_dronecontrol"
item.NoClassicMode = true
item.NoSampleCollectMode = true

GM:AddPointShopWeapon(nil,"ffemitter", 60, "weapon_zs_ffemitter", WEAPONCLASS_TOOL).Countables = "prop_ffemitter"
GM:AddPointShopWeapon(nil,"pointdefence", 60, "weapon_zs_spotlamp", WEAPONCLASS_TOOL).Countables = "prop_spotlamp"
GM:AddPointShopWeapon(nil,"enemytracker", 15, "weapon_zs_enemyradar", WEAPONCLASS_TOOL)
GM:AddPointShopWeapon(nil,"medkit", 40, "weapon_zs_medicalkit", WEAPONCLASS_TOOL)
GM:AddPointShopWeapon(nil,"ammokit", 40, "weapon_zs_ammokit", WEAPONCLASS_TOOL)

GM:AddPointShopWeapon(nil,"boardpack", 25, "weapon_zs_boardpack", WEAPONCLASS_TOOL).NoClassicMode = true

GM:AddPointShopWeapon(nil,"grenade", 15, "weapon_zs_grenade", WEAPONCLASS_CONSUMABLE)
GM:AddPointShopWeapon(nil,"flashbang", 10, "weapon_zs_flashbang", WEAPONCLASS_CONSUMABLE)
GM:AddPointShopWeapon(nil,"smoke", 7, "weapon_zs_smokegrenade", WEAPONCLASS_CONSUMABLE)
GM:AddPointShopWeapon(nil,"detpck", 40, "weapon_zs_detpack", WEAPONCLASS_CONSUMABLE)

local item = GM:AddPointShopItem(nil,"bodyarmor", "shopitem_bodyarmor_name", "shopitem_bodyarmor_desc", 25,function(pl) pl:WearBodyArmor() end, function(pl) return (pl.GetBodyArmor and pl:GetBodyArmor() < 100) end,"shopitem_bodyarmor_alreadyhave")

local item = GM:AddPointShopItem(nil,"extraspd", "shopitem_adrenaline_name", "shopitem_adrenaline_desc", 10,function(pl) pl:ApplyAdrenaline() end, function(pl) return not (pl:GetMaxHealth() < 60) end,"shopitem_adrenaline_toomuch")

local item = GM:AddPointShopItem(nil,"ammopurchase", "shopitem_ammo_name", "shopitem_ammo_desc", 20, function(pl) pl:RefillActiveWeapon() end, function(pl) return pl:ActiveWeaponCanBeRefilled() end, "shopitem_ammo_invalid")

-- Cache this now so we don't need to do it over and over

local function GetItemsByWeaponClass(wepclass)
	if not wepclass then return end

	local wepclassitems = {}
	for i, tab in pairs(GM.Items) do
		if tab.WeaponClass == wepclass then
			table.insert(wepclassitems, tab)
		end
	end

	return wepclassitems
end

GM.ItemsWepClass = {}
for i = 1, 48 do -- update when more weapon classes get added
	GM.ItemsWepClass[i] = GetItemsByWeaponClass(i)
	--print("Weapon Class "..i)
	--PrintTable(GM.ItemsWepClass[i])
end

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

GM.MapWhitelist = {
	--"cs_assault", Assault is way more fun in classic mode.
	--"cs_compound",
	"cs_galleria",
	--"cs_havana", Because of how this map is laid out it can become impossible to get to transmitters
	"cs_italy",
	"cs_miami_css",
	"cs_militia",
	"cs_office",
	"de_aztec",
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
	--"de_prodigy", Map is too confusing for anything that isn't classic.
	"de_school",
	"de_tides",
	"de_train",
	--"zm_4ngry_quaruntine", Map is too small to really do a non-classic mode on.
	"zm_ryan_valley02",
	"zm_tx_highschoolbeta7_d_vh",
	"zs_barren",
	"zs_lockup_v2",
	"zs_ravine",
	"zs_slugde",
	"zs_urbandecay_v4",
	"zsb_streetwar02a",
	"zsb_hallways"
}
GM.RandomSurvivorModels = {
	"female07",
	"female08",
	"female09",
	"female10",
	"female11",
	"female12",
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
	--"stripped",
	"combine",
	"combineelite",
	--"combineprison",
	--"css_arctic",
	--"css_gasmask",
	"css_guerilla",
	"css_leet",
	"css_phoenix",
	--"css_riot",
	--"css_swat",
	--"css_urban",
}

-- Zombine: has no head.
-- Skeleton: doesn't have flesh therefore making the hitboxes seem wonky

GM.RestrictedModels = {
	"charple",
	"corpse",
	"skeleton",
	"zombie",
	"zombiefast",
	"zombine"
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
	tab.DefaultClip = math.ceil(tab.ClipSize * self.SurvivalClips)
end

-- Utility function to setup weapon default aim stats.
function GM:SetupAimDefaults(tab,primtab)
	tab.AimExpandUnit = math.Round((tab.ConeMax - tab.ConeMin)/math.min(primtab.Delay*primtab.ClipSize,1.3),4)
	tab.AimCollapseUnit = (tab.ConeMax - tab.ConeMin)*4
	tab.AimExpandStayDuration = tab.Primary.Delay*0.75
end
	
GM.MaxTransmitters = 3
GM.NumberOfWaves = CreateConVar("zsb_numberofwaves", "9", FCVAR_REPLICATED + FCVAR_ARCHIVE + FCVAR_NOTIFY, "Number of waves in a game."):GetInt()
cvars.AddChangeCallback("zsb_numberofwaves", function(cvar, oldvalue, newvalue)
	GAMEMODE.NumberOfWaves = tonumber(newvalue) or 1
end)

GM.RoundLimit = CreateConVar("zsb_roundlimit", "3", FCVAR_ARCHIVE + FCVAR_NOTIFY, "How many times the game can be played on the same map. -1 means infinite or only use time limit. 0 means once."):GetInt()
cvars.AddChangeCallback("zsb_roundlimit", function(cvar, oldvalue, newvalue)
	GAMEMODE.RoundLimit = tonumber(newvalue) or 3
end)

GM.ClientSideHitscan = CreateConVar("zsb_clientsidehitscan", "0", FCVAR_REPLICATED + FCVAR_ARCHIVE + FCVAR_NOTIFY, "Enable clientside hitscan detection instead of serverside. Helps with detection but can be exploited more easily."):GetBool()
cvars.AddChangeCallback("zsb_clientsidehitscan", function(cvar, oldvalue, newvalue)
	GAMEMODE.ClientSideHitscan = tonumber(newvalue) == 1
end)

-- Low player count threshold. Used for increasing sample drop count.
GM.LowPlayerCountThreshold = CreateConVar("zsb_lowplayercountthreshold", "6", FCVAR_REPLICATED + FCVAR_ARCHIVE + FCVAR_NOTIFY, "The number of players below which the sample drop count starts being increased."):GetInt()
cvars.AddChangeCallback("zsb_lowplayercountthreshold", function(cvar, oldvalue, newvalue)
	GAMEMODE.LowPlayerCountThreshold = tonumber(newvalue) or 6
end)

GM.LowPlayerCountSamplesMaxAdditionalCountPlayer = CreateConVar("zsb_max_additional_samples_count_player", "3", FCVAR_REPLICATED + FCVAR_ARCHIVE + FCVAR_NOTIFY, "The maximum number of additional samples a killed player will drop when the player count is below the low player count threshold."):GetInt()
cvars.AddChangeCallback("zsb_max_additional_samples_count_player", function(cvar, oldvalue, newvalue)
	GAMEMODE.LowPlayerCountSamplesMaxAdditionalCountPlayer = tonumber(newvalue) or 3
end)

GM.LowPlayerCountSamplesMaxAdditionalCountNest = CreateConVar("zsb_max_additional_samples_count_nest", "10", FCVAR_REPLICATED + FCVAR_ARCHIVE + FCVAR_NOTIFY, "The maximum number of additional samples a nest will drop when the player count is below the low player count threshold."):GetInt()
cvars.AddChangeCallback("zsb_max_additional_samples_count_nest", function(cvar, oldvalue, newvalue)
	GAMEMODE.LowPlayerCountSamplesMaxAdditionalCountNest = tonumber(newvalue) or 10
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

-- Normal time between nest spawns.
GM.BaseNestSpawnTime = 45

-- Time removed from nest spawn delay every time one is spawned.
GM.NestSpawnTimeReduction = 5

-- Minimum possible spawn time between nest spawns.
GM.MinNestSpawnTime = 20

-- Samples a research terminal can take before the active terminal changes.
GM.SamplesBeforeChangeTerminal = 40

-- How many clips of ammo guns from the menu start with. The default clip is given as larger of the weapon's clip multiplied by this or 40.
GM.SurvivalClips = 3

-- How much the price of an item is discounted in classic (deathmatch) mode. 0.75 means a 30% discount.
GM.ClassicModeDiscountMultiplier = 0.7

GM.PreviousRoundmodeDir = "zsbw"
GM.PreviousRoundmodeFile = "previous_round_mode.dat"

-- End of round music
GM.SuddenDeathSound = Sound("music/bandit/lasthuman.ogg")
GM.AllLoseSound = Sound("music/bandit/music_lose.ogg")
GM.HumanWinSound = Sound("music/bandit/music_humanwin_vrts.ogg")
GM.BanditWinSound = Sound("music/bandit/music_banditwin_vrts_2.ogg")
-- Sound played to a person when they die as a human.
GM.DeathSound = Sound("music/stingers/HL1_stinger_song28.mp3")
