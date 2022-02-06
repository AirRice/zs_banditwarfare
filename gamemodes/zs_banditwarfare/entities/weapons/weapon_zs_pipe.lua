AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_leadpipe_name"
	SWEP.TranslateDesc = "weapon_leadpipe_desc"
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.2, 1, -2.274), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.599, 1, -6), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.DamageType = DMG_CLUB

SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/props_canal/mattpipe.mdl"
SWEP.UseHands = true

SWEP.MeleeDamage = 60
SWEP.MeleeRange = 50
SWEP.MeleeSize = 1.15

SWEP.Primary.Delay = 0.95
SWEP.MeleeKnockBack = 0
SWEP.DefaultMeleeKnockBack = 0
SWEP.UseMelee1 = true

SWEP.HitGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
SWEP.MissGesture = SWEP.HitGesture

SWEP.SwingRotation = Angle(20, -20, -20)
SWEP.SwingTime = 0.4
SWEP.SwingHoldType = "grenade"

SWEP.LastCharge = 0
SWEP.ChargeDelay = 2
function SWEP:SetupDataTables()
	self:NetworkVar("Float", 5, "ChargePerc")
	self:NetworkVar("Float", 6, "ChargeStart")
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
	self:SetChargeStart(0)
	self:SetIsCharging(false)
	return true
end

function SWEP:SecondaryAttack()
	if self:GetNextSecondaryFire() <= CurTime() and not self:GetOwner():IsHolding() and not self:GetIsCharging() then
		self:SetNextSecondaryFire(CurTime() + self.ChargeDelay)
		if not self:GetIsCharging() then
			self:SetIsCharging(true)
			self:EmitSound("items/ammocrate_open.wav", 75, math.random(75, 85),0.5)
			self:SetChargeStart(CurTime())
		end
	end
end

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(55, 65))
end

function SWEP:PlayHitSound()
	self:EmitSound("physics/metal/metal_canister_impact_hard"..math.random(3)..".wav", 75, math.random(115, 125))
end

function SWEP:Move(mv)
	if self:GetIsCharging() and self:GetChargePerc() >= 1 and mv:KeyDown(IN_ATTACK2) and not self:GetOwner():GetBarricadeGhosting() then
		mv:SetMaxSpeed(self.WalkSpeed*0.25)
		mv:SetMaxClientSpeed(self.WalkSpeed*0.25)	
		mv:SetSideSpeed(mv:GetSideSpeed() * 0.25)
	end
end

function SWEP:Think()
	local owner = self:GetOwner()
	if self:GetIsCharging() then
		if owner:KeyReleased(IN_ATTACK2) or owner:GetBarricadeGhosting() then
			if not owner:GetBarricadeGhosting() then
				self:MeleeSwing()
				self:EmitSound("physics/nearmiss/whoosh_large1.wav", 75, math.Rand(230, 260),0.3,CHAN_AUTO+21)
			end
			self:SetChargePerc(0)
			self:SetChargeStart(0)
			self:SetIsCharging(false)
			self:SetNextPrimaryFire(CurTime() + self.ChargeDelay/2)
			self:SetNextSecondaryFire(CurTime() + self.ChargeDelay/2)
			self.MeleeKnockBack = self.DefaultMeleeKnockBack
		elseif self:GetChargePerc() < 1 then
			if self.LastCharge <= CurTime() then
				self:SetChargePerc(math.Clamp(self:GetChargePerc() + 0.05, 0, 1))
				self.LastCharge = CurTime() + 0.08
			end	
		end
	end
	self.BaseClass.Think(self)
end

function SWEP:PostHitUtil(owner, hitent, dmginfo, tr, vel)
	if self:GetChargePerc() > 0 then	
		dmginfo:ScaleDamage(1+1*self:GetChargePerc())
		self.MeleeKnockBack = 350*self:GetChargePerc()
	end
	self.BaseClass.PostHitUtil(self, owner, hitent, dmginfo, tr, vel)
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if SERVER and hitent:IsValid() and hitent:IsPlayer() and CurTime() >= (hitent._NextLeadPipeEffect or 0) then
		hitent._NextLeadPipeEffect = CurTime() + 3
		local x = math.Rand(0.75, 1)
		x = x * (math.random(2) == 2 and 1 or -1)

		local ang = Angle(1 - x, x, 0) * 38
		hitent:ViewPunch(ang)

		local eyeangles = hitent:EyeAngles()
		eyeangles:RotateAroundAxis(eyeangles:Up(), ang.yaw)
		eyeangles:RotateAroundAxis(eyeangles:Right(), ang.pitch)
		eyeangles.pitch = math.Clamp(ang.pitch, -89, 89)
		eyeangles.roll = 0
		hitent:SetEyeAngles(eyeangles)
	end
end

function SWEP:CanPrimaryAttack()
	if self.BaseClass.CanPrimaryAttack then
		if not self.BaseClass.CanPrimaryAttack(self) then
			return false
		end
	end
	if self:GetNextSecondaryFire() > CurTime() or self:GetIsCharging() then
		return false
	else
		return true
	end
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
	local ghostlerp = 0
	function SWEP:GetViewModelPosition(pos, ang)
		if self:IsSwinging() then
			local rot = self.SwingRotation
			local offset = self.SwingOffset

			ang = Angle(ang.pitch, ang.yaw, ang.roll) -- Copy

			local swingend = self:GetSwingEnd()
			local delta = self.SwingTime - math.Clamp(swingend - CurTime(), 0, self.SwingTime)
			local power = CosineInterpolation(0, 1, delta / self.SwingTime)

			if power >= 0.9 then
				power = (1 - power) ^ 0.4 * 2
			end

			pos = pos + offset.x * power * ang:Right() + offset.y * power * ang:Forward() + offset.z * power * ang:Up()

			ang:RotateAroundAxis(ang:Right(), rot.pitch * power)
			ang:RotateAroundAxis(ang:Up(), rot.yaw * power)
			ang:RotateAroundAxis(ang:Forward(), rot.roll * power)
		elseif self:GetIsCharging() or self:GetChargePerc() > 0 then
			local rot = self.SwingRotation
			local offset = self.SwingOffset

			ang = Angle(ang.pitch, ang.yaw, ang.roll) -- Copy

			local delta = math.Clamp(CurTime() - self:GetChargeStart(), 0, 1)
			local power = CosineInterpolation(0, 1, delta)

			pos = pos + offset.x * power * ang:Right() + offset.y * power * ang:Forward() + offset.z * power * ang:Up()

			ang:RotateAroundAxis(ang:Right(), rot.pitch * power)
			ang:RotateAroundAxis(ang:Up(), rot.yaw * power)
			ang:RotateAroundAxis(ang:Forward(), rot.roll * power)
		end

		if self:GetOwner():GetBarricadeGhosting() then
			ghostlerp = math.min(1, ghostlerp + FrameTime() * 4)
		elseif ghostlerp > 0 then
			ghostlerp = math.max(0, ghostlerp - FrameTime() * 5)
		end

		if ghostlerp > 0 then
			pos = pos + 3.5 * ghostlerp * ang:Up()
			ang:RotateAroundAxis(ang:Right(), -30 * ghostlerp)
		end

		return pos, ang
	end
end