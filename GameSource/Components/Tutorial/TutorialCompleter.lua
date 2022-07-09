local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local TutorialCompleter = class("TutorialCompleter", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function TutorialCompleter:initialize()
	self.name = "TutorialCompleter"
end

function TutorialCompleter.category()
	return Enums.ComponentCategory.Furniture
end

function TutorialCompleter.displayName()
	return "Interact to Complete Tutorial"
end

function TutorialCompleter.createFromParameters(params)
	return TutorialCompleter:new()
end

function TutorialCompleter.tags()
	return { }
end

function TutorialCompleter.requirements()
	return {
	}
end

function TutorialCompleter.defaults()
	return {
		
	}
end

function TutorialCompleter.mutuallyExclusive()
	return { "TopLevelTool" }
end

function TutorialCompleter.dependsOnComponents() 
	return {}
end

function TutorialCompleter.desc()
	return "Interact with this to complete the tutorial."
end

return TutorialCompleter