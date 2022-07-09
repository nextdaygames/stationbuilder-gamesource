local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local TrackedMoney = class("TrackedMoney", ECS.Component)

function TrackedMoney:initialize()
    self.currentMoney = 0
	self.name = "TrackedMoney"
end

function TrackedMoney.desc()
	return "Holds the characters money."
end

return TrackedMoney