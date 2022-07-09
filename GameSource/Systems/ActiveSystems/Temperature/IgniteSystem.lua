local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local IgniteSystem = class("IgniteSystem", ECS.System)
local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

function IgniteSystem:initialize()
	ECS.System.initialize(self)
	self.ambientTempFarenheit = 72
	self.name = "Ignite"
end

function IgniteSystem:matchingGroups()
	return {
		["Ignitable"] = { "Ignitable", "Temperature", "PrimaryPart", "-OnFire" } 
	}
end

function IgniteSystem:update(dt)	
	for _, entity in pairs(self.entityGroups["Ignitable"]) do
		
		local temperatureComponent = entity:getComponent("Temperature")
		local ignitableComponent = entity:getComponent("Ignitable")
		if temperatureComponent.currentTemperatureFarenheit < ignitableComponent.ignitePointFarenheit then
			continue
		end
		
		local primaryPartComponent = entity:getComponent("PrimaryPart")

		local onFirePart = GetReplicatedStorage("Assets/Models/Fire"):clone()
		local weld = onFirePart:WaitForChild("WeldToModel")

		local primaryPart = primaryPartComponent.primaryPart
		weld.Part0 = onFirePart
		weld.Part1 = primaryPart
		onFirePart.Position = primaryPart.Position
		onFirePart.Parent = primaryPart
		entity:add(Components.OnFire:new(onFirePart))
		entity:add(Components.HeatProducer:new(600, onFirePart:FindFirstChild("FireHitbox")))
	end
end

return IgniteSystem