local draw_SimpleText = draw.SimpleText
local draw_DrawText = draw.DrawText
local surf_DrawRect = surface.DrawRect

local FontBlurX = 0
local FontBlurX2 = 0
local FontBlurY = 0
local FontBlurY2 = 0

timer.Create("fontblur", 0.1, 0, function()
	FontBlurX = math.random(-8, 8)
	FontBlurX2 = math.random(-8, 8)
	FontBlurY = math.random(-8, 8)
	FontBlurY2 = math.random(-8, 8)
end)

local color_blur1 = Color(60, 60, 60, 220)
local color_blur2 = Color(40, 40, 40, 140)
function draw.SimpleTextBlur(text, font, x, y, col, xalign, yalign)
	color_blur1.a = col.a * 0.85
	color_blur2.a = col.a * 0.55
	draw_SimpleText(text, font, x + FontBlurX, y + FontBlurY, color_blur1, xalign, yalign)
	draw_SimpleText(text, font, x + FontBlurX2, y + FontBlurY2, color_blur2, xalign, yalign)
	draw_SimpleText(text, font, x, y, col, xalign, yalign)
end

function draw.DrawTextBlur(text, font, x, y, col, xalign)
	color_blur1.a = col.a * 0.85
	color_blur2.a = col.a * 0.55
	draw_DrawText(text, font, x + FontBlurX, y + FontBlurY, color_blur1, xalign)
	draw_DrawText(text, font, x + FontBlurX2, y + FontBlurY2, color_blur2, xalign)
	draw_DrawText(text, font, x, y, col, xalign)
end

local colBlur = Color(0, 0, 0)
function draw.SimpleTextBlurry(text, font, x, y, col, xalign, yalign)
	colBlur.r = col.r
	colBlur.g = col.g
	colBlur.b = col.b
	colBlur.a = col.a * math.Rand(0.35, 0.6)

	draw_SimpleText(text, font.."Blur", x, y, colBlur, xalign, yalign)
	draw_SimpleText(text, font, x, y, col, xalign, yalign)
end

function draw.DrawTextBlurry(text, font, x, y, col, xalign)
	colBlur.r = col.r
	colBlur.g = col.g
	colBlur.b = col.b
	colBlur.a = col.a * math.Rand(0.35, 0.6)

	draw_DrawText(text, font.."Blur", x, y, colBlur, xalign)
	draw_DrawText(text, font, x, y, col, xalign)
end

local colBG = Color(16, 16, 16, 90)
local colRed = Color(220, 0, 0, 230)
local colYellow = Color(220, 220, 0, 230)
local colWhite = Color(220, 220, 220, 230)
local function GetAmmoColor(clip, maxclip)
	local colAmmo = Color(255, 255, 255, 230)
	if clip == 0 then
		colAmmo.r = 255 colAmmo.g = 0 colAmmo.b = 0
	else
		local sat = clip / maxclip
		colAmmo.r = 255
		colAmmo.g = sat ^ 0.3 * 255
		colAmmo.b = sat * 255
	end
	return colAmmo
end

function surface.DrawSteppedBeam(pos1x, pos1y, pos2x, pos2y, width, vertfirst)
	local halfwid = width/2
	local beamtall = math.abs(pos2y - pos1y)
	local beamwide = math.abs(pos2x - pos1x)
	if (pos1x == pos2x) then
		surf_DrawRect(pos1x-halfwid, math.min(pos1y, pos2y), width, beamtall)
		return
	elseif (pos1y == pos2y) then
		surf_DrawRect(math.min(pos1x,pos2x), pos1y-halfwid, beamwide, width)
		return
	end

	if (!vertfirst) then
		surf_DrawRect(math.min(pos1x,pos2x), math.max(pos1y, pos2y)-halfwid, beamwide, width)
		surf_DrawRect(math.max(pos1x,pos2x)-halfwid, math.min(pos1y, pos2y), width, beamtall)
	else
		surf_DrawRect(math.min(pos1x,pos2x)-halfwid, math.min(pos1y, pos2y), width, beamtall)
		surf_DrawRect(math.min(pos1x,pos2x), math.max(pos1y, pos2y)-halfwid, beamwide, width)
	end
end

function draw.DrawAmmoHud(clip, spare, maxclip, wid, hei, x, y, requiredclip, noclip, onlyclip,lowthreshold, is3d, pos, ang, hud3dscale)
	if requiredclip !=1 then
		clip = math.floor(clip / requiredclip)
		spare = math.floor(spare / requiredclip)
		maxclip = math.ceil(maxclip / requiredclip)
	end
	if is3d then
		cam.Start3D2D(pos, ang, (hud3dscale and hud3dscale or 0.01) / 2)
		draw.RoundedBoxEx(32, x, y, wid, hei, colBG, true, false, true, false)
	else
		draw.RoundedBox(16, x, y, wid, hei, colBG)
	end
	if noclip then
		local font = is3d and "ZS3D2DFontBig" or "ZSHUDFontBig"
		if spare >= 1000 then
			font = is3d and "ZS3D2DFontSmall" or "ZSHUDFontSmall"
		elseif spare >= 100 then
			font = is3d and "ZS3D2DFont" or "ZSHUDFont"
		end
		draw.SimpleTextBlurry(spare,font, x + wid * 0.5, y + hei * 0.5, spare == 0 and colRed or spare <= (lowthreshold and lowthreshold or 100) and colYellow or colWhite, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	elseif onlyclip then
		local font = is3d and "ZS3D2DFontBig" or "ZSHUDFontBig"
		if clip >= 1000 then
			font = is3d and "ZS3D2DFontSmall" or "ZSHUDFontSmall"
		elseif clip >= 100 then
			font = is3d and "ZS3D2DFont" or "ZSHUDFont"
		end
		draw.SimpleTextBlurry(clip, font, x + wid * 0.5, y + hei * 0.5, GetAmmoColor(clip, maxclip), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	else
		local smallfont = is3d and "ZS3D2DFontSmall" or "ZSHUDFontSmall"
		local normalfont = is3d and "ZS3D2DFont" or "ZSHUDFont"
		local bigfont = is3d and "ZS3D2DFontBig" or "ZSHUDFontBig"
		if maxclip > 0 then
			draw.SimpleTextBlurry(spare, spare >= 1000 and smallfont or  normalfont, x + wid * (is3d and 0.5 or 0.75), y + hei * (!is3d and 0.5 or 0.75), spare == 0 and colRed or spare <= maxclip and colYellow or colWhite, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		draw.SimpleTextBlurry(clip, clip >= 100 and  normalfont or bigfont, x + wid * (is3d and 0.5 or (maxclip > 0 and 0.25 or 0.5)), y + hei * (is3d and (maxclip > 0 and 0.3 or 0.5) or 0.5), GetAmmoColor(clip, maxclip), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	if is3d then
		cam.End3D2D()
	end
end