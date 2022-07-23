local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Blood = class("Blood", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

function Blood:rollBloodType ()
    local random = math.random()
    if random < 0.38 then
        return "O Positive"
    elseif random < 0.72 then
        return "A Positive"
    elseif random < 0.81 then
        return "B Positive"
    elseif random < 0.88 then
        return "O Negative"
    elseif random < 0.94 then
        return "A Negative"
    elseif random < 0.97 then
        return "AB Positive"
    elseif random < 0.99 then
        return "B Negative"
    else
        return "AB Negative"
    end
end

function Blood:initialize(maxBloodQuantity) 
	if maxBloodQuantity == nil then
		error("nil startingBloodQuantity")
	end
	self.maxBloodQuantity = maxBloodQuantity
	self.bloodQuantity = maxBloodQuantity
	self.bloodType = self:rollBloodType()
	self.lastBloodDropTime = os.time()
	self.slowBloodDropSecondInterval = 5
	self.fastBloodDropSecondInterval = 1

	self.name = "Blood"
end
function Blood.desc()
	return "The starting quantity of blood. A human has an average of 6 quarts of blood."
end

return Blood