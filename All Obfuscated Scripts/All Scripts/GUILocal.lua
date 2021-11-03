--[[
	id: IX4LIcM9cGYFatS04ucge
	name: GUI Local
	description: GUI Local
	time1: 2021-07-27 01:28:47.076211+00
	time2: 2021-07-27 01:28:47.076213+00
	uploader: 280
	uploadersession: 4MK4uWU_kfY3iUz7O2sqwpZn0wwnz6
	flag: f
--]]

--[[

Written by: loleeRBX
Date: 27/07/2021

]]--



local tweenService = game:GetService("TweenService")
plr = game.Players.LocalPlayer
MainFrame = script.Parent.Parent:WaitForChild("MainFrame")
RowSelected = 0
DeleteRowSelected = 0
selectedRemark = ""
Power = game.ReplicatedStorage:WaitForChild("Dont Change This Name").DontTouch.Power
Override = game.ReplicatedStorage:WaitForChild("Dont Change This Name").DontTouch.Override
PowerEvent = game.ReplicatedStorage:WaitForChild("Dont Change This Name").DontTouch.PowerEvent

--[[if Override.Value == true then
	script.Parent.Parent.StartFrame.Visible = false
	script.Parent.Parent.HasOverride.Visible = true
end]]--

script.Parent.Parent.HasOverride.DismissPress.MouseButton1Down:Connect(function()
	script.Parent.Parent.HasOverride.Visible = false
	script.Parent.Parent.StartFrame.Visible = true
end)

if Power.Value == true then
	script.Parent.Parent.StartFrame.OnOff.Slider.Position = UDim2.new(4.78, 0,6.62, 0)
	script.Parent.Parent.StartFrame.OnOff.Slider.ImageColor3 = Color3.fromRGB(0,255,0)
	script.Parent.Parent.StartFrame.TextButton.Visible = false
end

script.Parent.Parent.StartFrame.OnOff.PowerPress.MouseButton1Down:Connect(function()
	script.Parent.Parent.StartFrame.OnOff.PowerPress.Visible = false
	script.Parent.Parent.StartFrame.close.ButtonClose.Visible = false
	local Button = script.Parent.Parent.StartFrame.OnOff.Slider
	local GoalGreen = {ImageColor3 = Color3.fromRGB(0,255,0)}
	local GoalYellow = {ImageColor3 = Color3.fromRGB(255, 255, 0)}
	local GoalRed = {ImageColor3 = Color3.fromRGB(255, 0, 0)}
	local TweenGreen = tweenService:Create(Button, TweenInfo.new(0.5), GoalGreen)
	local TweenYellow = tweenService:Create(Button, TweenInfo.new(0.5), GoalYellow)
	local TweenRed = tweenService:Create(Button, TweenInfo.new(0.5), GoalRed)
	if Power.Value == false then
		PowerEvent:FireServer(plr,true)
		script.Parent.Parent.StartFrame.OnOff.Slider:TweenPosition(UDim2.new(4.44, 0,6.62, 0), "Out", "Quad", 1)
		TweenYellow:Play()
		local Info = TweenInfo.new(3)
		local Info2 = TweenInfo.new(0.5)
		wait(1.5)
		wait(1.5)
		wait(0.3)
		wait(3)
		wait(0.8)
		--set back to normal below
		script.Parent.Parent.StartFrame.OnOff.Slider:TweenPosition(UDim2.new(4.78, 0,6.62, 0), "Out", "Quad", 1)
		TweenGreen:Play()
		wait(1)
		script.Parent.Parent.StartFrame.OnOff.PowerPress.Visible = true
		script.Parent.Parent.StartFrame.close.ButtonClose.Visible = true
		script.Parent.Parent.StartFrame.TextButton.Visible = false
	else
		PowerEvent:FireServer(plr,false)
		script.Parent.Parent.StartFrame.TextButton.Visible = true
		script.Parent.Parent.StartFrame.OnOff.PowerPress.Visible = false
		script.Parent.Parent.StartFrame.close.ButtonClose.Visible = false
		script.Parent.Parent.StartFrame.OnOff.Slider:TweenPosition(UDim2.new(4.44, 0,6.62, 0), "Out", "Quad", 1)
		TweenYellow:Play()
		wait(2)
		script.Parent.Parent.StartFrame.OnOff.PowerPress.Visible = true
		script.Parent.Parent.StartFrame.close.ButtonClose.Visible = true
		script.Parent.Parent.StartFrame.OnOff.Slider:TweenPosition(UDim2.new(4.123, 0,6.62, 0), "Out", "Quad", 1)
		TweenRed:Play()
	end
end)




