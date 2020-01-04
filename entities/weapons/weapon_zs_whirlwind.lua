AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "'비르벨빈트' 휴대용 국지방어기"
	SWEP.Description = "탄약을 사용해 주변의 투사체를 요격하는 총기이다."

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
SWEP.Primary.Damage = 11
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.07

SWEP.Primary.ClipSize = 20
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SMG1

SWEP.ConeMax = 0.09
SWEP.ConeMin = 0.01
SWEP.Recoil = 0.28
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)

SWEP.WalkSpeed = SPEED_SLOW
SWEP.LastAttack = 0
SWEP.SearchRadius = 160
function SWEP:SecondaryAttack()
end

function SWEP:Attack(proj)
	if (!proj.Twister or proj.Twister == nil or !IsValid(proj.Twister)) and proj:IsValid() then
		self.Owner:EmitSound("weapons/ar1/ar1_dist"..math.random(2)..".wav")
		self:TakeAmmo()
	
		local owner = self.Owner
		--owner:MuzzleFlash()
		self:SendWeaponAnimation()
		owner:DoAttackEvent()
		proj.Twister = self
		local projcenter = proj:GetPos()
		local fireorigin = self.Owner:GetShootPos()
		local firevec = ( projcenter - fireorigin ):GetNormalized()
		local ed = EffectData()
			ed:SetOrigin(proj:GetPos())
			ed:SetNormal(firevec*-1)
			ed:SetRadius(2)
			ed:SetMagnitude(1)
			ed:SetScale(1)
		util.Effect("MetalSpark", ed)
		self.Owner:FireBullets({Num = 1, Src = fireorigin, Dir = firevec, Spread = Vector(0, 0, 0), Tracer = 1, TracerName = "AR2Tracer", Force = self.Primary.Damage * 0.1, Damage = 1, Callback = nil})
		self.IdleAnimation = CurTime() + self:SequenceDuration()
		if SERVER then
			proj:Remove()
		end
	end
end

function SWEP:Think()
	local curTime = CurTime()
	if self.IdleAnimation and self.IdleAnimation <= CurTime() then
		self.IdleAnimation = nil
		self:SendWeaponAnim(ACT_VM_IDLE)
	end
	self.BaseClass.Think(self)	
	if (self.LastAttack + self.Primary.Delay*0.75 <= curTime ) and self:Clip1() > 0 then
		local center = self.Owner:GetShootPos()
		for _, ent in pairs(ents.FindInSphere(center, self.SearchRadius)) do
			if (ent ~= self and ent:IsProjectile() and not (ent:GetOwner() and ent:GetOwner():IsPlayer() and self.Owner:IsPlayer() and ent:GetOwner():Team() == self.Owner:Team())) then				
				print(ent:GetClass())
				local dot = (ent:GetPos() - center):GetNormalized():Dot(self.Owner:GetAimVector())
				if dot >= 0.5 and (LightVisible(center, ent:GetPos(), self, ent, self.Owner)) then
					self:Attack(ent)
					self.LastAttack = curTime
					self:SetNextPrimaryFire(CurTime() + self.Primary.Delay*0.75)
				end
			end
		end
	end
end
