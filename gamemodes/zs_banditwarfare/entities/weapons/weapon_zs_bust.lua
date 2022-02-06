AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_buststick_name"
	SWEP.TranslateDesc = "weapon_buststick_desc"
	SWEP.ViewModelFOV = 70
	SWEP.ViewModelFlip = false

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/props_combine/breenbust.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, -2, -17), angle = Angle(180, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["basebroken"] = { type = "Model", model = "models/props_combine/breenbust_chunk01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 1, -17), angle = Angle(180, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["stick"] = { type = "Model", model = "models/props_docks/dock01_pole01a_128.mdl", bone = "ValveBiped.Bip01", rel = "base", pos = Vector(3.25, 3.194, -20.932), angle = Angle(5, 0, 0), size = Vector(0.15, 0.15, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/props_combine/breenbust.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 1, -20), angle = Angle(180, 270, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["basebroken"] = { type = "Model", model = "models/props_combine/breenbust_chunk01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 0, -20), angle = Angle(180, 270, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["stick"] = { type = "Model", model = "models/props_docks/dock01_pole01a_128.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 3, -18), angle = Angle(0, 0, 0), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.DamageType = DMG_CLUB

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true

SWEP.MeleeDamage = 43
SWEP.MeleeRange = 60
SWEP.MeleeSize = 1.4

SWEP.UseMelee1 = false

SWEP.HitGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
SWEP.MissGesture = SWEP.HitGesture

SWEP.SwingRotation = Angle(30, -30, -30)
SWEP.SwingTime = 0.3
SWEP.SwingHoldType = "grenade"
SWEP.RegenTime = 15

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 31, "IsBroken")
	self:NetworkVar("Float", 31, "LastBroken")
	if self.BaseClass.SetupDataTables then
		self.BaseClass.SetupDataTables(self)
	end
end

function SWEP:Think()
	if self:GetLastBroken() and self:GetLastBroken() != 0 and self:GetLastBroken() + self.RegenTime <= CurTime() then
		self:RegenBreak()
		self:SetLastBroken(0)
	end
	self.BaseClass.Think(self)
end

function SWEP:RegenBreak()
	self:SendWeaponAnim(ACT_VM_DRAW)
	self.IdleAnimation = CurTime() + self:SequenceDuration()
	self:SetNextPrimaryFire(self.IdleAnimation)
	self:SetIsBroken(false)
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if not self:GetIsBroken() then
		local edata = EffectData()
			edata:SetOrigin(tr.HitPos)
			edata:SetNormal(tr.HitNormal)
		util.Effect("hit_stone", edata)
		self:SetIsBroken(true)
		self:SetLastBroken(CurTime())
		if hitent and hitent:IsValid() and hitent:IsPlayer() and self:GetOwner() and self:GetOwner():IsValid() and self:GetOwner():IsPlayer() and hitent:Team() ~= self:GetOwner():Team() then
			local status = hitent:GiveStatus("confusion",20)
		end
	else
		hitent:TakeSpecialDamage(self.MeleeDamage*0.5, DMG_SLASH, self:GetOwner(), self, tr.HitPos)
	end
end

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.Rand(35, 45))
end

function SWEP:PlayHitSound()
	self:EmitSound("physics/concrete/rock_impact_hard"..math.random(6)..".wav", 75, math.Rand(86, 90))
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav", 75, math.Rand(86, 90))
end

if CLIENT then
	function SWEP:PostDrawViewModel(vm, pl, wep)
		local veles = self.VElements
		local weles = self.WElements
		local broken = self:GetIsBroken()
		local col1, col2 = Color(0, 0, 0, 0), Color(255, 255, 255, 255)
		if broken then
			veles["base"].color = col1
			veles["basebroken"].color = col2
		else
			veles["base"].color = col2
			veles["basebroken"].color = col1
		end
		if self.BaseClass.PostDrawViewModel then 
			self.BaseClass.PostDrawViewModel(self,vm, pl, wep)
		end
	end
	function SWEP:DrawWorldModel()
		local owner = self:GetOwner()
		if owner:IsValid() and owner.ShadowMan then return end
		local weles = self.WElements
		local broken = self:GetIsBroken()
		local col1, col2 = Color(0, 0, 0, 0), Color(255, 255, 255, 255)
		if broken then
			weles["base"].color = col1
			weles["basebroken"].color = col2
		else
			weles["base"].color = col2
			weles["basebroken"].color = col1
		end
		self:Anim_DrawWorldModel()
	end

	local texGradDown = surface.GetTextureID("VGUI/gradient_down")
	function SWEP:DrawHUD()
		local scrW = ScrW()
		local scrH = ScrH()
		local width = 200
		local height = 30
		local x, y = ScrW() - width - 32, ScrH() - height - 72
		local ratio = math.Clamp((CurTime()-self:GetLastBroken())/self.RegenTime,0,1) 
		if ratio > 0 and self:GetIsBroken() then
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