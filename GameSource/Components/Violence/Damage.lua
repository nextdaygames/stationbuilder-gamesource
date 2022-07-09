local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Damage = class("Damage", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function Damage:initialize(damage) 
	if damage == nil then
		error("damage not initialized")
	end
	self.damage = damage

	self.name = "Damage"
end

function Damage.category()
	return Enums.ComponentCategory.Weapons
end

function Damage.displayName()
	return "Damage"
end

function Damage.createFromParameters(params)
	return Damage:new(params["Damage"])
end

function Damage.requirements()
	return {
		["Damage"] = Enums.ValidEntryTypes.Float
	}
end

function Damage.defaults()
	return {
		["Damage"] = "34",
	}
end

function Damage.tags()
	return {}
end

function Damage.dependsOnComponents() 
	return {"TopLevelTool"}
end

function Damage.desc()
	return "Stores the amount of damage this tool creates."
end

return Damage