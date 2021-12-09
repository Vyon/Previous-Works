local signal = {}
signal.__index = signal

function signal:Create(name)
	local ac_signal = self.Active[name]

	if (not ac_signal) then
		local bindable = Instance.new('BindableEvent')
		bindable.Name = 'Signal'

		self.Active[name] = bindable
	end
end

function signal:Connect(name, callback)
	local ac_signal = self.Active[name]

	if (ac_signal) then
		local bindable = ac_signal
		local b_signal = bindable.Event

		b_signal:Connect(callback)
	else
		warn('[Signal:Connect] Could not connect to signal, signal does not exist.')
	end
end

function signal:Fire(name, ...)
	local ac_signal = self.Active[name]

	if (ac_signal) then
		local success, response = pcall(ac_signal.Fire, ac_signal, ...)

		if (not success) then
			warn('[Signal:Fire] Failed to fire signal\n', response)
		end
	else
		warn('[Signal:Fire] Could not fire signal, signal does not exist.')
	end
end

function signal:Disconnect(name)
	local ac_signal = self.Active[name]

	if (ac_signal) then
		ac_signal:Destroy()
		self.Active[name] = nil
	else
		warn('[Signal:Disconnect] Failed to disconnect signal, signal does not exist.')
	end
end

function signal:Dump()
	if (#self.Active >= 1) then
		print(self.Active)
	else
		warn('[Signal:Dump] No active signals to dump.')
	end
end

return {
	New = function()
		local self = { Active = {} }

		setmetatable(self, signal)

		return self
	end
}
