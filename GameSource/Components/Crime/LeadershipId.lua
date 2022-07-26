local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local LeadershipId = class("LeadershipId", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function LeadershipId:initialize()
	self.name = "LeadershipId"
end

function LeadershipId.category()
	return Enums.ComponentCategory.Crime
end

function LeadershipId.displayName()
	return "Captain ID"
end

function LeadershipId.createFromParameters(params)
	return LeadershipId:new()
end

function LeadershipId.tags()
	return {}
end

function LeadershipId.requirements()
	return {
	}
end

function LeadershipId.defaults()
	return {
		
	}
end

function LeadershipId.mutuallyExclusive()
	return {  }
end

function LeadershipId.dependsOnComponents() 
	return { "TopLevelTool" }
end

function LeadershipId.desc()
	return "This ID has Captain-level access."
end

return LeadershipId