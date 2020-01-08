AddCSLuaFile()
local util_SharedRandom = util.SharedRandom
if CLIENT then
	SWEP.PrintName = "'퓨크 블래스트' 생체 산탄총"
	SWEP.Description = "이 산탄총은 좀비의 것과 비슷한 독을 앞으로 분사한다. 이 독에 맞으면 일시적으로 체력이 닳았다가 빠르게 회복한다."
	SWEP.Slot = 3
	SWEP.SlotPos = 0
	
	SWEP.ViewModelFlip = false

	SWEP.HUD3DPos = Vector(4, -3.5, -1.2)
	SWEP.HUD3DAng = Angle(90, 0, -30)
	SWEP.HUD3DScale = 0.02
	SWEP.HUD3DBone = "SS.Grip.Dummy"
	SWEP.WElements = {
		["skull"] = { type = "Model", model = "models/gibs/hgibs.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 0, 14.611), angle = Angle(0, 0, 0), size = Vector(0.754, 0.754, 0.754), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["meatgib"] = { type = "Model", model = "models/gibs/antlion_gib_large_3.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-1.234, 0.059, 15.987), angle = Angle(-13.551, 0, -5.203), size = Vector(0.244, 0.244, 0.707), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/flesh", skin = 0, bodygroup = {} },
		["base"] = { type = "Model", model = "models/props_combine/cell_01_pod_cheap.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.399, 0, -1.729), angle = Angle(82.703, -3.116, -180), size = Vector(0.171, 0.171, 0.171), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["topcovering"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-2.593, 0, 23.406), angle = Angle(0, -90, 168.466), size = Vector(1.776, 1.217, 1.776), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/barnacle/barnacle_sheet", skin = 0, bodygroup = {} },
		["nozzle"] = { type = "Model", model = "models/gibs/strider_gib1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-3.139, 0, 29.604), angle = Angle(0, 0, 0), size = Vector(0.231, 0.144, 0.221), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.VElements = {
		["skull"] = { type = "Model", model = "models/gibs/hgibs.mdl", bone = "ValveBiped.Gun", rel = "base", pos = Vector(0, 0, 14.611), angle = Angle(0, 0, 0), size = Vector(0.754, 0.754, 0.754), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["meatgib"] = { type = "Model", model = "models/gibs/antlion_gib_large_3.mdl", bone = "ValveBiped.Pump", rel = "base", pos = Vector(-1.234, 0.059, 15.987), angle = Angle(-13.551, 0, -5.203), size = Vector(0.244, 0.244, 0.707), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/flesh", skin = 0, bodygroup = {} },
		["base"] = { type = "Model", model = "models/props_combine/cell_01_pod_cheap.mdl", bone = "ValveBiped.Gun", rel = "", pos = Vector(0, 1.898, -19.618), angle = Angle(0, -90, 0), size = Vector(0.171, 0.171, 0.171), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["nozzle"] = { type = "Model", model = "models/gibs/strider_gib1.mdl", bone = "ValveBiped.Bip01", rel = "base", pos = Vector(-3.139, 0, 37.215), angle = Angle(0, 0, 0), size = Vector(0.231, 0.144, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["topcovering"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Gun", rel = "base", pos = Vector(-2.593, 0, 23.406), angle = Angle(0, -90, 168.466), size = Vector(1.776, 1.217, 1.776), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/barnacle/barnacle_sheet", skin = 0, bodygroup = {} }
	}

end

SWEP.Base = "weapon_zs_base"
SWEP.UseHands = true
SWEP.ShowViewModel = false
SWEP.HoldType = "rpg"

SWEP.ViewModel = "models/weapons/c_shotgun.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"

SWEP.ReloadDelay = 0.4

SWEP.Primary.Sound = Sound("Weapon_Shotgun.Single")
SWEP.Primary.Damage = 5
SWEP.Primary.NumShots = 8
SWEP.Primary.Delay = 0.55
SWEP.Recoil = 3.72
SWEP.Primary.ClipSize = 3
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "alyxgun"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 0.08
SWEP.ConeMin = 0.07
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)

SWEP.WalkSpeed = SPEED_SLOWER

SWEP.reloadtimer = 0
SWEP.nextreloadfinish = 0
SWEP.PukeLeft = 0
SWEP.NextPuke = 0
function SWEP:SecondaryAttack()
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	self:EmitFireSound()
	self:TakeAmmo()
	self:SetConeAndFire()
	self:DoRecoil()

	local owner = self.Owner
	self:SendWeaponAnimation()
	owner:DoAttackEvent()
	self.PukeLeft = self.Primary.NumShots
	self.Owner:EmitSound("npc/barnacle/barnacle_die2.wav")
	self.Owner:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav", 72, math.Rand(85, 95))
	self.IdleAnimation = CurTime() + self:SequenceDuration()
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
end

function SWEP:Think()
	if self.reloading and self.reloadtimer < CurTime() then
		self.reloadtimer = CurTime() + self.ReloadDelay
		self:SendWeaponAnim(ACT_VM_RELOAD)

		self.Owner:RemoveAmmo(1, self.Primary.Ammo, false)
		self:SetClip1(self:Clip1() + 1)
		self:EmitSound("Weapon_Shotgun.Reload")

		if self.Primary.ClipSize <= self:Clip1() or self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then
			self.nextreloadfinish = CurTime() + self.ReloadDelay
			self.reloading = false
			self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		end
	end

	local nextreloadfinish = self.nextreloadfinish
	if nextreloadfinish ~= 0 and nextreloadfinish < CurTime() then
		self:EmitSound("Weapon_M3.Pump")
		self:SendWeaponAnim(ACT_SHOTGUN_PUMP)
		self.nextreloadfinish = 0
	end

	if self:GetIronsights() and not self.Owner:KeyDown(IN_ATTACK2) then
		self:SetIronsights(false)
	end

	local pl = self.Owner
	local cone = self:GetCone()
	if self.PukeLeft > 0 and CurTime() >= self.NextPuke and SERVER then
		self.PukeLeft = self.PukeLeft - 1
		self.NextEmit = CurTime() + 0.1

		local ent = ents.Create("projectile_poisonflesh")
		if ent:IsValid() then
			ent:SetPos(pl:GetShootPos())
			ent:SetOwner(pl)
			ent:Spawn()
			ent.Damage = self.Primary.Damage
			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then
				local cone = math.deg(self:GetCone())
				local eyeang = self.Owner:EyeAngles()
				eyeang:RotateAroundAxis(eyeang:Forward(),util_SharedRandom("rotate"..self:EntIndex(), 0, 360))
				eyeang:RotateAroundAxis(eyeang:Up(),util_SharedRandom("bulletangle"..self:EntIndex(), -cone, cone))
				phys:Wake()
				phys:SetVelocityInstantaneous(eyeang:Forward() * 2500)
				--phys:EnableGravity(false)
			end
		end
	end

	if self.BaseClass.Think then
		self.BaseClass.Think(self)
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
		if 0 < self:Clip1() then
			self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
		else
			self:SendWeaponAnim(ACT_VM_IDLE)
		end
		self.reloading = false
		self:SetNextPrimaryFire(CurTime() + 0.25)
		return false
	end

	return true
end
