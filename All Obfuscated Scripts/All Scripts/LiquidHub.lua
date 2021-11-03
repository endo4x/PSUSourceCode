--[[
	id: A3KKNTSwcX_uRJWpExYAA
	name: Liquid Hub
	description: joe
	time1: 2021-06-03 22:19:02.559988+00
	time2: 2021-06-03 22:19:02.559989+00
	uploader: 1397
	uploadersession: f8MGMm4JdCPBhrJ6KTxfMd0IovaEGH
	flag: f
--]]

-- Gui to Lua
-- Version: 3.2

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local Frame_2 = Instance.new("Frame")
local TextButton = Instance.new("TextButton")
local TextButton_2 = Instance.new("TextButton")
local Frame_3 = Instance.new("Frame")
local LuckyBlock_2 = Instance.new("TextButton")
local SuperBlock = Instance.new("TextButton")
local VoidBlock = Instance.new("TextButton")
local TextButton_3 = Instance.new("TextButton")
local TextButton_4 = Instance.new("TextButton")
local TextButton_5 = Instance.new("TextButton")
local TextButton_6 = Instance.new("TextButton")
local TextButton_7 = Instance.new("TextButton")
local TextButton_8 = Instance.new("TextButton")
local DiamondBlock = Instance.new("TextButton")
local TextButton_9 = Instance.new("TextButton")
local TextButton_10 = Instance.new("TextButton")
local TextButton_11 = Instance.new("TextButton")
local TextButton_12 = Instance.new("TextButton")
local RainbowBlock = Instance.new("TextButton")
local GalaxyBlock = Instance.new("TextButton")
local TextLabel_2 = Instance.new("TextLabel")
local Frame_4 = Instance.new("Frame")
local open_box = Instance.new("TextBox")
local TextLabel_3 = Instance.new("TextLabel")
local TextLabel_4 = Instance.new("TextLabel")

--Properties:

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.272374421, 0, 0.380221128, 0)
Frame.Size = UDim2.new(0, 597, 0, 195)

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.237855956, 0, 0, 0)
TextLabel.Size = UDim2.new(0, 313, 0, 50)
TextLabel.Font = Enum.Font.Gotham
TextLabel.Text = "Lucky Block Battle Grounds"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 25.000

Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.fromRGB(125, 82, 140)
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(0, 0, 0.224291503, 0)
Frame_2.Size = UDim2.new(0, 597, 0, 6)

TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(74, 74, 74)
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(0, 0, 0.254713714, 0)
TextButton.Selectable = false
TextButton.Size = UDim2.new(0, 55, 0, 24)
TextButton.AutoButtonColor = false
TextButton.Font = Enum.Font.Roboto
TextButton.Text = "LBBG"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextSize = 14.000

TextButton_2.Parent = Frame
TextButton_2.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
TextButton_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton_2.BorderSizePixel = 0
TextButton_2.Position = UDim2.new(0.0921273008, 0, 0.254713714, 0)
TextButton_2.Selectable = false
TextButton_2.Size = UDim2.new(0, 50, 0, 23)
TextButton_2.AutoButtonColor = false
TextButton_2.Font = Enum.Font.Roboto
TextButton_2.Text = "???"
TextButton_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_2.TextSize = 14.000

Frame_3.Parent = Frame
Frame_3.BackgroundColor3 = Color3.fromRGB(125, 82, 140)
Frame_3.BorderSizePixel = 0
Frame_3.Position = UDim2.new(0, 0, 0.372876912, 0)
Frame_3.Size = UDim2.new(0, 597, 0, 6)

LuckyBlock_2.Name = "LuckyBlock_2"
LuckyBlock_2.Parent = Frame
LuckyBlock_2.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
LuckyBlock_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
LuckyBlock_2.BorderSizePixel = 0
LuckyBlock_2.Position = UDim2.new(0.0100502502, 0, 0.470098436, 0)
LuckyBlock_2.Selectable = false
LuckyBlock_2.Size = UDim2.new(0, 88, 0, 32)
LuckyBlock_2.AutoButtonColor = false
LuckyBlock_2.Font = Enum.Font.Roboto
LuckyBlock_2.Text = "Lucky"
LuckyBlock_2.TextColor3 = Color3.fromRGB(255, 255, 255)
LuckyBlock_2.TextSize = 14.000

SuperBlock.Name = "SuperBlock"
SuperBlock.Parent = Frame
SuperBlock.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
SuperBlock.BorderColor3 = Color3.fromRGB(0, 0, 0)
SuperBlock.BorderSizePixel = 0
SuperBlock.Position = UDim2.new(0.175879404, 0, 0.470098436, 0)
SuperBlock.Selectable = false
SuperBlock.Size = UDim2.new(0, 88, 0, 32)
SuperBlock.AutoButtonColor = false
SuperBlock.Font = Enum.Font.Roboto
SuperBlock.Text = "Super"
SuperBlock.TextColor3 = Color3.fromRGB(255, 255, 255)
SuperBlock.TextSize = 14.000

