local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local FireDamageSystem = class("FireDamageSystem", ECS.System)

function FireDamageSystem:initialize()
	ECS.System.initialize(self)
	self.name = "FireDamage"
end

function FireDamageSystem:matchingGroups()
	return {
		["Damaging"] = { "Integrity", "OnFire" }
	}
end

function FireDamageSystem:update(dt)
	for _, entity in pairs(self.entityGroups["Damaging"]) do
		local healthComponent = entity:getComponent("Integrity")
		
		if healthComponent.currentIntegrity > 0 then
			healthComponent.currentIntegrity = healthComponent.currentIntegrity - (25*dt)
		end
	end
end

return FireDamageSystem