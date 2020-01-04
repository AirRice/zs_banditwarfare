AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "리벳건"
	SWEP.Description = "못을 높은 속도로 발사한다. 이 무기를 이용하면 장거리에서 프롭에 못을 박을 수 있다."
	SWEP.Slot = 1
	SWEP.SlotPos = 0
	
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60
	
	SWEP.HUD3DBone = "ValveBiped.square"
	SWEP.HUD3DPos = Vector(1.1, 0.25, -2)
	SWEP.HUD3DScale = 0.015
	SWEP.VElements = {
		["slidecover3"] = { type = "Model", model = "models/props_junk/metalbucket02a.mdl", bone = "ValveBiped.hammer", rel = "back", pos = Vector(0, -0.4, 7), angle = Angle(0, 0, -90), size = Vector(0.06, 0.3, 0.143), color = Color(255, 170, 0, 255), surpresslightning = false, material = "models/props_c17/canister_propane01a", skin = 0, bodygroup = {} },
		["back"] = { type = "Model", model = "models/props_c17/canister_propane01a.mdl", bone = "ValveBiped.hammer", rel = "element_name", pos = Vector(0, -8, -4.666), angle = Angle(0, 0, 90), size = Vector(0.083, 0.083, 0.052), color = Color(255, 170, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["element_name"] = { type = "Model", model = "models/props_pipes/pipe03_lcurve02_short.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7.131, 1.399, 1.042), angle = Angle(0, 90, 0), size = Vector(0.045, 0.074, 0.083), color = Color(255, 170, 0, 255), surpresslightning = false, material = "models/props_c17/consolebox01a", skin = 0, bodygroup = {} },
		["nozzle"] = { type = "Model", model = "models/props_junk/ibeam01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "slidecover3", pos = Vector(0, 3.5, 0), angle = Angle(0, 90, 0), size = Vector(0.07, 0.07, 0.07), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/chairchrome01", skin = 0, bodygroup = {} }
	}
end
SWEP.WElements = {
	["slidecover3"] = { type = "Model", model = "models/props_junk/metalbucket02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.63, 2.119, -3.625), angle = Angle(0, 90, 5.002), size = Vector(0.093, 0.218, 0.123), color = Color(255, 170, 0, 255), surpresslightning = false, material = "models/props_c17/canister_propane01a", skin = 0, bodygroup = {} },
	["nozzle"] = { type = "Model", model = "models/props_junk/ibeam01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10.477, 2.201, -4.301), angle = Angle(-4.928, 0, 85.244), size = Vector(0.03, 0.075, 0.075), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/chairchrome01", skin = 0, bodygroup = {} },
	["element_name"] = { type = "Model", model = "models/props_pipes/pipe03_lcurve02_short.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.354, 1.514, 0.699), angle = Angle(-5.206, 90, 0), size = Vector(0.045, 0.074, 0.083), color = Color(255, 170, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["back"] = { type = "Model", model = "models/props_c17/canister_propane01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.106, 1.95, -2.876), angle = Angle(-95.669, 0, 0), size = Vector(0.104, 0.104, 0.064), color = Color(255, 170, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
sound.Add(
{
	name = "Weapon_Nailgun.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	soundlevel = 100,
	pitch = {90,110},
	sound = "ambient/machines/catapult_throw.wav"
})
SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "pistol"

SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false
SWEP.Primary.ClipSize = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "GaussEnergy"
SWEP.Primary.Sound = Sound("Weapon_Nailgun.Single")
SWEP.ReloadSound = Sound("weapons/357/357_reload3.wav")
SWEP.Primary.Damage = 30
SWEP.Primary.Delay = 1     
SWEP.Primary.DefaultClip = 10
SWEP.Recoil = 1.8
SWEP.Primary.KnockbackScale = 3
SWEP.ConeMax = 0.02
SWEP.ConeMin = 0.005
SWEP.MovingConeOffset = 0.03
SWEP.IronSightsPos = Vector(-5.95, 3, 2.75)
SWEP.IronSightsAng = Vector(-0.15, -1, 2)

function SWEP:CanPrimaryAttack()
	if self.Owner:GetBarricadeGhosting() then return false end
	if self.Owner:IsCarrying() then
		self.Owner.status_human_holding:RemoveNextFrame()
	end
	if self:Clip1() < self.RequiredClip then
		self:EmitSound("Weapon_Pistol.Empty")
		self:SetNextPrimaryFire(CurTime() + math.max(0.25, self.Primary.Delay))
		return false
	end

	return self:GetNextPrimaryFire() <= CurTime()
end

function SWEP.BulletCallback(attacker, tr, dmginfo)
	local trent = tr.Entity
	local effectdata = EffectData()
	effectdata:SetOrigin(tr.HitPos)
	effectdata:SetNormal(tr.HitNormal)
	util.Effect("MetalSpark", effectdata)

	local trent = tr.Entity

	if not trent:IsValid()
	or not util.IsValidPhysicsObject(trent, tr.PhysicsBone)
	or tr.Fraction == 0
	or trent:GetMoveType() ~= MOVETYPE_VPHYSICS and not trent:GetNailFrozen()
	or trent.NoNails
	or trent:IsNailed() and (#trent.Nails >= 8 or trent:GetPropsInContraption() >= GAMEMODE.MaxPropsInBarricade)
	or trent:GetMaxHealth() == 1 and trent:Health() == 0 and not trent.TotalHealth
	or not trent:IsNailed() and not trent:GetPhysicsObject():IsMoveable() 
	or (trent:IsNailed() and trent:GetNailedPropOwner():IsPlayer() and trent:GetNailedPropOwner():Team() ~= attacker:Team())
	then GenericBulletCallback(attacker, tr, dmginfo) return end

	if not gamemode.Call("CanPlaceNail", attacker, tr) then return end

	local count = 0
	for _, nail in pairs(trent:GetNails()) do
		if nail:GetDeployer() == attacker then
			count = count + 1
			if count >= 3 then
				return
			end
		end
	end

	if tr.MatType == MAT_GRATE or tr.MatType == MAT_CLIP or tr.MatType == MAT_GLASS then return end

	if trent:IsValid() then
		for _, nail in pairs(ents.FindByClass("prop_nail")) do
			if trent:GetBarricadeHealth() <= 0 and trent:GetMaxBarricadeHealth() > 0 then
			return end
		end
	end

	local aimvec = attacker:GetAimVector()

	local trtwo = util.TraceLine({start = tr.HitPos, endpos = tr.HitPos + aimvec * 24, filter = {attacker, trent}, mask = MASK_SOLID})

	if trtwo.HitSky then return end

	local ent = trtwo.Entity
	if trtwo.HitWorld
	or ent:IsValid() and util.IsValidPhysicsObject(ent, trtwo.PhysicsBone) and (ent:GetMoveType() == MOVETYPE_VPHYSICS or ent:GetNailFrozen()) and not ent.NoNails and not (not ent:IsNailed() and not ent:GetPhysicsObject():IsMoveable()) and not (ent:GetMaxHealth() == 1 and ent:Health() == 0 and not ent.TotalHealth) then
		if trtwo.MatType == MAT_GRATE or trtwo.MatType == MAT_CLIP or trtwo.MatType == MAT_GLASS then return end

		if ent and ent:IsValid() and (ent.NoNails or ent:IsNailed() and (#ent.Nails >= 8 or ent:GetPropsInContraption() >= GAMEMODE.MaxPropsInBarricade)) then return end

		if ent:GetBarricadeHealth() <= 0 and ent:GetMaxBarricadeHealth() > 0 then return end

		if GAMEMODE:EntityWouldBlockSpawn(ent) then return end

		local cons = constraint.Weld(trent, ent, tr.PhysicsBone, trtwo.PhysicsBone, 0, true)
		if cons ~= nil then
			for _, oldcons in pairs(constraint.FindConstraints(trent, "Weld")) do
				if oldcons.Ent1 == ent or oldcons.Ent2 == ent then
					cons = oldcons.Constraint
					break
				end
			end
		end

		if not cons then return end

		trent:EmitSound("weapons/melee/crowbar/crowbar_hit-"..math.random(4)..".ogg")
		trent:SetNWEntity("LastNailOwner", attacker)
		local nail = ents.Create("prop_nail")
		if nail:IsValid() then
			nail:SetActualOffset(tr.HitPos, trent)
			nail:SetPos(tr.HitPos - aimvec * 8)
			nail:SetAngles(aimvec:Angle())
			nail:AttachTo(trent, ent, tr.PhysicsBone, trtwo.PhysicsBone)
			nail:Spawn()
			nail:SetDeployer(attacker)
			
			cons:DeleteOnRemove(nail)

			gamemode.Call("OnNailCreated", trent, ent, nail)
		end
	end	
	
end
