local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local BreakRestraintsSystem = class("BreakRestraintsSystem", ECS.System)
local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

function BreakRestraintsSystem:initialize()
	ECS.System.initialize(self)
	self.ambientTempFarenheit = 72
	self.name = "BreakRestraintsSystem"
end


function BreakRestraintsSystem:matchingGroups()
	return {
		["Restrained"] = { "Restrained", "Character" }
	}
end

function BreakRestraintsSystem:update(dt)
	if next(self.entityGroups) == nil then
		return
	end
	
	for _, entity in pairs(self.entityGroups["Restrained"]) do
		
		local restrainedComponent = entity:getComponent("Restrained")

		if os.time() > restrainedComponent.startTime + restrainedComponent.duration then
			entity:removeComponent("Restrained")

			local characterComponent = entity:getComponent("Character")
			if characterComponent == nil then
				warn("No interacted character.")
				continue
			end

			if characterComponent.character == nil then
				continue
			end

			local humanoid = characterComponent.character:FindFirstChild("Humanoid")
			if humanoid == nil then
				continue
			end

			humanoid.WalkSpeed = humanoid.WalkSpeed * 2
		end
		
	end
end

return BreakRestraintsSystem