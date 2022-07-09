local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Restrained = class("Restrained", ECS.Component)

function Restrained:initialize(startTime, duration) 
    if startTime == nil then
		error("startTime not initialized")
	end
	self.startTime = startTime

    if duration == nil then
		error("duration not initialized")
	end
	self.duration = duration

	self.name = "Restrained"
end

function Restrained.desc()
	return "Slows a characters movements for a time."
end

return Restrained 