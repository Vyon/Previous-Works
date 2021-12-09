-- Services
local players = game:GetService('Players')

-- Modules
local ps = require(script.Parent.ps)
local Settings = require(script.Parent.settings)

-- Data Store Stuff
local store = ps.GetProfileStore(Settings.store_name, Settings.store_base)

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
		return false
	end
end

function data.Release(player)
	local profile = Cache[player]
	if (profile) then
		profile:Release()
	end
end

return data