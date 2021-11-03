--[[
	id: 2lqZi-Qz9S42VCAIOsWOD
	name: clocking machine client
	description: clocking machine client
	time1: 2021-05-21 02:40:40.664051+00
	time2: 2021-05-21 02:40:40.664051+00
	uploader: 7fYr1Pvc-PegVsGilkrVK2EOw-yvgz4mKNbnE3mZ
	uploadersession: johpelgYzC7ePR0qkvMf3e8DoS13j0
	flag: f
--]]

--[[ 
strings-override
polaris best
wow its a clocking machine
alyss was here
hi mom!
go buy more stuff ok thx <3
sheeeeeeeeeeesh
]]
local event = script.EV.Value
local TS = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(
	0.7, 
	Enum.EasingStyle.Quad, 
	Enum.EasingDirection.Out, 
	0, 
	false, 
	0 
)
script.Parent.Auth.Welcome.Text = "Welcome, "..game.Players.LocalPlayer.DisplayName.."!"
script.Parent.Welcome.ImageButton.MouseButton1Click:Connect(function()
	script.Parent.Welcome:TweenPosition(UDim2.new(-0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
	wait(0.4)
	script.Parent.Auth:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
	wait(0.6)
	script.Parent.Auth.LoadingIcon.Spin.Disabled = false
	wait(2)
	script.Parent.Auth.LoadingIcon.Spin.Disabled = true
	local tween = TS:Create(script.Parent.Auth.LoadingIcon, tweenInfo, {ImageTransparency = 1})	
	tween:Play()
	local tween = TS:Create(script.Parent.Auth.Authenticating, tweenInfo, {TextTransparency = 1})	
	tween:Play()
	wait(0.7)
	script.Parent.Auth.Authenticating.Text = "Authenticated!"
	local tween = TS:Create(script.Parent.Auth.Welcome, tweenInfo, {TextTransparency = 0})	
	tween:Play()
	local tween = TS:Create(script.Parent.Auth.Authenticating, tweenInfo, {TextTransparency = 0})	
	tween:Play()
	wait(1.3)
	script.Parent.Auth:TweenPosition(UDim2.new(-0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
	wait(0.4)
	script.Parent.Main:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
end)
for i,v in pairs(script.Parent:GetChildren()) do
	if v:IsA("Frame") then
		if v:FindFirstChild("X") then
			v.X.MouseButton1Click:Connect(function()
				v:TweenPosition(UDim2.new(0.5, 0, 1.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
				wait(0.6)
				event:FireServer("X")
			end)
		end
	end
end

script.Parent.Main.In.MouseButton1Click:Connect(function()
	event:FireServer("In")
end)
script.Parent.Main.Out.MouseButton1Click:Connect(function()
	event:FireServer("Out")
end)
event.OnClientEvent:Connect(function(action) 
	if action == "Out" then
		script.Parent.Auth.Authenticating.Text = "Processing"
		script.Parent.Auth.LoadingIcon.ImageTransparency = 0
		script.Parent.Auth.Welcome.TextTransparency = 1
		script.Parent.Auth.Position = UDim2.fromScale(1.5, 0.5)
		script.Parent.Main:TweenPosition(UDim2.new(-0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
		wait(0.4)
		script.Parent.Auth:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
		wait(0.6)
		script.Parent.Auth.LoadingIcon.Spin.Disabled = false
		wait(2)
		script.Parent.Auth.LoadingIcon.Spin.Disabled = true
		local tween = TS:Create(script.Parent.Auth.LoadingIcon, tweenInfo, {ImageTransparency = 1})	
		tween:Play()
		local tween = TS:Create(script.Parent.Auth.Authenticating, tweenInfo, {TextTransparency = 1})	
		tween:Play()
		wait(0.7)
		script.Parent.Auth.Authenticating.Text = "You're all set!"
		script.Parent.Auth.Welcome.Text = "You may now close out of this screen."
		local tween = TS:Create(script.Parent.Auth.Welcome, tweenInfo, {TextTransparency = 0})	
		tween:Play()
		local tween = TS:Create(script.Parent.Auth.Authenticating, tweenInfo, {TextTransparency = 0})	
		tween:Play()
		script.Parent.Auth.X.Visible = true
		local tween = TS:Create(script.Parent.Auth.X, tweenInfo, {TextTransparency = 0})	
		tween:Play()
	elseif action == "CantOut" then
		script.Parent.Main.Cant.Text = "You can't clock out if you haven't clocked in!"
		local tween = TS:Create(script.Parent.Main.Cant, tweenInfo, {TextTransparency = 0})	
		tween:Play()
		wait(1.3)
		local tween = TS:Create(script.Parent.Main.Cant, tweenInfo, {TextTransparency = 1})	
		tween:Play()
	elseif action == "CantIn" then
		script.Parent.Main.Cant.Text = "You can't clock in if you already clocked in!"
		local tween = TS:Create(script.Parent.Main.Cant, tweenInfo, {TextTransparency = 0})	
		tween:Play()
		wait(1.3)
		local tween = TS:Create(script.Parent.Main.Cant, tweenInfo, {TextTransparency = 1})	
		tween:Play()
	end
end)
script.Parent.Welcome:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6, false)