VoidBlock.Name = "VoidBlock"
VoidBlock.Parent = Frame
VoidBlock.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
VoidBlock.BorderColor3 = Color3.fromRGB(0, 0, 0)
VoidBlock.BorderSizePixel = 0
VoidBlock.Position = UDim2.new(0.844221115, 0, 0.470098436, 0)
VoidBlock.Selectable = false
VoidBlock.Size = UDim2.new(0, 88, 0, 32)
VoidBlock.AutoButtonColor = false
VoidBlock.Font = Enum.Font.Roboto
VoidBlock.Text = "Void"
VoidBlock.TextColor3 = Color3.fromRGB(255, 255, 255)
VoidBlock.TextSize = 14.000

TextButton_3.Parent = Frame
TextButton_3.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
TextButton_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton_3.BorderSizePixel = 0
TextButton_3.Position = UDim2.new(0.175879404, 0, 0.254713804, 0)
TextButton_3.Selectable = false
TextButton_3.Size = UDim2.new(0, 50, 0, 23)
TextButton_3.AutoButtonColor = false
TextButton_3.Font = Enum.Font.Roboto
TextButton_3.Text = "???"
TextButton_3.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_3.TextSize = 14.000

TextButton_4.Parent = Frame
TextButton_4.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
TextButton_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton_4.BorderSizePixel = 0
TextButton_4.Position = UDim2.new(0.259631515, 0, 0.254713804, 0)
TextButton_4.Selectable = false
TextButton_4.Size = UDim2.new(0, 50, 0, 23)
TextButton_4.AutoButtonColor = false
TextButton_4.Font = Enum.Font.Roboto
TextButton_4.Text = "???"
TextButton_4.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_4.TextSize = 14.000

TextButton_5.Parent = Frame
TextButton_5.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
TextButton_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton_5.BorderSizePixel = 0
TextButton_5.Position = UDim2.new(0.34338361, 0, 0.254713804, 0)
TextButton_5.Selectable = false
TextButton_5.Size = UDim2.new(0, 50, 0, 23)
TextButton_5.AutoButtonColor = false
TextButton_5.Font = Enum.Font.Roboto
TextButton_5.Text = "???"
TextButton_5.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_5.TextSize = 14.000

TextButton_6.Parent = Frame
TextButton_6.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
TextButton_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton_6.BorderSizePixel = 0
TextButton_6.Position = UDim2.new(0.427135706, 0, 0.254713804, 0)
TextButton_6.Selectable = false
TextButton_6.Size = UDim2.new(0, 50, 0, 23)
TextButton_6.AutoButtonColor = false
TextButton_6.Font = Enum.Font.Roboto
TextButton_6.Text = "???"
TextButton_6.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_6.TextSize = 14.000

TextButton_7.Parent = Frame
TextButton_7.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
TextButton_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton_7.BorderSizePixel = 0
TextButton_7.Position = UDim2.new(0.510887802, 0, 0.254713804, 0)
TextButton_7.Selectable = false
TextButton_7.Size = UDim2.new(0, 50, 0, 23)
TextButton_7.AutoButtonColor = false
TextButton_7.Font = Enum.Font.Roboto
TextButton_7.Text = "???"
TextButton_7.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_7.TextSize = 14.000

TextButton_8.Parent = Frame
TextButton_8.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
TextButton_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton_8.BorderSizePixel = 0
TextButton_8.Position = UDim2.new(0.594639897, 0, 0.254713804, 0)
TextButton_8.Selectable = false
TextButton_8.Size = UDim2.new(0, 50, 0, 23)
TextButton_8.AutoButtonColor = false
TextButton_8.Font = Enum.Font.Roboto
TextButton_8.Text = "???"
TextButton_8.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_8.TextSize = 14.000

DiamondBlock.Name = "DiamondBlock"
DiamondBlock.Parent = Frame
DiamondBlock.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
DiamondBlock.BorderColor3 = Color3.fromRGB(0, 0, 0)
DiamondBlock.BorderSizePixel = 0
DiamondBlock.Position = UDim2.new(0.34338358, 0, 0.470098436, 0)
DiamondBlock.Selectable = false
DiamondBlock.Size = UDim2.new(0, 88, 0, 32)
DiamondBlock.AutoButtonColor = false
DiamondBlock.Font = Enum.Font.Roboto
DiamondBlock.Text = "Diamond"
DiamondBlock.TextColor3 = Color3.fromRGB(255, 255, 255)
DiamondBlock.TextSize = 14.000

