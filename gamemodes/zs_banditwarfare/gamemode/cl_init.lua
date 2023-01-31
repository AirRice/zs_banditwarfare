-- Sometimes persistent ones don't get created.
local dummy = CreateClientConVar("_zs_dummyconvar", 1, false, false)
local oldCreateClientConVar = CreateClientConVar
function CreateClientConVar(...)
	return oldCreateClientConVar(...) or dummy
end

include("shared.lua")
include("cl_draw.lua")
include("cl_util.lua")
include("cl_options.lua")
include("obj_player_extend_cl.lua")
include("cl_scoreboard.lua")
include("cl_targetid.lua")
include("cl_postprocess.lua")

include("vgui/dgamestate.lua")
include("vgui/dtransmittercounter.lua")
include("vgui/dteamcounter.lua")
include("vgui/dteamscores.lua")
include("vgui/dmodelpanelex.lua")
include("vgui/dweaponloadoutbutton.lua")
include("vgui/dteamheading.lua")
include("vgui/dteamselect.lua")
include("vgui/dmodelkillicon.lua")

include("vgui/dexroundedpanel.lua")
include("vgui/dexroundedframe.lua")
include("vgui/dexrotatedimage.lua")
include("vgui/dexnotificationslist.lua")
include("vgui/dexchanginglabel.lua")

include("vgui/pmainmenu.lua")
include("vgui/poptions.lua")
include("vgui/phelp.lua")
include("vgui/pweapons.lua")
include("vgui/pendboard.lua")
include("vgui/ppointshop.lua")
include("vgui/dpingmeter.lua")
include("vgui/zshealtharea.lua")

include("cl_dermaskin.lua")
include("cl_deathnotice.lua")
include("cl_floatingscore.lua")
include("cl_hint.lua")

w, h = ScrW(), ScrH()

MySelf = MySelf or NULL
hook.Add("InitPostEntity", "GetLocal", function()
	MySelf = LocalPlayer()

	GAMEMODE.HookGetLocal = GAMEMODE.HookGetLocal or (function(g) end)
	gamemode.Call("HookGetLocal", MySelf)
	RunConsoleCommand("initpostentity")
end)

-- Remove when model decal crash is fixed.
function util.Decal()
end

-- Save on global lookup time.
local render = render
local surface = surface
local draw = draw
local cam = cam
local player = player
local ents = ents
local util = util
local math = math
local string = string
local bit = bit
local gamemode = gamemode
local hook = hook
local Vector = Vector
local VectorRand = VectorRand
local Angle = Angle
local AngleRand = AngleRand
local Entity = Entity
local Color = Color
local FrameTime = FrameTime
local RealTime = RealTime
local CurTime = CurTime
local SysTime = SysTime
local EyePos = EyePos
local EyeAngles = EyeAngles
local pairs = pairs
local ipairs = ipairs
local tostring = tostring
local tonumber = tonumber
local type = type
local ScrW = ScrW
local ScrH = ScrH
local TEXT_ALIGN_CENTER = TEXT_ALIGN_CENTER
local TEXT_ALIGN_LEFT = TEXT_ALIGN_LEFT
local TEXT_ALIGN_RIGHT = TEXT_ALIGN_RIGHT
local TEXT_ALIGN_TOP = TEXT_ALIGN_TOP
local TEXT_ALIGN_BOTTOM = TEXT_ALIGN_BOTTOM

local TEAM_HUMAN = TEAM_HUMAN
local TEAM_BANDIT = TEAM_BANDIT
local translate = translate

local COLOR_PURPLE = COLOR_PURPLE
local COLOR_GRAY = COLOR_GRAY
local COLOR_RED = COLOR_RED
local COLOR_DARKRED = COLOR_DARKRED
local COLOR_DARKGREEN = COLOR_DARKGREEN
local COLOR_GREEN = COLOR_GREEN
local COLOR_WHITE = COLOR_WHITE

local surface_SetFont = surface.SetFont
local surface_SetTexture = surface.SetTexture
local surface_SetMaterial = surface.SetMaterial
local surface_SetDrawColor = surface.SetDrawColor
local surface_DrawRect = surface.DrawRect
local surface_DrawOutlinedRect = surface.DrawOutlinedRect
local surface_DrawTexturedRect = surface.DrawTexturedRect
local surface_DrawTexturedRectRotated = surface.DrawTexturedRectRotated
local surface_DrawTexturedRectUV = surface.DrawTexturedRectUV
local surface_PlaySound = surface.PlaySound

local draw_SimpleText = draw.SimpleText
local draw_SimpleTextBlurry = draw.SimpleTextBlurry
local draw_SimpleTextBlur = draw.SimpleTextBlur
local draw_GetFontHeight = draw.GetFontHeight

local MedicalAuraDistance = 300

GM.LifeStatsEnemyKilled = 0
GM.LifeStatsEnemyDamage = 0
GM.LifeStatsBarricadeDamage = 0
GM.InputMouseX = 0
GM.InputMouseY = 0
GM.LastTimeDead = 0
GM.LastTimeAlive = 0
GM.FOVLerp = 1
GM.HurtEffect = 0
GM.PrevHealth = 0
GM.SuppressArsenalTime = 0
GM.NextSpawnTime = nil
GM.IsInSuddenDeath = false
GM.Beats = {
"music/HL2_song29.mp3",
"music/HL2_song3.mp3",
"music/HL2_song31.mp3",
"music/HL2_song20_submix0.mp3",
"music/HL2_song20_submix4.mp3",
"music/HL2_song16.mp3",
"music/HL2_song15.mp3",
"music/HL2_song14.mp3",
"music/HL2_song4.mp3",
"music/HL2_song3.mp3",
"music/HL1_song15.mp3",
"music/HL1_song17.mp3",
"music/HL1_song10.mp3"
}

function GM:ClickedPlayerButton(pl, button)
end

function GM:ClickedEndBoardPlayerButton(pl, button)
end

function GM:UpdateTransmitterTeamCounter(objtable)
	if self.TransmitterCounterPanel and self.TransmitterCounterPanel:Valid() then
		self.TransmitterCounterPanel:UpdateTransmitterTeams(objtable)
	end
end

function GM:CenterNotify(...)
	if self.CenterNotificationHUD and self.CenterNotificationHUD:Valid() then
		return self.CenterNotificationHUD:AddNotification(...)
	end
end

function GM:TopNotify(...)
	if self.TopNotificationHUD and self.TopNotificationHUD:Valid() then
		return self.TopNotificationHUD:AddNotification(...)
	end
end

function GM:_InputMouseApply(cmd, x, y, ang)
	self.InputMouseX = x
	self.InputMouseY = y

	if MySelf:KeyDown(IN_WALK) and MySelf:IsHolding() then
		RunConsoleCommand("_zs_rotateang", self.InputMouseX, self.InputMouseY)
		return true
	end
end

function GM:TryHumanPickup(pl, entity)
end

function GM:AddExtraOptions(list, window)
end

function GM:SpawnMenuEnabled()
	return true
end

function GM:ContextMenuOpen()
	return false
end

function GM:HUDWeaponPickedUp(wep)
end

function GM:_HUDWeaponPickedUp(wep)
	if (MySelf:Team() == TEAM_HUMAN or MySelf:Team() == TEAM_BANDIT) and not wep.NoPickupNotification then
		self:Rewarded(wep:GetClass())
	end
end

function GM:HUDItemPickedUp(itemname)
end

function GM:HUDAmmoPickedUp(itemname, amount)
end

function GM:InitPostEntity()
	if not self.HealthHUD then
		self.HealthHUD = vgui.Create("ZSHealthArea")
	end

	self:LocalPlayerFound()

	self:EvaluateFilmMode()
end

local matAura = Material("models/debug/debugwhite")
local skip = false
function GM.PostPlayerDrawMedical(pl)
	if not skip and pl:Team() == MySelf:Team() and pl ~= LocalPlayer() then
		local eyepos = EyePos()
		local dist = pl:NearestPoint(eyepos):Distance(eyepos)
		if dist < MedicalAuraDistance then
			local green = pl:Health() / pl:GetMaxHealth()

			pl.SkipDrawHooks = true
			skip = true

			render.SuppressEngineLighting(true)
			render.ModelMaterialOverride(matAura)
			render.SetBlend((1 - (dist / MedicalAuraDistance)) * 0.1 * (1 + math.abs(math.sin((CurTime() + pl:EntIndex()) * 4)) * 0.05))
			render.SetColorModulation(1 - green, green, 0)
				pl:DrawModel()
			render.SetColorModulation(1, 1, 1)
			render.SetBlend(1)
			render.ModelMaterialOverride()
			render.SuppressEngineLighting(false)

			skip = false
			pl.SkipDrawHooks = false
		end
	end
end

function GM:OnReloaded()
	self.BaseClass.OnReloaded(self)

	self:LocalPlayerFound()
end

