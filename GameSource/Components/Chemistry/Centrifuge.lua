local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Centrifuge = class("Centrifuge", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})
function Centrifuge:initialize()
	self.name = "Centrifuge"
end

function Centrifuge.category()
	return Enums.ComponentCategory.Chemistry
end

function Centrifuge.displayName()
	return "Centrifuge"
end

function Centrifuge.createFromParameters(params)
	return Centrifuge:new()
end

function Centrifuge.tags()
	return {}
end

function Centrifuge.requirements()
	return {
	}
end

function Centrifuge.defaults()
	return {
		
	}
end

function Centrifuge.mutuallyExclusive()
	return { "ToolMaker" }
end

function Centrifuge.dependsOnComponents() 
	return {}
end

function Centrifuge.desc()
	return "This item acts as a centrifuge on liquids like blood."
end

return Centrifuge