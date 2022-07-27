local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Furnace = class("Furnace", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function Furnace:initialize() 
	self.name = "Furnace"
end

function Furnace.category()
	return Enums.ComponentCategory.Mining
end

function Furnace.displayName()
	return "Furnace"
end

function Furnace.createFromParameters(params)
	return Furnace:new()
end

function Furnace.requirements()
	return {
	}
end

function Furnace.defaults()
	return {
	}
end

function Furnace.tags()
	return {}
end

function Furnace.mutuallyExclusive() 
	return {"TopLevelTool"}
end

function Furnace.desc()
	return "Turns ore into ore bar."
end

return Furnace