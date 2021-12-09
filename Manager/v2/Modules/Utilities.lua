-- Locals
local modules = script.Parent

-- Init ServiceManager
local manager = require(modules:WaitForChild('ServiceManager'))
local services = manager:Init()

-- Custom Services
local data = services.DataService

-- Module
local util = {}

function util.PlayerAdded(player)
	local profile = data.Load(player)

	print(profile)
end

function util.PlayerRemoving(player)
	data.Release(player)
end

return util