ENT.Type = "anim"

ENT.m_NoNailUnfreeze = true
ENT.NoNails = true

AccessorFuncDT(ENT, "LastCaptureTeam", "Int", 0)
AccessorFuncDT(ENT, "LastCalcedNearby", "Float", 0)
AccessorFuncDT(ENT, "SamplesSinceReset", "Int", 1)
AccessorFuncDT(ENT, "LastInsertTime", "Float", 1)


function ENT:SetIsActive(b)
	if b then
		self:EmitSound("ambient/levels/citadel/zapper_warmup4.wav",200,120,1,CHAN_AUTO + 20)
	else
		self:EmitSound("ambient/levels/citadel/weapon_disintegrate1.wav",100,80,1,CHAN_AUTO + 20)
	end
	local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos())
		effectdata:SetNormal(self:GetUp())
		effectdata:SetMagnitude(4)
		effectdata:SetScale(1.33)
	util.Effect("cball_explode", effectdata)
	self:SetSamplesSinceReset(0)
	self:SetLastInsertTime(CurTime())
	self:SetDTBool(0, b)
end

function ENT:GetIsActive()
	return self:GetDTBool(0)
end