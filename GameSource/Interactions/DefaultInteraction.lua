local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})
local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local DefaultInteraction = class("DefaultInteraction", Interact)

function DefaultInteraction:init()
    self.aiActionCost = 1
    self.name = "DefaultInteraction"
end

function DefaultInteraction:instigatorInteractsWithObjectMatches()
    return {
        instigatorMatches = {},
        aiInstigatorRequires = { },
        objectMatches = {},
    }
end

function DefaultInteraction:instigatorInteractsWithObject(instigator, object, interactionToolsProcessor)
	return false
end

function DefaultInteraction:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = {},
        aiInstigatorRequires = {},
        objectMatches = {},
        toolMatches = {},
    }
end

function DefaultInteraction:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)
	return false
end

function DefaultInteraction:instigatorInteractsWithSelfMatches()
    return {
        instigatorMatches = {},
        aiInstigatorRequires = {},
    }
end

function DefaultInteraction:instigatorInteractsWithSelf(instigator, interactionToolsProcessor)
	return false
end

function DefaultInteraction:instigatorInteractsWithSelfUsingToolMatches()
    return {
        instigatorMatches = {},
        aiInstigatorRequires = {},
        toolMatches = {},
    }
end

function DefaultInteraction:instigatorInteractsWithSelfUsingTool(instigator, tool, interactionToolsProcessor)
	return false
end

return DefaultInteraction
