-- Parent: util

local listener = {
	Active = {}
}

function listener:Create(key, signal, callback)
	if (typeof(key) == 'string' and typeof(signal) == 'RBXScriptSignal' and typeof(callback) == 'function') then
		self.Active[tostring(math.random(1000000, 9999999))] = {
			Key = key,
			Signal = signal,
			Connection = signal:Connect(callback)
		}
	else
		warn('Invalid Parameters\nParameters:\n')
		print(key, '\n', signal, '\n', callback)
		warn('\nParameter Types:\n')
		print(typeof(key), '\n', typeof(signal), '\n', typeof(callback))
	end
end

function listener:Sever(key)
	for i, v in pairs(self.Active) do
		if (v.Key == key) then
			v.Connection:Disconnect()
			self.Active[i] = nil
			return
		end
	end
	warn('No connection using the key \"' .. key .. '\" was found')
end

function listener:Update(key, signal, callback, ...)
	local keyOverride = {...}
	for i, v in pairs(self.Active) do
		if (v.Key == key) then
			self.Active[i].Connection:Disconnect()
			if (#keyOverride == 1 and typeof(keyOverride[1]) == 'string') then key = keyOverride[1] end
			self.Active[i] = {
				Key = key,
				Signal = signal,
				Connection = signal:Connect(callback)
			}
			return
		end
	end
	warn('Unable to update connection please check the input parameters')
end

function listener:Fetch(...)
	local keys = {...}
	local located = {}
	for i, v in pairs(self.Active) do
		if (typeof(keys) == 'table' and #keys ~= 0 and table.find(keys, v.Key)) then
			if (not located[v.Key]) then
				located[v.Key] = {}
			end
			table.insert(located[v.Key], v)
		elseif (#keys == 0) then
			located[math.random(1000000, 9999999)] = v
		end
	end
	return located
end

return listener