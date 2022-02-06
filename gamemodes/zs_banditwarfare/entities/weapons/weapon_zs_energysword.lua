AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_energysword_name"
	SWEP.TranslateDesc = "weapon_energysword_desc"
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 70

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

SWEP.VElements = {
	["Blade"] = { type = "Model", model = "models/props_combine/combine_fence01b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-2.967, 1.404, -9.174), angle = Angle(-180, -90, 8.237), size = Vector(0.103, 0.305, 0.156), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["Handle"] = { type = "Model", model = "models/items/combine_rifle_cartridge01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.983, 1.299, -0.692), angle = Angle(0, -11.07, 0), size = Vector(0.913, 0.913, 0.913), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["Handle"] = { type = "Model", model = "models/items/combine_rifle_cartridge01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.285, 0.587, -0.67), angle = Angle(25.451, -7.106, -12.844), size = Vector(0.47, 0.828, 0.671), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["Blade"] = { type = "Model", model = "models/props_combine/combine_fence01b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.098, 1.679, -7.317), angle = Angle(-6.257, 90.987, 168.966), size = Vector(0.127, 0.127, 0.237), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
end


SWEP.Base = "weapon_zs_basemelee"

SWEP.HoldType = "melee2"
SWEP.DamageType = DMG_DISSOLVE
SWEP.FakeDamageType = DMG_SLASH
SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.ShowWorldModel = false
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"
SWEP.UseHands = true
SWEP.HitDecal = "Manhackcut"

SWEP.MeleeDamage = 50
SWEP.MeleeRange = 60
SWEP.MeleeSize = 2

SWEP.WalkSpeed = SPEED_NORMAL

SWEP.Primary.Delay = 0.5
SWEP.Secondary.Delay = 10
SWEP.HitAnim = ACT_VM_MISSCENTER
SWEP.ChargeSpeed = 1000

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 11, "ChargePerc")
	self:NetworkVar("Float", 12, "ChargeStart")
	if self.BaseClass.SetupDataTables then
		self.BaseClass.SetupDataTables(self)
	end
end

function SWEP:OnRemove()
	local owner = self:GetOwner()
	if SERVER and owner.m_EnergyChargeTrail and IsValid(owner.m_EnergyChargeTrail) then
		owner.m_EnergyChargeTrail:Remove()
		owner.m_EnergyChargeTrail = nil
	end
end

function SWEP:Holster()
	local owner = self:GetOwner()
	if SERVER and owner.m_EnergyChargeTrail and IsValid(owner.m_EnergyChargeTrail) then
		owner.m_EnergyChargeTrail:Remove()
		owner.m_EnergyChargeTrail = nil
	end
	return self.BaseClass.Holster(self)
end


function SWEP:PlayHitSound()
	self:EmitSound("ambient/energy/weld"..math.random(2)..".wav", 75, math.random(120,150))
end
function SWEP:PlaySwingSound()
	self:EmitSound("weapons/physcannon/energy_bounce"..math.random(2)..".wav", 75, math.random(80,110))
