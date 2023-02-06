GM.ItemCategoryIcons = {
	[ITEMCAT_GUNS] = "icon16/gun.png",
	[ITEMCAT_MELEE] = "icon16/wrench.png",
	[ITEMCAT_TOOLS] = "icon16/cog.png",
	[ITEMCAT_CONS] = "icon16/bomb.png"
	--[ITEMCAT_RETURNS] = "icon16/user_delete.png",
}

GM.LifeStatsLifeTime = 5
GM.HitMarkerLifeTime = 0.3
GM.CrosshairColor = Color(CreateClientConVar("zsb_crosshair_colr", "255", true, false):GetInt(), CreateClientConVar("zsb_crosshair_colg", "255", true, false):GetInt(), CreateClientConVar("zsb_crosshair_colb", "255", true, false):GetInt(), 220)
GM.CrosshairColor2 = Color(CreateClientConVar("zsb_crosshair_colr2", "220", true, false):GetInt(), CreateClientConVar("zsb_crosshair_colg2", "0", true, false):GetInt(), CreateClientConVar("zsb_crosshair_colb2", "0", true, false):GetInt(), 220)
cvars.AddChangeCallback("zsb_crosshair_colr", function(cvar, oldvalue, newvalue) GAMEMODE.CrosshairColor.r = tonumber(newvalue) or 255 end)
cvars.AddChangeCallback("zsb_crosshair_colg", function(cvar, oldvalue, newvalue) GAMEMODE.CrosshairColor.g = tonumber(newvalue) or 255 end)
cvars.AddChangeCallback("zsb_crosshair_colb", function(cvar, oldvalue, newvalue) GAMEMODE.CrosshairColor.b = tonumber(newvalue) or 255 end)
cvars.AddChangeCallback("zsb_crosshair_colr2", function(cvar, oldvalue, newvalue) GAMEMODE.CrosshairColor2.r = tonumber(newvalue) or 255 end)
cvars.AddChangeCallback("zsb_crosshair_colg2", function(cvar, oldvalue, newvalue) GAMEMODE.CrosshairColor2.g = tonumber(newvalue) or 255 end)
cvars.AddChangeCallback("zsb_crosshair_colb2", function(cvar, oldvalue, newvalue) GAMEMODE.CrosshairColor2.b = tonumber(newvalue) or 255 end)

GM.FilmMode = CreateClientConVar("zsb_filmmode", "0", true, false):GetBool()
cvars.AddChangeCallback("zsb_filmmode", function(cvar, oldvalue, newvalue)
	GAMEMODE.FilmMode = tonumber(newvalue) == 1

	GAMEMODE:EvaluateFilmMode()
end)

CreateClientConVar("zsb_autoselectteam", "0", true, true)

GM.BeatsVolume = math.Clamp(CreateClientConVar("zsb_beatsvolume", 80, true, false):GetInt(), 0, 100) / 100
cvars.AddChangeCallback("zsb_beatsvolume", function(cvar, oldvalue, newvalue)
	GAMEMODE.BeatsVolume = math.Clamp(tonumber(newvalue) or 0, 0, 100) / 100
	if (GAMEMODE.BeatsSoundChannel and GAMEMODE.BeatsSoundChannel:IsValid()) then
		GAMEMODE.BeatsSoundChannel:SetVolume(GAMEMODE.BeatsVolume)
	end
end)

GM.AlwaysShowNails = CreateClientConVar("zsb_alwaysshownails", "0", true, false):GetBool()
cvars.AddChangeCallback("zsb_alwaysshownails", function(cvar, oldvalue, newvalue)
	GAMEMODE.AlwaysShowNails = tonumber(newvalue) == 1
end)

GM.ShowIndicators = CreateClientConVar("zsb_teamindicators", "1", true, false):GetBool()
cvars.AddChangeCallback("zsb_teamindicators", function(cvar, oldvalue, newvalue)
	GAMEMODE.ShowIndicators = tonumber(newvalue) == 1
end)

GM.SimpleScoreBoard = CreateClientConVar("zsb_simplescoreboard", "1", true, false):GetBool()
cvars.AddChangeCallback("zsb_simplescoreboard", function(cvar, oldvalue, newvalue)
	GAMEMODE.SimpleScoreBoard = tonumber(newvalue) == 1
end)

GM.KillstreakSounds = CreateClientConVar("zsb_killstreaksounds", "1", true, false):GetBool()
cvars.AddChangeCallback("zsb_killstreaksounds", function(cvar, oldvalue, newvalue)
	GAMEMODE.KillstreakSounds = tonumber(newvalue) == 1
end)

GM.NoCrosshairRotate = CreateClientConVar("zsb_nocrosshairrotate", "0", true, false):GetBool()
cvars.AddChangeCallback("zsb_nocrosshairrotate", function(cvar, oldvalue, newvalue)
	GAMEMODE.NoCrosshairRotate = tonumber(newvalue) == 1
end)

GM.TransparencyRadius = math.Clamp(CreateClientConVar("zsb_transparencyradius", 140, true, false):GetInt(), 0, 512)
cvars.AddChangeCallback("zsb_transparencyradius", function(cvar, oldvalue, newvalue)
	GAMEMODE.TransparencyRadius = math.Clamp(tonumber(newvalue) or 0, 0, 512)
end)

GM.MovementViewRoll = CreateClientConVar("zsb_movementviewroll", "1", true, false):GetBool()
cvars.AddChangeCallback("zsb_movementviewroll", function(cvar, oldvalue, newvalue)
	GAMEMODE.MovementViewRoll = tonumber(newvalue) == 1
end)

GM.WeaponHUDMode = CreateClientConVar("zsb_weaponhudmode", "0", true, false):GetInt()
cvars.AddChangeCallback("zsb_weaponhudmode", function(cvar, oldvalue, newvalue)
	GAMEMODE.WeaponHUDMode = tonumber(newvalue) or 0
end)

GM.DrawPainFlash = CreateClientConVar("zsb_drawpainflash", "1", true, false):GetBool()
cvars.AddChangeCallback("zsb_drawpainflash", function(cvar, oldvalue, newvalue)
	GAMEMODE.DrawPainFlash = tonumber(newvalue) == 1
end)

GM.DontDoRagdollEyes = CreateClientConVar("zsb_ragdolleyes", "1", true, false):GetBool()
cvars.AddChangeCallback("zsb_ragdolleyes", function(cvar, oldvalue, newvalue)
	GAMEMODE.DontDoRagdollEyes = tonumber(newvalue) == 1
end)

GM.UseModelHealthBar = CreateClientConVar("zsb_modelhealthbar", "1", true, false):GetBool()
cvars.AddChangeCallback("zsb_modelhealthbar", function(cvar, oldvalue, newvalue)
	GAMEMODE.UseModelHealthBar = tonumber(newvalue) == 1
end)

CreateConVar( "zsb_preferredsurvivormodel", "", { FCVAR_ARCHIVE, FCVAR_USERINFO }, "Player model to use when on the Survivor team" )
CreateConVar( "zsb_preferredbanditmodel", "", { FCVAR_ARCHIVE, FCVAR_USERINFO }, "Player model to use when on the Bandit team" )

CreateConVar( "cl_playercolor", "0.24 0.34 0.41", { FCVAR_ARCHIVE, FCVAR_USERINFO }, "The value is a Vector - so between 0-1 - not between 0-255" )
CreateConVar( "cl_weaponcolor", "0.30 1.80 2.10", { FCVAR_ARCHIVE, FCVAR_USERINFO }, "The value is a Vector - so between 0-1 - not between 0-255" )