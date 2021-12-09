local players =  game:GetService("Players")
local dss = game:GetService("DataStoreService")
local datastore = dss:GetDataStore("player_Data3")

local tries = 3
local dataLoaded = false

-- // Sets/Saves Player Data \\ --
local function Set(player)
	if dataLoaded then
		local key = ("Player_"..player.UserId)
		local count = 0

		local data = {
			["ClickPrice"] = player.ClickData.ClickPrice.Value,
			["WalkPrice"] = player.ClickData.WalkPrice.Value,
			["PrestigePrice"] = player.ClickData.PrestigePrice.Value,
			["WalkSpeed"] = player.ClickData.WalkSpeed.Value,
			["Clicks"] = player.leaderstats.Clicks.Value,
			["ClickMultiplier"] = player.ClickData.Click_Multiplier.Value,
			["TotalClicks"] = player.ClickData.TotalClicks.Value,
			["Prestige"] = player.ClickData.Prestige.Value
		}
		local success, errormessage

		repeat 
			success, errormessage = pcall(function()
				datastore:SetAsync(key,data)
			end)	
		until count >= tries or success
		if not success then
			warn("Failed to save Data. Error Code: ".. tostring(errormessage))
			return	
		end
	else
		return
	end
end

-- // Loads Player Data \\ --
local function Get(player)
	local key = ("Player_"..player.UserId)
	local count = 0

	local data

	local success, errormessage

	repeat
		success, errormessage = pcall(function()
			data = datastore:GetAsync(key)
		end)

		count = count + 1

	until count >= tries or success

	if not success then
		warn("Failed to read data. Error Code: ".. tostring(errormessage))

		player:Kick(player.Name" , Your data has failed to save please rejoin and try again!")

		return
	end

	if success then 
		if data then
			return data
		else
			return {
				["ClickPrice"] = 1000,
				["WalkPrice"] = 10000,
				["PrestigePrice"] = 500000,
				["WalkSpeed"] = 16,
				["Clicks"] = 0,
				["ClickMultiplier"] = 1,
				["TotalClicks"] = 0,
				["Prestige"] = 0
			}
		end
	end
end

-- // Creates  ClickData \\ --
local function stats(player)
	local values = Get(player)

	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local ClickData = Instance.new("Folder")
	ClickData.Name = "ClickData"
	ClickData.Parent = player

	local ClickPrice = Instance.new("IntValue")
	ClickPrice.Name = "ClickPrice"
	ClickPrice.Parent = ClickData

	local WalkPrice = Instance.new("IntValue")
	WalkPrice.Name = "WalkPrice"
	WalkPrice.Parent = ClickData

	local PrestigePrice = Instance.new("IntValue")
	PrestigePrice.Name = "PrestigePrice"
	PrestigePrice.Parent = ClickData

	local WalkSpeed = Instance.new("IntValue")
	WalkSpeed.Name = "WalkSpeed"
	WalkSpeed.Parent = ClickData

	local C = Instance.new("IntValue")
	C.Name = "Clicks"
	C.Parent = leaderstats

	local CM = Instance.new("IntValue")
	CM.Name = "Click_Multiplier"
	CM.Parent = ClickData

	local TC = Instance.new("IntValue")
	TC.Name = "TotalClicks"
	TC.Parent = ClickData

	local Prestige = Instance.new("IntValue")
	Prestige.Name = "Prestige"
	Prestige.Parent = ClickData

	ClickPrice.Value = values.ClickPrice
	WalkPrice.Value = values.WalkPrice
	PrestigePrice.Value = values.PrestigePrice
	WalkSpeed.Value = values.WalkSpeed
	C.Value = values.Clicks
	CM.Value = values.ClickMultiplier
	TC.Value = values.TotalClicks
	Prestige.Value = values.Prestige

	dataLoaded = true
end
players.PlayerRemoving:Connect(Set)
players.PlayerAdded:Connect(stats)

game:BindToClose(function()
	for i, v in next, game.Players:GetChildren() do
		if v then
			Set(v)
		end
	end
end)