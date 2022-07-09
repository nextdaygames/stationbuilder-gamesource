local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Poison = class("Poison", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function Poison:initialize() 
	self.name = "Poison"
end

function Poison.category()
	return Enums.ComponentCategory.Weapons
end

function Poison.displayName()
	return "Poison Food and People"
end

function Poison.createFromParameters(params)
	return Poison:new()
end

function Poison.requirements()
	return {

	}
end

function Poison.defaults()
	return {
	}
end

function Poison.tags()
	return {

	}
end

function Poison.dependsOnComponents() 
	return {
		"TopLevelTool"
	}
end

function Poison.desc()
	return "Can by used to poison yourself or poison food."
end

return Poison