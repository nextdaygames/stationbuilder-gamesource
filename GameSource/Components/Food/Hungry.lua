local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Hungry = class("Hungry", ECS.Component)

function Hungry:initialize() 
	self.name = "Hungry"
end

function Hungry.desc()
	return "Denotes that a character is hungry."
end

return Hungry 