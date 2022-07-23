local Utility = game.ReplicatedStorage:WaitForChild("Utility")
local GetReplicatedStorage = require(Utility:WaitForChild("GetReplicatedStorage"))
local Get = require(GetReplicatedStorage("Get", Utility))

local class = Get("Lib/middleclass")
local ECS = Get("Lib/ECS")
local FingerprintScanner = class("FingerprintScanner", ECS.Component)

local Flatten = Get("Utility/FlattenDecendantsIntoDictonary")
local Enums = Flatten({"Enums"})
function FingerprintScanner:initialize()
	self.name = "FingerprintScanner"
end

function FingerprintScanner.category()
	return Enums.ComponentCategory.Crime
end

function FingerprintScanner.displayName()
	return "Fingerprint Finder"
end

function FingerprintScanner.createFromParameters(params)
	return FingerprintScanner:new()
end

function FingerprintScanner.tags()
	return {}
end

function FingerprintScanner.requirements()
	return {
	}
end

function FingerprintScanner.defaults()
	return {
		
	}
end

function FingerprintScanner.mutuallyExclusive()
	return {  }
end

function FingerprintScanner.dependsOnComponents() 
	return { "TopLevelTool" }
end

function FingerprintScanner.desc()
	return "Reads out the ID of the last person to touch an item."
end

return FingerprintScanner