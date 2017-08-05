GM.ZombieEscapeWeapons = {
	"weapon_zs_zedeagle",
	"weapon_zs_zeakbar",
	"weapon_zs_zesweeper",
	"weapon_zs_zesmg",
	"weapon_zs_zestubber",
	"weapon_zs_zebulletstorm"
}

-- Change this if you plan to alter the cost of items or you severely change how Worth works.
-- Having separate cart files allows people to have separate loadouts for different servers.
GM.CartFile = "zsbanditcarts.txt"

ITEMCAT_GUNS = 1
ITEMCAT_AMMO = 2
ITEMCAT_MELEE = 3
ITEMCAT_TOOLS = 4
ITEMCAT_OTHER = 5
ITEMCAT_TRAITS = 6
ITEMCAT_RETURNS = 7


GM.ItemCategories = {
	[ITEMCAT_GUNS] = "총기",
	[ITEMCAT_AMMO] = "탄약",
	[ITEMCAT_MELEE] = "근접 무기",
	[ITEMCAT_TOOLS] = "도구",
	[ITEMCAT_OTHER] = "기타",
	[ITEMCAT_TRAITS] = "특성",
	[ITEMCAT_RETURNS] = "환불",	

}

--[[
Humans select what weapons (or other things) they want to start with and can even save favorites. Each object has a number of 'Worth' points.
Signature is a unique signature to give in case the item is renamed or reordered. Don't use a number or a string number!
A human can only use 100 points (default) when they join. Redeeming or joining late starts you out with a random loadout from above.
SWEP is a swep given when the player spawns with that perk chosen.
Callback is a function called. Model is a display model. If model isn't defined then the SWEP model will try to be used.
swep, callback, and model can all be nil or empty
]]
GM.Items = {}
function GM:AddItem(tier, signature, name, desc, category, worth, swep, callback, model )
	local tab = { Tier = tier, Signature = signature, Name = name, Description = desc, Category = category, Worth = worth or 0, SWEP = swep, Callback = callback, Model = model}
	self.Items[#self.Items + 1] = tab

	return tab
end

function GM:AddPointShopItem(tier, signature, name, desc, category, points, worth, callback, model)
	return self:AddItem(tier, "ps_"..signature, name, desc, category, points, worth, callback, model)
end

-- Weapons are registered after the gamemode.
timer.Simple(0, function()
	for _, tab in pairs(GAMEMODE.Items) do
		if not tab.Description and tab.SWEP then
			local sweptab = weapons.GetStored(tab.SWEP)
			if sweptab then
				tab.Description = sweptab.Description
			end
		end
	end
end)

-- How much ammo is considered one 'clip' of ammo? For use with setting up weapon defaults. Works directly with zs_survivalclips
GM.AmmoCache = {}
GM.AmmoCache["ar2"] = 30 -- Assault rifles.
GM.AmmoCache["alyxgun"] = 24 -- Not used.
GM.AmmoCache["pistol"] = 12 -- Pistols.
GM.AmmoCache["smg1"] = 30 -- SMG's and some rifles.
GM.AmmoCache["357"] = 6 -- Rifles, especially of the sniper variety.
GM.AmmoCache["xbowbolt"] = 2 -- Crossbows
GM.AmmoCache["buckshot"] = 8 -- Shotguns
GM.AmmoCache["ar2altfire"] = 1 -- Smokes.
GM.AmmoCache["slam"] = 1 -- Force Field Emitters.
GM.AmmoCache["rpg_round"] = 1 -- Fbangs
GM.AmmoCache["smg1_grenade"] = 1 -- .
GM.AmmoCache["sniperround"] = 1 -- Barricade Kit
GM.AmmoCache["sniperpenetratedround"] = 1 -- Remote Det pack.
GM.AmmoCache["grenade"] = 1 -- Grenades.
GM.AmmoCache["thumper"] = 1 -- Gun turret.
GM.AmmoCache["gravity"] = 1 -- EMP Charge.
GM.AmmoCache["battery"] = 30 -- Used with the Medical Kit.
GM.AmmoCache["gaussenergy"] = 1 -- Nails used with the Carpenter's Hammer.
GM.AmmoCache["combinecannon"] = 1 -- .
GM.AmmoCache["airboatgun"] = 1 -- Arsenal crates.
GM.AmmoCache["striderminigun"] = 1 -- Message beacons.
GM.AmmoCache["helicoptergun"] = 1 --Resupply boxes.
GM.AmmoCache["spotlamp"] = 1
GM.AmmoCache["manhack"] = 1
GM.AmmoCache["pulse"] = 30

-- These ammo types are available at ammunition boxes.
-- The amount is the ammo to give them.
-- If the player isn't holding a weapon that uses one of these then they will get smg1 ammo.
GM.AmmoResupply = {}
GM.AmmoResupply["ar2"] = 20
GM.AmmoResupply["alyxgun"] = GM.AmmoCache["alyxgun"]
GM.AmmoResupply["pistol"] = GM.AmmoCache["pistol"]
GM.AmmoResupply["smg1"] = 20
GM.AmmoResupply["357"] = GM.AmmoCache["357"]
GM.AmmoResupply["xbowbolt"] = GM.AmmoCache["xbowbolt"]
GM.AmmoResupply["buckshot"] = GM.AmmoCache["buckshot"]
GM.AmmoResupply["battery"] = 30
GM.AmmoResupply["pulse"] = GM.AmmoCache["pulse"]
GM.AmmoResupply["gravity"] = 1 -- EMP Charge.
GM.AmmoResupply["gaussenergy"] = 1 -- Nails used with the Carpenter's Hammer.
GM.AmmoResupply["sniperround"] = 1
GM.AmmoResupply["grenlauncher"] = 1
-----------
-- Worth --
-----------

--[[GM:AddStartingItem("pshtr", "'피슈터' 권총", nil, ITEMCAT_GUNS, 40, "weapon_zs_peashooter")
GM:AddStartingItem("btlax", "'배틀액스' 권총", nil, ITEMCAT_GUNS, 40, "weapon_zs_battleaxe")
GM:AddStartingItem("owens", "'오웬스' 권총", nil, ITEMCAT_GUNS, 40, "weapon_zs_owens")
GM:AddStartingItem("blstr", "'블래스터' 산탄총", nil, ITEMCAT_GUNS, 55, "weapon_zs_blaster")
GM:AddStartingItem("tossr", "'토저' SMG", nil, ITEMCAT_GUNS, 50, "weapon_zs_tosser")
GM:AddStartingItem("stbbr", "'스터버' 소총", nil, ITEMCAT_GUNS, 55, "weapon_zs_stubber")
GM:AddStartingItem("crklr", "'크래클러' 돌격 소총", nil, ITEMCAT_GUNS, 50, "weapon_zs_crackler")
GM:AddStartingItem("z9000", "'Z9000' 펄스 권총", nil, ITEMCAT_GUNS, 50, "weapon_zs_z9000")

GM:AddStartingItem("2pcp", "권총 탄약 x36", nil, ITEMCAT_AMMO, 15, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["pistol"] or 12) * 3, "pistol", true) end, "models/Items/BoxSRounds.mdl")
GM:AddStartingItem("2sgcp", "산탄총 탄약 x24", nil, ITEMCAT_AMMO, 15, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["buckshot"] or 8) * 3, "buckshot", true) end, "models/Items/BoxBuckshot.mdl")
GM:AddStartingItem("2smgcp", "SMG 탄약 x90", nil, ITEMCAT_AMMO, 15, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["smg1"] or 30) * 3, "smg1", true) end, "models/Items/BoxMRounds.mdl")
GM:AddStartingItem("2arcp", "돌격소총 탄약 x90", nil, ITEMCAT_AMMO, 15, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["ar2"] or 30) * 3, "ar2", true) end, "models/Items/357ammobox.mdl")
GM:AddStartingItem("2rcp", "소총 탄약 x18", nil, ITEMCAT_AMMO, 15, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["357"] or 6) * 3, "357", true) end, "models/Items/BoxSniperRounds.mdl")
GM:AddStartingItem("2pls", "펄스탄 x90", nil, ITEMCAT_AMMO, 15, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["pulse"] or 30) * 3, "pulse", true) end, "models/Items/combine_rifle_ammo01.mdl")
GM:AddStartingItem("3pcp", "권총 탄약 x60", nil, ITEMCAT_AMMO, 20, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["pistol"] or 12) * 5, "pistol", true) end, "models/Items/BoxSRounds.mdl")
GM:AddStartingItem("3sgcp", "산탄총 탄약 x40", nil, ITEMCAT_AMMO, 20, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["buckshot"] or 8) * 5, "buckshot", true) end, "models/Items/BoxBuckshot.mdl")
GM:AddStartingItem("3smgcp", "SMG 탄약 x150", nil, ITEMCAT_AMMO, 20, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["smg1"] or 30) * 5, "smg1", true) end, "models/Items/BoxMRounds.mdl")
GM:AddStartingItem("3arcp", "돌격소총 탄약 x150", nil, ITEMCAT_AMMO, 20, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["ar2"] or 30) * 5, "ar2", true) end, "models/Items/357ammobox.mdl")
GM:AddStartingItem("3rcp", "소총 탄약 x30", nil, ITEMCAT_AMMO, 20, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["357"] or 6) * 5, "357", true) end, "models/Items/BoxSniperRounds.mdl")
GM:AddStartingItem("3pls", "펄스탄 x150", nil, ITEMCAT_AMMO, 20, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["pulse"] or 30) * 5, "pulse", true) end, "models/Items/combine_rifle_ammo01.mdl")

