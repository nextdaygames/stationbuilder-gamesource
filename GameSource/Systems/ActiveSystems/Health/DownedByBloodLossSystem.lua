local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local ChatService = game:GetService("Chat")

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local DownedByBloodLossSystem = class("DownedByBloodLossSystem", ECS.System)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

function DownedByBloodLossSystem:initialize()
	ECS.System.initialize(self)
	self.name = "DownedByBloodLossSystem"
end

function DownedByBloodLossSystem:matchingGroups()
	return {
        ["DownableCharacters"] = { "Character", "Blood", "Downable" },
    }
end

function DownedByBloodLossSystem:update(dt)
	for _, entity in pairs(self.entityGroups["DownableCharacters"]) do
        local characterComponent = entity:getComponent("Character")
		local downableComponent = entity:getComponent("Downable")

        if characterComponent.character == nil then
			downableComponent.dueToBloodLoss = false
            continue
        end

		local bloodComponent = entity:getComponent("Blood")
		downableComponent.dueToBloodLoss =  bloodComponent.bloodQuantity / bloodComponent.maxBloodQuantity < 0.25
	end
end

return DownedByBloodLossSystem