--[[
	id: bQnLKhZoJyh0-PK1iQ8ou
	name: bsploit
	description: bsploit script hub
	time1: 2021-06-09 21:13:49.584706+00
	time2: 2021-06-09 21:13:49.584707+00
	uploader: 2TKhqQtQGnfNFojI8MjdTniMBUM6bez9h-mAK_1m
	uploadersession: iIirTeGazVHfKg-c4a1o-hPlPXLa69
	flag: f
--]]

-- bsploit


local BSPLOIT = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local UICorner1 = Instance.new("UICorner")
local TabContainer = Instance.new("Frame")
local UICorner1_2 = Instance.new("UICorner")
local LT2TabButton = Instance.new("TextButton")
local UICorner3 = Instance.new("UICorner")
local PFTabButton = Instance.new("TextButton")
local UICorner3_2 = Instance.new("UICorner")
local PFTab = Instance.new("Frame")
local PF1 = Instance.new("TextButton")
local UICorner3_3 = Instance.new("UICorner")
local PF2 = Instance.new("TextButton")
local UICorner3_4 = Instance.new("UICorner")
local UICorner1_3 = Instance.new("UICorner")
local UIGridLayout = Instance.new("UIGridLayout")
local LT2Tab = Instance.new("Frame")
local AzureHub = Instance.new("TextButton")
local UICorner3_5 = Instance.new("UICorner")
local Silent = Instance.new("TextButton")
local UICorner3_6 = Instance.new("UICorner")
local UICorner1_4 = Instance.new("UICorner")
local UIGridLayout_2 = Instance.new("UIGridLayout")
local Welcome = Instance.new("TextLabel")
local UICorner1_5 = Instance.new("UICorner")

--Properties:

BSPLOIT.Name = "BSPLOIT"
BSPLOIT.Parent = game.CoreGui

Main.Name = "Main"
Main.Parent = BSPLOIT
Main.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.313, 0, 0.316, 0)
Main.Size = UDim2.new(0, 500, 0, 300)
Main.Active = true
Main.Draggable = true

Title.Name = "Title"
Title.Parent = Main
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Position = UDim2.new(0, 10, 0, 2)
Title.Size = UDim2.new(0, 107, 0, 47)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "BSPLOIT"
Title.TextColor3 = Color3.fromRGB(50, 150, 250)
Title.TextScaled = true
Title.TextSize = 14.000
Title.TextWrapped = true

UICorner1.CornerRadius = UDim.new(0, 10)
UICorner1.Name = "UICorner1"
UICorner1.Parent = Main

TabContainer.Name = "TabContainer"
TabContainer.Parent = Main
TabContainer.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TabContainer.BorderSizePixel = 0
TabContainer.Position = UDim2.new(0.00100000005, 0, 0.167999998, 0)
TabContainer.Size = UDim2.new(0, 117, 0, 249)

UICorner1_2.CornerRadius = UDim.new(0, 10)
UICorner1_2.Name = "UICorner1"
UICorner1_2.Parent = TabContainer

LT2TabButton.Name = "LT2TabButton"
LT2TabButton.Parent = TabContainer
LT2TabButton.BackgroundColor3 = Color3.fromRGB(50, 150, 250)
LT2TabButton.ClipsDescendants = true
LT2TabButton.Position = UDim2.new(0.0329999998, 0, 0.00999999978, 0)
LT2TabButton.Size = UDim2.new(0, 110, 0, 30)
LT2TabButton.Font = Enum.Font.SourceSansBold
LT2TabButton.Text = "LT2"
LT2TabButton.TextColor3 = Color3.fromRGB(230, 230, 230)
LT2TabButton.TextScaled = true
LT2TabButton.TextSize = 14.000
LT2TabButton.TextWrapped = true

UICorner3.Name = "UICorner3"
UICorner3.Parent = LT2TabButton

