AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_severance_name"
	SWEP.TranslateDesc = "weapon_severance_desc"
	SWEP.Slot = 3
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "ValveBiped.Gun"
	SWEP.HUD3DPos = Vector(3.1, -1, -8)
	SWEP.HUD3DScale = 0.025

	SWEP.ViewModelFlip = false

	SWEP.VElements = {
		["Body+"] = { type = "Model", model = "models/props_vents/vent_large_corner001.mdl", bone = "ValveBiped.Gun", rel = "Body", pos = Vector(0, 4.432, 1.851), angle = Angle(-90, 0, 0), size = Vector(0.104, 0.075, 0.123), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["Noz++"] = { type = "Model", model = "models/props_phx/misc/potato_launcher_chamber.mdl", bone = "ValveBiped.Bip01", rel = "Body++++", pos = Vector(0, 0, -16.031), angle = Angle(0, 0, 0), size = Vector(0.194, 0.194, 0.316), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_junk/vent001", skin = 0, bodygroup = {} },
		["Body++"] = { type = "Model", model = "models/props_vents/vent_large_corner001.mdl", bone = "ValveBiped.Gun", rel = "Body", pos = Vector(0, 0, -3.306), angle = Angle(90, -180, 0), size = Vector(0.104, 0.075, 0.123), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["Body"] = { type = "Model", model = "models/props_wasteland/medbridge_post01.mdl", bone = "ValveBiped.Gun", rel = "", pos = Vector(0, 0, -9.941), angle = Angle(0, 0, 0), size = Vector(0.07, 0.149, 0.226), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["Body++++++"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "ValveBiped.Gun", rel = "Body", pos = Vector(-1.601, -0.861, 7), angle = Angle(180, 90, 0), size = Vector(0.326, 0.316, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["Body++++"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "ValveBiped.Gun", rel = "Body", pos = Vector(0, 1.473, 7), angle = Angle(180, 90, 0), size = Vector(0.326, 0.326, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["Noz"] = { type = "Model", model = "models/props_phx/misc/potato_launcher_chamber.mdl", bone = "ValveBiped.Bip01", rel = "Body++++++", pos = Vector(0, 0, -16.031), angle = Angle(0, 0, 0), size = Vector(0.194, 0.194, 0.316), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_junk/vent001", skin = 0, bodygroup = {} },
		["Noz+"] = { type = "Model", model = "models/props_phx/misc/potato_launcher_chamber.mdl", bone = "ValveBiped.Bip01", rel = "Body+++++", pos = Vector(0, 0, -16.031), angle = Angle(0, 0, 0), size = Vector(0.194, 0.194, 0.316), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_junk/vent001", skin = 0, bodygroup = {} },
		["Body+++++++"] = { type = "Model", model = "models/hunter/triangles/1x1mirrored.mdl", bone = "ValveBiped.Gun", rel = "Body", pos = Vector(0, 0.825, 23.127), angle = Angle(0, 90, 0), size = Vector(0.128, 0.079, 0.128), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["Body+++"] = { type = "Model", model = "models/props_lab/harddrive02.mdl", bone = "ValveBiped.Gun", rel = "Body", pos = Vector(0, 3.947, -7.65), angle = Angle(180, 90, 0), size = Vector(0.326, 0.316, 0.611), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["Body+++++"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "ValveBiped.Gun", rel = "Body", pos = Vector(1.6, -0.861, 7), angle = Angle(180, 90, 0), size = Vector(0.326, 0.316, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["Body+"] = { type = "Model", model = "models/props_vents/vent_large_corner001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Body", pos = Vector(0, 4.432, 1.851), angle = Angle(-90, 0, 0), size = Vector(0.104, 0.075, 0.123), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["Noz++"] = { type = "Model", model = "models/props_phx/misc/potato_launcher_chamber.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Body++++", pos = Vector(0, 0, -16.031), angle = Angle(0, 0, 0), size = Vector(0.194, 0.194, 0.316), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_junk/vent001", skin = 0, bodygroup = {} },
		["Body++"] = { type = "Model", model = "models/props_vents/vent_large_corner001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Body", pos = Vector(0, 0, -3.306), angle = Angle(90, -180, 0), size = Vector(0.104, 0.075, 0.123), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["Body"] = { type = "Model", model = "models/props_wasteland/medbridge_post01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.137, 1.937, -4.875), angle = Angle(0, -84.988, -100.706), size = Vector(0.07, 0.149, 0.216), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["Body++++++"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Body", pos = Vector(-1.601, -0.861, 7), angle = Angle(180, 90, 0), size = Vector(0.326, 0.316, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["Body++++"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Body", pos = Vector(0, 1.473, 7), angle = Angle(180, 90, 0), size = Vector(0.326, 0.326, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["Noz"] = { type = "Model", model = "models/props_phx/misc/potato_launcher_chamber.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Body++++++", pos = Vector(0, 0, -16.031), angle = Angle(0, 0, 0), size = Vector(0.194, 0.194, 0.316), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_junk/vent001", skin = 0, bodygroup = {} },
		["Noz+"] = { type = "Model", model = "models/props_phx/misc/potato_launcher_chamber.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Body+++++", pos = Vector(0, 0, -16.031), angle = Angle(0, 0, 0), size = Vector(0.194, 0.194, 0.316), color
		= Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_junk/vent001", skin = 0, bodygroup = {} },
		["Body+++++"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Body", pos = Vector(1.6, -0.861, 7), angle = Angle(180, 90, 0), size = Vector(0.326, 0.316, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["Body+++"] = { type = "Model", model = "models/props_lab/harddrive02.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Body", pos = Vector(0, 3.947, -7.65), angle = Angle(180, 90, 0), size = Vector(0.326, 0.316, 0.611), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["Body+++++++"] = { type = "Model", model = "models/hunter/triangles/1x1mirrored.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Body", pos = Vector(0, 0.825, 23.127), angle = Angle(0, 90, 0), size = Vector(0.128, 0.079, 0.128), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} }
	}

end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "shotgun"

SWEP.ViewModel = "models/weapons/c_shotgun.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"
SWEP.UseHands = true
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.Primary.Sound = Sound("weapons/shotgun/shotgun_dbl_fire.wav")
SWEP.Primary.Damage = 9
SWEP.Primary.NumShots = 10
SWEP.Primary.Delay = 0.9
SWEP.ReloadDelay = 0.4
SWEP.Recoil = 1.72
SWEP.Primary.ClipSize = 5
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "buckshot"
GAMEMODE:SetupDefaultClip(SWEP.Primary)
SWEP.ReloadSound = Sound("weapons/aug/aug_boltslap.wav")
SWEP.SelfKnockBackForce = 220
SWEP.ConeMax = 0.07
SWEP.ConeMin = 0.05
SWEP.MovingConeOffset = 0.1
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)

SWEP.WalkSpeed = SPEED_SLOWEST

function SWEP.BulletCallback(attacker, tr, dmginfo)
	local ent = tr.Entity
	local phys = ent:GetPhysicsObject()
	if ent:IsValid() and ent:IsPlayer() and ent:Team() ~= attacker:Team() and SERVER then
		local invuln = ent:GetStatus("spawnbuff")
		if not (invuln and invuln:IsValid()) then
			local pushvel = tr.Normal * 50
			pushvel.z = math.max(pushvel.z, 10)
			ent:SetGroundEntity(nil)
			ent:SetLocalVelocity(ent:GetVelocity() + pushvel)
		end
	elseif IsValid(phys) then
		phys:AddVelocity(phys:GetVelocity() + tr.Normal * 5)
	end
	GenericBulletCallback(attacker, tr, dmginfo)
end


function SWEP:EmitFireSound()
	self:EmitSound(self.Primary.Sound, 75, math.random(117, 133), 0.7)
	self:EmitSound("weapons/shotgun/shotgun_fire6.wav", 75, math.random(102, 148), 0.6, CHAN_WEAPON + 20)
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
	self:EmitSound(self.ReloadSound)
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

function SWEP:SecondaryAttack()
end
