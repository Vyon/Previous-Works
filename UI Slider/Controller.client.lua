local min, max, start = 10, 100, 50

local p = game.Players.LocalPlayer
local m = p:GetMouse()

local output = script.Parent:WaitForChild('Output')

local bg = script.Parent:WaitForChild('BG')
local len = bg.Length
local tick = bg.Tick
local adjust = bg.Adjust

local active = false

local function Value(val)
	print(val)
end

local function Update(val)
	local p_x = bg.AbsolutePosition.X
	local s_o = bg.AbsoluteSize.X

	local clamp = math.clamp((val - p_x), 0, s_o)

	local new_pos = (max - min) * (clamp / s_o) + min
	local current = math.floor(new_pos)

	tick.Position = UDim2.new(0, clamp, .5, 0)
	len.Size = UDim2.new(0, clamp, 0, 15)
	output.Text = current
	pcall(Value, current)
end

tick.MouseButton1Down:Connect(function()
	active = true
end)

adjust.MouseButton1Down:Connect(function()
	active = true
	Update(m.X)
end)

output.FocusLost:Connect(function()
	local p_x = bg.AbsolutePosition.X
	local s_o = bg.AbsoluteSize.X
	local num = tonumber(output.Text)

	local result = (num - min) / (max - min)
	local pixels = (result * s_o) + p_x

	Update(pixels)
end)

game:GetService('UserInputService').InputChanged:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseMovement and active) then
		Update(input.Position.X)
	end
end)

game:GetService('UserInputService').InputEnded:Connect(function(input)	
	if (input.UserInputType == Enum.UserInputType.MouseButton1 and active) then
		active = false
	end
end)