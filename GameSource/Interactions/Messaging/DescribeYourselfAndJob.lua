local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})
local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local DescribeYourselfAndJob = class("DescribeYourselfAndJob", Interact)

function DescribeYourselfAndJob:init()
    self.aiActionCost = 1
    self.name = "DescribeYourselfAndJob"
end

function DescribeYourselfAndJob:instigatorInteractsWithSelfMatches()
    return {
        instigatorMatches = {"Character", "Job"},
        aiInstigatorRequires = { "DefaultAI" },
    }
end

function DescribeYourselfAndJob:instigatorInteractsWithSelf(instigator, interactionToolsProcessor)
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")
	local jobComponent = instigator:getComponent("Job")
    ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "I'm " .. instigatorEntityContainer.entityContainer.Name .. ", the " .. jobComponent.jobName .. ".", Enum.ChatColor.Blue)
    return true
end


return DescribeYourselfAndJob
