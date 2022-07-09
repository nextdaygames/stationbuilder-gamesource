local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Ore = class("Ore", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function Ore:initialize() 
	self.name = "Ore"
end

function Ore.category()
	return Enums.ComponentCategory.Mining
end

function Ore.displayName()
	return "Ore"
end

function Ore.createFromParameters(params)
	return Ore:new()
end

function Ore.requirements()
	return {
	}
end

function Ore.defaults()
	return {
	}
end

function Ore.tags()
	return {}
end

function Ore.dependsOnComponents() 
	return {}
end

function Ore.desc()
	return "Tags this item as ore so interactions listening for ore interactions can pick it up."
end

return Ore