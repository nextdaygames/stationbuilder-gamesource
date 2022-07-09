local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))


local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Clothing = class("Clothing", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function Clothing:initialize()
	self.name = "Clothing"
end

function Clothing.category()
	return Enums.ComponentCategory.Clothing
end

function Clothing.displayName()
	return "Use as Clothing"
end

function Clothing.createFromParameters(params)
	return Clothing:new()
end

function Clothing.requirements()
	return {
	}
end

function Clothing.defaults()
	return {
		
	}
end

function Clothing.tags()
	return {Enums.ComponentTag.DeprecatedSafeToDelete, Enums.ComponentTag.Deprecated}
end

function Clothing.mutuallyExclusive()
	return { "TopLevelTool" }
end

function Clothing.dependsOnComponents() 
	return {}
end

function Clothing.desc()
	return "Enables this item to be worn as clothing."
end

return Clothing