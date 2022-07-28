local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

local DamageClothingsWearer = class("DamageClothingsWearer", Interact)

function DamageClothingsWearer:init()
    self.aiActionCost = 1
    self.name = "DamageClothingsWearer"
    self.isDisabled = true
end

function DamageClothingsWearer:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = { "ViolentAI" },
        objectMatches = {"Clothing", "Worn"},
		toolMatches = {"Damage"}
    }
end

function DamageClothingsWearer:getDistance(here,there)
    return math.sqrt(math.pow(there.x - here.x, 2) + math.pow(there.y - here.y, 2) + math.pow(there.z - here.z, 2))
end

function DamageClothingsWearer:instigatorInteractsWithObjectUsingTool(wornByEntity, object, tool, interactionToolsProcessor)
    
    -- Calculate distance falloff
    local damageComponent = tool:getComponent("Damage")
    local wornByEntityEntityContainer = wornByEntity:getComponent("EntityContainer")
    local toolEntityContainerComponent = tool:getComponent("EntityContainer")
    local distance = self:getDistance(wornByEntityEntityContainer.primaryPart.Position, toolEntityContainerComponent.primaryPart.Position)
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

    local wornComponent = object:getComponent("Worn")
	
    local characterComponent = wornComponent.wornByEntity:getComponent("Character")
	if characterComponent.character == nil then
		return false
	end
	local humanoid = characterComponent.character:WaitForChild("Humanoid")
	if humanoid == nil then
		return false
	end
    humanoid:TakeDamage(damage)

    local toolName = tool:getComponent("EntityName").entityName

    local sharpTool = tool:getComponent("Sharp")
    local wornByEntityWoundTracker = wornComponent.wornByEntity:getComponent("WoundTracker")
    if sharpTool ~= nil and wornByEntityWoundTracker ~= nil  then
        print("Added", toolName .. " Wound")
        table.insert(wornByEntityWoundTracker.wounds, { name = toolName .. " Wound", damage = damage})
        self:createBloodDroplet(interactionToolsProcessor, wornComponent.wornByEntity)
    end

    local wornByEntityOrganicHealth = wornComponent.wornByEntity:getComponent("OrganicHealth")
    if wornByEntityOrganicHealth ~= nil then
        wornByEntityOrganicHealth.bruteDamage += damage
    end

	local wornByEntityName = wornComponent.wornByEntity:getComponent("EntityName").entityName
    local objectName = object:getComponent("EntityName").entityName
    local toolName = tool:getComponent("EntityName").entityName
	local wornByEntityEntityContainer = wornComponent.wornByEntity:getComponent("EntityContainer")

    if not tool:getComponent("Gun") then
        ChatService:Chat(wornByEntityEntityContainer.entityContainer:WaitForChild("Head"), "Damages " .. wornByEntityName .. " using the " .. toolName .. ".", Enum.ChatColor.Blue)
    end

	return true
end


return DamageClothingsWearer
