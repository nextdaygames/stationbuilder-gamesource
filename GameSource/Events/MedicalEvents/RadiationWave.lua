local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})

local class = Get("Lib/middleclass")
local Event = Get("Lib/RoundEvents/Event")
local RadiationWave = class("RadiationWave", Event)

function RadiationWave:initialize(interactionToolsProcessor)
    Event.initialize(self, interactionToolsProcessor)
    self.name = "RadiationWave"
    self.description = "Gives everyone radiation poisoning unless they have taken an iodine pill or are wearing lead."
end

function RadiationWave.matchingGroups()
	return {
        ["ExposedOrganics"] = { "OrganicHealth", "-Iodine", "-LeadCovered" },
        ["ExposedComputers"] = { "Machinery", "-RadiationProof" } 
    }
end

function RadiationWave.announcement()
    return "A band of radiation is striking the station soon. Take iodine or wear lead to avoid harmful radiation."
end

function RadiationWave.lifeCycle()
    return {
        startDelayMinutes = 1,
        announcmentDelayMinutes = 0,
        durationAfterStartingMinutes = 1,
        isAnnouncementEnabled = true
    }
end

function RadiationWave.isDisabled() 
    return false
end

function RadiationWave.areDuplicatesAllowed()
    return false
end

function RadiationWave.weight()
    return 50 -- Once every 5 games
end

function RadiationWave.maxOccurences()
    return 1
end

function RadiationWave.minimumPlayerCount()
    return 1
end

function RadiationWave.earliestStartMinute()
    return 15
end

function RadiationWave.canStart(event, minutesPassed, playerCount)
    if not Event.canStart(event, minutesPassed, playerCount) then
        return false
    end

    return true
end

function RadiationWave:setupEvent()
    Event.setupEvent(self)
end

function RadiationWave:startEvent()
    Event.startEvent(self)
end

function RadiationWave:endEvent()
    Event.endEvent(self)
end

function RadiationWave:update(dt)
    Event.update(self, dt)

    if self.status == Enums.EventStatus.NOT_STARTED then
        return
    end

    local numberExposedOrganics = table.getn(self.entityGroups["ExposedOrganics"])
    local numberExposedComputers = table.getn(self.entityGroups["ExposedComputers"])
    print(numberExposedOrganics, numberExposedComputers)
end

return RadiationWave