GM:AddStartingItem("zpaxe", "도끼", nil, ITEMCAT_MELEE, 30, "weapon_zs_axe")
GM:AddStartingItem("crwbar", "빠루", nil, ITEMCAT_MELEE, 30, "weapon_zs_crowbar")
GM:AddStartingItem("stnbtn", "전기충격기", nil, ITEMCAT_MELEE, 45, "weapon_zs_stunbaton")
GM:AddStartingItem("csknf", "칼", nil, ITEMCAT_MELEE, 10, "weapon_zs_swissarmyknife")
GM:AddStartingItem("zpplnk", "판자", nil, ITEMCAT_MELEE, 10, "weapon_zs_plank")
GM:AddStartingItem("zpfryp", "후라이팬", nil, ITEMCAT_MELEE, 20, "weapon_zs_fryingpan")
GM:AddStartingItem("zpcpot", "냄비", nil, ITEMCAT_MELEE, 25, "weapon_zs_pot")
GM:AddStartingItem("pipe", "납 파이프", nil, ITEMCAT_MELEE, 45, "weapon_zs_pipe")
GM:AddStartingItem("hook", "갈고리", nil, ITEMCAT_MELEE, 30, "weapon_zs_hook")

GM:AddStartingItem("tracker", "송신기 추적장치", nil, ITEMCAT_TOOLS, 5, "weapon_zs_objectiveradar")
GM:AddStartingItem("medkit", "메디킷", nil, ITEMCAT_TOOLS, 50, "weapon_zs_medicalkit")
GM:AddStartingItem("150mkit", "150 메디컬 에너지", nil, ITEMCAT_TOOLS, 30, nil, function(pl) pl:GiveAmmo(150, "Battery", true) end, "models/healthvial.mdl")
--GM:AddStartingItem("arscrate", "상점 상자", nil, ITEMCAT_TOOLS, 50, "weapon_zs_arsenalcrate").Countables = "prop_arsenalcrate"
GM:AddStartingItem("resupplybox", "보급 상자", nil, ITEMCAT_TOOLS, 50, "weapon_zs_resupplybox").Countables = "prop_resupplybox"
local item = GM:AddStartingItem("infturret", "자동 터렛", nil, ITEMCAT_TOOLS, 75, nil, function(pl)
	pl:GiveEmptyWeapon("weapon_zs_gunturret")
	pl:GiveAmmo(1, "thumper")
	pl:GiveAmmo(250, "smg1")
end)
item.Countables = {"weapon_zs_gunturret", "prop_gunturret"}

