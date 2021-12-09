local MarketplaceService = game:GetService("MarketplaceService")
local DSS = game:GetService("DataStoreService")
local purchaseHistoryDS = DSS:GetDataStore("purchases1")
local players = game:GetService("Players")
local donationId = 1077794725
local x10Id = 1077792841
local x100Id = 1077793972

MarketplaceService.ProcessReceipt = function(receipt)
	local ID = "Player_"..receipt.PlayerId

	local success = nil

	pcall(function()
		success = purchaseHistoryDS:GetAsync(ID)
	end)

	if success then

		return Enum.ProductPurchaseDecision.PurchaseGranted
	end

	local player = game.Players:GetPlayerByUserId(receipt.PlayerId)

	if not player then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	else

		if receipt.ProductId == donationId then
			player.PlayerGui.Main.DonationFrame.Visible = true
			wait(10)
			player.PlayerGui.Main.DonationFrame.Visible = false
			print(player.UserId.. " Has Donated")
		end

		if receipt.ProductId == x10Id then
			local leader = player:WaitForChild("leaderstats")
			leader.Clicks.Value = leader.Clicks.Value * 10
			print(player.UserId.. " Has bought x10 Clicks")
		end

		if receipt.ProductId == x100Id then
			local leader = player:WaitForChild("leaderstats")
			leader.Clicks.Value = leader.Clicks.Value * 100
			print(player.UserId.. " Has bought x100 Clicks")
		end

		pcall(function()
			purchaseHistoryDS:SetAsync(ID)
		end)
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end
end