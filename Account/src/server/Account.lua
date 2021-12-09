local account = {}

account.__index = account
account.ClassName = 'Account'

local function GetDate()
	local date = os.date('*t', os.time())

	local month, day, year = date.month, date.day, date.year

	local date_str = tostring(month .. '/' .. day .. '/' .. year)

	return date_str
end

function account:Add(p1)
	p1 = tonumber(p1)

	if (typeof(p1) ~= 'number') then
		warn('[Account:Add] Input parameter was not a number.')
		return
	end

	self.Balance += p1

	if (not self.History[GetDate()]) then
		self.History[GetDate()] = {}

		table.insert(self.History[GetDate()], ('[Earned]: %d'):format(p1))
	else
		table.insert(self.History[GetDate()], ('[Earned]: %d'):format(p1))
	end
end

function account:Sub(p1)
	p1 = tonumber(p1)

	if (typeof(p1) ~= 'number') then
		warn('[Account:Sub] Input parameter was not a number.')
		return
	end

	self.Balance -= p1
	
	if (not self.History[GetDate()]) then
		self.History[GetDate()] = {}

		table.insert(self.History[GetDate()], ('[Spent]: %d'):format(p1))
	else
		table.insert(self.History[GetDate()], ('[Spent]: %d'):format(p1))
	end
end

function account:Set(num)
	num = tonumber(num)

	if (typeof(num) ~= 'number') then
		warn('[Account:Set] Input parameter was not a number.')
		return
	end

	self.Balance = num
end

function account:Transactions()
	print(self.History)
end

return {
	New = function()
		local self = { Balance = 0, History = {} }

		setmetatable(self, account)

		return self
	end
}