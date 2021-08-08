AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_integrator_name"
	SWEP.TranslateDesc = "weapon_integrator_desc"
	SWEP.Slot = 3
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 80

	SWEP.HUD3DBone = "v_weapon.famas"
	SWEP.HUD3DPos = Vector(1.1, -3.5, 5)
	SWEP.HUD3DScale = 0.025
	SWEP.VElements = {
		["sidebattery++++"] = { type = "Model", model = "models/items/car_battery01.mdl", bone = "v_weapon.famas", rel = "base", pos = Vector(-0.755, 1.029, -1.609), angle = Angle(-90, 180, 0), size = Vector(0.218, 0.218, 0.218), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["pullhandle"] = { type = "Model", model = "models/props_combine/combine_emitter01.mdl", bone = "v_weapon.bolt", rel = "", pos = Vector(0, 0.407, -0.244), angle = Angle(24.01, 90, -180), size = Vector(0.083, 0.083, 0.083), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery++"] = { type = "Model", model = "models/props_lab/powerbox02b.mdl", bone = "v_weapon.famas", rel = "base", pos = Vector(1.325, -6.424, -1.798), angle = Angle(0, 0, 0), size = Vector(0.086, 0.086, 0.086), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["limb"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025c.mdl", bone = "v_weapon.famas", rel = "base", pos = Vector(-0.962, -5.25, -1.364), angle = Angle(0, 90, 0), size = Vector(0.293, 0.293, 0.097), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_wasteland/wood_fence01a", skin = 0, bodygroup = {} },
		["base++"] = { type = "Model", model = "models/props_combine/combinethumper002.mdl", bone = "v_weapon.famas", rel = "base", pos = Vector(0, 9.163, -4.272), angle = Angle(-180, 180, 93.026), size = Vector(0.029, 0.035, 0.035), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["grip"] = { type = "Model", model = "models/weapons/w_pist_fiveseven.mdl", bone = "v_weapon.famas", rel = "base", pos = Vector(0.079, -2.741, -7.948), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "v_weapon.famas", rel = "base", pos = Vector(0, -2.258, -2.037), angle = Angle(-180, 0, 0), size = Vector(0.02, 0.046, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery+"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "v_weapon.famas", rel = "base", pos = Vector(-0.959, -10.294, -1.349), angle = Angle(0, -10.186, 90), size = Vector(0.142, 0.224, 0.187), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["battery"] = { type = "Model", model = "models/items/battery.mdl", bone = "v_weapon.magazine", rel = "", pos = Vector(0, -4, -0.569), angle = Angle(-90, -90, 0), size = Vector(0.316, 0.216, 0.545), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["back++"] = { type = "Model", model = "models/props_combine/breenpod_inner.mdl", bone = "v_weapon.famas", rel = "base", pos = Vector(0, -13.459, -6.896), angle = Angle(-14.422, -90, 0), size = Vector(0.372, 0.093, 0.12), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["back+"] = { type = "Model", model = "models/props_combine/combine_emitter01.mdl", bone = "v_weapon.famas", rel = "base", pos = Vector(0, 7.48, -2.248), angle = Angle(0, -90, 0), size = Vector(0.224, 1.131, 0.224), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery+++"] = { type = "Model", model = "models/items/car_battery01.mdl", bone = "v_weapon.famas", rel = "base", pos = Vector(0.684, 1.029, -1.609), angle = Angle(-90, 0, 0), size = Vector(0.218, 0.218, 0.218), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base"] = { type = "Model", model = "models/props_combine/combine_train02b.mdl", bone = "v_weapon.famas", rel = "", pos = Vector(0, -2.314, 14.84), angle = Angle(0, 0, -90), size = Vector(0.021, 0.035, 0.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "v_weapon.famas", rel = "base", pos = Vector(0.688, -8.968, -1.333), angle = Angle(0, -166.051, -90), size = Vector(0.142, 0.224, 0.187), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["battery+"] = { type = "Model", model = "models/items/combine_rifle_cartridge01.mdl", bone = "v_weapon.magazine", rel = "", pos = Vector(0, -4.5, 1.401), angle = Angle(-59.612, 90, 0), size = Vector(0.467, 0.467, 0.467), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["back"] = { type = "Model", model = "models/props_combine/breenconsole.mdl", bone = "v_weapon.famas", rel = "base", pos = Vector(0, -4.919, 1.039), angle = Angle(180, 180, 90), size = Vector(0.071, 0.138, 0.164), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery+++1"] = { type = "Model", model = "models/props_c17/utilityconnecter006c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-4.371, 3.299, -1.851), angle = Angle(-90.199, -154, 0), size = Vector(0.135, 0.135, 0.14), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery++++++"] = { type = "Model", model = "models/props_c17/utilityconnecter006c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(3.884, 3.299, -1.851), angle = Angle(-90.199, -26.178, 0), size = Vector(0.135, 0.135, 0.14), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["limb"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-0.962, -5.25, -1.364), angle = Angle(0, 90, 0), size = Vector(0.293, 0.293, 0.097), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_wasteland/wood_fence01a", skin = 0, bodygroup = {} },
		["sidebattery"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0.688, -8.968, -1.333), angle = Angle(0, -166.051, -90), size = Vector(0.142, 0.224, 0.187), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery+++++"] = { type = "Model", model = "models/items/car_battery01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0.684, 1.029, -1.609), angle = Angle(-90, 0, 0), size = Vector(0.218, 0.218, 0.218), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["back"] = { type = "Model", model = "models/props_combine/breenconsole.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, -4.919, 1.039), angle = Angle(180, 180, 90), size = Vector(0.071, 0.138, 0.164), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery++++"] = { type = "Model", model = "models/items/car_battery01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-0.755, 1.029, -1.609), angle = Angle(-90, 180, 0), size = Vector(0.218, 0.218, 0.218), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base"] = { type = "Model", model = "models/props_combine/combine_train02b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.381, 1.725, -5.763), angle = Angle(0, -94.45, 180), size = Vector(0.021, 0.035, 0.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery++++++"] = { type = "Model", model = "models/props_c17/utilityconnecter006c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(3.884, 3.299, -1.851), angle = Angle(-90.199, -26.178, 0), size = Vector(0.135, 0.135, 0.14), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base++"] = { type = "Model", model = "models/props_combine/combinethumper002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 9.163, -4.272), angle = Angle(-180, 180, 93.026), size = Vector(0.029, 0.035, 0.035), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, -2.258, -2.037), angle = Angle(-180, 0, 0), size = Vector(0.02, 0.046, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery+++1"] = { type = "Model", model = "models/props_c17/utilityconnecter006c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-4.371, 3.299, -1.851), angle = Angle(-90.199, -154, 0), size = Vector(0.135, 0.135, 0.14), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["back++"] = { type = "Model", model = "models/props_combine/breenpod_inner.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, -13.459, -6.896), angle = Angle(-14.422, -90, 0), size = Vector(0.372, 0.093, 0.12), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["back+"] = { type = "Model", model = "models/props_combine/combine_emitter01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 7.48, -2.248), angle = Angle(0, -90, 0), size = Vector(0.224, 1.131, 0.224), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery+"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-0.959, -10.294, -1.349), angle = Angle(0, -10.186, 90), size = Vector(0.142, 0.224, 0.187), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery++"] = { type = "Model", model = "models/props_lab/powerbox02b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(1.325, -6.424, -1.798), angle = Angle(0, 0, 0), size = Vector(0.086, 0.086, 0.086), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery+++"] = { type = "Model", model = "models/items/car_battery01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0.684, 1.029, -1.609), angle = Angle(-90, 0, 0), size = Vector(0.218, 0.218, 0.218), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/cstrike/c_rif_famas.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fiveseven.mdl"
SWEP.UseHands = true
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.ReloadSound = Sound("Weapon_AWP.ClipOut")
SWEP.Primary.Sound = Sound("Weapon_EMPgun.Single")
SWEP.Primary.Damage = 100
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.5
SWEP.ReloadDelay = SWEP.Primary.Delay

SWEP.Primary.ClipSize = 5
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "XBowBolt"
SWEP.Primary.DefaultClip = 15
SWEP.Recoil = 1.4
SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN
SWEP.NoScaleToLessPlayers = true
SWEP.ReloadSpeed = 0.75

SWEP.ConeMax = 0.001
SWEP.ConeMin = 0
SWEP.MovingConeOffset = 0.04
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)

SWEP.IronSightsPos = Vector(-3, 3, 2)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.WalkSpeed = SPEED_SLOWEST

SWEP.ChargeSound = "npc/scanner/scanner_pain2.wav"
SWEP.LastCharge = 0
SWEP.LastOverchargeAlarm = 0
function SWEP:SetupDataTables()
	self:NetworkVar("Float", 5, "ChargePerc")
	self:NetworkVar("Bool", 5, "IsCharging")
	self:NetworkVar("Bool", 4, "HasOverCharged")
	self:NetworkVar("Int", 4, "OverchargeGraces")
	if self.BaseClass.SetupDataTables then
		self.BaseClass.SetupDataTables(self)
	end
end
function SWEP:Deploy()
	self:SetOverchargeGraces(5)
	self:SetChargePerc(0)
	self:SetIsCharging(false)
	self:SetHasOverCharged(false)
	if self.BaseClass.Deploy then
		return self.BaseClass.Deploy(self)
	end
end


function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() or self:GetIsCharging() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	if not self:GetIsCharging() then
		self:SetIsCharging(true)
	end
end

function SWEP:Think()
	local owner = self.Owner
	if self:GetIsCharging() then
		if owner:KeyReleased(IN_ATTACK) then
			local nextshotdelay = 0.25
			if self:GetChargePerc() > 0.1 then
				self:TakeAmmo()
				self:EmitFireSound()
				self:ShootBullets(self.Primary.Damage*math.Clamp(self:GetChargePerc(), 0, 1), self.Primary.NumShots, self:GetCone())
				nextshotdelay = self.Primary.Delay
			end
			self:SetChargePerc(0)
			self:SetIsCharging(false)
			self:SetHasOverCharged(false)
			self.IdleAnimation = CurTime() + self:SequenceDuration()
			self:SetNextPrimaryFire(CurTime() + nextshotdelay)
		elseif self:GetChargePerc() < 1 then
			if self.LastCharge <= CurTime() then
				self:SetChargePerc(math.Clamp(self:GetChargePerc() + 0.1, 0, 1))
				self:EmitSound(self.ChargeSound, 65, 80+60*self:GetChargePerc(), 1, CHAN_WEAPON)
				self.LastCharge = CurTime() + 0.08
			end	
		else
			if not self:GetHasOverCharged() then 
				self:SetOverchargeGraces(8)
				self:SetHasOverCharged(true)
			elseif self:GetHasOverCharged() then
				if self.LastOverchargeAlarm <= CurTime() then
					self:EmitSound("npc/scanner/combat_scan4.wav", 60, 110, 1, CHAN_ITEM)
					self:SetOverchargeGraces(self:GetOverchargeGraces()-1)
					self.LastOverchargeAlarm = CurTime() + 0.3
				end
				if self:GetOverchargeGraces() <= 0 then
					self:SetHasOverCharged(false)
					self:TakeAmmo()
					self:SetChargePerc(0)
					self:SetIsCharging(false)
					self.IdleAnimation = CurTime() + self:SequenceDuration()
					self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
					self.Owner:TakeSpecialDamage(30, DMG_DISSOLVE, self.Owner, self)
					local effectdata = EffectData()
						effectdata:SetOrigin(self:GetPos())
					util.Effect("Explosion", effectdata, true, true)
				end
			end
		end
	end
	self.BaseClass.Think(self)
end

function SWEP:IsScoped()
	return self:GetIronsights() and self.fIronTime and self.fIronTime + 0.25 <= CurTime()
end

function SWEP.BulletCallback(attacker, tr, dmginfo)
	--[[if CLIENT then
		local effectdata = EffectData()
			effectdata:SetOrigin(tr.HitPos)
			effectdata:SetStart(tr.StartPos)
			effectdata:SetEntity(attacker:GetActiveWeapon())
			effectdata:SetAttachment(1)
			effectdata:SetFlags(TRACER_LINE_AND_WHIZ)
		util.Effect("tracer_comsniper", effectdata)
	end]]
	GenericBulletCallback(attacker, tr, dmginfo)
end

if CLIENT then

	function SWEP:TranslateFOV(fov)
		return GAMEMODE.FOVLerp * fov * (1-0.03*math.Clamp(self:GetChargePerc(), 0, 1))
	end
	SWEP.IronsightsMultiplier = 0.55
	function SWEP:GetViewModelPosition(pos, ang)
		if self:IsScoped() then
			return pos + ang:Up() * 256, ang
		end

		return self.BaseClass.GetViewModelPosition(self, pos, ang)
	end
	function SWEP:CalcViewModelView(vm, oldpos, oldang, pos, ang)
		pos, ang = self.BaseClass.CalcViewModelView(self, vm, oldpos, oldang, pos, ang)
		return pos+VectorRand(-0.3,0.3)*math.Clamp(self:GetChargePerc(), 0, 1),ang
	end
	local texGradDown = surface.GetTextureID("VGUI/gradient_down")
	function SWEP:DrawHUD()
		local scrW = ScrW()
		local scrH = ScrH()
		local width = 200
		local height = 30
		local x, y = (ScrW()- width)*0.5 , (ScrH() - height)*0.75
		local ratio = math.Clamp(self:GetChargePerc(), 0, 1)
		if ratio > 0 then
			surface.SetDrawColor(5, 5, 5, 180)
			surface.DrawRect(x, y, width, height)
			surface.SetDrawColor(255, 0, 0, 180)
			surface.SetTexture(texGradDown)
			surface.DrawTexturedRect(x, y, width*ratio, height)
			surface.SetDrawColor(255, 0, 0, 180)
			surface.DrawOutlinedRect(x - 1, y - 1, width + 2, height + 2)
		end
		if self.BaseClass.DrawHUD then
			self.BaseClass.DrawHUD(self)
		end
	end
end