AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "메디킷"
	SWEP.Description = "응급 의약품이 에너지의 형태로 들어 있는 킷.\n팀원의 체력을 책임진다.\n주 공격: 팀원 치료.\n보조 공격: 자신 치료.\n팀원을 치료할 시 딜레이가 50% 감소하고 포인트를 습득한다."
	SWEP.Slot = 4
	SWEP.SlotPos = 0

	SWEP.ViewModelFOV = 50
	SWEP.ViewModelFlip = false

	SWEP.BobScale = 2
	SWEP.SwayScale = 1.5
end

SWEP.Base = "weapon_zs_base"

SWEP.WorldModel = "models/weapons/w_medkit.mdl"
SWEP.ViewModel = "models/weapons/c_medkit.mdl"
SWEP.UseHands = true

SWEP.Primary.Delay = 3
SWEP.Primary.Heal = 20
SWEP.Primary.Automatic = true

SWEP.Primary.ClipSize = 40
SWEP.Primary.DefaultClip = 160
SWEP.Primary.Ammo = "Battery"

SWEP.Secondary.Delay = 6
SWEP.Secondary.Heal = 20

SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Ammo = "dummy"

SWEP.WalkSpeed = SPEED_NORMAL

SWEP.NoMagazine = true

SWEP.HoldType = "slam"

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	self:SetDeploySpeed(1.1)
end

function SWEP:Think()
	if self.IdleAnimation and self.IdleAnimation <= CurTime() then
		self.IdleAnimation = nil
		self:SendWeaponAnim(ACT_VM_IDLE)
	end
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	local owner = self.Owner

	owner:LagCompensation(true)
	local ent = owner:MeleeTrace(32, 2).Entity
	owner:LagCompensation(false)

	if ent and ent:IsValid() and ent:IsPlayer() and ent:Team() == owner:Team() and ent:Alive() and gamemode.Call("PlayerCanBeHealed", ent) then
		local health, maxhealth = ent:Health(), ent:GetMaxHealth()
		local multiplier = owner.HumanHealMultiplier or 1
		local toheal = math.min(self:GetPrimaryAmmoCount(), math.ceil(math.min(self.Primary.Heal * multiplier, maxhealth - health)))
		local totake = math.ceil(toheal / multiplier)
		if toheal > 0 then
			self:SetNextCharge(CurTime() + self.Primary.Delay * math.min(1, toheal / self.Primary.Heal))
			owner.NextMedKitUse = self:GetNextCharge()

			self:TakeCombinedPrimaryAmmo(totake)

			ent:SetHealth(health + toheal)
			self:EmitSound("items/medshot4.wav")

			self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

			owner:DoAttackEvent()
			self.IdleAnimation = CurTime() + self:SequenceDuration()

			gamemode.Call("PlayerHealedTeamMember", owner, ent, toheal, self)
		end
	end
end

function SWEP:SecondaryAttack()
	local owner = self.Owner
	if not self:CanPrimaryAttack() or not gamemode.Call("PlayerCanBeHealed", owner) then return end

	local health, maxhealth = owner:Health(), owner:GetMaxHealth()
	local multiplier = owner.HumanHealMultiplier or 1
	local toheal = math.min(self:GetPrimaryAmmoCount(), math.ceil(math.min(self.Secondary.Heal * multiplier, maxhealth - health)))
	local totake = math.ceil(toheal / multiplier)
	if toheal > 0 then
		self:SetNextCharge(CurTime() + self.Secondary.Delay * math.min(1, toheal / self.Secondary.Heal))
		owner.NextMedKitUse = self:GetNextCharge()

		self:TakeCombinedPrimaryAmmo(totake)

		owner:SetHealth(health + toheal)
		self:EmitSound("items/smallmedkit1.wav")

		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

		owner:DoAttackEvent()
		self.IdleAnimation = CurTime() + self:SequenceDuration()
	end
end

function SWEP:Deploy()
	gamemode.Call("WeaponDeployed", self.Owner, self)

	self.IdleAnimation = CurTime() + self:SequenceDuration()

	if CLIENT then
		hook.Add("PostPlayerDraw", "PostPlayerDrawMedical", GAMEMODE.PostPlayerDrawMedical)
		GAMEMODE.MedicalAura = true
	end

	return true
end

function SWEP:Holster()
	if CLIENT then
		hook.Remove("PostPlayerDraw", "PostPlayerDrawMedical")
		GAMEMODE.MedicalAura = false
	end

	return true
end

function SWEP:OnRemove()
	if CLIENT and self.Owner == LocalPlayer() then
		hook.Remove("PostPlayerDraw", "PostPlayerDrawMedical")
		GAMEMODE.MedicalAura = false
	end
end

function SWEP:Reload()
end

function SWEP:SetNextCharge(tim)
	self:SetDTFloat(0, tim)
end

function SWEP:GetNextCharge()
	return self:GetDTFloat(0)
end

function SWEP:CanPrimaryAttack()
	local owner = self.Owner
	if owner:IsHolding() or owner:GetBarricadeGhosting() then return false end

	if self:GetPrimaryAmmoCount() <= 0 then
		self:EmitSound("items/medshotno1.wav")

		self:SetNextCharge(CurTime() + 0.75)
		owner.NextMedKitUse = self:GetNextCharge()
		return false
	end

	return self:GetNextCharge() <= CurTime() and (owner.NextMedKitUse or 0) <= CurTime()
end

if not CLIENT then return end

function SWEP:DrawWeaponSelection(...)
	return self:BaseDrawWeaponSelection(...)
end

local texGradDown = surface.GetTextureID("VGUI/gradient_down")
function SWEP:DrawHUD()
	local screenscale = BetterScreenScale()
	local wid, hei = 256, 16
	local x, y = ScrW() - wid - 32, ScrH() - hei - 72
	local texty = y - 4 - draw.GetFontHeight("ZSHUDFontSmall")

	local timeleft = self:GetNextCharge() - CurTime()
	if 0 < timeleft then
		surface.SetDrawColor(5, 5, 5, 180)
		surface.DrawRect(x, y, wid, hei)

		surface.SetDrawColor(255, 0, 0, 180)
		surface.SetTexture(texGradDown)
		surface.DrawTexturedRect(x, y, math.min(1, timeleft / math.max(self.Primary.Delay, self.Secondary.Delay)) * wid, hei)

		surface.SetDrawColor(255, 0, 0, 180)
		surface.DrawOutlinedRect(x, y, wid, hei)
	end

	draw.SimpleText("메디킷 에너지", "ZSHUDFontSmall", x, texty, COLOR_GREEN, TEXT_ALIGN_LEFT)

	local charges = self:GetPrimaryAmmoCount()
	if charges > 0 then
		draw.SimpleText(charges, "ZSHUDFontSmall", x + wid, texty, COLOR_GREEN, TEXT_ALIGN_RIGHT)
	else
		draw.SimpleText(charges, "ZSHUDFontSmall", x + wid, texty, COLOR_DARKRED, TEXT_ALIGN_RIGHT)
	end

	if GetConVarNumber("crosshair") == 1 then
		self:DrawCrosshairDot()
	end
end
