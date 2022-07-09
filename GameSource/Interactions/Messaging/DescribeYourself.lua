local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})
local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local DescribeYourself = class("DescribeYourself", Interact)

function DescribeYourself:init()
    self.aiActionCost = 1
    self.name = "DescribeYourself"
end

function DescribeYourself:instigatorInteractsWithSelfMatches()
    return {
        instigatorMatches = {"Character", "-Job"},
        aiInstigatorRequires = { "DefaultAI" },
    }
end

function DescribeYourself:instigatorInteractsWithSelf(instigator, interactionToolsProcessor)
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    local message = "I'm " .. instigatorEntityContainer.entityContainer.Name .. "."
    local messageSource = instigatorEntityContainer.entityContainer:WaitForChild("Head")
    ChatService:Chat(messageSource, message, Enum.ChatColor.Blue)
    return true
end


return DescribeYourself
