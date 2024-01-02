AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_longsword_name"
	SWEP.TranslateDesc = "weapon_longsword_desc"
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

	SWEP.VElements = {
		["base+++"] = { type = "Model", model = "models/props_trainstation/trainstation_ornament002.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0, 0, -5.791), angle = Angle(-90, 0, 0), size = Vector(0.035, 0.029, 0.3), color = Color(209, 209, 228, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+++++"] = { type = "Model", model = "models/props_c17/utilityconnecter005.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0, 0, -5.791), angle = Angle(90, 90, 0), size = Vector(0.223, 0.259, 0.196), color = Color(209, 209, 228, 255), surpresslightning = false, material = "models/props_pipes/pipemetal004a", skin = 0, bodygroup = {} },
		["base"] = { type = "Model", model = "models/props_junk/popcan01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.743, 1.294, 3.095), angle = Angle(6.436, 0, 0), size = Vector(0.412, 0.257, 1.68), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_junk/shoe001a", skin = 0, bodygroup = {} },
		["base++++"] = { type = "Model", model = "models/props_phx/misc/flakshell_big.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0, 0, -5.827), angle = Angle(180, 0, 0), size = Vector(0.093, 0.012, 0.97), color = Color(223, 223, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/props_c17/streetsign002b.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0, 0, 6.59), angle = Angle(0, 0, 0), size = Vector(0.09, 3.848, 0.09), color = Color(156, 155, 173, 255), surpresslightning = false, material = "models/props_pipes/pipesystem01a_skin1", skin = 0, bodygroup = {} },
		["base++"] = { type = "Model", model = "models/props_trainstation/trainstation_ornament002.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0, 0, -5.791), angle = Angle(90, 0, 0), size = Vector(0.035, 0.029, 0.3), color = Color(209, 209, 228, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["base+++++"] = { type = "Model", model = "models/props_c17/utilityconnecter005.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 0, -5.791), angle = Angle(90, 90, 0), size = Vector(0.223, 0.259, 0.196), color = Color(209, 209, 228, 255), surpresslightning = false, material = "models/props_pipes/pipemetal004a", skin = 0, bodygroup = {} },
		["base++"] = { type = "Model", model = "models/props_trainstation/trainstation_ornament002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 0, -5.791), angle = Angle(90, 0, 0), size = Vector(0.035, 0.029, 0.3), color = Color(209, 209, 228, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base"] = { type = "Model", model = "models/props_junk/popcan01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.665, 1.264, 2.4), angle = Angle(-5.286, 16.554, -2.345), size = Vector(0.412, 0.257, 1.68), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_junk/shoe001a", skin = 0, bodygroup = {} },
		["base+++"] = { type = "Model", model = "models/props_trainstation/trainstation_ornament002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 0, -5.791), angle = Angle(-90, 0, 0), size = Vector(0.035, 0.029, 0.3), color = Color(209, 209, 228, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/props_c17/streetsign002b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 0, 6.59), angle = Angle(0, 0, 0), size = Vector(0.09, 3.848, 0.09), color = Color(156, 155, 173, 255), surpresslightning = false, material = "models/props_pipes/pipesystem01a_skin1", skin = 0, bodygroup = {} },
		["base++++"] = { type = "Model", model = "models/props_phx/misc/flakshell_big.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 0, -5.827), angle = Angle(180, 0, 0), size = Vector(0.093, 0.012, 0.97), color = Color(223, 223, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} }
	}
end


SWEP.Base = "weapon_zs_basemelee"

SWEP.HoldType = "melee2"
SWEP.DamageType = DMG_SLASH
SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"
SWEP.ShowWorldModel = false
SWEP.ShowViewModel = false
SWEP.UseHands = true
SWEP.HitDecal = "Manhackcut"

SWEP.MeleeDamage = 35
SWEP.MeleeRange = 60
SWEP.MeleeSize = 4

SWEP.WalkSpeed = SPEED_NORMAL

SWEP.Primary.Delay = 0.5
SWEP.HitAnim = ACT_VM_MISSCENTER
SWEP.SwingHoldType = "melee"

SWEP.ChargeSound = "player/suit_sprint.wav"
SWEP.LastCharge = 0
SWEP.ChargeDelay = 2
function SWEP:SetupDataTables()
	self:NetworkVar("Float", 5, "ChargePerc")
	self:NetworkVar("Bool", 5, "IsCharging")
	if self.BaseClass.SetupDataTables then
		self.BaseClass.SetupDataTables(self)
	end
end
function SWEP:Deploy()
	if self.BaseClass.Deploy then
		self.BaseClass.Deploy(self)
	end
	self:SetChargePerc(0)
	self:SetIsCharging(false)
	return true
end

function SWEP:SecondaryAttack()
	if self:GetNextSecondaryFire() <= CurTime() and not self:GetOwner():IsHolding() and not self:GetIsCharging() then
		self:SetNextSecondaryFire(CurTime() + self.ChargeDelay)
		if not self:GetIsCharging() then
			self:SetIsCharging(true)
			self:GetOwner():ResetSpeed()
		end
	end
end

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(65, 85))
end

function SWEP:PlayHitSound()
	self:EmitSound("ambient/machines/slicer"..math.random(4)..".wav", 75)
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/flesh/flesh_bloody_break.wav", 80, math.Rand(90, 100))
end


function SWEP:Think()
	local owner = self:GetOwner()
	if self:GetIsCharging() then
		if owner:KeyReleased(IN_ATTACK2) or owner:GetBarricadeGhosting() then
			if not owner:GetBarricadeGhosting() then
				self:EmitSound("npc/combine_soldier/gear"..math.random(1,6)..".wav", 80, math.Rand(120, 140),1,CHAN_AUTO+20)
				self:EmitSound("physics/nearmiss/whoosh_large1.wav", 75, math.Rand(140, 180),1,CHAN_AUTO+21)
				if SERVER then
					local fwd = 700 * math.Clamp(self:GetChargePerc(),0,1)
					self:SendWeaponAnim(self.MissAnim)
					owner:DoAttackEvent()
					local pushvel = self:GetOwner():GetEyeTrace().Normal * fwd + (self:GetOwner():GetAngles():Up()*100)
					owner:SetGroundEntity(nil)
					owner:SetLocalVelocity( self:GetOwner():GetVelocity() + pushvel)
					
				end
			end
			self:SetChargePerc(0)
			self:SetIsCharging(false)
			self:SetNextPrimaryFire(CurTime())
			self:SetNextSecondaryFire(CurTime() + self.ChargeDelay/2)
			owner:ResetSpeed()
		elseif self:GetChargePerc() < 1 then
			if self.LastCharge <= CurTime() then
				self:SetChargePerc(math.Clamp(self:GetChargePerc() + 0.03, 0, 1))
				self:EmitSound(self.ChargeSound, 65, 60+70*self:GetChargePerc(), 0.4, CHAN_WEAPON)
				self.LastCharge = CurTime() + 0.08
			end	
		end
	end
	self.BaseClass.Think(self)
end

function SWEP:GetWalkSpeedOverride()
	if self:GetIsCharging() and self:GetOwner():KeyDown(IN_ATTACK2) and not self:GetOwner():GetBarricadeGhosting() then
		return self.WalkSpeed*0.15
	end
	return self.WalkSpeed
end

if CLIENT then
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