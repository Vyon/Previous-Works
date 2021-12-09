local DS = game:GetService("DataStoreService")
local BanDS = DS:GetDataStore("banData")

game.Players.PlayerAdded:Connect(function(player)
	local puid = player.UserId
	local banned
	local success, errormessage = pcall(function()
		banned = BanDS:GetAsync(puid)
	end)

	if banned == true then
		player:Kick("[BANNED]")
	end
end)