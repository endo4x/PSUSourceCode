--[[
	id: gwQ-cJT87KOvQMSrsPpm3
	name: Raindrop Hub Key System
	description: yes key
	time1: 2021-05-18 15:01:17.305366+00
	time2: 2021-05-18 15:01:17.305367+00
	uploader: W8FWkprIhNQI7YQ7QPOCyvO4IKY4ZDXoHwppQrFA
	uploadersession: kwQzQ1-KWp1i1xlgg3opWMxfNCbkD1
	flag: f
--]]

-- Gui to Lua
-- Version: 3.2

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("ImageLabel")
local Frame_2 = Instance.new("ImageLabel")
local Frame_3 = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local keytext = Instance.new("TextBox")
local Frame_4 = Instance.new("Frame")
local TextLabel_2 = Instance.new("TextLabel")
local enter = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

--Properties:

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Name = "Frame"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BackgroundTransparency = 1.000
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.414248019, 0, 0.263991565, 0)
Frame.Size = UDim2.new(0, 325, 0, 447)
Frame.Image = "rbxassetid://3570695787"
Frame.ImageColor3 = Color3.fromRGB(255, 88, 82)
Frame.ScaleType = Enum.ScaleType.Slice
Frame.SliceCenter = Rect.new(100, 100, 100, 100)
Frame.SliceScale = 0.120

Frame_2.Name = "Frame"
Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame_2.BackgroundTransparency = 1.000
Frame_2.Position = UDim2.new(-0.00113660097, 0, -0.00222766399, 0)
Frame_2.Size = UDim2.new(0, 325, 0, 42)
Frame_2.Image = "rbxassetid://3570695787"
Frame_2.ImageColor3 = Color3.fromRGB(79, 79, 79)
Frame_2.ScaleType = Enum.ScaleType.Slice
Frame_2.SliceCenter = Rect.new(100, 100, 100, 100)
Frame_2.SliceScale = 0.120

Frame_3.Parent = Frame
Frame_3.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
Frame_3.BorderSizePixel = 0
Frame_3.Position = UDim2.new(-0.00113656849, 0, 0.0554914027, 0)
Frame_3.Size = UDim2.new(0, 325, 0, 16)

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Size = UDim2.new(0, 324, 0, 40)
TextLabel.Font = Enum.Font.GothamBlack
TextLabel.Text = "Login"
TextLabel.TextColor3 = Color3.fromRGB(241, 241, 241)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

keytext.Name = "keytext"
keytext.Parent = Frame
keytext.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
keytext.BorderSizePixel = 0
keytext.Position = UDim2.new(0.101538457, 0, 0.418344527, 0)
keytext.Size = UDim2.new(0, 259, 0, 50)
keytext.Font = Enum.Font.SourceSans
keytext.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
keytext.Text = ""
keytext.TextColor3 = Color3.fromRGB(255, 255, 255)
keytext.TextScaled = true
keytext.TextSize = 14.000
keytext.TextWrapped = true

Frame_4.Parent = Frame
Frame_4.BackgroundColor3 = Color3.fromRGB(66, 157, 255)
Frame_4.BorderSizePixel = 0
Frame_4.Position = UDim2.new(0.101538464, 0, 0.530201375, 0)
Frame_4.Size = UDim2.new(0, 259, 0, 2)

TextLabel_2.Parent = Frame
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1.000
TextLabel_2.Position = UDim2.new(0.00307692308, 0, 0.315436244, 0)
TextLabel_2.Size = UDim2.new(0, 324, 0, 40)
TextLabel_2.Font = Enum.Font.GothamBlack
TextLabel_2.Text = "Key"
TextLabel_2.TextColor3 = Color3.fromRGB(241, 241, 241)
TextLabel_2.TextScaled = true
TextLabel_2.TextSize = 14.000
TextLabel_2.TextWrapped = true

enter.Name = "enter"
enter.Parent = Frame
enter.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
enter.Position = UDim2.new(0.193846151, 0, 0.610738218, 0)
enter.Size = UDim2.new(0, 200, 0, 50)
enter.Font = Enum.Font.GothamBlack
enter.Text = "Enter"
enter.TextColor3 = Color3.fromRGB(255, 255, 255)
enter.TextScaled = true
enter.TextSize = 14.000
enter.TextWrapped = true
enter.MouseButton1Down:connect(function()
	local key = keytext.Text
	local userid = game:GetService('Players').LocalPlayer.UserId
	local url = "https://raindrophubmanager.000webhostapp.com/index.php?key="..key.."&user="..userid

	if game:HttpGet(url) == "~ True ~" then
		enter.Text = "Checking Key"
		wait(0.8)
		enter.Text = "Encrypting Login"
		wait(1)
		enter.Text = "Scanning"
		wait(0.5)
		enter.Text = "Whitelisted!"
		wait(1)
		loadstring(game:HttpGet(('https://raindrophubmanager.000webhostapp.com/script.lua'),true))()
		Frame.Visible = false
	else
		--// Not Whitelisted Script Here
		enter.Text = "Checking Key"
		wait(0.8)
		enter.Text = "Invalid Key"
		wait(1)
		enter.Text = "Enter"
	end
end)
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = enter

-- Scripts:

local function FIAZUA_fake_script() -- Frame.Dragify 
	local script = Instance.new('LocalScript', Frame)

	local UIS = game:GetService("UserInputService")
	function dragify(Frame)
	    dragToggle = nil
	    local dragSpeed = 0
	    dragInput = nil
	    dragStart = nil
	    local dragPos = nil
	    function updateInput(input)
	        local Delta = input.Position - dragStart
	        local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
	        game:GetService("TweenService"):Create(Frame, TweenInfo.new(0.25), {Position = Position}):Play()
	    end
	    Frame.InputBegan:Connect(function(input)
	        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UIS:GetFocusedTextBox() == nil then
	            dragToggle = true
	            dragStart = input.Position
	            startPos = Frame.Position
	            input.Changed:Connect(function()
	                if input.UserInputState == Enum.UserInputState.End then
	                    dragToggle = false
	                end
	            end)
	        end
	    end)
	    Frame.InputChanged:Connect(function(input)
	        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
	            dragInput = input
	        end
	    end)
	    game:GetService("UserInputService").InputChanged:Connect(function(input)
	        if input == dragInput and dragToggle then
	            updateInput(input)
	        end
	    end)
	end
	
	dragify(script.Parent)
end
coroutine.wrap(FIAZUA_fake_script)()
