AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_inquisition_name"
	SWEP.TranslateDesc = "weapon_inquisition_desc"
	SWEP.Slot = 1
	SWEP.SlotPos = 0

	SWEP.ViewModelFOV = 60
	SWEP.ViewModelFlip = false

	SWEP.HUD3DBone = "v_weapon.FIVESEVEN_PARENT"
	SWEP.HUD3DPos = Vector(-1.3, -2.5, -3)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.02
	
	SWEP.VElements = {
		["String1"] = { type = "Model", model = "models/props_pipes/pipe03_straight01_long.mdl", bone = "v_weapon.FIVESEVEN_PARENT", rel = "base", pos = Vector(-3.185, -3.458, -0.334), angle = Angle(0, -45, 0), size = Vector(0.016, 0.104, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "cable/rope", skin = 0, bodygroup = {} },
		["backside"] = { type = "Model", model = "models/props_pipes/valve003.mdl", bone = "v_weapon.FIVESEVEN_SLIDE", rel = "", pos = Vector(0, -1, 0.5), angle = Angle(0, 0, -90), size = Vector(0.244, 0.244, 0.303), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Arc1"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve.mdl", bone = "v_weapon.FIVESEVEN_PARENT", rel = "base", pos = Vector(2.657, 5.019, 0.421), angle = Angle(180, 0, 0), size = Vector(0.079, 0.15, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "metal6", skin = 0, bodygroup = {} },
		["base"] = { type = "Model", model = "models/props_phx/trains/track_1024.mdl", bone = "v_weapon.FIVESEVEN_PARENT", rel = "", pos = Vector(0.05, -3.4, -13), angle = Angle(-90, 90, 0), size = Vector(0.025, 0.009, 0.037), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["String1+"] = { type = "Model", model = "models/props_pipes/pipe03_straight01_long.mdl", bone = "v_weapon.FIVESEVEN_PARENT", rel = "base", pos = Vector(-3.185, 3.21, -0.334), angle = Angle(0, 45, 0), size = Vector(0.016, 0.104, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "cable/rope", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/props_trainstation/pole_448connection002b.mdl", bone = "v_weapon.FIVESEVEN_PARENT", rel = "base", pos = Vector(1.258, 0, -0.41), angle = Angle(0, -90, -90), size = Vector(0.052, 0.032, 0.052), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Arc1+"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve.mdl", bone = "v_weapon.FIVESEVEN_PARENT", rel = "base", pos = Vector(2.519, -5.022, -0.997), angle = Angle(0, -180, 0), size = Vector(0.079, 0.15, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "metal6", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["String1"] = { type = "Model", model = "models/props_pipes/pipe03_straight01_long.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-3.185, -3.458, -0.334), angle = Angle(0, -45, 0), size = Vector(0.016, 0.104, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "cable/rope", skin = 0, bodygroup = {} },
		["Arc1+"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(2.519, -5.022, -0.997), angle = Angle(0, -180, 0), size = Vector(0.079, 0.15, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "metal6", skin = 0, bodygroup = {} },
		["Arc1"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(2.657, 5.019, 0.421), angle = Angle(180, 0, 0), size = Vector(0.079, 0.15, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "metal6", skin = 0, bodygroup = {} },
		["base"] = { type = "Model", model = "models/props_phx/trains/track_1024.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(14.359, 2.532, -4.744), angle = Angle(-1.55, -4.831, -180), size = Vector(0.025, 0.009, 0.037), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["String1+"] = { type = "Model", model = "models/props_pipes/pipe03_straight01_long.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-3.185, 3.21, -0.334), angle = Angle(0, 45, 0), size = Vector(0.016, 0.104, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "cable/rope", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/props_trainstation/pole_448connection002b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(1.258, 0, -0.41), angle = Angle(0, -90, -90), size = Vector(0.052, 0.032, 0.052), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["backside"] = { type = "Model", model = "models/props_pipes/valve003.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.193, 1.501, -3.806), angle = Angle(87.745, -3.271, 0), size = Vector(0.244, 0.244, 0.303), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "revolver"

SWEP.ViewModel = "models/weapons/cstrike/c_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fiveseven.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_Crossbow.Single")
SWEP.Primary.Damage = 20
SWEP.Primary.NumShots = 3
SWEP.Primary.Delay = 0.7

SWEP.Primary.ClipSize = 3
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "XBowBolt"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 0.009
SWEP.ConeMin = 0.0085
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
SWEP.Recoil = 0.8

SWEP.IronSightsPos = Vector(-6, -1, 2.25)
SWEP.ReloadSpeed = 0.9

SWEP.m_NotBulletWeapon = true

function SWEP:SetupDataTables()
	self:NetworkVar( "Int" , 10 , "RemainingShots" )
	self:NetworkVar( "Float" , 9 , "NextIqstnFire" )
	if self.BaseClass.SetupDataTables then
		self.BaseClass.SetupDataTables(self)
	end
end

function SWEP:Initialize()
	self:SetRemainingShots(0)
	self:SetNextIqstnFire(0)
	self.BaseClass.Initialize(self)
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:TakeAmmo()
	self:SendWeaponAnimation()
	self:SetRemainingShots(self.Primary.NumShots)
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.IdleAnimation = CurTime() + self:SequenceDuration()
end

function SWEP:Think()	
	local curtime = CurTime()
	local firedelay = math.min((self.Primary.Delay-0.4)/self.Primary.NumShots,0.1)
	if (self:GetNextPrimaryFire() > curtime and self:GetRemainingShots() > 0) then
		if (self:GetNextIqstnFire() < curtime) then
			self:EmitFireSound()
			self:ShootBullets(self.Primary.Damage, 1, self:GetCone())
			self:GetOwner():DoAttackEvent()
			self:SetRemainingShots(self:GetRemainingShots()-1)
			self:SetNextIqstnFire(curtime + firedelay)
		end
	end
	
	if self.BaseClass.Think then
		self.BaseClass.Think(self)
	end
end

function SWEP:ShootBullets(dmg, numbul, cone)
	local owner = self:GetOwner()
	--owner:MuzzleFlash()
	self:SetConeAndFire()
	self:DoRecoil()
	
	-- Do animations
	if IsFirstTimePredicted() then
		owner:DoAttackEvent()
	end
	
	if CLIENT then return end

	local aimvec = owner:GetAimVector()
	if SERVER then
		local ent = ents.Create("projectile_tinyarrow")
		if ent:IsValid() then
			ent:SetPos(owner:GetShootPos())
			ent:SetAngles(aimvec:Angle())
			ent:SetOwner(owner)
			ent:Spawn()
			ent.Damage = self.Primary.Damage
			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then
				phys:Wake()
				phys:SetVelocity(aimvec *2200)
			end
			--ent:SetVelocity(aimvec *2200)
		end
    end
end