AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_combinesniper_name"
	SWEP.TranslateDesc = "weapon_combinesniper_desc"
	SWEP.Slot = 3
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 70

	SWEP.HUD3DBone = "v_weapon.awm_parent"
	SWEP.HUD3DPos = Vector(-1.25, -3.5, -16)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.02
	SWEP.VElements = {
		["clip"] = { type = "Model", model = "models/items/combine_rifle_cartridge01.mdl", bone = "v_weapon.awm_clip", rel = "", pos = Vector(0, -0.648, -0.925), angle = Angle(-71.352, 90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["bolt"] = { type = "Model", model = "models/props_combine/combinecamera001.mdl", bone = "v_weapon.awm_bolt_action", rel = "", pos = Vector(-0.797, 0.442, 1.287), angle = Angle(-35.057, -180, 180), size = Vector(0.186, 0.186, 0.186), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },	
		["handle+"] = { type = "Model", model = "models/props_combine/combine_barricade_bracket01b.mdl", bone = "v_weapon.awm_parent", rel = "handle", pos = Vector(1.516, -3.763, 0), angle = Angle(0, -39.431, 0), size = Vector(0.15, 0.229, 0.189), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["handle"] = { type = "Model", model = "models/props_combine/combine_barricade_bracket01a.mdl", bone = "v_weapon.awm_parent", rel = "", pos = Vector(0.001, -1.795, 0.879), angle = Angle(0, -90.425, 90), size = Vector(0.15, 0.229, 0.189), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["scope+"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "v_weapon.awm_parent", rel = "barrel", pos = Vector(-3.559, 0, 18.972), angle = Angle(0, -33.43, 180), size = Vector(0.116, 0.116, 0.574), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base1+"] = { type = "Model", model = "models/props_combine/combinebutton.mdl", bone = "v_weapon.awm_parent", rel = "handle", pos = Vector(-4.509, 19.67, -0.601), angle = Angle(0, -90, 0), size = Vector(0.177, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base1+++++"] = { type = "Model", model = "models/items/battery.mdl", bone = "v_weapon.awm_parent", rel = "handle", pos = Vector(-0.561, 14.227, 0), angle = Angle(0, 0, -90), size = Vector(0.612, 0.612, 1.268), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base1"] = { type = "Model", model = "models/items/combine_rifle_cartridge01.mdl", bone = "v_weapon.awm_parent", rel = "handle", pos = Vector(-1.305, 2.473, 0), angle = Angle(0, 48.029, 90), size = Vector(0.815, 0.815, 0.815), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["scope"] = { type = "Model", model = "models/props_combine/combine_teleportplatform.mdl", bone = "v_weapon.awm_parent", rel = "barrel", pos = Vector(-3.576, 0, 9.317), angle = Angle(0, -180, 0), size = Vector(0.035, 0.035, 0.085), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base1++++"] = { type = "Model", model = "models/items/battery.mdl", bone = "v_weapon.awm_parent", rel = "handle", pos = Vector(-0.401, 10.829, 0), angle = Angle(0, 0, 90), size = Vector(0.612, 0.612, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sideplate"] = { type = "Model", model = "models/props_combine/eli_pod.mdl", bone = "v_weapon.awm_parent", rel = "barrel", pos = Vector(0.751, 0, 7.131), angle = Angle(0, 0, -180), size = Vector(0.128, 0.128, 0.098), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel"] = { type = "Model", model = "models/props_trainstation/trainstation_column001.mdl", bone = "v_weapon.awm_parent", rel = "handle", pos = Vector(-2.866, -5.452, 0), angle = Angle(0, 0, 90), size = Vector(0.093, 0.093, 0.165), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["butt+"] = { type = "Model", model = "models/props_combine/combine_generator01.mdl", bone = "v_weapon.awm_parent", rel = "handle", pos = Vector(-0.705, -9.558, -0.658), angle = Angle(-90, 90, 0), size = Vector(0.076, 0.123, 0.067), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["scope++"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "v_weapon.awm_parent", rel = "barrel", pos = Vector(-3.751, 0, 7.376), angle = Angle(0, 0, 0), size = Vector(0.107, 0.107, 0.409), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base1++"] = { type = "Model", model = "models/props_trainstation/pole_448connection002b.mdl", bone = "v_weapon.awm_parent", rel = "handle", pos = Vector(-5.058, 9.092, 0), angle = Angle(0, -180, -90), size = Vector(0.061, 0.061, 0.041), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["handle+"] = { type = "Model", model = "models/props_combine/combine_barricade_bracket01b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(1.516, -3.763, 0), angle = Angle(0, -39.431, 0), size = Vector(0.15, 0.229, 0.189), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["handle"] = { type = "Model", model = "models/props_combine/combine_barricade_bracket01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.045, 0.924, -1.936), angle = Angle(80.535, 0, 90), size = Vector(0.15, 0.229, 0.189), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["scope+"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barrel", pos = Vector(-3.559, 0, 18.972), angle = Angle(0, -33.43, 180), size = Vector(0.116, 0.116, 0.574), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base1+"] = { type = "Model", model = "models/props_combine/combinebutton.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(-4.509, 19.67, -0.601), angle = Angle(0, -90, 0), size = Vector(0.177, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base1"] = { type = "Model", model = "models/items/combine_rifle_cartridge01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(-1.305, 2.473, 0), angle = Angle(0, 48.029, 90), size = Vector(0.815, 0.815, 0.815), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base1+++++"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(-0.561, 14.227, 0), angle = Angle(0, 0, -90), size = Vector(0.612, 0.612, 1.268), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["scope"] = { type = "Model", model = "models/props_combine/combine_teleportplatform.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barrel", pos = Vector(-3.576, 0, 9.317), angle = Angle(0, -180, 0), size = Vector(0.035, 0.035, 0.085), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base1++++"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(-0.401, 10.829, 0), angle = Angle(0, 0, 90), size = Vector(0.612, 0.612, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel"] = { type = "Model", model = "models/props_trainstation/trainstation_column001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(-2.866, -5.452, 0), angle = Angle(0, 0, 90), size = Vector(0.093, 0.093, 0.165), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base1++"] = { type = "Model", model = "models/props_trainstation/pole_448connection002b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(-5.058, 9.092, 0), angle = Angle(0, -180, -90), size = Vector(0.061, 0.061, 0.041), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["scope++"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barrel", pos = Vector(-3.751, 0, 7.376), angle = Angle(0, 0, 0), size = Vector(0.107, 0.107, 0.409), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["butt+"] = { type = "Model", model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(-0.705, -9.558, -0.658), angle = Angle(-90, 90, 0), size = Vector(0.076, 0.123, 0.067), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sideplate"] = { type = "Model", model = "models/props_combine/eli_pod.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barrel", pos = Vector(0.751, 0, 7.131), angle = Angle(0, 0, -180), size = Vector(0.128, 0.128, 0.098), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end


SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/cstrike/c_snip_awp.mdl"
SWEP.WorldModel = "models/weapons/w_snip_awp.mdl"
SWEP.UseHands = true
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.ReloadSound = Sound("Weapon_AWP.ClipOut")
SWEP.Primary.Damage = 100
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 1.2
SWEP.ReloadDelay = SWEP.Primary.Delay

SWEP.Primary.ClipSize = 5
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "357"
SWEP.Primary.DefaultClip = 15
SWEP.Recoil = 1.4
SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN
SWEP.NoScaleToLessPlayers = true

SWEP.ConeMax = 0.001
SWEP.ConeMin = 0
SWEP.MovingConeOffset = 0.04
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
SWEP.ReloadSpeed = 0.75

SWEP.IronSightsPos = Vector(-5, -40, 3)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.WalkSpeed = SPEED_SLOWEST

SWEP.TracerName = "tracer_comsniper"
SWEP.ChargeSound = "items/suitchargeok1.wav"
SWEP.LastCharge = 0
SWEP.LastOverchargeAlarm = 0

SWEP.m_HasDifferingDmgValues = true
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
	return self.BaseClass.Deploy(self)
end


function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() or self:GetIsCharging() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	if not self:GetIsCharging() then
		self:SetIsCharging(true)
	end
end

function SWEP:Think()
	local owner = self:GetOwner()
	if self:GetIsCharging() then
		if owner:KeyReleased(IN_ATTACK) or owner:GetBarricadeGhosting() then
			local nextshotdelay = 0.25
			if self:GetChargePerc() > 0.2 and not owner:GetBarricadeGhosting() then
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
				self:SetChargePerc(math.Clamp(self:GetChargePerc() + 0.05, 0, 1))
				self:EmitSound(self.ChargeSound, 65, 70+30*self:GetChargePerc(), 1, CHAN_WEAPON)
				self.LastCharge = CurTime() + 0.08
			end	
		else
			if not self:GetHasOverCharged() then 
				self:SetOverchargeGraces(5)
				self:SetHasOverCharged(true)
			elseif self:GetHasOverCharged() then
				if self.LastOverchargeAlarm <= CurTime() then
					self:EmitSound("npc/attack_helicopter/aheli_damaged_alarm1.wav", 45, 130, 1, CHAN_ITEM)
					self:SetOverchargeGraces(self:GetOverchargeGraces()-1)
					self.LastOverchargeAlarm = CurTime() + 0.5
				end
				if self:GetOverchargeGraces() <= 0 then
					self:SetHasOverCharged(false)
					self:TakeAmmo()
					self:SetChargePerc(0)
					self:SetIsCharging(false)
					self.IdleAnimation = CurTime() + self:SequenceDuration()
					self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
					self:GetOwner():TakeSpecialDamage(60, DMG_DISSOLVE, self:GetOwner(), self)
					local effectdata = EffectData()
						effectdata:SetOrigin(self:GetPos())
					util.Effect("Explosion", effectdata, true, true)
				end
			end
		end
	end
	self.BaseClass.Think(self)
end


function SWEP:EmitFireSound()
	self:EmitSound("npc/sniper/sniper1.wav", 75, 100,1,CHAN_VOICE)
	self:EmitSound("npc/sniper/echo1.wav", 75, 100,1,CHAN_WEAPON)
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
	SWEP.IronsightsMultiplier = 0.25
	function SWEP:GetViewModelPosition(pos, ang)
		if self:IsScoped() then
			return pos + ang:Up() * 256, ang
		end

		return self.BaseClass.GetViewModelPosition(self, pos, ang)
	end
	function SWEP:CalcViewModelView(vm, oldpos, oldang, pos, ang)
		pos, ang = self.BaseClass.CalcViewModelView(self, vm, oldpos, oldang, pos, ang)
		return pos+VectorRand(-0.1,0.1)*math.Clamp(self:GetChargePerc(), 0, 1),ang
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
	function SWEP:ViewModelDrawn()
		self:Anim_ViewModelDrawn()
		if self:GetIsCharging() and not self:IsScoped() then
			self:DrawLaser()
		end
	end

	function SWEP:DrawWorldModel()
		local owner = self:GetOwner()
		if owner:IsValid() and owner.ShadowMan then return end
		self:Anim_DrawWorldModel()
		if self:GetIsCharging() then
			self:DrawLaser()
		end
	end
	SWEP.DrawWorldModelTranslucent = SWEP.DrawWorldModel

	function SWEP:GetMuzzlePos( weapon, attachment )
		if(!IsValid(weapon)) then return end
		local origin = weapon:GetPos()
		local angle = weapon:GetAngles()
		if weapon:IsWeapon() and weapon:IsCarriedByLocalPlayer() then
			if( IsValid( weapon:GetOwner() ) && GetViewEntity() == weapon:GetOwner() ) then
				local viewmodel = weapon:GetOwner():GetViewModel()
				if( IsValid( viewmodel ) ) then
					weapon = viewmodel
				end
			end
		end
		local attachment = weapon:GetAttachment( attachment or 1 )
		if( !attachment ) then
			return origin, angle
		end
		return attachment.Pos, attachment.Ang
	end
	
	local matBeam = Material("trails/laser")
	local matGlow = Material("sprites/glow04_noz")
	function SWEP:DrawLaser() 
		local endpos = nil 
		local startpos = nil
		local td = {}
			td.start = self:GetOwner():EyePos()
			td.mask = MASK_SHOT
			td.filter = {}
			table.Add(td.filter, {self:GetOwner()})
			table.Add(td.filter, {self:GetOwner():GetActiveWeapon()})
			table.Add(td.filter, team.GetPlayers(self:GetOwner():Team()))
			td.endpos = td.start + self:GetOwner():EyeAngles():Forward()*10000
			table.Add(td.filter, {self})
		local tr = util.TraceLine(td)
		local endpos = tr.Hit and tr.HitPos
		startpos = self:GetMuzzlePos( self, 1 )
		if not startpos or not endpos then return end
		render.SetMaterial(matGlow)
		render.DrawSprite( endpos, 4, 4, Color(36, 167, 255,255))
		render.SetMaterial(matBeam)  
		render.DrawBeam( startpos,endpos, 16, 0, 1, Color(36, 167, 255,45*math.Clamp(self:GetChargePerc(), 0, 1)) )
	end
end