local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local HealthScanner = class("HealthScanner", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function HealthScanner:initialize()
	self.name = "HealthScanner"
end

function HealthScanner.category()
	return Enums.ComponentCategory.Health
end

function HealthScanner.displayName()
	return "Display Character Vitals"
end

function HealthScanner.createFromParameters(params)
	return HealthScanner:new()
end

function HealthScanner.requirements()
	return {
	}
end

function HealthScanner.defaults()
	return {
	}
end

function HealthScanner.tags()
	return {}
end

function HealthScanner.dependsOnComponents() 
	return {"TopLevelTool"}
end

function HealthScanner.desc()
	return "Use an item with this component on a character to read out their damage values."
end

return HealthScanner