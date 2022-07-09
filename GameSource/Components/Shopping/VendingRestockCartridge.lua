local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local VendingRestockCartridge = class("VendingRestockCartridge", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function VendingRestockCartridge:initialize(vendCategory) 
	self.name = "VendingRestockCartridge"

	if vendCategory == nil then
		error("nil vendCategory")
	end
	self.vendCategory = vendCategory
end

function VendingRestockCartridge.category()
	return Enums.ComponentCategory.Vending
end

function VendingRestockCartridge.displayName()
	return "Restock a Vending Machine"
end

function VendingRestockCartridge.createFromParameters(params)
	return VendingRestockCartridge:new(params["Vend Category"])
end

function VendingRestockCartridge.requirements()
	return {
        ["Vend Category"] = Enums.ValidEntryTypes.String,
	}
end

function VendingRestockCartridge.fieldsToModerate()
	return {
		"Vend Category"
	}
end

function VendingRestockCartridge.defaults()
	return {
        ["Vend Category"] = "drinks",
	}
end

function VendingRestockCartridge.tags()
	return {
        -- Enums.ComponentTag.Deprecated
	}
end

function VendingRestockCartridge.mutuallyExclusive()
	return {}
end

function VendingRestockCartridge.dependsOnComponents()
	return {"TopLevelTool"}
end

function VendingRestockCartridge.desc()
	return "Replaces missing items in a vending machine."
end

return VendingRestockCartridge 