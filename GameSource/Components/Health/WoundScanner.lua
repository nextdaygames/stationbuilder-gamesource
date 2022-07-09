local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local WoundScanner = class("WoundScanner", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function WoundScanner:initialize() 
	self.name = "WoundScanner"
end

function WoundScanner.category()
	return Enums.ComponentCategory.Health
end

function WoundScanner.displayName()
	return "Display Character Wounds"
end

function WoundScanner.createFromParameters(params)
	return WoundScanner:new()
end

function WoundScanner.requirements()
	return {
	}
end

function WoundScanner.defaults()
	return {
	}
end

function WoundScanner.tags()
	return {}
end

function WoundScanner.dependsOnComponents() 
	return {"TopLevelTool"}
end

function WoundScanner.desc()
	return "Reads wounds and bleeding rate of injuries."
end

return WoundScanner