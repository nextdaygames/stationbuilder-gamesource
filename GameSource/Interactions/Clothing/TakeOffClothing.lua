local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})
local ChatService = game:GetService("Chat")	

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local TakeOffClothing = class("TakeOffClothing", Interact)

function TakeOffClothing:init()
    self.aiActionCost = 1
    self.name = "TakeOffClothing"
end

function TakeOffClothing:instigatorInteractsWithObjectMatches()
    return {
        instigatorMatches = {"Character", "ClothingInventory"},
        aiInstigatorRequires = { },
        objectMatches = {"Clothing", "Worn"},
    }
end

function TakeOffClothing:getClothingSlot(entity)
    
    if entity:matchesComponents({"Hat"}) then
        return Enums.ClothingSlot.Hat
    elseif entity:matchesComponents({"Mask"}) then
        return Enums.ClothingSlot.Mask
    elseif entity:matchesComponents({"Backpack"}) then
        return Enums.ClothingSlot.Backpack
    elseif entity:matchesComponents({"Shirt"}) then
        return Enums.ClothingSlot.Shirt
    elseif entity:matchesComponents({"Belt"}) then
        return Enums.ClothingSlot.Belt
    else
        return nil
    end
end

function TakeOffClothing:instigatorInteractsWithObject(instigator, object, interactionToolsProcessor)
    local clothingSlot = self:getClothingSlot(object)
	if clothingSlot == nil then
		return false
	end

    local objectWornComponent = object:getComponent("Worn")
    if objectWornComponent.wornByEntity.id ~= instigator.id then
        return false
    end

    objectWornComponent.weldToCharacter.Parent = nil
    object:removeComponent("Worn")

    local objectEntityContainerComponent = object:getComponent("EntityContainer")
    objectEntityContainerComponent.entityContainer.Parent = workspace

    local displacement = Vector3.new(0,2,0)
    local newCframe = CFrame.new(objectEntityContainerComponent.primaryPart.CFrame.Position + displacement, objectEntityContainerComponent.primaryPart.CFrame.LookVector + displacement)
    objectEntityContainerComponent.primaryPart.CFrame = newCframe

    local clothingInventoryComponent = instigator:getComponent("ClothingInventory")
    clothingInventoryComponent.inventoryEntityIds[clothingSlot] = nil

	return true
end

return TakeOffClothing
