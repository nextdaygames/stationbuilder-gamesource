local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

local DamageNonHuman = class("DamageNonHuman", Interact)

function DamageNonHuman:init()
    self.aiActionCost = 1
    self.name = "DamageNonHuman"
end

function DamageNonHuman:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = { "ViolentAI" },
        objectMatches = {"Integrity"},
		toolMatches = {"Damage"}
    }
end

function DamageNonHuman:damageNonHuman(damagingEntity, damagedEntity)
	local damageComponent = damagingEntity:getComponent("Damage")
	local integrityComponent = damagedEntity:getComponent("Integrity")
	integrityComponent.currentIntegrity = math.max(0, integrityComponent.currentIntegrity - damageComponent.damage)
end

function DamageNonHuman:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)
    self:damageNonHuman(tool, object)

	local instigatorName = instigator:getComponent("EntityName").entityName
    local objectName = object:getComponent("EntityName").entityName
    local toolName = tool:getComponent("EntityName").entityName
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")

    if not tool:getComponent("Gun") then
        ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Damages the " .. objectName .. " using the " .. toolName .. ".", Enum.ChatColor.Blue)
    end

	return true
end

function DamageNonHuman:instigatorInteractsWithSelfUsingToolMatches()
    return {
        instigatorMatches = {"Integrity"},
        aiInstigatorRequires = { "ViolentAI" },
		toolMatches = {"Damage"}
    }
end

function DamageNonHuman:instigatorInteractsWithSelfUsingTool(instigator, tool, interactionToolsProcessor)
    self:damageNonHuman(tool, instigator)

	local instigatorName = instigator:getComponent("EntityName").entityName
    local toolName = tool:getComponent("EntityName").entityName
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")

    if not tool:getComponent("Gun") then
        ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Damages themselves using the " .. toolName .. ".", Enum.ChatColor.Red)
    end
	return true
end

return DamageNonHuman
