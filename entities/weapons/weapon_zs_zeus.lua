AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_zeusrifle_name"
	SWEP.TranslateDesc = "weapon_zeusrifle_desc"
	SWEP.Slot = 3
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 50

	SWEP.HUD3DBone = "v_weapon.g3sg1_Parent"
	SWEP.HUD3DPos = Vector(-2, -5, -6)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.03
end

sound.Add(
{
	name = "Weapon_Zeus.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	soundlevel = 100,
	sound = "weapons/g3sg1/g3sg1-1.wav"
})

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/cstrike/c_snip_g3sg1.mdl"
SWEP.WorldModel = "models/weapons/w_snip_g3sg1.mdl"
SWEP.UseHands = true

SWEP.ReloadSound = Sound("Weapon_AWP.ClipOut")
SWEP.Primary.Sound = Sound("Weapon_Zeus.Single")
SWEP.Primary.Damage = 45
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.35
SWEP.ReloadDelay = SWEP.Primary.Delay

SWEP.Primary.ClipSize = 10
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "357"
SWEP.Primary.DefaultClip = 30
SWEP.Primary.KnockbackScale = 0.1

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN
SWEP.ReloadSpeed = 1.15
SWEP.ConeMax = 0.004
SWEP.ConeMin = 0.0005
SWEP.Recoil = 1.33
SWEP.DefaultRecoil = 2.23
SWEP.MovingConeOffset = 0.14
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)

SWEP.IronSightsPos = Vector(5.427, -5.026, 2.21)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.WalkSpeed = SPEED_SLOWEST

SWEP.TracerName = "Tracer"

function SWEP:IsScoped()
	return self:GetIronsights() and self.fIronTime and self.fIronTime + 0.25 <= CurTime()
end
function SWEP:Think()
	if (self:GetIronsights()) then
		self.Recoil = self.DefaultRecoil*0.3
	else
		self.Recoil = self.DefaultRecoil
	end
	self.BaseClass.Think(self)
end
--[[function SWEP:EmitFireSound()
	self:EmitSound(self.Primary.Sound, 85, 80)
end]]

function SWEP.BulletCallback(attacker, tr, dmginfo)

	GenericBulletCallback(attacker, tr, dmginfo)
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
