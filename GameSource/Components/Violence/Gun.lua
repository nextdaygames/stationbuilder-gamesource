local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Gun = class("Gun", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function Gun:initialize(burstCooldownMilliseconds, burstBulletStaggerMilliseconds, burstBulletQuantity, clipSize, spreadCalculationDistance, spread, isContinuousFire) 
	self.name = "Gun"

    if burstCooldownMilliseconds == nil then
		error("burstCooldownMilliseconds not initialized")
	end
	self.burstCooldownMilliseconds = burstCooldownMilliseconds

    if burstBulletStaggerMilliseconds == nil then
		error("burstBulletStaggerMilliseconds not initialized")
	end
	self.burstBulletStaggerMilliseconds = burstBulletStaggerMilliseconds

    if burstBulletQuantity == nil then
		error("burstBulletQuantity not initialized")
	end
	self.burstBulletQuantity = burstBulletQuantity

    if clipSize == nil then
		error("clipSize not initialized")
	end
	self.clipSize = clipSize

	if spreadCalculationDistance == nil then
		error("spreadCalculationDistance not initialized")
	end
	self.spreadCalculationDistance = spreadCalculationDistance

    if spread == nil then
		error("spread not initialized")
	end
	self.spread = spread

    if isContinuousFire == nil then
		error("isContinuousFire not initialized")
	end
	self.isContinuousFire = string.upper(isContinuousFire) == "TRUE"

	local currentTimeMilliseconds = DateTime.now().UnixTimestampMillis
	self.lastBurstBegan = currentTimeMilliseconds
	self.lastFire = currentTimeMilliseconds

	self.isFiring = false
	self.isFreshInput = true
	
	self.maxSpraySpread = 1
	self.durationMillisecondsForSpreadPeriod = 1*1000
	self.sprayCalculationDistance = 20
	self.currentSpraySpread = 0
	
	self.burstBulletCooldowns = {}
end

function Gun.category()
	return Enums.ComponentCategory.Weapons
end

function Gun.displayName()
	return "Gun"
end

function Gun.createFromParameters(params)
	return Gun:new(
        params["Burst Cooldown Milliseconds"], params["Burst Bullet Stagger Milliseconds"], params["Burst Bullet Quantity"],
        params["Clip Size"],
        params["Spread Calculation Distance"], params["Spread"],
        params["Continuous Fire?"]
    )
end

function Gun.requirements()
	return {
        ["Burst Cooldown Milliseconds"] = Enums.ValidEntryTypes.Float,
        ["Burst Bullet Stagger Milliseconds"] = Enums.ValidEntryTypes.Float,
        ["Burst Bullet Quantity"] = Enums.ValidEntryTypes.Float,
        ["Clip Size"] = Enums.ValidEntryTypes.Float,
        ["Spread Calculation Distance"] = Enums.ValidEntryTypes.Float,
        ["Spread"] = Enums.ValidEntryTypes.Float,
        ["Continuous Fire?"] = Enums.ValidEntryTypes.SelectOneOption,
	}
end

function Gun.options()
    return {
        ["Continuous Fire?"] = "true,false",
    }
end

function Gun.validate(params)
	if params["Burst Bullet Stagger Milliseconds"] * params["Burst Bullet Quantity"] >= params["Burst Cooldown Milliseconds"] then
		return "The time it takes to burst fire take longer than the guns cooldown."
	end
end

function Gun.defaults()
	return {
        ["Burst Cooldown Milliseconds"] = 150,
        ["Burst Bullet Stagger Milliseconds"] = 40,
        ["Burst Bullet Quantity"] = 3,
        ["Clip Size"] = 12,
        ["Spread Calculation Distance"] = 20,
        ["Spread"] = 1,
        ["Continuous Fire?"] = "true",
	}
end

function Gun.tags()
	return {
        -- Enums.ComponentTag.Deprecated
	}
end

function Gun.mutuallyExclusive()
	return {  }
end

function Gun.dependsOnComponents()
	return { "TopLevelTool", "Damage" }
end

function Gun.desc()
	return "Makes the item fire hitscan damage."
end

return Gun 