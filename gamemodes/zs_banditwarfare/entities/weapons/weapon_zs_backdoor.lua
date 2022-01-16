AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_backdoor_name"
	SWEP.TranslateDesc = "weapon_backdoor_desc"

	SWEP.ViewModelFOV = 70

	SWEP.Slot = 4

	SWEP.ShowViewModel = true
	SWEP.ShowWorldModel = true
	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/props_lab/servers.mdl", bone = "v_weapon.c4", rel = "", pos = Vector(-2.491, -0.461, 3.096), angle = Angle(0, -90, -180), size = Vector(0.128, 0.133, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["cables"] = { type = "Model", model = "models/props_lab/reciever01d.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(2.326, -0.299, 1.702), angle = Angle(84.878, 0, 0), size = Vector(0.834, 0.708, 0.834), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["cables++"] = { type = "Model", model = "models/props_lab/reciever01a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0, 0.156, 3.325), angle = Angle(84.878, 0, 0), size = Vector(0.497, 0.551, 0.531), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["cables+"] = { type = "Model", model = "models/props_rooftop/roof_dish001.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0, 1.31, 1.687), angle = Angle(136.923, 0, 36.886), size = Vector(0.074, 0.074, 0.074), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/props_lab/servers.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.611, 4.288, -2.504), angle = Angle(36.708, 25.784, -7.717), size = Vector(0.128, 0.098, 0.061), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["cables"] = { type = "Model", model = "models/props_lab/reciever01d.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(2.326, -0.299, 1.702), angle = Angle(84.878, 0, 0), size = Vector(0.834, 0.708, 0.834), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["cables++"] = { type = "Model", model = "models/props_lab/reciever01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 0.156, 3.576), angle = Angle(84.878, 0, 0), size = Vector(0.446, 0.446, 0.446), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["cables+"] = { type = "Model", model = "models/props_rooftop/roof_dish001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 1.31, -0.318), angle = Angle(136.923, 0, 36.886), size = Vector(0.074, 0.074, 0.074), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/weapons/cstrike/c_c4.mdl"
SWEP.WorldModel = "models/weapons/w_c4.mdl"
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
SWEP.IsHacking = false
SWEP.IsConsumable = true

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "Charged")
end

function SWEP:CanPrimaryAttack()
	if self:GetOwner():IsHolding() or self:GetOwner():GetBarricadeGhosting() or self.IsHacking then return false end
	return self:GetNextPrimaryFire() <= CurTime()
end
function SWEP:Think()
	if self.IdleAnimation and self.IdleAnimation <= CurTime() then
		self.IdleAnimation = nil
		self:SendWeaponAnim(ACT_VM_IDLE)
	end
end
function SWEP:PrimaryAttack()	
	if self:CanPrimaryAttack() then
		local tr = {}
		tr.start = self:GetOwner():GetShootPos()
		tr.endpos = self:GetOwner():GetShootPos() + 300 * self:GetOwner():GetAimVector()
		tr.filter = {self:GetOwner()}
		local trace = util.TraceLine(tr)
		if trace.Hit and trace.Entity:GetClass() == "prop_obj_transmitter" 
		and self:GetOwner():IsPlayer() and (trace.Entity:GetTransmitterTeam() == TEAM_BANDIT or trace.Entity:GetTransmitterTeam() == TEAM_HUMAN) 
		and trace.Entity:GetTransmitterTeam() ~= self:GetOwner():Team() then
			self:GetOwner():Freeze( true )
			self.IsHacking = true
			self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
			self.Weapon:SetNextPrimaryFire(CurTime()+self:GetOwner():GetViewModel():SequenceDuration()+1)
			timer.Simple(self:GetOwner():GetViewModel():SequenceDuration(), function()
				if SERVER then self:GetOwner():Freeze(false) end
				if self:GetOwner():Alive() then
					self:GetOwner():SetAnimation(PLAYER_ATTACK1)
					self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
					self.IsHacking = false
					self:EmitSound("ambient/machines/thumper_shutdown1.wav")
					if SERVER then 
						trace.Entity:DoDamageComms(self:GetOwner():Team(),self:GetOwner())
						self.Owner:StripWeapon(self:GetClass())
					end
				end
			end)
		else
			
			self:EmitSound("buttons/combine_button_locked.wav")
			self:SetNextPrimaryFire(CurTime() + 0.5)
		end
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

if not CLIENT then return end
--[[
function SWEP:DrawHUD()
	local curtime = CurTime()
	local w, h = ScrW(), ScrH()

	local packup = MySelf.PackUp
	if packup and packup:IsValid() then
		self:DrawPackUpBar(w * 0.5, h * 0.55, 1 - packup:GetTimeRemaining() / packup:GetMaxTime(), packup:GetNotOwner(), screenscale)
	end
	if self.BaseClass.DrawHUD then
		self.BaseClass.DrawHUD(self)
	end
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
end]]
