local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local BloodRestock = class("BloodRestock", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function BloodRestock:initialize(bloodQuantity) 
	if bloodQuantity == nil then
		error("nil bloodQuantity")
	end
	self.bloodQuantity = bloodQuantity

	self.name = "BloodRestock"
end

function BloodRestock.category()
	return Enums.ComponentCategory.Health
end

function BloodRestock.displayName()
	return "Restore Blood"
end

function BloodRestock.createFromParameters(params)
	return BloodRestock:new(params["Blood Quantity"])
end

function BloodRestock.requirements()
	return {
		["Blood Quantity"] = Enums.ValidEntryTypes.Float,
	}
end

function BloodRestock.defaults()
	return {
		["Blood Quantity"] = "20",
	}
end

function BloodRestock.tags()
	return {}
end

function BloodRestock.dependsOnComponents() 
	return {"TopLevelTool"}
end

function BloodRestock.desc()
	return "Restores lost blood to people."
end

return BloodRestock