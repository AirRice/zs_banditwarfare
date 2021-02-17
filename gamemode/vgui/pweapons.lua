
local Features = {
{"WalkSpeed", "이동속도"},
{"MeleeDamage", "대미지",1},
{"MeleeRange", "사정거리"},

{"ClipSize", "탄창 용량", 1, "Primary"},
{"DefaultClip", "기본 지급 탄약", 1, "Primary"},
{"Damage", "대미지", 1, "Primary"},
{"NumShots", "탄환 수", 1, "Primary"},
{"Delay", "발사 딜레이", 0.001, "Primary"}
}

function GM:MakeWeaponInfo(swep)
	local wid, hei = 400, 350
	local scrwid = ScrW()
	local scrhei = ScrH()
	local frame = vgui.Create("DFrame")
	frame:ShowCloseButton(false)
	frame:SetDeleteOnClose(true)
	frame:SetSize(wid, hei)
	frame:SetPos(scrwid*0.15, ScrH()-hei-40) 
	frame:SetTitle(" ")
	frame:DockPadding(8, 4, 8, 4)
	self.m_weaponInfoFrame = frame

	if not swep then return end
	local sweptable = weapons.GetStored(swep)
	if not sweptable then return end

	local title = EasyLabel(frame, sweptable.TranslateName and translate.Get(sweptable.TranslateName) or swep, "ZSHUDFontSmall", COLOR_GRAY)
	title:SetContentAlignment(8)
	title:Dock(TOP)

	local text = ""

	if sweptable.TranslateDesc then
		text = translate.Get(sweptable.TranslateDesc)
	end
	
	for i, featuretab in ipairs(Features) do
		local touse
		if featuretab[4] then
			touse = sweptable[ featuretab[4] ]
		else
			touse = sweptable
		end
		local value = touse[ featuretab[1] ]
		if value and value > 0 then
			text = text.."\n"..featuretab[2]..": "..value
		end
	end

	local desc = vgui.Create("DLabel", frame)
	desc:SetContentAlignment(7)
	desc:SetFont("ZSHUDFontSmallest")
	desc:SetText(text)
	desc:SetMultiline(true)
	desc:SetWrap(true)
	desc:Dock(FILL)
	
	frame:SizeToContents()
end
