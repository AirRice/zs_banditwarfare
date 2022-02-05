AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_telescopic_baton_name"
	SWEP.TranslateDesc = "weapon_telescopic_baton_desc"
	SWEP.ViewModelFOV = 55
	SWEP.VElements = {
		["base1"] = { type = "Model", model = "models/props_borealis/bluebarrel001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.931, 1.424, 0.423), angle = Angle(5.899, 19.891, -2.722), size = Vector(0.05, 0.05, 0.18), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },
		["base2"] = { type = "Model", model = "models/props_c17/signpole001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base1", pos = Vector(0, 0, -11), angle = Angle(0, 0, 0), size = Vector(0.386, 0.386, 0.086), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base3"] = { type = "Model", model = "models/props_c17/signpole001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base2", pos = Vector(0, 0, -6.6), angle = Angle(0, 0, 0), size = Vector(0.207, 0.207, 0.09), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["endcap"] = { type = "Model", model = "models/props_c17/lamp_standard_off01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base3", pos = Vector(0, 0, -0.082), angle = Angle(0, 0, 0), size = Vector(0.046, 0.046, 0.046), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["base1"] = { type = "Model", model = "models/props_borealis/bluebarrel001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.694, 1.353, -0.091), angle = Angle(-3.912, 29.535, 0), size = Vector(0.05, 0.05, 0.18), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/v_stunbaton/w_shaft01a", skin = 0, bodygroup = {} },
		["base2"] = { type = "Model", model = "models/props_c17/signpole001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base1", pos = Vector(0, 0, -10.572), angle = Angle(0, 0, 0), size = Vector(0.386, 0.386, 0.086), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base3"] = { type = "Model", model = "models/props_c17/signpole001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base2", pos = Vector(0, 0, -6.54), angle = Angle(0, 0, 0), size = Vector(0.207, 0.207, 0.09), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["endcap"] = { type = "Model", model = "models/props_c17/lamp_standard_off01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base3", pos = Vector(0, 0, -0.288), angle = Angle(0, 0, 0), size = Vector(0.046, 0.046, 0.046), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/weapons/w_stunbaton.mdl"
SWEP.UseHands = true
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.HoldType = "melee"

SWEP.MeleeDamage = 20
SWEP.MeleeRange = 55
SWEP.MeleeSize = 1.5
SWEP.Primary.Delay = 0.65
SWEP.DamageType = DMG_CLUB

SWEP.SwingTime = 0.15
SWEP.SwingRotation = Angle(60, 0, 0)
SWEP.SwingOffset = Vector(0, -50, 0)
SWEP.SwingHoldType = "grenade"
function SWEP:SetupDataTables()
	self:NetworkVar("Float", 31, "DeployStartTime")
	if self.BaseClass.SetupDataTables then
		self.BaseClass.SetupDataTables(self)
	end
end

function SWEP:Deploy()
	if self.BaseClass.Deploy then
		self.BaseClass.Deploy(self)
	end
	self:SetDeployStartTime(CurTime())
	self:EmitSound("buttons/lever8.wav",75,math.random(145,170),0.2)
	return true
end

function SWEP:PlayHitSound()
	self:EmitSound("weapons/melee/golfclub/golf_hit-0"..math.random(4)..".ogg",75,math.random(125,140),0.6)
	self:EmitSound("physics/metal/metal_grenade_impact_hard"..math.random(1,3)..".wav",75,85,0.75, CHAN_AUTO+20)
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("Weapon_StunStick.Melee_Hit")
end

function SWEP:PlayerHitUtil(owner, damage, hitent, dmginfo)
	hitent:MeleeViewPunch(damage*0.1)
	local combo = self:GetDTInt(2)
	self:SetNextPrimaryFire(CurTime() + math.max(0.15, self.Primary.Delay * (1 - combo / 3)))

	self:SetDTInt(2, combo + 1)
end

function SWEP:PostOnMeleeMiss(tr)
	self:SetDTInt(2, 0)
end

if CLIENT then
	function SWEP:PostDrawViewModel(vm, pl, wep)
		local veles = self.VElements
		
		local base2pos = veles["base2"].pos
		local base3pos = veles["base3"].pos

		local curtime = CurTime()
		local deploystart = self:GetDeployStartTime()
		local deployanimtime = 0.35
		if curtime < deploystart+deployanimtime then
			local lowertime = math.min(curtime - deploystart,deployanimtime)
			local delta = math.Clamp(lowertime/ deployanimtime, 0, 1)
			base2pos.z = -3 - 8*delta
			base3pos.z = -1 - 5.5*delta
		else
			base2pos.z = -11
			base3pos.z = -6.5
		end
		if self.BaseClass.PostDrawViewModel then 
			self.BaseClass.PostDrawViewModel(self,vm, pl, wep)
		end
	end
end