local players = game:GetService('Players')
local replicatedStorage = game:GetService('ReplicatedStorage')
local tweenService = game:GetService('TweenService')

local Parts = workspace.gameObjects.Parts
local HotelSections = workspace.gameObjects.HotelSections
local RHH = Parts.RHH

local Remotes = replicatedStorage.Remotes
local Events = Remotes.Events
local Functions = Remotes.Functions

local module = {}
local Selection = {
	'RHH_Hotel|DarkMatter';
	'RHH_Hotel|FrozenMatter';
}

local Toggle = false
local doorToggled = false
local RHH_On = false

function module.Check(hit)
	if hit.Parent:FindFirstChild('Humanoid') then
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		if doorToggled then
			Events.R0:FireClient(player, 'Entering_RHH')
			wait(1)
			doorToggled = false
		end
	end
end

function module.RHH_Exit(hit)
	if hit.Parent:FindFirstChild('Humanoid') then
		wait(0.2)
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		if doorToggled then
			Events.R0:FireClient(player, 'Leaving_RHH')
			wait(1)
			doorToggled = false
		end
	end
end

function module.RHH_Enter(hit)
	if hit.Parent:FindFirstChild('Humanoid') then
		local rando = math.random(1, #Selection)
		local selectedReciever = HotelSections[Selection[rando]]
		for _, v in pairs(selectedReciever:GetChildren()) do
			if v.Name == 'Recieve' then
				hit.Parent:FindFirstChild('HumanoidRootPart').CFrame = v.CFrame
			end
		end
	end
end

function module.ToggleDoor(player, part)
	if not Toggle then
		Toggle = true
		local origin = {}
		origin.Position = part.Position
		local finish = {}
		finish.Position = part.Position - Vector3.new(0, 3.625 * 2, 0)
		local tweenInfo = TweenInfo.new(0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut ,0 ,false ,0)
		local tween = tweenService:Create(part, tweenInfo, finish)
		if part.Parent.Name == 'RHH' then
			if not doorToggled then
				Events.R0:FireClient(player, 'Entering_RHH')
				wait(1)
				doorToggled = true
			end
		end
		tween:Play()
		wait(1)
		Toggle = false
		local tweenInfo2 = TweenInfo.new(0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut ,0 ,false ,0)
		local tween2 = tweenService:Create(part, tweenInfo2, origin)
		tween2:Play()
		wait(1)
	end
end

return module