MainFrame.ButtonBack.MouseButton1Down:connect(function()
	MainFrame.Visible = false
	script.Parent.Parent.StartFrame.Visible = true
	RowSelected = 0
	selectedRemark = ""
	MainFrame.Gate.GateInput.Text = ""
	MainFrame.Dest.DestInput.Text = ""
	MainFrame.FlightNo.FlightInput.Text = ""
	MainFrame.FlightTime.TimeInput.Text = ""
	MainFrame.Remarks.SelectedOne.Text = ""
end)

script.Parent.Parent.StartFrame.DeleteLine.RemoveLineOpenScroll.MouseButton1Down:Connect(function()
	script.Parent.Parent.StartFrame.DeleteLine.RemoveLineOpenScroll.Visible = false
	script.Parent.Parent.StartFrame.DeleteLine.ScrollFrame.Visible = true
	script.Parent.Parent.StartFrame.DeleteLine.LineSelected.Text = " "
	script.Parent.Parent.StartFrame.DeleteLine.temp.Visible = false
end)

for i,v in pairs(script.Parent.Parent.StartFrame.DeleteLine.ScrollFrame:GetDescendants()) do
	local frame = script.Parent.Parent.StartFrame.DeleteLine.ScrollFrame
	v.MouseButton1Down:connect(function()
		DeleteRowSelected = v:GetAttribute("WhatLine")
		frame.Visible = false
		script.Parent.Parent.StartFrame.DeleteLine.LineSelected.Text = DeleteRowSelected
		script.Parent.Parent.StartFrame.DeleteLine.RemoveLineOpenScroll.Visible = true
		script.Parent.Parent.StartFrame.DeleteLine.temp.Visible = true
		for i,v in pairs(script.Parent.Parent.StartFrame.RemoveGo:GetDescendants()) do
			v.Visible = true
		end
	end)
end

script.Parent.Parent.StartFrame.RemoveGo.GoPress.MouseButton1Down:Connect(function()
	for i,v in pairs(script.Parent.Parent.StartFrame.RemoveGo:GetDescendants()) do
		v.Visible = false	
	end
	script.Parent.Parent.StartFrame.DeleteLine.LineSelected.Text = ""
	script.Parent.Wipe:FireServer(plr,DeleteRowSelected)
end)

script.Parent.Parent.StartFrame.Scroll.EditLineOpenScroll.MouseButton1Down:Connect(function()
	script.Parent.Parent.StartFrame.Scroll.EditLineOpenScroll.Visible = false
	script.Parent.Parent.StartFrame.Scroll.ScrollFrame.Visible = true
	script.Parent.Parent.StartFrame.Scroll.LineSelected.Text = " "
	script.Parent.Parent.StartFrame.Scroll.temp.Visible = false
end)


for i,v in pairs(script.Parent.Parent.StartFrame.Scroll.ScrollFrame:GetDescendants()) do
	local frame = script.Parent.Parent.StartFrame.Scroll.ScrollFrame
	v.MouseButton1Down:connect(function()
		RowSelected = v:GetAttribute("WhatLine")
		frame.Visible = false
		script.Parent.Parent.StartFrame.Scroll.LineSelected.Text = RowSelected
		script.Parent.Parent.StartFrame.Scroll.EditLineOpenScroll.Visible = true
		script.Parent.Parent.StartFrame.Scroll.temp.Visible = true
		for i,v in pairs(script.Parent.Parent.StartFrame.Go:GetDescendants()) do
			v.Visible = true
		end
	end)
