local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})
local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local HealthScan = class("HealthScan", Interact)

function HealthScan:init()
    self.aiActionCost = 1
    self.name = "HealthScan"
end

function HealthScan:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = { "Character" },
        aiInstigatorRequires = { "MedicalAI" },
        objectMatches = { "Character", "OrganicHealth" },
        toolMatches = { "HealthScanner" },
    }
end

function HealthScan:createMessage(scannedEntity, organicHealth)
    local objectName = scannedEntity:getComponent("EntityName").entityName

    local message = objectName
    if organicHealth.bruteDamage > 0 then
        message = message .. "\nBrute: " .. organicHealth.bruteDamage
    end
    if organicHealth.toxicDamage > 0 then
        message = message .. "\nToxic: " .. organicHealth.toxicDamage
    end
    if organicHealth.burnDamage > 0 then
        message = message .. "\nBurn: " .. organicHealth.burnDamage
    end
    if organicHealth.suffocationDamage > 0 then
        message = message .. "\nSuffocation: " .. organicHealth.suffocationDamage
    end
    if organicHealth.starvationDamage > 0 then
        message = message .. "\nStarvation: " .. organicHealth.starvationDamage
    end
    if message == objectName then
        message = message .. "\nHealthy"
    end
    if scannedEntity:getComponent("Epinephrine") ~= nil then
        message = message .. "\nEpinephrine Administered"
    end
    return message
end

function HealthScan:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)

    local objectOrganicHealthComponent = object:getComponent("OrganicHealth")
    local instigatorEntityContainerComponent = instigator:getComponent("EntityContainer")
    local message = self:createMessage(object, objectOrganicHealthComponent)
    ChatService:Chat(instigatorEntityContainerComponent.entityContainer:WaitForChild("Head"), message, Enum.ChatColor.Blue)

	return true
end

function HealthScan:instigatorInteractsWithSelfUsingToolMatches()
    return {
        instigatorMatches = { "Character", "OrganicHealth" },
        aiInstigatorRequires = { "MedicalAI" },
        toolMatches = { "HealthScanner" },
    }
end

function HealthScan:instigatorInteractsWithSelfUsingTool(instigator, tool, interactionToolsProcessor)

    local instigatorOrganicHealthComponent = instigator:getComponent("OrganicHealth")
    local instigatorEntityContainerComponent = instigator:getComponent("EntityContainer")
    local message = self:createMessage(instigator, instigatorOrganicHealthComponent)
    ChatService:Chat(instigatorEntityContainerComponent.entityContainer:WaitForChild("Head"), message, Enum.ChatColor.Blue)

	return true
end

return HealthScan
