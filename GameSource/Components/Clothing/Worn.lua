local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Worn = class("Worn", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function Worn:initialize(wornByEntity, weldToCharacter)
	self.name = "Worn"

    if wornByEntity == nil then
        error("nil wornByEntity")
    end
    self.wornByEntity = wornByEntity

    if weldToCharacter == nil then
        error("nil weldToCharacter")
    end
    self.weldToCharacter = weldToCharacter
end

function Worn.desc()
	return "Marks this clothing as being worn so you can't steal people's clothing off their backs."
end

return Worn