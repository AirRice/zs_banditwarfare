AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_bioticrifle_name"
	SWEP.TranslateDesc = "weapon_bioticrifle_desc"
	SWEP.Slot = 3
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 50

	SWEP.HUD3DBone = "v_weapon.scout_Parent"
	SWEP.HUD3DPos = Vector(-2, -3.75, -6)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.025

	SWEP.VElements = {
		["base++++"] = { type = "Model", model = "models/gibs/hgibs.mdl", bone = "v_weapon.scout_Bolt", rel = "base", pos = Vector(1.794, -0.417, -3.037), angle = Angle(0, 0, -180), size = Vector(0.286, 0.286, 0.286), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+++"] = { type = "Model", model = "models/gibs/gunship_gibs_midsection.mdl", bone = "v_weapon.scout_Bolt", rel = "base", pos = Vector(7.467, -0.41, 1.23), angle = Angle(-54.584, -180, 180), size = Vector(0.085, 0.046, 0.119), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base++++++"] = { type = "Model", model = "models/gibs/hgibs_scapula.mdl", bone = "v_weapon.scout_Bolt", rel = "base", pos = Vector(-0.987, -1.969, 0.51), angle = Angle(-24.091, -180, 0), size = Vector(0.486, 0.486, 0.486), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+++++"] = { type = "Model", model = "models/gibs/hgibs.mdl", bone = "v_weapon.scout_Bolt", rel = "base", pos = Vector(-7.468, -0.417, -3.037), angle = Angle(-1.556, -180, -180), size = Vector(0.286, 0.286, 0.286), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base"] = { type = "Model", model = "models/gibs/airboat_broken_engine.mdl", bone = "v_weapon.scout_Parent", rel = "", pos = Vector(0.317, -1.956, -8.728), angle = Angle(90, 0, 90), size = Vector(0.217, 0.217, 0.217), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+++++++"] = { type = "Model", model = "models/gibs/hgibs_scapula.mdl", bone = "v_weapon.scout_Bolt", rel = "base", pos = Vector(-0.348, 1.812, 0.666), angle = Angle(-180, -180, 164.927), size = Vector(0.486, 0.486, 0.486), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["clip"] = { type = "Model", model = "models/headcrabblack.mdl", bone = "v_weapon.scout_Clip", rel = "", pos = Vector(0.588, -0.475, 0.819), angle = Angle(104.108, 81.112, -0.534), size = Vector(0.224, 0.224, 0.224), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/gibs/hgibs_rib.mdl", bone = "v_weapon.scout_Bolt", rel = "", pos = Vector(-2.6, 0.675, -1.218), angle = Angle(84.249, -52.054, 170.49), size = Vector(0.393, 0.393, 0.564), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base++"] = { type = "Model", model = "models/gibs/gunship_gibs_headsection.mdl", bone = "v_weapon.scout_Bolt", rel = "base", pos = Vector(-6.93, -1.137, -0.537), angle = Angle(2.371, -180, 0), size = Vector(0.097, 0.026, 0.052), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["base++"] = { type = "Model", model = "models/gibs/gunship_gibs_headsection.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-6.93, -0.343, -0.537), angle = Angle(-1.902, -177.566, 0), size = Vector(0.157, 0.057, 0.108), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+++++"] = { type = "Model", model = "models/gibs/hgibs.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-7.468, -0.417, -3.037), angle = Angle(-1.556, -180, -180), size = Vector(0.286, 0.286, 0.286), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base++++++"] = { type = "Model", model = "models/gibs/hgibs_scapula.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-0.987, -1.969, 0.51), angle = Angle(-24.091, -180, 0), size = Vector(0.486, 0.486, 0.486), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base++++"] = { type = "Model", model = "models/gibs/hgibs.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(1.794, -0.417, -3.037), angle = Angle(0, 0, -180), size = Vector(0.286, 0.286, 0.286), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base"] = { type = "Model", model = "models/gibs/airboat_broken_engine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7.486, 0, -4.638), angle = Angle(180, -1.066, -180), size = Vector(0.217, 0.217, 0.319), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+++++++"] = { type = "Model", model = "models/gibs/hgibs_scapula.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-0.348, 1.812, 0.666), angle = Angle(-180, -180, 164.927), size = Vector(0.486, 0.486, 0.486), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+++"] = { type = "Model", model = "models/gibs/gunship_gibs_midsection.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(6.89, -0.621, 2.993), angle = Angle(-42.263, -180, 180), size = Vector(0.104, 0.054, 0.104), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/cstrike/c_snip_scout.mdl"
