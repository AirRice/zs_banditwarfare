AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_energysword_name"
	SWEP.TranslateDesc = "weapon_energysword_desc"
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 70

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

SWEP.VElements = {
	["Blade"] = { type = "Model", model = "models/props_combine/combine_fence01b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-2.967, 1.404, -9.174), angle = Angle(-180, -90, 8.237), size = Vector(0.103, 0.305, 0.156), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["Handle"] = { type = "Model", model = "models/items/combine_rifle_cartridge01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.983, 1.299, -0.692), angle = Angle(0, -11.07, 0), size = Vector(0.913, 0.913, 0.913), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["Handle"] = { type = "Model", model = "models/items/combine_rifle_cartridge01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.285, 0.587, -0.67), angle = Angle(25.451, -7.106, -12.844), size = Vector(0.47, 0.828, 0.671), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["Blade"] = { type = "Model", model = "models/props_combine/combine_fence01b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.098, 1.679, -7.317), angle = Angle(-6.257, 90.987, 168.966), size = Vector(0.127, 0.127, 0.237), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
end


SWEP.Base = "weapon_zs_basemelee"

SWEP.HoldType = "melee2"
SWEP.DamageType = DMG_DISSOLVE
SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.ShowWorldModel = false
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"
SWEP.UseHands = true
SWEP.HitDecal = "Manhackcut"

SWEP.MeleeDamage = 24
SWEP.MeleeRange = 60
SWEP.MeleeSize = 2

SWEP.WalkSpeed = SPEED_NORMAL

SWEP.Primary.Delay = 0.5
SWEP.Secondary.Delay = 10
SWEP.SwiftStriking = false
SWEP.CapFallDamage = true
SWEP.HitAnim = ACT_VM_MISSCENTER

function SWEP:PlayHitSound()
	self:EmitSound("ambient/energy/weld"..math.random(2)..".wav", 75, math.random(120,150))
end
function SWEP:PlaySwingSound()
	self:EmitSound("weapons/physcannon/energy_bounce"..math.random(2)..".wav", 75, math.random(80,110))
end
function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/flesh/flesh_bloody_break.wav", 80, math.Rand(90, 100))
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	local ent = tr.Entity
	local edata = EffectData()
		edata:SetEntity(hitent)
		edata:SetMagnitude(2)
		edata:SetScale(1)
		util.Effect("TeslaHitBoxes", edata) 
		edata:SetOrigin(tr.HitPos)
		edata:SetNormal(tr.HitNormal)
		edata:SetMagnitude(1)
		edata:SetScale(1)
		util.Effect("AR2Impact", edata)
		util.Decal("Manhackcut", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
end