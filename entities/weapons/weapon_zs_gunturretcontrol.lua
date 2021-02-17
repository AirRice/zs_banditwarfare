AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_turretcontrol_name"
	SWEP.TranslateDesc = "weapon_turretcontrol_desc"

	SWEP.ViewModelFOV = 50

	SWEP.BobScale = 0.5
	SWEP.SwayScale = 0.5

	SWEP.Slot = 4
	SWEP.SlotPos = 0
end

SWEP.ViewModel = "models/weapons/c_slam.mdl"
SWEP.WorldModel = "models/weapons/w_slam.mdl"
SWEP.UseHands = true

SWEP.Primary.Delay = 0
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.Delay = 20
SWEP.Secondary.Heal = 10

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.WalkSpeed = SPEED_FAST

SWEP.NoMagazine = true
SWEP.Undroppable = true
SWEP.NoPickupNotification = true

SWEP.HoldType = "slam"

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	self:SetDeploySpeed(10)
	if CLIENT then
		if self.TranslateName then
			self.PrintName = translate.Get(self.TranslateName)
		end
	end
end

function SWEP:Think()
	if self.IdleAnimation and self.IdleAnimation <= CurTime() then
		self.IdleAnimation = nil
		self:SendWeaponAnim(ACT_VM_IDLE)
	end

	if SERVER then
		self:ControlClosestTurret()

		for _, ent in pairs(ents.FindByClass("prop_gunturret")) do
			if ent:GetObjectOwner() == self.Owner then
				return
			end
		end

		self.Owner:StripWeapon(self:GetClass())
	end
end

function SWEP:ControlClosestTurret()
	local closest, closestdist
	local ownerpos = self.Owner:GetPos()
	for _, ent in pairs(ents.FindByClass("prop_gunturret")) do
		if ent:GetObjectOwner() == self.Owner then
			local dist = ent:NearestPoint(ownerpos):Distance(ownerpos)
			if not closestdist or dist < closestdist then
				closest = ent
				closestdist = dist
			end
		end
	end
	if closest then
		self:SetTurret(closest)
	end
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
	if IsFirstTimePredicted() then
		self:SetDTBool(0, not self:GetDTBool(0))

		if CLIENT then
			LocalPlayer():EmitSound(self:GetDTBool(0) and "buttons/button17.wav" or "buttons/button19.wav", 0)
		end
	end
end

function SWEP:GetTurret()
	return self:GetDTEntity(0)
end

function SWEP:SetTurret(ent)
	self:SetDTEntity(0, ent)
end

function SWEP:Reload()
	return false
end
	
function SWEP:Deploy()
	gamemode.Call("WeaponDeployed", self.Owner, self)

	self.IdleAnimation = CurTime() + self:SequenceDuration()

	return true
end

function SWEP:Holster()
	return true
end

function SWEP:Reload()
end

if not CLIENT then return end

function SWEP:DrawWeaponSelection(...)
	return self:BaseDrawWeaponSelection(...)
end
