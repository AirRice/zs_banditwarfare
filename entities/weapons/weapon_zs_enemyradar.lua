AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "생체 탐지기"
	SWEP.Description = "적의 위치를 10초마다 한 번 보여준다."

	SWEP.ViewModelFOV = 70

	SWEP.Slot = 4

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/props_lab/harddrive02.mdl", bone = "v_weapon.c4", rel = "", pos = Vector(-2.47, -0.002, -0), angle = Angle(0, 0, 0), size = Vector(0.597, 0.481, 0.337), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+++"] = { type = "Model", model = "models/props_lab/generatorconsole.mdl", bone = "v_weapon.c4", rel = "base", pos = Vector(1.47, 0.127, -1.295), angle = Angle(0, 0, -87.741), size = Vector(0.09, 0.09, 0.09), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/props/cs_office/tv_plasma.mdl", bone = "v_weapon.c4", rel = "base", pos = Vector(-0.267, -0.809, 0.991), angle = Angle(-27.102, 90, 0), size = Vector(0.192, 0.192, 0.192), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base++"] = { type = "Model", model = "models/props_lab/tpswitch.mdl", bone = "v_weapon.c4", rel = "base", pos = Vector(-4.09, -1.933, -1.458), angle = Angle(0, 90, 0), size = Vector(0.123, 0.123, 0.123), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/props_lab/harddrive02.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.191, 6.157, -0.682), angle = Angle(0, -87.268, -126.991), size = Vector(0.572, 0.3, 0.301), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+++"] = { type = "Model", model = "models/props_lab/generatorconsole.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(1.47, 0.795, -1.532), angle = Angle(0, 0, -87.741), size = Vector(0.09, 0.09, 0.09), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/props/cs_office/tv_plasma.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-0.267, -0.327, 0.991), angle = Angle(-27.102, 90, 0), size = Vector(0.192, 0.192, 0.192), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base++"] = { type = "Model", model = "models/props_lab/tpswitch.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-4.09, -1.693, -1.458), angle = Angle(0, 90, 0), size = Vector(0.123, 0.123, 0.123), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/weapons/cstrike/c_c4.mdl"
SWEP.WorldModel = "models/weapons/w_slam.mdl"
SWEP.ModelScale = 0.5
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
SWEP.ScanDelay = 13
SWEP.LastScan = 0
SWEP.targets = {}
function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

if not CLIENT then return end
function SWEP:DrawHUD()
	if GAMEMODE:GetWaveActive() then
	if self.LastScan + self.ScanDelay <= CurTime() then
		self.targets = {}
		for _, ent in pairs(player.GetAll()) do
			if self.Owner:IsPlayer() and ent:Team() ~= self.Owner:Team() and (ent:Team() == TEAM_HUMAN or ent:Team() == TEAM_BANDIT) and ent:Alive() then 
				table.insert(self.targets,ent:GetPos())
			end
		end
		self.LastScan = CurTime()
		surface.PlaySound("npc/combine_gunship/gunship_ping_search.wav")
	end
	for _, pos in pairs(self.targets) do
		self:DrawTarget(pos,18,0)
	end
	local scrW = ScrW()
	local scrH = ScrH()
	local width = 200
	local height = 20
	local x = scrW / 2 - width / 2
	local y = scrH / 2 - height / 2 + 30
	local ratio = (CurTime() - self.LastScan) / self.ScanDelay
	surface.SetDrawColor(Color(0, 0, 255, 80))
	surface.DrawOutlinedRect(x - 1, y - 1, width + 2, height + 2)
	draw.RoundedBox(0, x, y, width*ratio, height, Color(255, 0, 0, 80))
	end

	if self.BaseClass.DrawHUD then
		self.BaseClass.DrawHUD(self)
	end
end

local texScope = Material("vgui/hud/autoaim")
function SWEP:DrawTarget(tgt, size, offset)
	local scrpos = tgt:ToScreen()
	scrpos.x = math.Clamp(scrpos.x, size, ScrW() - size)
	scrpos.y = math.Clamp(scrpos.y, size, ScrH() - size)
	surface.DrawCircle(scrpos.x - size, scrpos.y - size, size * 2,255,0,0,150)
	local text = math.ceil(self.Owner:GetPos():Distance(tgt))
	local w, h = surface.GetTextSize(text)
	--surface.SetFont("ZSHUDFontSmall")
	--surface.DrawText(text)
	draw.SimpleText(text, "ZSHUDFontSmallest", scrpos.x - size- w/2,scrpos.y - size+ (offset * size) - h/2)
end