local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local ChatService = game:GetService("Chat")	
local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local ScanFingerprints = class("ScanFingerprints", Interact)

function ScanFingerprints:init()
    self.aiActionCost = 1
    self.name = "ScanFingerprints"
end

function ScanFingerprints:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = { },
        objectMatches = { "TopLevelTool" },
        toolMatches = {"FingerprintScanner"},
    }
end

function ScanFingerprints:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)

    local fingerprintComponent = tool:getComponent("Fingerprint")
    
    local instigatorEntityContainer = instigator:getComponent("EntityContainer")
	local objectName = object:getComponent("EntityName").entityName

    local message = "The " .. objectName .. " has the finger prints that match Employee: " .. fingerprintComponent.lastHeldByPlayerId .. "."
    ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), message, Enum.ChatColor.Blue)
    
	return true
end


return ScanFingerprints
