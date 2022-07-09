local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local DefaultInteraction = class("DefaultInteraction", Interact)

function DefaultInteraction:init()
    self.aiActionCost = 1
    self.name = "DefaultInteraction"
end

function DefaultInteraction:instigatorInteractsWithObjectMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = { "DefaultAI" },
        objectMatches = {"Notice"},
    }
end

function DefaultInteraction:instigatorInteractsWithObject(instigator, object, interactionToolsProcessor)
	
    local objectName = object:getComponent("EntityName").entityName
    local objectMessage = object:getComponent("Notice").message
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "The " .. objectName .. " reads \"" .. objectMessage .."\"", Enum.ChatColor.White)

    return true
end

return DefaultInteraction
