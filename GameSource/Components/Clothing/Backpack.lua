local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Backpack = class("Backpack", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})
function Backpack:initialize()
	self.name = "Backpack"
end

function Backpack.category()
	return Enums.ComponentCategory.Clothing
end

function Backpack.displayName()
	return "Place on Back"
end

function Backpack.createFromParameters(params)
	return Backpack:new()
end

function Backpack.tags()
	return {}
end

function Backpack.requirements()
	return {
	}
end

function Backpack.defaults()
	return {
		
	}
end

function Backpack.mutuallyExclusive()
	return { "ToolMaker", "Hat", "Mask", "Shirt", "Belt" }
end

function Backpack.dependsOnComponents() 
	return {}
end

function Backpack.desc()
	return "Enables this clothing to be worn on the back."
end

return Backpack