AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_terminator_name"
	SWEP.TranslateDesc = "weapon_terminator_desc"
	SWEP.Slot = 1
	SWEP.SlotPos = 2

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "v_weapon.FIVESEVEN_PARENT"
	SWEP.HUD3DPos = Vector(-1.3, -2.5, -3)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.02
	
	SWEP.VElements = {
		["Handle"] = { type = "Model", model = "models/weapons/w_pist_p228.mdl", bone = "v_weapon.FIVESEVEN_PARENT", rel = "", pos = Vector(0, 2.901, -1.494), angle = Angle(-90, 90, 0), size = Vector(0.944, 1.009, 0.944), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_trainstation/benchoutdoor01a", skin = 0, bodygroup = {[3] = 2} },
		["SlideWings"] = { type = "Model", model = "models/props_wasteland/laundry_basket002.mdl", bone = "v_weapon.FIVESEVEN_PARENT", rel = "Handle", pos = Vector(5.763, 0, 4.423), angle = Angle(-90, 0, 0), size = Vector(0.041, 0.03, 0.112), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["underside"] = { type = "Model", model = "models/props_c17/furniturebathtub001a.mdl", bone = "v_weapon.FIVESEVEN_PARENT", rel = "Handle", pos = Vector(-2.586, 0, 4.994), angle = Angle(-100.652, 0, 0), size = Vector(0.043, 0.052, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/furnituremetal002a", skin = 0, bodygroup = {} },
		["slide"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "v_weapon.FIVESEVEN_SLIDE", rel = "", pos = Vector(0, 3.648, -0.04), angle = Angle(0, 0, 90), size = Vector(0.157, 0.157, 0.17), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	}	
	SWEP.WElements = {
		["underside"] = { type = "Model", model = "models/props_c17/furniturebathtub001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Handle", pos = Vector(-2.586, 0, 4.994), angle = Angle(-100.652, 0, 0), size = Vector(0.043, 0.052, 0.043), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/furnituremetal002a", skin = 0, bodygroup = {} },
		["slide"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Handle", pos = Vector(3.72, 0, 6.06), angle = Angle(-90, 0, 0), size = Vector(0.15, 0.181, 0.143), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Handle"] = { type = "Model", model = "models/weapons/w_pist_p228.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 1.4, 2.5), angle = Angle(-3.3, -5.212, 180), size = Vector(0.88, 1.3, 0.88), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_trainstation/benchoutdoor01a", skin = 0, bodygroup = {[3] = 2} },
		["SlideWings"] = { type = "Model", model = "models/props_wasteland/laundry_basket002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Handle", pos = Vector(5.763, 0, 4.423), angle = Angle(-90, 0, 0), size = Vector(0.041, 0.03, 0.112), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end


SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "revolver"

SWEP.ViewModel = "models/weapons/cstrike/c_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fiveseven.mdl"
SWEP.UseHands = true
SWEP.Primary.Sound = Sound("weapons/fiveseven/fiveseven-1.wav")
SWEP.Primary.Damage = 14
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.1
SWEP.Recoil = 0.76
SWEP.Primary.ClipSize = 6
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.DefaultClip = 24

SWEP.ConeMax = 0.018
SWEP.ConeMin = 0.003
SWEP.MovingConeOffset = 0.04
SWEP.IronSightsPos = Vector(-6.2, 0, 2.5)
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)

function SWEP.BulletCallback(attacker, tr, dmginfo)
	if attacker:GetActiveWeapon():GetClass() == "weapon_zs_terminator" then
		local spare = attacker:GetAmmoCount("pistol")
		if tr.HitGroup == HITGROUP_HEAD then
			local wep = attacker:GetActiveWeapon()
			local current = wep:Clip1()
			local totake = math.min(spare, 6 - current)
			wep:SetClip1(current + totake)
			if SERVER then
				attacker:RemoveAmmo(totake, "pistol")
			end
			attacker:EmitSound("weapons/gauss/fire1.wav", 75, 100,1,CHAN_ITEM)
			local effectdata = EffectData()
				effectdata:SetOrigin(tr.HitPos)
				effectdata:SetNormal(tr.Normal)
				effectdata:SetMagnitude(4)
				effectdata:SetScale(1.33)
			util.Effect("cball_explode", effectdata)
		end
	end
	GenericBulletCallback(attacker, tr, dmginfo)
end