TextButton_9.Parent = Frame
TextButton_9.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
TextButton_9.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton_9.BorderSizePixel = 0
TextButton_9.Position = UDim2.new(0.678391993, 0, 0.254713804, 0)
TextButton_9.Selectable = false
TextButton_9.Size = UDim2.new(0, 50, 0, 23)
TextButton_9.AutoButtonColor = false
TextButton_9.Font = Enum.Font.Roboto
TextButton_9.Text = "???"
TextButton_9.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_9.TextSize = 14.000

TextButton_10.Parent = Frame
TextButton_10.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
TextButton_10.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton_10.BorderSizePixel = 0
TextButton_10.Position = UDim2.new(0.760469019, 0, 0.254713804, 0)
TextButton_10.Selectable = false
TextButton_10.Size = UDim2.new(0, 50, 0, 23)
TextButton_10.AutoButtonColor = false
TextButton_10.Font = Enum.Font.Roboto
TextButton_10.Text = "???"
TextButton_10.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_10.TextSize = 14.000

TextButton_11.Parent = Frame
TextButton_11.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
TextButton_11.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton_11.BorderSizePixel = 0
TextButton_11.Position = UDim2.new(0.844221115, 0, 0.254713804, 0)
TextButton_11.Selectable = false
TextButton_11.Size = UDim2.new(0, 50, 0, 23)
TextButton_11.AutoButtonColor = false
TextButton_11.Font = Enum.Font.Roboto
TextButton_11.Text = "???"
TextButton_11.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_11.TextSize = 14.000

TextButton_12.Parent = Frame
TextButton_12.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
TextButton_12.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton_12.BorderSizePixel = 0
TextButton_12.Position = UDim2.new(0.916247904, 0, 0.254713804, 0)
TextButton_12.Selectable = false
TextButton_12.Size = UDim2.new(0, 50, 0, 23)
TextButton_12.AutoButtonColor = false
TextButton_12.Font = Enum.Font.Roboto
TextButton_12.Text = "???"
TextButton_12.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_12.TextSize = 14.000

RainbowBlock.Name = "RainbowBlock"
RainbowBlock.Parent = Frame
RainbowBlock.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
RainbowBlock.BorderColor3 = Color3.fromRGB(0, 0, 0)
RainbowBlock.BorderSizePixel = 0
RainbowBlock.Position = UDim2.new(0.510887742, 0, 0.470098436, 0)
RainbowBlock.Selectable = false
RainbowBlock.Size = UDim2.new(0, 88, 0, 32)
RainbowBlock.AutoButtonColor = false
RainbowBlock.Font = Enum.Font.Roboto
RainbowBlock.Text = "Rainbow"
RainbowBlock.TextColor3 = Color3.fromRGB(255, 255, 255)
RainbowBlock.TextSize = 14.000

GalaxyBlock.Name = "GalaxyBlock"
GalaxyBlock.Parent = Frame
GalaxyBlock.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
GalaxyBlock.BorderColor3 = Color3.fromRGB(0, 0, 0)
GalaxyBlock.BorderSizePixel = 0
GalaxyBlock.Position = UDim2.new(0.678391933, 0, 0.470098436, 0)
GalaxyBlock.Selectable = false
GalaxyBlock.Size = UDim2.new(0, 88, 0, 32)
GalaxyBlock.AutoButtonColor = false
GalaxyBlock.Font = Enum.Font.Roboto
GalaxyBlock.Text = "Galaxy"
GalaxyBlock.TextColor3 = Color3.fromRGB(255, 255, 255)
GalaxyBlock.TextSize = 14.000

TextLabel_2.Parent = Frame
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1.000
TextLabel_2.BorderSizePixel = 0
TextLabel_2.Position = UDim2.new(0, 0, 0.800000012, 0)
TextLabel_2.Size = UDim2.new(0, 134, 0, 39)
TextLabel_2.Font = Enum.Font.Gotham
TextLabel_2.Text = "Press [ to toggle UI"
TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.TextSize = 12.000

Frame_4.Parent = Frame
Frame_4.BackgroundColor3 = Color3.fromRGB(125, 82, 140)
Frame_4.BorderSizePixel = 0
Frame_4.Position = UDim2.new(0.403685182, 0, 0.670312822, 0)
Frame_4.Size = UDim2.new(0, 114, 0, 57)

open_box.Name = "open_box"
open_box.Parent = Frame_4
open_box.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
open_box.BorderSizePixel = 0
open_box.Position = UDim2.new(0.0766552091, 0, 0.443184912, 0)
open_box.Size = UDim2.new(0, 96, 0, 28)
open_box.Font = Enum.Font.SourceSans
open_box.Text = "1"
open_box.TextColor3 = Color3.fromRGB(255, 255, 255)
open_box.TextSize = 14.000

