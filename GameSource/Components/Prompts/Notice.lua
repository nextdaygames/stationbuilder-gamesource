local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Notice = class("Notice", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function Notice:initialize(message) 
	if message == nil then
		error("message not initialized")
	end
	self.message = message
	
	self.name = "Notice"
end

function Notice.category()
	return Enums.ComponentCategory.Interaction
end

function Notice.displayName()
	return "Display a Message"
end

function Notice.createFromParameters(params)
	return Notice:new(params["Message"])
end

function Notice.requirements()
	return {
		["Message"] = Enums.ValidEntryTypes.String
	}
end

function Notice.tags()
	return {}
end

function Notice.mutuallyExclusive() 
	return {}
end

function Notice.fieldsToModerate()
	return {
		"Message"
	}
end

function Notice.defaults()
	return {
		["Message"] = 100,
	}
end

function Notice.desc()
	return "When someone interacts with this without something in their hand they will read out the message."
end

return Notice