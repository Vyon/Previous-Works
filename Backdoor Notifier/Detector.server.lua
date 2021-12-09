--| VyonEXE

--| Services
local bd = game:GetService("ServerScriptService").BackdoorDetector;
local lighting = game:GetService('Lighting');
local repF = game:GetService('ReplicatedFirst');
local sound = game:GetService('SoundService');
local terrain = workspace:WaitForChild('Terrain');

--| Modules
local bmod = require(bd:WaitForChild('bmod'));

--| Functions
terrain.ChildAdded:Connect(function(obj)
	bmod.check(obj, terrain.Name);
end);

lighting.ChildAdded:Connect(function(obj)
	bmod.check(obj, lighting.Name);
end);

sound.ChildAdded:Connect(function(obj)
	bmod.check(obj, sound.Name);
end);

repF.ChildAdded:Connect(function(obj)
	bmod.check(obj, repF.Name);
end);