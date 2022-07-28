local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Burns = class("Burns", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function Burns:initialize() 
	self.name = "Burns"
end

function Burns.category()
	return Enums.ComponentCategory.Weapons
end

function Burns.displayName()
	return "Burn Things"
end

function Burns.createFromParameters(params)
end

function Burns.requirements()
	return {}
end

function Burns.defaults()
	return {}
end

function Burns.tags()
	return {}
end

function Burns.dependsOnComponents() 
	return {"TopLevelTool"}
end

function Burns.desc()
	return "Causes burn damage."
end

return Burns