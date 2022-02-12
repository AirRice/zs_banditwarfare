AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_practicion_name"
	SWEP.TranslateDesc = "weapon_practicion_desc"

	SWEP.Slot = 2
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 45
	SWEP.VElements = {
		["medvial"] = { type = "Model", model = "models/healthvial.mdl", bone = "v_weapon.AK47_Clip", rel = "", pos = Vector(0, 0.082, 1.297), angle = Angle(-116.181, -93.926, -4.924), size = Vector(0.99, 0.99, 0.99), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Stock"] = { type = "Model", model = "models/props_combine/breenlight.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(0, -3.207, 6.977), angle = Angle(0, 90, 0), size = Vector(0.741, 0.552, 0.731), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["Nozzle"] = { type = "Model", model = "models/props_pipes/valve002.mdl", bone = "v_weapon.AK47_Bolt", rel = "", pos = Vector(0, 1.032, -3.503), angle = Angle(-180, -90, 0), size = Vector(0.221, 0.221, 0.221), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Nozzle+"] = { type = "Model", model = "models/healthvial.mdl", bone = "v_weapon.AK47_Bolt", rel = "", pos = Vector(-1.599, 1.032, -8.228), angle = Angle(89.334, 0, 0), size = Vector(0.549, 0.549, 0.372), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["GunBody"] = { type = "Model", model = "models/props_combine/combinetrain01a.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(0.075, -2.062, -2.416), angle = Angle(-90, 0, -90), size = Vector(0.016, 0.019, 0.016), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["pipe+"] = { type = "Model", model = "models/props_pipes/pipecluster16d_001a.mdl", bone = "v_weapon.AK47_ClipRelease", rel = "", pos = Vector(-1.106, 0.326, -3.448), angle = Angle(88.875, 0, 0), size = Vector(0.028, 0.028, 0.028), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["pipe++"] = { type = "Model", model = "models/props_pipes/pipecluster16d_001a.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(1.787, -4.518, -6.603), angle = Angle(-35.552, -61.82, -89.033), size = Vector(0.039, 0.039, 0.039), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["pipe"] = { type = "Model", model = "models/props_pipes/pipecluster16d_001a.mdl", bone = "v_weapon.AK47_ClipRelease", rel = "", pos = Vector(-1.106, 0.726, -1.866), angle = Angle(88.875, 0, 0), size = Vector(0.028, 0.028, 0.028), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["medvial"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(19.25, 1.802, -6.107), angle = Angle(-90, 90, -180), size = Vector(0.412, 0.412, 0.412), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Stock"] = { type = "Model", model = "models/props_combine/breenlight.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-1.787, 0.829, -1.714), angle = Angle(-77.25, -180, 0), size = Vector(0.741, 0.552, 0.731), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["Nozzle"] = { type = "Model", model = "models/props_pipes/valve002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(14.409, 0.717, -5.237), angle = Angle(-99.195, 0, 0), size = Vector(0.157, 0.157, 0.216), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["medvial+"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9.27, 0.612, -4.487), angle = Angle(-32.586, 0, 0), size = Vector(1.12, 1.12, 1.12), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["GunBody"] = { type = "Model", model = "models/props_combine/combinetrain01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9.612, 0.462, -2.099), angle = Angle(-11.101, 0, 180), size = Vector(0.019, 0.019, 0.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["pipe+"] = { type = "Model", model = "models/props_pipes/pipecluster16d_001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12.585, 2.451, -1.999), angle = Angle(0, 0, 90), size = Vector(0.028, 0.028, 0.028), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["pipe++"] = { type = "Model", model = "models/props_pipes/pipecluster16d_001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10.114, 1.914, -1.56), angle = Angle(-16.452, 14.064, 87.228), size = Vector(0.028, 0.028, 0.028), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["pipe"] = { type = "Model", model = "models/props_pipes/pipecluster16d_001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.274, -0.724, -3.898), angle = Angle(39.147, -27.515, -69.176), size = Vector(0.037, 0.037, 0.037), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.HUD3DBone = "v_weapon.AK47_Parent"
	SWEP.HUD3DPos = Vector(-1.85, -5.5, -5)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.02
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"
SWEP.UseHands = true

SWEP.ReloadSound = Sound("Weapon_AK47.Clipout")
SWEP.Primary.Sound = Sound("weapons/grenade_launcher1.wav", 70, math.random(90,120))
SWEP.Primary.Damage = 4
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.13
SWEP.Primary.ClipSize = 120
SWEP.RequiredClip = 4
SWEP.Primary.Ammo = "Battery"
SWEP.Primary.Automatic = true
SWEP.Primary.DefaultClip = 240
SWEP.TracerName = "HelicopterTracer"

SWEP.ConeMax = 0.07
SWEP.ConeMin = 0.007
SWEP.MovingConeOffset = 0.07
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
SWEP.NoAmmo = false
SWEP.Recoil = 0.26
SWEP.ToxicDamage = 2
SWEP.ToxicTick = 0.25
SWEP.ToxDuration = 1
SWEP.Heal = 4
SWEP.WalkSpeed = SPEED_SLOW

SWEP.IronSightsPos = Vector(-6.6, 40, 2.1)

function SWEP.BulletCallback(attacker, tr, dmginfo)
	local usecshitdetect = (GAMEMODE.ClientSideHitscan and !(attacker.GetOwner and attacker:GetOwner():IsPlayer() and attacker:GetOwner():IsBot()))
	local shooter = usecshitdetect and attacker or attacker:GetOwner()
	local wep = usecshitdetect and attacker:GetWeapon("weapon_zs_practition") or attacker
	if (!wep:IsValid()) then
		return 
	end
	local ent = tr.Entity
	if tr.HitSky then return end
	local effectdata = EffectData()
		effectdata:SetOrigin(tr.HitPos)
		effectdata:SetNormal(tr.HitNormal)
		effectdata:SetMagnitude(5)
		if tr.Entity:IsValid() then
			effectdata:SetEntity(tr.Entity)
		else
			effectdata:SetEntity(NULL)
		end
	util.Effect("hit_healdart", effectdata)

	dmginfo:SetAttacker(shooter)
	if ent:IsPlayer() and SERVER then
		if IsValid(wep) and wep:IsValid() and shooter:IsPlayer() then
			if ent:Team() ~= shooter:Team() then
				local tox = ent:GetStatus("tox")
				if (tox and tox:IsValid()) then
					tox:AddTime(wep.ToxDuration)
					tox:SetOwner(ent)
					tox.Damage = wep.ToxicDamage
					tox.Damager = shooter
					tox.TimeInterval = wep.ToxicTick
				else
					tox = ent:GiveStatus("tox")
					tox:SetTime(wep.ToxDuration)
					tox:SetOwner(ent)
					tox.Damage = wep.ToxicDamage
					tox.Damager = shooter
					tox.TimeInterval = wep.ToxicTick
				end
			else
				dmginfo:SetDamage(0)
				ent:GiveStatus("healdartboost").DieTime = CurTime() + 5
				ent:EmitSound("items/medshot4.wav")
				local toheal = wep.Heal
				if tr.HitGroup == HITGROUP_HEAD then
					toheal = toheal * 3
				end
				ent:HealHealth(toheal,shooter,wep)
			end
		end
	end	
	GenericBulletCallback(shooter, tr, dmginfo)
end

function SWEP:ShootBullets(dmg, numbul, cone)	
	self:SetConeAndFire()
	self:DoRecoil()

	local owner = self:GetOwner()
	--owner:MuzzleFlash()
	self:SendWeaponAnimation()
	owner:DoAttackEvent()
	
	if owner and owner:IsValid() and owner:IsPlayer() and self.IsFirearm and SERVER then
		owner.ShotsFired = owner.ShotsFired + numbul
		owner.LastShotWeapon = self:GetClass()
	end
	if (GAMEMODE.ClientSideHitscan and !owner:IsBot()) then
		self:ShootCSBullets(owner, dmg, numbul, cone, true)
	else
		self:StartBulletKnockback()
		if IsFirstTimePredicted() then
			self:FireBullets({Num = numbul, Src = owner:GetShootPos(), Dir = owner:GetAimVector(), Spread = Vector(cone, cone, 0), Tracer = 1, TracerName = self.TracerName, Force = dmg * 0.1, Damage = dmg, Callback = self.BulletCallback})
		end
		self:DoBulletKnockback(self.Primary.KnockbackScale * 0.05)
		self:EndBulletKnockback()
	end
end