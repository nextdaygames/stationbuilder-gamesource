--
-- Temperature, for objects that can warm due to heat sources
--

local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Temperature = class("Temperature", ECS.Component)

function Temperature:initialize(fireHitboxPart) 
	if fireHitboxPart == nil then
		error("fireHitboxPart not initialized")
	end
	self.fireHitboxPart = fireHitboxPart
	
	self.currentTemperatureFarenheit = 72
	
	self.name = "Temperature"
end

function Temperature.desc()
	return "Allows the entity to be heated by heat producers. Tracks current temperature."
end

return Temperature