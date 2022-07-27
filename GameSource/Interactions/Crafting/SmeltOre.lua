local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})
local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local SmeltOre = class("SmeltOre", Interact)

function SmeltOre:init()
    self.aiActionCost = 1
    self.name = "SmeltOre"
end

function SmeltOre:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = {},
        objectMatches = {"Furnace"},
        toolMatches = {"Ore"},
    }
end

function SmeltOre:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)

    local oreComponent = tool:getComponent("Ore")
    if oreComponent.oreBarItemGuid == "" or oreComponent.oreBarItemGuid == "missing" then
        return false
    end

    local orebarItemInfo = interactionToolsProcessor:getItemEntityForItemGuid(oreComponent.oreBarItemGuid)
    if orebarItemInfo == nil then
        return false
    end

    local instigatorEntityContainer = instigator:getComponent("EntityContainer")
	local objectEntityContainer = object:getComponent("EntityContainer")
    local distanceToInstigator = instigatorEntityContainer.entityContainer:WaitForChild("Head").Position - objectEntityContainer.primaryPart.Position
    local itemSpawnLocation = objectEntityContainer.primaryPart.Position + (distanceToInstigator/2)
    local components = {
        Components.SpawnAt:new(itemSpawnLocation)
    }

    -- Delete the current item to create a new one
    tool:add(Components.Debris:new(0))
    interactionToolsProcessor:createItemByItemGuidWithComponents(oreComponent.oreBarItemGuid, components)  

    local messageSource = instigatorEntityContainer.entityContainer:WaitForChild("Head")
    local message = "Smelted ore."
    ChatService:Chat(messageSource, message, Enum.ChatColor.Blue)

	return true
end


return SmeltOre
