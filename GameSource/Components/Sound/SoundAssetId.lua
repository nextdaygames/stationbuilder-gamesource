local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local SoundAssetId = class("SoundAssetId", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function SoundAssetId:initialize(soundAssetId) 
	if soundAssetId == nil then
		error("entityName not initialized")
	end
	self.soundAssetId = soundAssetId

	self.name = "SoundAssetId"
end

function SoundAssetId.category()
	return Enums.ComponentCategory.Sound
end

function SoundAssetId.displayName()
	return "Use a Sound Asset"
end

function SoundAssetId.createFromParameters(params)
	return SoundAssetId:new(params["Sound Asset Id"])
end

function SoundAssetId.requirements()
	return {
		["Sound Asset Id"] = Enums.ValidEntryTypes.Float
	}
end

function SoundAssetId.defaults()
	return {
		["Sound Asset Id"] = 425543283,
	}
end

function SoundAssetId.tags()
	return {Enums.ComponentTag.DeprecatedSafeToDelete, Enums.ComponentTag.Deprecated}
end

function SoundAssetId.desc()
	return "Creates a Sound based on a Roblox Asset Id. Used to create sounds on activation and ambiently."
end

return SoundAssetId
