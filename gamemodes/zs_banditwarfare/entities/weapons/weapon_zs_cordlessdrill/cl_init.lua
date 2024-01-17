include("shared.lua")

SWEP.TranslateName = "weapon_drill_name"
SWEP.TranslateDesc = "weapon_drill_desc"
SWEP.Slot = 1
SWEP.SlotPos = 0

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 60

SWEP.HUD3DBone = "ValveBiped.square"
SWEP.HUD3DPos = Vector(1.1, 0.25, -2)
SWEP.HUD3DScale = 0.015
SWEP.VElements = {
	["barrelbase+"] = { type = "Model", model = "models/props_phx/gears/bevel36.mdl", bone = "ValveBiped.square", rel = "barrelbase", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.072, 0.072, 0.179), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["barrelbase"] = { type = "Model", model = "models/props_c17/canister_propane01a.mdl", bone = "ValveBiped.square", rel = "base", pos = Vector(0, 2.994, -0.156), angle = Angle(180, 0, -77.461), size = Vector(0.108, 0.108, 0.108), color = Color(255, 255, 0, 255), surpresslightning = false, material = "models/props_c17/furnituremetal001a", skin = 0, bodygroup = {} },
	["tip"] = { type = "Model", model = "models/props_phx/rocket1.mdl", bone = "ValveBiped.square", rel = "barrelbase+", pos = Vector(0, 0, 0.260), angle = Angle(0, 0, 0), size = Vector(0.009, 0.009, 0.03), color = Color(60, 60, 60, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
	["barrelbase++"] = { type = "Model", model = "models/xqm/afterburner1.mdl", bone = "ValveBiped.square", rel = "barrelbase", pos = Vector(0, 0, 7.203), angle = Angle(0, 0, 0), size = Vector(0.152, 0.152, 0.123), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 3, bodygroup = {} },
	["base"] = { type = "Model", model = "models/props_phx/empty_barrel.mdl", bone = "ValveBiped.square", rel = "", pos = Vector(0, 0.224, -2.162), angle = Angle(0, 0, 102.647), size = Vector(0.092, 0.107, 0.112), color = Color(255, 255, 0, 255), surpresslightning = false, material = "models/props_c17/furnituremetal001a", skin = 0, bodygroup = {} },
	["handle"] = { type = "Model", model = "models/props_combine/breenpod.mdl", bone = "ValveBiped.square", rel = "base", pos = Vector(0, -0.403, 5.735), angle = Angle(-4.969, 90, 180), size = Vector(0.086, 0.101, 0.086), color = Color(85, 85, 85, 255), surpresslightning = false, material = "models/props_junk/shoe001a", skin = 0, bodygroup = {} },
	["base+"] = { type = "Model", model = "models/props_c17/cashregister01a.mdl", bone = "ValveBiped.square", rel = "base", pos = Vector(0, -0.524, 5.301), angle = Angle(0, 180, 180), size = Vector(0.107, 0.237, 0.114), color = Color(255, 255, 0, 255), surpresslightning = false, material = "models/props_c17/furnituremetal001a", skin = 0, bodygroup = {} },
	["trigger"] = { type = "Model", model = "models/props_c17/furniturebathtub001a.mdl", bone = "ValveBiped.square", rel = "base", pos = Vector(0, -1.785, 0.925), angle = Angle(90, 90, 0), size = Vector(0.039, 0.014, 0.043), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/furnituremetal002a", skin = 0, bodygroup = {} }
}

local ghostlerp = 0
function SWEP:GetViewModelPosition(pos, ang)
	local offset = self.DrillingPos
	local rot = self.DrillingAng

		ang = Angle(ang.pitch, ang.yaw, ang.roll) -- Copy
		local power = 0
		if self:GetDrilling() then
			local delta = math.Clamp(CurTime() - self.LastStartDrilling , 0, self.DrillDelay)
			power = CosineInterpolation(0, 1, delta / self.DrillDelay)
		else
			local delta = math.Clamp(math.Clamp((self.LastStopDrilling - self.LastStartDrilling), 0, self.DrillDelay) - (CurTime() - self.LastStopDrilling), 0, self.DrillDelay)
			power = CosineInterpolation(0, 1, delta / self.DrillDelay)				
		end
		pos = pos + offset.x * power * ang:Right() + offset.y * power * ang:Forward() + offset.z * power * ang:Up()

		ang:RotateAroundAxis(ang:Right(), rot.pitch * power)
		ang:RotateAroundAxis(ang:Up(), rot.yaw * power)
		ang:RotateAroundAxis(ang:Forward(), rot.roll * power)
		
	if self:GetOwner():GetBarricadeGhosting() then
		ghostlerp = math.min(1, ghostlerp + FrameTime() * 4)
	elseif ghostlerp > 0 then
		ghostlerp = math.max(0, ghostlerp - FrameTime() * 5)
	end

	if ghostlerp > 0 then
		pos = pos + 3.5 * ghostlerp * ang:Up()
		ang:RotateAroundAxis(ang:Right(), -30 * ghostlerp)
	end
	local randrange = power * 0.25
	return pos + (self:GetDrilling() and VectorRand(-randrange, randrange) or Vector(0,0,0)),ang
end

function SWEP:PostDrawViewModel(vm, pl, wep)
	local veles = self.VElements
	if self:GetHeatRatio() > 0 then
		local heatcolor = 255 * (1-self:GetHeatRatio())
		local newcol = Color (255, heatcolor, heatcolor, 255)
		veles["barrelbase+"].color = newcol
	end
	if self.BaseClass.PostDrawViewModel then 
		self.BaseClass.PostDrawViewModel(self,vm, pl, wep)
	end
end

local texGradDown = surface.GetTextureID("VGUI/gradient_down")
function SWEP:DrawHUD()
	local scrW = ScrW()
	local scrH = ScrH()
	local width = 200
	local height = 30
	local x, y = ScrW() - width - 32, ScrH() - height - 72

	local ratio = self:GetHeatRatio()

	if ratio > 0 then
		surface.SetDrawColor(5, 5, 5, 180)
		surface.DrawRect(x, y, width, height)
		surface.SetDrawColor(255, 0, 0, 180)
		surface.SetTexture(texGradDown)
		surface.DrawTexturedRect(x, y, width*ratio, height)
		surface.SetDrawColor(255, 0, 0, 180)
		surface.DrawOutlinedRect(x - 1, y - 1, width + 2, height + 2)
	end
	if self.BaseClass.DrawHUD then
		self.BaseClass.DrawHUD(self)
	end
end