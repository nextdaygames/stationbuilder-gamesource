local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local Players = game:GetService("Players")

local CSF = Get("Lib/Events/ClientServerFacilitator")
local EventType = Get("Source/EventType")

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")

local HungerDrainSystem = class("HungerDrainSystem", ECS.System)

function HungerDrainSystem:initialize()
	ECS.System.initialize(self)
	self.name = "HungerDrainSystem"
end

function HungerDrainSystem:matchingGroups()
	return {
        ["HungryPeople"] = { "Character", "Hunger" }
    }
end

function HungerDrainSystem:update(dt)
	for _, entity in pairs(self.entityGroups["HungryPeople"]) do
        local characterComponent = entity:getComponent("Character")
        if characterComponent.character == nil then
            continue
        end
        
		local hungerComponent = entity:getComponent("Hunger")
		if hungerComponent.currentHunger <= 0 then
            continue
        end

        local currentTime = os.time()
        if currentTime < hungerComponent.lastHungerDrainTime + hungerComponent.hungerDrainSecondInterval then
            continue
        end
		hungerComponent.lastHungerDrainTime = currentTime
		hungerComponent.currentHunger -= hungerComponent.hungerDrainAmount

        local player = Players:GetPlayerFromCharacter(characterComponent.character)
        if player ~= nil then
            CSF:fireEvent(player, EventType.ToClient_UpdateHunger, hungerComponent.currentHunger / hungerComponent.maxHunger)
        end
	end
end

return HungerDrainSystem