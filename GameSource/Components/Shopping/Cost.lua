
local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))


local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Cost = class("Cost", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function Cost:initialize(cost, handleOrientation) 
	if cost == nil then
		error("cost not initialized")
	end
	self.cost = cost

	self.name = "Cost"
end

function Cost.category()
	return Enums.ComponentCategory.Shopping
end

function Cost.displayName()
	return "Cost of the Item"
end

function Cost.createFromParameters(params)
	return Cost:new(params["Cost"])
end

function Cost.requirements()
	return {
		["Cost"] = Enums.ValidEntryTypes.Float
	}
end

function Cost.tags()
	return {Enums.ComponentTag.ClothingDefault, Enums.ComponentTag.GadgetDefault, Enums.ComponentTag.FurnitureDefault}
end

function Cost.defaults()
	return {
		["Cost"] = 1,
	}
end

function Cost.desc()
	return "The cost of this item."
end

return Cost 