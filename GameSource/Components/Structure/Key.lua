local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Key = class("Key", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function Key:initialize(doorCode)
	if doorCode == nil then
		error("nil doorCode")
	end
	self.doorCode = doorCode

	self.name = "Key"
end

function Key.category()
	return Enums.ComponentCategory.Furniture
end

function Key.displayName()
	return "Open Keyed Doors"
end

function Key.createFromParameters(params)
	return Key:new(params["Door Code"])
end

function Key.tags()
	return { }
end

function Key.requirements()
	return {
        ["Door Code"] = Enums.ValidEntryTypes.String,
	}
end

function Key.defaults()
	return {
        ["Door Code"] = "All Access",		
	}
end

function Key.mutuallyExclusive()
	return { }
end

function Key.dependsOnComponents() 
	return {"TopLevelTool"}
end

function Key.desc()
	return "Opens keyed doors."
end

return Key