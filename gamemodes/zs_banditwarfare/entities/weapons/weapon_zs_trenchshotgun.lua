AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_trenchgun_name"
	SWEP.TranslateDesc = "weapon_trenchgun_desc"
	SWEP.Slot = 3
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 53
	SWEP.ViewModelBoneMods = {
		["v_weapon.M3_SHELL"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0)}
	}
	SWEP.HUD3DBone = "v_weapon.M3_PARENT"
	SWEP.HUD3DPos = Vector(-1, -4.5, -4)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.015
	
	SWEP.VElements = {
		["Main+++"] = { type = "Model", model = "models/props_c17/canister02a.mdl", bone = "v_weapon.M3_PARENT", rel = "Main", pos = Vector(0, 0.653, -4.881), angle = Angle(0, 0, 180), size = Vector(0.115, 0.115, 0.188), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/concrete1", skin = 0, bodygroup = {} },
		["Pump"] = { type = "Model", model = "models/props_borealis/bluebarrel002.mdl", bone = "v_weapon.M3_PUMP", rel = "", pos = Vector(0, -0.2, -4.75), angle = Angle(0, 0, 0), size = Vector(0.055, 0.055, 0.097), color = Color(103, 103, 103, 255), surpresslightning = false, material = "phoenix_storms/wood_side", skin = 0, bodygroup = {} },
		["Main+++++"] = { type = "Model", model = "models/mechanics/articulating/arm_base_b.mdl", bone = "v_weapon.M3_PARENT", rel = "Main", pos = Vector(0, -1.043, 8.626), angle = Angle(0, 0, -90), size = Vector(0.014, 0.014, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["Main"] = { type = "Model", model = "models/hunter/misc/roundthing2.mdl", bone = "v_weapon.M3_PARENT", rel = "", pos = Vector(0, -4.128, -8.877), angle = Angle(0, 0, 0), size = Vector(0.028, 0.018, 0.228), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["Main++++++"] = { type = "Model", model = "models/hunter/triangles/1x1.mdl", bone = "v_weapon.M3_PARENT", rel = "Main", pos = Vector(0, -1.43, -13.778), angle = Angle(90, -90, 90), size = Vector(0.014, 0.014, 0.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["Main++"] = { type = "Model", model = "models/props_docks/dock01_pole01a_256.mdl", bone = "v_weapon.M3_PARENT", rel = "Main", pos = Vector(0, -0.644, -7.369), angle = Angle(0, 0, -180), size = Vector(0.064, 0.064, 0.064), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/concrete1", skin = 0, bodygroup = {} },
		["Grip"] = { type = "Model", model = "models/weapons/w_pist_glock18.mdl", bone = "v_weapon.M3_PARENT", rel = "", pos = Vector(0, 1.832, 0.917), angle = Angle(-90, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Main+"] = { type = "Model", model = "models/props_c17/pottery05a.mdl", bone = "v_weapon.M3_PARENT", rel = "Main", pos = Vector(0, 0.008, 13.291), angle = Angle(180, 0, 0), size = Vector(0.1, 0.216, 0.338), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["Main+++++++"] = { type = "Model", model = "models/props_c17/pipe_cap003.mdl", bone = "v_weapon.M3_PARENT", rel = "Main++", pos = Vector(0, 0, 8.215), angle = Angle(90, 0, 5.843), size = Vector(0.071, 0.071, 0.071), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Bolt+"] = { type = "Model", model = "models/props_c17/playground_teetertoter_stan.mdl", bone = "v_weapon.M3_PUMP", rel = "Bolt", pos = Vector(-0.08, 0.021, -0.491), angle = Angle(-180, 7.988, 0), size = Vector(0.067, 0.067, 0.037), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["Bolt"] = { type = "Model", model = "models/props_c17/furniturebathtub001a.mdl", bone = "v_weapon.M3_PUMP", rel = "Pump", pos = Vector(-0.524, -1.297, 9.173), angle = Angle(-90, 0, 0), size = Vector(0.056, 0.035, 0.064), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["Main++++"] = { type = "Model", model = "models/props_c17/substation_transformer01b.mdl", bone = "v_weapon.M3_PARENT", rel = "Main", pos = Vector(0, 0.004, -9.565), angle = Angle(-90.125, 0, 180), size = Vector(0.009, 0.014, 0.013), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["Main+++"] = { type = "Model", model = "models/props_c17/canister02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Main", pos = Vector(0, 0.653, -3.836), angle = Angle(0, 0, 180), size = Vector(0.115, 0.115, 0.134), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/concrete1", skin = 0, bodygroup = {} },
		["Pump"] = { type = "Model", model = "models/props_borealis/bluebarrel002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Main+++", pos = Vector(-0.002, 0, 0.263), angle = Angle(-180, 180, 0), size = Vector(0.064, 0.064, 0.064), color = Color(103, 103, 103, 255), surpresslightning = false, material = "phoenix_storms/wood_side", skin = 0, bodygroup = {} },
		["Main+++++"] = { type = "Model", model = "models/weapons/w_pist_glock18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Main", pos = Vector(-0.003, 6.166, 8.706), angle = Angle(-90, -90, -180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Main"] = { type = "Model", model = "models/hunter/misc/roundthing2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12.204, 1.664, -5.079), angle = Angle(0, 91.536, -82.561), size = Vector(0.028, 0.018, 0.228), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["Main++"] = { type = "Model", model = "models/props_docks/dock01_pole01a_256.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Main", pos = Vector(0, -0.644, -4.924), angle = Angle(0, 0, -180), size = Vector(0.064, 0.064, 0.074), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/concrete1", skin = 0, bodygroup = {} },
		["Main+"] = { type = "Model", model = "models/props_c17/pottery05a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Main", pos = Vector(0, 0.008, 13.291), angle = Angle(180, 0, 0), size = Vector(0.1, 0.216, 0.338), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["Main++++"] = { type = "Model", model = "models/props_c17/substation_transformer01b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Main", pos = Vector(0, 0.004, -6.753), angle = Angle(-90.125, 0, 180), size = Vector(0.009, 0.014, 0.013), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["Main+++++++"] = { type = "Model", model = "models/props_c17/pipe_cap003.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Main++", pos = Vector(0, 0, 9.298), angle = Angle(90, 0, 5.843), size = Vector(0.071, 0.071, 0.071), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Bolt+"] = { type = "Model", model = "models/props_c17/playground_teetertoter_stan.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Bolt", pos = Vector(-0.08, 0.021, -0.491), angle = Angle(-180, 7.988, 0), size = Vector(0.067, 0.067, 0.037), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["Bolt"] = { type = "Model", model = "models/props_c17/furniturebathtub001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Pump", pos = Vector(-0.524, -1.297, 6.822), angle = Angle(-90, 0, 0), size = Vector(0.056, 0.035, 0.075), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} }
	}

end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "shotgun"

SWEP.ViewModel = "models/weapons/cstrike/c_shot_m3super90.mdl"
SWEP.WorldModel = "models/weapons/w_shot_m3super90.mdl"
SWEP.UseHands = true
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.ReloadDelay = 0.45

SWEP.Primary.Sound = Sound("Weapon_M3.Single")
SWEP.Primary.Damage = 6
SWEP.Primary.NumShots = 9
SWEP.Primary.Delay = 0.65
SWEP.Recoil = 4
SWEP.Primary.ClipSize = 4
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "buckshot"
GAMEMODE:SetupDefaultClip(SWEP.Primary)
SWEP.FireAnimSpeed = 1.3
SWEP.ConeMax = 0.123
SWEP.ConeMin = 0.06
SWEP.MovingConeOffset = 0.07
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
SWEP.AimExpandStayDuration = 0.002
SWEP.Recoil = 2.89
SWEP.WalkSpeed = SPEED_SLOWER
SWEP.SelfKnockBackForce = 120
SWEP.nextreloadfinish = 0

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

function SWEP:EmitFireSound()
	self:EmitSound(")weapons/m3/m3-1.wav", 75, math.random(127, 133), 0.7)
	self:EmitSound("weapons/shotgun/shotgun_dbl_fire7.wav", 75, math.random(82, 98), 0.8, CHAN_WEAPON + 20)
end

function SWEP:SecondaryAttack()
end
