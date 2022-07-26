local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})
local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

local PutOnClothing = class("PutOnClothing", Interact)

function PutOnClothing:init()
    self.aiActionCost = 1
    self.name = "PutOnClothing"
end

function PutOnClothing:instigatorInteractsWithObjectMatches()
    return {
        instigatorMatches = {"Character", "ClothingInventory"},
        aiInstigatorRequires = { },
        objectMatches = {"Clothing", "-Worn"},
    }
end

function PutOnClothing:getClothingSlot(entity)
    
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

function PutOnClothing:instigatorInteractsWithObject(instigator, object, interactionToolsProcessor)
	local instigatorEntityContainerComponent = instigator:getComponent("EntityContainer")
    local head = instigatorEntityContainerComponent.entityContainer:WaitForChild("Head")
	if head == nil then
		error("Missing head!")
	end
    
    local clothingSlot = self:getClothingSlot(object)
	if clothingSlot == nil then
        local objectEntityName = object:getComponent("EntityName").EntityName
        ChatService:Chat(head, "I don't know how to wear a " .. objectEntityName .. ".", Enum.ChatColor.Blue)
		return false
	end

    -- Try to reserve clothing slot
    local clothingInventoryComponent = instigator:getComponent("ClothingInventory")
    if clothingInventoryComponent.inventoryEntityIds[clothingSlot] ~= nil then
        ChatService:Chat(head, "I am already wearing a " .. clothingSlot .. ".", Enum.ChatColor.Blue)
        return false
    end
    clothingInventoryComponent.inventoryEntityIds[clothingSlot] = object.id

    
	local upperTorso = instigatorEntityContainerComponent.entityContainer:WaitForChild("UpperTorso")
	if upperTorso == nil then
		warn("Missing upper torso!")
        ChatService:Chat(head, "I cannot wear a " .. clothingSlot .. ".", Enum.ChatColor.Blue)
        return false
	end
	local lowerTorso = instigatorEntityContainerComponent.entityContainer:WaitForChild("LowerTorso")
	if lowerTorso == nil then
		warn("Missing lowerTorso!")
        ChatService:Chat(head, "I cannot wear a " .. clothingSlot .. ".", Enum.ChatColor.Blue)
        return false
	end

    local newCFrame = CFrame.new(head.Position)
	if clothingSlot == Enums.ClothingSlot.Mask then
		local facePosition = head.Position + (head.CFrame.LookVector * (head.Size.Z/2))
		newCFrame = (CFrame.new(facePosition, facePosition + head.CFrame.LookVector))
	elseif clothingSlot == Enums.ClothingSlot.Hat then
		local facePosition = head.Position + (head.CFrame.UpVector * (head.Size.Y/2))
		newCFrame = (CFrame.new(facePosition, facePosition + head.CFrame.LookVector))
	elseif clothingSlot == Enums.ClothingSlot.Backpack then
		local backPosition = upperTorso.Position - (upperTorso.CFrame.LookVector * (upperTorso.Size.Z/2))
		newCFrame = (CFrame.new(backPosition, backPosition - upperTorso.CFrame.LookVector))
	elseif clothingSlot == Enums.ClothingSlot.Shirt then
		newCFrame = (CFrame.new(upperTorso.Position, upperTorso.Position + upperTorso.CFrame.LookVector))
	elseif clothingSlot == Enums.ClothingSlot.Belt then
		local beltPosition = lowerTorso.Position + (lowerTorso.CFrame.LookVector * (lowerTorso.Size.Z/2))
		newCFrame = (CFrame.new(beltPosition, beltPosition + lowerTorso.CFrame.LookVector))
	end
    local objectEntityContainerComponent = object:getComponent("EntityContainer")
	objectEntityContainerComponent.primaryPart.CFrame = newCFrame 

	local weld = Instance.new("WeldConstraint", objectEntityContainerComponent.entityContainer)
	weld.Name = "BodyPartWeld"
	if clothingSlot == Enums.ClothingSlot.Mask or clothingSlot == Enums.ClothingSlot.Hat then
		weld.Part0 = head
	elseif clothingSlot == Enums.ClothingSlot.Backpack or clothingSlot == Enums.ClothingSlot.Shirt then
		weld.Part0 = upperTorso
	elseif clothingSlot == Enums.ClothingSlot.Belt then
		weld.Part0 = lowerTorso
	end
	weld.Part1 = objectEntityContainerComponent.entityContainer.PrimaryPart
	weld.Parent = objectEntityContainerComponent.entityContainer
	object:add(Components.Worn(instigator.id, weld))
    
    return true
end

return PutOnClothing
