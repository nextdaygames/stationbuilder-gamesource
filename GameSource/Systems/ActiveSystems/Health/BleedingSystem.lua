local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local ChatService = game:GetService("Chat")

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local BleedingSystem = class("BleedingSystem", ECS.System)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

function BleedingSystem:initialize()
	ECS.System.initialize(self)
	self.name = "BleedingSystem"
end

function BleedingSystem:matchingGroups()
	return {
        ["BleedingCharacters"] = { "Character", "Blood", "WoundTracker" },
    }
end

function BleedingSystem:update(dt)
	for _, entity in pairs(self.entityGroups["BleedingCharacters"]) do
        local characterComponent = entity:getComponent("Character")		
        if characterComponent.character == nil then
            continue
        end

		local bloodComponent = entity:getComponent("Blood")
		local woundTrackerComponent = entity:getComponent("WoundTracker")
		local totalBloodLossATick = 0
		for _, wound in ipairs(woundTrackerComponent.wounds) do
			totalBloodLossATick += wound.damage / 10
		end

		-- local isFastBloodDrop = totalBloodLossATick > 5
		totalBloodLossATick = totalBloodLossATick * dt

		bloodComponent.bloodQuantity = math.max(0, bloodComponent.bloodQuantity - totalBloodLossATick)

		-- local currentTime = os.time()
        -- if currentTime < bloodComponent.lastBloodDropTime + (isFastBloodDrop and bloodComponent.fastBloodDropSecondInterval or bloodComponent.fastBloodDropSecondInterval)  then
        --     continue
        -- end
		-- -- Spray blood
		-- bloodComponent.lastBloodDropTime = currentTime
	end
end

return BleedingSystem