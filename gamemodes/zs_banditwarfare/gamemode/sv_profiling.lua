-- This system creates nodes which can be used to spawn dynamic objectives.

GM.ProfilerNodes = {}
GM.ProfilerFolderPreMade = "profiler_premade"

hook.Add("Initialize", "ZSProfiler", function()
	file.CreateDir(GAMEMODE.ProfilerFolderPreMade)
end)

local mapname = string.lower(game.GetMap())
if file.Exists(GM.ProfilerFolderPreMade.."/"..mapname..".txt", "DATA") then
	GM.ProfilerNodes = Deserialize(file.Read(GM.ProfilerFolderPreMade.."/"..mapname..".txt", "DATA"))
end

function GM:SaveProfilerPreMade(tab)
	file.Write(self:GetProfilerFilePreMade(), Serialize(tab))
end

function GM:DeleteProfilerPreMade()
	file.Delete(self:GetProfilerFilePreMade())
	self.ProfilerNodes = {}
end

function GM:GetProfilerFilePreMade()
	return self.ProfilerFolderPreMade.."/"..string.lower(game.GetMap())..".txt"
end

function GM:MapHasEnoughObjectives(mapname)
	if file.Exists(self:GetProfilerFilePreMade(),"DATA") then
		local nodes = Deserialize(file.Read(self:GetProfilerFilePreMade(), "DATA"))
		if #self.ProfilerNodes >= self.MaxTransmitters then
			return true
		else
			return false
		end
	else
		return false
	end
end