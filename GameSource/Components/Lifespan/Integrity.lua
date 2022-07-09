local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Integrity = class("Integrity", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function Integrity:initialize(totalIntegrity) 
	if totalIntegrity == nil then
		error("totalIntegrity not initialized")
	end
	self.totalIntegrity = totalIntegrity
	self.currentIntegrity = totalIntegrity
	
	self.name = "Integrity"
end

function Integrity.category()
	return Enums.ComponentCategory.InanimateLife
end

function Integrity.displayName()
	return "Total Health of the Item"
end

function Integrity.createFromParameters(params)
	return Integrity:new(tonumber(params["Total Integrity"]))
end

function Integrity.requirements()
	return {
		["Total Integrity"] = Enums.ValidEntryTypes.Float
	}
end

function Integrity.tags()
	return {Enums.ComponentTag.Default}
end

function Integrity.mutuallyExclusive() 
	return {"RenderCharacter"}
end

function Integrity.defaults()
	return {
		["Total Integrity"] = 100,
	}
end

function Integrity.desc()
	return "Stores the health of the object."
end

return Integrity