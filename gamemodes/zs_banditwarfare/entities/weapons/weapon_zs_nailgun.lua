AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_nailgun_name"
	SWEP.TranslateDesc = "weapon_nailgun_desc"
	SWEP.Slot = 1
	SWEP.SlotPos = 0
	
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60
	
	SWEP.HUD3DBone = "ValveBiped.square"
	SWEP.HUD3DPos = Vector(1.1, 0.25, -2)
	SWEP.HUD3DScale = 0.015
	SWEP.VElements = {
		["slidecover3"] = { type = "Model", model = "models/props_junk/metalbucket02a.mdl", bone = "ValveBiped.hammer", rel = "back", pos = Vector(0, -0.4, 7), angle = Angle(0, 0, -90), size = Vector(0.06, 0.3, 0.143), color = Color(255, 170, 0, 255), surpresslightning = false, material = "models/props_c17/canister_propane01a", skin = 0, bodygroup = {} },
		["back"] = { type = "Model", model = "models/props_c17/canister_propane01a.mdl", bone = "ValveBiped.hammer", rel = "element_name", pos = Vector(0, -8, -4.666), angle = Angle(0, 0, 90), size = Vector(0.083, 0.083, 0.052), color = Color(255, 170, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["element_name"] = { type = "Model", model = "models/props_pipes/pipe03_lcurve02_short.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7.131, 1.399, 1.042), angle = Angle(0, 90, 0), size = Vector(0.045, 0.074, 0.083), color = Color(255, 170, 0, 255), surpresslightning = false, material = "models/props_c17/consolebox01a", skin = 0, bodygroup = {} },
		["nozzle"] = { type = "Model", model = "models/props_junk/ibeam01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "slidecover3", pos = Vector(0, 3.5, 0), angle = Angle(0, 90, 0), size = Vector(0.07, 0.07, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/chairchrome01", skin = 0, bodygroup = {} }
	}
end
SWEP.WElements = {
	["slidecover3"] = { type = "Model", model = "models/props_junk/metalbucket02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.63, 2.119, -3.625), angle = Angle(0, 90, 5.002), size = Vector(0.093, 0.218, 0.123), color = Color(255, 170, 0, 255), surpresslightning = false, material = "models/props_c17/canister_propane01a", skin = 0, bodygroup = {} },
	["nozzle"] = { type = "Model", model = "models/props_junk/ibeam01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10.477, 2.201, -4.301), angle = Angle(-4.928, 0, 85.244), size = Vector(0.03, 0.075, 0.075), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/chairchrome01", skin = 0, bodygroup = {} },
	["element_name"] = { type = "Model", model = "models/props_pipes/pipe03_lcurve02_short.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.354, 1.514, 0.699), angle = Angle(-5.206, 90, 0), size = Vector(0.045, 0.074, 0.083), color = Color(255, 170, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["back"] = { type = "Model", model = "models/props_c17/canister_propane01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.106, 1.95, -2.876), angle = Angle(-95.669, 0, 0), size = Vector(0.104, 0.104, 0.064), color = Color(255, 170, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
sound.Add(
{
	name = "Weapon_Nailgun.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	soundlevel = 100,
	pitch = {100,120},
	sound = "ambient/machines/catapult_throw.wav"
})
SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "pistol"

SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false
SWEP.Primary.ClipSize = 3
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "GaussEnergy"
SWEP.Primary.Sound = Sound("Weapon_Nailgun.Single")
SWEP.ReloadSound = Sound("weapons/357/357_reload3.wav")
SWEP.Primary.Damage = 20
SWEP.Primary.Delay = 0.5     
SWEP.Primary.DefaultClip = 10
SWEP.Recoil = 1.8
SWEP.Primary.KnockbackScale = 3
SWEP.ConeMax = 0.02
SWEP.ConeMin = 0.005
SWEP.MovingConeOffset = 0.03
SWEP.IronSightsPos = Vector(-5.95, 3, 2.75)
SWEP.IronSightsAng = Vector(-0.15, -1, 2)
SWEP.NailSize = 0.875
function SWEP:CanPrimaryAttack()
	if self:GetOwner():GetBarricadeGhosting() then return false end
	if self:Clip1() < self.RequiredClip then
		self:EmitSound("Weapon_Pistol.Empty")
		self:SetNextPrimaryFire(CurTime() + math.max(0.25, self.Primary.Delay))
		return false
	end
	return self:GetNextPrimaryFire() <= CurTime()
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end 
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:EmitFireSound()
	self:TakeAmmo()
	local tr = self:GetOwner():CompensatedMeleeTrace(128, self.NailSize, nil, nil)
	if self:GetOwner():IsHolding() and self:GetOwner():AttemptNail(tr) then
		self:ShootNormalBullets(self.Primary.Damage, self.Primary.NumShots, self:GetCone())
	else 
		self:ShootBullets(self.Primary.Damage, self.Primary.NumShots, self:GetCone())
	end
	self.IdleAnimation = CurTime() + self:SequenceDuration()
	self:SetNextReload(self.IdleAnimation+0.2)
end

function SWEP:ShootNormalBullets(dmg, numbul, cone)	
	self._BulletCallback = self.BulletCallback
	self.BulletCallback = GenericBulletCallback
	self.BaseClass.ShootBullets(self,dmg,numbul,cone)
	self.BulletCallback = self._BulletCallback
end

function SWEP.BulletCallback(attacker, tr, dmginfo)
	local trent = tr.Entity
		local effectdata = EffectData()
		effectdata:SetOrigin(tr.HitPos)
		effectdata:SetNormal(tr.HitNormal)
	util.Effect("MetalSpark", effectdata)
	
	if attacker:IsPlayer() then
		attacker:AttemptNail(tr) 		
	end
	LeaveNailBulletCallback(attacker, tr, dmginfo)
end

function LeaveNailBulletCallback(attacker, tr, dmginfo)
	if tr.HitWorld and SERVER then
		local nail = ents.Create("prop_nail_pickuppable")
		if nail:IsValid() then
			nail:SetPos(tr.HitPos + tr.HitNormal * 14)
			nail:SetAngles((tr.HitNormal*-1):Angle())
			nail:Spawn()
		end
	end
	GenericBulletCallback(attacker, tr, dmginfo)
end
