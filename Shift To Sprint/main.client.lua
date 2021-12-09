local UserInputService = game:GetService("UserInputService")

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.LeftShift then
		char.Humanoid.WalkSpeed = 30
	end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.LeftShift then
		char.Humanoid.WalkSpeed = 16
	end
end)