local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Shirt = class("Shirt", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function Shirt:initialize()
	self.name = "Shirt"
end

function Shirt.category()
	return Enums.ComponentCategory.Clothing
end

function Shirt.displayName()
	return "Place on Chest"
end

function Shirt.createFromParameters(params)
	return Shirt:new()
end

function Shirt.tags()
	return {}
end

function Shirt.requirements()
	return {
	}
end

function Shirt.defaults()
	return {
		
	}
end

function Shirt.mutuallyExclusive()
	return { "ToolMaker", "Hat", "Mask", "Backpack", "Belt" }
end

function Shirt.dependsOnComponents() 
	return {}
end

function Shirt.desc()
	return "Enables this clothing to be worn on the chest."
end

return Shirt