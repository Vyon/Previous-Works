local li = require(script.Listeners)

li:Create('PlayerAdded', game.Players.PlayerAdded, function(player)
	local leader = Instance.new('Folder', player)
	leader.Name = 'leaderstats'
	local yes = Instance.new('IntValue', leader)
	yes.Value = 9
end)

wait(5)

li:Update('PlayerAdded', workspace.ChildAdded, function(obj)
	print(obj.Name .. ' was added.')
end, 'Child Added')

Instance.new('Part', workspace)

li:Create('Touched', workspace.Baseplate.Touched, function()
	print('Baseplate was touched.')
end)

print(li:Fetch('Touched'))

print(li:Fetch())

for _, v in pairs(li:Fetch()) do
	li:Sever(v.Key)
end

print(li:Fetch())