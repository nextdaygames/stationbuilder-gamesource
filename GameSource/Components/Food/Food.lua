local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Food = class("Food", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function Food:initialize(hungerAmount)
	if hungerAmount == nil then
		error("nil hungerAmount")
	end
	self.hungerAmount = hungerAmount
	
	self.name = "Food"
end

function Food.category()
	return Enums.ComponentCategory.Food
end

function Food.displayName()
	return "Edible"
end

function Food.createFromParameters(params)
	return Food:new(params["Hunger Amount"])
end

function Food.requirements()
	return {
		["Hunger Amount"] = Enums.ValidEntryTypes.Float,
	}
end

function Food.defaults()
	return {
		["Hunger Amount"] = 10,
	}
end

function Food.dependsOnComponents()
	return {"TopLevelTool"}
end

function Food.tags()
	return {}
end

function Food.desc()
	return "This item can be eaten."
end

return Food