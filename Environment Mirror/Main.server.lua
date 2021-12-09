-- Services
local repl = game:GetService('ReplicatedStorage')
local players = game:GetService('Players')

-- Locals
local remotes = repl.Remotes

-- Remotes
local ar = remotes.AbilityRequest

-- Modules
local util = require(script.Parent.util)

for _, v in ipairs(players:GetPlayers()) do
	task.spawn(util:UpdateCache(v))
end

players.PlayerAdded:Connect(util.UpdateCache)

ar.OnServerEvent:Connect(util.RequestSanity)