AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "추가 방탄복"
	SWEP.Description = "사용시 내구도 100짜리의 방탄복을 입으며 이동속도는 25 하락한다. 이미 방탄복을 입은 경우 사용할 수 없다.\n이 방탄복은 근접 무기 피해를 60%, 총알과 투사체 피해를 50% 줄여준다.\n단 머리를 보호하거나 독 피해는 막지 못한다."
	SWEP.ViewModelFOV = 70
	SWEP.ViewModelFlip = false
	SWEP.Slot = 4
	SWEP.SlotPos = 0
	SWEP.VElements = {
		["main"] = { type = "Model", model = "models/gibs/helicopter_brokenpiece_03.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.71, 2.898, 0.526), angle = Angle(-35.854, 6.664, -154.424), size = Vector(0.187, 0.187, 0.187), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["main"] = { type = "Model", model = "models/gibs/helicopter_brokenpiece_03.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.559, 3.256, -1.499), angle = Angle(-77.095, 60.439, -113.69), size = Vector(0.187, 0.187, 0.187), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.HoldType = "grenade"

SWEP.DamageType = DMG_CLUB

SWEP.ViewModel = "models/weapons/c_bugbait.mdl"
SWEP.WorldModel = "models/gibs/helicopter_brokenpiece_03.mdl"
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.UseHands = true

SWEP.Primary.Delay = 2
SWEP.Primary.ClipSize = 1
SWEP.Primary.Ammo = "healingfactor"

SWEP.WalkSpeed = SPEED_FAST

function SWEP:PrimaryAttack()
	if (self:CanPrimaryAttack()) then
		local owner = self.Owner
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		if (IsValid(owner)) then
			if owner:GetBodyArmor() and owner:GetBodyArmor() < 100 then
				owner.HumanSpeedAdder = (owner.HumanSpeedAdder or 0) -25
				owner:ResetSpeed() 
				owner:SetBodyArmor(100)
				self:TakePrimaryAmmo(1)
				self:EmitSound("npc/combine_soldier/gear"..math.random(6)..".wav")
			else
				if CLIENT then
					self.Owner:PrintMessage(HUD_PRINTTALK, "방탄복을 이미 입고 있다.")
				end
				return
			end
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