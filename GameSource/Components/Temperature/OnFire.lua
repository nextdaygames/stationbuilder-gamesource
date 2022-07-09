local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local OnFire = class("OnFire", ECS.Component)

function OnFire:initialize(firePart) 
	if firePart == nil then
		error("firePart not initialized")
	end
	self.firePart = firePart
	
	self.name = "OnFire"
end

function OnFire.desc()
	return "Creates a fire particle effect on top of the on fire part."
end

return OnFire