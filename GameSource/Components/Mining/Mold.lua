local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Mold = class("Mold", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function Mold:initialize() 
	self.name = "Mold"
end

function Mold.category()
	return Enums.ComponentCategory.Mining
end

function Mold.displayName()
	return "Mold"
end

function Mold.createFromParameters(params)
	return Mold:new()
end

function Mold.requirements()
	return {
	}
end

function Mold.defaults()
	return {
	}
end

function Mold.tags()
	return {}
end

function Mold.dependsOnComponents() 
	return {}
end

function Mold.desc()
	return "Tags this item as Mold so interactions listening for Mold interactions can pick it up."
end

return Mold