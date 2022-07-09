local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local ChatService = game:GetService("Chat")	

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local SellItem = class("SellItem", Interact)

local one = "73FFAB39-5E88-4C1A-948A-62B2636D7D29"
local five = "55D9D0C4-C7CA-4581-9AF7-01FB726445C1"
local ten = "8D559DF3-FF04-4FAD-AA92-F7FE250C9265"
local oneHundred = "4C3FF4AC-09FE-4BEB-A5B6-870389EF55EF"

function SellItem:init()
    self.aiActionCost = 1
    self.name = "SellItem"
end

function SellItem:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = { "MoneyHandlingAI" },
        toolMatches = {"Cost"},
        objectMatches = {"Buyer"},
    }
end

function SellItem:spawnCash(cash, spawnLocation, interactionToolsProcessor)
    local dispensedCash = 0
    while dispensedCash ~= cash do
        local dispensedItem = one
        if dispensedCash + 100 <= cash then
            dispensedCash += 100
            dispensedItem = oneHundred
        elseif dispensedCash + 10 <= cash then
            dispensedCash += 10
            dispensedItem = ten
        elseif dispensedCash + 5 <= cash then
            dispensedCash += 5
            dispensedItem = five
        else
            dispensedCash += 1
        end

        interactionToolsProcessor:createItemByGuidWithComponents(dispensedItem, {Components.SpawnAt:new(spawnLocation)})
    end

end

function SellItem:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")

	local objectEntityContainer = object:getComponent("EntityContainer")
    local distanceToInstigator = instigatorEntityContainer.entityContainer:WaitForChild("Head").Position - objectEntityContainer.primaryPart.Position
    local spawnLocation = objectEntityContainer.primaryPart.Position + (distanceToInstigator/2)
    local toolCostComponent = tool:getComponent("Cost")
    self:spawnCash(toolCostComponent.cost, spawnLocation, interactionToolsProcessor)
    
    tool:add(Components.Debris:new(0))

    local toolName = tool:getComponent("EntityName").entityName
    ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Sells the " .. toolName .. " for " .. toolCostComponent.cost .. " weights.", Enum.ChatColor.Blue)

	return true
end

return SellItem
