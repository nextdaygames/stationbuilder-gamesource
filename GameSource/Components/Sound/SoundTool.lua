local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local SoundTool = class("SoundTool", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function SoundTool:initialize(soundAssetId)
	if soundAssetId == nil then
		error("entityName not initialized")
	end
	self.soundAssetId = soundAssetId

	self.name = "SoundTool"
	self.lastOsTime = os.time()
end

function SoundTool.category()
	return Enums.ComponentCategory.Sound
end

function SoundTool.displayName()
	return "Play a Sound on Item Use"
end

function SoundTool.createFromParameters(params)
	return SoundTool:new(params["Sound Asset Id"])
end

function SoundTool.requirements()
	return {
		["Sound Asset Id"] = Enums.ValidEntryTypes.Float,
	}
end

function SoundTool.defaults()
	return {
		["Sound Asset Id"] = 425543283,
	}
end

function SoundTool.tags()
	return { Enums.ComponentTag.DeprecatedSafeToDelete, Enums.ComponentTag.Deprecated }
end

function SoundTool.mutuallyExclusive()
	return { }
end

function SoundTool.dependsOnComponents() 
	return {"TopLevelTool"}
end

function SoundTool.desc()
	return "Makes a sound on activation."
end

return SoundTool 