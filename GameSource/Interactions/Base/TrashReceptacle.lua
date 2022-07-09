local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local ChatService = game:GetService("Chat")	

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local TrashReceptacle = class("TrashReceptacle", Interact)

function TrashReceptacle:init()
    self.aiActionCost = 1
    self.name = "TrashReceptacle"
end

function TrashReceptacle:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = { "DefaultAI" },
        objectMatches = {"TrashReceptacle"},
        toolMatches = {},
    }
end

function TrashReceptacle:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)

    tool:add(Components.Debris:new(0))

    local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    local instigatorName = instigator:getComponent("EntityName").entityName
	local objectName = object:getComponent("EntityName").entityName
    local toolName = tool:getComponent("EntityName").entityName
    ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Tosses the " .. toolName .. " into the " .. objectName .. ".", Enum.ChatColor.Blue)

	return true
end

return TrashReceptacle
