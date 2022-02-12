AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_ioncannon_name"
	SWEP.TranslateDesc = "weapon_ioncannon_desc"
	SWEP.Slot = 3
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 55

	SWEP.HUD3DBone = "ValveBiped.Crossbow_base"
	SWEP.HUD3DPos = Vector(2.2, -2, 30)
	SWEP.HUD3DScale = 0.025
	
SWEP.VElements = {
	["battery"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Crossbow_base", rel = "base", pos = Vector(10.913, 1.253, -0.003), angle = Angle(0, -90, 0), size = Vector(0.444, 0.444, 0.444), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["Round"] = { type = "Model", model = "models/props_combine/breentp_rings.mdl", bone = "ValveBiped.bolt", rel = "", pos = Vector(0, 1, 10), angle = Angle(0, 0, 0), size = Vector(0.021, 0.021, 0.231), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["Grip"] = { type = "Model", model = "models/items/combine_rifle_cartridge01.mdl", bone = "ValveBiped.Crossbow_base", rel = "base", pos = Vector(13.743, 0, 0.426), angle = Angle(122.374, 0, 0), size = Vector(1.184, 1.184, 1.184), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["battery++"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Crossbow_base", rel = "base", pos = Vector(15.244, 1.253, -0.003), angle = Angle(0, -90, 0), size = Vector(0.444, 0.444, 0.444), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base"] = { type = "Model", model = "models/props_combine/combinetrain01a.mdl", bone = "ValveBiped.Crossbow_base", rel = "", pos = Vector(0, 0.24, 10), angle = Angle(-90, 90, 0), size = Vector(0.075, 0.025, 0.016), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["pipe+"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender128.mdl", bone = "ValveBiped.pull", rel = "base", pos = Vector(-10.065, 0, 0.711), angle = Angle(-90, 0, 0), size = Vector(0.405, 0.405, 0.405), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["battery+"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Crossbow_base", rel = "base", pos = Vector(12.892, 1.253, -0.003), angle = Angle(0, -90, 0), size = Vector(0.444, 0.444, 0.444), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["pipe"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender128.mdl", bone = "ValveBiped.pull", rel = "base", pos = Vector(-15.969, 0, 2.872), angle = Angle(-90, 0, 0), size = Vector(0.361, 0.361, 0.367), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["battery++++"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(7.469, 2.214, -0.003), angle = Angle(0, -90, 0), size = Vector(0.444, 0.444, 0.444), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["pipe"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender128.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-4.947, 0, 2.828), angle = Angle(-90, 0, 0), size = Vector(0.263, 0.263, 0.225), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["battery"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(9.411, -2.3, -0.003), angle = Angle(0, 90, 0), size = Vector(0.444, 0.444, 0.444), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["battery+++++"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(9.352, 2.214, -0.003), angle = Angle(0, -90, 0), size = Vector(0.444, 0.444, 0.444), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["battery+++"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(5.234, 2.214, -0.003), angle = Angle(0, -90, 0), size = Vector(0.444, 0.444, 0.444), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["battery++"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(5.234, -2.386, -0.003), angle = Angle(0, 90, 0), size = Vector(0.444, 0.444, 0.444), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base"] = { type = "Model", model = "models/props_combine/combinetrain01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(11.659, 0.842, -2.939), angle = Angle(6.489, -180, -175.29), size = Vector(0.043, 0.032, 0.016), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["pipe+"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-6.041, -0.32, 0.966), angle = Angle(-90, 0, 0), size = Vector(0.296, 0.296, 0.411), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["battery+"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(7.369, -2.304, -0.003), angle = Angle(0, 90, 0), size = Vector(0.444, 0.444, 0.444), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["Grip"] = { type = "Model", model = "models/items/combine_rifle_cartridge01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(9.225, 0, -2.041), angle = Angle(91.44, 0, 0), size = Vector(0.978, 0.565, 0.978), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "shotgun"

SWEP.ViewModel = "models/weapons/c_crossbow.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"
SWEP.UseHands = true
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
sound.Add(
{
	name = "Weapon_pulseboom.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	soundlevel = 100,
	sound = "weapons/gauss/fire1.wav"
})

SWEP.Recoil = 2.8
SWEP.Primary.Damage = 6
SWEP.Primary.NumShots = 6
SWEP.Primary.Delay = 0.45
SWEP.ReloadDelay = 1
SWEP.Primary.ClipSize = 8
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pulse"
SWEP.TracerName = "HelicopterTracer"
SWEP.ReloadSound = Sound("ambient/machines/combine_terminal_idle4.wav")
SWEP.Primary.Sound = Sound("Weapon_pulseboom.Single")
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 0.09
SWEP.ConeMin = 0.007
SWEP.MovingConeOffset = 0.09
SWEP.AimSubtractUnit = 0.03
SWEP.AimReleaseUnit = 0.2
SWEP.AimExpandStayDuration = 0.1

SWEP.WalkSpeed = SPEED_SLOWER
function SWEP:Initialize()
	if not self:IsValid() then return end
	self:SetWeaponHoldType(self.HoldType)
	self:SetDeploySpeed(1.1)

	self:SetConeAdder(self.ConeMax)
	if CLIENT then
		self:CheckCustomIronSights()
		self:Anim_Initialize()
		if self.TranslateName then
			self.PrintName = translate.Get(self.TranslateName)
		end
	end
end

function SWEP:AimConeExpandThink()
	local curTime = CurTime()
	local collapseStartTime = self.AimStartTime + self.Primary.Delay
	if collapseStartTime > curTime then
		self:SetConeAdder(math.Clamp(self:GetConeAdder()-self.AimSubtractUnit * FrameTime(), 0, self.ConeMax-self.ConeMin))
	else
		if (collapseStartTime + self.AimExpandStayDuration <= curTime) and self:GetConeAdder() > 0 then
			self:SetConeAdder(math.Clamp(self:GetConeAdder() + self.AimReleaseUnit * FrameTime(), 0, self.ConeMax-self.ConeMin))
		end      
	end
end

function SWEP:Reload()
	if self:GetOwner():IsHolding() then return end

	if self:GetIronsights() then
		self:SetIronsights(false)
	end

	if self:GetNextReload() <= CurTime() and self:DefaultReload(ACT_VM_RELOAD) then
		self:GetOwner():GetViewModel():SetPlaybackRate(0.5)
		self.IdleAnimation = CurTime() + self:SequenceDuration()*2+0.3
		self:SetNextPrimaryFire(self.IdleAnimation)
		self:SetNextReload(self.IdleAnimation)
		self:GetOwner():DoReloadEvent()
		if self.ReloadSound then
			self:EmitSound(self.ReloadSound)
		end
	end
end

function SWEP.BulletCallback(attacker, tr, dmginfo)
	local ent = tr.Entity
	if ent:IsValid() and ent:IsPlayer() and ent:Team() ~= attacker:Team() then
		ent:AddLegDamage(4)
	end
	local e = EffectData()
		e:SetOrigin(tr.HitPos)
		e:SetNormal(tr.HitNormal)
		e:SetRadius(3)
		e:SetMagnitude(1)
		e:SetScale(1)
	util.Effect("ar2_hit", e)
	GenericBulletCallback(attacker, tr, dmginfo)	
end