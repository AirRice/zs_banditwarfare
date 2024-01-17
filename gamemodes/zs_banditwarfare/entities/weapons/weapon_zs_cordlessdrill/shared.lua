AddCSLuaFile("shared.lua")

SWEP.WElements = {
	["trigger"] = { type = "Model", model = "models/props_c17/furniturebathtub001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, -1.785, 0.925), angle = Angle(90, 90, 0), size = Vector(0.039, 0.014, 0.043), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/furnituremetal002a", skin = 0, bodygroup = {} },
	["barrelbase++"] = { type = "Model", model = "models/xqm/afterburner1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barrelbase", pos = Vector(0, 0, 7.203), angle = Angle(0, 0, 0), size = Vector(0.152, 0.152, 0.123), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 3, bodygroup = {} },
	["tip"] = { type = "Model", model = "models/props_phx/rocket1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barrelbase", pos = Vector(0, 0, 6.25), angle = Angle(0, 0, 0), size = Vector(0.009, 0.009, 0.009), color = Color(60, 60, 60, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
	["barrelbase+"] = { type = "Model", model = "models/props_phx/gears/bevel36.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barrelbase", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.072, 0.072, 0.179), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base"] = { type = "Model", model = "models/props_phx/empty_barrel.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.651, 1.993, -3.306), angle = Angle(0, -91.585, 6.778), size = Vector(0.092, 0.107, 0.112), color = Color(255, 255, 0, 255), surpresslightning = false, material = "models/props_c17/furnituremetal001a", skin = 0, bodygroup = {} },
	["handle"] = { type = "Model", model = "models/props_combine/breenpod.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, -0.403, 5.735), angle = Angle(-4.969, 90, 180), size = Vector(0.086, 0.101, 0.086), color = Color(85, 85, 85, 255), surpresslightning = false, material = "models/props_junk/shoe001a", skin = 0, bodygroup = {} },
	["base+"] = { type = "Model", model = "models/props_c17/cashregister01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, -0.524, 5.301), angle = Angle(0, 180, 180), size = Vector(0.107, 0.237, 0.114), color = Color(255, 255, 0, 255), surpresslightning = false, material = "models/props_c17/furnituremetal001a", skin = 0, bodygroup = {} },
	["barrelbase"] = { type = "Model", model = "models/props_c17/canister_propane01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 2.994, -0.156), angle = Angle(180, 0, -77.461), size = Vector(0.108, 0.108, 0.108), color = Color(255, 255, 0, 255), surpresslightning = false, material = "models/props_c17/furnituremetal001a", skin = 0, bodygroup = {} }
}

sound.Add( {
	name = "Loop_Drill_Motor",
	channel = CHAN_AUTO+21,
	volume = 1,
	level = 75,
	pitch = 250,
	volume = 0.6,
	sound = "vehicles/tank_turret_loop1.wav"
} )

sound.Add( {
	name = "Loop_Drill_Motor2",
	channel = CHAN_AUTO+22,
	volume = 1,
	level = 75,
	pitch = 450,
	volume = 0.4,
	sound = "ambient/machines/machine_whine1.wav"
} )

sound.Add( {
	name = "Loop_Drill_Impact",
	channel = CHAN_AUTO+23,
	volume = 1,
	level = 75,
	pitch = 450,
	volume = 0.5,
	sound = "vehicles/digger_grinder_loop1.wav"
} )

SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.Base = "weapon_zs_basemelee"

SWEP.HoldType = "normal"
SWEP.SpecialHoldType = "revolver"

SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.UseHands = true

SWEP.MeleeDamage = 1
SWEP.HealStrength = 0.5
SWEP.MeleeRange = 40
SWEP.MeleeSize = 0.5
SWEP.MeleeKnockBack = 32

SWEP.Primary.Delay = 0.08
SWEP.WalkSpeed = SPEED_FAST
SWEP.FakeDamageType = DMG_CLUB

SWEP.DrillingPos = Vector(0, 5.5, 0.35)
SWEP.DrillingAng = Angle(4.2, 7.5, -4)

SWEP.LastStartDrilling = 0
SWEP.LastStopDrilling = 0
SWEP.RemainingDrillHeat = 0
SWEP.DrillDelay = 0.3
SWEP.LastMeleeAttack = 0
SWEP.LastAttackPos = nil
SWEP.RepairsRegain = 5
SWEP.OverHeatTime = 5
SWEP.LastDrillOverHeat = 0
function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 5, "Drilling")
	self:NetworkVar("Float", 5, "DrillHeat")
	self:NetworkVar("Bool", 6, "Overheated")
	if self.BaseClass.SetupDataTables then
		self.BaseClass.SetupDataTables(self)
	end
end

function SWEP:Initialize()
	self:SetDrillHeat(0)
	return self.BaseClass.Initialize(self)
end

function SWEP:GetHeatRatio()
	return math.Clamp(self:GetDrillHeat()/self.OverHeatTime, 0, 1)
end

function SWEP:HandleHeating()
	local ft = FrameTime()
	if self:GetDrillHeat() >= self.OverHeatTime then
		self:SetOverheated(true)
		self:EmitSound("ambient/machines/spindown.wav", 75, math.Rand(160,210), 0.5, CHAN_AUTO+20)
	elseif self:GetDrillHeat() <= 0 then
		self:SetOverheated(false)
	end
	if self:GetDrilling() then
		self:SetDrillHeat(math.min(self:GetDrillHeat() + ft * (0.5+self:GetHeatRatio()*2.5), self.OverHeatTime))
	else
		self:SetDrillHeat(math.max(self:GetDrillHeat() - ft * (self:GetOverheated() and 0.75 or 2), 0))
	end
end

function SWEP:CanPrimaryAttack()
	if self:GetOverheated() then return false end
	return self.BaseClass.CanPrimaryAttack(self)
end

function SWEP:Think()
	if not self:GetOwner():KeyDown(IN_ATTACK) or not self:GetOwner():Alive() or self:GetOwner():Health() <= 0 or not self:CanPrimaryAttack() then
		if self:GetDrilling() then
			self:SetDrilling( false )
			self.LastStopDrilling = CurTime()
		end
		self:GetOwner():ResetSpeed()
		self:StopSound( "Loop_Drill_Motor" )
		self:StopSound( "Loop_Drill_Motor2" )
		self:StopSound( "Loop_Drill_Impact" )
	else
		self:EmitSound( "Loop_Drill_Motor" )
		self:EmitSound( "Loop_Drill_Motor2" )
		if not self:GetDrilling() then
			self:SetDrilling(true)
			self.LastStartDrilling = CurTime()
			self:GetOwner():ResetSpeed()
			self:EmitSound("npc/metropolice/gear5.wav", 80, math.Rand(60, 70),0.5,CHAN_AUTO+20)
		else
			if CurTime() >= self.LastMeleeAttack + self.Primary.Delay and (CurTime() >= self.LastStartDrilling + self.DrillDelay) then
				self.LastMeleeAttack = CurTime()
				self:MeleeAttack()
				self:GetOwner():DoAttackEvent()
			end
		end
	end
	self:HandleHeating()
	if self.BaseClass.Think then
		self.BaseClass.Think(self)
	end
end

function SWEP:GetWalkSpeedModifier()
	if self:GetDrilling() then
		return -self.WalkSpeed*0.75
	end
	return 0
end

function SWEP:PrimaryAttack()
end

local drillsounds = {
	"npc/dog/dog_servo1.wav",
	"npc/dog/dog_servo2.wav",
	"npc/dog/dog_servo3.wav",
	"npc/dog/dog_servo8.wav",
	"npc/dog/dog_servo10.wav"
}

function SWEP:PlayDrillSound()
	self:EmitSound(drillsounds[math.random( #drillsounds )], 80, math.Rand(60, 70),0.7,CHAN_AUTO+23)
end

function SWEP:MeleeAttack()
	local owner = self:GetOwner()
	local tr = owner:CompensatedMeleeTrace(self.MeleeRange, self.MeleeSize)

	if tr.Hit then
		self:EmitSound( "Loop_Drill_Impact" )
		if not IsFirstTimePredicted() then return end
		if math.random(10) == 1 then
			self:PlayDrillSound()
		end
		local damage = self.MeleeDamage
		local hitent = tr.Entity
		local hitflesh = tr.MatType == MAT_FLESH or tr.MatType == MAT_BLOODYFLESH or tr.MatType == MAT_ANTLION or tr.MatType == MAT_ALIENFLESH

		if !self.LastAttackPos or isvector(self.LastAttackPos) and self.LastAttackPos:DistToSqr(tr.HitPos) >= 16 then
			self.LastAttackPos = tr.HitPos
			if hitflesh then
				util.Decal("Impact.Flesh", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
			else
				local effectdata = EffectData()
				effectdata:SetOrigin(tr.HitPos)
				effectdata:SetStart(tr.StartPos)
				effectdata:SetNormal(tr.HitNormal)
				util.Effect("RagdollImpact", effectdata)
				if not tr.HitSky then
					effectdata:SetSurfaceProp(tr.SurfaceProps)
					effectdata:SetDamageType(self.FakeDamageType and self.FakeDamageType or self.DamageType)
					effectdata:SetHitBox(tr.HitBox)
					effectdata:SetEntity(hitent)
					util.Effect("Impact", effectdata)
				end
			end
		end

		local effectdata = EffectData()
			effectdata:SetOrigin(tr.HitPos)
			effectdata:SetNormal(tr.HitNormal)
			effectdata:SetMagnitude(1)
			effectdata:SetScale(1)
		util.Effect("sparks", effectdata)

		local owner = self:GetOwner()
		local damage = self.MeleeDamage
		local dmginfo = DamageInfo()
		dmginfo:SetDamagePosition(tr.HitPos)
		dmginfo:SetAttacker(owner)
		dmginfo:SetInflictor(self)
		dmginfo:SetDamageType(self.DamageType)
		dmginfo:SetDamage(damage)
		dmginfo:SetDamageForce(owner:GetAimVector()*0.01)

		if SERVER and self:OnRepair(hitent, tr) then
			return
		else
			local vel
			if hitent:IsPlayer() then
				if SERVER then
					if tr.HitGroup == HITGROUP_HEAD then
						hitent:SetWasHitInHead()
					end
				end
				vel = hitent:GetVelocity()
			end
			hitent:DispatchTraceAttack(dmginfo, tr, owner:GetAimVector())
			if vel then
				hitent:SetLocalVelocity(vel)
			end
		end
	else
		self:StopSound( "Loop_Drill_Impact" )
	end
end

function SWEP:TranslateActivity( act )

	if self:GetDrilling() and self.ActivityTranslateSpecial[act] then
		return self.ActivityTranslateSpecial[act] or -1
	end

	return self.BaseClass.TranslateActivity(self, act)
end
