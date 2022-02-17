AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_grenadelauncher_name"
	SWEP.TranslateDesc = "weapon_grenadelauncher_desc"
	SWEP.Slot = 3
	SWEP.SlotPos = 0
	SWEP.ViewModelFOV = 50
	SWEP.ViewModelFlip = false

	SWEP.HUD3DBone = "ValveBiped.Gun"
	SWEP.HUD3DPos = Vector(1.75, 1, -5)
	SWEP.HUD3DAng = Angle(180, 0, 0)
	SWEP.HUD3DScale = 0.035
	SWEP.VElements = {
		["barrel1"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.base", rel = "diskrotate", pos = Vector(-1, -1.8, -3.5), angle = Angle(0, 0, 0), size = Vector(0.076, 0.076, 0.076), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel2"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.base", rel = "diskrotate", pos = Vector(2.1, 0, -3.5), angle = Angle(0, 0, 0), size = Vector(0.076, 0.076, 0.076), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel3"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.base", rel = "diskrotate", pos = Vector(-2.1, 0, -3.5), angle = Angle(0, 0, 0), size = Vector(0.076, 0.076, 0.076), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel4"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.base", rel = "diskrotate", pos = Vector(-1, 1.8, -3.5), angle = Angle(0, 0, 0), size = Vector(0.076, 0.076, 0.076), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel5"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.base", rel = "diskrotate", pos = Vector(1, 1.8, -3.5), angle = Angle(0, 0, 0), size = Vector(0.076, 0.076, 0.076), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel6"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.base", rel = "diskrotate", pos = Vector(1, -1.8, -3.5), angle = Angle(0, 0, 0), size = Vector(0.076, 0.076, 0.076), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		
		["rotato"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(0, -0.077, 0.418), angle = Angle(0, 0, 0), size = Vector(0.048, 0.048, 0.048), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["handle"] = { type = "Model", model = "models/weapons/w_pist_fiveseven.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(0, 6, -1), angle = Angle(90, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["handle+++"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.base", rel = "rotato", pos = Vector(0, -0.394, 6.8), angle = Angle(0, -90, 0), size = Vector(0.504, 0.504, 0.504), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }, -- angle y to -40, pos z to 8.5
		["handle++"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.base", rel = "handle+++", pos = Vector(4.307, 0, -1.024), angle = Angle(-90, 0, 0), size = Vector(0.658, 0.658, 0.202), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["tringle++"] = { type = "Model", model = "models/props_combine/breenchair.mdl", bone = "ValveBiped.base", rel = "handle", pos = Vector(-6, 0, 4.5), angle = Angle(-105.191, 0, 0), size = Vector(0.223, 0.057, 0.104), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_vents/borealis_vent001b", skin = 0, bodygroup = {} },
		["diskrotate"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.base", rel = "handle+++", pos = Vector(1.679, 0, -2.037), angle = Angle(0, 0, 0), size = Vector(0.065, 0.065, 0.065), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },
		["tringle+"] = { type = "Model", model = "models/props_interiors/bathtub01a.mdl", bone = "ValveBiped.base", rel = "handle", pos = Vector(-5.5, 0.5, 4.5), angle = Angle(-110, 0, 0), size = Vector(0.07, 0.06, 0.09), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },
		
		["disk1"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.base", rel = "handle", pos = Vector(2.575, 0, 4.796), angle = Angle(-90, 0, 0), size = Vector(0.065, 0.065, 0.065), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },
		
		["handle+"] = { type = "Model", model = "models/props_phx2/garbage_metalcan001a.mdl", bone = "ValveBiped.base", rel = "handle+++", pos = Vector(0.203, 0, 0.749), angle = Angle(0, 0, 0), size = Vector(0.658, 0.658, 2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_pipes/valve001_skin2", skin = 0, bodygroup = {} },
		
		["tringle"] = { type = "Model", model = "models/gibs/gunship_gibs_midsection.mdl", bone = "ValveBiped.base", rel = "handle", pos = Vector(-1, 0, 5.5), angle = Angle(50, 0, 0), size = Vector(0.05, 0.03, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_vents/borealis_vent001b", skin = 0, bodygroup = {} }
	}


	SWEP.WElements = {
		["barrel1"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "disk1+", pos = Vector(-1, -1.8, -4.65), angle = Angle(0, 0, 0), size = Vector(0.076, 0.076, 0.105), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel2"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "disk1+", pos = Vector(2.1, 0, -4.65), angle = Angle(0, 0, 0), size = Vector(0.076, 0.076, 0.105), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel3"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "disk1+", pos = Vector(-2.1, 0, -4.65), angle = Angle(0, 0, 0), size = Vector(0.076, 0.076, 0.105), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel4"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "disk1+", pos = Vector(-1, 1.8, -4.65), angle = Angle(0, 0, 0), size = Vector(0.076, 0.076, 0.105), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel5"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "disk1+", pos = Vector(1, 1.8, -4.65), angle = Angle(0, 0, 0), size = Vector(0.076, 0.076, 0.105), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel6"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "disk1+", pos = Vector(1, -1.8, -4.65), angle = Angle(0, 0, 0), size = Vector(0.076, 0.076, 0.105), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["handle+++"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(8.329, 0, 6.831), angle = Angle(-90, 0, 0), size = Vector(0.658, 0.658, 0.425), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["tringle"] = { type = "Model", model = "models/gibs/gunship_gibs_midsection.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(-1, 0, 5.5), angle = Angle(50, 0, 0), size = Vector(0.05, 0.03, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_vents/borealis_vent001b", skin = 0, bodygroup = {} },
		["tringle++"] = { type = "Model", model = "models/props_combine/breenchair.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(-6, 0, 4.5), angle = Angle(-105.191, 0, 0), size = Vector(0.223, 0.057, 0.104), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_vents/borealis_vent001b", skin = 0, bodygroup = {} },
		["disk1+"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle+", pos = Vector(1.6, 0, -0.76), angle = Angle(0, 0, 0), size = Vector(0.065, 0.065, 0.065), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },
		["handle+"] = { type = "Model", model = "models/props_phx2/garbage_metalcan001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(8.972, 0, 6.532), angle = Angle(-90, 0, 0), size = Vector(0.658, 0.658, 1.129), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_pipes/valve001_skin2", skin = 0, bodygroup = {} },
		["disk1"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(3.542, 0, 5), angle = Angle(-90, 0, 0), size = Vector(0.065, 0.065, 0.065), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },
		["tringle+"] = { type = "Model", model = "models/props_interiors/bathtub01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(-5.5, 0.5, 4.5), angle = Angle(-110, 0, 0), size = Vector(0.07, 0.06, 0.09), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_pipes/guttermetal01a", skin = 0, bodygroup = {} },
		["handle++"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(10.532, 0.384, 3.187), angle = Angle(-180, 0, 0), size = Vector(0.658, 0.658, 0.202), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["handle"] = { type = "Model", model = "models/weapons/w_pist_fiveseven.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.996, 1.519, 2.255), angle = Angle(-5.639, -1.772, -180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.ViewModelBoneMods = {
		["ValveBiped.base"] = { scale = Vector(0.093, 0.093, 0.093), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
	}

end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "smg"

SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fiveseven.mdl"
SWEP.UseHands = true
SWEP.ShowViewModel = false

SWEP.ReloadSound = Sound("vehicles/tank_readyfire1.wav")
SWEP.ReloadFinishSound = Sound("buttons/lever7.wav")
SWEP.Primary.Sound = Sound("weapons/grenade_launcher1.wav", 70, 90)
SWEP.Primary.Damage = 15
SWEP.Primary.NumShots = 0
SWEP.Primary.Delay = 0.75
SWEP.Primary.Automatic = false

SWEP.Primary.ClipSize = 6
SWEP.Primary.Ammo = "grenlauncher"
SWEP.Primary.DefaultClip = 6

SWEP.ConeMax = 0
SWEP.ConeMin = 0

SWEP.Recoil = 1.65
SWEP.IronSightsPos = Vector(-9.08, 0, -1.28)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.ReloadSpeed = 0.65
SWEP.WalkSpeed = SPEED_SLOWER

SWEP.BarrelAligned = true
SWEP.LastBarrelAngle = 0
SWEP.BarrelAngleTarget = 0
SWEP.LastShotTime = 0
SWEP.DuringReload = false

SWEP.m_NotBulletWeapon = true

function SWEP:Deploy()
	if self.BaseClass.Deploy then
		self.BaseClass.Deploy(self)
	end
	self.BarrelAligned = true
	self.LastBarrelAngle = 0
	self.BarrelAngleTarget = 0
	self.LastShotTime = 0
	self.DuringReload = false
	return true
end

function SWEP:ShootBullets(dmg, numbul, cone)
	local owner = self:GetOwner()
	--owner:MuzzleFlash()
	if SERVER then
		self:SetConeAndFire()
	end
	self:DoRecoil()
	self:SendWeaponAnimation()
	owner:DoAttackEvent()
	self.BarrelAligned = false
	self.LastShotTime = CurTime()
	self.BarrelAngleTarget = self.LastBarrelAngle + 60
	self:SetNextReload(CurTime() + 1)
	if SERVER then
		local ent = ents.Create("projectile_launchedgrenade")
		if ent:IsValid() then
			ent.Damage = self.Primary.Damage
			ent:SetPos(owner:GetShootPos())
			ent:SetAngles(owner:GetAimVector():Angle())
			ent:SetOwner(owner)
			ent:Spawn()
			ent.GrenadeDamage = dmg
			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then
				phys:Wake()
				phys:SetVelocityInstantaneous(self:GetOwner():GetAimVector() * 1000)
			end
		end
	end
end

function SWEP:Think()
	local owner = self:GetOwner()
	if not self.BarrelAligned then
		if CLIENT then
			if self.LastBarrelAngle %360 == 0 then
				self.VElements["diskrotate"].angle.y = 0
				self.BarrelAngleTarget = self.BarrelAngleTarget%360
			end
			self.VElements["diskrotate"].angle.y = math.Approach(self.VElements["diskrotate"].angle.y, self.BarrelAngleTarget, FrameTime()*160)
		end
		if self.LastShotTime + self.Primary.Delay <= CurTime() then
			self.BarrelAligned = true
			self.LastBarrelAngle = self.BarrelAngleTarget
		end
	end
	if CLIENT then
		self.VElements["handle+++"].pos.z = math.Approach(self.VElements["handle+++"].pos.z, self.DuringReload and 8.5 or 6.8, FrameTime()*100)
		self.VElements["handle+++"].angle.y = math.Approach(self.VElements["handle+++"].angle.y, self.DuringReload and -40 or -90, FrameTime()*100)
	end
	if self.BaseClass.Think then
		self.BaseClass.Think(self)
	end
end

function SWEP:SendReloadAnimation()
	self:SendWeaponAnim(ACT_VM_RELOAD)
	if IsFirstTimePredicted() then
		self:EmitSound(self.ReloadFinishSound, 75, 60, 1, CHAN_WEAPON + 20)
	end
	self.DuringReload = true
	self.BarrelAligned = false
	self.LastShotTime = CurTime()
	self.BarrelAngleTarget = 0
	self.LastBarrelAngle = 0
	if self.BaseClass.SendReloadAnimation then
		self.BaseClass.SendReloadAnimation(self)
	end
end

function SWEP:EmitReloadFinishSound()
	self.DuringReload = false
	if IsFirstTimePredicted() then
		self:EmitSound(self.ReloadFinishSound, 75, 70, 1, CHAN_WEAPON + 21)
	end
end