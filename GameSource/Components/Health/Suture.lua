local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Suture = class("Suture", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function Suture:initialize() 
	self.name = "Suture"
end

function Suture.category()
	return Enums.ComponentCategory.Health
end

function Suture.displayName()
	return "Suture Wounds"
end

function Suture.createFromParameters(params)
	return Suture:new()
end

function Suture.requirements()
	return {

	}
end

function Suture.defaults()
	return {
	}
end

function Suture.tags()
	return {

	}
end

function Suture.dependsOnComponents() 
	return {
		"TopLevelTool"
	}
end

function Suture.desc()
	return "Can by used to close open wounds."
end

return Suture