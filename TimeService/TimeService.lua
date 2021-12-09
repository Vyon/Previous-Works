local ctz, ctf = nil, nil;
local t = {};
local tzList = {
	['ust'] = 0;
	['est'] = 4;
	['pst'] = 7;
};

function t.time(tz)
	local timeTbl = nil;
	local reduce = nil;
	local hour = nil;
	local min = nil;
	local tf = nil;

	timeTbl = DateTime.now():ToUniversalTime();

	if (tz and timeTbl ~= nil and tz ~= '') then
		for i, v in pairs(tzList) do
			if (string.lower(tz) == i) then
				reduce = tzList[i];
			end;
		end;

		hour = timeTbl.Hour - reduce;

		if (timeTbl.Minute > 9) then
			min = tostring(timeTbl.Minute);
		else
			min = '0' .. tostring(timeTbl.Minute);
		end;

		if (hour < 0) then
			hour = 24 - reduce + 3
		elseif (hour == 0) then
			hour = 12;
			hour = tostring(hour);
			tf = 'AM';
			ctf = tf;
			return hour .. ':' .. min .. ' ' .. tf;
		end

		if (hour >= 12) then
			hour = hour % 12
			hour = tostring(hour);
			tf = 'PM';
			ctf = tf;
		elseif (hour < 12) then
			hour = tostring(hour);
			tf = 'AM';
			ctf = tf;
		end;

		ctz = tz;

		return hour .. ':' .. min .. ' ' .. tf;
	end;
end;

function t.date(tz)
	local timeTbl = nil;
	local month = nil;
	local year = nil;
	local day = nil;

	timeTbl = DateTime.now():ToUniversalTime();
	day = tostring(timeTbl.Day);
	month = tostring(timeTbl.Month);
	year = tostring(timeTbl.Year);
	t.time(tz);

	if (ctz ~= 'ust' and ctf == 'PM') then
		day = day - 1;
	end;

	return month .. '/' .. day .. '/' .. year;
end;

return t;