-- The whole point of this is so we don't need to check if the local player is valid 1000 times a second.
-- Empty functions get filled when the local player is found.
function GM:Think() end
GM.HUDWeaponPickedUp = GM.Think
GM.Think = GM._Think
GM.HUDShouldDraw = GM.Think
GM.CalcView = GM.Think
GM.ShouldDrawLocalPlayer = GM.Think
GM.PostDrawOpaqueRenderables = GM.Think
GM.PostDrawTranslucentRenderables = GM.Think
GM.HUDPaint = GM.Think
GM.HUDPaintBackground = GM.Think
GM.CreateMove = GM.Think
GM.PrePlayerDraw = GM.Think
GM.PostPlayerDraw = GM.Think
GM.InputMouseApply = GM.Think
GM.GUIMousePressed = GM.Think
GM.GUIMouseDoublePressed = GM.Think

function GM:LocalPlayerFound()
	self.Think = self._Think
	self.HUDShouldDraw = self._HUDShouldDraw
	self.CalcView = self._CalcView
	self.ShouldDrawLocalPlayer = self._ShouldDrawLocalPlayer
	self.PostDrawOpaqueRenderables = self._PostDrawOpaqueRenderables
	self.PostDrawTranslucentRenderables = self._PostDrawTranslucentRenderables
	self.HUDPaint = self._HUDPaint
	self.HUDPaintBackground = self._HUDPaintBackground
	self.CreateMove = self._CreateMove
	self.PrePlayerDraw = self._PrePlayerDraw
	self.PostPlayerDraw = self._PostPlayerDraw
	self.InputMouseApply = self._InputMouseApply
	self.GUIMousePressed = self._GUIMousePressed
	self.GUIMouseDoublePressed = self._GUIMouseDoublePressed
	self.HUDWeaponPickedUp = self._HUDWeaponPickedUp

	LocalPlayer().LegDamage = 0

	if render.GetDXLevel() >= 80 then
		self.RenderScreenspaceEffects = self._RenderScreenspaceEffects
	end
end

local currentpower = 0
local spawngreen = 0

function GM:TrackLastDeath()
	if MySelf:Alive() then
		self.LastTimeAlive = CurTime()
	else
		self.LastTimeDead = CurTime()
	end
end

function GM:IsSampleCollectMode()
	return GetGlobalInt("roundgamemode", 0) == ROUNDMODE_SAMPLES
end

function GM:IsClassicMode()
	return GetGlobalInt("roundgamemode", 0) == ROUNDMODE_CLASSIC
end

function GM:IsTransmissionMode()
	return GetGlobalInt("roundgamemode", 0) == ROUNDMODE_TRANSMISSION
end

function GM:IsRoundModeUnassigned()
	return GetGlobalInt("roundgamemode", 0) == ROUNDMODE_UNASSIGNED
end

local lastwarntim = -1
function GM:_Think()
	
	if self.HealthHUD and self.HealthHUD:Valid() then
		if MySelf:Team() == TEAM_SPECTATOR then
			self.HealthHUD:SetVisible(false)
		else
			self.HealthHUD:SetVisible(not self.FilmMode)
		end
	end
	
	local health = MySelf:Health()
	if self.PrevHealth and health < self.PrevHealth then
		self.HurtEffect = math.min(self.HurtEffect + (self.PrevHealth - health) * 0.02, 1.5)
	elseif self.HurtEffect > 0 then
		self.HurtEffect = math.max(0, self.HurtEffect - FrameTime() * 0.65)
	end
	self.PrevHealth = health

	self:TrackLastDeath()

	local endtime = self:GetWaveActive() and self:GetWaveEnd() or self:GetWaveStart()
	if endtime ~= -1 then
		local timleft = math.max(0, endtime - CurTime())
		if timleft <= 10 and lastwarntim ~= math.ceil(timleft) then
			lastwarntim = math.ceil(timleft)
			if 0 < lastwarntim then
				surface_PlaySound("buttons/lightswitch2.wav")
			end
		end
	end
	if CurTime() >= self.LastHitMarker+self.HitMarkerLifeTime then
		self.LastHitMarkerHeadshot = false
	end
	local myteam = MySelf:Team()
	self:PlayBeats()
	if myteam == TEAM_HUMAN or myteam == TEAM_BANDIT then
		local wep = MySelf:GetActiveWeapon()
		if wep:IsValid() and wep.GetIronsights and wep:GetIronsights() then
			self.FOVLerp = math.Approach(self.FOVLerp, wep.IronsightsMultiplier or 0.6, FrameTime() * 4)
		elseif self.FOVLerp ~= 1 then
			self.FOVLerp = math.Approach(self.FOVLerp, 1, FrameTime() * 5)
		end

		if MySelf:GetBarricadeGhosting() then
			MySelf:BarricadeGhostingThink()
		end
	end

	for _, pl in pairs(player.GetAll()) do
		if pl.WasBuildingBonePositions then
			pl.WasBuildingBonePositions = nil
			pl:ResetBones()
		end
	end
end

function GM:ShouldPlayBeats()
	return not self.RoundEnded and (self:GetWaveActive() or self.IsInSuddenDeath)
end


