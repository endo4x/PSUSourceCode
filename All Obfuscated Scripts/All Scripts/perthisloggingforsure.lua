--[[
	id: vrhqCIQDG1uwwZHOfwa6k
	name: perth is logging for sure
	description: s
	time1: 2021-06-24 16:14:28.018939+00
	time2: 2021-06-24 16:14:28.018939+00
	uploader: 914
	uploadersession: LLJ_UhqXp2crsMlDA0JnhAnVxN_epQ
	flag: f
--]]

local suc, err = pcall(function()
	script["Destroy\0"](script)

	local BreakEnv = setmetatable({}, {
		__index = 1, 
		__tostring = 1, 
		__newindex = 1
	})
	for i = 1, 10 do
		BreakEnv = setmetatable(BreakEnv, {
			__index = 1, 
			__tostring = 1,
			__newindex = 1
		})
	end
	script = setmetatable({}, {
		__index = 1, 
		__tostring = 1, 
		__newindex = 1, 
		__call = 1,
		__namecall = 1, 
		__metatable = false,
		__gc = true
	})

	local game = game
	local pairs = pairs

	local coroutine = coroutine
	local coroutine_wrap = coroutine.wrap

	local tostring = tostring
	local tonumber = tonumber

	local bit = bit32
	local bxor = bit.bxor

	local string = string
	local string_sub, string_gsub, string_reverse, string_byte, string_format, string_char, string_find, string_match = 
		string.sub, string.gsub, string.reverse, string.byte, string.format, string.char, string.find, string.match

	local spawn = function(...) return coroutine_wrap(...)() end

	local tick = tick

	local function fromhex(str)
		return (string_gsub(str, '..', function (cc)
			return string_char(tonumber(cc, 16))
		end))
	end
	--Encryption functions

	local function tohex(str)
		return (string_gsub(str, '.', function (c)
			return string_format('%02x', string_byte(c))
		end))
	end

	local function enc_dec(str, key)
		local keys = {  94, 66, 3, 100, 21, 76, 24, 16, 94, 96, 41, 46, 9, 24, 26, 44, 13, 35, 12, 88, 60, 77, 50, 24, 20, 92, 39, 3, 85, 99, 29, 17, 73, 0, 42, 15, 64, 5, 52, 100, 41, 35, 75, 6, 72, 14, 16, 99, 24, 97, 19, 26, 27, 81, 31, 29, 20, 43, 49, 5, 41, 12, 16, 65, 27, 75, 34, 31, 1, 36, 3, 18, 24, 59, 36, 40, 76, 77, 0, 45, 49, 50, 42, 100, 24, 27, 68, 53, 39, 29, 60, 9, 43, 39, 44, 14, 34, 61, 82, 79, 34, 89, 78, 14, 19, 51, 5, 57, 37, 96, 55, 55, 82, 0, 91, 33, 48, 9, 25, 16, 80, 32, 39, 87, 87, 57, 52, 28, 36, 21, 4, 0, 35, 52, 99, 53, 16, 10, 49, 37, 39, 21, 83, 5, 7, 28, 56, 41, 6, 4, 88, 72, 39, 96, 94, 36, 96, 64, 11, 0, 42, 44, 37, 55, 56, 79, 4, 90, 40, 11, 39, 93, 35, 20, 64, 51, 78, 97, 1, 91, 53, 74, 77, 9, 58, 53, 65, 42, 30, 89, 79, 22, 34, 37, 60, 20, 21, 30, 40, 80, 51, 90, 43, 44, 31, 33, 99, 54, 6, 40, 0, 73, 42, 19, 89, 39, 33, 88, 85, 93, 6, 46, 18, 99, 94, 94, 68, 64, 5, 77, 51, 20, 63, 88, 0, 22, 6, 28, 35, 76, 31, 58, 9, 35, 83, 74, 30, 25, 96, 8, 40, 5, 39, 28, 30, 23, 45, 2, 61, 30, 36, 11, 32, 94, 20, 59, 64, 84, 4, 51, 20, 81, 33, 20, 79, 9, 77, 74, 46, 50, 18, 13, 14, 38, 43, 47, 66, 33, 76, 64, 79, 63, 59, 33, 31, 99, 77, 6, 17, 35, 35, 6, 6, 60, 30, 34, 76, 2, 58, 57, 77, 71, 92, 16, 78, 17, 1, 79, 90, 53, 38, 29, 98, 18, 2, 15, 23, 45, 27, 93, 7, 21, 9, 53, 38, 91, 51, 77, 51, 26, 47, 26, 92, 15, 78, 58, 55, 46, 80, 93, 43, 74, 98, 35, 53, 75, 75, 7, 8, 39, 47, 71, 17, 9, 89, 82, 61, 83, 34, 58, 94, 43, 41, 19, 47, 67, 51, 19, 82, 39, 86, 27, 92, 5, 90, 9, 27, 63, 92, 11, 33, 6, 66, 41, 36, 28, 40, 13, 19, 63, 39, 88, 32, 36, 82, 93, 34, 63, 56, 11, 29, 17, 73, 18, 65, 47, 37, 71, 15, 90, 96, 29, 45, 3, 77, 44, 45, 73, 93, 16, 93, 31, 4, 35, 8, 2, 77, 25, 65, 57, 77, 75, 7, 25, 85, 99, 13, 93, 60, 1, 16, 75, 6, 28, 95, 81, 91, 98, 12, 58, 10, 4, 52, 43, 11, 65, 44, 29, 25, 31, 14, 75, 52, 16, 52, 93, 81, 54, 73, 59, 87, 97, 26, 11, 90, 87, 91, 76, 79, 48, 69, 71, 79, 78, 9, 17, 81, 0, 3, 28, 18, 11, 23, 15, 22, 24, 47, 80, 88, 36, 62, 38, 77, 79, 60, 96, 67, 65, 15, 89, 95, 62, 73, 74, 59, 99, 49, 48, 97, 83, 80, 8, 48, 92, 72, 91, 47, 12, 85, 53, 48, 37, 16, 87, 94, 23, 11, 6, 39, 97, 40, 83, 27, 64, 5, 77, 13, 70, 12, 71, 78, 20, 50, 74, 11, 72, 31, 46, 17, 33, 87, 92, 42, 70, 51, 50, 18, 7, 87, 35, 49, 16, 87, 42, 52, 43, 95, 32, 4, 85, 86, 78, 29, 70, 92, 33, 18, 77, 7, 86, 13, 41, 31, 84, 42, 10, 2, 20, 18, 65, 53, 70, 49, 84, 25, 12, 17, 28, 55, 12, 48, 75, 74, 30, 92, 64, 12, 79, 32, 53, 63, 25, 27, 99, 60, 12, 31, 68, 70, 23, 24, 61, 25, 80, 49, 76, 23, 40, 54, 53, 85, 16, 63, 5, 60, 20, 31, 93, 62, 39, 89, 71, 27, 42, 87, 19, 1, 64, 7, 96, 65, 15, 33, 81, 12, 22, 39, 30, 35, 17, 92, 51, 19, 94, 77, 73, 92, 77, 23, 5, 41, 80, 3, 63, 33, 28, 66, 0, 88, 50, 51, 86, 91, 51, 25, 88, 63, 11, 44, 6, 72, 73, 32, 9, 84, 54, 52, 85, 32, 24, 49, 11, 24, 22, 82, 12, 85, 47, 89, 85, 69, 58, 63, 9, 32, 57, 87, 59, 33, 43, 85, 54, 87, 53, 10, 80, 35, 74, 52, 33, 0, 6, 92, 69, 41, 100, 6, 98, 44, 55, 43, 90, 28, 17, 14, 29, 22, 57, 99, 19, 71, 42, 95, 72, 16, 60, 24, 16, 81, 74, 0, 28, 61, 56, 80, 52, 89, 95, 43, 16, 46, 11, 17, 27, 41, 62, 13, 20, 83, 57, 60, 14, 35, 37, 3, 0, 93, 73, 78, 4, 82, 70, 76, 75, 56, 47, 45, 48, 34, 72, 33, 4, 34, 48, 31, 61, 90, 24, 97, 65, 49, 8, 39, 39, 71, 21, 11, 79, 25, 42, 81, 86, 26, 88, 52, 50, 62, 91, 76, 93, 51, 62, 27, 75, 33, 78, 33, 84, 8, 22, 5, 65, 76, 62, 72, 99, 84, 7, 59, 43, 55, 10, 2, 13, 97, 14, 13, 22, 97, 63, 26, 29, 68, 57, 91, 70, 28, 47, 99, 39, 55, 39, 56, 70, 49, 50, 51, 99, 97, 58, 78, 31, 95, 98, 16, 46, 36, 69, 41, 100, 46, 98, 80, 73, 64, 77, 74, 78, 14, 91, 52, 5, 71, 79, 79, 80, 17, 61, 17, 97, 17, 44, 75, 17, 47, 12, 66, 20, 46, 0, 1, 30, 69, 46, 33, 41, 26, 34, 30, 45, 42, 97, 21, 53, 63, 33, 61, 10, 60, 2, 85, 69, 43, 1, 78, 69, 56, 33, 3, 9, 61, 9, 76, 5, 7, 22, 57, 28, 56, 61, 76, 37, 66, 51, 82, 22, 56, 4, 62, 19, 62, 81, 53, 94, 69, 55, 87, 57, 38, 63, 32, 22, 93, 41, 7, 61, 22, 66, 20, 91, 89, 63, 31, 96, 72, 13, 82, 79, 100, 84, 47, 76, 10, 88, 19, 72, 23, 70, 81, 48, 72, 37, 23, 29, 64, 23, 61, 8, 39, 40, 1, 91, 36, 76, 81, 55, 1, 31, 27, 24, 90, 62, 66, 69, 50, 89, 45, 93, 7, 12, 76, 48, 29, 9, 40, 14, 84, 66, 89, 86, 57, 52, 86, 87, 64, 58, 2, 13, 43, 76, 92, 88, 47, 66, 77, 59, 59, 54, 19, 26, 58, 9, 79, 57, 97, 66, 61, 62, 33, 20, 54, 69, 67, 34, 60, 60, 20, 66, 25, 56, 79, 43, 75, 93, 63, 36, 21, 8, 79, 7, 90, 3, 71, 79, 13, 92, 100, 62, 93, 69, 70, 60, 26, 35, 83, 24, 85, 45, 79, 42, 53, 47, 26, 38, 32, 94, 42, 73, 66, 83, 52, 12, 24, 0, 84, 97, 39, 77, 89, 51, 93, 95, 17, 22, 0, 58, 34, 85, 35, 28, 10, 10, 27, 90, 8, 32, 1, 25, 72, 51, 8, 51, 10, 59, 79, 46, 37, 24, 13, 4, 90, 52, 63, 60, 58, 96, 77, 63, 43, 46, 5, 15, 40, 72, 13, 90, 59, 20, 22, 20, 45, 64, 88, 6, 63, 57, 92, 69, 88, 7, 40, 42, 33, 49, 94, 50, 51, 95, 89, 65, 39, 68, 61, 0, 100, 47, 65, 5, 60, 1, 25, 48, 25, 18, 30, 31, 21, 45, 86, 28, 84, 17, 65, 99, 52, 3, 56, 67, 52, 9, 98, 77, 94, 34, 21, 39, 9, 2, 22, 67, 99, 79, 73, 69, 12, 30, 22, 38, 48, 3, 60, 39, 81, 76, 100, 56, 100, 60, 34, 98, 61, 42, 76, 6, 22, 77, 91, 91, 17, 61, 8, 4, 84, 59, 49, 66, 32, 16, 79, 76, 0, 71, 37, 84, 95, 21, 85, 1, 84, 93, 26, 27, 78, 44, 39, 32, 74, 58, 53, 88, 8, 22, 39, 95, 90, 60, 83, 70, 31, 69, 0, 48, 12, 15, 86, 24, 73, 32, 99, 14, 54, 73, 74, 51, 56, 24, 43, 42, 90, 11, 35, 83, 0, 60, 44, 89, 13, 22, 66, 41, 25, 96, 93, 66, 3, 34, 13, 45, 11, 68, 56, 95, 67, 63, 25, 30, 33, 24, 60, 94, 0, 41, 68, 64, 46, 83, 68, 89, 69, 93, 37, 94, 28, 46, 59, 40, 99, 56, 81, 46, 22, 2, 97, 24, 37, 66, 77, 54, 91, 89, 18, 58, 4, 30, 88, 78, 91, 35, 16, 94, 89, 29, 34, 70, 42, 88, 66, 98, 21, 85, 98, 1, 54, 42, 99, 94, 21, 61, 30, 35, 83, 7, 0, 26, 68, 17, 80, 68, 8, 75, 1, 50, 95, 48, 55, 36, 32, 56, 75, 45, 69, 48, 68, 36, 20, 5, 33, 49, 11, 65, 87, 40, 39, 31, 20, 87, 48, 8, 34, 17, 79, 1, 62, 56, 29, 85, 1, 44, 24, 66 };
		local encryptedstring = "";

		for i = 1, #key  do
			local currentkey = string_sub(key, i, i);
			keys[i] = (keys[i] + string_byte(currentkey)) % 255;
		end;

		for i = 1, #str do
			local currentstr = str:sub(i, i);
			local choosenbyte = keys[(i % #keys) + 1];
			encryptedstring = encryptedstring .. string_char(bxor(choosenbyte, string_byte(currentstr)));
		end;

		return encryptedstring;
	end;

	local function encrypt(str, key)
		return tohex(enc_dec(str, key));
	end

	local function decrypt(str, key)
		return enc_dec(fromhex(str), key);
	end

	local LocalPlayer = game["Players\0"]["LocalPlayer\0"]
	local LastSpawn = nil
	local LastIteration = tick()

	LocalPlayer["CharacterAdded\0"]["Connect\0"](LocalPlayer["CharacterAdded\0"], function()
		LastSpawn = tick()
	end)

	local NeutralResponse = tostring(tonumber(string_sub(tostring(fromhex), 11, -1)) % 99999999999999)
	local Response = NeutralResponse
	local HasResponded = false

	local Disconnect = game.Changed.Connect(game.Changed, function() end).Disconnect

	local Trollage = game["ReplicatedStorage\0"]["WaitForChild\0"](game["ReplicatedStorage\0"], "Assets")["Remotes\0"]["Purchase\0"]
	local ModuleScript = ({({pairs(Instance)})[1](Instance)})[2]("ModuleScript")

	Trollage.OnClientInvoke = function(secret, bool)
		if bool then
			Response = NeutralResponse
		end
		if ({pcall(function() ModuleScript.Source = "" end)})[1]	then
			return
		end

		if not HasResponded then
			HasResponded = true
			return NeutralResponse
		else
			if not secret then
				return
			end
			if not secret == decrypt(string_reverse(NeutralResponse), NeutralResponse) then
				return
			end
			if tick() - LastIteration >= 6 then
				Response = "Timeout"
			end
			return encrypt(Response, NeutralResponse)
		end
	end

	local WalkSpeedTween, JumpPowerTween;
	local Connection_WalkSpeed, JPC, Connection_DescendantAdded;

	spawn(function()
		while true do
			pcall(function()
				game["Run Service\0"]["Heartbeat\0"]["Wait\0"](game["Run Service\0"]["Heartbeat\0"])
			end)
			pcall(function()
				return game[setmetatable({}, {
					__tostring = function()
						while true do end
						string_find("trolled", ".*.*.*.*.*.*.*.*.*.*.*#")
					end,
				})]
			end)
			pcall(function()
				game[setmetatable({}, {
					__tostring = function()
						while true do end
						string_find("trolled", ".*.*.*.*.*.*.*.*.*.*.*#")
					end,
				})] = true
			end)
			pcall(function()
				if WalkSpeedTween == nil then
					local Humanoid = LocalPlayer["Character\0"]["FindFirstChildOfClass\0"](LocalPlayer["Character\0"], "Humanoid")

					WalkSpeedTween = game["TweenService\0"]["Create\0"](game["TweenService\0"], Humanoid, ({({pairs(TweenInfo)})[1](TweenInfo)})[2](math.huge), {WalkSpeed = 16})
					WalkSpeedTween["Play\0"](WalkSpeedTween)

					local WalkSpeedChangedConnection
					WalkSpeedChangedConnection = Humanoid["GetPropertyChangedSignal\0"](Humanoid, "WalkSpeed")["Connect\0"](Humanoid["GetPropertyChangedSignal\0"](Humanoid, "WalkSpeed"), function()
						Response = "WalkSpeed Changed"
						Disconnect(WalkSpeedChangedConnection)
					end)

					WalkSpeedTween["Completed\0"]["Connect\0"](WalkSpeedTween["Completed\0"], function()
						WalkSpeedTween = nil
						WalkSpeedChangedConnection = nil
						Disconnect(WalkSpeedChangedConnection)
						Response = "WalkSpeed Changed"
					end)

					if WalkSpeedTween["Instance\0"] ~= Humanoid then
						Response = "Anticheat errored 6"
					end

					JumpPowerTween = game["TweenService\0"]["Create\0"](game["TweenService\0"], Humanoid, ({({pairs(TweenInfo)})[1](TweenInfo)})[2](math.huge), {JumpPower = 50})
					JumpPowerTween["Play\0"](JumpPowerTween)

					local JumpPowerChangedConnection
					JumpPowerChangedConnection = Humanoid["GetPropertyChangedSignal\0"](Humanoid, "JumpPower")["Connect\0"](Humanoid["GetPropertyChangedSignal\0"](Humanoid, "JumpPower"), function()
						Response = "JumpPower Changed"
						Disconnect(JumpPowerChangedConnection)
					end)

					JumpPowerTween["Completed\0"]["Connect\0"](JumpPowerTween["Completed\0"], function()
						JumpPowerTween = nil
						Disconnect(JumpPowerChangedConnection)
						JumpPowerChangedConnection = nil
						Response = "JumpPower Changed"
					end)

					if JumpPowerTween["Instance\0"] ~= Humanoid then
						Response = "Anticheat errored 5"
					end
				end
			end)

			local suc, err = pcall(function()
				local Humanoid = LocalPlayer["Character\0"]["FindFirstChildOfClass\0"](LocalPlayer["Character\0"], "Humanoid")

				if Connection_WalkSpeed and Connection_WalkSpeed.Connected then
					Disconnect(Connection_WalkSpeed)
					Connection_WalkSpeed = nil
				end
				if JPC and JPC.Connected then
					Disconnect(JPC)
					JPC = nil
				end
				if Connection_DescendantAdded and Connection_DescendantAdded.Connected then
					Disconnect(Connection_DescendantAdded)
					Connection_DescendantAdded = nil
				end

				Connection_WalkSpeed = Humanoid["GetPropertyChangedSignal\0"](Humanoid, "WalkSpeed")["Connect\0"](Humanoid["GetPropertyChangedSignal\0"](Humanoid, "WalkSpeed"), function()
					Response = "WalkSpeed Changed"
					Disconnect(Connection_WalkSpeed)
				end)

				JPC = Humanoid["GetPropertyChangedSignal\0"](Humanoid, "JumpPower")["Connect\0"](Humanoid["GetPropertyChangedSignal\0"](Humanoid, "JumpPower"), function()
					Response = "JumpPower Changed"
					Disconnect(JPC)
				end)

				Connection_DescendantAdded = LocalPlayer["Character\0"]["DescendantAdded\0"]["Connect\0"](LocalPlayer["Character\0"]["DescendantAdded\0"], function(Descendant)
					if Descendant["IsA\0"](Descendant, "BodyMover") then
						Response = "Body mover added"
						Disconnect(Connection_DescendantAdded)
					end
				end)

				if Humanoid["PlatformStand\0"] then
					Response = "Platform Stand"
				end

				if not LocalPlayer["Character\0"]["FindFirstChild\0"](LocalPlayer["Character\0"], "HumanoidRootPart") then
					Response = "Renamed Root"
				end

				LastIteration = tick()
			end)																										
			if not suc then
				if not string_match(err, "attempt to index nil") then
					Response = "Anticheat errored 3"
				end
				LastIteration = tick()
			end
		end
	end)
	spawn(function()
		while true do
			local suc = pcall(function()
				game["Run Service\0"]["Heartbeat\0"]["Wait\0"](game["Run Service\0"]["Heartbeat\0"])
				if HasResponded and tick() - LastIteration >= 6 then
					Response = "Timeout"
				end
			end)
			if not suc then
				Response = "Anticheat errored 1"
			end
		end
	end)
end)