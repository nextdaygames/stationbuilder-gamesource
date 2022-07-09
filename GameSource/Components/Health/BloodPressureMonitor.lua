local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local BloodPressureMonitor = class("BloodPressureMonitor", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function BloodPressureMonitor:initialize() 
	self.name = "BloodPressureMonitor"
end

function BloodPressureMonitor.category()
	return Enums.ComponentCategory.Health
end

function BloodPressureMonitor.displayName()
	return "Display Blood Pressure"
end

function BloodPressureMonitor.createFromParameters(params)
	return BloodPressureMonitor:new()
end

function BloodPressureMonitor.requirements()
	return {
	}
end

function BloodPressureMonitor.defaults()
	return {
	}
end

function BloodPressureMonitor.tags()
	return {}
end

function BloodPressureMonitor.dependsOnComponents() 
	return {"TopLevelTool"}
end

function BloodPressureMonitor.desc()
	return "Reads the blood pressure. A normal blood pressure is 120/80."
end

return BloodPressureMonitor