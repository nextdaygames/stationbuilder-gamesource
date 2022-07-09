local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage", Utility))
local Get = require(GetReplicatedStorage("Get", Utility))

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Components = Flatten({"GameSource/Components", "PrivateGameSource/Components"})
local ChatService = game:GetService("Chat")	

local class = Get("Lib/middleclass")

local PickUpTool = Get("PrivateGameSource/Interactions/ToolHandling/PickUpTool")
local PickUpMoneyNotTracked = class("PickUpMoneyNotTracked", PickUpTool)

function PickUpMoneyNotTracked:init()
    self.aiActionCost = 1
    self.name = "PickUpMoneyNotTracked"
end

function PickUpMoneyNotTracked:instigatorInteractsWithObjectMatches()
    return {
        instigatorMatches = {"Character", "-TrackedMoney"},
		aiInstigatorRequires = { "DefaultAI" },
        objectMatches = {"Tool", "Money"},
    }
end

return PickUpMoneyNotTracked