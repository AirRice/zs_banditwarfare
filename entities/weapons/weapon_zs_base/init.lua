AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("animations.lua")

include("shared.lua")

function SWEP:Think()
	local curTime = CurTime();
	if self:GetReloadFinish() > 0 then
		if CurTime() >= self:GetReloadFinish() then
			self:FinishReload()
		end

		return
	elseif self.IdleAnimation and self.IdleAnimation <= CurTime() then
		self.IdleAnimation = nil
		self:SendWeaponAnim(self.IdleActivity)
	end
	
	if self:GetIronsights() and not self.Owner:KeyDown(IN_ATTACK2) then
		self:SetIronsights(false)
	end
	if not self.Owner:KeyDown(IN_ATTACK) and (self.LastAttemptedShot + (self.AutoReloadDelay and self.AutoReloadDelay or 1)  <= curTime) and self.Primary.Ammo == "autocharging" then
		if self:GetNextAutoReload() <= curTime and self:Clip1() < self.Primary.ClipSize then
			self:SetClip1(self:Clip1() + 1)
			self:SetNextAutoReload(curTime+0.02)
			self.Owner:EmitSound("buttons/button16.wav")
		end
	end
	
end
