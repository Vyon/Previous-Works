-- Services
local players = game:GetService('Players')

-- Locals
local modules = script.Parent.Modules

-- Modules
local util = require(modules:WaitForChild('Utilities'))

-- Setup
for _, v in pairs(players:GetPlayers()) do
	task.spawn(util.PlayerAdded(v))
end

-- Connections
players.PlayerAdded:Connect(util.PlayerAdded)
players.PlayerRemoving:Connect(util.PlayerRemoving)