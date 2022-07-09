local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local SpawnSoundMakerSystem = class("SpawnSoundMakerSystem", ECS.InitializationSystem)

function SpawnSoundMakerSystem:initialize(isDebug)
	ECS.InitializationSystem.initialize(self)
	
	self.name = "SpawnSoundMakerSystem"	
	self.isDebug = isDebug ~= nil and isDebug or false	
end

function SpawnSoundMakerSystem:matches()
	return { "SpawnSoundMaker", "EntityContainer" }
end

function SpawnSoundMakerSystem:initializeEntity(entity)
	local spawnSoundComponent = entity:getComponent("SpawnSoundMaker")
	
	local entityContainerComponent = entity:getComponent("EntityContainer")
	
	local sound = Instance.new("Sound")
	sound.Looped = false
	sound.PlaybackSpeed = 1
	sound.Playing = false
	sound.Volume = 0.1
	sound.SoundId = "rbxassetid://" .. spawnSoundComponent.soundAssetId
	sound.Name = spawnSoundComponent.soundAssetId
	sound.Parent = entityContainerComponent.primaryPart
	sound:Play()
end

return SpawnSoundMakerSystem