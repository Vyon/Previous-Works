--[[
	@Edits
	12/9/2021:
		Added debugger usage
--]]

local players = game:GetService('Players')
local debugger = require(script.Parent.Debugger).New()

local debug_statements = {
	Joined = function(player)
		warn(player.Name, 'has joined!')
	end
}

debugger:Register(debug_statements) --> Reads the dictionary content and adds listeners that can be called

players.PlayerAdded:Connect(function(player)
	debugger:Call('Joined', player) --> <debug_key: string>, ...(<player: instance>)
end)