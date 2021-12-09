-- Services
local repl = game:GetService('ReplicatedStorage')

-- Locals
local remotes = repl.Remotes

-- Remotes
local ar = remotes.AbilityRequest

-- Variables
local whitelisted = { Enum.KeyCode.G }

-- Module
local util = {}

function util.HookInput(input, gpe)
	if (gpe) then return end

	if (table.find(whitelisted, input.KeyCode)) then
		ar:FireServer(input.KeyCode)
	end
end

return util