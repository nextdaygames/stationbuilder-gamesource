local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local ChatService = game:GetService("Chat")	

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local ScoreVend = class("ScoreVend", Interact)

function ScoreVend:init()
    self.aiActionCost = 1
    self.name = "ScoreVend"
end

function ScoreVend:instigatorInteractsWithObjectMatches()
    return {
        instigatorMatches = { "Character", "TrackedMoney" },
        aiInstigatorRequires = { "MoneyHandlingAI" },
        objectMatches = {"ScoreVendingMachine"},
    }
end

function ScoreVend:instigatorInteractsWithObject(instigator, object, interactionToolsProcessor)
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")
	local instigatorTrackedMoneyComponent = instigator:getComponent("TrackedMoney")
    local objectScoreVendingMachineComponent = object:getComponent("ScoreVendingMachine")

    local vendedItemGuid = objectScoreVendingMachineComponent.vendedItemGuid
    if vendedItemGuid == "" or vendedItemGuid == "missing" then
        return false
    end

    local objectName = object:getComponent("EntityName").entityName
    local missingMoney = objectScoreVendingMachineComponent.itemCost - instigatorTrackedMoneyComponent.currentMoney
    if missingMoney > 0 then 
        ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Cannot afford a " .. objectName .. ". Missing " .. missingMoney, Enum.ChatColor.Blue)
        return true
    end
    instigatorTrackedMoneyComponent.currentMoney -= objectScoreVendingMachineComponent.itemCost 

	local objectEntityContainer = object:getComponent("EntityContainer")
    local distanceToInstigator = instigatorEntityContainer.entityContainer:WaitForChild("Head").Position - objectEntityContainer.primaryPart.Position
    local vendedItemSpawnLocation = objectEntityContainer.primaryPart.Position + (distanceToInstigator/2)
    local vendedComponents = {
        Components.SpawnAt:new(vendedItemSpawnLocation)
    }
    interactionToolsProcessor:createItemByItemGuidWithComponents(vendedItemGuid, vendedComponents)

    local vendedItemInfo = interactionToolsProcessor:getItemEntityForItemGuid(vendedItemGuid)
    local vendedItemName = vendedItemInfo:getComponent("EntityName").entityName
    ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Buys a " .. vendedItemName .. ".", Enum.ChatColor.Blue)

	return true
end

return ScoreVend
