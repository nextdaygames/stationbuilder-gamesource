local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local EpinephrineBurnSystem = class("EpinephrineBurnSystem", ECS.System)

function EpinephrineBurnSystem:initialize()
	ECS.System.initialize(self)
	self.name = "EpinephrineBurnSystem"
end

function EpinephrineBurnSystem:matchingGroups()
	return {
        ["EpiPeople"] = { "Epinephrine" }
    }
end

function EpinephrineBurnSystem:update(dt)
	for _, entity in pairs(self.entityGroups["EpiPeople"]) do
		local epinephrineComponent = entity:getComponent("Epinephrine")

		local currentTime = os.time()
        if currentTime < epinephrineComponent.lastEpinephrineAdministerTime + epinephrineComponent.epinephrineDurationSeconds then
            continue
        end
        entity:removeComponent("Epinephrine")
	end
end

return EpinephrineBurnSystem