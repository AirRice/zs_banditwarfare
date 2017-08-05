AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "유탄발사기"
	SWEP.Description = "유탄을 정확하게 발사한다."
	SWEP.Slot = 3
	SWEP.SlotPos = 0
	SWEP.ViewModelFOV = 60
	SWEP.ViewModelFlip = false

	SWEP.HUD3DBone = "ValveBiped.Gun"
	SWEP.HUD3DPos = Vector(1.75, 1, -5)
	SWEP.HUD3DAng = Angle(180, 0, 0)
	SWEP.HUD3DScale = 0.035
	SWEP.VElements = {
		["Sights+"] = { type = "Model", model = "models/props_wasteland/woodwall030b_window01a_bars.mdl", bone = "ValveBiped.Gun", rel = "Barrel", pos = Vector(-0.055, -5.848, -2.596), angle = Angle(0, 0, 90), size = Vector(0.061, 0.061, 0.123), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Sights"] = { type = "Model", model = "models/props_wasteland/woodwall030b_window01b.mdl", bone = "ValveBiped.Gun", rel = "Barrel", pos = Vector(-0.055, -4.644, -2.187), angle = Angle(0, 0, 90), size = Vector(0.061, 0.061, 0.174), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Barrel"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "ValveBiped.Gun", rel = "", pos = Vector(0, 0, 11.427), angle = Angle(0, 0, 0), size = Vector(0.3, 0.3, 0.619), color = Color(100, 100, 100, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Barrel+"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "ValveBiped.Gun", rel = "Barrel", pos = Vector(0, 1.472, -1.402), angle = Angle(0, 0, 0), size = Vector(0.319, 0.319, 0.319), color = Color(100, 100, 100, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Barreltip"] = { type = "Model", model = "models/props_c17/furniturefridge001a.mdl", bone = "ValveBiped.Gun", rel = "Barrel", pos = Vector(0, 1.6, 10.116), angle = Angle(90, 90, 0), size = Vector(0.437, 0.097, 0.041), color = Color(125, 91, 89, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["Sights+"] = { type = "Model", model = "models/props_wasteland/woodwall030b_window01a_bars.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Barrel", pos = Vector(-0.055, -5.848, -2.596), angle = Angle(0, 0, 90), size = Vector(0.061, 0.061, 0.123), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Sights"] = { type = "Model", model = "models/props_wasteland/woodwall030b_window01b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Barrel", pos = Vector(-0.055, -4.644, -2.187), angle = Angle(0, 0, 90), size = Vector(0.061, 0.061, 0.174), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Barrel"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(20.077, 1.394, -6.341), angle = Angle(0, -88.552, -96.692), size = Vector(0.324, 0.338, 0.467), color = Color(100, 100, 100, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Barrel+"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Barrel", pos = Vector(0, 1.472, -5.902), angle = Angle(0, 0, 0), size = Vector(0.375, 0.375, 0.284), color = Color(100, 100, 100, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Barreltip"] = { type = "Model", model = "models/props_c17/furniturefridge001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Barrel", pos = Vector(0, 1.6, 5.454), angle = Angle(90, 90, 0), size = Vector(0.395, 0.075, 0.064), color = Color(125, 91, 89, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/v_annabelle.mdl"
SWEP.WorldModel = "models/weapons/w_annabelle.mdl"

SWEP.Primary.Sound = Sound("weapons/grenade_launcher1.wav", 70, 90)
SWEP.Primary.Damage = 192
SWEP.Primary.NumShots = 0
SWEP.Primary.Delay = 1

SWEP.Primary.ClipSize = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "grenlauncher"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 0
SWEP.ConeMin = 0

SWEP.Recoil = 1.65
SWEP.IronSightsPos = Vector(-9.08, 0, -1.28)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.WalkSpeed = SPEED_SLOWER

function SWEP:ShootBullets(dmg, numbul, cone)
	local owner = self.Owner
	--owner:MuzzleFlash()
	if SERVER then
		self:SetConeAndFire()
	end
	self:DoRecoil()
	self:SendWeaponAnimation()
	owner:DoAttackEvent()

	if SERVER then
		local ent = ents.Create("projectile_launchedgrenade")
		if ent:IsValid() then
			ent:SetPos(owner:GetShootPos())
			ent:SetAngles(owner:GetAimVector():Angle())
			ent:SetOwner(owner)
			ent:Spawn()
			ent.GrenadeDamage = dmg
			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then
				phys:Wake()
				phys:SetVelocityInstantaneous(self.Owner:GetAimVector() * 1200)
			end
		end
	end
end
function SWEP:Reload()
	if self.Owner:IsHolding() then return end

	if self:GetIronsights() then
		self:SetIronsights(false)
	end

	if self:GetNextReload() <= CurTime() and self:DefaultReload(ACT_VM_RELOAD) then
		self.Owner:GetViewModel():SetPlaybackRate(0.2)
		self:EmitSound("vehicles/tank_readyfire1.wav", 70, 130)
		self.IdleAnimation = CurTime() + self:SequenceDuration()*5+0.3
		self:SetNextPrimaryFire(self.IdleAnimation)
		self:SetNextReload(self.IdleAnimation)
		self.Owner:DoReloadEvent()
		if self.ReloadSound then
			self:EmitSound(self.ReloadSound)
		end
	end
	self:ResetConeAdder()
end