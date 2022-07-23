local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local BloodDroplet = class("BloodDroplet", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function BloodDroplet:initialize(bloodType)
    if bloodType == nil then
        error("nil bloodType")
    end
	self.bloodType = bloodType
	self.name = "BloodDroplet"
end

function BloodDroplet.desc()
	return "Stores info related to blood droplets."
end

return BloodDroplet