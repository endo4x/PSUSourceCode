--[[
	id: JjX9BDNqa_f6bu1IZXXF2
	name: polarissci client
	description: polarissci client
	time1: 2021-05-23 01:28:49.566485+00
	time2: 2021-05-23 01:28:49.566486+00
	uploader: 7fYr1Pvc-PegVsGilkrVK2EOw-yvgz4mKNbnE3mZ
	uploadersession: johpelgYzC7ePR0qkvMf3e8DoS13j0
	flag: f
--]]

--[[ 
strings-override
polaris best
wow its a sci v3!11!!11!1 best sci bro
alyss was here
hi mom!
go buy more stuff ok thx <3
sheeeeeeeeeeesh
]]
local waittime
local event = script.Event.Value 
local closed = script.Closed.Value
script.Closed:Destroy()
local TS = game:GetService("TweenService")
local clickable = false
local tweenInfo = TweenInfo.new(
	0.9, 
	Enum.EasingStyle.Quad, 
	Enum.EasingDirection.Out, 
	0, 
	false, 
	0 
)
local current = nil
local onadmin = false
local function typewrite(TypeLabel,text)
	waittime = #text*.01
	for i = 1,#text do
		TypeLabel.Text = string.sub(text,1,i)
		wait(.01)
	end
end
local content, isReady = game.Players:GetUserThumbnailAsync(game.Players.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
script.Parent.WelcomeScreen.AvatarFrame.Image = content
if closed == true then
	script.Parent.ToggleScreen.Frame.zStatus.TopNav.Button.OnOffStatus.Text = "Self Check-In is off!"
	script.Parent.AdminScreen.Frame.zWelcomeReturn.Visible = false
elseif closed == false then
	script.Parent.ToggleScreen.Frame.zStatus.TopNav.Button.OnOffStatus.Text = "Self Check-In is on!"
	script.Parent.AdminScreen.Frame.zWelcomeReturn.Visible = true
end
if game.Players.LocalPlayer:GetRankInGroup(script.GroupID.Value) >= script.Min.Value then
	script.Parent.WelcomeScreen.Admin.MouseButton1Click:Connect(function()
		onadmin = true
		script.Parent.WelcomeScreen:TweenPosition(UDim2.new(0.5, 0, 1.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
		wait(0.4)
		script.Parent.AdminScreen:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
	end)
	script.Parent.ClosedScreen.Admin.MouseButton1Click:Connect(function()
		onadmin = true
		script.Parent.ClosedScreen:TweenPosition(UDim2.new(0.5, 0, 1.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
		wait(0.4)
		script.Parent.AdminScreen:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
	end)
	script.Parent.AdminScreen.Frame.zWelcomeReturn.TopNav.Button.TextLabel.MouseButton1Click:Connect(function()
		onadmin = false
		script.Parent.AdminScreen:TweenPosition(UDim2.new(0.5, 0, -0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
		wait(0.4)
		script.Parent.WelcomeScreen:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
		wait(0.6)
		if script.Parent.WelcomeScreen.TypeLabel.Text == "" then
			typewrite(script.Parent.WelcomeScreen.TypeLabel,"Welcome to "..script.Airport.Value.." Airport. Click the icon to proceed.")

			wait(waittime)

			script.Parent.WelcomeScreen.ConfirmIcon.Visible = true
			local tween = TS:Create(script.Parent.WelcomeScreen.ConfirmIcon, tweenInfo, {ImageTransparency = 0})	
			tween:Play()
			wait(0.7)
			clickable = true
		end
	end)
	script.Parent.AdminScreen.Frame.ypolarisSCIToggle.TopNav.Button.TextLabel.MouseButton1Click:Connect(function()
		script.Parent.AdminScreen:TweenPosition(UDim2.new(0.5, 0, 1.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
		wait(0.4)
		script.Parent.ToggleScreen:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
	end)
	script.Parent.AdminScreen.Frame.ClassSeatInfo.TopNav.Button.TextLabel.MouseButton1Click:Connect(function()
		script.Parent.AdminScreen:TweenPosition(UDim2.new(0.5, 0, 1.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
		wait(0.4)
		script.Parent.ClassSeatingScreen:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
	end)
	script.Parent.AdminScreen.Frame.FlightInformation.TopNav.Button.TextLabel.MouseButton1Click:Connect(function()
		script.Parent.AdminScreen:TweenPosition(UDim2.new(0.5, 0, 1.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
		wait(0.4)
		script.Parent.FlightInfoScreen:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
	end)
	script.Parent.ToggleScreen.Frame.WelcomeReturn.TopNav.Button.TextLabel.MouseButton1Click:Connect(function()
		script.Parent.ToggleScreen:TweenPosition(UDim2.new(0.5, 0, -0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
		wait(0.4)
		script.Parent.AdminScreen:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
	end)
	script.Parent.ClassSeatingScreen.Seats.ZZWelcomeReturn.TopNav.Button.TextLabel.MouseButton1Click:Connect(function()
		script.Parent.ClassSeatingScreen:TweenPosition(UDim2.new(0.5, 0, -0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
		wait(0.4)
		script.Parent.AdminScreen:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
	end)
	script.Parent.FlightInfoScreen.Frame.ZAdminReturn.TopNav.Button.TextLabel.MouseButton1Click:Connect(function()
		script.Parent.FlightInfoScreen:TweenPosition(UDim2.new(0.5, 0, -0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
		wait(0.4)
		script.Parent.AdminScreen:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
	end)
	script.Parent.ToggleScreen.Frame.AToggleOn.TopNav.Button.TextLabel.MouseButton1Click:Connect(function()
		event:FireServer("On")
		script.Parent.ToggleScreen.Frame.zStatus.TopNav.Button.OnOffStatus.Text = "Self Check-In is on!"
	end)
	script.Parent.ToggleScreen.Frame.ToggleOff.TopNav.Button.TextLabel.MouseButton1Click:Connect(function()
		event:FireServer("Off")
		script.Parent.ToggleScreen.Frame.zStatus.TopNav.Button.OnOffStatus.Text = "Self Check-In is off!"
	end)
	for i,v in pairs(script.Parent.FlightInfoScreen.Frame:GetChildren()) do
		if string.match(v.Name, "Flight") then
			if string.match(v.Name, "Aircraft") then
				v.Class1Aircraft.FocusLost:Connect(function()
					event:FireServer("AircraftUpdate", string.sub(v.Name, -1), v.Class1Aircraft.Text)
				end)
			elseif string.match(v.Name, "Date") then
				v.Class1D.FocusLost:Connect(function()
					event:FireServer("DUpdate", string.sub(v.Name, -1), v.Class1D.Text)
				end)
				v.Class1M.FocusLost:Connect(function()
					event:FireServer("MUpdate", string.sub(v.Name, -1), v.Class1M.Text)
				end)
			elseif string.match(v.Name, "Departure") then
				v.Class1Aircraft.FocusLost:Connect(function()
					event:FireServer("DepUpdate", string.sub(v.Name, -1), v.Class1Aircraft.Text)
				end)
			elseif string.match(v.Name, "Destination") then
				v.Class1Aircraft.FocusLost:Connect(function()
					event:FireServer("DestUpdate", string.sub(v.Name, -1), v.Class1Aircraft.Text)
				end)
			end
		end
	end
	for i,v in pairs(script.Parent.ClassSeatingScreen.Seats:GetChildren()) do
		if tonumber(v.Name) then
			if v:FindFirstChild("L") then
				v.L.FocusLost:Connect(function()
					if v.L.Text ~= "" then
						event:FireServer("SeatUpdate", tonumber(v.Name)-1, v.L.Text)
					else
						event:FireServer("SeatUpdate", tonumber(v.Name)-1, "0")
					end
				end)
				v.R.FocusLost:Connect(function()
					if v.R.Text ~= "" then
						event:FireServer("SeatUpdate", tonumber(v.Name), v.R.Text)
					else
						event:FireServer("SeatUpdate", tonumber(v.Name), "0")
					end
				end)
			elseif v:FindFirstChild("CSeats") then
				v.CSeats.FocusLost:Connect(function()
					if v.CSeats.Text ~= "" then
						event:FireServer("SeatUpdate", tonumber(v.Name), v.CSeats.Text)
					else
						event:FireServer("SeatUpdate", tonumber(v.Name), "0")
					end
				end)
			end
		end
	end
else
	script.Parent.AdminScreen:Destroy()
	script.Parent.WelcomeScreen.Admin:Destroy()
	script.Parent.ToggleScreen:Destroy()
	script.Parent.FlightInfoScreen:Destroy()
	script.Parent.ClassSeatingScreen:Destroy()
end
event.OnClientEvent:Connect(function(part, val, otherval)
	if part == "On" then
		closed = false
		script.Parent.ToggleScreen.Frame.zStatus.TopNav.Button.OnOffStatus.Text = "Self Check-In is on!"
		script.Parent.AdminScreen.Frame.zWelcomeReturn.Visible = true
		if onadmin then
			return
		else
			if script.Parent.AdminScreen.Position ~= UDim2.fromScale(0.5,-0.5) then
				script.Parent.AdminScreen:TweenPosition(UDim2.new(0.5, 0, -0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
				wait(0.4)
				script.Parent.WelcomeScreen:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
				wait(0.6)
				typewrite(script.Parent.WelcomeScreen.TypeLabel,"Welcome to "..script.Airport.Value.." Airport. Click the icon to proceed.")

				wait(waittime)

				script.Parent.WelcomeScreen.ConfirmIcon.Visible = true
				local tween = TS:Create(script.Parent.WelcomeScreen.ConfirmIcon, tweenInfo, {ImageTransparency = 0})	
				tween:Play()
				wait(0.7)
				clickable = true	
			end
		end
	elseif part == "Off" then
		closed = true
		script.Parent.ToggleScreen.Frame.zStatus.TopNav.Button.OnOffStatus.Text = "Self Check-In is off!"
		script.Parent.AdminScreen.Frame.zWelcomeReturn.Visible = false
		if onadmin then
			return
		else
			for i,v in pairs(script.Parent:GetChildren()) do
				if v:IsA("Frame") then
					v:TweenPosition(UDim2.new(0.5, 0, -0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
				end
			end
			wait(0.4)
			script.Parent.ClosedScreen:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
		end
	elseif part == "stockupdateone" then
		if tonumber(otherval) >= 0 then
			script.Parent.ClassSelectScreen.ScrollingFrame:FindFirstChild(val).ClassSelectFrame:FindFirstChild("SeatsLeft").SeatNumberLeft.Text = tostring(otherval)
		end	
	elseif part == "AircraftUpdate" then
		script.Parent.FlightSelectScreen:FindFirstChild(val).TopNav.Button.AircraftName.Text = otherval
	elseif part == "DUpdate" then
		script.Parent.FlightSelectScreen:FindFirstChild(val).TopNav.Button.Month.Day.Text = otherval
	elseif part == "MUpdate" then
		script.Parent.FlightSelectScreen:FindFirstChild(val).TopNav.Button.Month.Text = otherval
	elseif part == "DepUpdate" then
		script.Parent.FlightSelectScreen:FindFirstChild(val).TopNav.Button.Departure.Text = otherval
	elseif part == "DestUpdate" then
		script.Parent.FlightSelectScreen:FindFirstChild(val).TopNav.Button.Arrival.Text = otherval
	elseif part == "SeatUpdate" then
		if tonumber(otherval) >= 0 then
			if val == 1 then
				script.Parent.ClassSelectScreen.ScrollingFrame.AEco.ClassSelectFrame.SeatsLeft.SeatNumberLeft.Text = otherval
			else
				script.Parent.ClassSelectScreen.ScrollingFrame:FindFirstChild("Class"..tostring(val-1)).ClassSelectFrame.SeatsLeft.SeatNumberLeft.Text = otherval
			end
		end
	end
end)
script.Parent.FlightSelectScreen.AwesomeText1.Text = "Awesome, "..game.Players.LocalPlayer.Name.."."
for i,v in pairs(script.Parent:GetChildren()) do
	if v:IsA("Frame") then 
		v.ExitButton.MouseButton1Click:Connect(function()
			v:TweenPosition(UDim2.new(0.5, 0, 1.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
			wait(0.6)
			event:FireServer("X")
		end)
	end
end
for i,v in pairs(script.Parent.FlightSelectScreen:GetChildren()) do
	if tonumber(v.Name) == 1 then
		local tweenInfo = TweenInfo.new(
			0.4, 
			Enum.EasingStyle.Quad, 
			Enum.EasingDirection.Out, 
			0, 
			false, 
			0 
		)
		v.TopNav.Button.Click.MouseButton1Click:Connect(function()
			if current == nil then
				current = v
				local tween = TS:Create(script.Parent.FlightSelectScreen.AwesomeText, tweenInfo, {TextTransparency = 0})	
				local tween1 = TS:Create(script.Parent.FlightSelectScreen.AwesomeText1, tweenInfo, {TextTransparency = 0})	
				tween:Play()
				tween1:Play()
				wait(0.4)
				script.Parent.FlightSelectScreen.ConfirmIcon.Visible = true
				local tween = TS:Create(script.Parent.FlightSelectScreen.ConfirmIcon, tweenInfo, {ImageTransparency = 0})	
				tween:Play()
				wait(0.4)
				clickable = true
			elseif current == v then
				current = nil
				clickable = false
				local tween = TS:Create(script.Parent.FlightSelectScreen.AwesomeText, tweenInfo, {TextTransparency = 1})	
				local tween1 = TS:Create(script.Parent.FlightSelectScreen.AwesomeText1, tweenInfo, {TextTransparency = 1})	
				tween:Play()
				tween1:Play()
				local tween = TS:Create(script.Parent.FlightSelectScreen.ConfirmIcon, tweenInfo, {ImageTransparency = 1})	
				tween:Play()
				wait(0.4)
				script.Parent.FlightSelectScreen.ConfirmIcon.Visible = false
			else
				current = v
			end
		end)
	elseif tonumber(v.Name) then
		v.TopNav.Button.Click.MouseButton1Click:Connect(function()
			local tween = TS:Create(script.Parent.FlightSelectScreen.FlightAvailableFrame, tweenInfo, {BackgroundTransparency = 0})
			local tween2 = TS:Create(script.Parent.FlightSelectScreen.FlightAvailableFrame.Departure, tweenInfo, {TextTransparency = 0})
			tween:Play()
			tween2:Play()
			wait(1.5)
			local tween = TS:Create(script.Parent.FlightSelectScreen.FlightAvailableFrame, tweenInfo, {BackgroundTransparency = 1})
			local tween2 = TS:Create(script.Parent.FlightSelectScreen.FlightAvailableFrame.Departure, tweenInfo, {TextTransparency = 1})
			tween:Play()
			tween2:Play()
		end)
	end
end
local function onend()
	local tween = TS:Create(script.Parent.ClassSelectScreen.AwesomeText, tweenInfo, {TextTransparency = 0})	
	local tween1 = TS:Create(script.Parent.ClassSelectScreen.AwesomeText1, tweenInfo, {TextTransparency = 0})	
	tween:Play()
	tween1:Play()
	wait(1)
	script.Parent.ClassSelectScreen:TweenPosition(UDim2.new(0.5, 0, 1.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
	wait(0.4)
	script.Parent.TicketPrintScreen:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
	wait(0.6)
	script.Parent.TicketPrintScreen.LoadingIcon.Spin.Disabled = false
	wait(1.5)
	script.Parent.TicketPrintScreen.LoadingIcon.Spin.Disabled = true
	wait(0.5)
	local tween = TS:Create(script.Parent.TicketPrintScreen.AwesomeText, tweenInfo, {TextTransparency = 0})
	local tween1 = TS:Create(script.Parent.TicketPrintScreen.CheckIcon, tweenInfo, {ImageTransparency = 0})
	local tween2 = TS:Create(script.Parent.TicketPrintScreen.AwesomeText1, tweenInfo, {TextTransparency = 1})
	local tween3 = TS:Create(script.Parent.TicketPrintScreen.LoadingIcon, tweenInfo, {ImageTransparency = 1})
	tween:Play()
	tween1:Play()
	tween2:Play()
	tween3:Play()
	wait(1.5)
	script.Parent.TicketPrintScreen:TweenPosition(UDim2.new(0.5, 0, 1.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
	wait(0.4)
	script.Parent.SuccessScreen:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
end
for i,v in pairs(script.Parent.ClassSelectScreen.ScrollingFrame:GetChildren()) do
	if v:IsA("Frame") then
		v.ClassSelectFrame.Select.MouseButton1Click:Connect(function()
			if v.Name == "AEco" then
				if tonumber(v.ClassSelectFrame.SeatsLeft.SeatNumberLeft.Text) > 0 then
					event:FireServer("give", "Eco")
					onend()
				else
					local tween = TS:Create(script.Parent.ClassSelectScreen.OOS, tweenInfo, {BackgroundTransparency = 0, TextTransparency = 0})	
					tween:Play()
					wait(1.5)
					local tween = TS:Create(script.Parent.ClassSelectScreen.OOS, tweenInfo, {BackgroundTransparency = 1, TextTransparency = 1})	
					tween:Play()
				end
			else
				if string.lower(v.ClassSelectFrame.Type.Value) == "tshirt" then
					if game.MarketplaceService:PlayerOwnsAsset(game.Players.LocalPlayer, v.ClassSelectFrame.ID.Value) or game.Players.LocalPlayer:GetRankInGroup(script.GroupID.Value) == v.ClassSelectFrame.Rank.Value then
						if tonumber(v.ClassSelectFrame.SeatsLeft.SeatNumberLeft.Text) > 0 then
							event:FireServer("give", v.ClassSelectFrame.Type.Value, v.ClassSelectFrame.ID.Value, v.Name)
							onend()
						else
							local tween = TS:Create(script.Parent.ClassSelectScreen.OOS, tweenInfo, {BackgroundTransparency = 0, TextTransparency = 0})	
							tween:Play()
							wait(1.5)
							local tween = TS:Create(script.Parent.ClassSelectScreen.OOS, tweenInfo, {BackgroundTransparency = 1, TextTransparency = 1})	
							tween:Play()
						end
					else
						local tween = TS:Create(script.Parent.ClassSelectScreen.NoOwn, tweenInfo, {BackgroundTransparency = 0, TextTransparency = 0})	
						tween:Play()
						wait(1.5)
						local tween = TS:Create(script.Parent.ClassSelectScreen.NoOwn, tweenInfo, {BackgroundTransparency = 1, TextTransparency = 1})	
						tween:Play()
					end
				elseif string.lower(v.ClassSelectFrame.Type.Value) == "gamepass" then
					if game.MarketplaceService:UserOwnsGamePassAsync(game.Players.LocalPlayer.UserId, v.ClassSelectFrame.ID.Value) or game.Players.LocalPlayer:GetRankInGroup(script.GroupID.Value) == v.ClassSelectFrame.Rank.Value then
						if tonumber(v.ClassSelectFrame.SeatsLeft.SeatNumberLeft.Text) > 0 then
							event:FireServer("give", v.ClassSelectFrame.Type.Value, v.ClassSelectFrame.ID.Value, v.Name)
							onend()
						else
							local tween = TS:Create(script.Parent.ClassSelectScreen.OOS, tweenInfo, {BackgroundTransparency = 0, TextTransparency = 0})	
							tween:Play()
							wait(1.5)
							local tween = TS:Create(script.Parent.ClassSelectScreen.OOS, tweenInfo, {BackgroundTransparency = 1, TextTransparency = 1})	
							tween:Play()
						end
					else
						local tween = TS:Create(script.Parent.ClassSelectScreen.NoOwn, tweenInfo, {BackgroundTransparency = 0, TextTransparency = 0})	
						tween:Play()
						wait(1.5)
						local tween = TS:Create(script.Parent.ClassSelectScreen.NoOwn, tweenInfo, {BackgroundTransparency = 1, TextTransparency = 1})	
						tween:Play()
					end
				end
			end
		end)
		if v.Name ~= "AEco" then
			v.ClassSelectFrame.Purchase.MouseButton1Click:Connect(function()
				if string.lower(v.ClassSelectFrame.Type.Value) == "gamepass" then
					game.MarketplaceService:PromptGamePassPurchase(game.Players.LocalPlayer, v.ClassSelectFrame.ID.Value)
				elseif string.lower(v.ClassSelectFrame.Type.Value) == "tshirt" then
					game.MarketplaceService:PromptPurchase(game.Players.LocalPlayer, v.ClassSelectFrame.ID.Value)
				end
			end)
		end
	end
end
script.Parent.WelcomeScreen.ConfirmIcon.MouseButton1Click:Connect(function()
	if clickable == true then
		clickable = false
		script.Parent.WelcomeScreen:TweenPosition(UDim2.new(0.5, 0, 1.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
		wait(0.4)
		script.Parent.FlightSelectScreen:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
	end
end)
script.Parent.FlightSelectScreen.ConfirmIcon.MouseButton1Click:Connect(function()
	if clickable == true then
		clickable = false
		current = nil
		script.Parent.FlightSelectScreen:TweenPosition(UDim2.new(0.5, 0, 1.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
		wait(0.4)
		script.Parent.ClassSelectScreen:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
	end
end)
if closed == false then
	script.Parent.WelcomeScreen:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
	wait(0.6)
	typewrite(script.Parent.WelcomeScreen.TypeLabel,"Welcome to "..script.Airport.Value.." Airport. Click the icon to proceed.")

	wait(waittime)

	script.Parent.WelcomeScreen.ConfirmIcon.Visible = true
	local tween = TS:Create(script.Parent.WelcomeScreen.ConfirmIcon, tweenInfo, {ImageTransparency = 0})	
	tween:Play()
	wait(0.7)
	clickable = true
else
	script.Parent.ClosedScreen:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
end