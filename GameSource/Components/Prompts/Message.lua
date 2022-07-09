local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Message = class("Message", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function Message:initialize(message) 
	if message == nil then
		error("message not initialized")
	end
	self.message = message

	self.name = "Message"
end

function Message.category()
	return Enums.ComponentCategory.Rendering
end

function Message.displayName()
	return "Render a Message on a Face"
end

function Message.createFromParameters(params)
	return Message:new(params["Message"])
end

function Message.requirements()
	return {
		["Message"] = Enums.ValidEntryTypes.String
	}
end

function Message.fieldsToModerate()
	return {
		"Message"
	}
end

function Message.defaults()
	return {
        ["Message"] = "Message",
	}
end

function Message.dependsOnComponents()
    return {
        "CollisionBoxMaker"
    }
end

function Message.tags()
	return { Enums.ComponentTag.Deprecated }
end

function Message.desc()
	return "Display a message on one of the faces of the collision box."
end

return Message
