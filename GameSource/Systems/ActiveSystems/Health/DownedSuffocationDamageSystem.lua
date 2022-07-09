local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local DownedSuffocationDamageSystem = class("DownedSuffocationDamageSystem", ECS.System)

function DownedSuffocationDamageSystem:initialize()
	ECS.System.initialize(self)
	self.name = "DownedSuffocationDamageSystem"
end

function DownedSuffocationDamageSystem:matchingGroups()
	return {
        ["SuffocatingCharacters"] = { "Character", "Downed", "OrganicHealth","-Epinephrine" }
    }
end

function DownedSuffocationDamageSystem:update(dt)
	for _, entity in pairs(self.entityGroups["SuffocatingCharacters"]) do
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

		local downedComponent = entity:getComponent("Downed")

		local currentTime = os.time()
        if currentTime < downedComponent.lastSuffocationDamageTime + downedComponent.suffocationDamageSecondInterval then
            continue
        end
		downedComponent.lastSuffocationDamageTime = currentTime

		local organicHealthComponent = entity:getComponent("OrganicHealth")
        organicHealthComponent.suffocationDamage += downedComponent.suffocationDamageAmount
		humanoid.Health -= downedComponent.suffocationDamageAmount

		local entityContainer = entity:getComponent("EntityContainer")
		ChatService:Chat(entityContainer.primaryPart, "*GASP*", Enum.ChatColor.Red)
	end
end

return DownedSuffocationDamageSystem