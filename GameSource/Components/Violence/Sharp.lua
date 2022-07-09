local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Sharp = class("Sharp", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function Sharp:initialize() 
	self.name = "Sharp"
end

function Sharp.category()
	return Enums.ComponentCategory.Weapons
end

function Sharp.displayName()
	return "Sharp"
end

function Sharp.createFromParameters(params)
	return Sharp:new()
end

function Sharp.requirements()
	return {}
end

function Sharp.defaults()
	return {}
end

function Sharp.tags()
	return {}
end

function Sharp.dependsOnComponents() 
	return {"TopLevelTool"}
end

function Sharp.desc()
	return "This tool is sharp and can cut and slice items."
end

return Sharp