AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_cowpoke_name"
	SWEP.TranslateDesc = "weapon_cowpoke_desc"
	SWEP.Slot = 3
	SWEP.SlotPos = 0
	
	SWEP.ViewModelFlip = false

	SWEP.HUD3DBone = "ValveBiped.Gun"
	SWEP.HUD3DPos = Vector(3.5, -1, -5)
	SWEP.HUD3DAng = Angle(180, 0, 0)
	SWEP.HUD3DScale = 0.03
	SWEP.VElements = {
	["bottom+"] = { type = "Model", model = "models/props_junk/cardboard_box001a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "barr++", pos = Vector(1.404, -0.155, -1.961), angle = Angle(0, 0, 90), size = Vector(0.052, 0.759, 0.05), color = Color(155, 155, 185, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },
	["barr+"] = { type = "Model", model = "models/hunter/tubes/tube2x2x2.mdl", bone = "ValveBiped.Gun", rel = "barr++", pos = Vector(2.74, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.025, 0.025, 0.352), color = Color(192, 192, 255, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },
	["CAP+"] = { type = "Model", model = "models/props_phx/construct/glass/glass_dome360.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "barr++", pos = Vector(2.736, 0, -16.616), angle = Angle(180, 0, 0), size = Vector(0.025, 0.025, 0.025), color = Color(192, 192, 255, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },
	["barr++"] = { type = "Model", model = "models/hunter/tubes/tube2x2x2.mdl", bone = "ValveBiped.Gun", rel = "", pos = Vector(-1.183, 0.100, 11.350), angle = Angle(0, 0, 0), size = Vector(0.025, 0.025, 0.352), color = Color(192, 192, 255, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },
	["bottom"] = { type = "Model", model = "models/props_junk/cardboard_box001a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "barr++", pos = Vector(1.162, 1.728, -0.658), angle = Angle(0, 0, 90), size = Vector(0.103, 0.649, 0.05), color = Color(255, 255, 215, 255), surpresslightning = false, material = "models/props/de_inferno/roofbits", skin = 0, bodygroup = {} },
	["CAP"] = { type = "Model", model = "models/props_phx/construct/glass/glass_dome360.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "barr++", pos = Vector(0, 0, -16.616), angle = Angle(180, 0, 0), size = Vector(0.025, 0.025, 0.025), color = Color(192, 192, 255, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },
	["bottom++"] = { type = "Model", model = "models/props_junk/cardboard_box001a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "barr++", pos = Vector(1.343, -0.950, 12.184), angle = Angle(0, 0, 0), size = Vector(0.023, 0.023, 0.023), color = Color(155, 155, 185, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} }
	}
end
SWEP.WElements = {
	["bottom+"] = { type = "Model", model = "models/props_junk/cardboard_box001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barr++", pos = Vector(1.404, -0.431, -0.951), angle = Angle(0, 0, 90), size = Vector(0.052, 0.746, 0.05), color = Color(155, 155, 185, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },
	["barr+"] = { type = "Model", model = "models/hunter/tubes/tube2x2x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barr++", pos = Vector(2.74, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.025, 0.025, 0.324), color = Color(192, 192, 255, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },
	["barr++"] = { type = "Model", model = "models/hunter/tubes/tube2x2x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(22.500, 0.178, -6.100), angle = Angle(3.207, -88.655, -96.483), size = Vector(0.025, 0.025, 0.324), color = Color(192, 192, 255, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },
	["CAP+"] = { type = "Model", model = "models/props_phx/construct/glass/glass_dome360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barr++", pos = Vector(2.736, 0, -15.389), angle = Angle(180, 0, 0), size = Vector(0.025, 0.025, 0.025), color = Color(192, 192, 255, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },
	["bottom"] = { type = "Model", model = "models/props_junk/cardboard_box001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barr++", pos = Vector(1.162, 1.728, -0.658), angle = Angle(0, 0, 90), size = Vector(0.103, 0.749, 0.05), color = Color(255, 255, 215, 255), surpresslightning = false, material = "models/props/de_inferno/roofbits", skin = 0, bodygroup = {} },
	["CAP"] = { type = "Model", model = "models/props_phx/construct/glass/glass_dome360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barr++", pos = Vector(0, 0, -15.389), angle = Angle(180, 0, 0), size = Vector(0.025, 0.025, 0.025), color = Color(192, 192, 255, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },
	["bottom++"] = { type = "Model", model = "models/props_junk/cardboard_box001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barr++", pos = Vector(1.343, -1.089, 13.241), angle = Angle(0, 0, 0), size = Vector(0.023, 0.023, 0.023), color = Color(155, 155, 185, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} }
	}

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "shotgun"

SWEP.ViewModel = "models/weapons/c_annabelle.mdl"
SWEP.WorldModel = "models/weapons/w_annabelle.mdl"

SWEP.CSMuzzleFlashes = false

SWEP.Primary.Sound = Sound("Weapon_Shotgun.Single")
SWEP.Primary.Damage = 5
SWEP.Primary.NumShots = 10
SWEP.Primary.Delay = 0.4
SWEP.Recoil = 5.71
SWEP.ReloadDelay = 0.8

SWEP.Primary.ClipSize = 2
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.DefaultClip = 10
SWEP.SelfKnockBackForce = 100
SWEP.ConeMax = 0.265
SWEP.ConeMin = 0.076
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)

SWEP.WalkSpeed = SPEED_SLOWER
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN

SWEP.reloadtimer = 0
SWEP.nextreloadfinish = 0

function SWEP:Reload()
	if self.reloading then return end

	if self:GetNextReload() <= CurTime() and self:Clip1() < self.Primary.ClipSize and 0 < self:Ammo1() then
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		self.reloading = true
		self.reloadtimer = CurTime() + self.ReloadDelay
		self:SendWeaponAnim(ACT_VM_IDLE_TO_LOWERED)
		self.Owner:SetAnimation( PLAYER_RELOAD )
		self.Owner:DoReloadEvent()
		self:SetNextReload(CurTime() + self:SequenceDuration())
	end
	self:SetIronsights(false)
end

function SWEP:SecondaryAttack()
	local owner = self.Owner
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:EmitSound("weapons/shotgun/shotgun_dbl_fire.wav")
	local clip = self:Clip1()
	self:ShootBullets(self.Primary.Damage, math.floor(self.Primary.NumShots * 2), self:GetCone())
	self:DoSelfKnockBack(2)
	if owner and owner:IsValid() and owner:IsPlayer() and SERVER then
		owner.ShotsFired = owner.ShotsFired + math.floor(self.Primary.NumShots * 2)
		owner.LastShotWeapon = self:GetClass()
	end	
	self:TakePrimaryAmmo(clip)
end

function SWEP:Think()
	if self.reloading and self.reloadtimer < CurTime() then
		self.reloadtimer = CurTime() + self.ReloadDelay
		self:SendWeaponAnim(ACT_VM_RELOAD)

		self.Owner:RemoveAmmo(1, self.Primary.Ammo, false)
		self:SetClip1(self:Clip1() + 1)
		self:EmitSound("Weapon_Shotgun.Reload")

		if self.Primary.ClipSize <= self:Clip1() or self:Ammo1() <= 0 or not self.Owner:KeyDown(IN_RELOAD) then
			self.nextreloadfinish = CurTime() + self.ReloadDelay
			self.reloading = false
			self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		end
	end

	local nextreloadfinish = self.nextreloadfinish
	if nextreloadfinish ~= 0 and nextreloadfinish < CurTime() then
		self:SendWeaponAnim(ACT_SHOTGUN_PUMP)
		self:EmitSound("Weapon_Shotgun.Special1")
		self.nextreloadfinish = 0
	end

	if self.IdleAnimation and self.IdleAnimation <= CurTime() then
		self.IdleAnimation = nil
		self:SendWeaponAnim(ACT_VM_IDLE)
	end

	if self:GetIronsights() and not self.Owner:KeyDown(IN_ATTACK2) then
		self:SetIronsights(false)
	end
	
	if self:Clip1() <= 1 and self.Owner:KeyDown(IN_ATTACK2) then
		self:SetNextSecondaryAttack(CurTime() + 0.25)
		return false
	end
end

function SWEP:CanPrimaryAttack()
	if self.Owner:IsHolding() or self.Owner:GetBarricadeGhosting() then return false end

	if self:Clip1() <= 0 then
		self:EmitSound("Weapon_Shotgun.Empty")
		self:SetNextPrimaryFire(CurTime() + 0.25)
		return false
	end
	
	if self.reloading then
		if self:Clip1() < self.Primary.ClipSize then
			self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
		else
			self:SendWeaponAnim(ACT_SHOTGUN_PUMP)
			self:EmitSound("Weapon_Shotgun.Special1")
		end
		self.reloading = false
		self:SetNextPrimaryFire(CurTime() + 0.25)
		return false
	end

	return self:GetNextPrimaryFire() <= CurTime()
end