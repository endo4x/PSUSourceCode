--[[
	id: Jx_parreFL3I-Z8Tgq2tI
	name: Calculator
	description: My Calculator Script
	time1: 2021-05-05 23:12:57.313581+00
	time2: 2021-05-05 23:12:57.313581+00
	uploader: W8FWkprIhNQI7YQ7QPOCyvO4IKY4ZDXoHwppQrFA
	uploadersession: kwQzQ1-KWp1i1xlgg3opWMxfNCbkD1
	flag: f
--]]

--[[
strings-override
Lol don't take a peak at my script
Not cool bro, trying to skid?
Yo why are u spying on my script
]]
-- Gui to Lua
-- Version: 3.2

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("ImageLabel")
local Frame_2 = Instance.new("Frame")
local Frame_3 = Instance.new("ImageLabel")
local TextLabel = Instance.new("TextLabel")
local TextLabel_2 = Instance.new("TextLabel")
local Number1 = Instance.new("TextBox")
local UICorner = Instance.new("UICorner")
local Typeof = Instance.new("TextButton")
local Number2 = Instance.new("TextBox")
local UICorner_2 = Instance.new("UICorner")
local TextLabel_3 = Instance.new("TextLabel")
local TextLabel_4 = Instance.new("TextLabel")
local SolveButton = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local Answer = Instance.new("TextLabel")

--Properties:

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Name = "Frame"
Frame.Parent = ScreenGui
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BackgroundTransparency = 1.000
Frame.Position = UDim2.new(0.512928724, 0, 0.489968359, 0)
Frame.Size = UDim2.new(0, 270, 0, 388)
Frame.Image = "rbxassetid://3570695787"
Frame.ImageColor3 = Color3.fromRGB(202, 95, 95)
Frame.ScaleType = Enum.ScaleType.Slice
Frame.SliceCenter = Rect.new(100, 100, 100, 100)
Frame.SliceScale = 0.120

Frame_2.Parent = Frame
Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
Frame_2.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
Frame_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(0.499000162, 0, 0.082422711, 0)
Frame_2.Size = UDim2.new(0, 270, 0, 11)

Frame_3.Name = "Frame"
Frame_3.Parent = Frame
Frame_3.AnchorPoint = Vector2.new(0.5, 0.5)
Frame_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame_3.BackgroundTransparency = 1.000
Frame_3.BorderColor3 = Color3.fromRGB(27, 42, 53)
Frame_3.Position = UDim2.new(0.499000013, 0, 0.0444226786, 0)
Frame_3.Size = UDim2.new(0, 270, 0, 40)
Frame_3.Image = "rbxassetid://3570695787"
Frame_3.ImageColor3 = Color3.fromRGB(79, 79, 79)
Frame_3.ScaleType = Enum.ScaleType.Slice
Frame_3.SliceCenter = Rect.new(100, 100, 100, 100)
Frame_3.SliceScale = 0.120

TextLabel.Parent = Frame_3
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Size = UDim2.new(0, 270, 0, 40)
TextLabel.Font = Enum.Font.GothamBlack
TextLabel.Text = "Calculator"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

TextLabel_2.Parent = Frame_3
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1.000
TextLabel_2.Position = UDim2.new(0.0666666627, 0, 2.27499986, 0)
TextLabel_2.Size = UDim2.new(0, 234, 0, 40)
TextLabel_2.Font = Enum.Font.GothamBlack
TextLabel_2.Text = "Made by AuthenticTimes"
TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.TextScaled = true
TextLabel_2.TextSize = 14.000
TextLabel_2.TextWrapped = true

Number1.Name = "Number1"
Number1.Parent = Frame
Number1.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
Number1.Position = UDim2.new(0.211111113, 0, 0.440721661, 0)
Number1.Size = UDim2.new(0, 44, 0, 44)
Number1.Font = Enum.Font.GothamBlack
Number1.Text = ""
Number1.TextColor3 = Color3.fromRGB(255, 255, 255)
Number1.TextScaled = true
Number1.TextSize = 14.000
Number1.TextWrapped = true

UICorner.Parent = Number1

Typeof.Name = "Typeof"
Typeof.Parent = Frame
Typeof.BackgroundColor3 = Color3.fromRGB(202, 95, 95)
Typeof.BorderSizePixel = 0
Typeof.Position = UDim2.new(0.400000244, 0, 0.425257742, 0)
Typeof.Size = UDim2.new(0, 53, 0, 50)
Typeof.Font = Enum.Font.SourceSans
Typeof.Text = "+"
Typeof.TextColor3 = Color3.fromRGB(255, 255, 255)
Typeof.TextScaled = true
Typeof.TextSize = 14.000
Typeof.TextWrapped = true

