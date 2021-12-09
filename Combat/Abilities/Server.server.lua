local replicatedStorage = game:GetService("ReplicatedStorage")
local Events = replicatedStorage.Events

local eventModule = require(script.EventModule)

Events.playerEvent.OnServerEvent:Connect(function(player, Type)
	if Type == "Archway" then
		eventModule.Archway(player)
	end
	if Type == "VoidSphere" then
		eventModule.Void(player)
	end
	if Type == "FireBall" then
		eventModule.FireBall(player)
	end
	if Type == "JumpKick" then
		eventModule.JumpKick(player)
	end
end)