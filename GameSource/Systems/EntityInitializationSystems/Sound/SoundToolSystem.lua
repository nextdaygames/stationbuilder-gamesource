local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local CreateSmokeTrail = Get("Utility/CreateSmokeTrail")

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local SoundToolSystem = class("SoundToolSystem", ECS.InitializationSystem)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

function SoundToolSystem:initialize(isDebug)
	ECS.InitializationSystem.initialize(self)
	
	self.name = "SoundToolSystem"	
	self.isDebug = isDebug ~= nil and isDebug or false	
end

function SoundToolSystem:matches()
	return { "SoundTool", "Tool", "EntityContainer" }
end

function SoundToolSystem:initializeEntity(entity)
	local toolComponent = entity:getComponent("Tool")
	local soundToolComponent = entity:getComponent("SoundTool")
	local entityContainerComponent = entity:getComponent("EntityContainer")
	
	local sound = Instance.new("Sound")
	sound.Looped = false
	sound.PlaybackSpeed = 1
	sound.Playing = false
	sound.Volume = 0.1
	sound.SoundId = "rbxassetid://" .. soundToolComponent.soundAssetId
	sound.Name = soundToolComponent.soundAssetId
	sound.Parent = entityContainerComponent.primaryPart
	
	local toolActivatableCallback = function()
		local toolActivatationCooldownComponent = entity:getComponent("ToolActivationCooldown")
		if toolActivatationCooldownComponent ~= nil then
			local currentTime = os.time()
			if currentTime < soundToolComponent.lastOsTime + toolActivatationCooldownComponent.cooldownSeconds then
				return
			end
			soundToolComponent.lastOsTime = currentTime
		end
		
		sound:Play()
	end
	toolComponent.tool.Activated:Connect(toolActivatableCallback)
end

return SoundToolSystem