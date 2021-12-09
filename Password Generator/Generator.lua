--| VyonEXE

--| Services
local httpService = game:GetService('HttpService');

--| Variables
local gen = {};

--| Functions
function gen.start(method, ca, hook, id)
	local genInfo = nil;
	local isHook = nil;
	if (typeof(method) == 'string' and method ~= nil or method ~= '') then
		if (method == 'pass') then
			genInfo = gen.pass(ca);
		end;
		isHook = gen.webhook(hook, id, genInfo);
		if (not isHook) then
			return genInfo.Info;
		end;
	else
		return 'Method was invalid';
	end;
end;

function gen.webhook(hook, id, genInfo)
	local embed = nil;
	local errorTbl = {};
	if (hook == nil or hook == '') then return false; end;
	if (genInfo == nil or genInfo == {}) then return false; end;
	if (id ~= nil and id ~= '') then
		embed = {
			['content'] = '<@' .. id .. '>';
			['embeds'] = {
				{
					['author'] = {
						['name'] = 'Generator written by VyonEXE';
						['url'] = 'https://github.com/Vyon';
					};
					['color'] = 11566847;
					['fields'] = {
						{
							['name'] = 'Your ' .. genInfo.Method ..' has been created';
							['value'] = genInfo.Info;
							['inline'] = false;
						};
					};
				};
			};
		};
	else
		embed = {
			['embeds'] = {
				{
					['author'] = {
						['name'] = 'Generator written by VyonEXE';
						['url'] = 'https://github.com/Vyon';
					};
					['color'] = 11566847;
					['fields'] = {
						{
							['name'] = 'Your ' .. genInfo.Method ..' has been created';
							['value'] = genInfo.Info;
							['inline'] = false;
						};
					};
				};
			};
		};
	end;
	embed = httpService:JSONEncode(embed);
	httpService:PostAsync(hook, embed);
	return true;
end;

function gen.pass(ca)
	local keyDict = {"a","c","b","e","d","g","f","i","h","k","j","m","l","o","n","q","p","s","r","u","t","w","v","y","x","{","z","}","~","!"," ","#",'"',"%","$","'","&",")","(","+","*","-",",","/",".","1","0","3","2","5","4","7","6","9","8",";",":","=","<","?",">","A","@","C","B","E","D","G","F","I","H","K","J","M","L","O","N","Q","P","S","R","U","T","W","V","Y","X","[","Z","]","_","^"};
	local output = {};
	local pass = {};
	local count = 0;
	local s = nil;
	if (ca == nil or ca == 0) then 
		ca = 50; 
	elseif (ca > 250) then
		ca = 250;
	end;
	while task.wait() do
		count += 1;
		s = keyDict[math.random(1, #keyDict)];
		table.insert(pass, s); -- Removed deprecated method - (12/9/2021)
		if (count >= ca) then
			pass = '[~]' .. tostring(table.concat(pass)) .. '[~]';
			output.Method = 'password';
			output.Info = pass;
			return output;
		end;
	end;
end;

return gen;
