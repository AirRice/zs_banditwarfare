AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "추가 방탄복"
	SWEP.Description = "사용시 죽을 때까지 체력이 30 늘어나며 이동속도는 15 하락한다.\n최대체력이 200 이상인 경우 사용할 수 없다."
	SWEP.ViewModelFOV = 70.241170637475
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
			if owner:GetMaxHealth() < 200 then
				owner.HumanSpeedAdder = (owner.HumanSpeedAdder or 0) -15
				owner:ResetSpeed() 
				if SERVER then 
					owner:SetMaxHealth(owner:GetMaxHealth() + 30)
					owner:SetHealth(owner:Health()+30) 
				end
				self:TakePrimaryAmmo(1)
				self:EmitSound("npc/combine_soldier/gear"..math.random(6)..".wav")
			else 
				self.Owner:PrintMessage(HUD_PRINTCENTER, "방탄복을 더 사용할 수 없다.")
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