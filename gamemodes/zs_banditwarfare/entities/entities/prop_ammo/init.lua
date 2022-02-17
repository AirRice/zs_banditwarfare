AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.CleanupPriority = 2
ENT.LastUse = 0
function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)

	self:SetUseType(SIMPLE_USE)
	self:SetTrigger(true)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetMaterial("material")
		phys:EnableMotion(true)
		phys:Wake()
	end

	self:ItemCreated()
end

function ENT:SetAmmoType(ammotype)
	self:SetModel(GAMEMODE.AmmoModels[string.lower(ammotype)] or "models/Items/BoxMRounds.mdl")
	self.m_AmmoType = ammotype
end

function ENT:GetAmmoType()
	return self.m_AmmoType or "pistol"
end

function ENT:SetAmmo(ammo)
	self.m_Ammo = tonumber(ammo) or self:GetAmmo()
end

function ENT:GetAmmo()
	return self.m_Ammo or 0
end

function ENT:Use(activator, caller)
	if self.IgnoreUse or (self.LastUse + 0.1 >= CurTime()) then return end
	self.LastUse = CurTime()
	self:GiveToActivator(activator, caller, true)
end

function ENT:GiveToActivator(activator, caller, used)
	if activator:IsPlayer() and activator:Alive() and not activator:KeyDown(GAMEMODE.UtilityKey) and (activator:Team() == TEAM_HUMAN or activator:Team() == TEAM_BANDIT) and not self.Removing then
		local hasweapon = false
		for _, wep in pairs(activator:GetWeapons()) do
			if wep.Primary and wep.Primary.Ammo and string.lower(wep.Primary.Ammo) == string.lower(self:GetAmmoType())
			or wep.Secondary and wep.Secondary.Ammo and string.lower(wep.Secondary.Ammo) == string.lower(self:GetAmmoType()) then
				hasweapon = true
				break
			end
		end

		if not hasweapon and not self.Forced then
			if used then
				activator:CenterNotify(COLOR_RED, translate.ClientGet(activator, "nothing_for_this_ammo"))
			end
			return
		end

		activator:GiveAmmo(self:GetAmmo(), self:GetAmmoType())
		if not self.NeverRemove then 
			self.Removing = true
			self:RemoveNextFrame() 
		end
	end
end

function ENT:StartTouch(ent)
	if ent:IsPlayer() and ent:Alive() then
		self:GiveToActivator(ent,ent)
	end
end