local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local AirVent = class("AirVent", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function AirVent:initialize()
	self.name = "AirVent"
end

function AirVent.category()
	return Enums.ComponentCategory.Furniture
end

function AirVent.displayName()
	return "Provide Ventilation"
end

function AirVent.createFromParameters(params)
	return AirVent:new()
end

function AirVent.tags()
	return {Enums.ComponentTag.Deprecated}
end

function AirVent.requirements()
	return {
	}
end

function AirVent.defaults()
	return {
		
	}
end

function AirVent.mutuallyExclusive()
	return { "TopLevelTool" }
end

function AirVent.dependsOnComponents() 
	return {}
end

function AirVent.desc()
	return "Provide oxygen to room."
end

return AirVent