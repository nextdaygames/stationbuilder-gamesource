local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))
local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

local Heal = class("Heal", Interact)

function Heal:init()
    self.aiActionCost = 1
    self.name = "Heal"
end

function Heal:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = { "MedicalAI" },
        objectMatches = {"Character", "-OrganicHealth"},
		toolMatches = {"Heal"}
    }
end

function Heal:heal(healingEntity, healedEntity)
	local healComponent = healingEntity:getComponent("Heal")
	local characterComponent = healedEntity:getComponent("Character")
    if characterComponent.character == nil then
        return false
    end 

    local humanoid = characterComponent.character:WaitForChild("Humanoid")
	if humanoid == nil then
		return false
	end
    if humanoid.Health == 100 then
        return false
    end
    humanoid.Health = math.min(100, humanoid.Health + healComponent.healAmount)
    return true
end

function Heal:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)
    local isHealSuccessful = self:heal(tool, object)

    if not isHealSuccessful then
        return false
    end

	local instigatorName = instigator:getComponent("EntityName").entityName
    local objectName = object:getComponent("EntityName").entityName
    local toolName = tool:getComponent("EntityName").entityName
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Heals " .. objectName .. " using the " .. toolName .. ".", Enum.ChatColor.Blue)

	return true
end

function Heal:instigatorInteractsWithSelfUsingToolMatches()
    return {
        instigatorMatches = {"Character", "-OrganicHealth"},
        aiInstigatorRequires = { "MedicalAI" },
		toolMatches = {"Heal"}
    }
end

function Heal:instigatorInteractsWithSelfUsingTool(instigator, tool, interactionToolsProcessor)
    local isHealSuccessful = self:heal(tool, instigator)

    if not isHealSuccessful then
        return false
    end

	local instigatorName = instigator:getComponent("EntityName").entityName
    local toolName = tool:getComponent("EntityName").entityName
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Heals themselves using the " .. toolName .. ".", Enum.ChatColor.Blue)

	return true
end

return Heal
