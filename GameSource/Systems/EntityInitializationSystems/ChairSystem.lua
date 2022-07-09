local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local ChairSystem = class("ChairSystem", ECS.InitializationSystem)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})

function ChairSystem:initialize(isDebug)
	ECS.InitializationSystem.initialize(self)
	self.name = "ChairSystem"
	
	self.isDebug = isDebug ~= nil and isDebug or false
end

function ChairSystem:matches()
	return { "Chair", "EntityContainer" }
end

function ChairSystem:initializeEntity(entity)
	local chairComponent = entity:getComponent("Chair")
	local entityContainerComponent = entity:getComponent("EntityContainer")
	
	local seat = Instance.new("Seat")
	seat.Size = Vector3.new(seat.Size.X, 1, seat.Size.Y)
	seat.Position = Vector3.new(chairComponent.position.X, chairComponent.position.Y-0.5, chairComponent.position.Z)
	seat.Orientation = chairComponent.orientation
	seat.Transparency = self.isDebug and 0 or 1
	seat.Color = Color3.new(0,1,0)
	seat.Material = Enum.Material.ForceField
	seat.Name = "Seat"
	seat.CanCollide = true
	seat.CanTouch = true
	seat.CanQuery = false

	if self.isDebug then
		local surfaceGui = Instance.new("SurfaceGui", seat)
		surfaceGui.Adornee = seat
		surfaceGui.Face = "Front"
	end

	local weld = Instance.new("WeldConstraint")
	weld.Name = "ChairWeld"
	weld.Part0 = entityContainerComponent.primaryPart
	weld.Part1 = seat

	seat.Parent = entityContainerComponent.entityContainer
	weld.Parent = entityContainerComponent.entityContainer
end

return ChairSystem