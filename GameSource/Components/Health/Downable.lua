local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Downable = class("Downable", ECS.Component)

function Downable:initialize() 
    self.name = "Downable"

    self.lastSuffocationDamageTime = os.time()
	self.suffocationDamageSecondInterval = 5
	self.suffocationDamageAmount = 5

	self.dueToBloodLoss = false
	self.dueToLowHealth = false
end

function Downable:shouldBeDowned()
	return self.dueToBloodLoss or self.dueToLowHealth
end

function Downable.desc()
	return "For whichever reason, this person is downed."
end

return Downable 