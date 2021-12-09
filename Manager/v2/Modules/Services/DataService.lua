-- Services
local players = game:GetService('Players')

-- Collect Dependencies
local services = script.Parent
local modules = services.Parent
local manager = require(modules:WaitForChild('ServiceManager'))
local dep = manager.Collect(script.Name)

-- Modules
local ps = dep.ProfileService
local _settings = dep.Settings

-- Data Store Stuff
local store = ps.GetProfileStore(_settings.store_name, _settings.store_base)

-- Variables
local data = {}
local Cache = {}

-- Module Functions
function data.Load(player)
	local profile = store:LoadProfileAsync(tostring(player.UserId), 'ForceLoad')
		
	if (profile) then
		profile:Reconcile()
		profile:ListenToRelease(function()
			Cache[player] = nil
			player:Kick('\nUnable to load data, please rejoin.')
		end)
		if (players[player.Name]) then
			Cache[player] = profile
			return Cache[player].Data
		else
			profile:Release()
		end
	else
		player:Kick('\nFailure to load data.\n' .. os.date('Time: %I:%M %p\nDate: %x'))
	end
end

function data.Fetch(player)
	if (Cache[player]) then
		return Cache[player].Data
	else
		warn(player.Name, 'is not in the cache.')
	end
end

function data.Release(player)
	local profile = Cache[player]
	if (profile) then
		profile:Release()
	end
end

return data