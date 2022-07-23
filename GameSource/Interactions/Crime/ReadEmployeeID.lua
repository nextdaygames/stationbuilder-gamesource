local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})
local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local ReadEmployeeId = class("ReadEmployeeId", Interact)

function ReadEmployeeId:init()
    self.aiActionCost = 1
    self.name = "ReadEmployeeId"
end

function ReadEmployeeId:instigatorInteractsWithSelfUsingToolMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = {},
        toolMatches = {"TopLevelTool", "EmployeeId"},
    }
end

function ReadEmployeeId:instigatorInteractsWithSelfUsingTool(instigator, tool, interactionToolsProcessor)
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")

	local jobComponent = instigator:getComponent("Job")
	local bloodComponent = instigator:getComponent("Blood")
    local playerControlledComponent = instigator:getComponent("PlayerControlled")

    local messageSource = instigatorEntityContainer.entityContainer:WaitForChild("Head")
    local message = "I'm " .. instigatorEntityContainer.entityContainer.Name .. ". "

    if playerControlledComponent ~= nil then
        message = message .. "Employee #".. playerControlledComponent.player.UserId .. ". "
    end

    if jobComponent ~= nil then
        message = message .. "I'm a ".. jobComponent.jobName .. ". "
    end

    if bloodComponent ~= nil then
        message = message .. "Blood Type ".. bloodComponent.bloodType .. ". "
    end

    ChatService:Chat(messageSource, message, Enum.ChatColor.Blue)
    return true
end

return ReadEmployeeId