PFTabButton.Name = "PFTabButton"
PFTabButton.Parent = TabContainer
PFTabButton.BackgroundColor3 = Color3.fromRGB(50, 150, 250)
PFTabButton.ClipsDescendants = true
PFTabButton.Position = UDim2.new(0.0329999998, 0, 0.154578313, 0)
PFTabButton.Size = UDim2.new(0, 110, 0, 30)
PFTabButton.Font = Enum.Font.SourceSansBold
PFTabButton.Text = "PF"
PFTabButton.TextColor3 = Color3.fromRGB(230, 230, 230)
PFTabButton.TextScaled = true
PFTabButton.TextSize = 14.000
PFTabButton.TextWrapped = true

UICorner3_2.Name = "UICorner3"
UICorner3_2.Parent = PFTabButton

PFTab.Name = "PFTab"
PFTab.Parent = TabContainer
PFTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
PFTab.BorderSizePixel = 0
PFTab.Position = UDim2.new(1.04941881, 0, -0.00067460537, 0)
PFTab.Size = UDim2.new(0, 376, 0, 249)
PFTab.Visible = false

PF1.Name = "PF1"
PF1.Parent = PFTab
PF1.AnchorPoint = Vector2.new(0.5, 0.5)
PF1.BackgroundColor3 = Color3.fromRGB(50, 150, 250)
PF1.BorderSizePixel = 0
PF1.ClipsDescendants = true
PF1.Position = UDim2.new(0.511978745, 0, 0.648313284, 0)
PF1.Size = UDim2.new(0.469999999, 0, 0.100000001, 0)
PF1.Font = Enum.Font.SourceSansBold
PF1.Text = "PF1"
PF1.TextColor3 = Color3.fromRGB(230, 230, 230)
PF1.TextScaled = true
PF1.TextSize = 30.000
PF1.TextWrapped = true
PF1.MouseButton1Click:Connect(function()
	print("PF1 - Clicked")
end)

UICorner3_3.Name = "UICorner3"
UICorner3_3.Parent = PF1

PF2.Name = "PF2"
PF2.Parent = PFTab
PF2.AnchorPoint = Vector2.new(0.5, 0.5)
PF2.BackgroundColor3 = Color3.fromRGB(50, 150, 250)
PF2.BorderSizePixel = 0
PF2.ClipsDescendants = true
PF2.Position = UDim2.new(0.744000018, 0, 0.0700000003, 0)
PF2.Size = UDim2.new(0.469999999, 0, 0.100000001, 0)
PF2.Font = Enum.Font.SourceSansBold
PF2.Text = "PF2"
PF2.TextColor3 = Color3.fromRGB(230, 230, 230)
PF2.TextScaled = true
PF2.TextSize = 30.000
PF2.TextWrapped = true
PF2.MouseButton1Click:Connect(function()
	print("PF2 - Clicked")
end)

UICorner3_4.Name = "UICorner3"
UICorner3_4.Parent = PF2

UICorner1_3.CornerRadius = UDim.new(0, 10)
UICorner1_3.Name = "UICorner1"
UICorner1_3.Parent = PFTab

UIGridLayout.Parent = PFTab
UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellSize = UDim2.new(0, 180, 0, 30)

LT2Tab.Name = "LT2Tab"
LT2Tab.Parent = TabContainer
LT2Tab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
LT2Tab.BorderSizePixel = 0
LT2Tab.Position = UDim2.new(1.04941881, 0, 0, 0)
LT2Tab.Size = UDim2.new(0, 376, 0, 249)
LT2Tab.Visible = false

AzureHub.Name = "AzureHub"
AzureHub.Parent = LT2Tab
AzureHub.AnchorPoint = Vector2.new(0.5, 0.5)
AzureHub.BackgroundColor3 = Color3.fromRGB(50, 150, 250)
AzureHub.BorderSizePixel = 0
AzureHub.ClipsDescendants = true
AzureHub.Position = UDim2.new(0.511978745, 0, 0.648313284, 0)
AzureHub.Size = UDim2.new(0.469999999, 0, 0.100000001, 0)
AzureHub.Font = Enum.Font.SourceSansBold
AzureHub.Text = "AzureHub"
AzureHub.TextColor3 = Color3.fromRGB(230, 230, 230)
AzureHub.TextScaled = true
AzureHub.TextSize = 30.000
AzureHub.TextWrapped = true
AzureHub.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://zypher.wtf/azurescript"))()
end)