TextLabel_3.Parent = Frame_4
TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.BackgroundTransparency = 1.000
TextLabel_3.BorderSizePixel = 0
TextLabel_3.Position = UDim2.new(-0.867407143, 0, -0.239946008, 0)
TextLabel_3.Size = UDim2.new(0, 313, 0, 50)
TextLabel_3.Font = Enum.Font.Gotham
TextLabel_3.Text = "Enter Amount"
TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.TextSize = 11.000

TextLabel_4.Parent = Frame
TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_4.BackgroundTransparency = 1.000
TextLabel_4.BorderSizePixel = 0
TextLabel_4.Position = UDim2.new(0.767169178, 0, 0.800000012, 0)
TextLabel_4.Size = UDim2.new(0, 134, 0, 39)
TextLabel_4.Font = Enum.Font.Gotham
TextLabel_4.Text = "Void blocks are not effected by the amount"
TextLabel_4.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_4.TextSize = 12.000
TextLabel_4.TextWrapped = true

-- Scripts:

local function QJKU_fake_script() -- LuckyBlock_2.LocalScript 
	local script = Instance.new('LocalScript', LuckyBlock_2)

	LuckyBlock_2.MouseButton1Click:connect(function()
		for i=1, open_box.Text do --This number means that you'll get 100 gears (you can change this)
			game.ReplicatedStorage.SpawnLuckyBlock:FireServer()
		end
	end)
end
coroutine.wrap(QJKU_fake_script)()
local function DVNUM_fake_script() -- SuperBlock.LocalScript 
	local script = Instance.new('LocalScript', SuperBlock)

	SuperBlock.MouseButton1Click:connect(function()
		for i=1, open_box.Text do --This number means that you'll get 100 gears (you can change this)
			game.ReplicatedStorage.SpawnSuperBlock:FireServer()
		end
	end)
end
coroutine.wrap(DVNUM_fake_script)()
local function ZFQQSRD_fake_script() -- VoidBlock.LocalScript 
	local script = Instance.new('LocalScript', VoidBlock)

	VoidBlock.MouseButton1Click:connect(function()
		game:GetService("ReplicatedStorage").SpawnGalaxyBlock:FireServer()
		game:GetService("ReplicatedStorage").SpawnRainbowBlock:FireServer()
		game:GetService("ReplicatedStorage").SpawnGalaxyBlock:FireServer()
		game:GetService("ReplicatedStorage").SpawnRainbowBlock:FireServer()
		game:GetService("ReplicatedStorage").SpawnGalaxyBlock:FireServer()

	end)
end
coroutine.wrap(ZFQQSRD_fake_script)()
local function LRCNQD_fake_script() -- DiamondBlock.LocalScript 
	local script = Instance.new('LocalScript', DiamondBlock)

	DiamondBlock.MouseButton1Click:connect(function()
		for i=1, open_box.Text do --This number means that you'll get 100 gears (you can change this)
			game.ReplicatedStorage.SpawnDiamondBlock:FireServer()
		end
	end)
end
coroutine.wrap(LRCNQD_fake_script)()
local function TAJTLI_fake_script() -- RainbowBlock.LocalScript 
	local script = Instance.new('LocalScript', RainbowBlock)

	RainbowBlock.MouseButton1Click:connect(function()
		for i=1, open_box.Text do --This number means that you'll get 100 gears (you can change this)
			game.ReplicatedStorage.SpawnRainbowBlock:FireServer()
		end
	end)
end
coroutine.wrap(TAJTLI_fake_script)()
local function XRLDC_fake_script() -- GalaxyBlock.LocalScript 
	local script = Instance.new('LocalScript', GalaxyBlock)

	GalaxyBlock.MouseButton1Click:connect(function()
		for i=1, open_box.Text do --This number means that you'll get 100 gears (you can change this)
			game.ReplicatedStorage.SpawnGalaxyBlock:FireServer()
		end
	end)
end
coroutine.wrap(XRLDC_fake_script)()
local function AJEG_fake_script() -- Frame.LocalScript 
	local script = Instance.new('LocalScript', Frame)

	local UserInputService = game:GetService("UserInputService")
	
	local gui = script.Parent
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = gui:TweenPosition(UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y), 'Out', 'Linear', 0.1, true); -- drag speed
	end
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
	
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end
coroutine.wrap(AJEG_fake_script)()
local function SHVHOU_fake_script() -- Frame.LocalScript 
	local script = Instance.new('LocalScript', Frame)

	local frame = script.Parent -- path to the frame
	local mouse = game:GetService('Players').LocalPlayer:GetMouse(); -- we need the mouse object, which also has the keyboard
	
	mouse.KeyDown:connect(function(key) -- whenever a key is pushed down
		key = key:lower() -- i do this in all my key events, though i don't remember why
		if key == '[' then -- if key pressed is h
			frame.Visible = not frame.Visible -- flip between visible/invisible
		end
	end)
end
coroutine.wrap(SHVHOU_fake_script)()
