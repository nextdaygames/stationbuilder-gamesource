local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local AmbientSoundSystem = class("AmbientSoundSystem", ECS.InitializationSystem)

function AmbientSoundSystem:initialize(isDebug)
	ECS.InitializationSystem.initialize(self)
	
	self.name = "AmbientSoundSystem"	
	self.isDebug = isDebug ~= nil and isDebug or false	
end

function AmbientSoundSystem:matches()
	return { "AmbientSound", "EntityContainer" }
end

function AmbientSoundSystem:initializeEntity(entity)
	local ambientSoundComponent = entity:getComponent("AmbientSound")
	
	local entityContainerComponent = entity:getComponent("EntityContainer")
	
	local sound = Instance.new("Sound")
	sound.Looped = true
	sound.PlaybackSpeed = 1
	sound.Playing = false
	sound.Volume = 0.1
	sound.SoundId = "rbxassetid://" .. ambientSoundComponent.soundAssetId
	sound.Name = ambientSoundComponent.soundAssetId
	sound.Parent = entityContainerComponent.primaryPart
	sound:Play()
end

return AmbientSoundSystem