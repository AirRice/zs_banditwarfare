AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_shovel_name"
	SWEP.TranslateDesc = "weapon_shovel_desc"
	SWEP.ViewModelFOV = 60

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/props_junk/shovel01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.363, 1.363, -7.728), angle = Angle(0, 0, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/props_junk/shovel01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 1.363, -15), angle = Angle(-3, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.HoldType = "melee2"

SWEP.DamageType = DMG_CLUB

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/props_junk/shovel01a.mdl"
SWEP.UseHands = true

SWEP.MeleeDamage = 70
SWEP.MeleeRange = 68
SWEP.MeleeSize = 1.5
SWEP.MeleeKnockBack = 40

SWEP.Primary.Delay = 1.3

SWEP.WalkSpeed = SPEED_SLOWER

SWEP.SwingRotation = Angle(0, -90, -60)
SWEP.SwingOffset = Vector(0, 30, -40)
SWEP.SwingTime = 0.65
SWEP.SwingHoldType = "melee"

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(65, 70))
end

function SWEP:PlayHitSound()
	self:EmitSound("weapons/melee/shovel/shovel_hit-0"..math.random(4)..".ogg")
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav")
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if tr.HitWorld and (tr.MatType == MAT_DIRT or tr.MatType == MAT_SNOW  or tr.MatType == MAT_SAND  or tr.MatType == MAT_GRASS) then
		local found = false
		local perc = math.random(10)
		if perc == 1 then
			if SERVER then
				self:EmitSound("npc/antlion/digup1.wav",50,math.Rand(160,200),0.25,CHAN_AUTO + 21)
				local ent = ents.Create("prop_ammobag")
				if ent:IsValid() then
					ent:SetPos(self:GetOwner():GetShootPos())
					ent:SetOwner(self:GetOwner())
					ent:Spawn()
					ent:EmitSound("WeaponFrag.Throw")
					local phys = ent:GetPhysicsObject()
					if phys:IsValid() then
						phys:Wake()
						phys:AddAngleVelocity(VectorRand() * 5)
						phys:SetVelocityInstantaneous(self:GetOwner():GetAimVector() * 340)
					end
				end
			end
		end
		self:EmitSound("npc/antlion/digdown1.wav",50,math.Rand(160,200),0.3,CHAN_AUTO + 20)
	end
end