local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local HeatProducer = class("HeatProducer", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function HeatProducer:initialize(heatOutputFarenheit, heatHitboxPart) 
	if heatOutputFarenheit == nil then
		error("fireCatchFarenheitPoint not initialized")
	end
	self.heatOutputFarenheit = heatOutputFarenheit
	
	if heatHitboxPart == nil then
		error("fireHitboxRef not initialized")
	end
	self.heatHitboxPart = heatHitboxPart
	
	self.name = "HeatProducer"
end

function HeatProducer.tags()
	return {Enums.ComponentTag.Deprecated}
end

function HeatProducer.desc()
	return "Outputs heat at a given farenheit to any temperature based entities in the heat hitbox."
end

return HeatProducer