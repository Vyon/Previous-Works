-- Services
local players = game:GetService('Players')

-- Variables
local SETTINGS = {
	Token = nil,
	Anti = nil
}

-- Modules
local listener = require(script.Parent.Listener)

-- Token Cache
local Cache = {}

-- Module
local token_service = { external = {} }
local external = token_service.external

-- Functions
local function GenerateToken()
	local length = 20
	local token = ''
	local chars = {
		'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
		'1', '2', '3', '4', '5', '6', '7', '8', '9', '0'
	}

	for i = 1, length do
		token = token .. chars[math.random(1, #chars)]
	end

	return token
end

function external.FetchToken(player)
	if (not Cache[player]) then
		Cache[player] = { Token = GenerateToken(), Remaining = 8, Started = false }

		return Cache[player].Token
	else
		player:Kick('\nUnfortunately you can only have 1 token per session.')
	end
end

function token_service:Init(token_settings, anti_settings)
	-- Create Settings
	local TokenSettings = SETTINGS.Token
	local AntiSettings = SETTINGS.Anti

	TokenSettings = token_settings
	AntiSettings = anti_settings

	-- Setup Connections
	token_settings.FETCH.OnServerInvoke = self.external.FetchToken

	listener:Create('PlayerAdded', players.PlayerAdded, function(player)
		repeat wait(1) until Cache[player]
		Cache[player].Started = true -- Used for when the player leaves "Started" will be false

		-- Start Sanity Check
		while wait(1) do
			if (Cache[player]) then
				if (Cache[player].Remaining <= 0) then
					player:Kick('It seems like something is missing.')
				elseif (Cache[player].Remaining > 0) then
					Cache[player].Remaining -= 1
				elseif (not Cache[player].Started) then
					break
				end
			else
				player:Kick('Your sanity is our priority.')
			end
		end
	end)

	listener:Create('PlayerRemoving', players.PlayerRemoving, function(player)
		Cache[player].Started = false
		wait(1)
		Cache[player] = nil -- Remove player from the cache for garbage collection
	end)

	listener:Create('ClientCheck', TokenSettings.CHECK.OnServerEvent, function(player, ...)
		local args = {...}
		local token = args[1]

		if (args[1] == Cache[player].Token) then
			if (args[2] == AntiSettings.WalkSpeed and args[3] == AntiSettings.JumpPower) then
				Cache[player].Remaining = 8
			else
				player:Kick('Must you be a sussy imposter?')
			end
		else
			player:Kick('Are you missing something?')
		end
	end)
end

return token_service