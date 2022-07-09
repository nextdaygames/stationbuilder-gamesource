--
-- Ignitable, for objects that can catch fire
--

local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Ignitable = class("Ignitable", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function Ignitable:initialize(ignitePointFarenheit) 
	if ignitePointFarenheit == nil then
		error("ignitePointFarenheit not initialized")
	end
	self.ignitePointFarenheit = ignitePointFarenheit	
	self.name = "Ignitable"
end

function Ignitable.createFromParameters(params)
	return Ignitable:new(tonumber(params["Ignite Point Farenheit"]))
end

function Ignitable:requirements()
	return {
		["Ignite Point Farenheit"] = Enums.ValidEntryTypes.Float
	}
end

function Ignitable.defaults()
	return {
		["Ignite Point Farenheit"] = 100,
	}
end

function Ignitable.tags()
	return {Enums.ComponentTag.Deprecated}
end

function Ignitable.desc()
	return "Allows the object to catch fire. Requires Temperature."
end

return Ignitable