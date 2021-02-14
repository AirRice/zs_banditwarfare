AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "'뉴트리노' 펄스 LMG"
	SWEP.Description = "탄창이 없는 신식 무기로 공격을 거듭할수록 발사속도가 빨라진다."
	SWEP.Slot = 2
	SWEP.SlotPos = 0

	SWEP.HUD3DBone = "Base"
	SWEP.HUD3DPos = Vector(7.791, -2.597, -7.792)
	SWEP.HUD3DScale = 0.04
	SWEP.VElements = {
		["handle"] = { type = "Model", model = "models/props_lab/teleplatform.mdl", bone = "Base", rel = "", pos = Vector(2.562, 4.382, -7.264), angle = Angle(0, -106.975, -90), size = Vector(0.052, 0.018, 0.131), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["backcover+"] = { type = "Model", model = "models/props_combine/combine_booth_short01a.mdl", bone = "Base", rel = "", pos = Vector(0, 3.743, -4.172), angle = Angle(-90, 0, -90), size = Vector(0.064, 0.054, 0.112), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["top++"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "Base", rel = "", pos = Vector(-4, 3.4, 8.822), angle = Angle(0, 110, -90), size = Vector(0.064, 0.054, 0.054), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["ring"] = { type = "Model", model = "models/props_lab/teleportring.mdl", bone = "Base", rel = "", pos = Vector(0, 0, 0.83), angle = Angle(0, 0, 0), size = Vector(0.238, 0.238, 0.617), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["backcover"] = { type = "Model", model = "models/props_combine/breenconsole.mdl", bone = "Base", rel = "", pos = Vector(0, 8.26, -10.254), angle = Angle(180, 0, -90), size = Vector(0.259, 0.303, 0.18), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["top+"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "Base", rel = "", pos = Vector(4, 3.4, 8.822), angle = Angle(0, -110, -90), size = Vector(0.064, 0.054, 0.054), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["ring+"] = { type = "Model", model = "models/props_lab/teleportring.mdl", bone = "Base", rel = "", pos = Vector(0, 0, 9.887), angle = Angle(0, 0, 0), size = Vector(0.238, 0.238, 0.617), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["backcover++"] = { type = "Model", model = "models/props_combine/combine_core_ring01.mdl", bone = "Base", rel = "", pos = Vector(5.085, 5.119, -4.666), angle = Angle(10.803, 90, -90), size = Vector(0.09, 0.128, 0.064), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["nozzle"] = { type = "Model", model = "models/props_junk/terracotta01.mdl", bone = "Base", rel = "", pos = Vector(0, 0, 21.715), angle = Angle(0, 0, 0), size = Vector(0.583, 0.583, 0.583), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["top"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "Base", rel = "", pos = Vector(0, -1.769, 9.48), angle = Angle(0, 0, -90), size = Vector(0.064, 0.054, 0.054), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.ViewModelFlip = false
end
SWEP.WElements = {
	["top++"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(18.836, 1.134, -3.421), angle = Angle(-60, -75, 12), size = Vector(0.034, 0.034, 0.034), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["top"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(18.747, -2.422, -8.268), angle = Angle(180, -79.387, 0), size = Vector(0.034, 0.034, 0.034), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["nozzle"] = { type = "Model", model = "models/props_junk/terracotta01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(27.541, -3.258, -4.519), angle = Angle(-90, 3.944, 0), size = Vector(0.194, 0.194, 0.194), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["top+"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(17.674, -4.555, -2.25), angle = Angle(60, -75, -1.015), size = Vector(0.034, 0.034, 0.034), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["nozzle+"] = { type = "Model", model = "models/props_junk/metal_paintcan001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(18.461, -2.402, -6.15), angle = Angle(-89.82, 10.119, 0), size = Vector(0.762, 0.762, 0.762), color = Color(255, 255, 255, 255), surpresslightning = false, material = "metal6", skin = 0, bodygroup = {} }
}

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
	channel = CHAN_VOICE,
	volume = 1,
	level = 90,
	pitch = 110,
	sound = "weapons/gauss/chargeloop.wav"
} )
sound.Add( {
	name = "Loop_Neutrino_Firing",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 75,
	pitch = 115,
	sound = "weapons/smg1/smg1_fire1.wav"
} )

SWEP.ReloadSound = Sound("weapons/ar2/ar2_reload_push.wav")
SWEP.Primary.Sound = Sound("Loop_Neutrino_Firing")
SWEP.Recoil = 0.5
SWEP.Primary.Damage = 9
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.2

SWEP.Primary.ClipSize = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pulse"
SWEP.Primary.DefaultClip = 200

SWEP.ConeMax = 0.075
SWEP.ConeMin = 0.02

-- 에임이 늘어나는 단위
SWEP.AimExpandUnit = 0.005

-- 에임이 늘어난 상태가 유지되는 기간
SWEP.AimExpandStayDuration = 0.01

-- 에임이 줄어드는 단위
SWEP.AimCollapseUnit = 0.2

SWEP.WalkSpeed = SPEED_SLOWEST
SWEP.TracerName = "Ar2Tracer"
SWEP.PlayCharge = nil
SWEP.ShowOnlyClip = true
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
		self.Owner:RemoveAmmo( self.Primary.NumShots*((self:GetDTInt(4) >= 40) and 2 or (self:GetDTInt(4) >= 80) and 3 or 1), self.Weapon:GetPrimaryAmmoType() )
		self.IdleAnimation = CurTime() + self:SequenceDuration()
		local combo = self:GetDTInt(4)
		self:SetNextPrimaryFire(CurTime() + math.max(0.033, self.Primary.Delay * (1 - combo / 60)))
		self:SetDTInt(4, combo + 1)
	end
end

function SWEP:Think()
	local owner = self.Owner
	if owner:KeyDown(IN_ATTACK) and self:CanPrimaryAttack() then 
		if self:Ammo1()<=0 then return end
		
		if not self.PlayCharge then
			self:EmitSound("Loop_Neutrino_Charging")
			self.PlayCharge = true
		end
		if CLIENT then
			self.VElements["ring"].angle.y = math.Approach(self.VElements["ring"].angle.y, self.VElements["ring"].angle.y+2, FrameTime()*80)
			self.VElements["ring+"].angle.y = math.Approach(self.VElements["ring+"].angle.y, self.VElements["ring+"].angle.y+3, FrameTime()*80)
		end
	elseif CLIENT then
		self.VElements["ring"].angle.y = math.Approach(self.VElements["ring"].angle.y, math.ceil(self.VElements["ring"].angle.y/360)*360, FrameTime()*100)
        self.VElements["ring+"].angle.y = math.Approach(self.VElements["ring+"].angle.y, math.ceil(self.VElements["ring+"].angle.y/360)*360, FrameTime()*100)
	elseif not owner:KeyDown(IN_ATTACK) or not owner:Alive() then
		self:SetDTInt(4, 0)
		if self.PlayCharge then
			self:StopSound("Loop_Neutrino_Charging")
			self.PlayCharge = nil
		end
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