--local item = GM:AddStartingItem("manhack", "Manhack", nil, ITEMCAT_TOOLS, 60, "weapon_zs_manhack")
--item.Countables = "prop_manhack"
GM:AddStartingItem("wrench", "메카닉의 렌치", nil, ITEMCAT_TOOLS, 15, "weapon_zs_wrench").NoClassicMode = true
GM:AddStartingItem("crphmr", "목수의 망치", nil, ITEMCAT_TOOLS, 45, "weapon_zs_hammer").NoClassicMode = true
GM:AddStartingItem("6nails", "못 (12개입)", "바리케이드를 설치하기 쉽게 돕는 못 12개이다.", ITEMCAT_TOOLS, 25, nil, function(pl) pl:GiveAmmo(12, "GaussEnergy", true) end, "models/Items/BoxMRounds.mdl")
GM:AddStartingItem("junkpack", "판자 묶음", nil, ITEMCAT_TOOLS, 40, "weapon_zs_boardpack")
--GM:AddStartingItem("spotlamp", "스팟램프", nil, ITEMCAT_TOOLS, 25, "weapon_zs_spotlamp").Countables = "prop_spotlamp"
--GM:AddStartingItem("msgbeacon", "Message Beacon", nil, ITEMCAT_TOOLS, 10, "weapon_zs_messagebeacon").Countables = "prop_messagebeacon"
--GM:AddStartingItem("ffemitter", "방어막 생성기", nil, ITEMCAT_TOOLS, 50, "weapon_zs_ffemitter").Countables = "prop_ffemitter"


GM:AddStartingItem("stone", "돌", nil, ITEMCAT_OTHER, 5, "weapon_zs_stone")
GM:AddStartingItem("grenade", "수류탄", nil, ITEMCAT_OTHER, 30, "weapon_zs_grenade")
GM:AddStartingItem("flashbang", "섬광탄", "폭발 시 거리 128 내의 플레이어는 눈이 잠시 멀며 25% 확률로 1초간 넉다운된다.", ITEMCAT_OTHER, 35, "weapon_zs_flashbang")
GM:AddStartingItem("oxtank", "산소탱크",nil, ITEMCAT_OTHER, 15, "weapon_zs_oxygentank")
--GM:AddStartingItem("respawn", "정수", "소지한 정수 하나 당 리스폰을 한 번 할 수 있다.", ITEMCAT_OTHER, 25, nil, function(pl) pl:GiveAmmo((GAMEMODE.AmmoCache["gravity"] or 1), "gravity", true) end, "models/gibs/HGIBS.mdl")

GM:AddStartingItem("10hp", "맷집", "최대 체력을 10 증가시킨다.", ITEMCAT_TRAITS, 10, nil, function(pl) if SERVER then pl:SetMaxHealth(pl:GetMaxHealth() + 10) pl:SetHealth(pl:GetMaxHealth()) end end, "models/healthvial.mdl")
GM:AddStartingItem("25hp", "체력증강제", "최대 체력을 25 증가시킨다.", ITEMCAT_TRAITS, 20, nil, function(pl) if SERVER then pl:SetMaxHealth(pl:GetMaxHealth() + 25) pl:SetHealth(pl:GetMaxHealth()) end end, "models/items/healthkit.mdl")
GM:AddStartingItem("5spd", "체대 출신", "이동 속도를 약간 증가시킨다.", ITEMCAT_TRAITS, 10, nil, function(pl) pl.HumanSpeedAdder = (pl.HumanSpeedAdder or 0) + 7 pl:ResetSpeed() end, "models/props_lab/jar01a.mdl")
GM:AddStartingItem("10spd", "육상선수", "이동 속도를 증가시킨다.", ITEMCAT_TRAITS, 15, nil, function(pl) pl.HumanSpeedAdder = (pl.HumanSpeedAdder or 0) + 14 pl:ResetSpeed() end, "models/props_lab/jar01a.mdl")
GM:AddStartingItem("bfhandy", "공돌이", "수리 시 수리량을 25% 증가시킨다.", ITEMCAT_TRAITS, 25, nil, function(pl) pl.HumanRepairMultiplier = (pl.HumanRepairMultiplier or 1) + 0.25 end, "models/props_c17/tools_wrench01a.mdl")
GM:AddStartingItem("bfsurgeon", "의대 출신", "자신이 소유하는 의료기기를 강화시킨다.", ITEMCAT_TRAITS, 25, nil, function(pl) pl.HumanHealMultiplier = (pl.HumanHealMultiplier or 1) + 0.3 end, "models/healthvial.mdl")
GM:AddStartingItem("bfresist", "항체", "독 데미지가 더욱 빨리 회복된다.", ITEMCAT_TRAITS, 20, nil, function(pl) pl.BuffResistant = true end, "models/healthvial.mdl")
GM:AddStartingItem("bfregen", "리제네레이터", "체력이 4초에 1씩 회복된다.", ITEMCAT_TRAITS, 25, nil, function(pl) pl.BuffRegenerative = true end, "models/healthvial.mdl")
GM:AddStartingItem("bfmusc", "근육돼지", "무거운 물체도 들어 나를 수 있으며, 20%의 추가 피해를 근접무기로 입힌다.", ITEMCAT_TRAITS, 25, nil, function(pl) pl.BuffMuscular = true if SERVER then pl:DoMuscularBones() end end, "models/props_c17/FurnitureCouch001a.mdl")
GM:AddStartingItem("bfcannibal", "식인종", "바닥에 떨어진 살점을 먹어 체력을 회복할 수 있다.", ITEMCAT_TRAITS, 40, nil, function(pl) pl.Cannibalistic = true end, "models/props_lab/cleaver.mdl")

