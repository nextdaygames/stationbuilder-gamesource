local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local EmergencyActivator = class("EmergencyActivator", ECS.Component)
local Split = Get("Utility/Split")

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function EmergencyActivator:initialize() 
	self.name = "EmergencyActivator"
    self.isEmergency = false
    self.lastToggleTime = 0
    self.toggleCooldownSeconds = 30
end

function EmergencyActivator.category()
	return Enums.ComponentCategory.Emergency
end

function EmergencyActivator.displayName()
	return "Toggle to Declare Emergencies"
end

function EmergencyActivator.createFromParameters(params)
	return EmergencyActivator:new()
end

function EmergencyActivator.requirements()
	return {
	}
end

function EmergencyActivator.defaults()
	return {
	}
end

function EmergencyActivator.options()
	return {
	}
end

function EmergencyActivator.tags()
	return {}
end

function EmergencyActivator.mutuallyExclusive()
    return {"TopLevelTool"}
end

function EmergencyActivator.desc()
	return "Using an id on this will declare an emergency."
end

return EmergencyActivator