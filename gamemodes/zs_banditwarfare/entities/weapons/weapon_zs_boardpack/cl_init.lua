include("shared.lua")

SWEP.TranslateName = "weapon_boardpack_name"
SWEP.TranslateDesc = "weapon_boardpack_desc"
SWEP.ViewModelFOV = 45
SWEP.ViewModelFlip = false
SWEP.Slot = 4
SWEP.SlotPos = 0

SWEP.ShowWorldModel = false

SWEP.VElements = {
	["base"] = { type = "Model", model = "models/props_debris/wood_board05a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.004, 6.316, -5.428), angle = Angle(7.9, -2.475, -24.5), size = Vector(0.27, 0.27, 0.27), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["base"] = { type = "Model", model = "models/props_debris/wood_board06a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.675, 2.596, -6.753), angle = Angle(180, 66.623, -1.17), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

function SWEP:Initialize()
	self:SetDeploySpeed(1.1)
	if self.BaseClass.Initialize then
		self.BaseClass.Initialize(self)
	end
end

function SWEP:GetViewModelPosition(pos, ang)
	if self:GetPrimaryAmmoCount() <= 0 then
		return pos + ang:Forward() * -256, ang
	end

	return pos, ang
end
