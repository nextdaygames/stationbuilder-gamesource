local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local ChatService = game:GetService("Chat")	
local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local DamageCharacter = class("DamageCharacter", Interact)

function DamageCharacter:init()
    self.aiActionCost = 1
    self.name = "DamageCharacter"
end

function DamageCharacter:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = { "ViolentAI" },
        objectMatches = {"Character"},
        toolMatches = {"Damage"},
    }
end

function DamageCharacter:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)

    local damageComponent = tool:getComponent("Damage")
    local characterComponent = object:getComponent("Character")
	if characterComponent.character == nil then
		return false
	end
	local humanoid = characterComponent.character:WaitForChild("Humanoid")
	if humanoid == nil then
		return false
	end
    humanoid:TakeDamage(damageComponent.damage)

    local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    local instigatorName = instigator:getComponent("EntityName").entityName
	local objectName = object:getComponent("EntityName").entityName
    local toolName = tool:getComponent("EntityName").entityName

    local sharpTool = tool:getComponent("Sharp")
    local objectWoundTracker = object:getComponent("WoundTracker")
    if sharpTool ~= nil and objectWoundTracker ~= nil  then
        print("Added", toolName .. " Wound")
        table.insert(objectWoundTracker.wounds, { name = toolName .. " Wound", damage = damageComponent.damage})
        self:createBloodDroplet(interactionToolsProcessor, object)
    end

    local objectOrganicHealth = object:getComponent("OrganicHealth")
    if objectOrganicHealth ~= nil then
        objectOrganicHealth.bruteDamage += damageComponent.damage
    end

    if not tool:getComponent("Gun") then
        ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "hurts " .. objectName .. " with the " .. toolName .. ".", Enum.ChatColor.Blue)
    end
	return true
end

function DamageCharacter:instigatorInteractsWithSelfUsingToolMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = { "ViolentAI" },
        toolMatches = {"Damage"},
    }
end

function DamageCharacter:instigatorInteractsWithSelfUsingTool(instigator, tool, interactionToolsProcessor)

    local damageComponent = tool:getComponent("Damage")
    local characterComponent = instigator:getComponent("Character")
	if characterComponent.character == nil then
		return false
	end
	local humanoid = characterComponent.character:WaitForChild("Humanoid")
	if humanoid == nil then
		return false
	end
    humanoid:TakeDamage(damageComponent.damage)

    local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    local toolName = tool:getComponent("EntityName").entityName

    local sharpTool = tool:getComponent("Sharp")
    local instigatorWoundTracker = instigator:getComponent("WoundTracker")
    if sharpTool ~= nil and instigatorWoundTracker ~= nil  then
        print("Added", toolName .. " Wound")
        table.insert(instigatorWoundTracker.wounds, { name = toolName .. " Wound", damage = damageComponent.damage})
        self:createBloodDroplet(interactionToolsProcessor, instigator)
    end

    local instigatorOrganicHealth = instigator:getComponent("OrganicHealth")
    if instigatorOrganicHealth ~= nil then
        instigatorOrganicHealth.bruteDamage += damageComponent.damage
    end
    
    if not tool:getComponent("Gun") then
        ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Hurts themselves with the " .. toolName .. ".", Enum.ChatColor.Red)
    end

	return true
end

function DamageCharacter:createBloodDroplet(interactionToolsProcessor, person)
    local personEntityContainerComponent = person:getComponent("EntityContainer")
    local personBloodComponent = person:getComponent("Blood")

    local spawnPosition = personEntityContainerComponent.entityContainer:WaitForChild("Head").Position

    local components = {
        Components.SpawnAt(spawnPosition),
    }
    if personBloodComponent ~= nil then
        table.insert(components, Components.BloodDroplet(personBloodComponent.bloodType))
    end
    interactionToolsProcessor:createItemByItemGuidWithComponents("675471CE-F5BD-4F27-9207-696F44F30C05", components)
end

return DamageCharacter
