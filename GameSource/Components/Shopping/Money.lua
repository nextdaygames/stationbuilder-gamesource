local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Money = class("Money", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function Money:initialize(value) 
	if value == nil then
		error("value not initialized")
	end
	self.value = value

	self.name = "Money"
end

function Money.category()
	return Enums.ComponentCategory.Shopping
end

function Money.displayName()
	return "Act as Money"
end

function Money.createFromParameters(params)
	return Money:new(tonumber(params["Value"]))
end

function Money.requirements()
	return {
		["Value"] = Enums.ValidEntryTypes.Float
	}
end

function Money.defaults()
	return {
		["Value"] = 1,
	}
end

function Money.tags()
	return {}
end

function Money.desc()
	return "This item can be used to buy things."
end

return Money