local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

local AdministerBlood = class("AdministerBlood", Interact)

function AdministerBlood:init()
    self.aiActionCost = 1
    self.name = "AdministerBlood"
end

function AdministerBlood:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = { "MedicalAI" },
        objectMatches = {"Character", "Blood"},
		toolMatches = {"BloodRestock"}
    }
end

function AdministerBlood:administerBlood(bloodRestockEntity, receivingEntity)
	local bloodRestockComponent = bloodRestockEntity:getComponent("BloodRestock")
	local receivingEntityBloodComponent = receivingEntity:getComponent("Blood")
   
    local amountGiven = math.min(receivingEntityBloodComponent.maxBloodQuantity, receivingEntityBloodComponent.bloodQuantity + bloodRestockComponent.bloodQuantity)
    receivingEntityBloodComponent.bloodQuantity = amountGiven
    return true
end

function AdministerBlood:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)
    local isAdministerBloodSuccessful = self:administerBlood(tool, object)

    if not isAdministerBloodSuccessful then
        return false
    end

	local instigatorName = instigator:getComponent("EntityName").entityName
    local objectName = object:getComponent("EntityName").entityName
    local toolName = tool:getComponent("EntityName").entityName
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Administers " .. objectName .. " blood using the " .. toolName .. ".", Enum.ChatColor.Blue)

	return true
end

function AdministerBlood:instigatorInteractsWithSelfUsingToolMatches()
    return {
        instigatorMatches = {"Character", "Blood"},
        aiInstigatorRequires = { "MedicalAI" },
		toolMatches = {"BloodRestock"}
    }
end

function AdministerBlood:instigatorInteractsWithSelfUsingTool(instigator, tool, interactionToolsProcessor)
    local isAdministerBloodSuccessful = self:administerBlood(tool, instigator)

    if not isAdministerBloodSuccessful then
        return false
    end

	local instigatorName = instigator:getComponent("EntityName").entityName
    local toolName = tool:getComponent("EntityName").entityName
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Administers themselves blood using the " .. toolName .. ".", Enum.ChatColor.Blue)

	return true
end

return AdministerBlood
