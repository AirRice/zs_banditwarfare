AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_meatcleaver_name"
	SWEP.TranslateDesc = "weapon_meatcleaver_desc"
	SWEP.ViewModelFOV = 55
	SWEP.ViewModelFlip = false

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/props_lab/cleaver.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 1, -1), angle = Angle(90, 0, 0), size = Vector(0.8, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/props_lab/cleaver.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 1, -3.182), angle = Angle(90, 0, 0), size = Vector(0.8, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.DamageType = DMG_SLASH

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true
SWEP.NoDroppedWorldModel = true
--[[SWEP.BoxPhysicsMax = Vector(8, 1, 4)
SWEP.BoxPhysicsMin = Vector(-8, -1, -4)]]

SWEP.MeleeDamage = 14
SWEP.MeleeRange = 48
SWEP.MeleeSize = 0.875
SWEP.Primary.Delay = 0.35

SWEP.WalkSpeed = SPEED_FAST

SWEP.UseMelee1 = true

SWEP.HitGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
SWEP.MissGesture = SWEP.HitGesture

SWEP.HitDecal = "Manhackcut"
SWEP.HitAnim = ACT_VM_MISSCENTER

SWEP.MovementBonusResetDelay = 4
SWEP.MovementBonusPerHit = 10
SWEP.MovementBonusMaxHits = 20
function SWEP:SetupDataTables()
	self:NetworkVar("Float", 11, "LastEnemyHit")
	self:NetworkVar("Int", 11, "HitAmount")
	if self.BaseClass.SetupDataTables then
		self.BaseClass.SetupDataTables(self)
	end
end

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/knife/knife_slash"..math.random(2)..".wav", 72, math.Rand(85, 95))
end

function SWEP:PlayHitSound()
	self:EmitSound("weapons/knife/knife_hitwall1.wav", 72, math.Rand(75, 85))
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/flesh/flesh_squishy_impact_hard"..math.random(4)..".wav")
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav")
end

function SWEP:PlayerHitUtil(owner, damage, hitent, dmginfo)
	hitent:MeleeViewPunch(damage*0.1)
	if self:GetHitAmount() < 20 then
		self:SetHitAmount(self:GetHitAmount()+1)
		self:SetLastEnemyHit(CurTime())
		owner:ResetSpeed()
	end
end

function SWEP:GetWalkSpeed()
	return self.WalkSpeed + math.Clamp(self:GetHitAmount(),0,self.MovementBonusMaxHits)*self.MovementBonusPerHit
end

function SWEP:Think()
	local curtime = CurTime()
	local owner = self:GetOwner()
	if self:GetLastEnemyHit() + self.MovementBonusResetDelay <= curtime and self:GetHitAmount() > 0 then
		self:SetHitAmount(0)
		owner:ResetSpeed()
	end
	self.BaseClass.Think(self)
	self:NextThink(curtime)
	return true
end

if not CLIENT then return end

local texGradDown = surface.GetTextureID("VGUI/gradient_down")
function SWEP:DrawHUD()
	local scrW = ScrW()
	local scrH = ScrH()
	local width = 200
	local height = 30
	local x, y = ScrW() - width - 32, ScrH() - height - 72
	local ratio = math.Clamp((CurTime()-self:GetLastEnemyHit())/self.MovementBonusResetDelay,0,1) 
	if ratio > 0 and self:GetHitAmount() > 0 then
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