local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))
local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

local HealOrganicDamage = class("HealOrganicDamage", Interact)

function HealOrganicDamage:init()
    self.aiActionCost = 1
    self.name = "HealOrganicDamage"
end

function HealOrganicDamage:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = { "MedicalAI" },
        objectMatches = {"Character", "OrganicHealth"},
		toolMatches = {"Heal"}
    }
end

function HealOrganicDamage:heal(healingEnitity, healedEntity)
	local healComponent = healingEnitity:getComponent("Heal")
	local characterComponent = healedEntity:getComponent("Character")
    if characterComponent.character == nil then
        warn("no character")
        return false
    end 

    local humanoid = characterComponent.character:WaitForChild("Humanoid")
	if humanoid == nil then
        warn("no humanoid")
		return false
	end
    if humanoid.Health == 100 then
        warn("max health")
        return false
    end

    local healedOrganicHealthComponent = healedEntity:getComponent("OrganicHealth")
    local kindOfDamage = healComponent.healType .. "Damage"
    local currentDamaged = healedOrganicHealthComponent[kindOfDamage]
    local amountHealed = math.min(healComponent.healAmount, currentDamaged)

    if amountHealed == 0 then
        warn("no amount to heal")
        return false
    end

    healedOrganicHealthComponent[kindOfDamage] -= amountHealed
    humanoid.Health = math.min(100, humanoid.Health + amountHealed)

    return true
end

function HealOrganicDamage:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)
    local isHealOrganicDamageSuccessful = self:heal(tool, object)

    if not isHealOrganicDamageSuccessful then
        return false
    end

	local instigatorName = instigator:getComponent("EntityName").entityName
    local objectName = object:getComponent("EntityName").entityName
    local toolName = tool:getComponent("EntityName").entityName
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Heals " .. objectName .. " using the " .. toolName .. ".", Enum.ChatColor.Blue)

	return true
end

function HealOrganicDamage:instigatorInteractsWithSelfUsingToolMatches()
    return {
        instigatorMatches = {"Character", "OrganicHealth"},
        aiInstigatorRequires = { "MedicalAI" },
		toolMatches = {"Heal"}
    }
end

function HealOrganicDamage:instigatorInteractsWithSelfUsingTool(instigator, tool, interactionToolsProcessor)
    local isHealOrganicDamageSuccessful = self:heal(tool, instigator)

    if not isHealOrganicDamageSuccessful then
        return false
    end

	local instigatorName = instigator:getComponent("EntityName").entityName
    local toolName = tool:getComponent("EntityName").entityName
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Heals themselves using the " .. toolName .. ".", Enum.ChatColor.Blue)

	return true
end

return HealOrganicDamage
