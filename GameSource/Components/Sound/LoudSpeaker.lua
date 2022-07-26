local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local LoudSpeaker = class("LoudSpeaker", ECS.Component)
local Split = Get("Utility/Split")

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function LoudSpeaker:initialize() 
	self.name = "LoudSpeaker"
end

function LoudSpeaker.category()
	return Enums.ComponentCategory.Sound
end

function LoudSpeaker.displayName()
	return "Loud Speaker"
end

function LoudSpeaker.createFromParameters(params)
	return LoudSpeaker:new()
end

function LoudSpeaker.requirements()
	return {
	}
end

function LoudSpeaker.defaults()
	return {
	}
end

function LoudSpeaker.options()
	return {
	}
end

function LoudSpeaker.tags()
	return {}
end

function LoudSpeaker.mutuallyExclusive()
    return {"TopLevelTool"}
end

function LoudSpeaker.desc()
	return "When announcements or emergencies are declared, this item will be used."
end

return LoudSpeaker