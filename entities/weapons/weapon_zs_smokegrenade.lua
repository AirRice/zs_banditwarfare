AddCSLuaFile()

SWEP.Base = "weapon_zs_grenade"
SWEP.Primary.Ammo = "ar2altfire"
SWEP.ViewModel = "models/weapons/cstrike/c_eq_smokegrenade.mdl"
SWEP.WorldModel = "models/weapons/w_eq_smokegrenade.mdl"
if CLIENT then
	SWEP.PrintName = "연막탄"
	SWEP.Description = "시야를 가리는 연막을 형성한다."
end
function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	local owner = self.Owner
	self:SendWeaponAnim(ACT_VM_THROW)
	owner:DoAttackEvent()

	self:TakePrimaryAmmo(1)
	self.NextDeploy = CurTime() + 1

	if SERVER then
		local ent = ents.Create("projectile_smokegrenade")
		if ent:IsValid() then
			ent:SetPos(owner:GetShootPos())
			ent:SetOwner(owner)
			ent:Spawn()
			ent.GrenadeDamage = self.GrenadeDamage
			ent.GrenadeRadius = self.GrenadeRadius
			ent:EmitSound("WeaponFrag.Throw")
			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then
				phys:Wake()
				phys:AddAngleVelocity(VectorRand() * 5)
				phys:SetVelocityInstantaneous(self.Owner:GetAimVector() * 1000)
			end
		end
	end
end