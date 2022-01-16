AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_tinyslug_name"
	SWEP.TranslateDesc = "weapon_tinyslug_desc"
	SWEP.Slot = 3
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 50

	SWEP.HUD3DBone = "v_weapon.xm1014_Bolt"
	SWEP.HUD3DPos = Vector(-1, 0, 0)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.02
	SWEP.VElements = {
		["scopemid"] = { type = "Model", model = "models/xqm/rails/funnel.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scopebeginning", pos = Vector(4.645, 0, 0), angle = Angle(90, 0, 0), size = Vector(0.02, 0.02, 0.075), color = Color(95, 95, 95, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
		["scopebeginning"] = { type = "Model", model = "models/XQM/deg360.mdl", bone = "v_weapon.xm1014_Parent", rel = "", pos = Vector(0.079, -6.515, -0.695), angle = Angle(-90, 0, 0), size = Vector(0.019, 0.041, 0.041), color = Color(105, 105, 105, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
		["knobs+"] = { type = "Model", model = "models/XQM/cylinderx1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scopebeginning", pos = Vector(5.763, -0.769, 0), angle = Angle(180, 90, 98.054), size = Vector(0.079, 0.079, 0.079), color = Color(105, 105, 105, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
		["mount"] = { type = "Model", model = "models/XQM/CoasterTrack/track_guide.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scopebeginning", pos = Vector(6.022, 1.996, 0), angle = Angle(90, -90, 0), size = Vector(0.037, 0.041, 0.056), color = Color(105, 105, 105, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
		["scopemid+"] = { type = "Model", model = "models/xqm/rails/funnel.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scopebeginning", pos = Vector(8.166, 0, 0), angle = Angle(-90, 0, 0), size = Vector(0.02, 0.02, 0.014), color = Color(105, 105, 105, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
		["scopebeginning+++"] = { type = "Model", model = "models/XQM/deg360.mdl", bone = "v_weapon.xm1014_Parent", rel = "scopebeginning", pos = Vector(9.295, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.014, 0.041, 0.041), color = Color(105, 105, 105, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
		["midsection"] = { type = "Model", model = "models/props_phx/misc/smallcannonball.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scopebeginning", pos = Vector(5.747, -0.026, -0.81), angle = Angle(-90, 0, 0), size = Vector(0.114, 0.114, 0.114), color = Color(105, 105, 105, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
		["scopebeginning++"] = { type = "Model", model = "models/XQM/deg360.mdl", bone = "v_weapon.xm1014_Parent", rel = "scopebeginning", pos = Vector(7.31, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.043, 0.019, 0.017), color = Color(105, 105, 105, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
		["scopebeginning+"] = { type = "Model", model = "models/XQM/deg360.mdl", bone = "v_weapon.xm1014_Parent", rel = "scopebeginning", pos = Vector(4.828, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.028, 0.019, 0.014), color = Color(105, 105, 105, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
		["glass"] = { type = "Model", model = "models/XQM/panel360.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scopebeginning", pos = Vector(-0.238, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.039, 0.039, 0.039), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/dome_side", skin = 0, bodygroup = {} },
		["knobs"] = { type = "Model", model = "models/XQM/cylinderx1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scopebeginning", pos = Vector(5.763, 0, 0), angle = Angle(90, 0, 0), size = Vector(0.159, 0.079, 0.079), color = Color(105, 105, 105, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["scopemid"] = { type = "Model", model = "models/xqm/rails/funnel.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scopebeginning", pos = Vector(4.645, 0, -0.04), angle = Angle(90, 0, 0), size = Vector(0.02, 0.02, 0.075), color = Color(95, 95, 95, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
		["scopebeginning"] = { type = "Model", model = "models/XQM/deg360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.928, 0.908, -5.581), angle = Angle(-10, 0, -90), size = Vector(0.019, 0.041, 0.041), color = Color(105, 105, 105, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
		["knobs+"] = { type = "Model", model = "models/XQM/cylinderx1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scopebeginning", pos = Vector(5.763, -0.769, 0), angle = Angle(180, 90, 98.054), size = Vector(0.079, 0.079, 0.079), color = Color(105, 105, 105, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
		["glass+"] = { type = "Model", model = "models/XQM/panel360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scopebeginning", pos = Vector(9.529, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.039, 0.039, 0.039), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/dome_side", skin = 0, bodygroup = {} },
		["mount"] = { type = "Model", model = "models/XQM/CoasterTrack/track_guide.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scopebeginning", pos = Vector(6.022, 1.996, 0), angle = Angle(90, -90, 0), size = Vector(0.037, 0.041, 0.056), color = Color(105, 105, 105, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
		["glass"] = { type = "Model", model = "models/XQM/panel360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scopebeginning", pos = Vector(-0.238, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.039, 0.039, 0.039), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/dome_side", skin = 0, bodygroup = {} },
		["scopebeginning+++"] = { type = "Model", model = "models/XQM/deg360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scopebeginning", pos = Vector(9.274, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.014, 0.041, 0.041), color = Color(105, 105, 105, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
		["scopebeginning++"] = { type = "Model", model = "models/XQM/deg360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scopebeginning", pos = Vector(7.31, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.043, 0.019, 0.017), color = Color(105, 105, 105, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
		["scopemid+"] = { type = "Model", model = "models/xqm/rails/funnel.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scopebeginning", pos = Vector(8.166, 0, 0.05), angle = Angle(-90, 0, 0), size = Vector(0.02, 0.02, 0.014), color = Color(105, 105, 105, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
		["scopebeginning+"] = { type = "Model", model = "models/XQM/deg360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scopebeginning", pos = Vector(4.828, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.028, 0.019, 0.014), color = Color(105, 105, 105, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
		["midsection"] = { type = "Model", model = "models/props_phx/misc/smallcannonball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scopebeginning", pos = Vector(5.747, -0.026, -0.81), angle = Angle(-90, 0, 0), size = Vector(0.114, 0.114, 0.114), color = Color(105, 105, 105, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
		["knobs"] = { type = "Model", model = "models/XQM/cylinderx1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scopebeginning", pos = Vector(5.763, 0, 0), angle = Angle(90, 0, 0), size = Vector(0.159, 0.079, 0.079), color = Color(105, 105, 105, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/cstrike/c_shot_xm1014.mdl"
SWEP.WorldModel = "models/weapons/w_shot_xm1014.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_XM1014.Single")
SWEP.Primary.Damage = 75
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.5
SWEP.ReloadDelay = 0.4

SWEP.Primary.ClipSize = 6
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "357"
SWEP.Primary.DefaultClip = 18

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN

SWEP.ConeMax = 0.003
SWEP.ConeMin = 0
SWEP.Recoil = 2.25
SWEP.MovingConeOffset = 0.28
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronSightsAng = Vector(0, -1, 0)
SWEP.WalkSpeed = SPEED_SLOWER
function SWEP:EmitFireSound()
	self:EmitSound(self.Primary.Sound)
	self:EmitSound("weapons/awp/awp1.wav", 45, 100,1,CHAN_VOICE)
end

if CLIENT then
	SWEP.IronsightsMultiplier = 0.55
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 5, "ReloadTimer")
	self:NetworkVar("Bool", 5, "IsReloading")
	if self.BaseClass.SetupDataTables then
		self.BaseClass.SetupDataTables(self)
	end
end

function SWEP:Reload()
	if self:GetReloadTimer() > 0 then return end

	if self:Clip1() < self.Primary.ClipSize and 0 < self:Ammo1() then
		self:SetNextPrimaryFire(CurTime() + math.max(self.ReloadDelay,self.Primary.Delay))
		self:SetIsReloading(true)
		self:SetReloadTimer(CurTime() + self.ReloadDelay)
		self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
		self:GetOwner():DoReloadEvent()
	end
	self:SetIronsights(false)
end

function SWEP:Think()
	if self:GetReloadTimer() > 0 and CurTime() >= self:GetReloadTimer() then
		self:DoReload()
	end
	if self:GetIronsights() and not self:GetOwner():KeyDown(IN_ATTACK2) then
		self:SetIronsights(false)
	end
	if self.BaseClass.Think then
		self.BaseClass.Think(self)
	end
	self:NextThink(CurTime())
	return true
end

function SWEP:DoReload()
	if not (self:Clip1() < self.Primary.ClipSize and 0 < self:Ammo1()) or self:GetOwner():KeyDown(IN_ATTACK) or (not self:GetIsReloading() and not self:GetOwner():KeyDown(IN_RELOAD)) then
		self:StopReloading()
		return
	end

	local delay = self.ReloadDelay
	self:SendWeaponAnim(ACT_VM_RELOAD)

	self:GetOwner():RemoveAmmo(1, self.Primary.Ammo, false)
	self:SetClip1(self:Clip1() + 1)

	self:SetIsReloading(false)
	-- We always wanna call the reload function one more time. Forces a pump to take place.
	self:SetReloadTimer(CurTime() + delay)
	self:SetNextPrimaryFire(CurTime() + math.max(self.Primary.Delay, delay))
end

function SWEP:StopReloading()
	self:SetReloadTimer(0)
	self:SetIsReloading(false)
	self:SetNextPrimaryFire(CurTime() + math.max(self.Primary.Delay, self.ReloadDelay) * 0.75)
	if self:Clip1() > 0 then
		self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
	end
end

function SWEP:CanPrimaryAttack()
	if self:GetOwner():IsHolding() or self:GetOwner():GetBarricadeGhosting() then return false end

	if self:Clip1() <= 0 then
		self:EmitSound("Weapon_Shotgun.Empty")
		self:SetNextPrimaryFire(CurTime() + 0.25)
		return false
	end

	if self:GetIsReloading() then
		self:StopReloading()
		return false
	end

	return self:GetNextPrimaryFire() <= CurTime()
end

function SWEP:IsScoped()
	return self:GetIronsights() and self.fIronTime and self.fIronTime + 0.25 <= CurTime()
end
if CLIENT then
	SWEP.IronsightsMultiplier = 0.2

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