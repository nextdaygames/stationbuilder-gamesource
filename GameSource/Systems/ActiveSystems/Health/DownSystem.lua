local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local ChatService = game:GetService("Chat")

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local DownSystem = class("DownSystem", ECS.System)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

function DownSystem:initialize()
	ECS.System.initialize(self)
	self.name = "DownSystem"
end

function DownSystem:matchingGroups()
	return {
        ["DownedCharacters"] = { "Character", "Downable", "Downed" },
        ["DownableCharacters"] = { "Character", "Downable", "-Downed" }
    }
end

function DownSystem:update(dt)
	for _, entity in pairs(self.entityGroups["DownableCharacters"]) do
        local characterComponent = entity:getComponent("Character")
        if characterComponent.character == nil then
            continue
        end
        
		local downableComponent = entity:getComponent("Downable")
		if not downableComponent:shouldBeDowned() then
			continue
		end
        
		ChatService:Chat(characterComponent.character.primaryPart, "*Passes Out*", Enum.ChatColor.Blue)
		entity:add(Components.Downed:new())
	end

	for _, entity in pairs(self.entityGroups["DownedCharacters"]) do
        local characterComponent = entity:getComponent("Character")
        if characterComponent.character == nil then
            continue
        end

		local downableComponent = entity:getComponent("Downable")
		if downableComponent:shouldBeDowned() then
			continue
		end
        
		ChatService:Chat(characterComponent.character.primaryPart, "*Regains Consciousness*", Enum.ChatColor.Blue)
		entity:removeComponent("Downed")
	end
end

return DownSystem