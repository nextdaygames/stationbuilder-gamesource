local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})
local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local RestockVendingMachine = class("Vend", Interact)

function RestockVendingMachine:init()
    self.aiActionCost = 1
    self.name = "RestockVendingMachine"
end

function RestockVendingMachine:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = { "MoneyHandlingAI" },
        objectMatches = {"VendingMachine"},
        toolMatches = {"VendingRestockCartridge"}
    }
end

function RestockVendingMachine:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)
	local objectVendingMachineComponent = object:getComponent("VendingMachine")
	local toolVendingRestockCartridgeComponent = tool:getComponent("VendingRestockCartridge")
    
    if toolVendingRestockCartridgeComponent.vendCategory ~= objectVendingMachineComponent.vendCategory then
        return false
    end
	
    objectVendingMachineComponent.itemsLeft = objectVendingMachineComponent.startingItemCount 
    
    local instigatorName = instigator:getComponent("EntityName").entityName
    local objectName = object:getComponent("EntityName").entityName
    local toolName = tool:getComponent("EntityName").entityName
    local instigatorEntityContainerComponent = instigator:getComponent("EntityContainer")
    ChatService:Chat(instigatorEntityContainerComponent.entityContainer:WaitForChild("Head"), "Restocks the " .. objectName .. " with the " .. toolName .. ".", Enum.ChatColor.Blue)

	tool:add(Components.Debris:new(0))

	return true
end

return RestockVendingMachine