GM:AddStartingItem("dbfweak", "약골", "최대 체력이 30 줄어든다.", ITEMCAT_RETURNS, -20, nil, function(pl) if SERVER then pl:SetMaxHealth(math.max(1, pl:GetMaxHealth() - 30)) pl:SetHealth(pl:GetMaxHealth()) end pl.IsWeak = true end, "models/gibs/HGIBS.mdl")
GM:AddStartingItem("dbfslow", "느림보", "최대 속도가 줄어든다.", ITEMCAT_RETURNS, -15, nil, function(pl) pl.HumanSpeedAdder = (pl.HumanSpeedAdder or 0) - 20 pl:ResetSpeed() pl.IsSlow = true end, "models/gibs/HGIBS.mdl")
GM:AddStartingItem("dbfpalsy", "수전증", "정확히 조준할 수 없게 된다.", ITEMCAT_RETURNS, -10, nil, function(pl) if SERVER then pl:SetPalsy(true) end end, "models/gibs/HGIBS.mdl")
GM:AddStartingItem("dbfhemo", "헤모필리아", "다칠 경우 출혈로 데미지를 더 입는다.", ITEMCAT_RETURNS, -20, nil, function(pl) if SERVER then pl:SetHemophilia(true) end end, "models/gibs/HGIBS.mdl")
GM:AddStartingItem("dbfunluc", "거지", "상점 상자에서 아무것도 구매할 수 없다.", ITEMCAT_RETURNS, -100, nil, function(pl) if SERVER then pl:SetUnlucky(true) end end, "models/gibs/HGIBS.mdl")
GM:AddStartingItem("dbfclumsy", "골다공증", "매우 쉽게 넉다운된다.", ITEMCAT_RETURNS, -30, nil, function(pl) pl.Clumsy = true end, "models/gibs/HGIBS.mdl")
GM:AddStartingItem("dbfnoghosting", "뚱땡이", "바리케이드를 통과해 지나갈 수 없다.", ITEMCAT_RETURNS, -20, nil, function(pl) pl.NoGhosting = true end, "models/gibs/HGIBS.mdl").NoClassicMode = true
GM:AddStartingItem("dbfnopickup", "팔 장애", "물체를 들 수 없다.", ITEMCAT_RETURNS, -15, nil, function(pl) pl.NoObjectPickup = true if SERVER then pl:DoNoodleArmBones() end end, "models/gibs/HGIBS.mdl")
]]
------------
-- Points --
------------
--GM:AddPointShopItem("btlax", "'배틀액스' 권총", nil, ITEMCAT_GUNS, 0, "weapon_zs_battleaxe")
--GM:AddPointShopItem(0,"pshtr", "'피슈터' 권총", nil, ITEMCAT_GUNS, 15, "weapon_zs_peashooter")
GM:AddPointShopItem(0,"owens", "'오웬스' 권총", nil, ITEMCAT_GUNS, 15, "weapon_zs_owens")
GM:AddPointShopItem(0,"blstr", "'블래스터' 산탄총", nil, ITEMCAT_GUNS, 15, "weapon_zs_blaster")
GM:AddPointShopItem(0,"tossr", "'토저' SMG", nil, ITEMCAT_GUNS, 15, "weapon_zs_tosser")
GM:AddPointShopItem(0,"stbbr", "'스터버' 소총", nil, ITEMCAT_GUNS, 15, "weapon_zs_stubber")
GM:AddPointShopItem(0,"crklr", "'크래클러' 돌격 소총", nil, ITEMCAT_GUNS, 15, "weapon_zs_crackler")
GM:AddPointShopItem(0,"z9000", "'Z9000' 펄스 권총", nil, ITEMCAT_GUNS, 15, "weapon_zs_z9000")
GM:AddPointShopItem(0,"deagle", "'좀비 드릴' 데저트 이글", nil, ITEMCAT_GUNS, 15, "weapon_zs_deagle")

GM:AddPointShopItem(1,"glock3", "'크로스파이어' 글록-3", nil, ITEMCAT_GUNS, 60, "weapon_zs_glock3")
GM:AddPointShopItem(1,"magnum", "'리코세' 매그넘", nil, ITEMCAT_GUNS, 65, "weapon_zs_magnum")
GM:AddPointShopItem(1,"eraser", "'이레이저' 전략 권총", nil, ITEMCAT_GUNS, 60, "weapon_zs_eraser")
GM:AddPointShopItem(1,"shredder", "'슈레더' SMG", nil, ITEMCAT_GUNS, 60, "weapon_zs_smg")
GM:AddPointShopItem(1,"akbar", "'아크바' 돌격소총", nil, ITEMCAT_GUNS, 65, "weapon_zs_akbar")
GM:AddPointShopItem(1,"annabelle", "'애나멜' 소총", nil, ITEMCAT_GUNS, 60, "weapon_zs_annabelle")
GM:AddPointShopItem(1,"neutrino", "'뉴트리노' 펄스 LMG", nil, ITEMCAT_GUNS, 75, "weapon_zs_neutrino")
GM:AddPointShopItem(1,"doublebarrel", "'카우' 더블배럴", nil, ITEMCAT_GUNS, 70, "weapon_zs_doublebarrel")

