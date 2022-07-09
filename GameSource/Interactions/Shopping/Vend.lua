local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local ChatService = game:GetService("Chat")	

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local Vend = class("Vend", Interact)

function Vend:init()
    self.aiActionCost = 1
    self.name = "Vend"
end

function Vend:instigatorInteractsWithObjectMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = { "MoneyHandlingAI" },
        objectMatches = {"VendingMachine"},
    }
end

function Vend:instigatorInteractsWithObject(instigator, object, interactionToolsProcessor)
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    local objectVendingMachineComponent = object:getComponent("VendingMachine")

    local vendedItemGuid = objectVendingMachineComponent.vendedItemGuid
    if vendedItemGuid == "" or vendedItemGuid == "missing" then
        return false
    end

    local objectName = object:getComponent("EntityName").entityName
    if objectVendingMachineComponent.startingItemCount ~= -1 and objectVendingMachineComponent.itemsLeft < 1 then
        ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "tries to vend at the " .. objectName .. " but it's empty.", Enum.ChatColor.Blue)
        return true
    end

    -- if objectVendingMachineComponent.currencyInsertedTotalValue == 0 then
    --     ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "tries to vend at the " .. objectName .. " but they haven't inserted enough money.", Enum.ChatColor.Blue)
    --     return true
    -- end  

	local objectEntityContainer = object:getComponent("EntityContainer")
    local distanceToInstigator = instigatorEntityContainer.entityContainer:WaitForChild("Head").Position - objectEntityContainer.primaryPart.Position
    local vendedItemSpawnLocation = objectEntityContainer.primaryPart.Position + (distanceToInstigator/2)
    local vendedComponents = {
        Components.SpawnAt:new(vendedItemSpawnLocation)
    }
    interactionToolsProcessor:createItemByGuidWithComponents(vendedItemGuid, vendedComponents)
    
    objectVendingMachineComponent.itemsLeft -= 1
    objectVendingMachineComponent.currencyInsertedTotalValue = 0

    local vendedItemInfo = interactionToolsProcessor:getItemByGuid(vendedItemGuid)
    local vendedItemName = vendedItemInfo:getComponent("EntityName").entityName
    ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Vends a " .. vendedItemName .. ".", Enum.ChatColor.Blue)

	return true
end

return Vend
