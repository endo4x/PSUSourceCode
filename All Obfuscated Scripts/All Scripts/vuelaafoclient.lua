--[[
	id: nWfbnsjtEEd7htyyLSoDK
	name: vuela a320 fo client
	description: a
	time1: 2021-06-04 21:34:19.939442+00
	time2: 2021-06-04 21:34:19.939442+00
	uploader: 7fYr1Pvc-PegVsGilkrVK2EOw-yvgz4mKNbnE3mZ
	uploadersession: johpelgYzC7ePR0qkvMf3e8DoS13j0
	flag: f
--]]

--[[ 
strings-override
vuelllllllllllllllllllllllllllla
aegus
a320
yeegus a320
buy more stuff
sheeeeeeeeeeesh
http did nothing
i did everything
hi mom
]]
local event = script.RE.Value
local flaps = 0
script.Parent.Buttons.SpoilersUp.MouseButton1Click:Connect(function()
	event:FireServer("SpoilersUp")
end)
script.Parent.Buttons.SpoilersDown.MouseButton1Click:Connect(function()
	event:FireServer("SpoilersDown")
end)
script.Parent.Buttons.FlapsUp.MouseButton1Click:Connect(function()
	if flaps < 3 then
		event:FireServer("FLAPSUP")
		flaps = flaps +1
	end
end)
script.Parent.Buttons.FlapsDown.MouseButton1Click:Connect(function()
	if flaps > 0 then
		event:FireServer("FLAPSDOWN")
		flaps = flaps -1
	end
end)

script.Parent.Buttons.LandingLight.MouseButton1Click:Connect(function()
	event:FireServer("LandingLights")
end)

script.Parent.Buttons.StrobeLight.MouseButton1Click:Connect(function()
	event:FireServer("Strobe")
end)

script.Parent.Buttons.TaxiLight.MouseButton1Click:Connect(function()
	event:FireServer("TAXI")
end)

script.Parent.Buttons.NavigationLight.MouseButton1Click:Connect(function()
	event:FireServer("NAV")
end)

script.Parent.Buttons.LogoLight.MouseButton1Click:Connect(function()
	event:FireServer("LOGO")
end)

script.Parent.Buttons.Reversers.MouseButton1Click:Connect(function()
	event:FireServer("REV")
end)

script.Parent.Buttons.PTU.MouseButton1Click:Connect(function()
	event:FireServer("PTU")
end)
script.Parent.Buttons.APU.MouseButton1Click:Connect(function()
	event:FireServer("APU")
end)
script.Parent.Buttons.Battery.MouseButton1Click:Connect(function()
	event:FireServer("BATT")
end)
script.Parent.Buttons.Gears.MouseButton1Click:Connect(function()
	event:FireServer("GEAR")
end)
script.Parent.Buttons.BeaconLight.MouseButton1Click:Connect(function()
	event:FireServer("BEACON")
end)
script.Parent.Buttons.Engine2Toggle.MouseButton1Click:Connect(function()
	event:FireServer("E2")
end)
script.Parent.Buttons.Engine1Toggle.MouseButton1Click:Connect(function()
	event:FireServer("E1")
end)
event.OnClientEvent:Connect(function(name, color)
	script.Parent.Indicators:FindFirstChild(name).BackgroundColor3 = color
	event:FireServer("COLOR", name, color)
end)