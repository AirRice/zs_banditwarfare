AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_podvodny_name"
	SWEP.TranslateDesc = "weapon_podvodny_desc"
	SWEP.Slot = 3
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 50

	SWEP.HUD3DBone = "v_weapon.sg550_Parent"
	SWEP.HUD3DPos = Vector(-1.6, -5.75, -1.75)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.02
	
	SWEP.VElements = {
		["Stock+"] = { type = "Model", model = "models/props_c17/signpole001.mdl", bone = "v_weapon.sg550_Parent", rel = "Base", pos = Vector(0, -0.639, 0.531), angle = Angle(0, -90, 0), size = Vector(0.231, 0.231, 0.131), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Base+++"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "v_weapon.sg550_Parent", rel = "Base+", pos = Vector(-1.553, 0, 0), angle = Angle(0, 0, -90), size = Vector(0.111, 0.111, 0.167), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["handle"] = { type = "Model", model = "models/weapons/w_pist_usp.mdl", bone = "v_weapon.sg550_Parent", rel = "", pos = Vector(0, 1.664, 1.164), angle = Angle(-90, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Base"] = { type = "Model", model = "models/props_c17/furniturefridge001a.mdl", bone = "v_weapon.sg550_Parent", rel = "", pos = Vector(0, -4.019, -1.673), angle = Angle(0, 90, 0), size = Vector(0.128, 0.063, 0.209), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/gibs/metalgibs/metal_gibs", skin = 0, bodygroup = {} },
		["Mag"] = { type = "Model", model = "models/hunter/plates/plate05x1.mdl", bone = "v_weapon.sg550_Clip", rel = "", pos = Vector(0, 4.222, 0.254), angle = Angle(-90, 0, 0), size = Vector(0.104, 0.187, 0.158), color = Color(123, 140, 115, 255), surpresslightning = false, material = "models/props_lab/ravendoor_sheet", skin = 0, bodygroup = {} },
		["Mag+"] = { type = "Model", model = "models/props_wasteland/controlroom_filecabinet002a.mdl", bone = "v_weapon.sg550_Clip", rel = "Mag", pos = Vector(1.503, -2.656, 0), angle = Angle(0, 90, -90), size = Vector(0.134, 0.018, 0.081), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Base++++++"] = { type = "Model", model = "models/props_wasteland/laundry_basket001.mdl", bone = "v_weapon.sg550_Parent", rel = "Base+", pos = Vector(-1.553, -19.171, 0), angle = Angle(0, 0, -90), size = Vector(0.014, 0.014, 0.14), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Base+"] = { type = "Model", model = "models/props_pipes/pipe02_straight01_long.mdl", bone = "v_weapon.sg550_Parent", rel = "Base", pos = Vector(1.973, 0.381, -11.959), angle = Angle(0, 0, -90), size = Vector(0.108, 0.211, 0.108), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["Stock++"] = { type = "Model", model = "models/props_c17/signpole001.mdl", bone = "v_weapon.sg550_Parent", rel = "Base", pos = Vector(0, 0.638, 0.531), angle = Angle(0, -90, 0), size = Vector(0.231, 0.231, 0.131), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Stock"] = { type = "Model", model = "models/props_c17/playground_teetertoter_stan.mdl", bone = "v_weapon.sg550_Parent", rel = "Base", pos = Vector(0, 0, 14.833), angle = Angle(0, -90, 90), size = Vector(0.052, 0.195, 0.273), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Sight"] = { type = "Model", model = "models/props_c17/playground_teetertoter_stan.mdl", bone = "v_weapon.sg550_Parent", rel = "Base", pos = Vector(3, 0, 3), angle = Angle(0, 90, 90), size = Vector(0.032, 0.032, 0.032), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Base++"] = { type = "Model", model = "models/props_combine/combine_barricade_bracket01b.mdl", bone = "v_weapon.sg550_Parent", rel = "Base+", pos = Vector(-0.234, -5.348, 0), angle = Angle(0, 0, 0), size = Vector(0.064, 0.054, 0.164), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["Base++++"] = { type = "Model", model = "models/props_c17/canister_propane01a.mdl", bone = "v_weapon.sg550_Parent", rel = "Base+", pos = Vector(-1.553, -4.682, 0), angle = Angle(0, 0, -90), size = Vector(0.041, 0.041, 0.041), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["Base+++++"] = { type = "Model", model = "models/props_c17/signpole001.mdl", bone = "v_weapon.sg550_Parent", rel = "Base+", pos = Vector(-1.553, -4.682, 0), angle = Angle(0, 0, -90), size = Vector(0.219, 0.219, 0.109), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["bolt+"] = { type = "Model", model = "models/props_wasteland/prison_throwswitchlever001.mdl", bone = "v_weapon.sg550_Chamber", rel = "", pos = Vector(-0.773, 0.56, -3.754), angle = Angle(84.748, -8.697, 0), size = Vector(0.129, 0.217, 0.129), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["bolt"] = { type = "Model", model = "models/props_wasteland/laundry_washer003.mdl", bone = "v_weapon.sg550_Chamber", rel = "", pos = Vector(-0.8, 0.5, -2.107), angle = Angle(90, 0, 0), size = Vector(0.046, 0.03, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }

	}
	SWEP.WElements = {
		["Stock+"] = { type = "Model", model = "models/props_c17/signpole001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Base", pos = Vector(0, -0.639, 0.531), angle = Angle(0, -90, 0), size = Vector(0.231, 0.231, 0.131), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Base+++"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Base+", pos = Vector(-1.553, 0, 0), angle = Angle(0, 0, -90), size = Vector(0.111, 0.111, 0.167), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["handle"] = { type = "Model", model = "models/weapons/w_pist_usp.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Base", pos = Vector(-5.669, 0, 3.039), angle = Angle(-90, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Base"] = { type = "Model", model = "models/props_c17/furniturefridge001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.355, 0.574, -2.994), angle = Angle(-79.315, 179.434, 0), size = Vector(0.128, 0.063, 0.209), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/gibs/metalgibs/metal_gibs", skin = 0, bodygroup = {} },
		["Base+++++"] = { type = "Model", model = "models/props_c17/signpole001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Base+", pos = Vector(-1.553, -4.682, 0), angle = Angle(0, 0, -90), size = Vector(0.219, 0.219, 0.109), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Mag+"] = { type = "Model", model = "models/props_wasteland/controlroom_filecabinet002a.mdl", bone = "v_weapon.sg550_Clip", rel = "Mag", pos = Vector(1.503, -2.656, 0), angle = Angle(0, 90, -90), size = Vector(0.134, 0.018, 0.081), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Base++++++"] = { type = "Model", model = "models/props_wasteland/laundry_basket001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Base+", pos = Vector(-1.553, -19.171, 0), angle = Angle(0, 0, -90), size = Vector(0.014, 0.014, 0.14), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Mag"] = { type = "Model", model = "models/hunter/plates/plate05x1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Base", pos = Vector(-3.816, 0, -4.281), angle = Angle(-90, 0, 90), size = Vector(0.104, 0.187, 0.158), color = Color(123, 140, 115, 255), surpresslightning = false, material = "models/props_lab/ravendoor_sheet", skin = 0, bodygroup = {} },
		["Base++++"] = { type = "Model", model = "models/props_c17/canister_propane01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Base+", pos = Vector(-1.553, -4.682, 0), angle = Angle(0, 0, -90), size = Vector(0.041, 0.041, 0.041), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["Base++"] = { type = "Model", model = "models/props_combine/combine_barricade_bracket01b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Base+", pos = Vector(-0.234, -5.348, 0), angle = Angle(0, 0, 0), size = Vector(0.064, 0.054, 0.164), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["Stock"] = { type = "Model", model = "models/props_c17/playground_teetertoter_stan.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Base", pos = Vector(0, 0, 14.833), angle = Angle(0, -90, 90), size = Vector(0.052, 0.195, 0.273), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Stock++"] = { type = "Model", model = "models/props_c17/signpole001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Base", pos = Vector(0, 0.638, 0.531), angle = Angle(0, -90, 0), size = Vector(0.231, 0.231, 0.131), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Base+"] = { type = "Model", model = "models/props_pipes/pipe02_straight01_long.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Base", pos = Vector(1.973, 0.381, -11.959), angle = Angle(0, 0, -90), size = Vector(0.108, 0.211, 0.108), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} }
	}


end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/cstrike/c_snip_sg550.mdl"
SWEP.WorldModel = "models/weapons/w_snip_sg550.mdl"
SWEP.UseHands = true
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.ReloadSound = Sound("Weapon_AWP.ClipOut")
SWEP.Primary.Sound = Sound("npc/env_headcrabcanister/launch.wav")
SWEP.Primary.Damage = 36
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.26
SWEP.Recoil = 0.79
SWEP.DefaultRecoil = 0.89
SWEP.Primary.ClipSize = 26
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "XBowBolt"
SWEP.Primary.DefaultClip = 52
SWEP.ReloadSpeed = 1.25
SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN

SWEP.ConeMax = 0.003
SWEP.ConeMin = 0.001

GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)

SWEP.IronSightsPos = Vector(-7.4, 20, 1.3)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.WalkSpeed = SPEED_SLOWER
SWEP.IgnoreDamageScaling = true
SWEP.TracerName = "AR2Tracer"

function SWEP:EmitFireSound()
	self:EmitSound(self.Primary.Sound, 75, math.random(217, 233), 0.7)
	self:EmitSound("npc/waste_scanner/grenade_fire.wav", 75, math.random(182, 228), 0.4, CHAN_WEAPON + 20)
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
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
		local ent = ents.Create("projectile_bleedbolt")
		if ent:IsValid() then
			ent:SetPos(owner:GetShootPos())
			ent:SetAngles(aimvec:Angle())
			ent:SetOwner(owner)
			ent:Spawn()
			ent.Damage = self.Primary.Damage
			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then
				phys:Wake()
				phys:SetVelocity(aimvec *2300)
			end
			--ent:SetVelocity(aimvec *2200)
		end
    end
	self.IdleAnimation = CurTime() + self:SequenceDuration()
end