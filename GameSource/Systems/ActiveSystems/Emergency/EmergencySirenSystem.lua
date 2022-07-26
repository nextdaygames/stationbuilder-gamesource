local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local ChatService = game:GetService("Chat")

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local EmergencySirenSystem = class("EmergencySirenSystem", ECS.System)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

function EmergencySirenSystem:initialize()
	ECS.System.initialize(self)
    self.isEmergency = false

    self.lastEmergencyRing = 0
    self.emergencyRingCooldownSeconds = 10
	self.name = "EmergencySirenSystem"
end

function EmergencySirenSystem:matchingGroups()
	return {
        ["LoudSpeakers"] = { "LoudSpeaker" },
        ["EmergencyActivators"] = { "EmergencyActivator" },
    }
end

function EmergencySirenSystem:playSiren()
    for _, loudSpeaker in pairs(self.entityGroups["LoudSpeakers"]) do
        local loudSpeakerEntityContainerComponent = loudSpeaker:getComponent("EntityContainer")
	    Get("Utility/AudioFaker"):playSoundAssetAtLocation(10360000793, loudSpeakerEntityContainerComponent.primaryPart.Position) -- Scary Siren
    end
end

function EmergencySirenSystem:update(dt)

    local didToggleChange = false
	for _, entity in pairs(self.entityGroups["EmergencyActivators"]) do
        local emergencyActivatorComponent = entity:getComponent("EmergencyActivator")		
        if emergencyActivatorComponent.isEmergency ~= self.isEmergency then
            didToggleChange = true
            self.isEmergency = emergencyActivatorComponent.isEmergency
            break
        end
	end

    if not didToggleChange then
        local currentTime = os.time()
        if self.isEmergency and currentTime - self.lastEmergencyRing > self.emergencyRingCooldownSeconds then
            self.lastEmergencyRing = currentTime
            self:playSiren()
        end

        return
    end
    print("Toggled to ", self.isEmergency)

    -- Set all activators to match
    for _, entity in pairs(self.entityGroups["EmergencyActivators"]) do
        local emergencyActivatorComponent = entity:getComponent("EmergencyActivator")
        emergencyActivatorComponent.isEmergency = self.isEmergency	
    end

    if not self.isEmergency then
        return
    end
    self.lastEmergencyRing = os.time()
    self:playSiren()    
end

return EmergencySirenSystem