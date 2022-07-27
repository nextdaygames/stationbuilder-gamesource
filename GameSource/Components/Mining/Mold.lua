local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Mold = class("Mold", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function Mold:initialize(craftedItemGuid) 
	self.name = "Mold"

	if craftedItemGuid == nil then
		error("nil craftedItemGuid")
	end
	self.craftedItemGuid = craftedItemGuid
end

function Mold.category()
	return Enums.ComponentCategory.Mining
end

function Mold.displayName()
	return "Mold"
end

function Mold.createFromParameters(params)
	return Mold:new(params["Crafted Item"])
end

function Mold.requirements()
	return {
		["Crafted Item"] = Enums.ValidEntryTypes.ItemGuid,
	}
end

function Mold.defaults()
	return {
		["Crafted Item"] = "missing",
	}
end

function Mold.tags()
	return {}
end

function Mold.dependsOnComponents() 
	return {}
end

function Mold.desc()
	return "Turns ore bar into an item."
end

return Mold