local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Door = class("Door", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})



function Door:initialize()
	self.name = "Door"
end

function Door.category()
	return Enums.ComponentCategory.Furniture
end

function Door.displayName()
	return "Make it a Doorway"
end

function Door.createFromParameters(params)
	return Door:new()
end

function Door.requirements()
	return {
	}
end

function Door.defaults()
	return {
	}
end

function Door.dependsOnComponents()
	return {}
end

function Door.mutuallyExclusive()
	return { "TopLevelTool" }
end

function Door.tags()
	return { }
end

function Door.desc()
	return "Interacting with this toggles its collision box."
end

return Door