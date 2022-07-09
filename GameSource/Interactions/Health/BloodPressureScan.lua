local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})
local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local BloodPressureScan = class("BloodPressureScan", Interact)

function BloodPressureScan:init()
    self.aiActionCost = 1
    self.name = "BloodPressureScan"
end

function BloodPressureScan:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = { "Character" },
        aiInstigatorRequires = { "MedicalAI" },
        objectMatches = { "Character", "Blood" },
        toolMatches = { "BloodPressureMonitor" },
    }
end

function BloodPressureScan:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)

    local objectBloodComponent = object:getComponent("Blood")
    
    local instigatorEntityContainerComponent = instigator:getComponent("EntityContainer")
    local objectName = object:getComponent("EntityName").entityName

    -- 100 current / 100 max should give 120/80. As you approach 0 with blood, the diastolic approaches systolic linearly
    local bloodVolumeRatio = (objectBloodComponent.bloodQuantity / objectBloodComponent.maxBloodQuantity)
    local systolicPressure = math.floor(bloodVolumeRatio * 120)
    local diastolicPressure = math.max(math.floor(systolicPressure - (bloodVolumeRatio*40)), 0)

    local message = objectName .. "\nBlood Pressure: " .. systolicPressure .. "/" .. diastolicPressure
    ChatService:Chat(instigatorEntityContainerComponent.entityContainer:WaitForChild("Head"), message, Enum.ChatColor.Blue)

	return true
end

function BloodPressureScan:instigatorInteractsWithSelfUsingToolMatches()
    return {
        instigatorMatches = { "Character", "Blood" },
        aiInstigatorRequires = { "MedicalAI" },
        toolMatches = { "BloodPressureMonitor" },
    }
end

function BloodPressureScan:instigatorInteractsWithSelfUsingTool(instigator, tool, interactionToolsProcessor)

    local instigatorBloodComponent = instigator:getComponent("Blood")
    
    local instigatorName = instigator:getComponent("EntityName").entityName

    -- 100 current / 100 max should give 120/80. As you approach 0 with blood, the diastolic approaches systolic linearly
    local bloodVolumeRatio = (instigatorBloodComponent.bloodQuantity / instigatorBloodComponent.maxBloodQuantity)
    local systolicPressure = math.floor(bloodVolumeRatio * 120)
    local diastolicPressure = math.max(math.floor(systolicPressure - (bloodVolumeRatio*40)), 0)

    local message = instigatorName .. "\nBlood Pressure: " .. systolicPressure .. "/" .. diastolicPressure
    local instigatorEntityContainerComponent = instigator:getComponent("EntityContainer")
    ChatService:Chat(instigatorEntityContainerComponent.entityContainer:WaitForChild("Head"), message, Enum.ChatColor.Blue)

	return true
end

return BloodPressureScan
