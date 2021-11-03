--[[
	id: Jas-NdmbvpxDNcF01W6r_
	name: door_script
	description: SCPF
	time1: 2021-06-12 06:52:27.704222+00
	time2: 2021-06-12 06:52:27.704223+00
	uploader: 1162
	uploadersession: bzozLZO-UZ_x-vXCwssLsC3diLq8vS
	flag: f
--]]

--[[
strings-override
scpfos
...
]]


local http = game:GetService("HttpService")
local apiKey = script.api_key.Value
local aa = http:GetAsync("https://scpfos.glitch.me/api?apikey="..apiKey)
local a = http:JSONDecode(aa)
if a.doorsystem == true then
	print("[scpfOS] Door System: Loaded")
else
	print("[scpfOS] Door System: Error")
	script:Destroy()
end




local replicated = game:GetService('ReplicatedStorage')
local players = game:GetService("Players")
local rs = game:GetService("RunService")

local doors = {}
local doors_folder = workspace.doors

local door_func = replicated.door

local min_distance = script.MinDistance.Value

local debounce_lengths = {
	BlastDoor = script.BlastDoor.Value,
	SlideDoor = script.SlideDoor.Value
}

local function verify_door(obj)
	if obj:IsA('Model') and obj:FindFirstChild('Data') and obj.Data:FindFirstChild('Permissions') and obj.PrimaryPart then
		return true
	end
end

local function check_clearance(plr,door)
	if plr.Character and doors[door] then
		for i,v in pairs(plr.Backpack:GetChildren()) do
			if v:IsA('Tool') and doors[door].clearances[v.Name] then
				return true
			end
		end
		for i,v in pairs(plr.Character:GetChildren()) do
			if v:IsA('Tool') and doors[door].clearances[v.Name] then
				return true				
			end
		end
	end
end

door_func.OnServerInvoke = function(plr, door)
	if doors[door] and plr.Character then
		local info = doors[door]
		local distance = plr:DistanceFromCharacter(door.DoorFrame.Position)

		if (info.active.Value) then
			if info.denied then info.denied:Play() end
			return 'debounce'
		end

		if distance ~= 0 and distance <= min_distance then
			if check_clearance(plr, door) then
				if tick() - info.last_open >= debounce_lengths[door.Name] then

					for i, v in pairs(info) do
						if typeof(v) == 'Instance' and v:IsA('Sound') then
							v:Stop()
						end
					end

					spawn(function()
						info.doormodule.Check(plr, door)
						info.active.Value = false
					end)

					info.last_open = tick()
				else

					return 'debounce'
				end
			else
				info.active.Value = true

				spawn(function()
					wait(2)

					info.active.Value = false
				end)

				return "granted2"
			end
		end
	end
end
-- << - << 		   Code 		>> - >> --

for _, door in pairs(doors_folder:GetChildren()) do
	if verify_door(door) and not doors[door] then
		doors[door] = {
			center = door.PrimaryPart,
			open = door.Data:WaitForChild('Open'),
			clearances = require(door.Data:WaitForChild('Permissions')),
			doormodule = require(door.Data:WaitForChild('DoorModule')),
			last_open = tick(),
			granted = door.DoorFrame.Granted_SND;
			denied = door.DoorFrame.Error_SND;
			active = door.Data.Active;
		}	
	end
end