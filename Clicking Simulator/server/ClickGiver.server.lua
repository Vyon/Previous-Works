game.ReplicatedStorage.Remotes.GiveClicks.OnServerEvent:Connect(function(player)
	player.leaderstats.Clicks.Value = player.leaderstats.Clicks.Value + player.ClickData["Click_Multiplier"].Value
	player.ClickData.TotalClicks.Value = player.ClickData.TotalClicks.Value + player.ClickData["Click_Multiplier"].Value
	wait(2)
end)