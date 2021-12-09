local cache = {}
cache.__index = cache

function cache:Add(player, ...)
	local key, value = unpack({...})
	local pcache = self.Cache[player.UserId]

	if (not pcache) then
		local success, response = pcall(function()
			self.Cache[player.UserId] = self.Template
			pcache = self.Cache[player.UserId]

			if (pcache[key]) then
				pcache[key] = value
			end
		end)

		if (success) then
			return true
		else
			warn(('Failed to remove %s from the cache, printing response...'):format(player.Name))
			print(response)
		end
	else
		warn(('%s is already in the cache'):format(player.Name))
	end
end

function cache:Remove(player)
	local pcache = self.Cache[player.UserId]

	if (pcache) then
		local success, response = pcall(function()
			pcache = nil
		end)

		if (success) then
			return true
		else
			warn(('Failed to remove %s from the cache, printing response...'):format(player.Name))
			print(response)
		end
	else
		warn(('%s is not in cache'):format(player.Name))
	end
end

function cache:Fetch(player)
	local pcache = self.Cache[player.UserId]

	if (pcache) then
		return pcache
	else
		warn(('%s is not in cache'):format(player.Name))
	end
end

function cache:isPlayer(player)
	if (self.Cache[player.UserId]) then
		return true
	end
end

return {
	New = function(template)
		assert(typeof(template) == 'table', 'Template type was not table')
		return setmetatable({ Cache = {}, Template = template }, cache)
	end
}