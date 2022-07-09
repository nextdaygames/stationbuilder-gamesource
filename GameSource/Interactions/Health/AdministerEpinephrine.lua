local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))
local ChatService = game:GetService("Chat")	

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local AdministerEpinephrine = class("AdministerEpinephrine", Interact)

function AdministerEpinephrine:init()
    self.aiActionCost = 1
    self.name = "AdministerEpinephrine"
end

function AdministerEpinephrine:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = { "MedicalAI" },
        objectMatches = {"Character"},
		toolMatches = {"AdministerEpinephrine"},
        aiActionPreconditions = {},
        aiActionEffects = {},
    }
end

function AdministerEpinephrine:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)
    local objectEpinephrineComponent = object:getComponent("Epinephrine")
    if objectEpinephrineComponent ~= nil then
        objectEpinephrineComponent.lastEpinephrineAdministerTime = os.time()
    else
        object:add(Components.Epinephrine:new())
    end

    local objectName = object:getComponent("EntityName").entityName
    local toolName = tool:getComponent("EntityName").entityName
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Administers " .. objectName .. " " .. toolName .. ".", Enum.ChatColor.Blue)
	return true
end

function AdministerEpinephrine:instigatorInteractsWithSelfUsingToolMatches()
    return {
        instigatorMatches = {"Character"},
        aiInstigatorRequires = { "MedicalAI" },
		toolMatches = {"AdministerEpinephrine"},
        aiActionPreconditions = {},
        aiActionEffects = {},
    }
end

function AdministerEpinephrine:instigatorInteractsWithSelfUsingTool(instigator, tool, interactionToolsProcessor)
    local instigatorEpinephrineComponent = instigator:getComponent("Epinephrine")
    if instigatorEpinephrineComponent ~= nil then
        instigatorEpinephrineComponent.lastEpinephrineAdministerTime = os.time()
    else
        instigator:add(Components.Epinephrine:new())
    end

	local instigatorName = instigator:getComponent("EntityName").entityName
    local toolName = tool:getComponent("EntityName").entityName
	local instigatorEntityContainer = instigator:getComponent("EntityContainer")
    ChatService:Chat(instigatorEntityContainer.entityContainer:WaitForChild("Head"), "Administers themselves " .. toolName .. ".", Enum.ChatColor.Blue)

	return true
end

return AdministerEpinephrine
