local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})
local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local DeepFry = class("DeepFry", Interact)

function DeepFry:init()
    self.aiActionCost = 1
    self.name = "DeepFry"
end

function DeepFry:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = { "Character" },
        aiInstigatorRequires = {},
        objectMatches = {"DeepFrier"},
        toolMatches = { "-DeepFried" },
    }
end

function DeepFry:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)
    print("Deep fry!")
    tool:add(Components.DeepFried:new())

    local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    local messageSource = instigatorEntityContainer.entityContainer:WaitForChild("Head")

	local toolName = tool:getComponent("EntityName").entityName
    local objectName = object:getComponent("EntityName").entityName
    local message = "Deep fries the " .. toolName .. " using the " .. objectName .. "."

    ChatService:Chat(messageSource, message, Enum.ChatColor.Blue)

	return true
end

return DeepFry
