local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Fingerprint = class("Fingerprint", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function Fingerprint:initialize()
	self.name = "Fingerprint"
    self.lastHeldByPlayerId = nil
end

function Fingerprint.desc()
	return "Stores who last held something."
end

return Fingerprint