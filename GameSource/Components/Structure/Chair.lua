local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local Chair = class("Chair", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})


function Chair:initialize(position, orientation, canSwivel)

    if position == nil then
		error("nil position")
	end
	self.position = position

	if orientation == nil then
		error("nil orientation")
	end
	self.orientation = orientation

    if canSwivel == nil then
		error("nil canSwivel")
	end
    local stringtoboolean={ ["true"]=true, ["false"]=false }
	self.canSwivel = stringtoboolean[canSwivel]

	self.name = "Chair"
end

function Chair.category()
	return Enums.ComponentCategory.Furniture
end

function Chair.displayName()
	return "Seat a Character"
end

function Chair.createFromParameters(params)
	return Chair:new(params["SeatPosition"], params["SeatOrientation"], params["Can Swivel?"])
end

function Chair.requirements()
	return {
        ["SeatPosition"] = Enums.ValidEntryTypes.Vector3,
        ["SeatOrientation"] = Enums.ValidEntryTypes.Vector3,
        ["Can Swivel?"] = Enums.ValidEntryTypes.SelectOneOption
	}
end

function Chair.options()
	return {
		["Can Swivel?"] = "true,false"
	}
end

function Chair.defaults()
	return {
        ["SeatPosition"] = Vector3.new(0,0,0),
        ["SeatOrientation"] = Vector3.new(0,0,0),
        ["Can Swivel?"] = "false",
	}
end

function Chair.dependsOnComponents()
	return {}
end

function Chair.mutuallyExclusive()
	return { "TopLevelTool" }
end

function Chair.tags()
	return {}
end

function Chair.desc()
	return "Allow characters to weld to this item if they get close enough."
end

return Chair