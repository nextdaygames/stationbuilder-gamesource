local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local EmergencyButton = class("EmergencyButton", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function EmergencyButton:initialize()
	self.name = "EmergencyButton"
end

function EmergencyButton.category()
	return Enums.ComponentCategory.Furniture
end

function EmergencyButton.displayName()
	return "Interact to Toggle Emergency"
end

function EmergencyButton.createFromParameters(params)
	return EmergencyButton:new()
end

function EmergencyButton.tags()
	return { Enums.ComponentTag.Deprecated}
end

function EmergencyButton.requirements()
	return {
	}
end

function EmergencyButton.defaults()
	return {
		
	}
end

function EmergencyButton.mutuallyExclusive()
	return { "TopLevelTool" }
end

function EmergencyButton.dependsOnComponents() 
	return {}
end

function EmergencyButton.desc()
	return "Makes alarms play sounds."
end

return EmergencyButton