local cv_ShouldPlayMusic = CreateClientConVar("zsb_playmusic", 1, true, false)
GM.NextBeat = 0
GM.BeatsSoundChannel = nil
function GM:PlayBeats()
	if not gamemode.Call("ShouldPlayBeats") or not cv_ShouldPlayMusic:GetBool() then return end
	if (RealTime() >= self.NextBeat) then
		local snd = nil
		if self.IsInSuddenDeath then
			snd = self.SuddenDeathSound
		else
			snd = self.Beats[math.random(1,#self.Beats)]
		end
		
		if snd and not IsPlayingSong then
			sound.PlayFile("sound/"..snd,"noplay",function(channel, errId, errName)
				if (!errId and IsValid(channel)) then
					self.BeatsSoundChannel = channel
					self.BeatsSoundChannel:SetVolume(self.BeatsVolume)
					self.BeatsSoundChannel:Play()
				end
			end)
			self.NextBeat = RealTime() + (self.SoundDuration[snd] or SoundDuration(snd))
		end
	end
end

function GM:RestartBeats()
	if (self.BeatsSoundChannel and self.BeatsSoundChannel:IsValid()) then
		self.BeatsSoundChannel:Stop()
	end
	timer.Simple(0.5, function() self.NextBeat = 0; end)
end

local colPackUp = Color(20, 255, 20, 220)
local colPackUpNotOwner = Color(255, 240, 10, 220)
function GM:DrawPackUpBar(x, y, fraction, notowner, screenscale)
	local col = notowner and colPackUpNotOwner or colPackUp

	local maxbarwidth = 270 * screenscale
	local barheight = 11 * screenscale
	local barwidth = maxbarwidth * math.Clamp(fraction, 0, 1)
	local startx = x - maxbarwidth * 0.5

	surface_SetDrawColor(0, 0, 0, 220)
	surface_DrawRect(startx, y, maxbarwidth, barheight)
	surface_SetDrawColor(col)
	surface_DrawRect(startx + 3, y + 3, barwidth - 6, barheight - 6)
	surface_DrawOutlinedRect(startx, y, maxbarwidth, barheight)

	draw_SimpleText(notowner and CurTime() % 2 < 1 and translate.Format("requires_x_people", 4) or notowner and translate.Get("packing_others_object") or translate.Get("packing"), "ZSHUDFontSmall", x, y - draw_GetFontHeight("ZSHUDFontSmall") - 2, col, TEXT_ALIGN_CENTER)
end
local colLifeStats = Color(255, 0, 0, 255)
GM.LastHitMarker = 0
GM.LastHitMarkerHeadshot = false
net.Receive( "zs_hitmarker", function( iLen )
	local IsPlayer = net.ReadBool() 
	local head = net.ReadBool() 
	if not IsPlayer then return end
	
	GAMEMODE.LastHitMarker = CurTime()
	GAMEMODE.LastHitMarkerHeadshot = head
	LocalPlayer():EmitSound("bandit/hitsound.wav", 500, 100, 1,CHAN_ITEM)
end )

function GM:HumanHUD(screenscale)
	local curtime = CurTime()
	local w, h = ScrW(), ScrH()
	
	local packup = MySelf.PackUp
	if packup and packup:IsValid() then
		self:DrawPackUpBar(w * 0.5, h * 0.55, 1 - packup:GetTimeRemaining() / packup:GetMaxTime(), packup:GetNotOwner(), screenscale)
	end

	if not self.RoundEnded then
		if self:GetWave() == 0 and not self:GetWaveActive() then
			local wavezerowait = math.max(0, self:GetWaveStart() - self.WaveIntermissionLength - curtime)
			if wavezerowait > 0 then
				local txth = draw_GetFontHeight("ZSHUDFontSmall")
				draw_SimpleTextBlurry(translate.Get("waiting_for_players").." "..util.ToMinutesSeconds(math.max(0, self:GetWaveStart() - self.WaveIntermissionLength - curtime)), "ZSHUDFontSmall", w * 0.5, h * 0.25, COLOR_GRAY, TEXT_ALIGN_CENTER)

				local y = h * 0.75 + txth * 2

				txth = draw_GetFontHeight("ZSHUDFontTiny")
			end
		end

		local drown = MySelf.status_drown
		if drown and drown:IsValid() then
			surface_SetDrawColor(0, 0, 0, 60)
			surface_DrawRect(w * 0.4, h * 0.35, w * 0.2, 12)
			surface_SetDrawColor(30, 30, 230, 180)
			surface_DrawOutlinedRect(w * 0.4, h * 0.35, w * 0.2, 12)
			surface_DrawRect(w * 0.4, h * 0.35, w * 0.2 * (1 - drown:GetDrown()), 12)
			draw_SimpleTextBlurry(translate.Get("breath").." ", "ZSHUDFontSmall", w * 0.4, h * 0.35 + 6, COLOR_BLUE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		end
	end
	
	if self.IsInSuddenDeath then 
		draw_SimpleTextBlurry(translate.Format("sudden_death"), "ZSHUDFont", w * 0.5, 128, COLOR_DARKRED, TEXT_ALIGN_CENTER)
	end
	if self.LifeStatsEndTime and CurTime() < self.LifeStatsEndTime and (self.LifeStatsBarricadeDamage > 0 or self.LifeStatsEnemyDamage > 0 or self.LifeStatsEnemyKilled > 0) then
		colLifeStats.a = math.Clamp((self.LifeStatsEndTime - CurTime()) / (self.LifeStatsLifeTime * 0.33), 0, 1) * 255

		local th = draw_GetFontHeight("ZSHUDFontSmall")
		local x = ScrW() * 0.75
		local y = ScrH() * 0.75

		draw_SimpleTextBlur(translate.Get("that_life"), "ZSHUDFontSmall", x, y, colLifeStats, TEXT_ALIGN_LEFT)
		y = y + th

		if self.LifeStatsBarricadeDamage > 0 then
			draw_SimpleTextBlur(translate.Format("x_damage_to_barricades", self.LifeStatsBarricadeDamage), "ZSHUDFontSmall", x, y, colLifeStats, TEXT_ALIGN_LEFT)
			y = y + th
		end
		if self.LifeStatsEnemyDamage > 0 then
			draw_SimpleTextBlur(translate.Format("x_damage_to_enemies", self.LifeStatsEnemyDamage), "ZSHUDFontSmall", x, y, colLifeStats, TEXT_ALIGN_LEFT)
			y = y + th
		end
		if self.LifeStatsEnemyKilled > 0 then
			draw_SimpleTextBlur(translate.Format("x_kills", self.LifeStatsEnemyKilled), "ZSHUDFontSmall", x, y, colLifeStats, TEXT_ALIGN_LEFT)
			y = y + th
		end
	end
	local hitmarkeralpha = (math.Clamp(self.HitMarkerLifeTime+self.LastHitMarker-CurTime(), 0,self.HitMarkerLifeTime)/self.HitMarkerLifeTime)
	if hitmarkeralpha > 0 then
		local screen = Vector(ScrW() / 2, ScrH() / 2)
		local nonred = self.LastHitMarkerHeadshot and 0 or 255
		surface_SetDrawColor(255,nonred,nonred,255*hitmarkeralpha)
		surface.DrawLine( screen.x - 35, screen.y - 35, screen.x - 25, screen.y - 25 )
		surface.DrawLine( screen.x - 35, screen.y + 35, screen.x - 25, screen.y + 25 )
		surface.DrawLine( screen.x + 35, screen.y - 35, screen.x + 25, screen.y - 25 )
		surface.DrawLine( screen.x + 35, screen.y + 35, screen.x + 25, screen.y + 25 )
	end
	local obsmode = MySelf:GetObserverMode()
	if obsmode ~= OBS_MODE_NONE then
		self:ObserverHUD(obsmode)
	elseif not self:GetWaveActive() and not MySelf:Alive() then
		local th = draw_GetFontHeight("ZSHUDFont")
		local x = ScrW() * 0.5
		local y = ScrH() * 0.3
		draw_SimpleTextBlur(translate.Get("waiting_for_next_wave"), "ZSHUDFont", x, y, COLOR_DARKRED, TEXT_ALIGN_CENTER)
	end
end

function GM:HUDPaint()
end

local triangle = {
	{ x = 50, y = 50 },
	{ x = 75, y = 100 },
	{ x = 100, y = 50 }

}

function GM:_HUDPaint()
	if self.FilmMode then return end
	local myteam = MySelf:Team()
	if self:IsClassicMode() then		
		draw_SimpleTextBlurry(translate.Get("deathmatch_mode"), "ZSHUDFont", w * 0.5, h - 128, COLOR_DARKRED, TEXT_ALIGN_CENTER)
	elseif self:IsSampleCollectMode() then
		draw_SimpleTextBlurry(translate.Get("sample_collect_mode"), "ZSHUDFont", w * 0.5, h - 128, COLOR_DARKGREEN, TEXT_ALIGN_CENTER)
		if not MySelf:IsSpectator() then
			draw_SimpleTextBlurry(translate.Format("samples_collected",MySelf:GetSamples()), "ZSHUDFont", w * 0.5, h - 64, COLOR_DARKGREEN, TEXT_ALIGN_CENTER)
		end
	elseif self:IsTransmissionMode() then
		draw_SimpleTextBlurry(translate.Get("transmission_mode"), "ZSHUDFont", w * 0.5, h - 128, COLOR_DARKBLUE, TEXT_ALIGN_CENTER)
	end
	
	local screenscale = BetterScreenScale()

	self:HUDDrawTargetID(myteam, screenscale)

	if (myteam == TEAM_BANDIT or myteam == TEAM_HUMAN) then
		self:HumanHUD(screenscale)
	elseif myteam == TEAM_SPECTATOR then
		local obsmode = MySelf:GetObserverMode()
		if obsmode ~= OBS_MODE_NONE then
			self:ObserverHUD(obsmode)
		end
	end
end

function GM:ObserverHUD(obsmode)
	local w, h = ScrW(), ScrH()
	local texh = draw_GetFontHeight("ZSHUDFontSmall")
	if obsmode == OBS_MODE_CHASE or obsmode == OBS_MODE_IN_EYE then
		local target = MySelf:GetObserverTarget()
		if target and target:IsValid() and target:IsPlayer() then
			if target:Team() == MySelf:Team() or MySelf:IsSpectator() then
				local teamcolor = COLOR_DARKGREEN
				if MySelf:IsSpectator() and target:Team() == TEAM_BANDIT or target:Team() == TEAM_HUMAN then
					teamcolor = team.GetColor(target:Team())
				end
				draw_SimpleTextBlur(translate.Format("observing_x", target:Name(), math.max(0, target:Health())), "ZSHUDFontSmall", w * 0.5, h * 0.75 - texh - 32, teamcolor or COLOR_DARKGREEN, TEXT_ALIGN_CENTER)
			end
		end
	end
	if not self:IsClassicMode() and not self.IsInSuddenDeath and MySelf:Team() ~= TEAM_SPECTATOR then
		if self.NextSpawnTime and self.NextSpawnTime - CurTime() > 0 then
			draw_SimpleTextBlur(translate.Format("respawn_after_x_seconds",math.ceil(self.NextSpawnTime - CurTime())), "ZSHUDFontSmall", w * 0.5, h * 0.75, COLOR_DARKGREEN, TEXT_ALIGN_CENTER)
		elseif not self.NextSpawnTime or (self.NextSpawnTime - CurTime()) <= 0 then
			draw_SimpleTextBlur(translate.Get("press_lmb_to_spawn"), "ZSHUDFontSmall", w * 0.5, h * 0.75, COLOR_DARKGREEN, TEXT_ALIGN_CENTER)
		end
	end
	local space = texh+4
		draw_SimpleTextBlurry(translate.Get("press_rmb_to_cycle_targets"), "ZSHUDFontSmall", w * 0.5, h * 0.75 + space, COLOR_WHITE, TEXT_ALIGN_CENTER)
		draw_SimpleTextBlurry(translate.Get("press_duck_to_toggle_eyecam"), "ZSHUDFontSmall", w * 0.5, h * 0.75 + space*2, COLOR_WHITE, TEXT_ALIGN_CENTER)
	if MySelf:Team() == TEAM_SPECTATOR then
		draw_SimpleTextBlurry(translate.Get("press_jump_to_free_roam"), "ZSHUDFontSmall", w * 0.5, h * 0.75 + space * 3, COLOR_WHITE, TEXT_ALIGN_CENTER)
	end
end
local indicator_mat = Material("vgui/ico_friend_indicator_alone")

function GM:_PostDrawTranslucentRenderables()
	if not self.DrawingInSky then
		self:DrawPointWorldHints()
		self:DrawWorldHints()
	end
	if self.ShowIndicators then
		local plys = team.GetPlayers(MySelf:Team())
		local indicator_col = team.GetColor(MySelf:Team())
		local dir = MySelf:GetForward() * -1

		render.SetMaterial(indicator_mat)
		for i=1, #plys do
			ply = plys[i]
			if ply:IsPlayer() and ply:Team() == MySelf:Team() and ply != MySelf and ply:Alive() then
			   pos = ply:GetPos()
			   pos.z = pos.z + 74
			   render.DrawQuadEasy(pos, dir, 16, 16, indicator_col, 180)
			end
		end
	end
end

function GM:RestartRound()
	self.RoundEnded = nil

	if pEndBoard and pEndBoard:Valid() then
		pEndBoard:Remove()
		pEndBoard = nil
	end

	self:InitPostEntity()

end

function GM:_HUDShouldDraw(name)
	if self.FilmMode and name ~= "CHudWeaponSelection" then return false end
	return name ~= "CHudHealth" and name ~= "CHudBattery"
	and name ~= "CHudAmmo" and name ~= "CHudSecondaryAmmo"
	and name ~= "CHudDamageIndicator" and name ~= "CHudPoisonDamageIndicator"
	and name ~= "CHudSuitPower" and name ~= "CHudFlashlight"
end

local Current = 0
local NextCalculate = 0

function surface.CreateLegacyFont(font, size, weight, antialias, additive, name, shadow, outline, blursize, extended)
	surface.CreateFont(name, {font = font, size = size, weight = weight, antialias = antialias, additive = additive, shadow = shadow, outline = outline, blursize = blursize, extended = extended})
end

function GM:CreateFonts()
	local fontfamily = "Typenoksidi_v2"
	local fontfamily3d = "hidden_v2"
	local fontweight = 0
	local fontweightbold = 200
	local fontweight3D = 0
	local fontaa = true
	local fontshadow = false
	local fontoutline = true
	local fontextended = true

	surface.CreateLegacyFont("csd", 42, 500, true, false, "healthsign", false, true)
	surface.CreateLegacyFont("tahoma", 96, 1000, true, false, "zshintfont", false, true)

	surface.CreateLegacyFont(fontfamily3d, 48, fontweight3D, false, false,  "ZS3D2DFontSmall", false, true, false, true)
	surface.CreateLegacyFont(fontfamily3d, 72, fontweight3D, false, false, "ZS3D2DFont", false, true, false, true)
	surface.CreateLegacyFont(fontfamily3d, 128, fontweight3D, false, false, "ZS3D2DFontBig", false, true, false, true)
	surface.CreateLegacyFont(fontfamily3d, 48, fontweight3D, false, false,  "ZS3D2DFontSmallBlur", false, false, 16, true)
	surface.CreateLegacyFont(fontfamily3d, 72, fontweight3D, false, false, "ZS3D2DFontBlur", false, false, 16, true)
	surface.CreateLegacyFont(fontfamily3d, 128, fontweight3D, false, false, "ZS3D2DFontBigBlur", false, false, 16, true)
	surface.CreateLegacyFont(fontfamily, 40, fontweight3D, false, false,  "ZS3D2DFont2Smaller", false, true, false, true)
	surface.CreateLegacyFont(fontfamily, 48, fontweight3D, false, false,  "ZS3D2DFont2Small", false, true, false, true)
	surface.CreateLegacyFont(fontfamily, 72, fontweight3D, false, false, "ZS3D2DFont2", false, true, false, true)
	surface.CreateLegacyFont(fontfamily, 128, fontweight3D, false, false, "ZS3D2DFont2Big", false, true, false, true)
	surface.CreateLegacyFont(fontfamily, 40, fontweight3D, false, false,  "ZS3D2DFont2SmallerBlur", false, false, 16, true)
	surface.CreateLegacyFont(fontfamily, 48, fontweight3D, false, false,  "ZS3D2DFont2SmallBlur", false, false, 16, true)
	surface.CreateLegacyFont(fontfamily, 72, fontweight3D, false, false, "ZS3D2DFont2Blur", false, false, 16, true)
	surface.CreateLegacyFont(fontfamily, 128, fontweight3D, false, false, "ZS3D2DFont2BigBlur", false, false, 16, true)

	local screenscale = BetterScreenScale()

	surface.CreateLegacyFont("csd", screenscale * 36, 100, true, false, "zsdeathnoticecs", false, true)
	surface.CreateLegacyFont("HL2MP", screenscale * 36, 100, true, false, "zsdeathnotice", false, true)
	
	surface.CreateLegacyFont("csd", screenscale * 96, 100, true, false, "zsdeathnoticecsws", false, false)
	surface.CreateLegacyFont("HL2MP", screenscale * 96, 100, true, false, "zsdeathnoticews", false, false)
	
	surface.CreateLegacyFont("csd", screenscale * 76, 100, true, false, "zsdeathnoticecsps", false, false)
	surface.CreateLegacyFont("HL2MP", screenscale * 76, 100, true, false, "zsdeathnoticeps", false, false)
	
	surface.CreateLegacyFont(fontfamily, screenscale * 16, fontweight, fontaa, false, "ZSHUDFontTiny", fontshadow, fontoutline, false, fontextended)
	surface.CreateLegacyFont(fontfamily, screenscale * 20, fontweight, fontaa, false, "ZSHUDFontSmallest", fontshadow, fontoutline, false, fontextended)
	surface.CreateLegacyFont(fontfamily, screenscale * 22, fontweight, fontaa, false, "ZSHUDFontSmaller", fontshadow, fontoutline, false, fontextended)
	surface.CreateLegacyFont(fontfamily, screenscale * 28, fontweight, fontaa, false, "ZSHUDFontSmall", fontshadow, fontoutline, false, fontextended)
	surface.CreateLegacyFont(fontfamily, screenscale * 30, fontweightbold, fontaa, false, "ZSHUDFontSmallBold", fontshadow, fontoutline, false, fontextended)
	surface.CreateLegacyFont(fontfamily, screenscale * 42, fontweight, fontaa, false, "ZSHUDFont", fontshadow, fontoutline, false, fontextended)
	surface.CreateLegacyFont(fontfamily, screenscale * 72, fontweight, fontaa, false, "ZSHUDFontBig", fontshadow, fontoutline, false, fontextended)
	surface.CreateLegacyFont(fontfamily, screenscale * 16, fontweight, fontaa, false, "ZSHUDFontTinyBlur", false, false, 8, true)
	surface.CreateLegacyFont(fontfamily, screenscale * 22, fontweight, fontaa, false, "ZSHUDFontSmallerBlur", false, false, 8, true)
	surface.CreateLegacyFont(fontfamily, screenscale * 28, fontweight, fontaa, false, "ZSHUDFontSmallBlur", false, false, 8, true)
	surface.CreateLegacyFont(fontfamily, screenscale * 42, fontweight, fontaa, false, "ZSHUDFontBlur", false, false, 8, true)
	surface.CreateLegacyFont(fontfamily, screenscale * 72, fontweight, fontaa, false, "ZSHUDFontBigBlur", false, false, 8, true)

	surface.CreateLegacyFont(fontfamily, screenscale * 16, 0, fontaa, false, "ZSAmmoName", false, false, false, true)
	surface.CreateLegacyFont(fontfamily, screenscale * 16, fontweight, fontaa, false, "ZSHUDFontTinyNS", false, false, false, true)
	surface.CreateLegacyFont(fontfamily, screenscale * 20, fontweight, fontaa, false, "ZSHUDFontSmallestNS", false, false, false, true)
	surface.CreateLegacyFont(fontfamily, screenscale * 22, fontweight, fontaa, false, "ZSHUDFontSmallerNS", false, false, false, true)
	surface.CreateLegacyFont(fontfamily, screenscale * 28, fontweight, fontaa, false, "ZSHUDFontSmallNS", false, false, false, true)
	surface.CreateLegacyFont(fontfamily, screenscale * 42, fontweight, fontaa, false, "ZSHUDFontNS", false, false, false, true)
	surface.CreateLegacyFont(fontfamily, screenscale * 72, fontweight, fontaa, false, "ZSHUDFontBigNS", false, false, false, true)
	
	surface.CreateLegacyFont("arial", screenscale * 24, 0, true, false, "ZSIconFont", false, font)
	
	surface.CreateLegacyFont(fontfamily, screenscale * 16, 0, true, false, "ZSDamageResistance", false, true, false, true)
	surface.CreateLegacyFont(fontfamily, screenscale * 16, 0, true, false, "ZSDamageResistanceBlur", false, true, false, true)

	surface.CreateLegacyFont(fontfamily, 32, fontweight, true, false, "ZSScoreBoardTitle", false, true, false, true)
	surface.CreateLegacyFont(fontfamily, 22, fontweight, true, false, "ZSScoreBoardSubTitle", false, true, false, true)
	surface.CreateLegacyFont(fontfamily, 18, fontweight, true, false, "ZSScoreBoardPlayer", false, true, false, true)
	surface.CreateLegacyFont(fontfamily, 24, fontweight, true, false, "ZSScoreBoardHeading", false, false, false, true)
	surface.CreateLegacyFont("arial", 22, 0, true, false, "ZSScoreBoardPlayerSmall", false, true)

	-- Default, DefaultBold, DefaultSmall, etc. were changed when gmod13 hit. These are renamed fonts that have the old values.
	surface.CreateFont("DefaultFontVerySmall", {font = "tahoma", size = 10, weight = 0, antialias = false})
	surface.CreateFont("DefaultFontSmall", {font = "tahoma", size = 11, weight = 0, antialias = false})
	surface.CreateFont("DefaultFontSmallDropShadow", {font = "tahoma", size = 11, weight = 0, shadow = true, antialias = false})
	surface.CreateFont("DefaultFont", {font = "tahoma", size = 13, weight = 500, antialias = false})
	surface.CreateFont("DefaultFontBold", {font = "tahoma", size = 13, weight = 1000, antialias = false})
	surface.CreateFont("DefaultFontLarge", {font = "tahoma", size = 16, weight = 0, antialias = false})
end

function GM:EvaluateFilmMode()
	local visible = not self.FilmMode
	if self.GameStatePanel and self.GameStatePanel:Valid() then
		self.GameStatePanel:SetVisible(visible)
	end

	if self.TopNotificationHUD and self.TopNotificationHUD:Valid() then
		self.TopNotificationHUD:SetVisible(visible)
	end

	if self.CenterNotificationHUD and self.CenterNotificationHUD:Valid() then
		self.CenterNotificationHUD:SetVisible(visible)
	end
end

function GM:CreateVGUI()
	local screenscale = BetterScreenScale()
	self.GameStatePanel = vgui.Create("DGameState")				
	self.GameStatePanel:SetTextFont("ZSHUDFontSmaller")
	self.GameStatePanel:SetAlpha(220)
	self.GameStatePanel:SetSize(screenscale * 420, screenscale * 80)
	self.GameStatePanel:ParentToHUD()

	self.TransmitterCounterPanel = vgui.Create("DTransmitterCounter")
	self.TransmitterCounterPanel:SetAlpha(220)
	self.TransmitterCounterPanel:InvalidateLayout()
	self.TransmitterCounterPanel:ParentToHUD()
	
	self.TopNotificationHUD = vgui.Create("DEXNotificationsList")
	self.TopNotificationHUD:SetAlign(RIGHT)
	self.TopNotificationHUD.PerformLayout = function(pan)
		local screenscale = BetterScreenScale()
		pan:SetSize(ScrW() * 0.4, ScrH() * 0.6)
		pan:AlignTop(16 * screenscale)
		pan:AlignRight()
	end
	self.TopNotificationHUD:InvalidateLayout()
	self.TopNotificationHUD:ParentToHUD()

	self.CenterNotificationHUD = vgui.Create("DEXNotificationsList")
	self.CenterNotificationHUD:SetAlign(CENTER)
	self.CenterNotificationHUD:SetMessageHeight(36)
	self.CenterNotificationHUD.PerformLayout = function(pan)
		local screenscale = BetterScreenScale()
		pan:SetSize(ScrW() * 0.5, ScrH() * 0.35)
		pan:CenterHorizontal()
		pan:AlignBottom(16 * screenscale)
	end
	self.CenterNotificationHUD:InvalidateLayout()
	self.CenterNotificationHUD:ParentToHUD()
end

function GM:Initialize()
	self:CreateFonts()
	self:PrecacheResources()
	self:CreateVGUI()
	self:AddCustomAmmo()
end

local function FirstOfGoodType(a)
	for _, v in pairs(a) do
		local ext = string.sub(v, -4)
		if ext == ".ogg" or ext == ".wav" or ext == ".mp3" then
			return v
		end
	end
end

function GM:PlayerDeath(pl, attacker)
end

function GM:PlayerShouldTakeDamage(pl, attacker)
	return pl == attacker or not attacker:IsPlayer() or pl:Team() ~= attacker:Team()
end

--[[local texGradientUp = surface.GetTextureID("vgui/gradient_up")
local texGradientDown = surface.GetTextureID("vgui/gradient_down")
local texGradientRight = surface.GetTextureID("vgui/gradient-r")]]
--local color_black = color_black
local texCircle = surface.GetTextureID("effects/select_ring")
local defaultcolor =  Color(255, 255, 255, 255)
function GM:_HUDPaintBackground()
	local wep = MySelf:GetActiveWeapon()
	if wep:IsValid() and wep.DrawHUDBackground then
		wep:DrawHUDBackground()
	end
	if self:IsSampleCollectMode() then
		for _, ent in pairs(ents.FindByClass("prop_sampledepositterminal")) do
			local uipos = ent:GetPos()+ent:GetAngles():Up()*30
			if ent:GetIsActive() and !LightVisible(uipos,MySelf:EyePos(),MySelf,ent) then
				local teamcolor = nil
				if (ent:GetLastCaptureTeam() == TEAM_BANDIT or ent:GetLastCaptureTeam() == TEAM_HUMAN) then 
					teamcolor = team.GetColor(ent:GetLastCaptureTeam())
				end
				local scrpos = uipos:ToScreen()
				local colr,colg,colb,cola = (teamcolor ~= nil and teamcolor or defaultcolor):Unpack()
				local size = 24
				scrpos.x = math.Clamp(scrpos.x, size, ScrW() - size)
				scrpos.y = math.Clamp(scrpos.y, size, ScrH() - size)
				surface_SetTexture(texCircle)
				surface_SetDrawColor( colr,colg,colb, 255)
				surface_DrawTexturedRect(scrpos.x - size, scrpos.y - size, size*2, size*2)
			end
		end
	elseif self:IsTransmissionMode() then
		for _, ent in pairs(ents.FindByClass("prop_obj_transmitter")) do
			local uipos = ent:GetPos()+ent:GetAngles():Up()*30
			if !LightVisible(uipos,MySelf:EyePos(),MySelf,ent) then
				local teamcolor = nil
				if ent:GetTransmitterTeam() ~= nil then 
					teamcolor = team.GetColor(ent:GetTransmitterTeam())
				end
				local colr,colg,colb,cola = (teamcolor ~= nil and teamcolor or defaultcolor):Unpack()
				local size = 24
				local scrpos = uipos:ToScreen()
				scrpos.x = math.Clamp(scrpos.x, size, ScrW() - size)
				scrpos.y = math.Clamp(scrpos.y, size, ScrH() - size)
				if MySelf:GetActiveWeapon().AdditionalTransmitterInfo then
					local text = math.ceil(MySelf:GetPos():Distance(ent:GetPos()))
					local w, h = surface.GetTextSize(text)
					draw.SimpleText(text, "ZSHUDFontSmallest", scrpos.x - size- w/2,scrpos.y - size - h/2)
				end
				surface_SetTexture(texCircle)
				surface_SetDrawColor( colr,colg,colb, 255)
				surface_DrawTexturedRect(scrpos.x - size, scrpos.y - size, size*2,size*2)
			end
		end
	end
end

function GM:HumanMenu()

	if self.HumanMenuPanel and self.HumanMenuPanel:Valid() then
		self.HumanMenuPanel:SetVisible(true)
		self.HumanMenuPanel:OpenMenu()
		return
	end

	local panel = vgui.Create("DSideMenu")
	self.HumanMenuPanel = panel

	panel:OpenMenu()
end

local function CreateVoiceVGUI()
	g_VoicePanelList = vgui.Create( "DPanel" )
	g_VoicePanelList:ParentToHUD()
	g_VoicePanelList:SetPos( ScrW() - 300, 100 )
	g_VoicePanelList:SetSize( 250, ScrH() - 300 )
	g_VoicePanelList:SetPaintBackground( false )
end
hook.Add( "InitPostEntity", "CreateVoiceVGUI", CreateVoiceVGUI )


local function VoiceNotifyThink(pnl)
	pnl.TeamCol = COLOR_DARKGRAY
	if pnl.ply and pnl.ply:IsValid() and pnl.ply:IsPlayer() and (pnl.ply:Team() == TEAM_BANDIT or pnl.ply:Team() == TEAM_HUMAN) then
		pnl.TeamCol = team.GetColor(pnl.ply:Team())
	end
	pnl.TeamCol = ColorAlpha( pnl.TeamCol, 190)
end

local PlayerVoicePanels = {}
function GM:PlayerStartVoice( ply )
	if not IsValid(g_VoicePanelList) then return end

	-- There'd be an extra one if voice_loopback is on, so remove it.
	GAMEMODE:PlayerEndVoice(ply, true)

	if ( IsValid( PlayerVoicePanels[ ply ] ) ) then

	if ( PlayerVoicePanels[ ply ].fadeAnim ) then
		PlayerVoicePanels[ ply ].fadeAnim:Stop()
		PlayerVoicePanels[ ply ].fadeAnim = nil
	end

	PlayerVoicePanels[ ply ]:SetAlpha( 255 )

	return

	end

	if not IsValid(ply) then return end

	local pnl = g_VoicePanelList:Add("VoiceNotify")
	pnl:Setup(ply)
	local oldThink = pnl.Think
	pnl.Think = function( self )
		oldThink( self )
		VoiceNotifyThink( self )
	end
	pnl.Paint = function(pnlself, w, h)
		if not IsValid(pnlself.ply) then return end
		draw.RoundedBox(4, 0, 0, w, h, pnlself.TeamCol)
		draw.RoundedBox( 4, 2, 2, w-4, h-4, Color( 0, pnlself.ply:VoiceVolume() * 255, 0, 240 ) )
	end


	PlayerVoicePanels[ ply ] = pnl 
end

function GM:PlayerEndVoice( ply )

	if ( IsValid( PlayerVoicePanels[ ply ] ) ) then

		if ( PlayerVoicePanels[ ply ].fadeAnim ) then return end

		PlayerVoicePanels[ ply ].fadeAnim = Derma_Anim( "FadeOut", PlayerVoicePanels[ ply ], PlayerVoicePanels[ ply ].FadeOut )
		PlayerVoicePanels[ ply ].fadeAnim:Start( 0.5 )

	end

end

function GM:OnContextMenuOpen()
	if (MySelf:Team() == TEAM_HUMAN or MySelf:Team() == TEAM_BANDIT) and MySelf:Alive() then
		local activewep = MySelf:GetActiveWeapon()
		if activewep and activewep:IsValid() then
			gamemode.Call("MakeWeaponInfo",activewep:GetClass() or nil)
		end
	end
end
function GM:OnContextMenuClose()
	if (MySelf:Team() == TEAM_HUMAN or MySelf:Team() == TEAM_BANDIT) and (self.m_weaponInfoFrame and self.m_weaponInfoFrame:Valid()) then
		self.m_weaponInfoFrame:Close()
	end
end

function GM:PlayerBindPress(pl, bind, wasin)
	if bind == "gmod_undo" or bind == "undo" then
		RunConsoleCommand("+zoom")
		timer.CreateEx("ReleaseZoom", 1, 1, RunConsoleCommand, "-zoom")
	end
end

function GM:_ShouldDrawLocalPlayer(pl)
	return pl:IsPlayingTaunt()
end

local roll = 0
function GM:_CalcView(pl, origin, angles, fov, znear, zfar)
	if pl.Stunned and pl.Stunned:IsValid() then
		pl.Stunned:CalcView(pl, origin, angles, fov, znear, zfar)
	end
	if pl.KnockedDown and pl.KnockedDown:IsValid() then	
		if self.DontDoRagdollEyes then
			origin = pl:GetThirdPersonCameraPos(origin, angles)
		else
			local rpos, rang = self:GetRagdollEyes(pl)
			if rpos then
				origin = rpos
				angles = rang
			end
		end
	elseif pl:ShouldDrawLocalPlayer() and pl:OldAlive() then
		origin = pl:GetThirdPersonCameraPos(origin, angles)
	end

	local targetroll = 0
	if self.MovementViewRoll then
		local dir = pl:GetVelocity()
		local speed = dir:Length()
		dir:Normalize()

		targetroll = targetroll + dir:Dot(angles:Right()) * math.min(30, speed / 100)
	end

	if pl:WaterLevel() >= 3 then
		targetroll = targetroll + math.sin(CurTime()) * 7
	end

	roll = math.Approach(roll, targetroll, math.max(0.25, math.sqrt(math.abs(roll))) * 30 * FrameTime())
	angles.roll = angles.roll + roll

	if pl:IsPlayingTaunt() then
		self:CalcViewTaunt(pl, origin, angles, fov, zclose, zfar)
	end

	local target = pl:GetObserverTarget()
	if target and target:IsValid() then
		local lasttarget = self.LastObserverTarget
		if lasttarget and lasttarget:IsValid() and target ~= lasttarget and origin:Distance(self.LastObserverTargetPos) <= 800 then
			if self.LastObserverTargetLerp then
				if CurTime() >= self.LastObserverTargetLerp then
					self.LastObserverTarget = nil
					self.LastObserverTargetLerp = nil
				else
					local delta = math.Clamp((self.LastObserverTargetLerp - CurTime()) / 0.3333, 0, 1) ^ 0.5
					origin:Set(self.LastObserverTargetPos * delta + origin * (1 - delta))
				end
			else
				self.LastObserverTargetLerp = CurTime() + 0.3333
			end
		else
			self.LastObserverTarget = target
			self.LastObserverTargetPos = origin
		end
	end
	return self.BaseClass.CalcView(self, pl, origin, angles, fov, znear, zfar)
end

function GM:CalcViewTaunt(pl, origin, angles, fov, zclose, zfar)
	local tr = util.TraceHull({start = origin, endpos = origin - angles:Forward() * 72, mins = Vector(-2, -2, -2), maxs = Vector(2, 2, 2), mask = MASK_OPAQUE, filter = pl})
	origin:Set(tr.HitPos + tr.HitNormal * 2)
end

local staggerdir = VectorRand():GetNormalized()

local function PressingJump(cmd)
	return bit.band(cmd:GetButtons(), IN_JUMP) ~= 0
end

local function PressingDuck(cmd)
	return bit.band(cmd:GetButtons(), IN_DUCK) ~= 0
end

local function PressJump(cmd, press)
	if press then
		cmd:SetButtons(bit.bor(cmd:GetButtons(), IN_JUMP))
	elseif PressingJump(cmd) then
		cmd:SetButtons(cmd:GetButtons() - IN_JUMP)
	end
end

local function PressDuck(cmd, press)
	if press then
		cmd:SetButtons(bit.bor(cmd:GetButtons(), IN_DUCK))
	elseif PressingDuck(cmd) then
		cmd:SetButtons(cmd:GetButtons() - IN_DUCK)
	end
end

local TimeDuckHeld = 0
local staggerdir = VectorRand():GetNormalized()
function GM:_CreateMove(cmd)
	if MySelf:IsPlayingTaunt() and MySelf:Alive() then
		self:CreateMoveTaunt(cmd)
		return
	end

	-- Anti spaz out method A. Forces player to stay ducking until 0.5s after landing if they crouch in mid-air AND disables jumping during that time.
	if MySelf:Team() == TEAM_HUMAN or MySelf:Team() == TEAM_BANDIT then
		-- Forces duck to be held for 0.5s after pressing it if in mid-air
		if MySelf:OnGround() then
			TimeDuckHeld = 0
		elseif PressingDuck(cmd) then
			TimeDuckHeld = 0.9
		elseif TimeDuckHeld > 0 then
			TimeDuckHeld = TimeDuckHeld - FrameTime()
			PressDuck(cmd, true)
		end
	end

	local myteam = MySelf:Team()
	if myteam == TEAM_HUMAN or myteam == TEAM_BANDIT then
		--[[if MySelf:Alive() then
			local maxhealth = MySelf:GetMaxHealth()
			local threshold = maxhealth * 0.25
			local health = MySelf:Health()
			if (health <= threshold) then
				local ft = FrameTime()
				local healthth = (((threshold - health) / threshold) * 7)
				staggerdir = (staggerdir + ft * 8 * VectorRand()):GetNormalized()

				local ang = cmd:GetViewAngles()
				local rate = ft * healthth

				ang.pitch = math.NormalizeAngle(ang.pitch + staggerdir.z * rate)
				ang.yaw = math.NormalizeAngle(ang.yaw + staggerdir.x * rate)
				cmd:SetViewAngles(ang)
			end
		end]]
	end
	
	local obsmode = MySelf:GetObserverMode()
	local wep = MySelf:GetActiveWeapon()
	if obsmode == OBS_MODE_NONE and wep.CreateMove then
		wep:CreateMove(cmd) 
	end
end

function GM:CreateMoveTaunt(cmd)
	cmd:ClearButtons(0)
	cmd:ClearMovement()
end

function GM:PostProcessPermitted(str)
	return false
end

function GM:HUDPaintEndRound()
end

function GM:PreDrawViewModel(vm, pl, wep)
	if pl and pl:IsValid() and pl:IsHolding() then return true end

	if wep and wep:IsValid() and wep.PreDrawViewModel then
		return wep:PreDrawViewModel(vm)
	end
end

function GM:PostDrawViewModel(vm, pl, wep)
	if wep and wep:IsValid() then
		if wep.UseHands or not wep:IsScripted() then
			local hands = pl:GetHands()
			if hands and hands:IsValid() then
				hands:DrawModel()
			end
		end

		if wep.PostDrawViewModel then
			wep:PostDrawViewModel(vm)
		end
	end
end

local undomodelblend = false
local undozombievision = false
local matWhite = Material("models/debug/debugwhite")
local matStealth = Material("models/props_lab/warp_sheet")
function GM:_PrePlayerDraw(pl)
	local shadowman = false
	local myteam = MySelf:Team()
	if myteam != pl:Team() and pl ~= MySelf and MySelf:Alive() and pl:Alive() and (pl:Team() == TEAM_BANDIT or pl:Team() == TEAM_HUMAN) then
		local wep = pl:GetActiveWeapon()
		if wep.m_IsStealthWeapon then
			local blend = wep:GetStealthWepBlend()
			render.SetBlend(blend)
			if blend < 0.55 then
				render.ModelMaterialOverride(matStealth)
				shadowman = true
				if blend < 0.3 then
					render.ModelMaterialOverride(matWhite)
					render.SetColorModulation(0.2, 0.2, 0.2)
				end
			end
		end
	elseif pl.status_overridemodel and pl.status_overridemodel:IsValid() and self:ShouldDrawLocalPlayer(MySelf) then 
	-- We need to do this otherwise the player's real model shows up for some reason.
		undomodelblend = true
		render.SetBlend(0)
	else
		if myteam == pl:Team() and pl ~= MySelf and not self.MedicalAura and MySelf:Alive() then
			local radius = self.TransparencyRadius
			if radius > 0 then
				local eyepos = EyePos()
				local dist = pl:NearestPoint(eyepos):Distance(eyepos)
				if dist < radius then
					local blend = math.max((dist / radius) ^ 1.4, (myteam == TEAM_HUMAN or myteam == TEAM_BANDIT) and 0.04 or 0.1)
					render.SetBlend(blend)
					if (myteam == TEAM_HUMAN or myteam == TEAM_BANDIT) and blend < 0.4 then
						render.ModelMaterialOverride(matWhite)
						render.SetColorModulation(0.2, 0.2, 0.2)
						shadowman = true
					end
					undomodelblend = true
				end
			end
		end
	end

	pl.ShadowMan = shadowman
end

local colFriend = Color(10, 255, 10, 60)
local matFriendRing = Material("SGM/playercircle")
function GM:_PostPlayerDraw(pl)

	render.SetBlend(1)
	render.ModelMaterialOverride()
	render.SetColorModulation(1, 1, 1)
	render.SuppressEngineLighting(false)
	cam.IgnoreZ(false)
	undomodelblend = false

	if pl ~= MySelf and MySelf:Team() == pl:Team() and pl:IsFriend() then
		local pos = pl:GetPos() + Vector(0, 0, 2)
		render.SetMaterial(matFriendRing)
		render.DrawQuadEasy(pos, Vector(0, 0, 1), 32, 32, colFriend)
		render.DrawQuadEasy(pos, Vector(0, 0, -1), 32, 32, colFriend)
	end
end

function GM:HUDPaintBackgroundEndRound()
	local w, h = ScrW(), ScrH()
	local timleft = math.max(0, self.EndTime + self.EndGameTime - CurTime())

	if timleft <= 0 then
		draw_SimpleTextBlur(translate.Get("loading"), "ZSHUDFont", w * 0.5, h * 0.8, COLOR_WHITE, TEXT_ALIGN_CENTER)
	else
		draw_SimpleTextBlur(translate.Format("next_round_in_x", util.ToMinutesSeconds(timleft)), "ZSHUDFontSmall", w * 0.5, h * 0.8, COLOR_WHITE, TEXT_ALIGN_CENTER)
	end
end

local function EndRoundCalcView(pl, origin, angles, fov, znear, zfar)
	if GAMEMODE.EndTime and CurTime() < GAMEMODE.EndTime + 5 then
		local endposition = GAMEMODE.RoundEndCamPosition
		if endposition then
			local delta = math.Clamp((CurTime() - GAMEMODE.EndTime) * 2, 0, 1)
			local ignoreents = player.GetAll()
			ignoreents = table.Add(ignoreents,ents.FindByClass("prop_obj_transmitter"))
			ignoreents = table.Add(ignoreents,ents.FindByClass("prop_sampledepositterminal"))
			local start = endposition * delta + origin * (1 - delta)
			local tr = util.TraceHull({start = start, endpos = start + delta * 96 * Angle(-30, CurTime() * 30, 0):Forward(), mins = Vector(-2, -2, -2), maxs = Vector(2, 2, 2), filter = ignoreents, mask = MASK_SOLID})
			return {origin = tr.HitPos + tr.HitNormal, angles = (start - tr.HitPos):Angle()}
		end

		return
	end

	hook.Remove("CalcView", "EndRoundCalcView")
end

local function EndRoundShouldDrawLocalPlayer(pl)
	if GAMEMODE.EndTime and CurTime() < GAMEMODE.EndTime + 5 then
		return true
	end

	hook.Remove("ShouldDrawLocalPlayer", "EndRoundShouldDrawLocalPlayer")
end

function GM:EndRound(winner, nextmap)
	if self.RoundEnded then return end
	self.RoundEnded = true

	ROUNDWINNER = winner

	self.EndTime = CurTime()
	
	RunConsoleCommand("stopsound")
	gamemode.Call("RestartBeats")

	self.HUDPaint = self.HUDPaintEndRound
	self.HUDPaintBackground = self.HUDPaintBackgroundEndRound

	hook.Add("CalcView", "EndRoundCalcView", EndRoundCalcView)
	hook.Add("ShouldDrawLocalPlayer", "EndRoundShouldDrawLocalPlayer", EndRoundShouldDrawLocalPlayer)

	local snd = nil
	if winner == TEAM_BANDIT then
		snd = self.BanditWinSound
	elseif winner == TEAM_HUMANS then
		snd = self.HumanWinSound
	else
		snd = self.AllLoseSound
	end
	if snd then
		timer.Simple(0.5, function()
 			sound.PlayFile("sound/"..snd,"noplay",function(channel, errId, errName)
 				if (!errId and IsValid(channel)) then
 					GAMEMODE.BeatsSoundChannel = channel
 					GAMEMODE.BeatsSoundChannel:SetVolume(GAMEMODE.BeatsVolume)
 					GAMEMODE.BeatsSoundChannel:Play()
 				end
			end)
		end)
	end

	timer.Simple(5, function()
		if not (pEndBoard and pEndBoard:IsValid()) then
			MakepEndBoard(winner)
		end
	end)
end

function GM:WeaponDeployed(pl, wep)
end

function GM:LocalPlayerDied(attackername)
	LASTDEATH = RealTime()

	surface_PlaySound(self.DeathSound)
	if attackername then
		self:CenterNotify(COLOR_RED, {font = "ZSHUDFont"}, translate.Get("you_have_died"))
		self:CenterNotify(COLOR_RED, translate.Format("you_were_killed_by_x", tostring(attackername)))
	else
		self:CenterNotify(COLOR_RED, {font = "ZSHUDFont"}, translate.Get("you_have_died"))
	end
end

function GM:OnSpawnMenuOpen()
	if (MySelf:Team() == TEAM_HUMAN or MySelf:Team() == TEAM_BANDIT) and not self:IsRoundModeUnassigned() then
		if not self:IsClassicMode() then
			gamemode.Call("HumanMenu")
		elseif MySelf:Alive() then
			self:OpenPointsShop(WEAPONLOADOUT_NULL)
		end
	end
end

function GM:OnSpawnMenuClose()
	if (MySelf:Team() == TEAM_HUMAN or MySelf:Team() == TEAM_BANDIT) and not self:IsRoundModeUnassigned() and self.HumanMenuPanel and self.HumanMenuPanel:Valid() and not self:IsClassicMode() 
	and not (self.m_PointsShop and self.m_PointsShop:Valid()) then
		self.HumanMenuPanel:CloseMenu()
	end
end

function GM:KeyPress(pl, key)
	if key == IN_SPEED then
		if pl:Alive() then
			if pl:Team() == TEAM_HUMAN or pl:Team() == TEAM_BANDIT then
				pl:DispatchAltUse()
			end
		end
	end
end

function GM:PlayerStepSoundTime(pl, iType, bWalking)


	if iType == STEPSOUNDTIME_NORMAL or iType == STEPSOUNDTIME_WATER_FOOT then
		return math.max(520 - pl:GetVelocity():Length(),150)
		
	end

	if iType == STEPSOUNDTIME_ON_LADDER then
		return 500
	end

	if iType == STEPSOUNDTIME_WATER_KNEE then
		return 650
	end

	return 350
end

function GM:PlayerCanCheckout(pl)
	return pl:IsValid() and (pl:Team() == TEAM_HUMAN or pl:Team() == TEAM_BANDIT) and pl:Alive() and self:GetWave() <= 0
end

function GM:SuppressArsenalUpgrades(suppresstime)
	self.SuppressArsenalTime = math.max(CurTime() + suppresstime, self.SuppressArsenalTime)
end
function GM:SetNextSpawnTime(respawntime,pl)
	if LocalPlayer() ~= pl then return end
	if (respawntime == nil or respawntime < 0) then self.NextSpawnTime = nil return end
	self.NextSpawnTime = respawntime
end
function GM:Rewarded(class, amount)
	if CurTime() < self.SuppressArsenalTime then return end

	class = class or "0"

	local toptext = translate.Get("arsenal_upgraded")

	local wep = weapons.GetStored(class)
	if wep and wep.TranslateName then
		if killicon.Get(class) == killicon.Get("default") then
			self:CenterNotify(COLOR_PURPLE, toptext..": ", color_white, translate.Get(wep.TranslateName))
		else
			self:CenterNotify({killicon = class}, " ", COLOR_PURPLE, toptext..": ", color_white, translate.Get(wep.TranslateName))
		end
	elseif amount then
		self:CenterNotify(COLOR_PURPLE, toptext..": ", color_white, amount.." "..class)
	else
		self:CenterNotify(COLOR_PURPLE, toptext)
	end
end

function PlayMenuOpenSound()
	LocalPlayer():EmitSound("buttons/lightswitch2.wav", 100, 30)
end

function PlayMenuCloseSound()
	LocalPlayer():EmitSound("buttons/lightswitch2.wav", 100, 20)
end

local DamageFloaters = CreateClientConVar("zsb_damagefloaters", "1", true, false):GetBool()
cvars.AddChangeCallback("zsb_damagefloaters", function(cvar, oldvalue, newvalue)
	DamageFloaters = newvalue ~= "0"
end)

net.Receive("zs_legdamage", function(length)
	LocalPlayer().LegDamage = net.ReadFloat()
end)

net.Receive("zs_bodyarmor", function(length)
	LocalPlayer().BodyArmor = net.ReadFloat()
end)
GM.ClassicModeInsuredWeps = {}
GM.ClassicModePurchasedThisWave = {}

net.Receive("zs_weapon_toinsure", function(length)
	local wep = net.ReadString()
	GAMEMODE.ClassicModePurchasedThisWave[wep] = true
end)

net.Receive("zs_insure_weapon", function(length)
	local wep = net.ReadString()
	GAMEMODE.ClassicModeInsuredWeps[wep] = true
	local doMessage = net.ReadBool()
	if doMessage then
		local wepname = weapons.GetStored(wep).TranslateName and translate.Get(weapons.GetStored(wep).TranslateName)or wep
		if killicon.Get(wep) == killicon.Get("default") then
			GAMEMODE:CenterNotify(COLOR_PURPLE, translate.Get("weapon_insured")..": ", color_white, wepname)
		else
			GAMEMODE:CenterNotify({killicon = wep}, " ", COLOR_PURPLE, translate.Get("weapon_insured")..": ", color_white, wepname)
		end
	end
end)
net.Receive("zs_remove_insured_weapon", function(length)
	local wep = net.ReadString()
	GAMEMODE.ClassicModeInsuredWeps[wep] = false
end)

net.Receive("zs_playerrespawntime", function(length)
	local respawntime = net.ReadFloat()
	local pl = net.ReadEntity()
	gamemode.Call("SetNextSpawnTime",respawntime,pl)
end)

net.Receive("zs_dmg", function(length)
	local infinitedmg = net.ReadBool()
	local damage = net.ReadUInt(16)
	local pos = net.ReadVector()

	if DamageFloaters then
		local effectdata = EffectData()
			effectdata:SetFlags(infinitedmg and 1 or 0)
			effectdata:SetOrigin(pos)
			effectdata:SetMagnitude(damage)
			effectdata:SetScale(0)
		util.Effect("damagenumber", effectdata)
	end
end)

net.Receive("zs_dmg_prop", function(length)
	local infinitedmg = net.ReadBool()
	local damage = net.ReadUInt(16)
	local pos = net.ReadVector()

	if DamageFloaters then
		local effectdata = EffectData()
			effectdata:SetFlags(infinitedmg and 1 or 0)
			effectdata:SetOrigin(pos)
			effectdata:SetMagnitude(damage)
			effectdata:SetScale(1)
		util.Effect("damagenumber", effectdata)
	end
end)

net.Receive("zs_lifestats", function(length)
	local barricadedamage = net.ReadUInt(24)
	local humandamage = net.ReadUInt(24)
	local brainseaten = net.ReadUInt(16)

	GAMEMODE.LifeStatsEndTime = CurTime() + GAMEMODE.LifeStatsLifeTime
	GAMEMODE.LifeStatsBarricadeDamage = barricadedamage
	GAMEMODE.LifeStatsEnemyDamage = humandamage
	GAMEMODE.LifeStatsEnemyKilled = brainseaten
end)

net.Receive("zs_lifestatsbd", function(length)
	local barricadedamage = net.ReadUInt(24)

	GAMEMODE.LifeStatsEndTime = CurTime() + GAMEMODE.LifeStatsLifeTime
	GAMEMODE.LifeStatsBarricadeDamage = barricadedamage
end)

net.Receive("zs_lifestatshd", function(length)
	local humandamage = net.ReadUInt(24)

	GAMEMODE.LifeStatsEndTime = CurTime() + GAMEMODE.LifeStatsLifeTime
	GAMEMODE.LifeStatsEnemyDamage = humandamage
end)

net.Receive("zs_lifestatskills", function(length)
	local kills = net.ReadUInt(16)

	GAMEMODE.LifeStatsEndTime = CurTime() + GAMEMODE.LifeStatsLifeTime
	GAMEMODE.LifeStatsEnemyKilled = kills
end)

net.Receive("zs_honmention", function(length)
	local pl = net.ReadEntity()
	local mentionid = net.ReadUInt(8)
	local etc = net.ReadInt(32)

	if pl:IsValid() then
		gamemode.Call("AddHonorableMention", pl, mentionid, etc)
	end
end)

net.Receive("zs_currenttransmitters", function(length)
	local objteams = {}
	for i=1, GAMEMODE.MaxTransmitters do
		objteams[i] = net.ReadInt(4)
	end
	gamemode.Call("UpdateTransmitterTeamCounter",objteams)
end)

net.Receive("zs_wavestart", function(length)
	local wave = net.ReadInt(16)
	local time = net.ReadFloat()

	gamemode.Call("SetWave", wave)
	gamemode.Call("SetWaveEnd", time)
	GAMEMODE.RoundEndCamPosition = nil
	if wave == GAMEMODE:GetNumberOfWaves() then
		GAMEMODE:CenterNotify({killicon = "default"}, {font = "ZSHUDFont"}, " ", COLOR_RED, translate.Get("final_wave"), {killicon = "default"})
		GAMEMODE:CenterNotify(translate.Get("final_wave_sub"))
	else
		GAMEMODE:CenterNotify({killicon = "default"}, {font = "ZSHUDFont"}, " ", COLOR_RED, translate.Format("wave_x_has_begun", wave), {killicon = "default"})
	end
	local banditintros = {"npc/combine_soldier/vo/containmentproceeding.wav", "npc/combine_soldier/vo/stayalertreportsightlines.wav", "npc/combine_soldier/vo/extractorislive.wav","npc/combine_soldier/vo/readyweaponshostilesinbound.wav","npc/overwatch/radiovoice/recalibratesocioscan.wav","npc/overwatch/radiovoice/beginscanning10-0.wav" }
	local humanintros = {"vo/npc/male01/leadtheway01.wav", "vo/canals/matt_goodluck.wav", "vo/npc/Barney/ba_letsdoit.wav","vo/trainyard/ba_goodluck01.wav","vo/Streetwar/Alyx_gate/al_readywhenyou.wav"}
	if LocalPlayer() and IsValid(LocalPlayer()) and LocalPlayer():IsPlayer() then
		if LocalPlayer():Team() == TEAM_BANDIT then
		--surface_PlaySound("ambient/creatures/town_zombie_call1.wav")
			surface.PlaySound(banditintros[math.random(#banditintros)])
		elseif LocalPlayer():Team() == TEAM_HUMAN then
			surface.PlaySound(humanintros[math.random(#humanintros)])
		end
	else
		surface_PlaySound("ambient/levels/streetwar/city_battle"..math.random(6, 9)..".wav")--"ambient/creatures/town_zombie_call1.wav"
	end
end)

net.Receive("zs_suddendeath", function(length)
	local check = net.ReadBool()
	if check then
		GAMEMODE:CenterNotify({killicon = "default"}, {font = "ZSHUDFont"}, " ", COLOR_RED, translate.Format("sudden_death_start"), {killicon = "default"})
		GAMEMODE.IsInSuddenDeath = true
		gamemode.Call("RestartBeats")
		timer.Simple(0.1, function() surface_PlaySound("ambient/energy/whiteflash.wav")end)
	else
		GAMEMODE.IsInSuddenDeath = false
	end
end)

net.Receive("zs_waveend", function(length)
	local wave = net.ReadInt(16)
	local time = net.ReadFloat()
	local winner = net.ReadUInt(8)
	--GAMEMODE.IsInSuddenDeath = false
	gamemode.Call("RestartBeats")
	if winner == TEAM_HUMAN or winner == TEAM_BANDIT then
		GAMEMODE:CenterNotify({killicon = "default"},{font = "ZSHUDFont"}, " ", team.GetColor(winner), translate.ClientFormat(pl, "win",translate.GetTranslatedTeamName(winner,pl)) ,{killicon = "default"})
	else
		GAMEMODE:CenterNotify({killicon = "default"},{font = "ZSHUDFont"}, " ", COLOR_DARKGRAY, translate.ClientGet(pl, "draw"),{killicon = "default"})
	end
	gamemode.Call("SetWaveStart", time)
	GAMEMODE.ClassicModePurchasedThisWave = {}
	if wave < GAMEMODE:GetNumberOfWaves() and wave > 0 then
		GAMEMODE:CenterNotify(COLOR_RED, {font = "ZSHUDFont"}, translate.Format("wave_x_is_over", wave))
		timer.Simple(0.1, function() surface_PlaySound("ambient/atmosphere/cave_hit"..math.random(6)..".wav") end)
	end	
end)

net.Receive("zs_gamestate", function(length)
	local wave = net.ReadInt(16)
	local wavestart = net.ReadFloat()
	local waveend = net.ReadFloat()
	
	gamemode.Call("SetWave", wave)
	gamemode.Call("SetWaveStart", wavestart)
	gamemode.Call("SetWaveEnd", waveend)
end)

net.Receive("zs_centernotify", function(length)
	local tab = net.ReadTable()

	GAMEMODE:CenterNotify(unpack(tab))
end)

net.Receive("zs_topnotify", function(length)
	local tab = net.ReadTable()

	GAMEMODE:TopNotify(unpack(tab))
end)

net.Receive("zs_gamemodecall", function(length)
	gamemode.Call(net.ReadString())
end)

net.Receive("zs_roundendcampos", function(length)
	GAMEMODE.RoundEndCamPosition = net.ReadVector()
end)

net.Receive("zs_endround", function(length)
	local winner = net.ReadUInt(8)
	local nextmap = net.ReadString()

	gamemode.Call("EndRound", winner, nextmap)
end)

net.Receive("zs_wavewonby", function(length)

end)

-- Temporary fix
function render.DrawQuadEasy(pos, dir, xsize, ysize, color, rotation)
	xsize = xsize / 2
	ysize = ysize / 2

	local ang = dir:Angle()

	if rotation then
		ang:RotateAroundAxis(ang:Forward(), rotation)
	end

	local upoffset = ang:Up() * ysize
	local rightoffset = ang:Right() * xsize

	render.DrawQuad(pos - upoffset - rightoffset, pos - upoffset + rightoffset, pos + upoffset + rightoffset, pos + upoffset - rightoffset, color)
end
