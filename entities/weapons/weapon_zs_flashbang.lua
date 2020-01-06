AddCSLuaFile()

SWEP.Base = "weapon_zs_grenade"
SWEP.Primary.Ammo = "rpg_round"
SWEP.ViewModel = "models/weapons/cstrike/c_eq_flashbang.mdl"
SWEP.WorldModel = "models/weapons/w_eq_flashbang.mdl"
if CLIENT then
	SWEP.PrintName = "섬광탄"
	SWEP.Description = "폭발 시 거리 256 내의 플레이어(아군 포함)는 눈이 잠시 멀며 25% 확률로 2초간 넉다운된다."
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
		local ent = ents.Create("projectile_zsflashbang")
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