GM:AddPointShopItem(2,"uzi", "'스프레이어' Uzi 9mm", nil, ITEMCAT_GUNS, 100, "weapon_zs_uzi")
GM:AddPointShopItem(2,"ender", "'엔더' 자동 샷건", nil, ITEMCAT_GUNS, 100, "weapon_zs_ender")
GM:AddPointShopItem(2,"immortal", "'불멸' 권총", nil, ITEMCAT_GUNS, 100, "weapon_zs_immortal")
GM:AddPointShopItem(2,"waraxe", "'워액스' 권총", nil, ITEMCAT_GUNS, 100, "weapon_zs_waraxe")
GM:AddPointShopItem(2,"hunter", "'헌터' 소총", nil, ITEMCAT_GUNS, 100, "weapon_zs_hunter")
GM:AddPointShopItem(2,"stalker", "'스토커' M4", nil, ITEMCAT_GUNS, 100, "weapon_zs_m4")
GM:AddPointShopItem(2,"ioncannon", "이온캐논", nil, ITEMCAT_GUNS, 100, "weapon_zs_ioncannon")

GM:AddPointShopItem(3,"terminator", "'터미네이터' 권총", nil, ITEMCAT_GUNS, 155, "weapon_zs_terminator")
GM:AddPointShopItem(3,"bulletstorm", "'총알비' SMG", nil, ITEMCAT_GUNS, 155, "weapon_zs_bulletstorm")
GM:AddPointShopItem(3,"silencer", "'사일런서' SMG", nil, ITEMCAT_GUNS, 155, "weapon_zs_silencer")
GM:AddPointShopItem(3,"inquisition", "'인퀴지션' 소형 석궁", nil, ITEMCAT_GUNS, 155, "weapon_zs_inquisition")
GM:AddPointShopItem(3,"practition", "'프랙티션' 돌격소총", nil, ITEMCAT_GUNS, 155, "weapon_zs_practition")
GM:AddPointShopItem(3,"inferno", "'인페르노' AUG", nil, ITEMCAT_GUNS, 155, "weapon_zs_inferno")
GM:AddPointShopItem(3,"sweeper", "'스위퍼' 샷건", nil, ITEMCAT_GUNS, 155, "weapon_zs_sweepershotgun")
GM:AddPointShopItem(3,"pulserifle", "'아도니스' 펄스 소총", nil, ITEMCAT_GUNS, 155, "weapon_zs_pulserifle")
GM:AddPointShopItem(3,"zeus", "'제우스' 자동소총", nil, ITEMCAT_GUNS, 155, "weapon_zs_zeus")

GM:AddPointShopItem(4,"reaper", "'리퍼' UMP", nil, ITEMCAT_GUNS, 220, "weapon_zs_reaper")
GM:AddPointShopItem(4,"tommy", "'토미' SMG", nil, ITEMCAT_GUNS, 220, "weapon_zs_tommy")
GM:AddPointShopItem(4,"blitz", "'블리츠' 돌격소총", nil, ITEMCAT_GUNS, 220, "weapon_zs_blitz")
GM:AddPointShopItem(4,"sg550", "'헬베티카' DMR", nil, ITEMCAT_GUNS, 220, "weapon_zs_sg550")
GM:AddPointShopItem(4,"crossbow", "'임펠러' 석궁", nil, ITEMCAT_GUNS, 220, "weapon_zs_crossbow")
GM:AddPointShopItem(4,"boomstick", "붐스틱", nil, ITEMCAT_GUNS, 220, "weapon_zs_boomstick")
GM:AddPointShopItem(4,"slugrifle", "'티니' 슬러그 소총", nil, ITEMCAT_GUNS, 210, "weapon_zs_slugrifle")
GM:AddPointShopItem(4,"positron", "'포지트론' 입자포", nil, ITEMCAT_GUNS, 245, "weapon_zs_positron")

GM:AddPointShopItem(nil,"pistolammo", "권총 탄약", nil, ITEMCAT_AMMO, 3, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoCache["pistol"] or 12, "pistol", true) end, "models/Items/BoxSRounds.mdl")
GM:AddPointShopItem(nil,"shotgunammo", "샷건 탄약", nil, ITEMCAT_AMMO, 5, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoCache["buckshot"] or 8, "buckshot", true) end, "models/Items/BoxBuckshot.mdl")
GM:AddPointShopItem(nil,"smgammo", "SMG 탄약", nil, ITEMCAT_AMMO, 4, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoCache["smg1"] or 30, "smg1", true) end, "models/Items/BoxMRounds.mdl")
GM:AddPointShopItem(nil,"assaultrifleammo", "돌격소총 탄약", nil, ITEMCAT_AMMO, 5, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoCache["ar2"] or 30, "ar2", true) end, "models/Items/357ammobox.mdl")
GM:AddPointShopItem(nil,"rifleammo", "소총 탄약", nil, ITEMCAT_AMMO, 5, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoCache["357"] or 10, "357", true) end, "models/Items/BoxSniperRounds.mdl")
GM:AddPointShopItem(nil,"crossbowammo", "크로스보우 화살 묶음", nil, ITEMCAT_AMMO, 5, nil, function(pl) pl:GiveAmmo(5, "XBowBolt", true) end, "models/Items/CrossbowRounds.mdl")
GM:AddPointShopItem(nil,"pulseammo", "펄스건 탄약", nil, ITEMCAT_AMMO, 4, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoCache["pulse"] or 40, "pulse", true) end, "models/Items/combine_rifle_ammo01.mdl")
GM:AddPointShopItem(nil,"medicammo", "메디컬 에너지", nil, ITEMCAT_AMMO, 4, nil, function(pl) pl:GiveAmmo(50, "Battery", true) end, "models/healthvial.mdl")
GM:AddPointShopItem(nil,"empround", "EMP 배터리", "EMP건의 추가 탄환이다.", ITEMCAT_AMMO, 15, nil, function(pl) pl:GiveAmmo(5, "gravity", true) end, "models/items/Battery.mdl").NoClassicMode = true
GM:AddPointShopItem(nil,"nails", "못 2개", nil, ITEMCAT_AMMO, 5, nil, function(pl) pl:GiveAmmo(2, "GaussEnergy", true) end, "models/crossbow_bolt.mdl").NoClassicMode = true

