AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_renegade_name"
	SWEP.TranslateDesc = "weapon_renegade_desc"
	SWEP.Slot = 3
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "v_weapon.sg550_Parent"
	SWEP.HUD3DPos = Vector(-2, -5.2, -2)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.02

	SWEP.VElements = {
		["kickstand_hold"] = { type = "Model", model = "models/Mechanics/robotics/a1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "canister_front", pos = Vector(-0.242, 0, 4.394), angle = Angle(0, 90, 90), size = Vector(0.254, 0.144, 0.144), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["scopebase"] = { type = "Model", model = "models/Mechanics/roboticslarge/g1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scope", pos = Vector(-2.064, 0, -0.262), angle = Angle(0, 0, 90), size = Vector(0.061, 0.037, 0.129), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },
		["kickstand"] = { type = "Model", model = "models/props_c17/metalladder002b.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "barrel", pos = Vector(-6.031, 0, 25.576), angle = Angle(135, 0, 180), size = Vector(0.164, 0.245, 0.368), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["clip"] = { type = "Model", model = "models/props_c17/consolebox01a.mdl", bone = "v_weapon.sg550_Clip", rel = "", pos = Vector(0.902, 3.177, 0.266), angle = Angle(0, 90, -90), size = Vector(0.104, 0.134, 0.15), color = Color(125, 155, 135, 255), surpresslightning = false, material = "models/props_c17/canister_propane01a", skin = 0, bodygroup = {} },
		["canister_front"] = { type = "Model", model = "models/props_c17/canister_propane01a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scope", pos = Vector(0.779, 0, -1.066), angle = Angle(-90, 0, 0), size = Vector(0.1, 0.1, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },
		["scope"] = { type = "Model", model = "models/props_lab/citizenradio.mdl", bone = "v_weapon.sg550_Parent", rel = "", pos = Vector(0, -6.222, -4.554), angle = Angle(-90, 90, 0), size = Vector(0.731, 0.127, 0.182), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["bottom_grip"] = { type = "Model", model = "models/weapons/w_pist_elite_single.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "bottom", pos = Vector(0, -2.5, -6.072), angle = Angle(0, -90, 0), size = Vector(0.882, 0.865, 0.992), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },
		["barrel"] = { type = "Model", model = "models/props_rooftop/roof_vent001.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "canister_front", pos = Vector(0, 0, 36.013), angle = Angle(180, 0, 0), size = Vector(0.173, 0.36, 0.727), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },
		["barrelfront"] = { type = "Model", model = "models/props_borealis/mooring_cleat01.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "barrel", pos = Vector(0, 0, 0), angle = Angle(180, 0, 0), size = Vector(0.13, 0.11, 0.03), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["thing_that_moves_back_when_you_shoot"] = { type = "Model", model = "models/props_rooftop/roof_vent001.mdl", bone = "v_weapon.sg550_Chamber", rel = "", pos = Vector(-0.077, 1.86, -2.192), angle = Angle(90, 0, 0), size = Vector(0.18, 0.18, 0.063), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["blackbars"] = { type = "Model", model = "models/props_c17/playground_teetertoter_stan.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "canister_front", pos = Vector(0, 0, 4.34), angle = Angle(0, -90, 90), size = Vector(0.179, 0.5, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },
		["scope_screen"] = { type = "Model", model = "models/props_junk/cardboard_box001a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scope", pos = Vector(-3.105, 0, 1.746), angle = Angle(0, -90, 0), size = Vector(0.078, 0.116, 0.064), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/masterinterface_alert", skin = 0, bodygroup = {} },
		["bottom_back"] = { type = "Model", model = "models/props_c17/furniturefridge001a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "bottom", pos = Vector(0, -12.132, 0.768), angle = Angle(0, -90, 0), size = Vector(0.057, 0.133, 0.052), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["bottom"] = { type = "Model", model = "models/props_trainstation/train003.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "barrel", pos = Vector(-1.348, 0, 39.881), angle = Angle(0, 90, 90), size = Vector(0.027, 0.048, 0.019), color = Color(175, 185, 195, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["kickstand_hold"] = { type = "Model", model = "models/Mechanics/robotics/a1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "canister_front", pos = Vector(-0.242, 0, 4.394), angle = Angle(0, 90, 90), size = Vector(0.254, 0.144, 0.144), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["scopebase"] = { type = "Model", model = "models/Mechanics/roboticslarge/g1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scope", pos = Vector(-2.064, 0, -0.262), angle = Angle(0, 0, 90), size = Vector(0.061, 0.037, 0.129), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },
		["kickstand"] = { type = "Model", model = "models/props_c17/metalladder002b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barrel", pos = Vector(-6.031, 0, 19.576), angle = Angle(135, 0, 180), size = Vector(0.164, 0.245, 0.368), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["clip"] = { type = "Model", model = "models/props_c17/consolebox01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "bottom", pos = Vector(0.758, 4.119, -3.109), angle = Angle(90, 0, 0), size = Vector(0.104, 0.134, 0.15), color = Color(125, 155, 135, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },
		["canister_front"] = { type = "Model", model = "models/props_c17/canister_propane01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scope", pos = Vector(0.779, 0, -1.066), angle = Angle(-90, 0, 0), size = Vector(0.1, 0.1, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },
		["scope"] = { type = "Model", model = "models/props_lab/citizenradio.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.354, 1.194, -6.069), angle = Angle(-171.883, 180, 0), size = Vector(0.731, 0.127, 0.182), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["bottom_grip"] = { type = "Model", model = "models/weapons/w_pist_elite_single.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "bottom", pos = Vector(0, -2.5, -6.072), angle = Angle(0, -90, 0), size = Vector(0.882, 0.865, 0.992), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },
		["barrel"] = { type = "Model", model = "models/props_rooftop/roof_vent001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "canister_front", pos = Vector(0, 0, 29.892), angle = Angle(180, 0, 0), size = Vector(0.173, 0.36, 0.579), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },
		["barrelfront"] = { type = "Model", model = "models/props_borealis/mooring_cleat01.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "barrel", pos = Vector(0, 0, 0), angle = Angle(180, 0, 0), size = Vector(0.13, 0.11, 0.03), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["thing_that_moves_back_when_you_shoot"] = { type = "Model", model = "models/props_rooftop/roof_vent001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "bottom", pos = Vector(0.153, 5.056, 0.425), angle = Angle(-90, 0, 0), size = Vector(0.18, 0.18, 0.063), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["bottom"] = { type = "Model", model = "models/props_trainstation/train003.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barrel", pos = Vector(-1.348, 0, 33.347), angle = Angle(0, 90, 90), size = Vector(0.027, 0.048, 0.019), color = Color(175, 185, 195, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["bottom_back"] = { type = "Model", model = "models/props_c17/furniturefridge001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "bottom", pos = Vector(0, -12.132, 0.768), angle = Angle(0, -90, 0), size = Vector(0.057, 0.133, 0.052), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["scope_screen"] = { type = "Model", model = "models/props_junk/cardboard_box001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scope", pos = Vector(-3.105, 0, 1.746), angle = Angle(0, -90, 0), size = Vector(0.078, 0.116, 0.064), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/masterinterface_alert", skin = 0, bodygroup = {} },
		["blackbars"] = { type = "Model", model = "models/props_c17/playground_teetertoter_stan.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "canister_front", pos = Vector(0, 0, 4.34), angle = Angle(0, -90, 90), size = Vector(0.179, 0.5, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} }
	}
end

sound.Add(
{
	name = "Weapon_Renegade.Single",
	channel = CHAN_AUTO,
	volume = 1,
	soundlevel = 100,
	pitch = {115,125},
	sound = {"npc/sniper/sniper1.wav"}
})

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/cstrike/c_snip_sg550.mdl"
SWEP.WorldModel = "models/weapons/w_snip_sg550.mdl"
SWEP.UseHands = true
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.ReloadSound = Sound("Weapon_AWP.ClipOut")
SWEP.Primary.Sound = Sound("Weapon_Renegade.Single")
SWEP.Primary.Damage = 30
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 1
SWEP.ReloadDelay = SWEP.Primary.Delay

SWEP.Primary.ClipSize = 30
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pulse"
SWEP.Primary.DefaultClip = 60
SWEP.Recoil = 1
SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN
SWEP.ReloadSpeed = 0.75
SWEP.RequiredClip = 10

SWEP.ConeMax = 0.003
SWEP.ConeMin = 0
SWEP.MovingConeOffset = 0.1
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)

SWEP.IronSightsPos = Vector(5.015, -8, 2.52)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.WalkSpeed = SPEED_SLOWER

SWEP.TracerName = "AR2Tracer"
function SWEP:IsScoped()
	return self:GetIronsights() and self.fIronTime and self.fIronTime + 0.25 <= CurTime()
end

function SWEP:EmitFireSound()
	self:EmitSound(self.Primary.Sound)
	self:EmitSound("weapons/sg552/sg552-1.wav", 80, 75, 0.75, CHAN_AUTO)
	self:EmitSound("weapons/stunstick/alyx_stunner"..math.random(2)..".wav", 80, 145, 0.75, CHAN_WEAPON + 20)
end

function SWEP.BulletCallback(attacker, tr, dmginfo)
	local originaldmg = dmginfo:GetDamage()
	dmginfo:SetDamage(1)
	if tr.Hit and SERVER then
		local ent = ents.Create("prop_electricfield")
		if ent:IsValid() then
			ent:SetPos(tr.HitPos)
			ent:SetOwner(attacker)
			ent:Spawn()
		end
		for _, ent in pairs(ents.FindInSphere(tr.HitPos, 48)) do
			if ent and ent:IsValid() then
				local nearest = ent:NearestPoint(tr.HitPos)
				if TrueVisibleFilters(tr.HitPos, nearest, dmginfo:GetInflictor(), ent) && ent != attacker then
					ent:TakeSpecialDamage(originaldmg, DMG_SHOCK, attacker, dmginfo:GetInflictor(), nearest)
				end
			end
		end
	end
	local ent = tr.Entity
	local effectdata = EffectData()
	effectdata:SetOrigin(tr.HitPos)
		util.Effect("explosion_lightning", effectdata)
	effectdata:SetNormal(tr.HitNormal)		
	effectdata:SetMagnitude(2)
	effectdata:SetScale(1)
		util.Effect("cball_explode", effectdata)		
	GenericBulletCallback(attacker, tr, dmginfo)
end

if CLIENT then
	SWEP.IronsightsMultiplier = 0.2

	function SWEP:GetViewModelPosition(pos, ang)
		if self:IsScoped() then
			return pos + ang:Up() * 256, ang
		end

		return self.BaseClass.GetViewModelPosition(self, pos, ang)
	end

	local matScope = Material("zombiesurvival/scope")
	function SWEP:DrawHUDBackground()
		if self:IsScoped() then
			local scrw, scrh = ScrW(), ScrH()
			local size = math.min(scrw, scrh)
			surface.SetMaterial(matScope)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect((scrw - size) * 0.5, (scrh - size) * 0.5, size, size)
			surface.SetDrawColor(0, 0, 0, 255)
			if scrw > size then
				local extra = (scrw - size) * 0.5
				surface.DrawRect(0, 0, extra, scrh)
				surface.DrawRect(scrw - extra, 0, extra, scrh)
			end
			if scrh > size then
				local extra = (scrh - size) * 0.5
				surface.DrawRect(0, 0, scrw, extra)
				surface.DrawRect(0, scrh - extra, scrw, extra)
			end
		end
	end
end