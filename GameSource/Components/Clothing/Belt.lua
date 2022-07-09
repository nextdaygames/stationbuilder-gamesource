local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Belt = class("Belt", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function Belt:initialize()
	self.name = "Belt"
end

function Belt.category()
	return Enums.ComponentCategory.Clothing
end

function Belt.displayName()
	return "Place on Belt"
end

function Belt.createFromParameters(params)
	return Belt:new()
end

function Belt.tags()
	return {}
end

function Belt.requirements()
	return {
	}
end

function Belt.defaults()
	return {
		
	}
end

function Belt.mutuallyExclusive()
	return { "ToolMaker", "Hat", "Mask", "Shirt", "Backpack" }
end

function Belt.dependsOnComponents() 
	return {}
end

function Belt.desc()
	return "Enables this clothing to be worn on the belt."
end

return Belt