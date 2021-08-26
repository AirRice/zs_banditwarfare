include("shared.lua")
include("cl_animations.lua")

ENT.ColorModulation = Color(0.15, 0.8, 1)
function ENT:Initialize()
	self:DrawShadow(false)
	if self.BaseClass.Initialize then
		self.BaseClass.Initialize(self)
	end
end

function ENT:Think()
	local class = self:GetWeaponType()
	if class ~= self.LastWeaponType then
		self.LastWeaponType = class

		self:RemoveModels()

		local weptab = weapons.GetStored(class)
		if weptab then
			local showmdl = weptab.ShowWorldModel or not self:LookupBone("ValveBiped.Bip01_R_Hand") and not weptab.NoDroppedWorldModel
			self.ShowBaseModel = weptab.ShowWorldModel == nil and true or showmdl

			if weptab.WElements then
				self.WElements = table.FullCopy(weptab.WElements)
				self:CreateModels(self.WElements)
			end
			self.PropWeapon = true
		end
	end
end

function ENT:OnRemove()
	self:RemoveModels()
end
