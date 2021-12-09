--[[
	[ Explanation ]
	The "New" method is essentially a class constructor, after setting the metatable the methods present in the "test" table can be used.
]]

local test = {}
test.__index = test

function test:Print()
	print(self)
end

return {
	New = function()
		return setmetatable({}, test) --> setmetatable returns the "public" table or the first table parameter
	end
}