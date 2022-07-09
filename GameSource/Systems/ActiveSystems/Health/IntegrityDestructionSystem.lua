local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local IntegrityDestructionSystem = class("IntegrityDestructionSystem", ECS.System)

function IntegrityDestructionSystem:initialize(deleteEntityByIdCallback)
	ECS.System.initialize(self)
	self.name = "IntegrityDestructionSystem"

	if deleteEntityByIdCallback == nil then
		error("nil deleteEntityByIdCallback")
	end
	self.deleteEntityByIdCallback = deleteEntityByIdCallback
end

function IntegrityDestructionSystem:matchingGroups()
	return {
		["Destructibles"] = { "Integrity", "EntityContainer", "Spawned" } 
	}
end

function IntegrityDestructionSystem:update(dt)
	for entityId, destructibleEntity in pairs(self.entityGroups["Destructibles"]) do
		local integrityComponent = destructibleEntity:getComponent("Integrity")
		local entityContainerComponent = destructibleEntity:getComponent("EntityContainer")
		
		if integrityComponent.currentIntegrity <= 0 then
			entityContainerComponent.entityContainer.Parent = nil
			self.deleteEntityByIdCallback(entityId)
		end
	end
end

return IntegrityDestructionSystem