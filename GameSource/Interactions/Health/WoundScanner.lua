local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})
local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local WoundScanner = class("WoundScanner", Interact)

function WoundScanner:init()
    self.aiActionCost = 1
    self.name = "WoundScanner"
end

function WoundScanner:createScanMessage(ownerName, woundTrackerComponent)
    local message = ownerName

    if #woundTrackerComponent.wounds == 0 then
        return message .. "\nNo Wounds"
    end

    for _, wound in ipairs(woundTrackerComponent.wounds) do
        message = message.. "\n" .. wound.name .. " ".. wound.damage/10 .. "/s"
    end
    return message
end

function WoundScanner:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = { "Character" },
        aiInstigatorRequires = { "MedicalAI" },
        objectMatches = { "Character", "WoundTracker" },
        toolMatches = { "WoundScanner" },
    }
end

function WoundScanner:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)

    local instigatorEntityContainerComponent = instigator:getComponent("EntityContainer")

    local objectWoundTrackerComponent = object:getComponent("WoundTracker")
    local objectName = object:getComponent("EntityName").entityName

    local message = self:createScanMessage(objectName, objectWoundTrackerComponent)
    ChatService:Chat(instigatorEntityContainerComponent.entityContainer:WaitForChild("Head"), message, Enum.ChatColor.Blue)

	return true
end

function WoundScanner:instigatorInteractsWithSelfUsingToolMatches()
    return {
        instigatorMatches = { "Character", "WoundTracker" },
        aiInstigatorRequires = { "MedicalAI" },
        toolMatches = { "WoundScanner" },
    }
end

function WoundScanner:instigatorInteractsWithSelfUsingTool(instigator, tool, interactionToolsProcessor)

    local instigatorEntityContainerComponent = instigator:getComponent("EntityContainer")

    local instigatorName = instigator:getComponent("EntityName").entityName
    local instigatorWoundTrackerComponent = instigator:getComponent("WoundTracker")
    local message = self:createScanMessage(instigatorName, instigatorWoundTrackerComponent)

    ChatService:Chat(instigatorEntityContainerComponent.entityContainer:WaitForChild("Head"), message, Enum.ChatColor.Blue)

	return true
end

return WoundScanner
