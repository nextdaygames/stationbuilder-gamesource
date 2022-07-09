local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local ItemFaucet = class("ItemFaucet", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function ItemFaucet:initialize(toolHasFeaturesString, itemGuid, cooldownSeconds) 
	self.name = "ItemFaucet"

    if toolHasFeaturesString == nil then
		error("nil toolHasFeaturesString")
	end
	self.toolHasFeaturesString = toolHasFeaturesString

    if itemGuid == nil then
		error("nil itemGuid")
	end
	self.itemGuid = itemGuid

    if cooldownSeconds == nil then
		error("nil cooldownSeconds")
	end
	self.cooldownSeconds = cooldownSeconds

	self.lastUsedTime = os.time()
end

function ItemFaucet.category()
	return Enums.ComponentCategory.Mining
end

function ItemFaucet.displayName()
	return "Produce Items on Interaction"
end

function ItemFaucet.createFromParameters(params)
	return ItemFaucet:new(params["Tool has Features"], params["Creates Item"], params["Cooldown Seconds"])
end

function ItemFaucet.requirements()
	return {
        ["Tool has Features"] = Enums.ValidEntryTypes.String,
        ["Creates Item"] = Enums.ValidEntryTypes.ItemGuid,
        ["Cooldown Seconds"] = Enums.ValidEntryTypes.Float,
	}
end

function ItemFaucet.defaults()
	return {
        ["Tool has Features"] = "Pickaxe",
        ["Creates Item"] = "missing",
        ["Cooldown Seconds"] = 1,
	}
end

function ItemFaucet.tags()
	return {
        -- Enums.ComponentTag.Deprecated
	}
end

function ItemFaucet.mutuallyExclusive()
	return { "VendingMachine", "ScoreVendingMachine" }
end

function ItemFaucet.dependsOnComponents()
	return { }
end

function ItemFaucet.desc()
	return "When you use a matching tool on this, this item produces an item."
end

return ItemFaucet 