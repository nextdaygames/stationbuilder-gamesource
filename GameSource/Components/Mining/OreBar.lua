local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local OreBar = class("OreBar", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function OreBar:initialize() 
	self.name = "OreBar"
end

function OreBar.category()
	return Enums.ComponentCategory.Mining
end

function OreBar.displayName()
	return "OreBar"
end

function OreBar.createFromParameters(params)
	return OreBar:new()
end

function OreBar.requirements()
	return {
	}
end

function OreBar.defaults()
	return {
	}
end

function OreBar.tags()
	return {}
end

function OreBar.dependsOnComponents() 
	return {}
end

function OreBar.desc()
	return "Tags this item as OreBar so interactions listening for OreBar interactions can pick it up."
end

return OreBar