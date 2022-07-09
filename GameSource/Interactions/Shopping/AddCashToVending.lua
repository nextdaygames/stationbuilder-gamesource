local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local ChatService = game:GetService("Chat")	

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local AddCashToVending = class("AddCashToVending", Interact)

function AddCashToVending:init()
    self.aiActionCost = 1
    self.name = "AddCashToVending"
end

function AddCashToVending:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = { "MoneyHandlingAI" },
        objectMatches = {"VendingMachine"},
        toolMatches = {"Money"},
    }
end

function AddCashToVending:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    local objectVendingMachineComponent = object:getComponent("VendingMachine")
    local toolMoneyComponent = tool:getComponent("Money")

    objectVendingMachineComponent.currencyInsertedTotalValue = objectVendingMachineComponent.currencyInsertedTotalValue + toolMoneyComponent.value
    tool:add(Components.Debris:new(0))

	local instigatorName = instigator:getComponent("EntityName").entityName
    local objectName = object:getComponent("EntityName").entityName
    local toolName = tool:getComponent("EntityName").entityName
    ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Inserts the " .. toolName .. " into the " .. objectName .. " for a total of " .. objectVendingMachineComponent.currencyInsertedTotalValue .. ".", Enum.ChatColor.Blue)

	return true
end

return AddCashToVending