GM:AddPointShopItem(nil,"axe", "도끼", nil, ITEMCAT_MELEE, 25, "weapon_zs_axe")
GM:AddPointShopItem(nil,"crowbar", "빠루", nil, ITEMCAT_MELEE, 27, "weapon_zs_crowbar")
GM:AddPointShopItem(nil,"stunbaton", "전기충격기", nil, ITEMCAT_MELEE, 23, "weapon_zs_stunbaton")
--GM:AddPointShopItem("knife", "칼", nil, ITEMCAT_MELEE, 5, "weapon_zs_swissarmyknife")
GM:AddPointShopItem(nil,"shovel", "삽", nil, ITEMCAT_MELEE, 30, "weapon_zs_shovel")
GM:AddPointShopItem(nil,"sledgehammer", "오함마", nil, ITEMCAT_MELEE, 35, "weapon_zs_sledgehammer")
GM:AddPointShopItem(nil,"zpplnk", "판자", nil, ITEMCAT_MELEE, 10, "weapon_zs_plank")
GM:AddPointShopItem(nil,"zpfryp", "후라이팬", nil, ITEMCAT_MELEE, 17, "weapon_zs_fryingpan")
GM:AddPointShopItem(nil,"zpcpot", "냄비", nil, ITEMCAT_MELEE, 22, "weapon_zs_pot")
GM:AddPointShopItem(nil,"butcher", "정육점 칼", nil, ITEMCAT_MELEE, 25, "weapon_zs_butcherknife")
GM:AddPointShopItem(nil,"pipe", "납 파이프", nil, ITEMCAT_MELEE, 28, "weapon_zs_pipe")
GM:AddPointShopItem(nil,"hook", "갈고리", nil, ITEMCAT_MELEE, 20, "weapon_zs_hook")

GM:AddPointShopItem(nil,"crphmr", "목수의 망치", nil, ITEMCAT_TOOLS, 30, "weapon_zs_hammer").NoClassicMode = true
--GM:AddPointShopItem("arsenalcrate", "상점 상자", nil, ITEMCAT_TOOLS, 45, "weapon_zs_arsenalcrate")
--GM:AddPointShopItem(nil,"resupplybox", "보급 상자", nil, ITEMCAT_TOOLS, 55, "weapon_zs_resupplybox")
GM:AddPointShopItem(nil,"nailgun", "리벳건", nil, ITEMCAT_TOOLS, 65, "weapon_zs_nailgun").NoClassicMode = true
GM:AddPointShopItem(nil,"empgun", "EMP 건", nil, ITEMCAT_TOOLS, 45, "weapon_zs_empgun").NoClassicMode = true
GM:AddPointShopItem(nil,"medgun", "메디컬 건", nil, ITEMCAT_TOOLS, 45, "weapon_zs_medicgun")
GM:AddPointShopItem(nil,"medkit", "메디킷", nil, ITEMCAT_TOOLS, 50, "weapon_zs_medicalkit")
local item = GM:AddPointShopItem(nil,"infturret", "자동 터렛", nil, ITEMCAT_TOOLS, 60, nil, function(pl)
	pl:GiveEmptyWeapon("weapon_zs_gunturret")
	pl:GiveAmmo(1, "thumper")
	--pl:GiveAmmo(250, "smg1")
end)
item.Countables = {"weapon_zs_gunturret", "prop_gunturret"}
item.NoClassicMode = true
GM:AddPointShopItem(nil,"manhack", "맨핵", nil, ITEMCAT_TOOLS, 45, "weapon_zs_manhack").NoClassicMode = true
GM:AddPointShopItem(nil,"drone", "드론", nil, ITEMCAT_TOOLS, 50, "weapon_zs_drone").NoClassicMode = true
GM:AddPointShopItem(nil,"barricadekit", "'이지스' 바리케이드 킷", nil, ITEMCAT_TOOLS, 125, "weapon_zs_barricadekit").NoClassicMode = true
GM:AddPointShopItem(nil,"wrench", "메카닉의 렌치", nil, ITEMCAT_TOOLS, 25, "weapon_zs_wrench").NoClassicMode = true
GM:AddPointShopItem(nil,"ffemitter", "방어막 생성기", nil, ITEMCAT_TOOLS, 60, "weapon_zs_ffemitter").Countables = "prop_ffemitter"
GM:AddPointShopItem(nil,"tracker", "송신기 추적장치", nil, ITEMCAT_TOOLS, 5, "weapon_zs_objectiveradar").NoClassicMode = true
GM:AddPointShopItem(nil,"boardpack", "판자 2장", nil, ITEMCAT_TOOLS, 15, "weapon_zs_boardpack").NoClassicMode = true

GM:AddPointShopItem(nil,"backdoor", "통신 백도어 장치", nil, ITEMCAT_OTHER, 35, "weapon_zs_backdoor").NoClassicMode = true
GM:AddPointShopItem(nil,"grenade", "수류탄", nil, ITEMCAT_OTHER, 20, "weapon_zs_grenade")
GM:AddPointShopItem(nil,"extrahp", "추가 방탄복", nil, ITEMCAT_OTHER, 45, "weapon_zs_extrahealth")
GM:AddPointShopItem(nil,"flashbang", "섬광탄", nil, ITEMCAT_OTHER, 15, "weapon_zs_flashbang")
GM:AddPointShopItem(nil,"smoke", "연막탄", nil, ITEMCAT_OTHER, 10, "weapon_zs_smokegrenade")
GM:AddPointShopItem(nil,"detpck", "C4", nil, ITEMCAT_OTHER, 40, "weapon_zs_detpack")
GM:AddPointShopItem(nil,"grenadelauncher", "유탄발사기", nil, ITEMCAT_OTHER, 115, "weapon_zs_grenadelauncher")
GM:AddPointShopItem(nil,"glgrenade", "유탄", nil, ITEMCAT_OTHER, 30, nil, function(pl) pl:GiveAmmo(1, "grenlauncher", true) end, "models/items/ar2_grenade.mdl")

