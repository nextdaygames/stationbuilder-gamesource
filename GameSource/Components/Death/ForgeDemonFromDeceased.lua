local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local ForgeDemonFromDeceased = class("ForgeDemonFromDeceased", ECS.Component)
local Split = Get("Utility/Split")

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function ForgeDemonFromDeceased:initialize() 
	self.name = "ForgeDemonFromDeceased"
end

function ForgeDemonFromDeceased.category()
	return Enums.ComponentCategory.Interaction
end

function ForgeDemonFromDeceased.displayName()
	return "Create Demons from Deceased People"
end

function ForgeDemonFromDeceased.createFromParameters(params)
	return ForgeDemonFromDeceased:new()
end

function ForgeDemonFromDeceased.requirements()
	return {
	}
end

function ForgeDemonFromDeceased.defaults()
	return {
	}
end

function ForgeDemonFromDeceased.options()
	return {
	}
end

function ForgeDemonFromDeceased.tags()
	return {Enums.ComponentTag.DeprecatedSafeToDelete, Enums.ComponentTag.Deprecated}
end

function ForgeDemonFromDeceased.dependsOnComponents()
	return {"TopLevelTool"}
end

function ForgeDemonFromDeceased.desc()
	return "When you use this gadget on a dead person a demon is created."
end

return ForgeDemonFromDeceased