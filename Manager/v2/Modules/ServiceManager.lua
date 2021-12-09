-- Locals
local dep = script.Parent.Dependencies
local serv = script.Parent.Services

local manager = { Services = {} }

function manager:Init()
	if (#serv:GetChildren() ~= 0) then
		for _, x in pairs(serv:GetChildren()) do
			if (x:IsA('ModuleScript')) then
				self.Services[x.Name] = require(x)
			end
		end
	else
		warn('[ServiceManager]: There are no services to manage.')
		return
	end

	return self.Services
end

function manager.Collect(name)
	local dependencies = dep:FindFirstChild(name)

	if (#dependencies:GetChildren() ~= 0) then
		local collected = {}

		for _, x in pairs(dependencies:GetChildren()) do
			collected[x.Name] = require(x)
		end

		return collected
	else
		warn('[ServiceManager]: Dependencies failed to be collected.')
	end
end

return manager