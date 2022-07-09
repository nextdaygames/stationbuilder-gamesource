local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})
local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local Poison = class("Poison", Interact)

function Poison:init()
    self.aiActionCost = 1
    self.name = "Poison"
end

function Poison:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = { "Character" },
        aiInstigatorRequires = { "ViolentAI" },
        objectMatches = {"Food/DeepFried", "-Poison" },
        toolMatches = { "Poison" },
    }
end

function Poison:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)

    local toolName = tool:getComponent("EntityName").entityName
    local objectName = object:getComponent("EntityName").entityName
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Poisons the " .. objectName .. " with the " .. toolName .. ".", Enum.ChatColor.Blue)

    object:add(Components.Poison:new())
    tool:add(Components.Debris:new(0))

	return true
end

function Poison:instigatorInteractsWithSelfUsingToolMatches()
    return {
        instigatorMatches = { "OrganicHealth", "Character" },
        aiInstigatorRequires = { "ViolentAI" },
        toolMatches = { "Poison" },
    }
end

function Poison:instigatorInteractsWithSelfUsingTool(instigator, tool, interactionToolsProcessor)
    local instigatorCharacterComponent = instigator:getComponent("Character")
	if instigatorCharacterComponent.character == nil then
		return false
	end
	local humanoid = instigatorCharacterComponent.character:WaitForChild("Humanoid")
	if humanoid == nil then
		return false
	end
    local instigatorOrganicHealthComponent = instigator:getComponent("OrganicHealth")

    instigatorOrganicHealthComponent.toxicDamage += 51
    humanoid.Health -= 51

    local toolName = tool:getComponent("EntityName").entityName
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Poisons themselves with the " .. toolName .. ".", Enum.ChatColor.Blue)
    tool:add(Components.Debris:new(0))

	return true
end

return Poison
