local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local VendingMachine = class("VendingMachine", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function VendingMachine:initialize(vendCategory, vendedItemGuid, startingItemCount) 
	self.name = "VendingMachine"

    if vendCategory == nil then
		error("nil vendCategory")
	end
	self.vendCategory = vendCategory

    if vendedItemGuid == nil then
		error("nil vendedItemGuid")
	end
	self.vendedItemGuid = vendedItemGuid

    if startingItemCount == nil then
		error("nil startingItemCount")
	end
	self.startingItemCount = startingItemCount
	self.itemsLeft = startingItemCount

	self.currencyInsertedTotalValue = 0
end

function VendingMachine.category()
	return Enums.ComponentCategory.Vending
end

function VendingMachine.displayName()
	return "Vend Items"
end

function VendingMachine.createFromParameters(params)
	return VendingMachine:new(params["Vend Category"], params["Vended Item"], params["Starting Item Count"])
end

function VendingMachine.requirements()
	return {
        ["Vend Category"] = Enums.ValidEntryTypes.String,
        ["Vended Item"] = Enums.ValidEntryTypes.ItemGuid,
        ["Starting Item Count"] = Enums.ValidEntryTypes.Float,
	}
end

function VendingMachine.fieldsToModerate()
	return {
		"Vend Category"
	}
end

function VendingMachine.defaults()
	return {
        ["Vend Category"] = "drinks",
        ["Vended Item"] = "missing",
        ["Starting Item Count"] = 1,
	}
end

function VendingMachine.tags()
	return {
        -- Enums.ComponentTag.Deprecated
	}
end

function VendingMachine.mutuallyExclusive()
	return { "ItemFaucet", "ScoreVendingMachine" }
end

function VendingMachine.dependsOnComponents()
	return { }
end

function VendingMachine.desc()
	return "Make this object vend things."
end

return VendingMachine 