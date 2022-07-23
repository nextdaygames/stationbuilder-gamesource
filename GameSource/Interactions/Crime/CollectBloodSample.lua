local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})
local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local CollectBloodSample = class("CollectBloodSample", Interact)

function CollectBloodSample:init()
    self.aiActionCost = 1
    self.name = "CollectBloodSample"
end

function CollectBloodSample:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = { "Character" },
        aiInstigatorRequires = {},
        objectMatches = { "BloodDroplet" },
        toolMatches = { "BloodSampleContainer" },
    }
end

function CollectBloodSample:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)
	local toolBloodSampleComponent = tool:getComponent("BloodSampleContainer")
	local objectBloodDropletComponent = object:getComponent("BloodDroplet")

    toolBloodSampleComponent.hiddenBloodType = objectBloodDropletComponent.bloodType

    local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    local messageSource = instigatorEntityContainer.entityContainer:WaitForChild("Head")
    local toolName = tool:getComponent("EntityName").entityName
    local message = "Collects some blood using the " .. toolName .. "."
    ChatService:Chat(messageSource, message, Enum.ChatColor.Blue)

    return true
end


return CollectBloodSample
