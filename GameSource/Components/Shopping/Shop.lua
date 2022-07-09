local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Shop = class("Shop", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function Shop:initialize() 
	self.name = "Shop"
end

function Shop.createFromParameters(params)
	return Shop:new()
end

function Shop.requirements()
	return {}
end

function Shop.defaults()
	return {
	}
end

function Shop.tags()
	return {Enums.ComponentTag.Deprecated}
end

function Shop.desc()
	return "Turns this entity into a shop that sells item guids."
end

return Shop
