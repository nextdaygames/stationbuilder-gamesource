local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Epinephrine = class("Epinephrine", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function Epinephrine:initialize(maxEpinephrineQuantity) 
	self.lastEpinephrineAdministerTime = os.time()
	self.epinephrineDurationSeconds = 10

	self.name = "Epinephrine"
end
function Epinephrine.desc()
	return "Characters with epinephrine on board won't suffocate due to unconciousness."
end

return Epinephrine