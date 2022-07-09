local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local ShopPrompt = class("ShopPrompt", ECS.Component)

function ShopPrompt:initialize(shopPromptTriggeredSignal)
	if shopPromptTriggeredSignal == nil then
		error("shopPromptTriggeredSignal not initialized")
	end
	self.shopPromptTriggeredSignal = shopPromptTriggeredSignal
	
	self.name = "ShopPrompt"
end


function ShopPrompt.desc()
	return "Stores this entity's ShopPrompt."
end

return ShopPrompt
