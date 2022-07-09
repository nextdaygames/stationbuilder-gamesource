local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Downed = class("Downed", ECS.Component)

function Downed:initialize() 
    self.name = "Downed"

    self.lastSuffocationDamageTime = os.time()
	self.suffocationDamageSecondInterval = 5
	self.suffocationDamageAmount = 5
end

function Downed.desc()
	return "For whichever reason, this person is downed."
end

return Downed 