UICorner3_5.Name = "UICorner3"
UICorner3_5.Parent = AzureHub

Silent.Name = "Silent"
Silent.Parent = LT2Tab
Silent.AnchorPoint = Vector2.new(0.5, 0.5)
Silent.BackgroundColor3 = Color3.fromRGB(50, 150, 250)
Silent.BorderSizePixel = 0
Silent.ClipsDescendants = true
Silent.Position = UDim2.new(0.744000018, 0, 0.0700000003, 0)
Silent.Size = UDim2.new(0.469999999, 0, 0.100000001, 0)
Silent.Font = Enum.Font.SourceSansBold
Silent.Text = "Silent"
Silent.TextColor3 = Color3.fromRGB(230, 230, 230)
Silent.TextScaled = true
Silent.TextSize = 30.000
Silent.TextWrapped = true
Silent.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Silent-Development/Silent-Development/main/lt2.wtfihatelife"))()
end)

UICorner3_6.Name = "UICorner3"
UICorner3_6.Parent = Silent

UICorner1_4.CornerRadius = UDim.new(0, 10)
UICorner1_4.Name = "UICorner1"
UICorner1_4.Parent = LT2Tab

UIGridLayout_2.Parent = LT2Tab
UIGridLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIGridLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout_2.CellSize = UDim2.new(0, 180, 0, 30)

Welcome.Name = "Welcome"
Welcome.Parent = TabContainer
Welcome.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Welcome.Position = UDim2.new(1.04900002, 0, -0.00100000005, 0)
Welcome.Size = UDim2.new(0, 376, 0, 249)
Welcome.Font = Enum.Font.SourceSansBold
Welcome.Text = "Welcome to BSPLOIT! Credit: BSense#7013"
Welcome.TextColor3 = Color3.fromRGB(50, 150, 250)
Welcome.TextSize = 40.000
Welcome.TextWrapped = true

UICorner1_5.CornerRadius = UDim.new(0, 10)
UICorner1_5.Name = "UICorner1"
UICorner1_5.Parent = Welcome

-- Scripts:

local function JTFCM_fake_script() -- LT2TabButton.LocalScript 
	local script = Instance.new('LocalScript', LT2TabButton)

	script.Parent.MouseButton1Click:Connect(function()
		script.Parent.Parent.LT2Tab.Visible = true
		script.Parent.Parent.PFTab.Visible = false
		script.Parent.Parent.Welcome.Visible = false
	end)
end
coroutine.wrap(JTFCM_fake_script)()
local function LJBKCZV_fake_script() -- PFTabButton.LocalScript 
	local script = Instance.new('LocalScript', PFTabButton)

	script.Parent.MouseButton1Click:Connect(function()
		script.Parent.Parent.LT2Tab.Visible = false
		script.Parent.Parent.PFTab.Visible = true
		script.Parent.Parent.Welcome.Visible = false
	end)
end
coroutine.wrap(LJBKCZV_fake_script)()
local function FCUROBQ_fake_script() -- Main.LocalScript 
	local script = Instance.new('LocalScript', BSPLOIT)

	local FrameObject = script.Parent.Main
	local Open = false
	
	local PositionClosed = UDim2.new(1.1, 0 ,0.316, 0)
	local PositionOpen = UDim2.new(0.72, 0, 0.66, 0)
	
	local UserInputService = game:GetService("UserInputService")
	
	UserInputService.InputBegan:connect(function(keyCode)
		if keyCode.keyCode == Enum.KeyCode.RightShift then
			if Open then
				FrameObject:TweenPosition((PositionClosed), 'Out','Linear',.25)
				Open = false
			else
				Open = true
				FrameObject:TweenPosition((PositionOpen), 'Out','Linear',.25)
			end
		end
	end)
end
coroutine.wrap(FCUROBQ_fake_script)()