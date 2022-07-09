local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local HungrySystem = class("HungrySystem", ECS.System)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

function HungrySystem:initialize()
	ECS.System.initialize(self)
	self.name = "HungrySystem"
end

function HungrySystem:matchingGroups()
	return {
        ["HungerEntities"] = { "Hunger" }
    }
end

function HungrySystem:update(dt)
	for _, entity in pairs(self.entityGroups["HungerEntities"]) do
        
		local hungerComponent = entity:getComponent("Hunger")
		local hungryComponent = entity:getComponent("Hungry")
		local hungerRatio = hungerComponent.currentHunger / hungerComponent.maxHunger

		if hungerRatio > 0.25 then
            if hungerComponent ~= nil then
				entity:removeComponent("Hungry")
			end
        else
			if hungryComponent == nil then
				local entityContainer = entity:getComponent("EntityContainer")
				ChatService:Chat(entityContainer.primaryPart, "I'm hungry.", Enum.ChatColor.Red)
				entity:add(Components.Hungry:new())
			end
		end
	end
end

return HungrySystem