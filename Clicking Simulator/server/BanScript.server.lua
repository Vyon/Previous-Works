local DS = game:GetService("DataStoreService")
local BanDS = DS:GetDataStore("banData")

game.ReplicatedStorage.Remotes.BanPlayer.OnServerEvent:connect(function(player, reason)
	local puid = player.UserId
	local success, errormessage = pcall(function()
		BanDS:SetAsync(puid, true)
		player:Kick("[BANNED]")
	end)
end)