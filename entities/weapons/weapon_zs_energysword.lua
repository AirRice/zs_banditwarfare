AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "에너지 소드"
	SWEP.Description = "최신 기술의 집약체. 오른쪽 클릭으로 빠르게 앞으로 돌진할 수 있다."
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
SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.ShowWorldModel = false
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"
SWEP.UseHands = true
SWEP.HitDecal = "Manhackcut"

SWEP.MeleeDamage = 24
SWEP.MeleeRange = 90
SWEP.MeleeSize = 2

SWEP.WalkSpeed = SPEED_FASTEST+10

SWEP.Primary.Delay = 0.7
SWEP.Secondary.Delay = 8
SWEP.SwiftStriking = false
SWEP.NoFallDamage = true
SWEP.HitAnim = ACT_VM_MISSCENTER

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
		util.Decal("Manhackcut", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
end
function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	if self.SwingTime == 0 then
		self:MeleeSwing()
	else
		self:StartSwinging()
	end
end
function SWEP:Think()
	

	local curtime = CurTime()
	local owner = self.Owner

	if self.SwiftStriking then
			local dir = owner:GetAimVector()
			dir.z = math.Clamp(dir.z, -0.5, 0.9)
			dir:Normalize()

			owner:LagCompensation(true)

			local traces = owner:PenetratingMeleeTrace(24, 12, nil, owner:LocalToWorld(owner:OBBCenter()), dir)
			local damage = 5

			local hit = false
			for _, trace in ipairs(traces) do
				if not trace.Hit then continue end
				if trace.HitWorld then
					if trace.HitNormal.z < 0.8 then
						hit = true
						self.Weapon:SendWeaponAnim( ACT_VM_MISSCENTER )
					end
				else
					local ent = trace.Entity
					if ent and ent:IsValid() then
						hit = true
						self.Weapon:SendWeaponAnim( ACT_VM_MISSCENTER )
						local nearest = ent:NearestPoint(trace.StartPos)
						ent:ThrowFromPositionSetZ(self.Owner:GetPos(), damage * 40)
						self:ApplyMeleeDamage(ent, trace, damage)
					end
				end
			end

			if SERVER and hit then
				owner:EmitSound("npc/strider/strider_skewer1.wav")
			end

			owner:LagCompensation(false)

			if hit then
				self.SwiftStriking = false
			end
	end
	self.BaseClass.Think(self)
	self:NextThink(curtime)
	return true

end

function SWEP:ApplyMeleeDamage(ent, trace, damage)
	ent:EmitSound("npc/manhack/grind_flesh1.wav")
	if ent:IsPlayer() then
		ent:TakeSpecialDamage(damage, self.DamageType, self.Owner, self, trace.HitPos)
	else
		local dmgtype, owner, hitpos = self.DamageType, self.Owner, trace.HitPos
		timer.Simple(0, function() -- Avoid prediction errors.
			if ent:IsValid() then
				ent:TakeSpecialDamage(damage, dmgtype, owner, self, hitpos)
			end
		end)
	end
end

function SWEP:SecondaryAttack()
	if self:GetNextSecondaryFire() <= CurTime() and not self.Owner:IsHolding() then
	self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
	self:EmitSound("npc/env_headcrabcanister/incoming.wav", 80, math.Rand(90, 100))
	if SERVER then
		local fwd = 1200
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		local pushvel = self.Owner:GetEyeTrace().Normal * fwd
        self.Owner:SetGroundEntity(nil)
        self.Owner:SetLocalVelocity( self.Owner:GetVelocity() + pushvel)
		self.SwiftStriking = true
		self.Owner:SetGravity(0.01)
		local ownerplayer = self.Owner
		hook.Add( "DoPlayerDeath", "remove_energy_sword_float", function(ply, a, dmg)
			if ply == ownerplayer  then 
			ownerplayer:SetGravity(1)
			hook.Remove( "DoPlayerDeath", "remove_energy_sword_float" )
			end
		end )
		timer.Simple( 0.5, function() 
			if self.Owner and self.Owner:IsValid() and self.Owner:IsPlayer() and self.Owner:Alive() then 
				self.Owner:SetGravity(1)
				self.SwiftStriking = false
				--self.Owner:SetMoveType(MOVETYPE_NONE)
				self.Owner:SetLocalVelocity(Vector(0,0,0))
			end 
		end)
		
    end
	end
end
