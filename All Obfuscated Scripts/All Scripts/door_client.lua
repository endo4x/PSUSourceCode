--[[
	id: glvy7h_ST_SROLL23NzAh
	name: door_client
	description: SCPF
	time1: 2021-06-12 07:01:39.751377+00
	time2: 2021-06-12 07:01:39.751378+00
	uploader: 1162
	uploadersession: bzozLZO-UZ_x-vXCwssLsC3diLq8vS
	flag: f
--]]

--[[
strings-override
scpfos
...
]]


print(1)
local players = game:GetService('Players')
local replicated = game:GetService('ReplicatedStorage')
local uis = game:GetService('UserInputService')
local rs = game:GetService('RunService')
local ts = game:GetService("TweenService")

local plr = players.LocalPlayer
local plr_gui = plr:WaitForChild('PlayerGui')
local doors = {}

local char = plr.Character or plr.CharacterAdded:Wait()
local hum
local torso
local hum_died

local closest_door = nil
local min_distance = 10

local door_func = replicated:WaitForChild('door')

local TI = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
local tween_infos = {
	lights = TweenInfo.new(.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut, 0, false, 0),
	BlastDoor = TweenInfo.new(3.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut, 0, false, 0),
	SlideDoor = TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0),
	text = TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
}

local messages = {
	["denied"] = "You are unable to perform this action.",
	["granted"] = "You successfully completed this action.",
	["debounce"] = "DOOR COOLDOWN ACTIVE.",
	["lockdown"] = "This door is on lockdown status."
}

-- << - << 		Functions 	>> - >> --
local function verify_door(obj)
	if obj:IsA('Model') and obj:FindFirstChild('Data') and obj.Data:FindFirstChild('Permissions') and obj.PrimaryPart then
		return true
	end
end

local function can_see(part)
	local vector = (part.Position - torso.Position)
	local infov = vector:Dot(torso.CFrame.lookVector) > 0
	if infov and vector.magnitude < 9e8 then
		local ray = Ray.new(torso.Position, vector.unit * 999)
		local part, hitPosition = workspace:FindPartOnRay(ray, char)
		return part, infov
	end
	return false
end

local function get_closest_door() --credit to software for the idea of using table.sort (big brain)
	local distances = {}

	for door, info in pairs(doors) do
		door.Gui.Gui.Enabled = false
		distances[#distances+1] = {door, plr:DistanceFromCharacter(door.DoorFrame.Position)}
	end

	table.sort(distances, function(obj1, obj2)
		return obj1[2] < obj2[2]
	end)

	if distances[1] and distances[1][2] <= min_distance then
		distances[1][1].Gui.Gui.Enabled = true
		return distances[1][1]
	end
end

local function fade_message(text,arg,arg2)
	if text:IsA('TextLabel') then
		local tween
		if arg == 'Out' then
			tween = ts:Create(text,tween_infos.text,{
				TextTransparency = 1, 
				TextStrokeTransparency = 1
			}):Play()
		elseif arg == 'In' then
			tween = ts:Create(text,tween_infos.text,{
				TextTransparency = 0, 
				TextStrokeTransparency = 0.85
			}):Play()			
		end

		if arg2 then tween.Completed:Wait() end
	end
end

-- << - << 		   Code 		>> - >> --
uis.InputBegan:Connect(function(input, process)
	if input.KeyCode == Enum.KeyCode.E and not process and closest_door and char and hum.Health > 0 then	
		local msg = door_func:InvokeServer(closest_door)

		spawn(function()
			if (msg == "granted2") then
				local Tween = ts:Create(closest_door.Gui.Gui.ImageLabel, TI, {ImageTransparency = 1, ImageColor3 = Color3.fromRGB(125, 125, 125)})
				Tween:Play()

				Tween.Completed:Wait()

				closest_door.Gui.Gui.ImageLabel.Image = "rbxassetid://5686658272"

				Tween = ts:Create(closest_door.Gui.Gui.ImageLabel, TI, {ImageTransparency = 0, ImageColor3 = Color3.fromRGB(255, 255, 255)})
				Tween:Play()

				wait(2)

				Tween = ts:Create(closest_door.Gui.Gui.ImageLabel, TI, {ImageTransparency = 1, ImageColor3 = Color3.fromRGB(125, 125, 125)})
				Tween:Play()

				Tween.Completed:Wait()

				closest_door.Gui.Gui.ImageLabel.Image = "rbxassetid://5682114308"

				Tween = ts:Create(closest_door.Gui.Gui.ImageLabel, TI, {ImageTransparency = 0, ImageColor3 = Color3.fromRGB(255, 255, 255)})
				Tween:Play()
			end
		end)
	end
end)

hum = char:WaitForChild('Humanoid')
torso = hum.RigType == Enum.HumanoidRigType.R15 and char:WaitForChild('UpperTorso') or char:WaitForChild('Torso')

hum_died = hum.Died:Connect(function()
	rs:UnbindFromRenderStep('door')
	closest_door = nil
	hum_died:Disconnect()
end)

rs.Stepped:Connect(function()
	local door = get_closest_door()

	for door, info in pairs(doors) do
		local g = door.Gui:FindFirstChild("Gui2")
		if (g) then
			g:destroy()
		end
	end

	local Beam

	if door and can_see(door.PrimaryPart) then
		closest_door = door

		local Gui = closest_door.Gui.Gui:Clone()
		Gui.Parent = closest_door.Gui
		Gui.Face = "Front"
		Gui.Name = "Gui2"

		local Character = plr.Character

		if (Character) then
			local HumanoidRootPart = Character.HumanoidRootPart
			Beam = HumanoidRootPart:FindFirstChild("Beam")
			for _, info in next, doors do

				if (door) then

					local Attachment1 = HumanoidRootPart.RootRigAttachment

					if not (Beam) then
						Beam = script.Beam:Clone()
						Beam.Parent = HumanoidRootPart
						Beam.Attachment0 = door.DoorFrame.Closed_Attachment
						Beam.Attachment1 = Attachment1
					else
						Beam.Attachment0 = door.DoorFrame.Closed_Attachment
					end
				end
			end
		end

		repeat wait(); until get_closest_door() ~= door or hum.Health <= 0 or not char or not can_see(door.PrimaryPart)
	end
	if (Beam) then
		Beam.Attachment0 = nil
	end
end)

plr.CharacterRemoving:Connect(function()
	rs:UnbindFromRenderStep('door')
	closest_door = nil
	if hum_died then hum_died:Disconnect() end
end)

for _, door in pairs(workspace:WaitForChild('doors'):GetChildren()) do
	if verify_door(door) and not doors[door] then
		local last_open = tick()

		doors[door] = {
			center = door.PrimaryPart,
			open = door.Data:WaitForChild('Open'),
		}	
	end
end