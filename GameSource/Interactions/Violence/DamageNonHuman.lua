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
    self.isDisabled = true
end

function DamageNonHuman:getDistance(here,there)
    return math.sqrt(math.pow(there.x - here.x, 2) + math.pow(there.y - here.y, 2) + math.pow(there.z - here.z, 2))
end

function DamageNonHuman:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = { "ViolentAI" },
        objectMatches = {"-Clothing", "Integrity"},
		toolMatches = {"Damage", "-Gun"}
    }
end

function DamageNonHuman:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)
    
    -- Calculate distance falloff
    local damageComponent = tool:getComponent("Damage")
    local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    local toolEntityContainerComponent = tool:getComponent("EntityContainer")
    local distance = self:getDistance(instigatorEntityContainer.primaryPart.Position, toolEntityContainerComponent.primaryPart.Position)
    local minDistance = 5
    local maxDistance = 30
    local damage = damageComponent.damage
    if distance >= maxDistance then
        return false
    end
    if distance > minDistance then
        local rangeDistance = distance - minDistance
        local rangeMaxDistance = maxDistance - minDistance
        damage = damage * (rangeDistance/rangeMaxDistance)
    end

    local integrityComponent = object:getComponent("Integrity")
	integrityComponent.currentIntegrity = math.max(0, integrityComponent.currentIntegrity - damage)

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
		toolMatches = {"-Gun","Damage"}
    }
end

function DamageNonHuman:instigatorInteractsWithSelfUsingTool(instigator, tool, interactionToolsProcessor)
    
    local integrityComponent = instigator:getComponent("Integrity")
    local damageComponent = tool:getComponent("Damage")
	integrityComponent.currentIntegrity = math.max(0, integrityComponent.currentIntegrity - damageComponent.damage)

	local instigatorName = instigator:getComponent("EntityName").entityName
    local toolName = tool:getComponent("EntityName").entityName
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")

    if not tool:getComponent("Gun") then
        ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Damages themselves using the " .. toolName .. ".", Enum.ChatColor.Red)
    end
	return true
end

return DamageNonHuman
