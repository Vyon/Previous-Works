local tweenService = game:GetService("TweenService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local FX = replicatedStorage.FX

local Arch = FX.Arch
local VoidSphere = FX["Void Sphere"]

local eventModule = {}

function eventModule.Archway(player)
	local offset = Vector3.new(0,0,-10)
	local ArchClone1 = Arch:Clone()
	local ArchClone2 = Arch:Clone()
	local ArchClone3 = Arch:Clone()
	local ArchClone4 = Arch:Clone()
	local ArchClone5 = Arch:Clone()

	ArchClone1.Name = ""
	ArchClone2.Name = ""
	ArchClone3.Name = ""
	ArchClone4.Name = ""
	ArchClone5.Name = ""

	ArchClone1.Parent = workspace.FX
	ArchClone2.Parent = workspace.FX
	ArchClone3.Parent = workspace.FX
	ArchClone4.Parent = workspace.FX
	ArchClone5.Parent = workspace.FX

	ArchClone1.Main.CFrame = player.Character.PrimaryPart.CFrame * CFrame.new(offset)
	wait(0.1)
	ArchClone2.Main.CFrame = ArchClone1.Main.CFrame * CFrame.new(offset)
	wait(0.1)
	ArchClone3.Main.CFrame = ArchClone2.Main.CFrame * CFrame.new(offset)
	wait(0.1)
	ArchClone4.Main.CFrame = ArchClone3.Main.CFrame * CFrame.new(offset)
	wait(0.1)
	ArchClone5.Main.CFrame = ArchClone4.Main.CFrame * CFrame.new(offset)

	ArchClone1.P2.Touched:Connect(function(hit)
		if game.Players:FindFirstChild(hit.Parent.Name) and hit.Parent ~= player.Character then
			local playerHit = game.Players:FindFirstChild(hit.Parent.Name)
			if not playerHit:FindFirstChild("ArchHit" .. player.UserId) then
				local AlreadyHit = Instance.new("BoolValue", playerHit); AlreadyHit.Name = "ArchHit" .. player.UserId
				if AlreadyHit.Value == false then
					hit.Parent:FindFirstChild("Humanoid").Health -= 20
					AlreadyHit.Value = true
				end
			end
		end
	end)

	ArchClone2.P2.Touched:Connect(function(hit)
		if game.Players:FindFirstChild(hit.Parent.Name) and hit.Parent ~= player.Character then
			local playerHit = game.Players:FindFirstChild(hit.Parent.Name)
			if not playerHit:FindFirstChild("ArchHit" .. player.UserId) then
				local AlreadyHit = Instance.new("BoolValue", playerHit); AlreadyHit.Name = "ArchHit" .. player.UserId
				if AlreadyHit.Value == false then
					hit.Parent:FindFirstChild("Humanoid").Health -= 20
					AlreadyHit.Value = true
				end
			end
		end
	end)

	ArchClone3.P2.Touched:Connect(function(hit)
		if game.Players:FindFirstChild(hit.Parent.Name) and hit.Parent ~= player.Character then
			local playerHit = game.Players:FindFirstChild(hit.Parent.Name)
			if not playerHit:FindFirstChild("ArchHit" .. player.UserId) then
				local AlreadyHit = Instance.new("BoolValue", playerHit); AlreadyHit.Name = "ArchHit" .. player.UserId
				if AlreadyHit.Value == false then
					hit.Parent:FindFirstChild("Humanoid").Health -= 20
					AlreadyHit.Value = true
				end
			end
		end
	end)

	ArchClone4.P2.Touched:Connect(function(hit)
		if game.Players:FindFirstChild(hit.Parent.Name) and hit.Parent ~= player.Character then
			local playerHit = game.Players:FindFirstChild(hit.Parent.Name)
			if not playerHit:FindFirstChild("ArchHit" .. player.UserId) then
				local AlreadyHit = Instance.new("BoolValue", playerHit); AlreadyHit.Name = "ArchHit" .. player.UserId
				if AlreadyHit.Value == false then
					hit.Parent:FindFirstChild("Humanoid").Health -= 20
					AlreadyHit.Value = true
				end
			end
		end
	end)

	ArchClone5.P2.Touched:Connect(function(hit)
		if game.Players:FindFirstChild(hit.Parent.Name) and hit.Parent ~= player.Character then
			local playerHit = game.Players:FindFirstChild(hit.Parent.Name)
			if not playerHit:FindFirstChild("ArchHit" .. player.UserId) then
				local AlreadyHit = Instance.new("BoolValue", playerHit); AlreadyHit.Name = "ArchHit" .. player.UserId
				if AlreadyHit.Value == false then
					hit.Parent:FindFirstChild("Humanoid").Health -= 20
					AlreadyHit.Value = true
				end
			end
		end
	end)

	wait(2)

	for _,v in pairs(game.Players:GetChildren()) do
		for _, x in pairs(game.Players:FindFirstChild(v.Name):GetChildren()) do
			if x:IsA("BoolValue") and x.Name == "ArchHit" .. player.UserId then
				x:Destroy()
			end
		end
	end

	ArchClone1:Destroy()
	wait(0.1)
	ArchClone2:Destroy()
	wait(0.1)
	ArchClone3:Destroy()
	wait(0.1)
	ArchClone4:Destroy()
	wait(0.1)
	ArchClone5:Destroy()
end

function eventModule.Void(player)
	local playerList = {}
	local Count = 0
	local VoidClone = VoidSphere:Clone()
	VoidClone.Name = ""
	VoidClone.Parent = workspace.FX

	local Void = Instance.new("BoolValue")
	Void.Name = "Void"
	Void.Parent = VoidClone

	VoidClone.CFrame = player.Character.PrimaryPart.CFrame
	VoidClone.Touched:Connect(function(hit)
		if game.Players:FindFirstChild(hit.Parent.Name) and hit.Parent.Name ~= player.Name then
			local playerHit = game.Players:FindFirstChild(hit.Parent.Name)
			if not playerHit:FindFirstChild("VoidHit" .. player.UserId) then
				local AlreadyHit = Instance.new("BoolValue", playerHit); AlreadyHit.Name = "VoidHit" .. player.UserId
				if AlreadyHit.Value == false then
					hit.Parent:FindFirstChild("Humanoid").Health -= 20
					AlreadyHit.Value = true
				end
			end
		end
	end)
	while wait() do
		VoidClone.Size = VoidClone.Size + Vector3.new(7,7,7)
		Count += 1
		if Count == 8 then
			Count = 0
			break
		end
	end

	wait(8)
	Count = 0
	while wait() do
		VoidClone.Size = VoidClone.Size - Vector3.new(7,7,7)
		Count += 1
		if Count == 10 then
			break
		end
	end
	for _,v in pairs(game.Players:GetChildren()) do
		for _, x in pairs(game.Players:FindFirstChild(v.Name):GetChildren()) do
			if x:IsA("BoolValue") and x.Name == "VoidHit" .. player.UserId then
				x:Destroy()
			end
		end
	end
	VoidClone:Destroy()
end

function eventModule.FireBall(player)
	local Count = 0
	local inTween = false
	local FireBall = Instance.new("Part")
	local Fire = Instance.new("Fire")
	FireBall.Name = ""
	Fire.Name = ""
	FireBall.Parent = workspace.FX
	Fire.Parent = FireBall
	FireBall.Shape = Enum.PartType.Ball
	Fire.Heat = 0
	FireBall.Anchored = true
	Fire.Size = 100
	FireBall.CanCollide = false
	FireBall.Color = Color3.fromRGB(0, 0, 0)
	FireBall.Material = Enum.Material.Glass
	FireBall.Transparency = 0.2
	FireBall.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-2)
	while wait() do
		Count += 1
		FireBall.CFrame *= CFrame.new(0,0,-1)
		if Count >= 100 then
			break
		end
	end
	FireBall:Destroy()
end

function eventModule.JumpKick(player)
	local Hit = false
	local Character = player.Character or player.CharacterAdded:Wait()

	Character["Right Leg"].Touched:Connect(function(hit)
		if game.Players:FindFirstChild(hit.Parent.Name) then
			if player.Name ~= hit.Parent.Name and Hit == false then
				Hit = true
				hit.Parent:FindFirstChild("Humanoid"):TakeDamage(10)
			end
		end
	end)
end

return eventModule