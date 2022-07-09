local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local DeepFried = class("DeepFried", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})



function DeepFried:initialize()
	self.name = "DeepFried"
end

function DeepFried.category()
	return Enums.ComponentCategory.Food
end

function DeepFried.displayName()
	return "List this Item as Deep Fried"
end

function DeepFried.createFromParameters(params)
	return DeepFried:new()
end

function DeepFried.requirements()
	return {
	}
end

function DeepFried.defaults()
	return {
	}
end

function DeepFried.dependsOnComponents()
    return { "Food", "TopLevelTool" }
end

function DeepFried.tags()
	return {Enums.ComponentTag.DeprecatedSafeToDelete}
end

function DeepFried.desc()
	return "This item is deep fried and can be eaten."
end

return DeepFried