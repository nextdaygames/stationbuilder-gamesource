local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Alarm = class("Alarm", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function Alarm:initialize()
	self.name = "Alarm"
end

function Alarm.category()
	return Enums.ComponentCategory.Furniture
end

function Alarm.displayName()
	return "Play Sound During Emergencies"
end

function Alarm.createFromParameters(params)
	return Alarm:new()
end

function Alarm.tags()
	return {Enums.ComponentTag.Deprecated}
end

function Alarm.requirements()
	return {
	}
end

function Alarm.defaults()
	return {
		
	}
end

function Alarm.mutuallyExclusive()
	return { "TopLevelTool" }
end

function Alarm.dependsOnComponents() 
	return {}
end

function Alarm.desc()
	return "Plays sounds during emergencies."
end

return Alarm