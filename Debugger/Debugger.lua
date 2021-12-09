-- Tables
local SETTINGS = {
	Debug = true
}

-- Module
local debugger = {}

debugger.__index = debugger

function debugger:Listen(key, callback)
	if (SETTINGS.Debug) then
		if (not table.find(self.Active, key)) then 
			table.insert(self.Active, key)
			self.Listeners[math.random()] = {
				Key = key,
				Callback = callback
			}
		else
			warn('[Debugger:Listen] Key already exists, to overwrite use Debugger:Overwrite(key, new_key)')
		end
	end
end

function debugger:Overwrite(old, new, ...)
	if (SETTINGS.Debug) then
		local args = {...}

		if (#self.Active ~= 0) then
			for x, d in next, self.Listeners do
				if (d.Key == old) then
					table.remove(self.Active, table.find(self.Active, old))
					table.insert(self.Active, new)

					self.Listeners[x] = {
						Key = new,
						Callback = args[1] and typeof(args[1]) == 'function' and args[1] or d.Callback
					}

					return
				end
			end

			warn('[Debugger:Overwrite] Key was not found.')
		else
			warn('[Debugger:Overwrite] No active keys were found.')
		end
	end
end

function debugger:Clear(key)
	if (SETTINGS.Debug) then
		for x, d in next, self.Listeners do
			if (d.Key == key) then
				self.Listeners[x] = nil
				table.remove(self.Active, table.find(self.Active, key))
			end
		end
	end
end

function debugger:Call(key, ...)
	if (SETTINGS.Debug) then
		for x, d in next, self.Listeners do
			if (d.Key == key) then
				local success, response = pcall(d.Callback, ...)

				if (not success) then
					warn('[Debugger:Call] Failed to call function.')
					warn('[Response]:', response)
				end

				return success, response
			end
		end

		warn('[Debugger:Call] Key was not found.')
	end
end

function debugger:Register(tbl)
	if (SETTINGS.Debug) then
		for x, d in next, tbl do
			if (typeof(d) == 'function') then
				self:Listen(x, d)
			else
				warn('[Debugger:Register] Unable to register \'' .. x .. '\' because value is not a function.')
			end
		end
	end
end

function debugger:Dump()
	if (SETTINGS.Debug) then
		warn('[Debugger:Dump] Currently active keys')
		print(self.Active)
	end
end

return {
	New = function()
		local self = { Listeners = {}, Active = {}, Keys = {} }

		setmetatable(self, debugger)

		return self
	end
}