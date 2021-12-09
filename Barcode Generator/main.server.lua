--[[
	@Edits
	12/9/2021:
		Removed deprecated / useless methods

--]]

local selectionDict = {'I', 'l'}
local function getOutput(varA, varL)
	local tempC = 0
	local inputVal = nil
	local returnVal = {}
	local output = {}
	if varA == nil then varA = 1 end
	if varL == nil then varL = 10 end

	while task.wait() do
		tempC += 1
		table.insert(returnVal, selectionDict[math.random(1, #selectionDict)])
		if tempC >= varL then break end
	end

	for i = 0, varA do
		table.insert(output, tostring(table.concat(returnVal)))
	end

	return table.concat(output)
end

local deez = getOutput() -- <varAmount>, <varLength>
print(deez)