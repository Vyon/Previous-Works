local UserInputService = game:GetService("UserInputService")
local replicatedStorage = game:GetService("ReplicatedStorage")

repeat wait() until script.playerModule

local playerModule = require(script.PlayerModule)

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

UserInputService.InputBegan:Connect(function(input, typing)
	if not typing then
		if input.KeyCode == Enum.KeyCode.F and playerModule.cd1 == false and player.Character.Humanoid:WaitForChild("Animator") then
			playerModule.Archway(player)
		end
		if input.KeyCode == Enum.KeyCode.E and playerModule.cd2 == false and player.Character.Humanoid:WaitForChild("Animator") then
			playerModule.Void_Circle(player)
		end
		if input.KeyCode == Enum.KeyCode.Q and playerModule.cd4 == false and player.Character.Humanoid:WaitForChild("Animator") then
			playerModule.FireBall(player)
		end
		if input.KeyCode == Enum.KeyCode.C and playerModule.cd5 == false and player.Character.Humanoid:WaitForChild("Animator") then
			playerModule.JumpKick(player)
		end
	end
end)