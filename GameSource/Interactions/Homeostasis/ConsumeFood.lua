local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})
local ChatService = game:GetService("Chat")

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local Players = game:GetService("Players")
local CSF = Get("Lib/Events/ClientServerFacilitator")
local EventType = Get("Source/EventType")

local ConsumeFood = class("ConsumeFood", Interact)

function ConsumeFood:init()
    self.aiActionCost = 1
    self.name = "ConsumeFood"
end

function ConsumeFood:instigatorInteractsWithSelfUsingToolMatches()
    return {
        instigatorMatches = { "Character", "Hunger" },
		aiInstigatorRequires = { "DefaultAI" },
        toolMatches = {"Food/DeepFried", "-Poison"},
    }
end

function ConsumeFood:instigatorInteractsWithSelfUsingTool(instigator, tool, interactionToolsProcessor)
	local instigatorCharacterComponent = instigator:getComponent("Character")
	if instigatorCharacterComponent.character == nil then
		return false
	end
	local humanoid = instigatorCharacterComponent.character:WaitForChild("Humanoid")
	if humanoid == nil then
		return false
	end

	local instigatorHungerComponent = instigator:getComponent("Hunger")
	local toolFoodComponent = tool:getComponent("Food")
	if instigatorHungerComponent ~= nil and toolFoodComponent ~= nil then
		instigatorHungerComponent.currentHunger = math.min(instigatorHungerComponent.currentHunger + toolFoodComponent.hungerAmount, instigatorHungerComponent.maxHunger)
		local player = Players:GetPlayerFromCharacter(instigatorCharacterComponent.character)
		CSF:fireEvent(player, EventType.ToClient_UpdateHunger, instigatorHungerComponent.currentHunger / instigatorHungerComponent.maxHunger)
	end

	local toolEntityContainerComponent = tool:getComponent("EntityContainer")
	Get("Utility/AudioFaker"):playSoundAssetAtLocation(609587143, toolEntityContainerComponent.primaryPart.Position) -- Chew

    tool:add(Components.Debris:new(0))

	local instigatorEntityContainer = instigator:getComponent("EntityContainer")
	local toolName = tool:getComponent("EntityName").entityName
    ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Consumes the " .. toolName .. ".", Enum.ChatColor.Blue)

	return true
end

return ConsumeFood
