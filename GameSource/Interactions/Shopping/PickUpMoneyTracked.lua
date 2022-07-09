local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})
local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local PickUpMoneyTracked = class("PickUpMoneyTracked", Interact)

function PickUpMoneyTracked:init()
    self.aiActionCost = 1
    self.name = "PickUpMoneyTracked"
end

function PickUpMoneyTracked:instigatorInteractsWithObjectMatches()
    return {
        instigatorMatches = {"Character", "TrackedMoney"},
		aiInstigatorRequires = { "DefaultAI" },
        objectMatches = {"Tool", "Money"},
    }
end

function PickUpMoneyTracked:instigatorInteractsWithObject(instigator, object, interactionToolsProcessor)
	local instigatorTrackedMoneyComponent = instigator:getComponent("TrackedMoney")
	local objectMoneyComponent = object:getComponent("Money")
	instigatorTrackedMoneyComponent.currentMoney += objectMoneyComponent.value 

	local instigatorEntityContainer = instigator:getComponent("EntityContainer")
	ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Collects " .. objectMoneyComponent.value  .. " money.", Enum.ChatColor.Blue)
	
	object:add(Components.Debris())
	
	return true
end

return PickUpMoneyTracked