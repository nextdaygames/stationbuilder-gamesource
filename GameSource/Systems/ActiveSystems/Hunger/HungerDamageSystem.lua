local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local HungerDamageSystem = class("HungerDamageSystem", ECS.System)

function HungerDamageSystem:initialize()
	ECS.System.initialize(self)
	self.name = "HungerDamageSystem"
end

function HungerDamageSystem:matchingGroups()
	return {
        ["HungryPeople"] = { "OrganicHealth", "Character", "Hunger" }
    }
end

function HungerDamageSystem:update(dt)
	for _, entity in pairs(self.entityGroups["HungryPeople"]) do
        local characterComponent = entity:getComponent("Character")
        if characterComponent.character == nil then
            continue
        end

		local humanoid = characterComponent.character:FindFirstChild("Humanoid")
		if humanoid == nil then
			continue
		end

		if humanoid.Health <= 0 then
			continue
		end
        
		local hungerComponent = entity:getComponent("Hunger")
		if hungerComponent.currentHunger > 0 then
            continue
        end

        local currentTime = os.time()
        if currentTime < hungerComponent.lastHungerDamageTime + hungerComponent.hungryDamageSecondInterval then
            continue
        end
        hungerComponent.lastHungerDamageTime = currentTime

		local organicHealthComponent = entity:getComponent("OrganicHealth")
        organicHealthComponent.starvationDamage += hungerComponent.starvationDamageAmount
		humanoid.Health -= hungerComponent.starvationDamageAmount

        local entityContainer = entity:getComponent("EntityContainer")
		ChatService:Chat(entityContainer.primaryPart, "*rrrRRRR*", Enum.ChatColor.Red)
	end
end

return HungerDamageSystem