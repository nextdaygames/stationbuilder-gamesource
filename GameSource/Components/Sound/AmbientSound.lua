local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local AmbientSound = class("AmbientSound", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function AmbientSound:initialize(soundAssetId)
	if soundAssetId == nil then
		error("entityName not initialized")
	end
	self.soundAssetId = soundAssetId
	self.name = "AmbientSound"
end

function AmbientSound.category()
	return Enums.ComponentCategory.Sound
end

function AmbientSound.displayName()
	return "Play an Ambient Sound"
end

function AmbientSound.createFromParameters(params)
	return AmbientSound:new(params["Sound Asset Id"])
end

function AmbientSound.requirements()
	return {
		["Sound Asset Id"] = Enums.ValidEntryTypes.Float,
	}
end

function AmbientSound.defaults()
	return {
		["Sound Asset Id"] = 425543283,
	}
end

function AmbientSound.tags()
	return {}
end

function AmbientSound.mutuallyExclusive()
	return { }
end

function AmbientSound.dependsOnComponents() 
	return {}
end

function AmbientSound.desc()
	return "Play a looped sound as long as the item exists."
end

return AmbientSound 