--[[
	[Requiring ServiceManager]:
	local services = script.Parent
	local modules = services.Parent
	local manager = require(modules:WaitForChild('ServiceManager')

	local dep = manger.Collect(script.Name) -- dep means dependencies so to get dependencies you could do local _settings = dep.Settings
]]