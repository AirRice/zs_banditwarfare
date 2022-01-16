AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_m249_name"
	SWEP.TranslateDesc = "weapon_m249_desc"
	SWEP.Slot = 3
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60
	
	SWEP.HUD3DBone = "v_weapon.m249"
	SWEP.HUD3DPos = Vector(1.8, -1.3, 12)
	SWEP.HUD3DAng = Angle(180, 0, 0)
	SWEP.HUD3DScale = 0.02

end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "crossbow"

SWEP.ViewModel = "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel = "models/weapons/w_mach_m249para.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_m249.Single")
SWEP.Primary.Damage = 8
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.042

SWEP.Primary.KnockbackScale = 20

SWEP.Primary.ClipSize = 200
SWEP.Primary.DefaultClip = 400
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
SWEP.Recoil = 0.45
SWEP.ReloadSpeed = 1.2

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SMG1

SWEP.ConeMax = 0.06
SWEP.ConeMin = 0.02
SWEP.MovingConeOffset = 0.13
SWEP.WalkSpeed = SPEED_SLOWEST

SWEP.IronSightsPos = Vector(-6, 4, 1.3)
SWEP.IronSightsAng = Vector(0, 0, 0)

GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)

function SWEP:GetCone()
	local basecone = self.ConeMin
	local conediff = self.ConeMax - self.ConeMin + self.MovingConeOffset
	
	local multiplier = math.min(self:GetOwner():GetVelocity():Length() / self.WalkSpeed, 1)
	if !self:GetOwner():OnGround() then
		basecone = basecone * 1.2
		multiplier = multiplier + 0.55
	end
	if not self:GetOwner():Crouching() then 
		multiplier = multiplier - 0.1 
	end
	if self:GetIronsights() then 
		multiplier = multiplier - 0.1 
	end

	return (basecone + self:GetConeAdder()) + conediff*math.max(multiplier,0)
end