local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local FireHurtSystem = class("FireHurtSystem", ECS.System)

function FireHurtSystem:initialize()
	ECS.System.initialize(self)
	self.name = "FireDamage"
end

function FireHurtSystem:matchingGroups()
	return {
		["Hurting"] = { "Humanoid", "OnFire" }
	}
end

function FireHurtSystem:update(dt)
	for entityId, entity in pairs(self.entityGroups["Hurting"]) do
		local humanoidComponent = entity:getComponent("Humanoid")

		if humanoidComponent.humanoid.Health > 0 then
			humanoidComponent.humanoid.Health = humanoidComponent.humanoid.Health - (25*dt)
		end
	end
end

return FireHurtSystem