local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local RestrainedSystem = class("RestrainedSystem", ECS.InitializationSystem)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

function RestrainedSystem:initialize(isDebug)
	ECS.InitializationSystem.initialize(self)
	self.name = "RestrainedSystem"
	self.isDebug = isDebug ~= nil and isDebug or false	
end

-- This shit broke
function RestrainedSystem:matches()
	return { "Character", "Restrained" }
end

function RestrainedSystem:initializeEntity(entity)
	if self.isDebug then
		print("Welding entity together " .. entity.id)
	end

	local characterComponent = entity:getComponent("Character")

	if characterComponent == nil then
		warn("No interacted character.")
		return
	end

	if characterComponent.character == nil then
		return
	end

	local humanoid = characterComponent.character:FindFirstChild("Humanoid")
	if humanoid == nil then
		return
	end
	humanoid.WalkSpeed = humanoid.WalkSpeed * 0.5
end

return RestrainedSystem