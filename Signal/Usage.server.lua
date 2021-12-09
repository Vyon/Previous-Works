--[[
	@Edits
	12/9/2021:
		Added signal usage
--]]

local signal = require(script.Signal).New()

local connection = signal:Connect(function()
	print('Hello World!')
end)

signal:Fire() --> Activates signal

signal:Disconnect(connection)

signal:Fire() --> Tests if the signal is still active