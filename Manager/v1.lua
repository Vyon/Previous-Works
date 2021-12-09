-- Locals
local f_required = script.Parent.Required

-- Manager
local manager = {}

manager.__index = manager
manager.ClassName = 'Manager'

local function GetModules()
	if (#f_required:GetChildren() >= 1) then
		local required = {}

		for i, v in ipairs(f_required:GetChildren()) do
			if (v.ClassName == 'ModuleScript' and v.Name ~= 'Collect') then
				required[v.Name] = require(v)
			end
		end

		return required
	else
		warn('[GetModules] No modules to require')
	end
end

function manager:GetType(name)
	assert(typeof(name) == 'string', '[Manager:GetType] Parameter was not a string')

	if (self.Required[name]) then
		local module = self.Required[name]

		local meta = getmetatable(module)
		local class = meta.ClassName

		if (class) then
			return class
		else
			warn(('[Manager:GetType] %s does not have a ClassName'):format(name))
		end
	else
		warn(('[Manager:GetType] %s has not been required'):format(name))
	end
end

return {
	New = function()
		local self = GetModules()

		setmetatable(self, manager)

		return self
	end
}