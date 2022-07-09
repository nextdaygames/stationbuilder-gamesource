local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Repair = class("Repair", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function Repair:initialize(repairAmount) 
	if repairAmount == nil then
		error("nil repairAmount")
	end
	self.repairAmount = repairAmount

	self.name = "Repair"
end

function Repair.category()
	return Enums.ComponentCategory.InanimateLife
end

function Repair.displayName()
	return "Repair Integrity on Item Use"
end

function Repair.createFromParameters(params)
	return Repair:new(params["Repair Amount"])
end

function Repair.requirements()
	return {
		["Repair Amount"] = Enums.ValidEntryTypes.Float
	}
end

function Repair.defaults()
	return {
		["Repair Amount"] = "34",
	}
end

function Repair.tags()
	return {}
end

function Repair.dependsOnComponents() 
	return {"TopLevelTool"}
end

function Repair.desc()
	return "Repair characters for an amount of health."
end

return Repair