AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "아드레날린"
	SWEP.Description = "사용시 피해를 30 입으며 이동속도는 20 증가한다."
	SWEP.ViewModelFOV = 70
	SWEP.ViewModelFlip = false
	SWEP.Slot = 4
	SWEP.SlotPos = 0
	SWEP.VElements = {
		["vial"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.72, 2.786, -6.374), angle = Angle(0, 0, 0), size = Vector(0.823, 0.823, 0.823), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["body"] = { type = "Model", model = "models/props_phx/games/chess/black_rook.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "vial", pos = Vector(-0.047, 0.01, -0.81), angle = Angle(0, 0, 0), size = Vector(0.238, 0.238, 0.404), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["noz"] = { type = "Model", model = "models/props_pipes/valve001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "vial", pos = Vector(-0.301, 0.034, 4.9), angle = Angle(0, 0, 0), size = Vector(0.167, 0.167, 0.167), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["element_name"] = { type = "Model", model = "models/props_pipes/valve001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name++", pos = Vector(-0.301, 0.034, 4.9), angle = Angle(0, 0, 0), size = Vector(0.167, 0.167, 0.167), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["element_name+"] = { type = "Model", model = "models/props_phx/games/chess/black_rook.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name++", pos = Vector(-0.047, 0.01, -0.81), angle = Angle(0, 0, 0), size = Vector(0.238, 0.238, 0.404), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["element_name++"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.338, 1.253, -3.791), angle = Angle(0, 0, 0), size = Vector(0.823, 0.823, 0.823), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end



SWEP.Base = "weapon_zs_basemelee"

SWEP.HoldType = "fist"

SWEP.DamageType = DMG_CLUB

SWEP.ViewModel = "models/weapons/c_bugbait.mdl"
SWEP.WorldModel = "models/healthvial.mdl"
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.UseHands = true

SWEP.Primary.Delay = 2
SWEP.Primary.ClipSize = 1
SWEP.Primary.Ammo = "adrenaline"

SWEP.WalkSpeed = SPEED_FAST

function SWEP:PrimaryAttack()
	if (self:CanPrimaryAttack()) then
		local owner = self.Owner
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		if (IsValid(owner)) then
			owner.HumanSpeedAdder = (owner.HumanSpeedAdder or 0) +20
			owner:ResetSpeed() 
			if SERVER then 
				owner:TakeDamage(30, owner, self)
			end
			self:TakePrimaryAmmo(1)
			self:EmitSound("player/suit_sprint.wav")		
		else
			if SERVER then
				owner:StripWeapon(self:GetClass())
			end
		end	
		
		if (self:GetPrimaryAmmoCount() <= 0) and SERVER then
			owner:StripWeapon(self:GetClass())
		end
		
	end
end