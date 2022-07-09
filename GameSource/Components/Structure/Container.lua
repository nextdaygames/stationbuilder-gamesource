local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Container = class("Container", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function Container:initialize() 
	self.name = "Container"

    self.storedItem = nil
end

function Container.category()
	return Enums.ComponentCategory.Container
end

function Container.displayName()
	return "Store an Item Inside"
end

function Container.createFromParameters(params)
	return Container:new()
end

function Container.requirements()
	return {
	}
end

function Container.defaults()
	return {

	}
end

function Container.tags()
	return {
		Enums.ComponentTag.Deprecated,
	}
end

function Container.mutuallyExclusive()
	return { "TopLevelTool" }
end

function Container.dependsOnComponents()
	return { }
end

function Container.desc()
	return "Only one item can be stored at a time."
end

return Container 