local repl = game:GetService('ReplicatedStorage')

local listener = require(repl.Shared.Signal)

local signal = listener.New()

signal:Create('Test')

signal:Connect('Test', function(num1, num2)
	print(num1 + num2)
end)

signal:Fire('Test', 2, 4)

signal:Disconnect('Test')

signal:Dump()
