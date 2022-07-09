local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Mask = class("Mask", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function Mask:initialize()
	self.name = "Mask"
end

function Mask.category()
	return Enums.ComponentCategory.Clothing
end

function Mask.displayName()
	return "Place on Face"
end

function Mask.createFromParameters(params)
	return Mask:new()
end

function Mask.tags()
	return {Enums.ComponentTag.ClothingDefault}
end

function Mask.requirements()
	return {
	}
end

function Mask.defaults()
	return {
		
	}
end

function Mask.mutuallyExclusive()
	return { "ToolMaker", "Hat", "Backpack", "Shirt", "Belt"   }
end

function Mask.dependsOnComponents() 
	return {}
end

function Mask.desc()
	return "Enables this clothing to be worn on the face."
end

return Mask