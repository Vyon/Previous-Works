-- Services
local players = game:GetService('Players')
local uis = game:GetService('UserInputService')
local run = game:GetService('RunService')
local ts = game:GetService('TweenService')
local repl = game:GetService('ReplicatedStorage')
local lighting = game:GetService('Lighting')

-- Player
local player = players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local cam = workspace.CurrentCamera

-- Locals
local remotes = repl.Remotes

-- Remotes
local ar = remotes.AbilityRequest

-- Modules
local util = require(script.Parent.util)

-- Variables
local visuals_active = false

-- Tables
local c = {}

-- Functions
local function CreateEnv(p1)
	local x, z = math.random(2500, 5000), math.random(2500, 5000)

	local ENV = {
		['Floor'] = {
			Name = 'Floor',
			ClassName = 'Part',
			Parent = p1,
			CastShadow = false,
			Color = Color3.fromRGB(0, 0, 0),
			Material = Enum.Material.Grass,
			Position = Vector3.new(x, 1, z),
			Anchored = true,
			Size = Vector3.new(250, 20, 250)
		}
	}

	local instances = {}

	local Create = function(class, props)
		local inst = Instance.new(class)

		for i, v in pairs(props) do
			if (i ~= 'ClassName') then
				inst[i] = v
			end
		end

		return inst
	end

	for i, v in pairs(ENV) do
		instances[i] = Create(v.ClassName, v)
	end

	return instances
end

local function StartVisuals(p1, p2)
	local Original = function(fake)
		local contents = fake:split('\\')
		local original = {}

		for i = 1, #contents do
			if (contents[i] ~= '' and contents[i] ~= ' ') then
				table.insert(original, string.char(tonumber(contents[i])))
			end
		end

		return tostring(table.concat(original)):reverse()
	end

	local _name = Original(p2)
	local _player = players[_name]
	local char, _char = player.Character, _player.Character

	-- Prepare for cloning
	char.Archivable, _char.Archivable = true, true

	-- Clone and anchor
	char, _char = char:Clone(), _char:Clone()
	char.PrimaryPart.Anchored, _char.PrimaryPart.Anchored = true, true
	char.Parent, _char.Parent = p1, p1

	local ENV = CreateEnv(p1)
	cam.CameraSubject = char:WaitForChild('Humanoid')

	local animator = character:WaitForChild('Humanoid').Animator

	c['AnimationPlayed'] = animator.AnimationPlayed:Connect(function(track)
		local hum = char:WaitForChild('Humanoid')
		local _animator = hum.Animator
		local clone = _animator:LoadAnimation(track.Animation)

		local current_track

		clone:Play()

		current_track = track.Stopped:Connect(function()
			current_track:Disconnect()
			clone:Stop()
		end)
	end)

	c['Stepped'] = run.Stepped:Connect(function()
		if (character.Parent) then
			-- Invert hitbox cframe and multiply current player's cframe (lower CFrame * higher CFrame)
			-- clone:SetPrimaryPartCFrame(env.CFrame * distance)
			
			local dist = workspace.Baseplate.CFrame:Inverse() * character.PrimaryPart.CFrame
			char:SetPrimaryPartCFrame(ENV.Floor.CFrame * dist)
		else
			player.CharacterAdded:Wait()
		end
	end)
end

local function EndVisuals(p1)
	cam.CameraSubject = character:WaitForChild('Humanoid')

	-- Clean up connections
	for i, v in pairs(c) do
		v:Disconnect()
	end

	table.clear(c)
	p1:Destroy()
end

-- Connections
uis.InputBegan:Connect(util.HookInput)
ar.OnClientEvent:Connect(function(p1, p2)
	local _props = { Brightness = 3, ClockTime = 14.5, ExposureCompensation = 0, FogEnd = 100000, FogStart = 0 }
	local _fake = { Brightness = 0, ClockTime = 0, ExposureCompensation = -0.55, FogEnd = 500, FogStart = 25 }

	if (p1) then
		EndVisuals(workspace:FindFirstChild('Temp'))
		local info = TweenInfo.new(2, Enum.EasingStyle.Linear)

		local tween = ts:Create(lighting, info, _props)
		tween:Play()
		tween.Completed:Wait()
	elseif (not p1 and not workspace:FindFirstChild('Temp')) then

		local folder = Instance.new('Folder', workspace)
		local info = TweenInfo.new(1, Enum.EasingStyle.Linear)

		local tween = ts:Create(lighting, info, _fake)
		tween:Play()

		tween.Completed:Wait()
		folder.Name = 'Temp'

		StartVisuals(folder, p2)
	else
		return
	end
end)