local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local HealTypeInitializaitonSystem = class("HealTypeInitializaitonSystem", ECS.InitializationSystem)

function HealTypeInitializaitonSystem:initialize(isDebug)
	ECS.InitializationSystem.initialize(self)
	self.name = "HealTypeInitializaitonSystem"
	
	self.isDebug = isDebug ~= nil and isDebug or false
end

function HealTypeInitializaitonSystem:matches()
	return { "Heal" }
end

function HealTypeInitializaitonSystem:initializeEntity(entity)
	local healComponent = entity:getComponent("Heal")
	entity:add({name = "Heal" .. string.lower(healComponent.healType):gsub("^%l", string.upper)})
end

return HealTypeInitializaitonSystem