local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local ChatService = game:GetService("Chat")

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local DownedByHealthSystem = class("DownedByHealthSystem", ECS.System)

function DownedByHealthSystem:initialize()
	ECS.System.initialize(self)
	self.name = "DownedByHealthSystem"
end

function DownedByHealthSystem:matchingGroups()
	return {
        ["DownableCharacters"] = { "Character", "Downable" }
    }
end

function DownedByHealthSystem:update(dt)
	for _, entity in pairs(self.entityGroups["DownableCharacters"]) do
        local characterComponent = entity:getComponent("Character")
		local downableComponent = entity:getComponent("Downable")
        
		if characterComponent.character == nil then
			downableComponent.dueToLowHealth = false
            continue
        end

		local humanoid = characterComponent.character:WaitForChild("Humanoid")
		if humanoid == nil then
			downableComponent.dueToLowHealth = false
			continue
		end

		downableComponent.dueToLowHealth =  humanoid.Health < 50
	end
end

return DownedByHealthSystem