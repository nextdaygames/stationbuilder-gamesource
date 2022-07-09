local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local DeepFrier = class("DeepFrier", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function DeepFrier:initialize()
	self.name = "DeepFrier"
end

function DeepFrier.category()
	return Enums.ComponentCategory.Food
end

function DeepFrier.displayName()
	return "Deep Fries on Interact"
end

function DeepFrier.createFromParameters(params)
	return DeepFrier:new()
end

function DeepFrier.requirements()
	return {
	}
end

function DeepFrier.defaults()
	return {
	}
end

function DeepFrier.dependsOnComponents()
	return {}
end

function DeepFrier.mutuallyExclusive()
	return { "VendingMachine" }
end

function DeepFrier.tags()
	return { Enums.ComponentTag.DeprecatedSafeToDelete }
end

function DeepFrier.desc()
	return "Interact with this to deep fry it."
end

return DeepFrier