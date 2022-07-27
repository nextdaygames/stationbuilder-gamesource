local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})
local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local MoldItem = class("MoldItem", Interact)

function MoldItem:init()
    self.aiActionCost = 1
    self.name = "MoldItem"
end

function MoldItem:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = {},
        objectMatches = {"Mold"},
        toolMatches = {"OreBar"},
    }
end

function MoldItem:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)
    local moldComponent = object:getComponent("Mold")
    if moldComponent.craftedItemGuid == "" or moldComponent.craftedItemGuid == "missing" then
        return false
    end

    local moldedItemInfo = interactionToolsProcessor:getItemEntityForItemGuid(moldComponent.craftedItemGuid)
    if moldedItemInfo == nil then
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
    interactionToolsProcessor:createItemByItemGuidWithComponents(moldComponent.craftedItemGuid, components)  
    
    local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    local messageSource = instigatorEntityContainer.entityContainer:WaitForChild("Head")
    local message = "Molded item."
    ChatService:Chat(messageSource, message, Enum.ChatColor.Blue)
	return false
end


return MoldItem
