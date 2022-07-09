local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))
local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

local Repair = class("Repair", Interact)

function Repair:init()
    self.aiActionCost = 1
    self.name = "Repair"
end

function Repair:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = { "MedicalAI" },
        objectMatches = {"Integrity"},
		toolMatches = {"Repair"}
    }
end

function Repair:repair(repairingEntity, repairedEntity)
	local repairComponent = repairingEntity:getComponent("Repair")
	local integrityComponent = repairedEntity:getComponent("Integrity")
	integrityComponent.currentIntegrity = math.min(integrityComponent.totalIntegrity, integrityComponent.currentIntegrity + repairComponent.repairAmount)
end

function Repair:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)
    self:repair(tool, object)

	local instigatorName = instigator:getComponent("EntityName").entityName
    local objectName = object:getComponent("EntityName").entityName
    local toolName = tool:getComponent("EntityName").entityName
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Repairs the " .. objectName .. " using the " .. toolName .. ".", Enum.ChatColor.Blue)

	return true
end

function Repair:instigatorInteractsWithSelfUsingToolMatches()
    return {
        instigatorMatches = {"Character", "Integrity"},
        aiInstigatorRequires = { "MedicalAI" },
		toolMatches = {"Repair"}
    }
end

function Repair:instigatorInteractsWithSelfUsingTool(instigator, tool, interactionToolsProcessor)
    self:repair(tool, instigator)

	local instigatorName = instigator:getComponent("EntityName").entityName
    local toolName = tool:getComponent("EntityName").entityName
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Repairs themselves using the " .. toolName .. ".", Enum.ChatColor.Blue)

	return true
end

return Repair
