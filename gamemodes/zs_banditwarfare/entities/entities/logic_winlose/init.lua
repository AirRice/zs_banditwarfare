ENT.Type = "point"

function ENT:Initialize()
end

function ENT:Think()
end

function ENT:AcceptInput(name, activator, caller, args)
	name = string.lower(name)
	if string.sub(name, 1, 2) == "on" then
		self:FireOutput(name, activator, caller, args)
		return true
	elseif name == "hwin" then
		gamemode.Call("EndRound", TEAM_HUMAN)
		return true
	elseif name == "bwin" then
		gamemode.Call("EndRound", TEAM_BANDIT)
		return true
	elseif name == "lose" then
		gamemode.Call("EndRound", nil)
		return true
	elseif name == "setendslomo" then
		self:SetKeyValue("endslomo", args)
		return true
	elseif name == "setendcamera" then
		self:SetKeyValue("endcamera", args)
		return true
	elseif name == "setendcamerapos" then
		self:SetKeyValue("endcamerapos", args)
		return true
	elseif name == "sethwinmusic" then
		self:SetKeyValue("hwinmusic", args)
		return true
	elseif name == "setbwinmusic" then
		self:SetKeyValue("bwinmusic", args)
		return true
	end
end

function ENT:KeyValue(key, value)
	key = string.lower(key)
	if string.sub(key, 1, 2) == "on" then
		self:AddOnOutput(key, value)
	elseif key == "endslomo" then
		GAMEMODE.OverrideEndSlomo = value == "1"
	elseif key == "endcamera" then
		SetGlobalBool("endcamera", value == "1")
	elseif key == "endcamerapos" then
		SetGlobalVector("endcamerapos", Vector(value))
	elseif key == "hwinmusic" then
		if value == "default" then
			SetGlobalString("winmusic", nil)
		else
			SetGlobalString("winmusic", value)
		end
	elseif key == "bwinmusic" then
		if value == "default" then
			SetGlobalString("losemusic", nil)
		else
			SetGlobalString("losemusic", value)
		end
	end
end
