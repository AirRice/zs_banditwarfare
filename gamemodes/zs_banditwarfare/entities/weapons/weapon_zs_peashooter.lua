AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_peashooterpistol_name"
	SWEP.TranslateDesc = "weapon_peashooterpistol_desc"
	SWEP.Slot = 1
	SWEP.SlotPos = 0

	SWEP.ViewModelFOV = 60
	SWEP.ViewModelFlip = false

	SWEP.HUD3DBone = "v_weapon.p228_Slide"
	SWEP.HUD3DPos = Vector(-0.88, 0.35, 1)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.015
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "pistol"

SWEP.ViewModel = "models/weapons/cstrike/c_pist_p228.mdl"
SWEP.WorldModel = "models/weapons/w_pist_p228.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_P228.Single")
SWEP.Primary.Damage = 8
SWEP.Primary.NumShots = 3
SWEP.Primary.Delay = 0.08

SWEP.Primary.ClipSize = 18
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"
GAMEMODE:SetupDefaultClip(SWEP.Primary)
SWEP.Recoil = 0.275
SWEP.ConeMax = 0.028
SWEP.ConeMin = 0.007
SWEP.MovingConeOffset = 0.04
SWEP.IronSightsPos = Vector(-6, -1, 2.25)

GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)

function SWEP:SetupDataTables()
	self:NetworkVar( "Int" , 10 , "RemainingShots" )
	self:NetworkVar( "Float" , 9 , "NextPshtrFire" )
	if self.BaseClass.SetupDataTables then
		self.BaseClass.SetupDataTables(self)
	end
end

function SWEP:Initialize()
	self:SetRemainingShots(0)
	self:SetNextPshtrFire(0)
	self.BaseClass.Initialize(self)
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end 
	local shots = math.min(self:Clip1(),self.Primary.NumShots)
	self:SetRemainingShots(shots)
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay*(shots + 1.5))
	self:SetNextReload(CurTime() + self.Primary.Delay*(shots + 1.5))

	-- for i = 0, shots-1 do
	-- 	timer.Simple(self.Primary.Delay * i, function()
	-- 		if (self:IsValid() and self:GetOwner():Alive()) then
	-- 			self:EmitFireSound()
	-- 			self:TakeAmmo()
	-- 			self:ShootBullets(self.Primary.Damage, 1, self:GetCone())
	-- 		end
	-- 	end)
	-- end
	self.IdleAnimation = CurTime() + self:SequenceDuration()		
end

function SWEP:Think()	
	local curtime = CurTime()
	if (self:GetNextPrimaryFire() > curtime and self:GetRemainingShots() > 0) then
		if (self:GetNextPshtrFire() < curtime) then
			self:EmitFireSound()
			self:TakeAmmo()
			self:ShootBullets(self.Primary.Damage, 1, self:GetCone())
			self:SetRemainingShots(self:GetRemainingShots()-1)
			self:SetNextPshtrFire(curtime + self.Primary.Delay)
		end
	end
	
	if self.BaseClass.Think then
		self.BaseClass.Think(self)
	end
end