end

script.Parent.Parent.StartFrame.Go.GoPress.MouseButton1Down:Connect(function()
	for i,v in pairs(script.Parent.Parent.StartFrame.Go:GetDescendants()) do
		v.Visible = false
		script.Parent.Parent.StartFrame.Scroll.LineSelected.Text = ""
		script.Parent.Parent.StartFrame.Visible = false
		MainFrame.Visible = true
	end
	script.Parent.Activate:FireServer(plr,RowSelected)
end)

MainFrame.FlightTime.SetTime.MouseButton1Down:connect(function()
	local data = MainFrame.FlightTime.TimeInput.Text
	script.Parent.SetTime:FireServer(plr,data,RowSelected)
end)

MainFrame.FlightNo.SetFlightNo.MouseButton1Down:connect(function()
	local data = MainFrame.FlightNo.FlightInput.Text
	script.Parent.SetFlightNo:FireServer(plr,data,RowSelected)
end)

MainFrame.Dest.SetDest.MouseButton1Down:connect(function()
	local data = MainFrame.Dest.DestInput.Text
	script.Parent.SetDest:FireServer(plr,data,RowSelected)
end)

MainFrame.Remarks.DropdownClick.MouseButton1Down:connect(function()
	MainFrame.Remarks.DropdownPart.Visible = false
	MainFrame.Remarks.TextV.Visible = false
	MainFrame.Remarks.ScrollFrame.Visible = true
end)

for i,v in pairs(MainFrame.Remarks.ScrollFrame:GetDescendants()) do
	
	v.MouseButton1Down:connect(function()
		selectedRemark = v:GetAttribute("WhatOption")
		MainFrame.Remarks.ScrollFrame.Visible = false
		MainFrame.Remarks.DropdownPart.Visible = true
		MainFrame.Remarks.TextV.Visible = true
		MainFrame.Remarks.SelectedOne.Text = selectedRemark
	end)
end

MainFrame.Remarks.SetRemarks.MouseButton1Down:connect(function()
	script.Parent.SetRemark:FireServer(plr,selectedRemark,RowSelected)
end)

MainFrame.Gate.SetGate.MouseButton1Down:connect(function()
	local data = MainFrame.Gate.GateInput.Text
	script.Parent.SetGate:FireServer(plr,data,RowSelected)
end)

for i,v in pairs(MainFrame:GetDescendants()) do
	if v.Name == "Reset" then
		v.MouseButton1Down:connect(function()
			local attr = v:GetAttribute("WhatString")
			script.Parent.Reset:FireServer(plr,attr,RowSelected)
		end)
	end
end

script.Parent.Parent.Using.DismissPress.MouseButton1Down:Connect(function()
	script.Parent.Parent:Destroy()
end)

script.Parent.Parent.Using.OverPress.MouseButton1Down:Connect(function()
	local playername = game.Players.LocalPlayer.Name
	game.ReplicatedStorage:WaitForChild("Dont Change This Name").DontTouch.OverEvent:FireServer(plr,playername)
	script.Parent.Parent.Using.Visible = false
	script.Parent.Parent.StartFrame.Visible = true
end)

script.Parent.Parent.StartFrame.close.ButtonClose.MouseButton1Down:Connect(function()
	game.ReplicatedStorage:WaitForChild("Dont Change This Name").DontTouch.UsingEvent:FireServer(plr,"None")
	script.Parent.Parent:Destroy()
end)

script.Parent.Parent.MainFrame.ButtonClose.MouseButton1Down:Connect(function()
	game.ReplicatedStorage:WaitForChild("Dont Change This Name").DontTouch.UsingEvent:FireServer(plr,"None")
	script.Parent.Parent:Destroy()
end)