end
function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/flesh/flesh_bloody_break.wav", 80, math.Rand(90, 100))
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	local ent = tr.Entity
	local edata = EffectData()
		edata:SetEntity(hitent)
		edata:SetMagnitude(2)
		edata:SetScale(1)
		util.Effect("TeslaHitBoxes", edata) 
		edata:SetOrigin(tr.HitPos)
		edata:SetNormal(tr.HitNormal)
		edata:SetMagnitude(1)
		edata:SetScale(1)
		util.Effect("AR2Impact", edata)
		--util.Decal("Manhackcut", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
end

function SWEP:Think()

	local curtime = CurTime()
	local owner = self:GetOwner()
	
	if owner and owner:IsValid() and owner:IsPlayer() and owner:Alive() and (self:GetChargeStart() > 0) and (curtime - self:GetChargeStart() < 2.5) and not owner:GetBarricadeGhosting() then
		if self:GetChargePerc() < 100 then
			local toincrease = math.floor(math.max(self:GetChargePerc()/15,1))
			self:SetChargePerc(math.min(self:GetChargePerc()+toincrease,100))
		end

		local trace = owner:CompensatedMeleeTrace(24, 12)
		if trace.Hit then
			local ownervel = owner:GetVelocity()
			local ownerspeed = math.min(ownervel:Length(),self.ChargeSpeed)
			local hitent = trace.Entity
			local hitflesh = trace.MatType == MAT_FLESH or trace.MatType == MAT_BLOODYFLESH or trace.MatType == MAT_ANTLION or trace.MatType == MAT_ALIENFLESH
			if not (trace.HitWorld and (trace.HitNormal.z > 0.8)) then
				local ent = trace.Entity
				if ent and ent:IsValid() then
					local nearest = ent:NearestPoint(trace.StartPos)
					ent:ThrowFromPositionSetZ(nearest, ownerspeed^1.1 * 0.25)
					if SERVER then
						local phys = ent:GetPhysicsObject()
						if ent:GetMoveType() == MOVETYPE_VPHYSICS and phys:IsValid() and phys:IsMoveable() then
							ent:SetPhysicsAttacker(owner)
						end
					end
					self:OnMeleeHit(ent, hitflesh, trace)
					self:MeleeHitEntity(trace, ent, math.Clamp(ownerspeed/self.ChargeSpeed,0,1))
					if self.PostOnMeleeHit then self:PostOnMeleeHit(ent, hitflesh, trace) end
				end
				if self.HitAnim then
					self:SendWeaponAnim(self.HitAnim)
				end
				self.IdleAnimation = CurTime() + self:SequenceDuration()
				if hitflesh then
					self:PlayHitFleshSound()
					local damage = self.MeleeDamage
					if SERVER then
						util.Blood(trace.HitPos, math.Rand(damage * 0.25, damage * 0.6), (trace.HitPos - owner:GetShootPos()):GetNormalized(), math.min(400, math.Rand(damage * 6, damage * 12)), true)
					end
					if not self.NoHitSoundFlesh then
						self:PlayHitSound()
					end
				else
					self:PlayHitSound()
				end
				local bouncevel = ownervel:GetNormalized() * -1
				bouncevel.z = math.max(ownervel:GetNormalized().z,0.25)
				
				owner:SetGroundEntity(nil)
				owner:SetVelocity(ownervel*-1 + bouncevel*math.min(ownerspeed*0.5,300))
				owner:EmitSound("npc/strider/strider_skewer1.wav")
				owner:DoAttackEvent()
				self:SendWeaponAnim(self.HitAnim)
				self:SetChargeStart(0)
				self.m_LastViewAngles = nil
			end
		end
	else
		self:SetChargePerc(0)
		self:SetChargeStart(0)
		if SERVER and owner.m_EnergyChargeTrail and IsValid(owner.m_EnergyChargeTrail) then
			owner.m_EnergyChargeTrail:Remove()
			owner.m_EnergyChargeTrail = nil
		end
		self.m_LastViewAngles = nil
	end
	self.BaseClass.Think(self)
	self:NextThink(curtime)
	return true
end

function SWEP:SecondaryAttack()
	local curtime = CurTime()
	if self:GetOwner():IsHolding() or self:GetOwner():GetBarricadeGhosting() then 
		self:SetNextSecondaryFire(curtime + 0.5)
		return false 
	end
	if self:GetNextSecondaryFire() <= curtime then
		self:SetNextSecondaryFire(curtime + self.Secondary.Delay)
		self:EmitSound("npc/env_headcrabcanister/incoming.wav", 75, math.Rand(90, 110))
		self:EmitSound("physics/nearmiss/whoosh_large1.wav",75,math.Rand(140, 180),0.7,CHAN_AUTO + 21)
		local owner = self:GetOwner()
		self:SetChargeStart(curtime)
		self.m_LastViewAngles = owner:EyeAngles()
		if SERVER then
			owner:DoAttackEvent()
			if not (owner.m_EnergyChargeTrail and IsValid(owner.m_EnergyChargeTrail)) then
				local attch = owner:LookupAttachment("hips")
				owner.m_EnergyChargeTrail = util.SpriteTrail(owner, attch, COLOR_CYAN , true, 15, 1, 1, 0.025, "trails/tube" )
			end
			self:SendWeaponAnim( ACT_VM_MISSCENTER )
		end
	end
end

function SWEP:Deploy()
	if self.BaseClass.Deploy then
		self.BaseClass.Deploy(self)
	end
	self:SetChargePerc(0)
	self:SetChargeStart(0)
	return true
end

function SWEP:Move(mv)
	local perc = self:GetChargePerc()
	if self:GetChargeStart() == 0 then
		return
	elseif perc > 0 then
		local chargeratio = math.Clamp(perc/100,0,1)
		local speed = self.WalkSpeed + (self.ChargeSpeed-self.WalkSpeed)*chargeratio
		mv:SetForwardSpeed(10000)
		mv:SetSideSpeed(mv:GetSideSpeed() * 0.05)
		mv:SetMaxSpeed(speed)
		mv:SetMaxClientSpeed(speed)	
	end
end

if not CLIENT then return end

function SWEP:CreateMove(cmd)
	if self.m_LastViewAngles and (self:GetChargeStart() != 0) then
		local perc = self:GetChargePerc()
		local difflimit = 15+512*(1-math.Clamp(perc/100,0,1))
		local maxdiff = FrameTime() * difflimit
		local mindiff = -maxdiff
		local originalangles = self.m_LastViewAngles
		local viewangles = cmd:GetViewAngles()

		local diff = math.AngleDifference(viewangles.yaw, originalangles.yaw)
		if diff > maxdiff or diff < mindiff then
			viewangles.yaw = math.NormalizeAngle(originalangles.yaw + math.Clamp(diff, mindiff, maxdiff))
		end

		self.m_LastViewAngles = viewangles

		cmd:SetViewAngles(viewangles)
	end
end

local texGradDown = surface.GetTextureID("VGUI/gradient_down")
function SWEP:DrawHUD()
	local scrW = ScrW()
	local scrH = ScrH()
	local width = 200
	local height = 30
	local x, y = ScrW() - width - 32, ScrH() - height - 72
	local ratio = math.max(self:GetNextSecondaryFire()-CurTime(),0) / self.Secondary.Delay
	--local ratio = math.Clamp(self:GetChargePerc()/100,0,1)
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