local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Machinery = class("Machinery", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function Machinery:initialize()
	self.name = "Machinery"
end

function Machinery.category()
	return Enums.ComponentCategory.Machinery
end

function Machinery.displayName()
	return "Enable Machinery"
end

function Machinery.createFromParameters(params)
	return Machinery:new()
end

function Machinery.requirements()
	return {
	}
end

function Machinery.defaults()
	return {
	}
end

function Machinery.tags()
	return { Enums.ComponentTag.Deprecated, Enums.ComponentTag.DeprecatedSafeToDelete }
end

function Machinery.mutuallyExclusive()
    return { "TopLevelTool" }
end

function Machinery.desc()
	return "Enables complicated machinery."
end

return Machinery