-- These are the honorable mentions that come at the end of the round.

local function genericcallback(pl, magnitude) return pl:Name(), magnitude end
GM.HonorableMentions = {}
GM.HonorableMentions[HM_MOSTENEMYKILLED] = {Name = "살인마", String = "%s. %d명의 적을 죽였다.", Callback = genericcallback}
GM.HonorableMentions[HM_MOSTDAMAGETOENEMY] = {Name = "전쟁광", String = "%s. 전체 %d 대미지를 적에게 주었다.", Callback = genericcallback}
GM.HonorableMentions[HM_PACIFIST] = {Name = "비폭력주의자", String = "%s는 한 명의 적도 죽이지 않았다.", Callback = genericcallback}
GM.HonorableMentions[HM_MOSTHELPFUL] = {Name = "조력자", String = "%s는 동료가 %d명의 적을 죽일 수 있도록 도왔다.", Callback = genericcallback}
GM.HonorableMentions[HM_LASTHUMAN] = {Name = "Last-Stand", String = "%s가 최후의 생존자이다.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_OUTLANDER] = {Name = "도망자", String = "%s는 좀비 스폰 지점에서 %d피트나 떨어진 장소에서 살해당했다.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_GOODDOCTOR] = {Name = "의사양반", String = "%s는 팀의 체력을 %d만큼 책임졌다.", Callback = genericcallback}
GM.HonorableMentions[HM_HANDYMAN] = {Name = "공학자", String = "%s는 %d만큼 바리케이드를 수리했다.", Callback = genericcallback}
GM.HonorableMentions[HM_SCARECROW] = {Name = "죄 없는 까마귀", String = "플레이어 %s님이 까마귀 %d마리를 무참히 살해했다.", Callback = genericcallback, Color = COLOR_WHITE}
GM.HonorableMentions[HM_MOSTBRAINSEATEN] = {Name = "인간 학살자", String = "BJ %s님의 인간 뇌 먹방! 오늘은 %d명의 뇌를 먹어치워보겠습니다!", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_MOSTDAMAGETOHUMANS] = {Name = "너 나한테 시비 걸었냐?", String = "플레이어 %s님이 시비를 거는 인간들에게 %d 데미지로 응징했다.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_LASTBITE] = {Name = "심판자", String = "플레이어 %s님이 최후의 인간을 먹어치웠다.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_USEFULTOOPPOSITE] = {Name = "자살특공대", String = "%s는 적에게 %d번 죽었다.", Callback = genericcallback}
GM.HonorableMentions[HM_STUPID] = {Name = "똥멍청이", String = "플레이어 %s님은 좀비 스폰 지점에서 겨우 %d피트 떨어진 곳에서 살해당했다.", Callback = genericcallback, Color = COLOR_RED}
GM.HonorableMentions[HM_SALESMAN] = {Name = "세일즈맨", String = "%s는 장사를 통해 %d포인트를 벌었다.", Callback = genericcallback}
GM.HonorableMentions[HM_WAREHOUSE] = {Name = "창고장", String = "%s는 자신의 보급 상자로 %d번 동료를 도왔다.", Callback = genericcallback}
GM.HonorableMentions[HM_SPAWNPOINT] = {Name = "살아있는 스폰지점", String = "플레이어 %s님이 %d마리의 좀비를 부활시켰다.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_CROWFIGHTER] = {Name = "King of Crows", String = "플레이어 %s님이 %d마리의 까마귀를 전멸시켰다.", Callback = genericcallback, Color = COLOR_WHITE}
GM.HonorableMentions[HM_CROWBARRICADEDAMAGE] = {Name = "쥐꼬리만한 골칫거리", String = "플레이어 %s님이 까마귀로 바리케이드에 총합 %d 데미지를 가했다.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_BARRICADEDESTROYER] = {Name = "철거단원", String = "%s는 적의 바리케이드에 %d의 대미지를 주었다.", Callback = genericcallback}
GM.HonorableMentions[HM_NESTDESTROYER] = {Name = "네스트 디스트로이어", String = "플레이어 %s님이 %d개의 둥지를 흔적도 없이 날려버렸다.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_NESTMASTER] = {Name = "네스트 마스터", String = "플레이어 %s님이 %d마리의 좀비를 자신의 둥지에서 부활시켰다.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_COMMSUNIT] = {Name = "통신사 직원", String = "%s 는 %d개의 송신기를 탈환했다.", Callback = genericcallback}


-- Don't let humans use these models because they look like undead models. Must be lower case.
GM.RestrictedModels = {
	"models/player/zombie_classic.mdl",
	"models/player/zombine.mdl",
	"models/player/zombie_soldier.mdl",
	"models/player/zombie_fast.mdl",
	"models/player/corpse1.mdl",
	"models/player/charple.mdl",
	"models/player/skeleton.mdl"
}
GM.ForceClassicMaps = {
	"cs_newyork"
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
	tab.DefaultClip = math.ceil(tab.ClipSize * self.SurvivalClips * (tab.ClipMultiplier or 1))
end

GM.MaxSigils = CreateConVar("zs_maxsigils", "3", FCVAR_ARCHIVE + FCVAR_NOTIFY, "How many sigils to spawn. 0 for none."):GetInt()
cvars.AddChangeCallback("zs_maxsigils", function(cvar, oldvalue, newvalue)
	GAMEMODE.MaxSigils = math.Clamp(tonumber(newvalue) or 0, 0, 10)
end)

GM.DefaultRedeem = CreateConVar("zs_redeem", "4", FCVAR_REPLICATED + FCVAR_ARCHIVE + FCVAR_NOTIFY, "The amount of kills a zombie needs to do in order to redeem. Set to 0 to disable."):GetInt()
cvars.AddChangeCallback("zs_redeem", function(cvar, oldvalue, newvalue)
	GAMEMODE.DefaultRedeem = math.max(0, tonumber(newvalue) or 0)
end)

GM.WaveOneZombies = math.ceil(100 * CreateConVar("zs_waveonezombies", "0.1", FCVAR_REPLICATED + FCVAR_ARCHIVE + FCVAR_NOTIFY, "The percentage of players that will start as zombies when the game begins."):GetFloat()) * 0.01
cvars.AddChangeCallback("zs_waveonezombies", function(cvar, oldvalue, newvalue)
	GAMEMODE.WaveOneZombies = math.ceil(100 * (tonumber(newvalue) or 1)) * 0.01
end)

GM.NumberOfWaves = CreateConVar("zs_numberofwaves", "9", FCVAR_REPLICATED + FCVAR_ARCHIVE + FCVAR_NOTIFY, "Number of waves in a game."):GetInt()
cvars.AddChangeCallback("zs_numberofwaves", function(cvar, oldvalue, newvalue)
	GAMEMODE.NumberOfWaves = tonumber(newvalue) or 1
end)

-- Game feeling too easy? Just change these values!
GM.ZombieSpeedMultiplier = math.ceil(100 * CreateConVar("zs_zombiespeedmultiplier", "1", FCVAR_REPLICATED + FCVAR_ARCHIVE + FCVAR_NOTIFY, "Zombie running speed will be scaled by this value."):GetFloat()) * 0.01
cvars.AddChangeCallback("zs_zombiespeedmultiplier", function(cvar, oldvalue, newvalue)
	GAMEMODE.ZombieSpeedMultiplier = math.ceil(100 * (tonumber(newvalue) or 1)) * 0.01
end)

-- This is a resistance, not for claw damage. 0.5 will make zombies take half damage, 0.25 makes them take 1/4, etc.
GM.ZombieDamageMultiplier = math.ceil(100 * CreateConVar("zs_zombiedamagemultiplier", "1", FCVAR_REPLICATED + FCVAR_ARCHIVE + FCVAR_NOTIFY, "Scales the amount of damage that zombies take. Use higher values for easy zombies, lower for harder."):GetFloat()) * 0.01
cvars.AddChangeCallback("zs_zombiedamagemultiplier", function(cvar, oldvalue, newvalue)
	GAMEMODE.ZombieDamageMultiplier = math.ceil(100 * (tonumber(newvalue) or 1)) * 0.01
end)

GM.TimeLimit = CreateConVar("zs_timelimit", "15", FCVAR_ARCHIVE + FCVAR_NOTIFY, "Time in minutes before the game will change maps. It will not change maps if a round is currently in progress but after the current round ends. -1 means never switch maps. 0 means always switch maps."):GetInt() * 60
cvars.AddChangeCallback("zs_timelimit", function(cvar, oldvalue, newvalue)
	GAMEMODE.TimeLimit = tonumber(newvalue) or 15
	if GAMEMODE.TimeLimit ~= -1 then
		GAMEMODE.TimeLimit = GAMEMODE.TimeLimit * 60
	end
end)

GM.RoundLimit = CreateConVar("zs_roundlimit", "3", FCVAR_ARCHIVE + FCVAR_NOTIFY, "How many times the game can be played on the same map. -1 means infinite or only use time limit. 0 means once."):GetInt()
cvars.AddChangeCallback("zs_roundlimit", function(cvar, oldvalue, newvalue)
	GAMEMODE.RoundLimit = tonumber(newvalue) or 3
end)

-- Static values that don't need convars...

-- Initial length for wave 1.
GM.WaveOneLength = 600

-- For Classic Mode
GM.WaveOneLengthClassic = 120

-- Add this many seconds for each additional wave.
GM.TimeLostPerWave = 0

-- For Classic Mode
GM.TimeAddedPerWaveClassic = 10

-- New players are put on the zombie team if the current wave is this or higher. Do not put it lower than 1 or you'll break the game.
GM.NoNewHumansWave = 2

-- Humans can not commit suicide if the current wave is this or lower.
GM.NoSuicideWave = 0

-- How long 'wave 0' should last in seconds. This is the time you should give for new players to join and get ready.
GM.WaveZeroLength = 120

-- Time humans have between waves to do stuff without NEW zombies spawning. Any dead zombies will be in spectator (crow) view and any living ones will still be living.
GM.WaveIntermissionLength = 60

-- For Classic Mode
GM.WaveIntermissionLengthClassic = 20

-- Time in seconds between end round and next map.
GM.EndGameTime = 20

-- How many clips of ammo guns from the Worth menu start with. Some guns such as shotguns and sniper rifles have multipliers on this.
GM.SurvivalClips = 2

-- Put your unoriginal, 5MB Rob Zombie and Metallica music here.
GM.LastHumanSound = Sound("zombiesurvival/lasthuman.ogg")

-- Sound played when humans all die.
GM.AllLoseSound = Sound("zombiesurvival/music_lose.ogg")

-- Sound played when humans survive.
GM.HumanWinSound = Sound("zombiesurvival/music_qethics1.ogg")
GM.BanditWinSound = Sound("zombiesurvival/music_rules.ogg")
-- Sound played to a person when they die as a human.
GM.DeathSound = Sound("music/stingers/HL1_stinger_song28.mp3")
