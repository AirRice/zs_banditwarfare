AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_greataxe_name"
	SWEP.TranslateDesc = "weapon_greataxe_desc"
	SWEP.ViewModelFOV = 55
	SWEP.ViewModelFlip = false

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.VElements = {
		["base2+++"] = { type = "Model", model = "models/props_phx/misc/iron_beam1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(-0.519, 14, 0), angle = Angle(0, 90, -90), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/chairchrome01", skin = 0, bodygroup = {} },
		["base2"] = { type = "Model", model = "models/props_phx/gibs/wooden_wheel2_gib2.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(2, 15.074, -1.5), angle = Angle(0, -45, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/chairchrome01", skin = 0, bodygroup = {} },
		["base"] = { type = "Model", model = "models/props/cs_militia/axe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 1.299, -4), angle = Angle(0, 0, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base2++++"] = { type = "Model", model = "models/props_phx/construct/metal_angle180.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0, 15.064, -1), angle = Angle(0, 180, 0), size = Vector(0.2, 0.2, 0.5), color = Color(255, 255, 255, 35), surpresslightning = false, material = "models/shiny", skin = 0, bodygroup = {} },
		["base2++"] = { type = "Model", model = "models/props_phx/gibs/wooden_wheel2_gib2.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(2.049, 15.064, -1.52), angle = Angle(0, -80, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/chairchrome01", skin = 0, bodygroup = {} },
		["base2+"] = { type = "Model", model = "models/props_phx/construct/metal_angle180.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0, 15.064, -1), angle = Angle(0, 180, 0), size = Vector(0.2, 0.2, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/chairchrome01", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/props/cs_militia/axe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 1.299, -4), angle = Angle(0, 0, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base2+++"] = { type = "Model", model = "models/props_phx/misc/iron_beam1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-0.519, 14, 0), angle = Angle(0, 90, -90), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/chairchrome01", skin = 0, bodygroup = {} },
		["base2"] = { type = "Model", model = "models/props_phx/gibs/wooden_wheel2_gib2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0.699, 15.074, -1.5), angle = Angle(0, -45, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/chairchrome01", skin = 0, bodygroup = {} },
		["base2++++"] = { type = "Model", model = "models/props_phx/construct/metal_angle180.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 15.064, -1), angle = Angle(0, 180, 0), size = Vector(0.2, 0.2, 0.5), color = Color(255, 255, 255, 35), surpresslightning = false, material = "models/shiny", skin = 0, bodygroup = {} },
		["base2++"] = { type = "Model", model = "models/props_phx/gibs/wooden_wheel2_gib2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0.75, 15.064, -1.52), angle = Angle(0, -80, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/chairchrome01", skin = 0, bodygroup = {} },
		["base2+"] = { type = "Model", model = "models/props_phx/construct/metal_angle180.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 15.064, -1), angle = Angle(0, 180, 0), size = Vector(0.2, 0.2, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/chairchrome01", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true

SWEP.HoldType = "melee"

SWEP.MeleeDamage = 75
SWEP.MeleeRange = 60
SWEP.MeleeSize = 1.5
SWEP.Primary.Delay = 1

SWEP.DamageType = DMG_SLASH

SWEP.WalkSpeed = SPEED_SLOWEST
SWEP.SwingTime = 0.4
SWEP.SwingRotation = Angle(0, -20, -40)
SWEP.SwingOffset = Vector(10, 0, 0)
SWEP.SwingHoldType = "melee"

SWEP.MaxDefenseStacks = 20

function SWEP:SetupDataTables()
	self:NetworkVar("Int", 11, "DefenseStacks")
	if self.BaseClass.SetupDataTables then
		self.BaseClass.SetupDataTables(self)
	end
end

function SWEP:Initialize()
	self:SetDefenseStacks(10)
	if self.BaseClass.Initialize then
		self.BaseClass.Initialize(self)
	end
end

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(40, 45))
end

function SWEP:PlayHitSound()
	self:EmitSound("physics/metal/metal_sheet_impact_hard"..math.random(6,8)..".wav")
	self:EmitSound("weapons/melee/golf club/golf_hit-0"..math.random(4)..".ogg", 75, math.random(70, 75),1,CHAN_AUTO+20)
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/flesh/flesh_bloody_break.wav", 80, math.random(95, 105))
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	local effectdata = EffectData()
		effectdata:SetOrigin(tr.HitPos)
		effectdata:SetNormal(tr.HitNormal)
	util.Effect("MetalSpark", effectdata)
end

function SWEP:PlayerHitUtil(owner, damage, hitent, dmginfo)
	hitent:MeleeViewPunch(damage*0.1)
	if SERVER then
		if hitent:WouldDieFrom(damage, dmginfo:GetDamagePosition()) then
			self:SetDefenseStacks(math.min(self:GetDefenseStacks()+3,self.MaxDefenseStacks))
			self:EmitSound("common/warning.wav", 75, math.random(55, 75),0.5,CHAN_AUTO+21)
		else
			self:SetDefenseStacks(math.min(self:GetDefenseStacks()+1,self.MaxDefenseStacks))	
			self:EmitSound("common/warning.wav", 75, math.random(55, 75),0.5,CHAN_AUTO+21)		
		end
	end
end
if SERVER then
	function SWEP:ProcessDamage(dmginfo)
		local attacker, inflictor = dmginfo:GetAttacker(), dmginfo:GetInflictor()
		local owner = self:GetOwner()
		local attackweapon = (attacker:IsPlayer() and attacker:GetActiveWeapon() or nil)
		if attacker:IsPlayer() then
			if self:GetDefenseStacks() and self:GetDefenseStacks() > 0 then
				if dmginfo:IsDamageType(DMG_BULLET) and not (attackweapon and attackweapon.IgnoreDamageScaling) then
					dmginfo:ScaleDamage(0.5)
				end
				local center = owner:LocalToWorld(owner:OBBCenter())
				local hitpos = owner:NearestPoint(dmginfo:GetDamagePosition())
				local effectdata = EffectData()
					effectdata:SetOrigin(center)
					effectdata:SetStart(owner:WorldToLocal(hitpos))
					effectdata:SetAngles((center - hitpos):Angle())
					effectdata:SetEntity(owner)
				util.Effect("shadedeflect", effectdata, true, true)
				self:SetDefenseStacks(math.max(self:GetDefenseStacks()-1,0))
			end
		end
	end
end

if CLIENT then
	local texGradDown = surface.GetTextureID("VGUI/gradient_down")
	function SWEP:DrawHUD()
		local screenscale = BetterScreenScale()
		local scrW = ScrW()
		local scrH = ScrH()
		local wid = 200
		local hei = 30
		local x, y = ScrW() - wid - 32, ScrH() - hei - 72
		if self:GetDefenseStacks() > 0 then
			local metersize = math.Clamp(self:GetDefenseStacks()/self.MaxDefenseStacks,0,1)
			local rcol = 255*(1-metersize)
			local gcol = 255*metersize
			surface.SetDrawColor(5, 5, 5, 180)
			surface.DrawRect(x, y, wid, hei)

			surface.SetDrawColor(rcol, gcol, 0,  180)
			surface.SetTexture(texGradDown)
			surface.DrawTexturedRect(x, y, metersize * wid, hei)

			surface.SetDrawColor(rcol, gcol, 0,  180)
			surface.DrawOutlinedRect(x, y, wid, hei)

			draw.DrawText( translate.Get("weapon_greatexe_defensestacks"), "ZSHUDFontSmallerNS", x+wid/2, y, COLOR_GRAY, TEXT_ALIGN_CENTER )
		end
		self.BaseClass.DrawHUD(self)	
	end
end