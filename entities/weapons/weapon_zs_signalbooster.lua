AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "신호 증폭기"
	SWEP.Description = "손에 들고 있을 시 더 빠르게 송신기를 점령한다. 또한 송신기 추적장치가 내장되어 있어 송신기의 상황을 파악할 수 있다."

	SWEP.ViewModelFOV = 80

	SWEP.Slot = 4

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

	SWEP.VElements = {
		["element_name++"] = { type = "Model", model = "models/props_rooftop/antenna03a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(0, 0, 4.593), angle = Angle(-0, -34.119, 0), size = Vector(0.056, 0.056, 0.056), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["element_name+"] = { type = "Model", model = "models/props_lab/harddrive02.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(-0.424, 0, 0), angle = Angle(0, 180, 0), size = Vector(0.079, 0.324, 0.28), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["element_name"] = { type = "Model", model = "models/props_lab/keypad.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.704, 2.176, -1.538), angle = Angle(-0.361, -154.907, 180), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["element_name"] = { type = "Model", model = "models/props_lab/keypad.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.654, 2.711, -1.68), angle = Angle(-17.813, 147.498, 180), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["element_name+"] = { type = "Model", model = "models/props_lab/harddrive02.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(-0.424, 0, 0), angle = Angle(0, 180, 0), size = Vector(0.079, 0.324, 0.28), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["element_name++"] = { type = "Model", model = "models/props_rooftop/antenna03a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(0, 0, 4.593), angle = Angle(-0, -34.119, 0), size = Vector(0.056, 0.056, 0.056), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_slam.mdl"
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.WalkSpeed = SPEED_NORMAL

SWEP.HoldType = "slam"
SWEP.DoubleCapSpeed = true

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end


if not CLIENT then return end
function SWEP:DrawHUD()
	for _, ent in pairs(ents.FindByClass("prop_obj_sigil")) do
		local teamcolor = nil
		if ent:GetSigilTeam() ~= nil then 
			teamcolor = team.GetColor(ent:GetSigilTeam())
		end
		
		self:DrawTarget(ent,32,0,teamcolor)
	end
	if self.BaseClass.DrawHUD then
		self.BaseClass.DrawHUD(self)
	end
end

local texScope = Material("vgui/hud/autoaim")
function SWEP:DrawTarget(tgt, size, offset, color)
	local scrpos = tgt:GetPos():ToScreen()
	scrpos.x = math.Clamp(scrpos.x, size, ScrW() - size)
	scrpos.y = math.Clamp(scrpos.y, size, ScrH() - size)
	--surface.SetMaterial(texScope)
	--surface.DrawTexturedRect( scrpos.x - size, scrpos.y - size, size * 2, size * 2 )
	--surface.DrawCircle(scrpos.x - size, scrpos.y - size, size * 2,255,0,0,150)
	draw.RoundedBox( 10,scrpos.x - size, scrpos.y - size, size * 2, size * 2, color ~= nil and color or COLOR_GREY )
	local text = math.ceil(self.Owner:GetPos():Distance(tgt:GetPos()))
	local w, h = surface.GetTextSize(text)
	--surface.SetFont("ZSHUDFontSmall")
	--surface.DrawText(text)
	draw.SimpleText(text, "ZSHUDFontSmallest", scrpos.x - size- w/2,scrpos.y - size+ (offset * size) - h/2)
end