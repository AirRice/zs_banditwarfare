AddCSLuaFile()

if CLIENT then
	SWEP.TranslateName = "weapon_empgun_name"
	SWEP.TranslateDesc = "weapon_empgun_desc"
	SWEP.Slot = 4
	SWEP.SlotPos = 0
	
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60
	
	SWEP.HUD3DBone = "v_weapon.Deagle_Slide"
	SWEP.HUD3DPos = Vector(-3, 0, 1)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.015
	SWEP.VElements = {
		["sidebattery"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "barrel", pos = Vector(-0.798, -1.43, 0), angle = Angle(0, 0, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel+"] = { type = "Model", model = "models/props_c17/light_industrialbell02_on.mdl", bone = "v_weapon.Deagle_Parent", rel = "barrel", pos = Vector(0, 0.986, 1.388), angle = Angle(0, 0, 0), size = Vector(0.094, 0.094, 0.094), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel+++"] = { type = "Model", model = "models/props_c17/light_industrialbell02_on.mdl", bone = "v_weapon.Deagle_Parent", rel = "barrel", pos = Vector(0, -1.047, 11.095), angle = Angle(-180, 0, 0), size = Vector(0.079, 0.079, 0.140), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["clipbattery"] = { type = "Model", model = "models/items/battery.mdl", bone = "v_weapon.Deagle_Clip", rel = "", pos = Vector(0, -1.183, 0.379), angle = Angle(81.369, 90, 0), size = Vector(0.5, 0.218, 0.57), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "v_weapon.Deagle_Parent", rel = "", pos = Vector(0, -4.835, -7.567), angle = Angle(0, 0, 0), size = Vector(0.116, 0.189, 0.284), color = Color(20, 20, 40, 255), surpresslightning = false, material = "metal6", skin = 0, bodygroup = {} },
		["sidebattery+++"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "barrel", pos = Vector(0.797, 1.279, 0), angle = Angle(0, 0, 0), size = Vector(0.462, 0.722, 0.975), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel++"] = { type = "Model", model = "models/props_c17/light_industrialbell02_on.mdl", bone = "v_weapon.Deagle_Parent", rel = "barrel", pos = Vector(0, -1.047, 1.388), angle = Angle(0, 0, 0), size = Vector(0.094, 0.094, 0.094), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel++++"] = { type = "Model", model = "models/props_c17/light_industrialbell02_on.mdl", bone = "v_weapon.Deagle_Parent", rel = "barrel", pos = Vector(0, 1.149, 11.095), angle = Angle(-180, 0, 0), size = Vector(0.079, 0.079, 0.140), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery++"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "barrel", pos = Vector(0.33, -1.422, 0), angle = Angle(0, 180, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["sidebattery+"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "barrel", pos = Vector(-0.798, 1.164, 0), angle = Angle(0, -180, 0), size = Vector(0.462, 0.722, 0.975), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
end
SWEP.WElements = {
	["sidebattery"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barrel", pos = Vector(-0.798, -1.43, 0), angle = Angle(0, 0, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["barrel+"] = { type = "Model", model = "models/props_c17/light_industrialbell02_on.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barrel", pos = Vector(0, 0.986, 1.388), angle = Angle(0, 0, 0), size = Vector(0.094, 0.094, 0.094), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["barrel+++"] = { type = "Model", model = "models/props_c17/light_industrialbell02_on.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barrel", pos = Vector(0, -1.047, 11.095), angle = Angle(-180, 0, 0), size = Vector(0.079, 0.079, 0.079), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["sidebattery+"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barrel", pos = Vector(-0.798, 1.164, 0), angle = Angle(0, -180, 0), size = Vector(0.462, 0.722, 0.975), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["barrel"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.514, 1.072, -5.025), angle = Angle(0, -96.04, -89.905), size = Vector(0.143, 0.203, 0.279), color = Color(20, 20, 40, 255), surpresslightning = false, material = "metal6", skin = 0, bodygroup = {} },
	["sidebattery+++"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barrel", pos = Vector(0.797, 1.279, 0), angle = Angle(0, 0, 0), size = Vector(0.462, 0.722, 0.975), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["sidebattery++"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barrel", pos = Vector(0.33, -1.422, 0), angle = Angle(0, 180, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["barrel++++"] = { type = "Model", model = "models/props_c17/light_industrialbell02_on.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barrel", pos = Vector(0, 1.149, 11.095), angle = Angle(-180, 0, 0), size = Vector(0.079, 0.079, 0.079), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["barrel++"] = { type = "Model", model = "models/props_c17/light_industrialbell02_on.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "barrel", pos = Vector(0, -1.047, 1.388), angle = Angle(0, 0, 0), size = Vector(0.094, 0.094, 0.094), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

sound.Add(
{
	name = "Weapon_EMPgun.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	soundlevel = 100,
	pitch = 90,
	sound = "weapons/stunstick/alyx_stunner"..math.random(2)..".wav"
})
SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "revolver"

SWEP.ViewModel = "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel = "models/weapons/w_pist_deagle.mdl"
SWEP.UseHands = true
SWEP.Primary.ClipSize = 3
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "gravity"
SWEP.Primary.DefaultClip = 3

SWEP.Primary.Sound = Sound("Weapon_EMPgun.Single")
SWEP.Primary.Damage = 1
SWEP.Primary.NumShots = 0
SWEP.Primary.Delay = 0.7
SWEP.Recoil = 1.66
SWEP.WalkSpeed = SPEED_SLOWEST
SWEP.ConeMax = 0
SWEP.ConeMin = 0
SWEP.MovingConeOffset = 0.1
GAMEMODE:SetupAimDefaults(SWEP,SWEP.Primary)
SWEP.TracerName = "ToolTracer"
SWEP.IronSightsPos = Vector(-6.5, 0, -0.65)
SWEP.IronSightsAng = Vector(-0.15, -1, 2)

function SWEP:Reload()
	if self.Owner:IsHolding() then return end

	if self:GetIronsights() then
		self:SetIronsights(false)
	end
	
	if self:GetNextReload() <= CurTime() and self:DefaultReload(ACT_VM_RELOAD) then
		self.Owner:GetViewModel():SetPlaybackRate(0.5)
		self.IdleAnimation = CurTime() + self:SequenceDuration()*2+0.3
		self:SetNextPrimaryFire(self.IdleAnimation)
		self:SetNextReload(self.IdleAnimation+0.3)
		self.Owner:DoReloadEvent()
		if self.ReloadSound then
			self:EmitSound(self.ReloadSound)
		end
	end
	
end

function BulletCallback(attacker, tr, dmginfo)
	local ent = tr.Entity
	local effectdata = EffectData()
		effectdata:SetOrigin(tr.HitPos)
		effectdata:SetNormal(tr.Normal)
		effectdata:SetMagnitude(4)
		effectdata:SetScale(1.33)
	util.Effect("cball_explode", effectdata)
	util.ScreenShake( tr.HitPos, 5, 5, 0.5, 256 )
	local ent = tr.Entity
	if IsValid(ent) then
		if not ent:IsPlayer() then
			if ent:GetClass() == "prop_obj_sigil" then
				if (ent:GetSigilTeam() == TEAM_BANDIT or ent:GetSigilTeam() == TEAM_HUMAN) and attacker:IsPlayer() and ent:GetSigilTeam() ~= attacker:Team() and SERVER then
					ent:DoStopComms()
				end
			elseif ent:GetClass() == "prop_ffemitterfield" then
				if ent:GetOwner() and ent:GetOwner():GetClass() == "prop_ffemitter" and not ent:GetOwner():IsSameTeam(attacker) then
					local effectdata = EffectData()
						effectdata:SetOrigin(tr.HitPos)
					util.Effect("Explosion", effectdata, true, true)
					ent:GetOwner():Remove()
				end
			elseif ent:GetClass() == "prop_drone" or ent:GetClass() == "prop_manhack" and not ent:IsSameTeam(attacker) and SERVER then
				ent:Destroy()
			elseif ent:IsNailed() and not ent:IsSameTeam(attacker) then
				if not ent:IsValid() or not ent:IsNailed() or ent:IsSameTeam(attacker) then return end
				if not ent or not gamemode.Call("CanRemoveNail", attacker, ent) then return end
				local nailowner = ent:GetOwner()
				if nailowner:IsValid() and nailowner:IsPlayer() and attacker:IsPlayer() and nailowner ~= attacker and nailowner:Team() == attacker:Team() then return end
				for _, e in pairs(ents.FindByClass("prop_nail")) do
				if not e.m_PryingOut and e:GetParent() == ent and SERVER then
					ent:RemoveNail(e, nil, attacker)
					e.m_PryingOut = true -- Prevents infinite loops	
					end
				end
				if not ent:IsNailed() then
					ent:SetLocalVelocity( ent:GetVelocity() + tr.Normal*500)
				end
			elseif ent.IsBarricadeObject and not ent:IsSameTeam(attacker) and SERVER then
				ent:TakeDamage(ent:GetObjectHealth(),attacker,dmginfo:GetInflictor())
				--ent:TakeSpecialDamage(self.Primary.Damage*2.5, DMG_DISSOLVE, owner, self)
			end
		else
            if SERVER then
			local fwd = 500
			local up = 100
			local pushvel = tr.Normal * fwd
            pushvel.z = math.max(pushvel.z, up)
			--ent:KnockDown(3)
            ent:SetGroundEntity(nil)
            ent:SetLocalVelocity( ent:GetVelocity() + pushvel)
            end
		end
	end
	GenericBulletCallback(attacker, tr, dmginfo)
end

SWEP.BulletCallback = BulletCallback
