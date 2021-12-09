-- Services
local ts = game:GetService('TweenService')
local players = game:GetService('Players')
local repl = game:GetService('ReplicatedStorage')

-- Locals
local remotes = repl.Remotes

-- Remotes
local ar = remotes.AbilityRequest

-- Tasks
local w = task.wait

-- Tables
local cache = {}

-- Module
local util = {}

function util.RequestSanity(player, p1)
	local hit = {}
	if (typeof(p1) == 'EnumItem' and cache[player].Ready) then
		cache[player].Ready = false

		-- Character Info
		local char = player.Character or player.CharacterAdded:Wait()

		local hitbox = Instance.new('Part', workspace)
		hitbox.Anchored = true
		hitbox.CanCollide = false
		hitbox.CastShadow = false
		hitbox.Shape = Enum.PartType.Ball
		hitbox.Color = Color3.fromRGB(48, 0, 209)
		hitbox.Material = Enum.Material.Neon
		hitbox.Transparency = 0.6

		hitbox.CFrame = char.PrimaryPart.CFrame

		local min, max = 0, 40

		hitbox.Touched:Connect(function(obj)
			local _target = players:GetPlayerFromCharacter(obj.Parent)
			if (_target and _target ~= player and not table.find(hit, _target.Name)) then
				table.insert(hit, _target.Name)

				local fake_name = function(original)
					local new = original:reverse()
					local bytes = {}

					for i = 1, new:len() do
						table.insert(bytes, '\\')
						table.insert(bytes, new:byte(i))
					end

					return tostring(table.concat(bytes))
				end

				print('Request made', hit)

				ar:FireClient(_target, nil, fake_name(player.Name))
				w(20)
				ar:FireClient(_target, true)
			end
		end)

		local info = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
		local _t1 = ts:Create(hitbox, info, { Size = Vector3.new(max, max, max) } )
		local _t2 = ts:Create(hitbox, info, { Size = Vector3.new(min, min, min) } )
		_t1:Play()

		_t1.Completed:Wait()
		w(2)
		_t2:Play()

		_t2.Completed:Wait()
		hitbox:Destroy()
		task.delay(5, function()
			cache[player].Ready = true
			table.clear(hit)
			hit = nil
		end)
	end
end

function util.UpdateCache(player)
	if (not cache[player]) then
		cache[player] = { Ready = true }
	end
end

return util