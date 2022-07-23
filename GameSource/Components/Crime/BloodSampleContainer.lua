local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local BloodSampleContainer = class("BloodSampleContainer", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function BloodSampleContainer:initialize()
	self.name = "BloodSampleContainer"

	self.hiddenBloodType = nil
	self.bloodType = nil
end

function BloodSampleContainer.category()
	return Enums.ComponentCategory.Crime
end

function BloodSampleContainer.displayName()
	return "Blood Sample Container"
end

function BloodSampleContainer.createFromParameters(params)
	return BloodSampleContainer:new()
end

function BloodSampleContainer.tags()
	return {}
end

function BloodSampleContainer.requirements()
	return {
	}
end

function BloodSampleContainer.defaults()
	return {
		
	}
end

function BloodSampleContainer.mutuallyExclusive()
	return {  }
end

function BloodSampleContainer.dependsOnComponents() 
	return {"TopLevelTool"}
end

function BloodSampleContainer.desc()
	return "Can store blood droplets for analysis."
end

return BloodSampleContainer