local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local KeyedDoor = class("KeyedDoor", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function KeyedDoor:initialize(doorCode)
	if doorCode == nil then
		error("nil doorCode")
	end
	self.doorCode = doorCode

	self.name = "KeyedDoor"
end

function KeyedDoor.category()
	return Enums.ComponentCategory.Furniture
end

function KeyedDoor.displayName()
	return "Make it a Keyed Doorway"
end

function KeyedDoor.createFromParameters(params)
	return KeyedDoor:new(params["Door Code"])
end

function KeyedDoor.requirements()
	return {
        ["Door Code"] = Enums.ValidEntryTypes.String,
	}
end

function KeyedDoor.defaults()
	return {
        ["Door Code"] = "All Access",
	}
end

function KeyedDoor.dependsOnComponents()
	return {}
end

function KeyedDoor.mutuallyExclusive()
	return { "TopLevelTool" }
end

function KeyedDoor.tags()
	return { }
end

function KeyedDoor.desc()
	return "Interacting with this toggles its collision box."
end

return KeyedDoor