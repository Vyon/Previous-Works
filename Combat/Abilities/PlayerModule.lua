local replicatedStorage = game:GetService("ReplicatedStorage")

local playerModule = {
	["cd1"] = false;
	["cd2"] = false;
	["cd3"] = false;
	["cd4"] = false;
	["cd5"] = false;
	["Enabled"] = true;
	["Hold"] = 0;
}

function playerModule.Archway(player)
	playerModule.cd1 = true
	replicatedStorage.Events.playerEvent:FireServer("Archway")
	local MainAnim = player.Character.Humanoid:LoadAnimation(replicatedStorage.Animations.Arch.Activate)
	MainAnim:Play()
	wait(MainAnim.Length)
	wait(5)
	playerModule.cd1 = false
end

function playerModule.Void_Circle(player)
	playerModule.cd2 = true
	replicatedStorage.Events.playerEvent:FireServer("VoidSphere")
	local MainAnim = player.Character.Humanoid:LoadAnimation(replicatedStorage.Animations["Void Sphere"].Activate)
	MainAnim:Play()
	wait(MainAnim.Length)
	wait(9)
	playerModule.cd2 = false
end

function playerModule.FireBall(player)
	playerModule.cd4 = true
	replicatedStorage.Events.playerEvent:FireServer("FireBall")
	local MainAnim = player.Character.Humanoid:LoadAnimation(replicatedStorage.Animations.Fireball.Shoot)
	MainAnim:Play()
	wait(MainAnim.Length)
	wait(3)
	playerModule.cd4 = false
end

function playerModule.JumpKick(player)
	playerModule.cd5 = true
	replicatedStorage.Events.playerEvent:FireServer("JumpKick")
	local MainAnim = player.Character.Humanoid:LoadAnimation(replicatedStorage.Animations.JumpKick.Kick)
	MainAnim:Play()
	wait(MainAnim.Length)
	wait(2)
	playerModule.cd5 = false
end

return playerModule