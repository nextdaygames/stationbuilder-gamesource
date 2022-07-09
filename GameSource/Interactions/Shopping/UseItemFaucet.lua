local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))
local Split = Get("Split", Utility)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local UseItemFaucet = class("UseItemFaucet", Interact)

function UseItemFaucet:init()
    self.aiActionCost = 1
    self.name = "UseItemFaucet"
end

function UseItemFaucet:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = { "MoneyHandlingAI" },
        objectMatches = {"ItemFaucet"},
        toolMatches = {},
    }
end

function UseItemFaucet:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)
	
    local objectItemFaucetComponent = object:getComponent("ItemFaucet")
    local itemGuid = objectItemFaucetComponent.itemGuid

    if itemGuid == "" or itemGuid == "missing" then
        return false
    end

    local components = Split(objectItemFaucetComponent.toolHasFeaturesString, " ")
    if not tool:matchesComponents(components) then
        print("Failed to match", tool, components)
        return false
    end

    local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    local objectEntityContainer = object:getComponent("EntityContainer")
    local distanceToInstigator = instigatorEntityContainer.entityContainer:WaitForChild("Head").Position - objectEntityContainer.primaryPart.Position
    local vendedItemSpawnLocation = objectEntityContainer.primaryPart.Position + (distanceToInstigator/2)
    local vendedComponents = {
        Components.SpawnAt:new(vendedItemSpawnLocation)
    }
    interactionToolsProcessor:createItemByGuidWithComponents(itemGuid, vendedComponents)

    local instigatorName = instigator:getComponent("EntityName").entityName
	local objectName = object:getComponent("EntityName").entityName
    local toolName = tool:getComponent("EntityName").entityName
    ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Uses the " .. toolName .. " on the " .. objectName .. ".", Enum.ChatColor.Blue)

    return true
end

return UseItemFaucet
