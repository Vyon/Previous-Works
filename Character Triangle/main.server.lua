local function createTrognol()
	local chars = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'}
	local codeLen = 25
	local code = ''

	for i = 1, codeLen do
		local char = chars[math.random(1, #chars)]
		if (math.random(1, 2) == 1) then		
			char = char:upper()
		end
		if (i < codeLen) then
			code = code .. char
			print('|', code)
		elseif (i == codeLen) then
			for _ = 1, code:len() do
				code = code:sub(0, code:len() - 1)
				if (code:len() ~= 0) then
					print('|', code)
				end
			end
		end
	end
end

createTrognol()