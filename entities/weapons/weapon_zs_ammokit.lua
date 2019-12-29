AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "탄약킷"
	SWEP.Description = "탄약이 들어 있는 박스. 팀원이 들고 있는 무기의 탄약을 총 3번 공급해줄 수 있다."
	SWEP.Slot = 4

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 50
	SWEP.ShowViewModel = true
	SWEP.ShowWorldModel = false

	SWEP.ViewModelBoneMods = {
		["ValveBiped.cube1"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
		["ValveBiped.cube2"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
		["ValveBiped.cube3"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
		["ValveBiped.cube"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
	}
	SWEP.VElements = {
		["main"] = { type = "Model", model = "models/items/boxmrounds.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.19, 5.821, 3.233), angle = Angle(0, 0, 180), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["main"] = { type = "Model", model = "models/items/boxmrounds.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.942, 6.539, 1.677), angle = Angle(0, 57.424, 180), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_base"

SWEP.ViewModel = "models/weapons/c_bugbait.mdl"
SWEP.WorldModel = "models/items/boxmrounds.mdl"
SWEP.UseHands = true
SWEP.AmmoIfHas = true

SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 3
SWEP.Primary.Ammo = "smg1_grenade"
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 1.25


SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "dummy"

SWEP.WalkSpeed = SPEED_FAST

SWEP.HoldType = "slam"

function SWEP:Initialize()
	self:SetWeaponHoldType("slam")
	self:SetDeploySpeed(1.1)

	if CLIENT then
		self:Anim_Initialize()
	end
end

function SWEP:CanPrimaryAttack()
	if self.Owner:IsHolding() or self.Owner:GetBarricadeGhosting() then return false end

	if self:GetPrimaryAmmoCount() <= 0 then
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		return false
	end

	return true
end

function SWEP:PrimaryAttack()	
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	
	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + 200 * self.Owner:GetAimVector()
	tr.filter = {self.Owner}
	local trace = util.TraceLine(tr)
	if trace.Hit and trace.Entity:IsPlayer() and self.Owner:IsPlayer() and trace.Entity:Team() == self.Owner:Team() then
		self:SendWeaponAnim(ACT_VM_THROW)
		self.Owner:DoAttackEvent()
		self:TakePrimaryAmmo(1)	
		self.NextDeploy = CurTime() + 0.65
		local ammotype
		local wep = trace.Entity:GetActiveWeapon()
		if not wep:IsValid() then
			ammotype = "smg1"
		end

		if not ammotype then
			ammotype = wep:GetPrimaryAmmoTypeString()
			if not GAMEMODE.AmmoResupply[ammotype] then
				ammotype = "smg1"
			end
		end
		if SERVER then
			trace.Entity:GiveAmmo(GAMEMODE.AmmoResupply[ammotype], ammotype)
			self.Owner:AddPoints(1)
			net.Start("zs_commission")
				net.WriteEntity(self)
				net.WriteEntity(activator)
				net.WriteUInt(1, 16)
			net.Send(self.Owner)
		end
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:CanSecondaryAttack()
	return false
end

function SWEP:Reload()
	return false
end

function SWEP:Deploy()
	GAMEMODE:WeaponDeployed(self.Owner, self)

	if self:GetPrimaryAmmoCount() <= 0 then
		self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
	end

	return true
end

function SWEP:Holster()
	self.NextDeploy = nil

	if CLIENT then
		self:Anim_Holster()
	end

	return true
end

function SWEP:Think()
	if self.NextDeploy and self.NextDeploy <= CurTime() then
		self.NextDeploy = nil

		if 0 < self:GetPrimaryAmmoCount() then
			self:SendWeaponAnim(ACT_VM_DRAW)
		else
			self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)

			if SERVER then
				self:Remove()
			end
		end
	elseif SERVER and self:GetPrimaryAmmoCount() <= 0 then
		self:Remove()
	end
end