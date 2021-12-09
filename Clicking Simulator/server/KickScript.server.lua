game.ReplicatedStorage.Remotes.KickPlayer.OnServerEvent:connect(function(player, playerToKick, reason)
    game.Players:FindFirstChild(playerToKick):Kick(reason)
end)