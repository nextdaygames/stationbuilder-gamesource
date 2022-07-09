local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local OrganicHealth = class("OrganicHealth", ECS.Component)

function OrganicHealth:initialize() 
    self.name = "OrganicHealth"

    self.burnDamage = 0
    self.bruteDamage = 0
    self.toxicDamage = 0
    self.suffocationDamage = 0
    self.starvationDamage = 0
end

function OrganicHealth:getTotalDamage()
    return self.burnDamage + self.bruteDamage + self.toxicDamage + self.suffocationDamage + self.starvationDamage
end

function OrganicHealth.desc()
	return "Keeps track of organic damage sources that might kill you."
end

return OrganicHealth 