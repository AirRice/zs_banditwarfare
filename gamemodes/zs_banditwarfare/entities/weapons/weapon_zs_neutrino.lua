AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_neutrinoLMG_name"
	SWEP.TranslateDesc = "weapon_neutrinoLMG_desc"
	SWEP.Slot = 2
	SWEP.SlotPos = 0
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "Base"
	SWEP.HUD3DPos = Vector(7.791, -2.597, -7.792)
	SWEP.HUD3DScale = 0.04
	SWEP.VElements = {
		--[[["backcover+"] = { type = "Model", model = "models/props_combine/breenconsole.mdl", bone = "Base", rel = "", pos = Vector(0.529, 9.041, -9.542), angle = Angle(180, 0, -90), size = Vector(0.275, 0.261, 0.202), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["backcover+++"] = { type = "Model", model = "models/props_combine/combine_teleportplatform.mdl", bone = "Base", rel = "backcover+", pos = Vector(0, -28.847, 7.265), angle = Angle(90, 90, 0), size = Vector(0.206, 0.206, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["ring1+"] = { type = "Model", model = "models/props_lab/teleportring.mdl", bone = "Base", rel = "backcover+", pos = Vector(0, -10.032, 8.378), angle = Angle(63.763, 0, -90), size = Vector(0.372, 0.372, 0.912), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["train1+"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "Base", rel = "backcover+", pos = Vector(5, -24, 3.309), angle = Angle(-120, 0, 0), size = Vector(0.086, 0.065, 0.086), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["train1"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "Base", rel = "backcover+", pos = Vector(0, -24, 12), angle = Angle(0, 0, 0), size = Vector(0.086, 0.065, 0.086), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["train1++"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "Base", rel = "backcover+", pos = Vector(-5, -24, 3.299), angle = Angle(120, 0, 0), size = Vector(0.086, 0.065, 0.086), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["backcover"] = { type = "Model", model = "models/props_combine/combine_booth_short01a.mdl", bone = "Base", rel = "backcover+", pos = Vector(0, -10.66, 5.015), angle = Angle(17.34, -90, 0), size = Vector(0.164, 0.059, 0.149), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["backcover++"] = { type = "Model", model = "models/props_lab/labpart.mdl", bone = "Base", rel = "backcover+", pos = Vector(0.097, -3.138, 5.784), angle = Angle(180, -90, 0), size = Vector(1.133, 0.864, 1.133), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Nozzle"] = { type = "Model", model = "models/props_citizen_tech/firetrap_propanecanister01a.mdl", bone = "Base", rel = "backcover+", pos = Vector(0, -21.872, 8.322), angle = Angle(-90, 90, 0), size = Vector(0.492, 0.492, 0.409), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["ring1"] = { type = "Model", model = "models/props_lab/teleportring.mdl", bone = "Base", rel = "backcover+", pos = Vector(0, -19.664, 8.378), angle = Angle(180, 0, -90), size = Vector(0.372, 0.372, 1.506), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }]]
		["backcover+"] = { type = "Model", model = "models/props_combine/breenconsole.mdl", bone = "Base", rel = "", pos = Vector(0.529, 9.041, -9.542), angle = Angle(180, 0, -90), size = Vector(0.275, 0.261, 0.202), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["backcover+++"] = { type = "Model", model = "models/props_combine/combine_teleportplatform.mdl", bone = "Base", rel = "backcover+", pos = Vector(0, -25.903, 7.265), angle = Angle(90, 90, 0), size = Vector(0.115, 0.115, 0.115), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["ring1+"] = { type = "Model", model = "models/props_lab/teleportring.mdl", bone = "Base", rel = "backcover+", pos = Vector(-0.461, -9.105, 7.098), angle = Angle(9.607, 0, -90), size = Vector(0.219, 0.219, 0.219), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["train1+"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "Base", rel = "backcover+", pos = Vector(5, -13, 3.5), angle = Angle(-120, 0, 0), size = Vector(0.07, 0.039, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["train1"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "Base", rel = "backcover+", pos = Vector(0, -13, 12), angle = Angle(0, 0, 0), size = Vector(0.07, 0.039, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["train1++"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "Base", rel = "backcover+", pos = Vector(-5, -13, 3.5), angle = Angle(120, 0, 0), size = Vector(0.07, 0.039, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["backcover"] = { type = "Model", model = "models/props_combine/combine_booth_short01a.mdl", bone = "Base", rel = "backcover+", pos = Vector(0, -6.968, 4.618), angle = Angle(2.783, -90, 0), size = Vector(0.104, 0.052, 0.104), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["backcover++"] = { type = "Model", model = "models/props_lab/labpart.mdl", bone = "Base", rel = "backcover+", pos = Vector(0.097, -3.138, 5.784), angle = Angle(180, -90, 0), size = Vector(0.975, 0.975, 0.975), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Nozzle"] = { type = "Model", model = "models/props_citizen_tech/firetrap_propanecanister01a.mdl", bone = "Base", rel = "backcover+", pos = Vector(0, -15.318, 7.374), angle = Angle(-90, 90, 0), size = Vector(0.207, 0.207, 0.172), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["ring1"] = { type = "Model", model = "models/props_lab/teleportring.mdl", bone = "Base", rel = "backcover+", pos = Vector(0, -15.254, 7.098), angle = Angle(180, 0, -90), size = Vector(0.219, 0.219, 0.219), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["backcover+"] = { type = "Model", model = "models/props_combine/breenconsole.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.947, 2.385, 1.735), angle = Angle(164.147, -74.767, 0), size = Vector(0.275, 0.261, 0.202), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["backcover+++"] = { type = "Model", model = "models/props_combine/combine_teleportplatform.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "backcover+", pos = Vector(0, -25.903, 7.265), angle = Angle(90, 90, 0), size = Vector(0.115, 0.115, 0.115), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["ring1+"] = { type = "Model", model = "models/props_lab/teleportring.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "backcover+", pos = Vector(-0.461, -9.105, 7.098), angle = Angle(9.607, 0, -90), size = Vector(0.219, 0.219, 0.219), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["train1+"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "backcover+", pos = Vector(5, -13, 3.5), angle = Angle(-120, 0, 0), size = Vector(0.07, 0.039, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["train1"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "backcover+", pos = Vector(0, -13, 12), angle = Angle(0, 0, 0), size = Vector(0.07, 0.039, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["train1++"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "backcover+", pos = Vector(-5, -13, 3.5), angle = Angle(120, 0, 0), size = Vector(0.07, 0.039, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["backcover"] = { type = "Model", model = "models/props_combine/combine_booth_short01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "backcover+", pos = Vector(0, -6.968, 4.618), angle = Angle(2.783, -90, 0), size = Vector(0.104, 0.052, 0.104), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["backcover++"] = { type = "Model", model = "models/props_lab/labpart.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "backcover+", pos = Vector(0.097, -3.138, 5.784), angle = Angle(180, -90, 0), size = Vector(0.975, 0.975, 0.975), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Nozzle"] = { type = "Model", model = "models/props_citizen_tech/firetrap_propanecanister01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "backcover+", pos = Vector(0, -15.318, 7.374), angle = Angle(-90, 90, 0), size = Vector(0.207, 0.207, 0.172), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["ring1"] = { type = "Model", model = "models/props_lab/teleportring.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "backcover+", pos = Vector(0, -15.254, 7.098), angle = Angle(180, 0, -90), size = Vector(0.219, 0.219, 0.219), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.ViewModelFlip = false
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = Model( "models/weapons/c_physcannon.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_physics.mdl" )
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = true

SWEP.ReloadDelay = 0.15

SWEP.ViewModelBoneMods = {
	["Base"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

sound.Add( {
	name = "Loop_Neutrino_Charging",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 90,
	pitch = 130,
	sound = "weapons/gauss/chargeloop.wav"
} )
sound.Add( {
	name = "Loop_Neutrino_Firing",
	channel = CHAN_STATIC,
	volume = 0.6,
	level = 75,
	pitch = 115,
	sound = "weapons/smg1/smg1_fire1.wav"
} )

SWEP.ReloadSound = Sound("weapons/ar2/ar2_reload_push.wav")
SWEP.Primary.Sound = Sound("Loop_Neutrino_Firing")
SWEP.Recoil = 0.2
SWEP.Primary.Damage = 8
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.17

SWEP.Primary.ClipSize = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pulse"
SWEP.Primary.DefaultClip = 200

SWEP.ConeMax = 0.165
SWEP.ConeMin = 0.011

-- 에임이 늘어나는 단위
SWEP.AimExpandUnit = 0.006

-- 에임이 늘어난 상태가 유지되는 기간
SWEP.AimExpandStayDuration = 0.01

-- 에임이 줄어드는 단위
SWEP.AimCollapseUnit = 0.2

SWEP.WalkSpeed = SPEED_SLOWEST
SWEP.TracerName = "Ar2Tracer"
SWEP.PlayCharge = false
SWEP.HasNoClip = true
SWEP.LowAmmoThreshold = 100
function SWEP:SetIronsights()
end

function SWEP:Reload()
end

function SWEP:PrimaryAttack()
	if self:CanPrimaryAttack() then
		if ( self.Weapon:Ammo1() <= 0 ) then 
			self:EmitSound("buttons/combine_button_locked.wav")
			self:SetNextPrimaryFire(CurTime() + 0.5)
			self:SetDTInt(4, 0)
		return end
		self:EmitSound(self.Primary.Sound)
		self:ShootBullets(self.Primary.Damage, self.Primary.NumShots, self:GetCone())
		self.Owner:RemoveAmmo(1, self.Weapon:GetPrimaryAmmoType() )
		self.IdleAnimation = CurTime() + self:SequenceDuration()
		local combo = self:GetDTInt(4)
		self:SetNextPrimaryFire(CurTime() + math.max(0.035, self.Primary.Delay * (1 - combo / 50)))
		self:SetDTInt(4, combo + 1)
	end
end
function SWEP:Think()
	local owner = self.Owner
	if owner:KeyDown(IN_ATTACK) and self:CanPrimaryAttack() then 
		if self:Ammo1()<=0 then return end
		self:EmitSound("Loop_Neutrino_Charging")
		if CLIENT then
			self.VElements["ring1"].angle.x = math.Approach(self.VElements["ring1"].angle.x, self.VElements["ring1"].angle.x+2, FrameTime()*120)
			self.VElements["ring1+"].angle.x = math.Approach(self.VElements["ring1+"].angle.x, self.VElements["ring1+"].angle.x+3, FrameTime()*180)
		end
	elseif CLIENT then
		self.VElements["ring1"].angle.x = math.Approach(self.VElements["ring1"].angle.x, math.ceil(self.VElements["ring1"].angle.x/180)*180, FrameTime()*150)
        self.VElements["ring1+"].angle.x = math.Approach(self.VElements["ring1+"].angle.x, math.ceil(self.VElements["ring1+"].angle.x/180)*180, FrameTime()*200)
	elseif not owner:KeyDown(IN_ATTACK) or not owner:Alive() then
		self:SetDTInt(4, 0)
		self:StopSound("Loop_Neutrino_Charging")
	end
	if owner:KeyReleased(IN_ATTACK) then
		owner:EmitSound("weapons/slam/mine_mode.wav")
	end
	if self.BaseClass.Think then
		self.BaseClass.Think(self)
	end
end
function SWEP:OnRemove()
	self:StopSound("Loop_Neutrino_Charging")
end
function SWEP:CanPrimaryAttack()
	return true
end