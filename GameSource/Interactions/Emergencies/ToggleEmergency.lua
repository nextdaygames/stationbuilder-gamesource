local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})
local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local ToggleEmergency = class("ToggleEmergency", Interact)

function ToggleEmergency:init()
    self.aiActionCost = 1
    self.name = "ToggleEmergency"
end

function ToggleEmergency:instigatorInteractsWithObjectMatches()
    return {
        instigatorMatches = {"Character", "PlayerControlled"},
        aiInstigatorRequires = { },
        objectMatches = {"EmergencyActivator"},
    }
end

function ToggleEmergency:instigatorInteractsWithObject(instigator, object, interactionToolsProcessor)
	
    local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    local messageSource = instigatorEntityContainer.entityContainer:WaitForChild("Head")
    local objectName = object:getComponent("EntityName").entityName

    local emergencyActivatorComponent = object:getComponent("EmergencyActivator")
    local currentTime = os.time()
    local durationUntil = currentTime - emergencyActivatorComponent.lastToggleTime
    if emergencyActivatorComponent.lastToggleTime ~= 0 and durationUntil < emergencyActivatorComponent.toggleCooldownSeconds then
        local message = "Cannot toggle the " .. objectName .. " for another " .. (emergencyActivatorComponent.toggleCooldownSeconds - durationUntil) .. " seconds."
        ChatService:Chat(messageSource, message, Enum.ChatColor.Blue)
        return true
    end
    emergencyActivatorComponent.lastToggleTime = currentTime
    emergencyActivatorComponent.isEmergency = not emergencyActivatorComponent.isEmergency

    local objectEntityContainerComponent = object:getComponent("EntityContainer")
	Get("Utility/AudioFaker"):playSoundAssetAtLocation(9125626281, objectEntityContainerComponent.primaryPart.Position) -- Lever Mechanism Crank Clicks Big Metal Clunk (SFX)

    local message = (emergencyActivatorComponent.isEmergency and "Activates" or "Deactivates") .. " the " .. objectName .. "."
    ChatService:Chat(messageSource, message, Enum.ChatColor.Blue)
    
    return true
end

return ToggleEmergency
