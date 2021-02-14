AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "'타이니' 슬러그 건"
	SWEP.Description = "이 산탄총은 슬러그 탄을 발사하도록 개조되어 장거리에서도 매우 정확하다."
	SWEP.Slot = 3
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 50

	SWEP.HUD3DBone = "v_weapon.xm1014_Bolt"
	SWEP.HUD3DPos = Vector(-1, 0, 0)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.02

	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360x2.mdl", bone = "v_weapon.xm1014_Parent", rel = "", pos = Vector(0, -6, -9), angle = Angle(0, 0, 0), size = Vector(0.014, 0.014, 0.094), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/props_phx/construct/metal_angle360.mdl", bone = "v_weapon.xm1014_Parent", rel = "base", pos = Vector(0, 0, 8.5), angle = Angle(0, 0, 0), size = Vector(0.014, 0.014, 0.014), color = Color(255, 255, 255, 45), surpresslightning = false, material = "models/screenspace", skin = 0, bodygroup = {} },
		["base++"] = { type = "Model", model = "models/props_phx/construct/metal_angle360.mdl", bone = "v_weapon.xm1014_Parent", rel = "base", pos = Vector(0, 0, 2), angle = Angle(0, 0, 0), size = Vector(0.014, 0.014, 0.014), color = Color(255, 255, 255, 45), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(13, 1, -7), angle = Angle(80, 0, 0), size = Vector(0.014, 0.014, 0.094), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/props_phx/construct/metal_angle360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 0, 8.5), angle = Angle(0, 0, 0), size = Vector(0.014, 0.014, 0.014), color = Color(255, 255, 255, 45), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base++"] = { type = "Model", model = "models/props_phx/construct/metal_angle360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 0, 2), angle = Angle(0, 0, 0), size = Vector(0.014, 0.014, 0.014), color = Color(255, 255, 255, 45), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/cstrike/c_shot_xm1014.mdl"
SWEP.WorldModel = "models/weapons/w_shot_xm1014.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_XM1014.Single")
SWEP.Primary.Damage = 50
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 1.2
SWEP.ReloadDelay = 0.6

SWEP.Primary.ClipSize = 3
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.DefaultClip = 12

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN

SWEP.ConeMax = 0.005
SWEP.ConeMin = 0.00
SWEP.Recoil = 3.25
SWEP.MovingConeOffset = 0.28
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
SWEP.IronSightsPos = Vector() --Vector(-7.3, 9, 2.3)
SWEP.IronSightsAng = Vector(0, -1, 0)
SWEP.reloadtimer = 0
SWEP.nextreloadfinish = 0
SWEP.WalkSpeed = SPEED_SLOWER
function SWEP:EmitFireSound()
	self:EmitSound(self.Primary.Sound)
	self:EmitSound("weapons/awp/awp1.wav", 45, 100,1,CHAN_VOICE)
end
function SWEP:IsScoped()
	return self:GetIronsights() and self.fIronTime and self.fIronTime + 0.25 <= CurTime()
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
function SWEP:Reload()
	if self.reloading then return end

	if self:Clip1() < self.Primary.ClipSize and 0 < self.Owner:GetAmmoCount(self.Primary.Ammo) then
		self:SetNextPrimaryFire(CurTime() + self.ReloadDelay)
		self.reloading = true
		self.reloadtimer = CurTime() + self.ReloadDelay
		self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
		self.Owner:RestartGesture(ACT_HL2MP_GESTURE_RELOAD_SHOTGUN)
	end

	self:SetIronsights(false)
end

function SWEP:Think()
	if self.reloading and self.reloadtimer < CurTime() then
		self.reloadtimer = CurTime() + self.ReloadDelay
		self:SendWeaponAnim(ACT_VM_RELOAD)

		self.Owner:RemoveAmmo(1, self.Primary.Ammo, false)
		self:SetClip1(self:Clip1() + 1)

		if self.Primary.ClipSize <= self:Clip1() or self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then
			self.nextreloadfinish = CurTime() + self.ReloadDelay
			self.reloading = false
			self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		end
	end

	local nextreloadfinish = self.nextreloadfinish
	if nextreloadfinish ~= 0 and nextreloadfinish < CurTime() then
		self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
		self.nextreloadfinish = 0
	end

	if self:GetIronsights() and not self.Owner:KeyDown(IN_ATTACK2) then
		self:SetIronsights(false)
	end
	if self.BaseClass.Think then
		self.BaseClass.Think(self)
	end
end

--[[
function SWEP.BulletCallback(attacker, tr, dmginfo)
	if tr.HitGroup == HITGROUP_HEAD then
		local ent = tr.Entity
		if ent:IsValid() and ent:IsPlayer() then
			ent.Gibbed = CurTime()
		end

		if gamemode.Call("PlayerShouldTakeDamage", ent, attacker) then
			INFDAMAGEFLOATER = true
			ent:SetHealth(1)
		end
	end

	GenericBulletCallback(attacker, tr, dmginfo)
end
]]