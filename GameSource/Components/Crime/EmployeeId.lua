local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local EmployeeId = class("EmployeeId", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function EmployeeId:initialize()
	self.name = "EmployeeId"
end

function EmployeeId.category()
	return Enums.ComponentCategory.Crime
end

function EmployeeId.displayName()
	return "Employee ID"
end

function EmployeeId.createFromParameters(params)
	return EmployeeId:new()
end

function EmployeeId.tags()
	return {}
end

function EmployeeId.requirements()
	return {
	}
end

function EmployeeId.defaults()
	return {
		
	}
end

function EmployeeId.mutuallyExclusive()
	return {  }
end

function EmployeeId.dependsOnComponents() 
	return { "TopLevelTool" }
end

function EmployeeId.desc()
	return "Stores your name, job, blood type, and employee ID."
end

return EmployeeId