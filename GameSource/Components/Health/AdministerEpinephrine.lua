local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local AdministerEpinephrine = class("AdministerEpinephrine", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function AdministerEpinephrine:initialize() 
	self.name = "AdministerEpinephrine"
end

function AdministerEpinephrine.category()
	return Enums.ComponentCategory.Health
end

function AdministerEpinephrine.displayName()
	return "Administer Epinephrine"
end

function AdministerEpinephrine.createFromParameters(params)
	return AdministerEpinephrine:new()
end

function AdministerEpinephrine.requirements()
	return {
	}
end

function AdministerEpinephrine.defaults()
	return {
	}
end

function AdministerEpinephrine.tags()
	return {}
end

function AdministerEpinephrine.dependsOnComponents() 
	return {"TopLevelTool"}
end

function AdministerEpinephrine.desc()
	return "Epinephrine prevent suffocation damage when unconcious."
end

return AdministerEpinephrine
