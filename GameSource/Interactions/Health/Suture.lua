local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))
local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

local Suture = class("Suture", Interact)

function Suture:init()
    self.aiActionCost = 1
    self.name = "Suture"
end

function Suture:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = { "MedicalAI" },
        objectMatches = {"Character", "WoundTracker"},
		toolMatches = {"Suture"}
    }
end

function sortByDamage(a,b)
    return a["damage"] < b["damage"]
end

function Suture:suture(woundTrackerComponent)
	
    if #woundTrackerComponent.wounds == 0 then
        print("no wounds")
        return false
    end

    table.sort(woundTrackerComponent.wounds, sortByDamage)
    local woundName = woundTrackerComponent.wounds[1]["name"]
    table.remove(woundTrackerComponent.wounds, 1)

    return true, woundName
end

function Suture:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)
    local isSutureSuccessful, woundName = self:suture(object:getComponent("WoundTracker"))

    if not isSutureSuccessful then
        return false
    end

    local objectName = object:getComponent("EntityName").entityName
    local toolName = tool:getComponent("EntityName").entityName
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Sutures " .. objectName .. "'s " .. woundName .. " using the " .. toolName .. ".", Enum.ChatColor.Blue)

	return true
end

function Suture:instigatorInteractsWithSelfUsingToolMatches()
    return {
        instigatorMatches = {"Character", "WoundTracker"},
        aiInstigatorRequires = { "MedicalAI" },
		toolMatches = {"Suture"}
    }
end

function Suture:instigatorInteractsWithSelfUsingTool(instigator, tool, interactionToolsProcessor)
    local isSutureSuccessful, woundName = self:suture(instigator:getComponent("WoundTracker"))

    if not isSutureSuccessful then
        return false
    end

    local toolName = tool:getComponent("EntityName").entityName
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Sutures their " .. woundName .. " using the " .. toolName .. ".", Enum.ChatColor.Blue)

	return true
end

return Suture
