AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_annabelle_name"
	SWEP.TranslateDesc = "weapon_annabelle_desc"
	SWEP.Slot = 3
	SWEP.SlotPos = 0
	
	SWEP.ViewModelFlip = false

	SWEP.HUD3DBone = "ValveBiped.Gun"
	SWEP.HUD3DPos = Vector(1.75, 1, -5)
	SWEP.HUD3DAng = Angle(180, 0, 0)
	SWEP.HUD3DScale = 0.015
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/v_annabelle.mdl"
SWEP.WorldModel = "models/weapons/w_annabelle.mdl"

SWEP.CSMuzzleFlashes = false

SWEP.Primary.Sound = Sound("Weapon_Shotgun.Single")
SWEP.Primary.Damage = 45
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.75
SWEP.ReloadDelay = 0.35
SWEP.Recoil = 2.24

SWEP.Primary.ClipSize = 4
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "357"
SWEP.Primary.DefaultClip = 24

SWEP.ConeMax = 0.008
SWEP.ConeMin = 0.002
SWEP.MovingConeOffset = 0.22
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)

SWEP.WalkSpeed = SPEED_SLOW

SWEP.reloadtimer = 0
SWEP.nextreloadfinish = 0

SWEP.IronSightsPos = Vector(-8.8, 10, 2)
SWEP.IronSightsAng = Vector(1.4,0.1,5)

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 5, "ReloadTimer")
	self:NetworkVar("Bool", 5, "IsReloading")
	if self.BaseClass.SetupDataTables then
		self.BaseClass.SetupDataTables(self)
	end
end

function SWEP:Reload()
	if self:GetReloadTimer() > 0 then return end

	if self:Clip1() < self.Primary.ClipSize and 0 < self.Owner:GetAmmoCount(self.Primary.Ammo) then
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
	if self.BaseClass.Think then
		self.BaseClass.Think(self)
	end
	self:NextThink(CurTime())
	return true
end

function SWEP:DoReload()
	if not (self:Clip1() < self.Primary.ClipSize and 0 < self.Owner:GetAmmoCount(self.Primary.Ammo)) or self:GetOwner():KeyDown(IN_ATTACK) or (not self:GetIsReloading() and not self:GetOwner():KeyDown(IN_RELOAD)) then
		self:StopReloading()
		return
	end

	local delay = self.ReloadDelay
	self:SendWeaponAnim(ACT_VM_RELOAD)
	self:EmitSound("Weapon_Shotgun.Reload")
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
		self:SendWeaponAnim(ACT_SHOTGUN_PUMP)
		self:EmitSound("Weapon_Shotgun.Special1")
	else
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

local function DoRicochet(attacker, hitpos, hitnormal, normal, damage)
	attacker.RicochetBullet = true
	attacker:FireBullets({Num = 10, Src = hitpos, Dir = hitnormal, Spread = Vector(0.25, 0.25, 0), Tracer = 1, TracerName = "rico_trace", Force = damage * 0.15, Damage = damage, Callback = GenericBulletCallback})
	attacker.RicochetBullet = nil
end
function SWEP.BulletCallback(attacker, tr, dmginfo)
	if tr.HitWorld and not tr.HitSky then
		local hitpos, hitnormal, normal= tr.HitPos, tr.HitNormal, tr.Normal 
		if SERVER then
			timer.Simple(0, function() 
				DoRicochet(attacker, hitpos, hitnormal, normal, dmginfo:GetDamage()/20) 
			end)
			for _, ent in pairs(ents.FindInSphere(hitpos, 64)) do
				if ent and ent:IsValid() then
					local nearest = ent:NearestPoint(hitpos)
					if TrueVisibleFilters(hitpos, nearest, dmginfo:GetInflictor(), ent) then
						ent:TakeSpecialDamage(dmginfo:GetDamage()/1.5, DMG_BULLET, attacker, dmginfo:GetInflictor(), nearest)
					end
				end
			end
		end
	end
	GenericBulletCallback(attacker, tr, dmginfo)
end

if not CLIENT then return end

SWEP.IronsightsMultiplier = 0.55