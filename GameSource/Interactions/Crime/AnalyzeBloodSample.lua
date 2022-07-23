local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})
local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local AnalyzeBloodSample = class("AnalyzeBloodSample", Interact)

function AnalyzeBloodSample:init()
    self.aiActionCost = 1
    self.name = "AnalyzeBloodSample"
end

function AnalyzeBloodSample:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = {},
        objectMatches = {"Centrifuge"},
        toolMatches = {"BloodSampleContainer"},
    }
end

function AnalyzeBloodSample:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)
	local toolBloodSampleComponent = tool:getComponent("BloodSampleContainer")

    toolBloodSampleComponent.bloodType = toolBloodSampleComponent.hiddenBloodType
    local message = "This blood sample is blood type " .. toolBloodSampleComponent.bloodType .. ". "

    local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    local messageSource = instigatorEntityContainer.entityContainer:WaitForChild("Head")
    ChatService:Chat(messageSource, message, Enum.ChatColor.Blue)
    
    return true
end

function AnalyzeBloodSample:instigatorInteractsWithSelfUsingToolMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = {},
        toolMatches = {"BloodSampleContainer"},
    }
end

function AnalyzeBloodSample:instigatorInteractsWithSelfUsingTool(instigator, tool, interactionToolsProcessor)
	local toolBloodSampleComponent = tool:getComponent("BloodSampleContainer")

    local message = "No message"
    if toolBloodSampleComponent.hiddenBloodType == nil then
        message = "This blood sample is empty."
    else
        if toolBloodSampleComponent.bloodType == nil then
            message = "This blood sample needs to be run through a centrifuge."
        else
            message = "This blood sample is blood type " .. toolBloodSampleComponent.bloodType .. ". "
        end
    end

    local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    local messageSource = instigatorEntityContainer.entityContainer:WaitForChild("Head")
    ChatService:Chat(messageSource, message, Enum.ChatColor.Blue)
    return true
end

return AnalyzeBloodSample
