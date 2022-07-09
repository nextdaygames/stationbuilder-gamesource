local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Pickaxe = class("Pickaxe", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function Pickaxe:initialize() 
	self.name = "Pickaxe"
end

function Pickaxe.category()
	return Enums.ComponentCategory.Mining
end

function Pickaxe.displayName()
	return "Mine Rocks"
end

function Pickaxe.createFromParameters(params)
	return Pickaxe:new()
end

function Pickaxe.requirements()
	return {
	}
end

function Pickaxe.defaults()
	return {
	}
end

function Pickaxe.tags()
	return {
	}
end

function Pickaxe.mutuallyExclusive()
	return {  }
end

function Pickaxe.dependsOnComponents()
	return {"TopLevelTool" }
end

function Pickaxe.desc()
	return "Mine ore veins."
end

return Pickaxe 