Number2.Name = "Number2"
Number2.Parent = Frame
Number2.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
Number2.Position = UDim2.new(0.618518531, 0, 0.440721661, 0)
Number2.Size = UDim2.new(0, 44, 0, 44)
Number2.Font = Enum.Font.GothamBlack
Number2.Text = ""
Number2.TextColor3 = Color3.fromRGB(255, 255, 255)
Number2.TextScaled = true
Number2.TextSize = 14.000
Number2.TextWrapped = true

UICorner_2.Parent = Number2

TextLabel_3.Parent = Frame
TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.BackgroundTransparency = 1.000
TextLabel_3.Position = UDim2.new(0, 0, 0.719072104, 0)
TextLabel_3.Size = UDim2.new(0, 270, 0, 33)
TextLabel_3.Font = Enum.Font.SourceSans
TextLabel_3.Text = "_________________________________________________________"
TextLabel_3.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_3.TextScaled = true
TextLabel_3.TextSize = 14.000
TextLabel_3.TextWrapped = true

TextLabel_4.Parent = Frame
TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_4.BackgroundTransparency = 1.000
TextLabel_4.Position = UDim2.new(0.125925928, 0, 0.677835107, 0)
TextLabel_4.Size = UDim2.new(0, 200, 0, 38)
TextLabel_4.Font = Enum.Font.GothamBlack
TextLabel_4.Text = "Answer"
TextLabel_4.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_4.TextScaled = true
TextLabel_4.TextSize = 14.000
TextLabel_4.TextWrapped = true

SolveButton.Name = "SolveButton"
SolveButton.Parent = Frame
SolveButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SolveButton.Position = UDim2.new(0.359259248, 0, 0.574742258, 0)
SolveButton.Size = UDim2.new(0, 73, 0, 27)
SolveButton.Font = Enum.Font.GothamBlack
SolveButton.Text = "Solve"
SolveButton.TextColor3 = Color3.fromRGB(0, 0, 0)
SolveButton.TextSize = 20.000
SolveButton.TextWrapped = true

UICorner_3.Parent = SolveButton

Answer.Name = "Answer"
Answer.Parent = Frame
Answer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Answer.BackgroundTransparency = 1.000
Answer.Position = UDim2.new(0.374074072, 0, 0.80412364, 0)
Answer.Size = UDim2.new(0, 67, 0, 50)
Answer.Font = Enum.Font.SourceSans
Answer.Text = "0"
Answer.TextColor3 = Color3.fromRGB(255, 255, 255)
Answer.TextScaled = true
Answer.TextSize = 14.000
Answer.TextWrapped = true

-- Scripts:

local function FJOSCS_fake_script() -- Frame.Dragify 
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
coroutine.wrap(FJOSCS_fake_script)()
local function JVXND_fake_script() -- Typeof.LocalScript 
	local script = Instance.new('LocalScript', Typeof)

	function onClicked()
		if script.Parent.Text == "+" then
			script.Parent.Text = "-"
		elseif script.Parent.Text == "-" then
			script.Parent.Text = "x"
		elseif script.Parent.Text == "x" then
			script.Parent.Text = "/"
		elseif script.Parent.Text == "/" then
			script.Parent.Text = "+"
		end
	end
	script.Parent.MouseButton1Down:connect(onClicked)
	
end
coroutine.wrap(JVXND_fake_script)()
local function MTTPGWZ_fake_script() -- Frame.LocalScript 
	local script = Instance.new('LocalScript', Frame)

	local Num1 = script.Parent.Number1
	local Num2 = script.Parent.Number2
	local typeOf = script.Parent.Typeof
	local answer = 0
	local answerBox = script.Parent.Answer
	function onClicked()
		if typeOf.Text == "+" then
			answer = Num1.Text + Num2.Text
			answerBox.Text = answer
		elseif typeOf.Text == "-" then
			answer = Num1.Text - Num2.Text
			answerBox.Text = answer
		elseif typeOf.Text == "x" then
			answer = Num1.Text * Num2.Text
			answerBox.Text = answer
		elseif typeOf.Text == "/" then
			answer = Num1.Text / Num2.Text
			answerBox.Text = answer
		end
	end
	script.Parent.SolveButton.MouseButton1Down:connect(onClicked)
	
end
coroutine.wrap(MTTPGWZ_fake_script)()
