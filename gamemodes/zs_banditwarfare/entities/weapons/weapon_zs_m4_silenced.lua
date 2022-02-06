AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_stalkersilenced_name"
	SWEP.TranslateDesc = "weapon_stalkersilenced_desc"
	SWEP.Slot = 2
	SWEP.SlotPos = 0

	SWEP.WElements = {
		["techpart1"] = { type = "Model", model = "models/props_lab/eyescanner.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7.002, 1.667, -3.668), angle = Angle(-4.384, -94.143, 81.061), size = Vector(0.128, 0.128, 0.128), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["techpart2"] = { type = "Model", model = "models/props_lab/reciever01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "techpart1", pos = Vector(0, 0, -0.39), angle = Angle(0, 0, 0), size = Vector(0.104, 0.104, 0.104), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["techpart3"] = { type = "Model", model = "models/props_lab/reciever01d.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "techpart1", pos = Vector(0, 1.08, 2.438), angle = Angle(0, 0, 90), size = Vector(0.101, 0.239, 0.166), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["techpart4"] = { type = "Model", model = "models/props_pipes/interiorpipecluster02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "techpart1", pos = Vector(0.17, 0.363, 4.763), angle = Angle(0, -86.491, 4.88), size = Vector(0.041, 0.041, 0.041), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.VElements = {
		["techpart1"] = { type = "Model", model = "models/props_lab/eyescanner.mdl", bone = "v_weapon.m4_Parent", rel = "", pos = Vector(0.159, -3.504, -3.695), angle = Angle(180, 1.34, -180), size = Vector(0.128, 0.128, 0.128), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["techpart2"] = { type = "Model", model = "models/props_lab/reciever01a.mdl", bone = "v_weapon.m4_Parent", rel = "techpart1", pos = Vector(0, 0, -0.39), angle = Angle(0, 0, 0), size = Vector(0.104, 0.104, 0.104), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["techpart3"] = { type = "Model", model = "models/props_lab/reciever01d.mdl", bone = "v_weapon.m4_Parent", rel = "techpart1", pos = Vector(0, 1.08, 2.438), angle = Angle(0, 0, 90), size = Vector(0.101, 0.239, 0.166), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["techpart4"] = { type = "Model", model = "models/props_pipes/interiorpipecluster02a.mdl", bone = "v_weapon.m4_Parent", rel = "techpart1", pos = Vector(0.17, 0.363, 4.763), angle = Angle(0, -86.491, 4.88), size = Vector(0.041, 0.041, 0.041), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "v_weapon.m4_Parent"
	SWEP.HUD3DPos = Vector(-0.75, -5.5, -5.2)
	SWEP.HUD3DAng = Angle(0, -8, 0)
	SWEP.HUD3DScale = 0.02
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "smg"

SWEP.ViewModel = "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel = "models/weapons/w_rif_m4a1_silencer.mdl"
SWEP.UseHands = true
SWEP.Primary.Sound = Sound("Weapon_m4a1.Silenced")
SWEP.Primary.Damage = 10
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.074

SWEP.Primary.ClipSize = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "ar2"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SMG1

SWEP.ConeMax = 0.034
SWEP.ConeMin = 0.003
SWEP.Recoil = 0.33
SWEP.MovingConeOffset = 0.12
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
SWEP.WalkSpeed = SPEED_FAST
SWEP.IronSightsPos = Vector(-8.2, 10, -1)
SWEP.IronSightsAng = Vector(1.261, -1.364, -4.441)

SWEP.IdleActivity 		   = ACT_VM_IDLE_SILENCED

SWEP.m_IsStealthWeapon = true
SWEP.StealthMeterTick = 0.05
SWEP.LastStealthMeterCheck = 0

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 5, "StealthWepBlend")
	self:NetworkVar("Float", 6, "StealthMeter")
	if self.BaseClass.SetupDataTables then
		self.BaseClass.SetupDataTables(self)
	end
end

function SWEP:SendWeaponAnimation()
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK_SILENCED)
	self:GetOwner():GetViewModel():SetPlaybackRate(self.FireAnimSpeed)
end

function SWEP:Deploy()
	self:DrawShadow(false)
	if self:GetOwner() and self:GetOwner():IsPlayer() and self:GetOwner():Alive() then
		self:GetOwner():DrawShadow(false)
	end
	self:SetStealthWepBlend(1)
	self:SetStealthMeter(0)
	self:SendWeaponAnim(ACT_VM_DRAW_SILENCED)
	return self.BaseClass.Deploy(self)
end

function SWEP:Holster(wep)
	if self:GetOwner() and self:GetOwner():IsPlayer() then
		self:GetOwner():DrawShadow(true)
	end
	self:DrawShadow(true)
	return self.BaseClass.Holster(self)
end

function SWEP:SendReloadAnimation()
	self:SendWeaponAnim(ACT_VM_RELOAD_SILENCED)
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end 
	self:SetStealthMeter(math.Clamp(self:GetStealthMeter()-10,0,100))
	self.LastStealthMeterCheck = CurTime()+1
	self.BaseClass.PrimaryAttack(self)		
end

function SWEP:Think()
	local curTime = CurTime()
	local moverate = math.Clamp(self:GetOwner():GetVelocity():Length() / self.WalkSpeed, 0,1)*-3+1
	if curTime >= self.LastStealthMeterCheck+self.StealthMeterTick then
		self:SetStealthMeter(math.Clamp(self:GetStealthMeter()+moverate,0,100))
		self.LastStealthMeterCheck = curTime
	end
	self:SetStealthWepBlend(1-math.Clamp(self:GetStealthMeter()/100,0,1)*0.85)
	self.BaseClass.Think(self)	
end

if CLIENT then
	local texGradDown = surface.GetTextureID("VGUI/gradient_down")
	function SWEP:DrawHUD()
		local screenscale = BetterScreenScale()
		local scrW = ScrW()
		local scrH = ScrH()
		local wid = 200
		local hei = 30
		local x, y = (ScrW()- wid)*0.5 , (ScrH() - hei)*0.75
		local metersize = math.Clamp(self:GetStealthMeter()/100,0,1)
		if 0.05 < metersize then
			surface.SetDrawColor(5, 5, 5, 180)
			surface.DrawRect(x, y, wid, hei)

			surface.SetDrawColor(155, 155, 155, 180)
			surface.SetTexture(texGradDown)
			surface.DrawTexturedRect(x, y, metersize * wid, hei)

			surface.SetDrawColor(155, 155, 155, 180)
			surface.DrawOutlinedRect(x, y, wid, hei)

			draw.DrawText( translate.Get( "weapon_stalkersilenced_stealthmeter" ), "ZSHUDFontSmallestNS", x+wid/2, y, COLOR_GRAY, TEXT_ALIGN_CENTER )
		end
		self.BaseClass.DrawHUD(self)	
	end
end