local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local TrashReceptacle = class("TrashReceptacle", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function TrashReceptacle:initialize()
	self.name = "TrashReceptacle"
end

function TrashReceptacle.category()
	return Enums.ComponentCategory.Furniture
end

function TrashReceptacle.displayName()
	return "Make this Delete Trash"
end

function TrashReceptacle.createFromParameters(params)
	return TrashReceptacle:new()
end

function TrashReceptacle.requirements()
	return {
	}
end

function TrashReceptacle.defaults()
	return {
	}
end

function TrashReceptacle.dependsOnComponents()
	return {}
end

function TrashReceptacle.tags()
	return {}
end

function TrashReceptacle.desc()
	return "Use tools on this item to delete the tool."
end

return TrashReceptacle