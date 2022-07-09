local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Buyer = class("Buyer", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function Buyer:initialize() 
	self.name = "Buyer"
end

function Buyer.category()
	return Enums.ComponentCategory.Vending
end

function Buyer.displayName()
	return "Sell Items to this Item"
end

function Buyer.createFromParameters(params)
	return Buyer:new()
end

function Buyer.requirements()
	return {
	}
end

function Buyer.fieldsToModerate()
	return {
	}
end

function Buyer.defaults()
	return {
	}
end

function Buyer.tags()
	return {
	}
end

function Buyer.mutuallyExclusive()
	return {}
end

function Buyer.dependsOnComponents()
	return { }
end

function Buyer.desc()
	return "Use items on this item to sell stuff."
end

return Buyer 