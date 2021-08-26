AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_ventilator_name"
	SWEP.TranslateDesc = "weapon_ventilator_desc"
	SWEP.Slot = 1
	SWEP.SlotPos = 4

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 56

	SWEP.HUD3DBone = "v_weapon.Deagle_Parent"
	SWEP.HUD3DPos = Vector(0.1, -5.5, 1.22)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.016

	SWEP.VElements = {
		["novacolt++++++"] = { type = "Model", model = "models/props_combine/breenlight.mdl", bone = "v_weapon.Deagle_Parent", rel = "novacolt", pos = Vector(0, 4.524, 4.07), angle = Angle(113.376, -90, 0), size = Vector(0.451, 0.298, 0.365), color = Color(148, 132, 132, 255), surpresslightning = false, material = "phoenix_storms/fender_wood", skin = 0, bodygroup = {} },
		["novacolt++"] = { type = "Model", model = "models/props_combine/combinethumper002.mdl", bone = "v_weapon.Deagle_Parent", rel = "novacolt", pos = Vector(-0.612, 3.635, 1.74), angle = Angle(0, 0, 180), size = Vector(0.05, 0.059, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["novacolt"] = { type = "Model", model = "models/props_wasteland/laundry_washer001a.mdl", bone = "v_weapon.Deagle_Parent", rel = "", pos = Vector(0, -5.56, -2.725), angle = Angle(0, 0, 0), size = Vector(0.045, 0.045, 0.059), color = Color(80, 87, 99, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["novacolt+++++"] = { type = "Model", model = "models/props_wasteland/laundry_dryer001.mdl", bone = "v_weapon.Deagle_Parent", rel = "novacolt", pos = Vector(0, 0.6, 3), angle = Angle(110, -90, 0), size = Vector(0.019, 0.041, 0.034), color = Color(75, 82, 95, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["novacolt+"] = { type = "Model", model = "models/props_wasteland/laundry_washer001a.mdl", bone = "v_weapon.Deagle_Parent", rel = "novacolt", pos = Vector(0, 3, -0.35), angle = Angle(90, 0, 0), size = Vector(0.029, 0.029, 0.05), color = Color(92, 108, 118, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["novacolt+++++++"] = { type = "Model", model = "models/props_lab/eyescanner.mdl", bone = "v_weapon.Deagle_Parent", rel = "novacolt", pos = Vector(0, -1.601, 2.2), angle = Angle(66.62, 90, 0), size = Vector(0.129, 0.15, 0.159), color = Color(155,155,155, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["novacolt++++"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "v_weapon.Deagle_Parent", rel = "novacolt", pos = Vector(0, 0.47, -5.652), angle = Angle(-180, 180, 90), size = Vector(0.019, 0.028, 0.019), color = Color(255,255,255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["novacolt++++++"] = { type = "Model", model = "models/props_combine/breenlight.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "novacolt", pos = Vector(0, 4.524, 4.07), angle = Angle(113.376, -90, 0), size = Vector(0.451, 0.298, 0.365), color = Color(148, 132, 132, 255), surpresslightning = false, material = "phoenix_storms/fender_wood", skin = 0, bodygroup = {} },
		["novacolt++"] = { type = "Model", model = "models/props_combine/combinethumper002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "novacolt", pos = Vector(-0.612, 3.635, 1.74), angle = Angle(0, 0, 180), size = Vector(0.05, 0.059, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["novacolt"] = { type = "Model", model = "models/props_wasteland/laundry_washer001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.314, 1.432, -5.409), angle = Angle(0, 90, -86.532), size = Vector(0.045, 0.045, 0.059), color = Color(80, 87, 99, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["novacolt+++++"] = { type = "Model", model = "models/props_wasteland/laundry_dryer001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "novacolt", pos = Vector(0, 0.6, 3), angle = Angle(110, -90, 0), size = Vector(0.019, 0.041, 0.034), color = Color(75, 82, 95, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["novacolt+"] = { type = "Model", model = "models/props_wasteland/laundry_washer001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "novacolt", pos = Vector(0, 3, -0.35), angle = Angle(90, 0, 0), size = Vector(0.029, 0.029, 0.05), color = Color(92, 108, 118, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["novacolt+++++++"] = { type = "Model", model = "models/props_lab/eyescanner.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "novacolt", pos = Vector(0, -1.601, 2.2), angle = Angle(66.62, 90, 0), size = Vector(0.129, 0.15, 0.159), color = Color(155,155,155, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["novacolt++++"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "novacolt", pos = Vector(0, 0.47, -5.652), angle = Angle(-180, 180, 90), size = Vector(0.019, 0.028, 0.019), color = Color(255,255,255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.IronSightsPos = Vector(-6.321, 0, -0.561)
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "revolver"

SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.ViewModel = "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel = "models/weapons/w_pist_deagle.mdl"
SWEP.UseHands = true

SWEP.Primary.Damage = 45
SWEP.Primary.BurstDamage = 15
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.25
SWEP.Primary.KnockbackScale = 2
SWEP.Recoil = 1.6
SWEP.Primary.ClipSize = 7
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"
GAMEMODE:SetupDefaultClip(SWEP.Primary)
SWEP.ReloadSpeed = 1
SWEP.ConeMax = 0.0015
SWEP.ConeMin = 0.001
SWEP.MovingConeOffset = 0.1
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
SWEP.LastSecondaryFire = 0
function SWEP:EmitFireSound()
	self:EmitSound("weapons/deagle/deagle-1.wav", 75, math.random(91, 95), 0.5)
	self:EmitSound("weapons/ak47/ak47-1.wav", 75, math.random(112, 128), 0.73,CHAN_AUTO+20)
end

function SWEP:EmitReloadSound()
	if IsFirstTimePredicted() then
		self:EmitSound("weapons/357/357_reload1.wav", 75, 75, 1, CHAN_WEAPON + 21)
	end
end

function SWEP:EmitReloadFinishSound()
	if IsFirstTimePredicted() then
		self:EmitSound("weapons/357/357_spin1.wav", 70, 90)
	end
end
function SWEP:FinishReload()
	self.ReloadSpeed = 1
	if self.BaseClass.FinishReload then
		self.BaseClass.FinishReload(self)
	end
end

function SWEP:SecondaryAttack()
	if not self:CanPrimaryAttack() then return end 
	local shots = self:Clip1()
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay*2)
	--self:SetNextReload(CurTime() + self.Primary.Delay)
	self:EmitFireSound()
	self:EmitSound("weapons/shotgun/shotgun_dbl_fire.wav",75,80,1,CHAN_AUTO+21)
	self:TakePrimaryAmmo(shots)
	self:ShootBullets(math.max(self.Primary.BurstDamage,math.floor(self.Primary.Damage/shots)), shots, math.min(self:GetCone()*60,0.18))
	self.ReloadSpeed = 0.6
	self.IdleAnimation = CurTime() + self:SequenceDuration()
end