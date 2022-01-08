ENT.Type = "point"

function ENT:Initialize()
	self.Wave = self.Wave or -1
end

function ENT:Think()
end

function ENT:AcceptInput(name, activator, caller, args)
end

function ENT:KeyValue(key, value)
	key = string.lower(key)
	if string.sub(key, 1, 2) == "on" then
		self:AddOnOutput(key, value)
	elseif key == "wave" then
		self.Wave = tonumber(value) or -1
	end
end
