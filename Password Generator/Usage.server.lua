local gen = require(script.Generator);
local webhook = 'https://discord.com/api/webhooks/843388887241326632/3DjH1tR3YkIWLLjw7_LSRUOsd6iL3x7xh29kOAB5ozGjOsjcD_VWI9W3iXOii6HCZny_'; -- Webhook no longer exists lol
local id = ''; --> Discord ID
local genInfo = gen.start('pass', 100, webhook, id);

if (genInfo ~= 'Method was invalid' and genInfo ~= nil) then
	print(genInfo);
end;