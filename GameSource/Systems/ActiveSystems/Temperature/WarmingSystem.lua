local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local WarmingSystem = class("WarmingSystem", ECS.System)
local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

function WarmingSystem:initialize()
	ECS.System.initialize(self)
	self.ambientTempFarenheit = 72
	self.name = "Warming"
end


function WarmingSystem:matchingGroups()
	return {
		["HeatProducers"] = { "HeatProducer" },
		["Temperature"] = { "Temperature" } 
	}
end

function WarmingSystem:update(dt)	
	for _, heatProducingEntity in pairs(self.entityGroups["HeatProducers"]) do
		
		local heatProducerComponent = heatProducingEntity:getComponent("HeatProducer")
		local touchingParts = heatProducerComponent.heatHitboxPart:GetTouchingParts()
		
		for _, touchingPart in ipairs(touchingParts) do
			for _, heatableEntity in pairs(self.entityGroups["Temperature"]) do
				
				local temperatureComponent = heatableEntity:getComponent("Temperature")
				if touchingPart ~= temperatureComponent.fireHitboxPart then
					continue
				end
				local temperatureDifferential = 
					heatProducerComponent.heatOutputFarenheit - temperatureComponent.currentTemperatureFarenheit
				
				if temperatureDifferential <= 0 then
					return
				end	
				temperatureComponent.currentTemperatureFarenheit = 
					temperatureComponent.currentTemperatureFarenheit + ((temperatureDifferential/2)*dt)
			end
		end
	end
end

return WarmingSystem