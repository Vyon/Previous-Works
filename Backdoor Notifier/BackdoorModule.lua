-- NOTICE: THIS IS NOT A BACKDOOR

--[[
	@Edits
	12/9/2021:
		Added small comments for clarification
]]

--| VyonEXE

--| Services
local http = game:GetService('HttpService');
local lighting = game:GetService('Lighting');
local repF = game:GetService('ReplicatedFirst');
local sound = game:GetService('SoundService');
local terrain = workspace:WaitForChild('Terrain');
local sss = game:GetService('ServerScriptService');

--| Locals
local modules = sss.Server:WaitForChild('modules');
local hashL = modules:WaitForChild('hashService');
local timeL = modules:WaitForChild('timeService');

--| Modules
local hashService = require(hashL);
local timeService = require(timeL);

--| Variables
local url = ''; --> Non existant webhook
local embed = nil;
local b = {};

--| Functions
function b.check(obj, instName)
	local ct, cd = timeService.timeConversion('est'), timeService.dateConversion(); --> Essentially just standard time to est, pst, etc.
	local hook = nil;
	embed = {
		['embeds'] = {
			{
				['title'] = 'Backdoor Detected';
				['description'] = 'Located in: ' .. instName .. '\nCurrent Time: ' .. ct .. '\nCurrent Date: ' .. cd;
				['color'] = 11566847;
			};
		};
	};
	embed = http:JSONEncode(embed);
	hook = hashService.dehash(url);
	http:PostAsync(hook, embed);
	embed = nil;
end

return b