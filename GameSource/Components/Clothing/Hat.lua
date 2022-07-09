local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Hat = class("Hat", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function Hat:initialize()
	self.name = "Hat"
end

function Hat.category()
	return Enums.ComponentCategory.Clothing
end

function Hat.displayName()
	return "Place on Head"
end

function Hat.createFromParameters(params)
	return Hat:new()
end

function Hat.tags()
	return {}
end

function Hat.requirements()
	return {
	}
end

function Hat.defaults()
	return {
		
	}
end

function Hat.mutuallyExclusive()
	return { "ToolMaker", "Mask", "Backpack", "Shirt", "Belt" }
end

function Hat.dependsOnComponents() 
	return {}
end

function Hat.desc()
	return "Enables this clothing to be worn on the head."
end

return Hat