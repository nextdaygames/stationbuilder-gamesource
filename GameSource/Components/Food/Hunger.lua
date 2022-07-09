local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Hunger = class("Hunger", ECS.Component)

function Hunger:initialize() 
	self.maxHunger = 100

	-- 100 is full, 0 is max hungry
    self.currentHunger = self.maxHunger

	self.lastHungerDamageTime = os.time()
	self.hungryDamageSecondInterval = 10
	self.starvationDamageAmount = 10
	-- Downed 100 seconds after starving

	self.lastHungerDrainTime = os.time()
	self.hungerDrainSecondInterval = 30
	self.hungerDrainAmount = 2.5
	-- Starving in 20 minutes

	self.name = "Hunger"
end

function Hunger.desc()
	return "Tracks current hunger level."
end

return Hunger 