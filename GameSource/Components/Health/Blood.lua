local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Blood = class("Blood", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function Blood:initialize(maxBloodQuantity) 
	if maxBloodQuantity == nil then
		error("nil startingBloodQuantity")
	end
	self.maxBloodQuantity = maxBloodQuantity
	self.bloodQuantity = maxBloodQuantity

	self.lastBloodDropTime = os.time()
	self.slowBloodDropSecondInterval = 5
	self.fastBloodDropSecondInterval = 1

	self.name = "Blood"
end
function Blood.desc()
	return "The starting quantity of blood. A human has an average of 6 quarts of blood."
end

return Blood