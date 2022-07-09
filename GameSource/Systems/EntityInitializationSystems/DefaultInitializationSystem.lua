local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local DefaultInitializationSystem = class("DefaultInitializationSystem", ECS.InitializationSystem)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

function DefaultInitializationSystem:initialize(world, isDebug)
	ECS.InitializationSystem.initialize(self)
	self.name = "DefaultInitializationSystem"

    -- The workspace
	if world == nil then
		error("world not initialized")
	end
	self.world = world

	self.isDebug = isDebug ~= nil and isDebug or false	
end

-- Entities to keep track of
function DefaultInitializationSystem:matchingGroups()
	return {
        -- We keep track of player metal fans, we can name this group anything.
        ["PlayersMetalFans"] = { 
            "PlayerControlled", -- Player controlled 
            "ListensToMetal"  -- Who listen to metal
        },
    }
end

-- Entities to Initialize, in this case players who like bad games, 
-- don't listen to metal, and are scuffed or lame or get a load of this guy 
function DefaultInitializationSystem:matches()
	return {  
        "PlayerControlled", -- A player controlled entity 
        "LikesBadGames", -- Matching this component, in this case they have the component 'LikesBadGames'
        "-ListensToMetal", -- Does not have the 'ListensToMetal' component
        "Scuffed/Lame" -- Has any of these components
    }
end

function DefaultInitializationSystem:initializeEntity(entity)
	-- Entity in this case is our lame/scuffed non-metal player who likes bad games

    -- We can access our player metal fans by calling
    -- self.entityGroups["ListensToMetal"]
end

return DefaultInitializationSystem