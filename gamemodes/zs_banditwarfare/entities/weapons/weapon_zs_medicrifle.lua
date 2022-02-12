AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_convalescence_name"
	SWEP.TranslateDesc = "weapon_convalescence_desc"
	SWEP.Slot = 3
	SWEP.SlotPos = 0
	
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 55
	SWEP.ShowViewModel = true
	SWEP.ShowWorldModel = true

	SWEP.IronsightsMultiplier = 0.25
	SWEP.HUD3DBone = "v_weapon.scout_Parent"
	SWEP.HUD3DPos = Vector(-1.25, -2.75, -6)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.017

	SWEP.VElements = {
		["body2"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scope", pos = Vector(-2.431, 0, 7.743), angle = Angle(-180, 90, 0), size = Vector(0.541, 0.736, 1.307), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel"] = { type = "Model", model = "models/XQM/cylinderx1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scope", pos = Vector(-1.833, 0, 11.97), angle = Angle(90, 0, 0), size = Vector(0.717, 0.061, 0.061), color = Color(115, 140, 195, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["body3"] = { type = "Model", model = "models/props_trainstation/train001.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scope", pos = Vector(-2.57, 0, -5.768), angle = Angle(0, 90, 90), size = Vector(0.009, 0.016, 0.012), color = Color(85, 120, 195, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["scope"] = { type = "Model", model = "models/props_combine/breenlight.mdl", bone = "v_weapon.scout_Parent", rel = "", pos = Vector(0, -5.212, -11.976), angle = Angle(0, 90, 180), size = Vector(0.368, 0.616, 0.603), color = Color(115, 140, 195, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["body4"] = { type = "Model", model = "models/props_combine/combinetrain01a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scope", pos = Vector(-5.567, 0, -7.106), angle = Angle(-90, 0, 0), size = Vector(0.009, 0.014, 0.01), color = Color(115, 140, 195, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["body"] = { type = "Model", model = "models/props_c17/gravestone003a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scope", pos = Vector(-2.309, 0, 0.996), angle = Angle(-90, 0, 0), size = Vector(3.167, 0.043, 0.061), color = Color(115, 140, 195, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["body5"] = { type = "Model", model = "models/props_combine/breenconsole.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scope", pos = Vector(-3.738, 0, 5.004), angle = Angle(0, -90, -90), size = Vector(0.096, 0.284, 0.081), color = Color(115, 140, 195, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["stuff"] = { type = "Model", model = "models/props_c17/FurnitureDrawer001a_Chunk05.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scope", pos = Vector(0.041, 0, -5.003), angle = Angle(90, 0, 0), size = Vector(0.05, 0.035, 0.05), color = Color(255, 255, 195, 255), surpresslightning = false, material = "models/props_combine/masterinterface_alert", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["body2"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scope", pos = Vector(-2.922, 0, 15.505), angle = Angle(-180, 90, 0), size = Vector(0.582, 0.805, 1.307), color = Color(115, 140, 195, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["body3"] = { type = "Model", model = "models/props_trainstation/train001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scope", pos = Vector(-2.491, 0, -2.517), angle = Angle(0, 90, 90), size = Vector(0.009, 0.016, 0.012), color = Color(115, 140, 195, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["barrel"] = { type = "Model", model = "models/XQM/cylinderx1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scope", pos = Vector(-2.411, 0, 16.427), angle = Angle(90, 0, 0), size = Vector(0.99, 0.061, 0.061), color = Color(115, 140, 195, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["scope"] = { type = "Model", model = "models/props_combine/breenlight.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(11.253, 0.721, -7.623), angle = Angle(-100, 0, 0), size = Vector(0.433, 0.616, 0.755), color = Color(115, 140, 195, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["body4"] = { type = "Model", model = "models/props_combine/combinetrain01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scope", pos = Vector(-6.316, 0, -2.192), angle = Angle(-90, 0, 0), size = Vector(0.014, 0.014, 0.014), color = Color(115, 140, 195, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["body"] = { type = "Model", model = "models/props_c17/gravestone003a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scope", pos = Vector(-2.75, 0, 8.814), angle = Angle(-90, 0, 0), size = Vector(3.167, 0.043, 0.065), color = Color(115, 140, 195, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["body5"] = { type = "Model", model = "models/props_combine/breenconsole.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scope", pos = Vector(-3.738, 0, 12.616), angle = Angle(0, -90, -90), size = Vector(0.096, 0.419, 0.093), color = Color(115, 140, 195, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["stuff"] = { type = "Model", model = "models/props_c17/FurnitureDrawer001a_Chunk05.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scope", pos = Vector(0.046, 0, -6.447), angle = Angle(90, 0, 0), size = Vector(0.05, 0.035, 0.061), color = Color(255, 255, 195, 255), surpresslightning = false, material = "models/props_combine/masterinterface_alert", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/cstrike/c_snip_scout.mdl"
SWEP.WorldModel = "models/weapons/w_snip_scout.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_Pistol.Reload")

SWEP.Primary.Damage = 10
SWEP.Primary.Delay = 0.5
SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 200
SWEP.Primary.Ammo = "Battery"
SWEP.RequiredClip = 20

SWEP.TracerName = "HelicopterTracer"
SWEP.ConeMax = 0.005
SWEP.ConeMin = 0.001
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
SWEP.NoAmmo = false
SWEP.Recoil = 0.86
SWEP.ToxicDamage = 2
SWEP.ToxicTick = 0.2
SWEP.ToxDuration = 2
SWEP.Heal = 20
SWEP.WalkSpeed = SPEED_SLOW

SWEP.IronSightsPos = Vector(5.015, -8, 2.52)
SWEP.IronSightsAng = Vector(0, 0, 0)

function SWEP:EmitFireSound()
	self:EmitSound("weapons/ar2/npc_ar2_altfire.wav", 70, math.random(117, 123), 0.85)
	self:EmitSound("npc/sniper/sniper1.wav", 75, math.random(105, 115), 0.95, CHAN_WEAPON + 20)
	self:EmitSound("items/smallmedkit1.wav", 70, math.random(165, 170), 0.5, CHAN_WEAPON + 21)
end

function SWEP.BulletCallback(attacker, tr, dmginfo)
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
	local usecshitdetect = (GAMEMODE.ClientSideHitscan and !(attacker.GetOwner and attacker:GetOwner():IsPlayer() and attacker:GetOwner():IsBot()))
	local shooter = usecshitdetect and attacker or attacker:GetOwner()
	local wep = usecshitdetect and attacker:GetWeapon("weapon_zs_medicrifle") or attacker
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
					toheal = toheal * 1.5
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
	local owner = self.Owner
	--owner:MuzzleFlash()
	self:SendWeaponAnimation()
	owner:DoAttackEvent()
	
	if owner and owner:IsValid() and owner:IsPlayer() and self.IsFirearm and SERVER then
		owner.ShotsFired = owner.ShotsFired + numbul
		owner.LastShotWeapon = self:GetClass()
	end
	if GAMEMODE.ClientSideHitscan and !owner:IsBot() then
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

function SWEP:Deploy()
	gamemode.Call("WeaponDeployed", self.Owner, self)

	self.IdleAnimation = CurTime() + self:SequenceDuration()

	if CLIENT then
		hook.Add("PostPlayerDraw", "PostPlayerDrawMedical", GAMEMODE.PostPlayerDrawMedical)
		GAMEMODE.MedicalAura = true
	end

	return true
end

function SWEP:Holster()
	if CLIENT then
		hook.Remove("PostPlayerDraw", "PostPlayerDrawMedical")
		GAMEMODE.MedicalAura = false
	end

	return true
end

function SWEP:OnRemove()
	if CLIENT and self.Owner == LocalPlayer() then
		hook.Remove("PostPlayerDraw", "PostPlayerDrawMedical")
		GAMEMODE.MedicalAura = false
	end
end

function SWEP:IsScoped()
	return self:GetIronsights() and self.fIronTime and self.fIronTime + 0.25 <= CurTime()
end


if CLIENT then
	SWEP.IronsightsMultiplier = 0.25

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