SWEP.WorldModel = "models/weapons/w_snip_scout.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_Scout.Single")
SWEP.Primary.Damage = 65
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.75
SWEP.ReloadDelay = SWEP.Primary.Delay

SWEP.Primary.ClipSize = 5
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "alyxgun"
SWEP.Primary.DefaultClip = 25

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN

SWEP.ConeMax = 0
SWEP.ConeMin = 0
SWEP.Recoil = 2
SWEP.IronSightsPos = Vector() --Vector(-7.3, 9, 2.3)
SWEP.IronSightsAng = Vector(0, -1, 0)

SWEP.WalkSpeed = SPEED_SLOWER
SWEP.m_NotBulletWeapon = true

function SWEP:ShootBullets(dmg, numbul, cone)
	local owner = self:GetOwner()
	--owner:MuzzleFlash()
	if SERVER then
		self:SetConeAndFire()
	end
	self:DoRecoil()
	self:SendWeaponAnimation()
	owner:DoAttackEvent()

	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav", 72, math.Rand(85, 95))
	self:GetOwner():EmitSound("npc/headcrab_poison/ph_scream"..math.random(1, 3)..".wav",35,math.Rand(140,150))
	if CLIENT then return end
	for i=1, numbul do
	local ent = ents.Create("projectile_poisonspit_rif")
	if ent:IsValid() then
		ent:SetOwner(owner)
		local vStart = owner:GetShootPos()
		ent:SetPos(vStart)
		ent:Spawn()
		ent.Damage = self.Primary.Damage
		ent:EmitSound("weapons/crossbow/bolt_fly4.wav")
		local phys = ent:GetPhysicsObject()
		if phys:IsValid() then
			local ShotAng = self:GetOwner():EyeAngles():Forward()
			phys:Wake()
			phys:SetVelocityInstantaneous(ShotAng * 2000)
			phys:EnableGravity(false)
		end
	end
	end
end

function SWEP:IsScoped()
	return self:GetIronsights() and self.fIronTime and self.fIronTime + 0.25 <= CurTime()
end

function SWEP:EmitFireSound()
	self:EmitSound(self.Primary.Sound, 85, 100)
end

if CLIENT then
	SWEP.IronsightsMultiplier = 0.25

	function SWEP:GetViewModelPosition(pos, ang)
		if self:IsScoped() then
			return pos + ang:Up() * 256, ang
		end

		return self.BaseClass.GetViewModelPosition(self, pos, ang)
	end

	local matScope = Material("zombiesurvival/scope")
	function SWEP:DrawHUDBackground()
		if self:IsScoped() then
			local scrw, scrh = ScrW(), ScrH()
			local size = math.min(scrw, scrh)
			surface.SetMaterial(matScope)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect((scrw - size) * 0.5, (scrh - size) * 0.5, size, size)
			surface.SetDrawColor(0, 0, 0, 255)
			if scrw > size then
				local extra = (scrw - size) * 0.5
				surface.DrawRect(0, 0, extra, scrh)
				surface.DrawRect(scrw - extra, 0, extra, scrh)
			end
			if scrh > size then
				local extra = (scrh - size) * 0.5
				surface.DrawRect(0, 0, scrw, extra)
				surface.DrawRect(0, scrh - extra, scrw, extra)
			end
		end
	end
end