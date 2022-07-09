local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local ScoreVendingMachine = class("ScoreVendingMachine", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function ScoreVendingMachine:initialize(vendedItemGuid, itemCost) 
	self.name = "ScoreVendingMachine"

    if vendedItemGuid == nil then
		error("nil vendedItemGuid")
	end
	self.vendedItemGuid = vendedItemGuid

	if itemCost == nil then
		error("nil itemCost")
	end
	self.itemCost = itemCost
end

function ScoreVendingMachine.category()
	return Enums.ComponentCategory.Vending
end

function ScoreVendingMachine.displayName()
	return "Vend Items using Score"
end

function ScoreVendingMachine.createFromParameters(params)
	return ScoreVendingMachine:new(params["Vended Item"], params["Item Cost"])
end

function ScoreVendingMachine.requirements()
	return {
        ["Vended Item"] = Enums.ValidEntryTypes.ItemGuid,
        ["Item Cost"] = Enums.ValidEntryTypes.Float,
	}
end

function ScoreVendingMachine.defaults()
	return {
        ["Vended Item"] = "missing",
		["Item Cost"] = 10
	}
end

function ScoreVendingMachine.tags()
	return {
	}
end

function ScoreVendingMachine.mutuallyExclusive()
	return { "ItemFaucet", "VendingMachine" }
end

function ScoreVendingMachine.dependsOnComponents()
	return { }
end

function ScoreVendingMachine.desc()
	return "Make this object vend things for a portion of the players score."
end

return ScoreVendingMachine 