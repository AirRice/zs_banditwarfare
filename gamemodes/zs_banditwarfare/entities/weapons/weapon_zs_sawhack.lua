AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_sawhack_name"
	SWEP.TranslateDesc = "weapon_sawhack_desc"
	SWEP.ViewModelFOV = 60

	SWEP.VElements = {
		["axe"] = { type = "Model", model = "models/props/cs_militia/axe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.184, 1.501, -7.421), angle = Angle(2.427, -10, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["saw"] = { type = "Model", model = "models/props_junk/sawblade001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "axe", pos = Vector(0, 14, -0.021), angle = Angle(0, 0, 0), size = Vector(0.449, 0.449, 0.805), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["saw2"] = { type = "Model", model = "models/XQM/Rails/trackball_1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "axe", pos = Vector(0, 14, 0), angle = Angle(0, 0, 0), size = Vector(0.234, 0.234, 0.133), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_lab/door_klab01", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["axe"] = { type = "Model", model = "models/props/cs_militia/axe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.023, 2.147, -8.32), angle = Angle(-6.166, 20.881, 86.675), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["saw2"] = { type = "Model", model = "models/XQM/Rails/trackball_1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "axe", pos = Vector(0, 14, 0), angle = Angle(0, 90, 0), size = Vector(0.234, 0.234, 0.133), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_lab/door_klab01", skin = 0, bodygroup = {} },
		["saw"] = { type = "Model", model = "models/props_junk/sawblade001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "axe", pos = Vector(0, 14, -0.021), angle = Angle(0, 0, 0), size = Vector(0.449, 0.449, 0.805), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true

SWEP.HoldType = "melee2"

SWEP.Primary.Delay = 0.45

SWEP.MeleeDamage = 22
SWEP.MeleeRange = 55
SWEP.MeleeSize = 1.9
SWEP.MeleeKnockBack = 10

SWEP.WalkSpeed = SPEED_FAST

SWEP.SwingTime = 0.15
SWEP.SwingRotation = Angle(0, -35, -50)
SWEP.SwingOffset = Vector(10, 0, 0)
SWEP.HoldType = "melee2"
SWEP.SwingHoldType = "melee"

SWEP.HitDecal = "Manhackcut"
SWEP.HitAnim = ACT_VM_MISSCENTER

sound.Add( {
	name = "Loop_Sawhack_Engine",
	channel = CHAN_AUTO+20,
	volume = 1,
	level = 75,
	pitch = 70,
	volume = 0.2,
	sound = "npc/manhack/mh_blade_loop1.wav"
} )
sound.Add( {
	name = "Loop_Sawhack_Engine2",
	channel = CHAN_AUTO+21,
	volume = 1,
	level = 75,
	pitch = 130,
	volume = 0.1,
	sound = "npc/manhack/mh_engine_loop1.wav"
} )

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(75, 80))
end

function SWEP:PlayHitSound()
	self:EmitSound("npc/manhack/grind"..math.random(5)..".wav")
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("ambient/machines/slicer"..math.random(4)..".wav")
end

function SWEP:Deploy()
	if self.BaseClass.Deploy then
		self.BaseClass.Deploy(self)
	end
    self:EmitSound( "Loop_Sawhack_Engine" )
	self:EmitSound( "Loop_Sawhack_Engine2" )	
    return true
end

function SWEP:OnRemove()
	self:StopSound( "Loop_Sawhack_Engine" )
	self:StopSound( "Loop_Sawhack_Engine2" )
end

function SWEP:Holster()
    self:StopSound( "Loop_Sawhack_Engine" )
	self:StopSound( "Loop_Sawhack_Engine2" )
	return self.BaseClass.Holster(self)
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if not hitflesh then
		local effectdata = EffectData()
			effectdata:SetOrigin(tr.HitPos)
			effectdata:SetNormal(tr.HitNormal)
			effectdata:SetMagnitude(2)
			effectdata:SetScale(1)
		util.Effect("sparks", effectdata)
	end
end

function SWEP:PlayerHitUtil(owner, damage, hitent, dmginfo)
	hitent:MeleeViewPunch(damage*0.1)
	if hitent:WouldDieFrom(damage, dmginfo:GetDamagePosition()) then
		hitent:Dismember(hitent:NearestDismemberableBone(dmginfo:GetDamagePosition()))
	else
		local bleed = hitent:GetStatus("bleed")
		if bleed and bleed:IsValid() then
			bleed:AddDamage(damage)
			bleed.Damager = owner
		else
			local stat = hitent:GiveStatus("bleed")
			if stat and stat:IsValid() then
				stat:SetDamage(damage)
				stat.Damager = owner
			end
		end
	end
end

if CLIENT then
	function SWEP:PostDrawViewModel(vm, pl, wep)
		local veles = self.VElements
		local saw1ang = veles["saw"].angle
		local saw2ang = veles["saw2"].angle
		local rotatespeed = CurTime()*1400
		saw1ang.y = (rotatespeed)%360
		saw2ang.y = (rotatespeed)%360
		if self.BaseClass.PostDrawViewModel then 
			self.BaseClass.PostDrawViewModel(self,vm, pl, wep)
		end
	end
	function SWEP:DrawWorldModel()
		local owner = self:GetOwner()
		if owner:IsValid() and owner.ShadowMan then return end
		local weles = self.WElements
		local saw1ang = weles["saw"].angle
		local saw2ang = weles["saw2"].angle
		local rotatespeed = CurTime()*1400
		saw1ang.y = (rotatespeed)%360
		saw2ang.y = (rotatespeed)%360
		self:Anim_DrawWorldModel()
	end
end