--[[
	id: -c1CA21WfdbfbFNpMmRr5
	name: anim pack local
	description: anim pack local
	time1: 2021-05-22 18:33:00.000641+00
	time2: 2021-05-22 18:33:00.000642+00
	uploader: 7fYr1Pvc-PegVsGilkrVK2EOw-yvgz4mKNbnE3mZ
	uploadersession: johpelgYzC7ePR0qkvMf3e8DoS13j0
	flag: f
--]]

--[[ 
strings-override
polaris best
wow its a diy animation pack never seen before
alyss was here
hi mom!
go buy more stuff ok thx <3
sheeeeeeeeeeesh
]]
local UIS = game:GetService("UserInputService")
local event = script.Parent.SeatEV
local Settings = require(script.Parent:WaitForChild("Settings"))
local keys = {}
local numsettings = 0

for _, _ in pairs(Settings) do
	numsettings = numsettings + 1
end
local actions = (numsettings-1)/5
for i=1, actions do
	keys[string.upper(Settings["Action"..tostring(i).."Keybind"])] = "Action"..tostring(i)
end

UIS.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed then
		if input.UserInputType == Enum.UserInputType.Keyboard then
			local key = UIS:GetStringForKeyCode(input.KeyCode)
			if keys[key] then
				script.Parent.SeatEV:FireServer("Began", keys[key])
			end
		end
	end
end)

UIS.InputEnded:Connect(function(input, gameProcessed)
	if not gameProcessed then
		if input.UserInputType == Enum.UserInputType.Keyboard then
			local key = UIS:GetStringForKeyCode(input.KeyCode)
			if keys[key] then
				script.Parent.SeatEV:FireServer("End", keys[key])
			end
		end
	end
end)