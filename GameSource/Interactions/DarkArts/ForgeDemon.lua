local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})
local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")
local Interact = Get("Source/Interaction/Interaction")

local ForgeDemon = class("ForgeDemon", Interact)

function ForgeDemon:init()
    self.aiActionCost = 1
    self.name = "ForgeDemon"
end

function ForgeDemon:instigatorInteractsWithObjectUsingToolMatches()
    return {
        instigatorMatches = {"Character"},
		aiInstigatorRequires = { },
        objectMatches = {"Character"},
        toolMatches = {"ForgeDemonFromDeceased"},
    }
end

function ForgeDemon:instigatorInteractsWithObjectUsingTool(instigator, object, tool, interactionToolsProcessor)
	local interactedCharacterComponent = object:getComponent("Character")

	if interactedCharacterComponent.character == nil then
		return false
	end

	local humanoid = interactedCharacterComponent.character:FindFirstChild("Humanoid")
	if humanoid == nil then
		return false
	end
	local humanoidRootPart = interactedCharacterComponent.character:FindFirstChild("HumanoidRootPart")
	if humanoidRootPart == nil then
		return false
	end

	local instigatorContainer = instigator:getComponent("EntityContainer")
	local objectName = object:getComponent("EntityName").entityName
    local objectName = object:getComponent("EntityName").entityName
    local instigatorName = instigator:getComponent("EntityName").entityName
    ChatService:Chat(instigatorContainer.primaryPart, instigatorName .. " forges " .. objectName .. " into a demon using the " .. objectName .. ".", "White")
   
	local spawnPosition = humanoidRootPart.Position + Vector3.new(0,5,0)
	local interactedPlayerControlledComponent = object:getComponent("PlayerControlled")
	object:add(Components.Debris:new(0))

	local components = {
		Components.RenderCharacter:new(),
        Components.EntityName:new("Demon"),
		Components.SpawnAt:new(spawnPosition),
		Components.IntelligenceMaker:new({"Wander"}),
		Components.ClickablePartMaker:new(Vector3.new(0,0,0), Vector3.new(2,2,2), Vector3.new(0,0,0)),
		Components.Materials:new("flesh"),
	}
	if interactedPlayerControlledComponent ~= nil then
		table.insert(components, Components.PlayerControlled:new(interactedPlayerControlledComponent.player))
	end
	interactionToolsProcessor:createItemWithComponents(components)

	object:add(Components.Debris:new(0))
	return true
end

return ForgeDemon
