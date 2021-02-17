AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_impalercbow_name"
	SWEP.TranslateDesc = "weapon_impalercbow_desc"

	SWEP.HUD3DBone = "ValveBiped.Crossbow_base"
	SWEP.HUD3DPos = Vector(1.5, 0.5, 11)
	SWEP.HUD3DScale = 0.025

	SWEP.ViewModelFOV = 60
	SWEP.ViewModelFlip = false

	SWEP.Slot = 3
	SWEP.SlotPos = 0
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "crossbow"

SWEP.ViewModel = "models/weapons/c_crossbow.mdl"
SWEP.WorldModel = "models/weapons/w_crossbow.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false
SWEP.Primary.Sound = Sound("Weapon_Crossbow.Single")
SWEP.Primary.Damage = 100
SWEP.Primary.NumShots = 1
SWEP.Primary.ClipSize = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "XBowBolt"
SWEP.Primary.Delay = 2.0
SWEP.Primary.DefaultClip = 4

SWEP.ConeMax = 0.009
SWEP.ConeMin = 0.0085
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
SWEP.Recoil = 1.25
SWEP.WalkSpeed = SPEED_SLOW

function SWEP:IsScoped()
	return self:GetIronsights() and self.fIronTime and self.fIronTime + 0.25 <= CurTime()
end

function SWEP:Think()
	if self:GetIronsights() and not self.Owner:KeyDown(IN_ATTACK2) then
		self:SetIronsights(false)
	end
	if self.BaseClass.Think then
		self.BaseClass.Think(self)
	end
end

SWEP.BulletCallback = GenericBulletCallback
function SWEP:ShootBullets(dmg, numbul, cone)	
	self:SetConeAndFire()
	self:DoRecoil()

	local owner = self.Owner
	--owner:MuzzleFlash()
	self:SendWeaponAnimation()
	owner:DoAttackEvent()
	if SERVER then
		local ent = ents.Create("projectile_arrow")
		if ent:IsValid() then
			ent:SetOwner(owner)
			ent:SetPos(owner:GetShootPos())
			ent:SetAngles(owner:GetAimVector():Angle())
			ent.Damage = self.Primary.Damage
			ent:Spawn()
			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then
				phys:Wake()
				phys:SetVelocityInstantaneous(owner:GetAimVector() * 2200)
			end
		end
	end
end

function SWEP:Reload()
	if self:GetNextReload() <= CurTime() and self:Clip1() == 0 and 0 < self.Owner:GetAmmoCount("XBowBolt") then
		self:EmitSound("Weapon_Crossbow.Reload")
		self:DefaultReload(ACT_VM_RELOAD)
		self.Owner:RestartGesture(ACT_HL2MP_GESTURE_RELOAD_CROSSBOW)
		self:SetNextReload(CurTime() + self:SequenceDuration())
		timer.Simple(0.8, function() 
			if (self:IsValid() and self.Owner:IsPlayer() and self.Owner:Alive()) then
				self:EmitSound("Weapon_Crossbow.BoltElectrify")
			end
		end)
	end
end

if CLIENT then
	SWEP.IronsightsMultiplier = 0.25
	local texScope = surface.GetTextureID("zombiesurvival/scope")
	function SWEP:DrawHUDBackground()
		if self:IsScoped() then
			local scrw, scrh = ScrW(), ScrH()
			local size = math.min(scrw, scrh)

			local hw = scrw * 0.5
			local hh = scrh * 0.5

			surface.SetDrawColor(255, 0, 0, 180)
			surface.DrawLine(0, hh, scrw, hh)
			surface.DrawLine(hw, 0, hw, scrh)
			for i=1, 10 do
				surface.DrawLine(hw, hh + i * 7, hw + (50 - i * 5), hh + i * 7)
			end

			surface.SetTexture(texScope)
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
end

util.PrecacheSound("Weapon_Crossbow.Reload")
util.PrecacheSound("Weapon_Crossbow.BoltElectrify")