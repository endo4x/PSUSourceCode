--[[
	id: 2c8ByCG-m1iDKvwQirFhi
	name: GUI Server
	description: GUI Server
	time1: 2021-07-27 01:25:17.811265+00
	time2: 2021-07-27 01:25:17.811265+00
	uploader: 280
	uploadersession: 4MK4uWU_kfY3iUz7O2sqwpZn0wwnz6
	flag: f
--]]

--[[

Written by: loleeRBX
Date: 27/07/2021

]]--


		--WHITELIST

local PlaceInfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)

if PlaceInfo.Creator.CreatorType == "Group" then
	GameOwner = game:GetService("GroupService"):GetGroupInfoAsync(PlaceInfo.Creator.CreatorTargetId).Owner.Id
elseif PlaceInfo.Creator.CreatorType == "User" then
	GameOwner = PlaceInfo.Creator.Id
end

function HttpEnabled()
	local s = pcall(function()
		game:GetService('HttpService'):GetAsync('http://www.google.com/')
	end)
	return s
end

if not HttpEnabled() then
	script.Parent:Destroy()
	return
end

local module = require(4460787902)

local HubID = "642833559681368065"

module:GetAsync(HubID, "Departure Boards", GameOwner, function(Success, Value)
	if Success == true then
		--START OF CODE
		
local tweenService = game:GetService("TweenService")
local groupID = game.ReplicatedStorage:WaitForChild("Dont Change This Name").Configuration.GroupID.Value
local minRank = game.ReplicatedStorage:WaitForChild("Dont Change This Name").Configuration.MinRank.Value
local rem1 = Instance.new("RemoteEvent")
rem1.Parent = script.Parent
rem1.Name = "Activate"
local rem2 = Instance.new("RemoteEvent")
rem2.Parent = script.Parent
rem2.Name = "Reset"
local rem3 = Instance.new("RemoteEvent")
rem3.Parent = script.Parent
rem3.Name = "SetDest"
local rem4 = Instance.new("RemoteEvent")
rem4.Parent = script.Parent
rem4.Name = "SetFlightNo"
local rem5 = Instance.new("RemoteEvent")
rem5.Parent = script.Parent
rem5.Name = "SetGate"
local rem6 = Instance.new("RemoteEvent")
rem6.Parent = script.Parent
rem6.Name = "SetRemark"
local rem7 = Instance.new("RemoteEvent")
rem7.Parent = script.Parent
rem7.Name = "SetTime"
local rem8 = Instance.new("RemoteEvent")
rem8.Parent = script.Parent
rem8.Name = "Wipe"

local folder = game.ReplicatedStorage:WaitForChild("Dont Change This Name")


folder.DontTouch.PowerEvent.OnServerEvent:connect(function(plr,...)
	if plr:GetRankInGroup(groupID) >= minRank then
	local args = {...}
	if args[2] == true then
		folder.DontTouch.Power.Value = true
			for i,v in pairs(game.Workspace:GetDescendants()) do
			if v.Name == "DoNotChangeNameEI2IHFO2U" then
				spawn(function()
					v.SurfaceGui.Startup.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
					local Info = TweenInfo.new(3)
					local Info2 = TweenInfo.new(0.5)
					wait(1.5)
					v.SurfaceGui.Startup.logoFrame.ImageLabel:TweenPosition(UDim2.new(0, 100,0, 0), "Out", "Sine", 1.5)
					wait(1.5)
					local Tween = game:GetService("TweenService"):Create(v.SurfaceGui.Startup.textFrame.lolee,Info2,{TextTransparency=0})
					Tween:Play()
					wait(0.3)
					local Tween2 = game:GetService("TweenService"):Create(v.SurfaceGui.Startup.textFrame.GroundTech,Info2,{TextTransparency=0})
					Tween2:Play()
					v.SurfaceGui.Startup.logoFrame.Size = UDim2.new(0, 500,0, 170)
					wait(3)
					v.SurfaceGui.Startup.logoFrame.ImageLabel:TweenPosition(UDim2.new(0, 600,0, 0), "In", "Back", 0.5)
					v.SurfaceGui.Startup.textFrame:TweenPosition(UDim2.new(0, -240,0, 390), "In", "Back", 0.5)
					wait(0.8)
					v.SurfaceGui.Main:TweenPosition(UDim2.new(0, 0,0, 0), "Out", "Quad", 1.5)
					--set back to normal below
					v.SurfaceGui.Startup.textFrame.lolee.TextTransparency = 1
					v.SurfaceGui.Startup.textFrame.GroundTech.TextTransparency = 1
					v.SurfaceGui.Startup.logoFrame.Size = UDim2.new(0, 300,0, 170)
					v.SurfaceGui.Startup.logoFrame.ImageLabel.Position = UDim2.new(0, 300,0, 0)
					v.SurfaceGui.Startup.textFrame.Position = UDim2.new(0, 155,0, 390)
					end)
				end
			end
	else
		folder.DontTouch.Power.Value = false
		for i,v in pairs(game.Workspace:GetDescendants()) do
			if v.Name == "DoNotChangeNameEI2IHFO2U" then
				spawn(function()
					v.SurfaceGui.Main:TweenPosition(UDim2.new(0, -600,0, 0), "In", "Quad", 1.5)
					wait(2)
					v.SurfaceGui.Startup.BackgroundColor3 = Color3.fromRGB(0,0,0)
				end)
			end
		end
		end
	else
		plr:Kick("lolee | Do not attempt to fire remote events")
	end
end)








script.Parent.Reset.OnServerEvent:Connect(function(plr,...)
	local args = {...}
	local selectt = "Row"..args[3]
	local attr = args[2]
	for i,v in pairs(game.Workspace:GetDescendants()) do
		if v.Name == "DoNotChangeNameEI2IHFO2U" then
			if attr == "Remarks" then
				v.SurfaceGui.Main[selectt][attr].Text = ""
				v.SurfaceGui.Main[selectt].RemarkColour.BackgroundColor3 = Color3.fromRGB(0, 74, 159)
			else
			v.SurfaceGui.Main[selectt][attr].Text = ""
		end
	end
	end
end)

script.Parent.Wipe.OnServerEvent:Connect(function(plr,...)
	local args = {...}
	local selectt = "Row"..args[2]
	for i,v in pairs(game.Workspace:GetDescendants()) do
		if v.Name == "DoNotChangeNameEI2IHFO2U" then
			v.SurfaceGui.Main[selectt].Visible = false
			v.SurfaceGui.Main[selectt].RemarkColour.BackgroundColor3 = Color3.fromRGB(0, 74, 159)
			for i,v in pairs(v.SurfaceGui.Main[selectt]:GetDescendants()) do
				v.Text = ""
			end
		end
	end
end)

script.Parent.Activate.OnServerEvent:Connect(function(plr,...)
	local args = {...}
	local selectt = "Row"..args[2]
	for i,v in pairs(game.Workspace:GetDescendants()) do
		if v.Name == "DoNotChangeNameEI2IHFO2U" then
			v.SurfaceGui.Main[selectt].Visible = true
		end
	end
end)



script.Parent.SetTime.OnServerEvent:Connect(function(plr,...)
	local args = {...}
	local selectt = "Row"..args[3]
	for i,v in pairs(game.Workspace:GetDescendants()) do
		if v.Name == "DoNotChangeNameEI2IHFO2U" then
			v.SurfaceGui.Main[selectt].Time.Text = args[2]
		end
	end
end)

script.Parent.SetFlightNo.OnServerEvent:Connect(function(plr,...)
	local args = {...}
	local selectt = "Row"..args[3]
	for i,v in pairs(game.Workspace:GetDescendants()) do
		if v.Name == "DoNotChangeNameEI2IHFO2U" then
			v.SurfaceGui.Main[selectt].FlightNo.Text = args[2]
		end
	end
end)

script.Parent.SetDest.OnServerEvent:Connect(function(plr,...)
	local args = {...}
	local selectt = "Row"..args[3]
	for i,v in pairs(game.Workspace:GetDescendants()) do
		if v.Name == "DoNotChangeNameEI2IHFO2U" then
			v.SurfaceGui.Main[selectt].Dest.Text = args[2]
		end
	end
end)

script.Parent.SetGate.OnServerEvent:Connect(function(plr,...)
	local args = {...}
	local selectt = "Row"..args[3]
	for i,v in pairs(game.Workspace:GetDescendants()) do
		if v.Name == "DoNotChangeNameEI2IHFO2U" then
			v.SurfaceGui.Main[selectt].GateNo.Text = args[2]
		end
	end
end)


script.Parent.SetRemark.OnServerEvent:Connect(function(plr,...)
	local args = {...}
	local selectt = "Row"..args[3]
	if args[2] == "Wait In Lounge" then
		for i,v in pairs(game.Workspace:GetDescendants()) do
			if v.Name == "DoNotChangeNameEI2IHFO2U" then
				v.SurfaceGui.Main[selectt].Remarks.Text = args[2]
				v.SurfaceGui.Main[selectt].RemarkColour.BackgroundColor3 = Color3.fromRGB(0, 74, 159)
			end
		end
	elseif args[2] == "Go To Gate" then
		for i,v in pairs(game.Workspace:GetDescendants()) do
			if v.Name == "DoNotChangeNameEI2IHFO2U" then
				v.SurfaceGui.Main[selectt].Remarks.Text = args[2]
				v.SurfaceGui.Main[selectt].RemarkColour.BackgroundColor3 = Color3.fromRGB(0, 208, 0)
			end
		end
	elseif args[2] == "Now Boarding" then
		for i,v in pairs(game.Workspace:GetDescendants()) do
			if v.Name == "DoNotChangeNameEI2IHFO2U" then
				v.SurfaceGui.Main[selectt].Remarks.Text = args[2]
				v.SurfaceGui.Main[selectt].RemarkColour.BackgroundColor3 = Color3.fromRGB(255, 106, 0)
			end
		end
	elseif args[2] == "Gate Closing" then
		for i,v in pairs(game.Workspace:GetDescendants()) do
			if v.Name == "DoNotChangeNameEI2IHFO2U" then
				v.SurfaceGui.Main[selectt].Remarks.Text = args[2]
				v.SurfaceGui.Main[selectt].RemarkColour.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			end
		end
	elseif args[2] == "Delayed" then
		for i,v in pairs(game.Workspace:GetDescendants()) do
			if v.Name == "DoNotChangeNameEI2IHFO2U" then
				v.SurfaceGui.Main[selectt].Remarks.Text = args[2]
				v.SurfaceGui.Main[selectt].RemarkColour.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			end
		end
	elseif args[2] == "Cancelled" then
		for i,v in pairs(game.Workspace:GetDescendants()) do
			if v.Name == "DoNotChangeNameEI2IHFO2U" then
				v.SurfaceGui.Main[selectt].Remarks.Text = args[2]
				v.SurfaceGui.Main[selectt].RemarkColour.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			end
		end
	end
		end)
		
		
	else
		script:Destroy()
	end
end)