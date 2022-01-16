AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_whirlwind_name"
	SWEP.TranslateDesc = "weapon_whirlwind_desc"
	SWEP.HUD3DBone = "ValveBiped.base"
	SWEP.HUD3DPos = Vector(3, 0.25, -2)
	SWEP.HUD3DScale = 0.02
	
	SWEP.ViewModelFOV = 60
	SWEP.Slot = 2
	SWEP.ViewModelFlip = false

	SWEP.VElements = {
		["monitor"] = { type = "Model", model = "models/props_combine/combine_intmonitor001.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "core", pos = Vector(2.046, 1.325, 7.032), angle = Angle(0, 0, -90), size = Vector(0.059, 0.144, 0.054), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["backpanel"] = { type = "Model", model = "models/props_combine/combine_interface002.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "core", pos = Vector(0, 1.919, 0.23), angle = Angle(-42.225, -90, 180), size = Vector(0.054, 0.029, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["core"] = { type = "Model", model = "models/props_c17/canister_propane01a.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(0, 0, -6.711), angle = Angle(0, 0, 0), size = Vector(0.108, 0.128, 0.275), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["lightsight"] = { type = "Model", model = "models/props_combine/combine_light002a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "core", pos = Vector(0, -1.915, -2.839), angle = Angle(0, -90, 0), size = Vector(0.156, 0.221, 0.314), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["radar"] = { type = "Model", model = "models/props_rooftop/roof_dish001.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "core", pos = Vector(-0.258, -1.035, 0.224), angle = Angle(-84.481, 55.051, -94.617), size = Vector(0.046, 0.046, 0.046), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["gun1"] = { type = "Model", model = "models/props_c17/column02a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "core", pos = Vector(-1.372, 0.824, 14.314), angle = Angle(0, 0, 0), size = Vector(0.009, 0.009, 0.018), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["gun2"] = { type = "Model", model = "models/props_c17/column02a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "core", pos = Vector(-1.372, -0.825, 14.314), angle = Angle(0, 0, 0), size = Vector(0.009, 0.009, 0.018), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["gun3"] = { type = "Model", model = "models/props_c17/column02a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "core", pos = Vector(1.371, -0.825, 14.314), angle = Angle(0, 0, 0), size = Vector(0.009, 0.009, 0.018), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["gun4"] = { type = "Model", model = "models/props_c17/column02a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "core", pos = Vector(1.371, 0.824, 14.314), angle = Angle(0, 0, 0), size = Vector(0.009, 0.009, 0.018), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["monitor"] = { type = "Model", model = "models/props_combine/combine_intmonitor001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "core", pos = Vector(2.046, 1.325, 5.361), angle = Angle(0, 0, -90), size = Vector(0.059, 0.104, 0.054), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["backpanel"] = { type = "Model", model = "models/props_combine/combine_interface002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "core", pos = Vector(0, 1.919, 0.23), angle = Angle(-42.225, -90, 180), size = Vector(0.054, 0.029, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["core"] = { type = "Model", model = "models/props_c17/canister_propane01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.172, 1.524, -4.211), angle = Angle(0, -89.995, -102.33), size = Vector(0.108, 0.128, 0.256), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["lightsight"] = { type = "Model", model = "models/props_combine/combine_light002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "core", pos = Vector(0, -1.915, -2.839), angle = Angle(0, -90, 0), size = Vector(0.156, 0.221, 0.314), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["gun1"] = { type = "Model", model = "models/props_c17/column02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "core", pos = Vector(-1.453, 0.985, 12.852), angle = Angle(0, 0, 0), size = Vector(0.009, 0.009, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["gun2"] = { type = "Model", model = "models/props_c17/column02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "core", pos = Vector(-1.453, -0.986, 12.852), angle = Angle(0, 0, 0), size = Vector(0.009, 0.009, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["gun3"] = { type = "Model", model = "models/props_c17/column02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "core", pos = Vector(1.452, 0.985, 12.852), angle = Angle(0, 0, 0), size = Vector(0.009, 0.009, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["gun4"] = { type = "Model", model = "models/props_c17/column02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "core", pos = Vector(1.452, -0.986, 12.852), angle = Angle(0, 0, 0), size = Vector(0.009, 0.009, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["radar"] = { type = "Model", model = "models/props_rooftop/roof_dish001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "core", pos = Vector(-0.258, -1.035, 0.224), angle = Angle(-84.481, 55.051, -94.617), size = Vector(0.046, 0.046, 0.046), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "smg"
SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.UseHands = true
SWEP.ReloadSound = Sound("Weapon_Alyx_Gun.Reload")
SWEP.Primary.Sound = Sound("weapons/smg1/smg1_fire1.wav")
SWEP.Primary.Damage = 6
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.07

SWEP.Primary.ClipSize = 20
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "autocharging"
SWEP.Primary.DefaultClip = 20

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SMG1

SWEP.ConeMax = 0.06
SWEP.ConeMin = 0.01
SWEP.Recoil = 0.22
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)

SWEP.WalkSpeed = SPEED_SLOW
SWEP.LastAttack = 0
SWEP.SearchRadius = 160
SWEP.AutoReloadDelay = 1
SWEP.ShowOnlyClip = true
SWEP.LowAmmoThreshold = 25

--SWEP.TracerName = "tracer_interception"
function SWEP:Reload()
end

--[[function SWEP:SecondaryAttack()
end]]

local steeringratio = 0.8
function SWEP:Attack(proj)
	if proj:IsValid() and (!proj.Twister or proj.Twister == nil or !IsValid(proj.Twister)) then
		self:GetOwner():EmitSound("weapons/ar1/ar1_dist"..math.random(2)..".wav")
		self:TakeAmmo()
	
		local owner = self:GetOwner()
		--owner:MuzzleFlash()
		self:SendWeaponAnimation()
		owner:DoAttackEvent()
		proj.Twister = self
		local projcenter = proj:GetPos()
		local fireorigin = self:GetOwner():GetShootPos()
		local firevec = ( projcenter - fireorigin ):GetNormalized()
		local ed = EffectData()
			ed:SetFlags( 0x0003 ) --TRACER_FLAG_USEATTACHMENT + TRACER_FLAG_WHIZ
			ed:SetEntity(self)
			ed:SetAttachment(1)
			ed:SetOrigin(proj:GetPos())
		util.Effect("tracer_interception", ed)
		local ed = EffectData()	
			ed:SetOrigin(proj:GetPos())
			ed:SetNormal(firevec*-1)
			ed:SetRadius(2)
			ed:SetMagnitude(1)
			ed:SetScale(1)
		util.Effect("MetalSpark", ed)
		self.IdleAnimation = CurTime() + self:SequenceDuration()
		if SERVER then
			local aimvec = owner:GetAimVector()
			local phys = proj:GetPhysicsObject()
			if phys:IsValid() then
				phys:SetVelocity(phys:GetVelocity()*0.25)
				local dir = (aimvec*steeringratio+firevec*(1-steeringratio))
				phys:AddVelocity(dir*2200)
				proj:SetOwner(self:GetOwner())
			else
				proj:Remove()
			end
		end
		self.LastAttack = CurTime()
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay*1.5)
	end
end

function SWEP:Think()
	local curTime = CurTime()
	if self.IdleAnimation and self.IdleAnimation <= curTime then
		self.IdleAnimation = nil
		self:SendWeaponAnim(ACT_VM_IDLE)
	end
	if SERVER then
	if (self.LastAttack + self.Primary.Delay*2 <= curTime ) and self:Clip1() > 0 then
		local center = self:GetOwner():GetShootPos()
		for _, ent in ipairs(ents.FindInSphere(center, self.SearchRadius)) do
			if (ent ~= self and !ent:IsPlayer() and ent:IsProjectile() and ent:GetMoveType() != MOVETYPE_NONE and not (ent:GetOwner() and ent:GetOwner():IsPlayer() and self:GetOwner():IsPlayer() and ent:GetOwner():Team() == self:GetOwner():Team())) then
				local dot = (ent:GetPos() - center):GetNormalized():Dot(self:GetOwner():GetAimVector())
				if dot >= 0.5 and (LightVisible(center, ent:GetPos(), self, ent, self:GetOwner())) then
					self:Attack(ent)
					break
				end
			end
		end
	end
	end
	self.BaseClass.Think(self)	
end
