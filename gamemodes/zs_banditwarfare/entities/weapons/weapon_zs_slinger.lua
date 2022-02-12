AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_slinger_name"
	SWEP.TranslateDesc = "weapon_slinger_desc"
	SWEP.HUD3DBone = "v_weapon.p228_Slide"
	SWEP.HUD3DPos = Vector(-1.4, 0.15, 0)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.017

	SWEP.VElements = {
		["BACKING+"] = { type = "Model", model = "models/props_wasteland/light_spotlight02_base.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "train", pos = Vector(-0.101, -1.787, -0.027), angle = Angle(111.536, 90, 0), size = Vector(0.18, 0.504, 1.327), color = Color(75, 75, 75, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
		["BOLT"] = { type = "Model", model = "models/crossbow_bolt.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "train", pos = Vector(-0.042, 11.982, 1.141), angle = Angle(0, 90, 0), size = Vector(0.65, 0.65, 0.65), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["train"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "v_weapon.p228_Parent", rel = "", pos = Vector(0, -3.579, -2.291), angle = Angle(180, 0, -90), size = Vector(0.023, 0.019, 0.009), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
		["backa"] = { type = "Model", model = "models/props_wasteland/tram_bracket01.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "train", pos = Vector(-0.065, 4.964, 0.18), angle = Angle(0, -90, 0), size = Vector(0.043, 0.043, 0.043), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
		["BACKING"] = { type = "Model", model = "models/props_wasteland/light_spotlight02_base.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "train", pos = Vector(-0.062, -3.317, 1.368), angle = Angle(93.779, 90, 0), size = Vector(0.18, 0.504, 1.327), color = Color(75, 75, 75, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["BACKING+"] = { type = "Model", model = "models/props_wasteland/light_spotlight02_base.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "train", pos = Vector(-0.101, -1.787, -0.027), angle = Angle(111.536, 90, 0), size = Vector(0.18, 0.504, 1.327), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
		["BOLT"] = { type = "Model", model = "models/crossbow_bolt.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "train", pos = Vector(-0.042, 11, 1.141), angle = Angle(0, 90, 0), size = Vector(0.65, 0.65, 0.65), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["train"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7.178, 1.909, -3.55), angle = Angle(180, 85.359, -2.799), size = Vector(0.023, 0.019, 0.009), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
		["BACKING"] = { type = "Model", model = "models/props_wasteland/light_spotlight02_base.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "train", pos = Vector(-0.062, -3.317, 1.368), angle = Angle(93.779, 90, 0), size = Vector(0.18, 0.504, 1.327), color = Color(75, 75, 75, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
		["backa"] = { type = "Model", model = "models/props_wasteland/tram_bracket01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "train", pos = Vector(-0.065, 4.964, 0.18), angle = Angle(0, -90, 0), size = Vector(0.043, 0.043, 0.043), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} }
	}

	SWEP.ViewModelFOV = 65
	SWEP.ViewModelFlip = false

	SWEP.Slot = 1
	SWEP.SlotPos = 0
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "revolver"

SWEP.ViewModel = "models/weapons/cstrike/c_pist_p228.mdl"
SWEP.WorldModel = "models/weapons/w_pist_p228.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_Crossbow.Single")
SWEP.Primary.Damage = 50
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.5

SWEP.Primary.ClipSize = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "XBowBolt"
SWEP.Primary.DefaultClip = 5

SWEP.ConeMax = 0.009
SWEP.ConeMin = 0.0085
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
SWEP.Recoil = 1.3
SWEP.CSMuzzleFlashes = false
SWEP.IronSightsPos = Vector(-6, -1, -1.25)

SWEP.ReloadSpeed = 0.8

function SWEP:SendReloadAnimation()
	self:SendWeaponAnim(ACT_VM_DRAW)
end

function SWEP:EmitReloadFinishSound()
	if IsFirstTimePredicted() then
		self:EmitSound("weapons/galil/galil_boltpull.wav", 70, 190)
	end
end

function SWEP:EmitReloadSound()
	if IsFirstTimePredicted() then
		self:EmitSound("weapons/g3sg1/g3sg1_clipout.wav", 70, 135, 0.9, CHAN_AUTO)
	end
end

function SWEP:EmitFireSound()
	self:EmitSound("weapons/crossbow/fire1.wav", 70, 160, 0.9, CHAN_WEAPON)
end

util.PrecacheSound("weapons/crossbow/bolt_load1.wav")
util.PrecacheSound("weapons/crossbow/bolt_load2.wav")

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:SetNextReload(CurTime() + self.Primary.Delay)
	self:EmitFireSound()	
	self:TakeAmmo()
	local dmg = self.Primary.Damage
	self:SetConeAndFire()
	self:DoRecoil()

	local owner = self:GetOwner()
	--owner:MuzzleFlash()
	self:SendWeaponAnimation()
	owner:DoAttackEvent()
	local aimvec = owner:GetAimVector()
	if SERVER then
		local ent = ents.Create("projectile_slingerbolt")
		if ent:IsValid() then
			ent:SetPos(owner:GetShootPos())
			ent:SetAngles(aimvec:Angle())
			ent:SetOwner(owner)
			ent:Spawn()
			ent.Damage = self.Primary.Damage
			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then
				phys:Wake()
				phys:AddVelocity(aimvec * 4400)
			end
			--ent:SetVelocity(aimvec *2200)
		end
    end
	self.IdleAnimation = CurTime() + self:SequenceDuration()
end

if CLIENT then
	function SWEP:PostDrawViewModel(vm, pl, wep)
		local veles = self.VElements

		local boltpos = veles["BOLT"].pos
		local backang = veles["BACKING"].angle

		local time = CurTime()
		local reloadfinish = self:GetReloadFinish()
		local reloadstart = self:GetReloadStart()

		local col1, col2 = Color(0, 0, 0, 0), Color(255, 255, 255, 255)
		if (reloadfinish == 0 and self:Clip1() < 1) or (reloadfinish - time * 5) > (time - reloadstart) then
			veles["BOLT"].color = col1
		else
			veles["BOLT"].color = col2
		end

		if time < reloadfinish then
			local lowertime = math.min(reloadfinish - time, time - reloadstart)
			local delta = math.Clamp(lowertime * 4 / (reloadfinish - reloadstart), 0, 1)

			boltpos.y = Lerp(delta, 11, 5)
			backang.pitch = Lerp(delta, 105, 120)
		else
			boltpos.y = 11
			backang.pitch = 95
		end
		if self.BaseClass.PostDrawViewModel then 
			self.BaseClass.PostDrawViewModel(self,vm, pl, wep)
		end
	end
end
   