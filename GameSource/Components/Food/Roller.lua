local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Roller = class("Roller", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function Roller:initialize() 
	self.name = "Roller"
end

function Roller.category()
	return Enums.ComponentCategory.Food
end

function Roller.displayName()
	return "Flatten Foodstuffs"
end

function Roller.createFromParameters(params)
	return Roller:new()
end

function Roller.requirements()
	return {}
end

function Roller.defaults()
	return {}
end

function Roller.tags()
	return {}
end

function Roller.dependsOnComponents() 
	return {"TopLevelTool"}
end

function Roller.desc()
	return "This tool is flat and can roll out foodstuffs."
end

return Roller