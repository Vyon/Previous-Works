--[[
	@Edits
	12/9/2021:
		Removed deprecated methods
		Removed unused variables
		Added toggle
--]]

-- This code is slightly edited from a tutorial made by MaplGalaxy
-- LINK: https://www.youtube.com/watch?v=w7M9oQDnBKs&ab_channel=MaplGalaxy

local Player = game.Players.LocalPlayer
repeat task.wait() until Player.Character
local c = Player.Character

local mouse = Player:GetMouse()

local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")

local toggle = false
local Target = nil
local CamBlock = Instance.new("Part", workspace.CurrentCamera)
CamBlock.Size = Vector3.new(1,1,1)
CamBlock.Transparency = 1
CamBlock.CanCollide = false
local BP = Instance.new("BodyPosition", CamBlock)
BP.maxForce = Vector3.new(math.huge,math.huge,math.huge)
BP.D = 500

UIS.InputBegan:Connect(function(input,gpe)
	if gpe then return end

	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		if mouse.Target and mouse.Target.Parent:FindFirstChild("Humanoid") then
			toggle = true
			Target = mouse.Target.Parent
			CamBlock.Position = CFrame.new(c.HumanoidRootPart.Position, Target.PrimaryPart.Position)*CFrame.new(0,4,9).Position
			BP.Position = CFrame.new(c.HumanoidRootPart.Position, Target.PrimaryPart.Position)*CFrame.new(0,4,9).Position
		else
			Target = nil
		end
	end
end)

UIS.InputEnded:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseButton2 and toggle) then
		toggle = false
	end
end)

RS.RenderStepped:Connect(function()
	if toggle and Target and (c.HumanoidRootPart.Position-Target.PrimaryPart.Position).magnitude < 80 and Target.Humanoid ~= nil and Target.Humanoid.Health > 0 and c.Humanoid ~= nil and c.Humanoid.Health > 0 then 
		local CamPos = CFrame.new(c.HumanoidRootPart.Position, Target.PrimaryPart.Position)*CFrame.new(0,4,9).Position
		BP.Position = CamPos
		workspace.CurrentCamera.CameraType = "Scriptable"
		workspace.CurrentCamera.CFrame = CFrame.new(CamBlock.Position,Target.PrimaryPart.Position)
	else
		Target = nil
		workspace.CurrentCamera.CameraType = "Custom"
	end
end)