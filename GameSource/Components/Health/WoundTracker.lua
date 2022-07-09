local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local WoundTracker = class("WoundTracker", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function WoundTracker:initialize() 
	
    self.wounds = {}

	self.name = "WoundTracker"
end
function WoundTracker.desc()
	return "Tracks wounds."
end

return WoundTracker