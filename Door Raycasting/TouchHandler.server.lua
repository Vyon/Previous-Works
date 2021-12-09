--| VyonEXE

--| Services
local plrs = game:GetService('Players')

--| Modules
local tM = require(script.touchModule)

--| Locals
local Parts = workspace.gameObjects.Parts
local hotelSections = workspace.gameObjects.HotelSections
local RHH = Parts.RHH
local DM = hotelSections['RHH_Hotel|DarkMatter']
local FM = hotelSections['RHH_Hotel|FrozenMatter']

--| Variables
local Toggle = false

--| Player
plrs.PlayerAdded:Connect(function(player)
	local char = player.Character or player.CharacterAdded:Wait()
	local root = char:WaitForChild('HumanoidRootPart')

	local rinfo = RaycastParams.new()
	rinfo.FilterType = Enum.RaycastFilterType.Blacklist
	rinfo.FilterDescendantsInstances = {char}

	while wait(0.05) do
		local result = workspace:Raycast(root.Position, root.CFrame.LookVector * 15, rinfo)
		if result then
			local parthit = result.Instance
			if parthit.Name == 'Door' and not Toggle then
				Toggle = true
				tM.ToggleDoor(player, parthit)
				wait(0.5)
				Toggle = false
			end
		end
	end
end)

--| Functions

RHH.RHH_Exit.Touched:Connect(tM.RHH_Exit)

RHH.RHH_Enter.Touched:Connect(tM.RHH_Enter)

RHH.ReCheck.Touched:Connect(tM.Check)