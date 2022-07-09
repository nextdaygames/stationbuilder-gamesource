local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Heal = class("Heal", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function Heal:initialize(healAmount, healType) 
	if healAmount == nil then
		error("nil healAmount")
	end
	self.healAmount = healAmount

	if healType == nil then
		error("nil healType")
	end
	self.healType = healType

	self.name = "Heal"
end

function Heal.category()
	return Enums.ComponentCategory.Health
end

function Heal.displayName()
	return "Heal Characters on Item Use"
end

function Heal.createFromParameters(params)
	return Heal:new(params["Heal Amount"], params["Heal Type"])
end

function Heal.requirements()
	return {
		["Heal Amount"] = Enums.ValidEntryTypes.Float,
		["Heal Type"] = Enums.ValidEntryTypes.SelectOneOption
	}
end

function Heal.options()
	return {
		["Heal Type"] = "brute,burn,toxic,suffocation,starvation,"
	}
end

function Heal.defaults()
	return {
		["Heal Type"] = "brute",
		["Heal Amount"] = "34",
	}
end

function Heal.tags()
	return {}
end

function Heal.dependsOnComponents() 
	return {"TopLevelTool"}
end

function Heal.desc()
	return "Heal characters for an amount of health."
end

return Heal