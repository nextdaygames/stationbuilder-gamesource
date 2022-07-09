local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local OreVein = class("OreVein", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function OreVein:initialize(oreItemGuid, quantityCreated) 
	self.name = "OreVein"

	if oreItemGuid == nil then
		error("nil oreItemGuid")
	end
	self.oreItemGuid = oreItemGuid

	if quantityCreated == nil then
		error("nil quantityCreated")
	end
	self.quantityCreated = quantityCreated
end

function OreVein.category()
	return Enums.ComponentCategory.Mining
end

function OreVein.displayName()
	return "Ore Vein"
end

function OreVein.createFromParameters(params)
	return OreVein:new(params["Ore Item"], params["Quantity Created"])
end

function OreVein.requirements()
	return {
		["Ore Item"] = Enums.ValidEntryTypes.ItemGuid,
		["Quantity Created"] = Enums.ValidEntryTypes.Float,
	}
end

function OreVein.defaults()
	return {
		["Ore Item"] = "missing",
		["Quantity Created"] = 1,
	}
end

function OreVein.tags()
	return {
	}
end

function OreVein.mutuallyExclusive()
	return { "TopLevelTool" }
end

function OreVein.dependsOnComponents()
	return {  }
end

function OreVein.desc()
	return "A OreVein of ore."
end

return OreVein 