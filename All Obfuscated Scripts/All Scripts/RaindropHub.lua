--[[
	id: pkuhPS2hM4uglDEB7tGc-
	name: Raindrop Hub
	description: My Best Hub Yet!
	time1: 2021-04-25 20:05:32.671171+00
	time2: 2021-04-25 20:05:32.671172+00
	uploader: W8FWkprIhNQI7YQ7QPOCyvO4IKY4ZDXoHwppQrFA
	uploadersession: kwQzQ1-KWp1i1xlgg3opWMxfNCbkD1
	flag: f
--]]

--[[
strings-override
Look who it is, a skid looking at my Raindrop Hub source code!
Haha skid looking at my script go BRR
Raindrop was made by AuthenticTimes not you stop skidding lol
If ur not a skid why are u here?
]]
-- Gui to Lua
-- Version: 3.2

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("ImageLabel")
local TitleFrame = Instance.new("ImageLabel")
local Blocker = Instance.new("Frame")
local Minimize = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Close = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local MinimizeButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local RaindropHubText = Instance.new("TextLabel")
local ButtonsHolder = Instance.new("ImageLabel")
local ScriptsButton = Instance.new("ImageButton")
local HomeButton = Instance.new("ImageButton")
local SettingsButton = Instance.new("ImageButton")
local AboutButton = Instance.new("ImageButton")
local ButtonsBlocker = Instance.new("Frame")
local Pages = Instance.new("Frame")
local HomePage = Instance.new("Frame")
local RaindropGoodStatus = Instance.new("TextLabel")
local RaindropBadStatus = Instance.new("TextLabel")
local VersionNumber = Instance.new("TextLabel")
local Details = Instance.new("TextLabel")
local ReleaseDate = Instance.new("TextLabel")
local SettingsPage = Instance.new("Frame")
local Colors = Instance.new("TextLabel")
local Red = Instance.new("ImageLabel")
local Orange = Instance.new("ImageLabel")
local Yellow = Instance.new("ImageLabel")
local Green = Instance.new("ImageLabel")
local Blue = Instance.new("ImageLabel")
local Purple = Instance.new("ImageLabel")
local TextButton_Roundify_12px = Instance.new("ImageLabel")
local Regular = Instance.new("TextButton")
local RedClick = Instance.new("TextButton")
local OrangeClick = Instance.new("TextButton")
local YellowClick = Instance.new("TextButton")
local GreenClick = Instance.new("TextButton")
local BlueClick = Instance.new("TextButton")
local PurpleClick = Instance.new("TextButton")
local MoreSoon = Instance.new("TextLabel")
local AboutPage = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local TextLabel_2 = Instance.new("TextLabel")
local ScriptsPage = Instance.new("Frame")
local Page = Instance.new("TextLabel")
local TypeOfScripts = Instance.new("TextLabel")
local Page1 = Instance.new("Frame")
local InfiniteYield = Instance.new("ImageLabel")
local InfiniteYieldButton = Instance.new("TextButton")
local CMDX = Instance.new("ImageLabel")
local CMDXButton = Instance.new("TextButton")
local PageNumber = Instance.new("TextLabel")
local Right = Instance.new("TextButton")
local Left = Instance.new("TextButton")
local PageNumberBottom = Instance.new("TextLabel")
local Page2 = Instance.new("Frame")
local DomainHub = Instance.new("ImageLabel")
local DomainHubButton = Instance.new("TextButton")
local XXHub = Instance.new("ImageLabel")
local XXHubButton = Instance.new("TextButton")
local Page3 = Instance.new("Frame")
local TextLabel_3 = Instance.new("TextLabel")
local BlockerButtons = Instance.new("Frame")
local WhichNumber = Instance.new("NumberValue")

--Properties:

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Name = "Frame"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BackgroundTransparency = 1.000
Frame.Position = UDim2.new(0.324010551, 0, 0.453009516, 0)
Frame.Size = UDim2.new(0, 475, 0, 296)
Frame.Image = "rbxassetid://3570695787"
Frame.ImageColor3 = Color3.fromRGB(62, 96, 126)
Frame.ScaleType = Enum.ScaleType.Slice
Frame.SliceCenter = Rect.new(100, 100, 100, 100)
Frame.SliceScale = 0.120

TitleFrame.Name = "TitleFrame"
TitleFrame.Parent = Frame
TitleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TitleFrame.BackgroundTransparency = 1.000
TitleFrame.BorderSizePixel = 0
TitleFrame.Size = UDim2.new(0, 475, 0, 29)
TitleFrame.Image = "rbxassetid://3570695787"
TitleFrame.ImageColor3 = Color3.fromRGB(57, 57, 57)
TitleFrame.ScaleType = Enum.ScaleType.Slice
TitleFrame.SliceCenter = Rect.new(100, 100, 100, 100)
TitleFrame.SliceScale = 0.120

Blocker.Name = "Blocker"
Blocker.Parent = Frame
Blocker.BackgroundColor3 = Color3.fromRGB(57, 57, 57)
Blocker.BorderSizePixel = 0
Blocker.Position = UDim2.new(0, 0, 0.0608108193, 0)
Blocker.Size = UDim2.new(0, 475, 0, 11)

Minimize.Name = "Minimize"
Minimize.Parent = Frame
Minimize.BackgroundColor3 = Color3.fromRGB(204, 156, 34)
Minimize.Position = UDim2.new(0.902252674, 0, 0.0228537321, 0)
Minimize.Size = UDim2.new(0, 15, 0, 15)

UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = Minimize

Close.Name = "Close"
Close.Parent = Frame
Close.BackgroundColor3 = Color3.fromRGB(204, 55, 9)
Close.Position = UDim2.new(0.950673699, 0, 0.0228537321, 0)
Close.Size = UDim2.new(0, 15, 0, 15)

UICorner_2.CornerRadius = UDim.new(1, 0)
UICorner_2.Parent = Close

MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = Frame
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.BackgroundTransparency = 1.000
MinimizeButton.Position = UDim2.new(0.90315789, 0, 0.0228537489, 0)
MinimizeButton.Size = UDim2.new(0, 14, 0, 15)
MinimizeButton.Font = Enum.Font.SourceSans
MinimizeButton.Text = " "
MinimizeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
MinimizeButton.TextSize = 14.000

CloseButton.Name = "CloseButton"
CloseButton.Parent = Frame
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.BackgroundTransparency = 1.000
CloseButton.Position = UDim2.new(0.951578915, 0, 0.0228537489, 0)
CloseButton.Size = UDim2.new(0, 14, 0, 15)
CloseButton.Font = Enum.Font.SourceSans
CloseButton.Text = " "
CloseButton.TextColor3 = Color3.fromRGB(0, 0, 0)
CloseButton.TextSize = 14.000

RaindropHubText.Name = "RaindropHubText"
RaindropHubText.Parent = Frame
RaindropHubText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
RaindropHubText.BackgroundTransparency = 1.000
RaindropHubText.Position = UDim2.new(0.288421065, 0, 0, 0)
RaindropHubText.Size = UDim2.new(0, 200, 0, 29)
RaindropHubText.Font = Enum.Font.Highway
RaindropHubText.Text = "Raindrop Hub - V1"
RaindropHubText.TextColor3 = Color3.fromRGB(0, 0, 0)
RaindropHubText.TextSize = 25.000
RaindropHubText.TextWrapped = true

ButtonsHolder.Name = "ButtonsHolder"
ButtonsHolder.Parent = Frame
ButtonsHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ButtonsHolder.BackgroundTransparency = 1.000
ButtonsHolder.Position = UDim2.new(0, 0, 0.0608108118, 0)
ButtonsHolder.Size = UDim2.new(0, 49, 0, 278)
ButtonsHolder.Image = "rbxassetid://3570695787"
ButtonsHolder.ImageColor3 = Color3.fromRGB(57, 57, 57)
ButtonsHolder.ScaleType = Enum.ScaleType.Slice
ButtonsHolder.SliceCenter = Rect.new(100, 100, 100, 100)
ButtonsHolder.SliceScale = 0.120

ScriptsButton.Name = "ScriptsButton"
ScriptsButton.Parent = ButtonsHolder
ScriptsButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ScriptsButton.BackgroundTransparency = 1.000
ScriptsButton.Position = UDim2.new(0, 0, 0.279190153, 0)
ScriptsButton.Size = UDim2.new(0, 49, 0, 44)
ScriptsButton.Image = "rbxassetid://3370290202"

HomeButton.Name = "HomeButton"
HomeButton.Parent = ButtonsHolder
HomeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
HomeButton.BackgroundTransparency = 1.000
HomeButton.Position = UDim2.new(0, 0, 0.093379356, 0)
HomeButton.Size = UDim2.new(0, 49, 0, 44)
HomeButton.Image = "rbxassetid://1073830992"

SettingsButton.Name = "SettingsButton"
SettingsButton.Parent = ButtonsHolder
SettingsButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SettingsButton.BackgroundTransparency = 1.000
SettingsButton.Position = UDim2.new(0, 0, 0.437463582, 0)
SettingsButton.Size = UDim2.new(0, 49, 0, 49)
SettingsButton.Image = "rbxassetid://1602653070"

AboutButton.Name = "AboutButton"
AboutButton.Parent = ButtonsHolder
AboutButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AboutButton.BackgroundTransparency = 1.000
AboutButton.Position = UDim2.new(0, 0, 0.635305285, 0)
AboutButton.Size = UDim2.new(0, 49, 0, 49)
AboutButton.Image = "rbxassetid://238316630"

ButtonsBlocker.Name = "ButtonsBlocker"
ButtonsBlocker.Parent = Frame
ButtonsBlocker.BackgroundColor3 = Color3.fromRGB(57, 57, 57)
ButtonsBlocker.BorderSizePixel = 0
ButtonsBlocker.Position = UDim2.new(0.0842105299, 0, 0.922297299, 0)
ButtonsBlocker.Size = UDim2.new(0, 9, 0, 23)

Pages.Name = "Pages"
Pages.Parent = Frame
Pages.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Pages.BackgroundTransparency = 1.000
Pages.Position = UDim2.new(0.103157893, 0, 0.0979729742, 0)
Pages.Size = UDim2.new(0, 426, 0, 267)

HomePage.Name = "HomePage"
HomePage.Parent = Pages
HomePage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
HomePage.BackgroundTransparency = 1.000
HomePage.Position = UDim2.new(0.103157893, 0, 0.0979729742, 0)
HomePage.Size = UDim2.new(0, 426, 0, 267)

RaindropGoodStatus.Name = "RaindropGoodStatus"
RaindropGoodStatus.Parent = HomePage
RaindropGoodStatus.BackgroundColor3 = Color3.fromRGB(80, 216, 59)
RaindropGoodStatus.BorderSizePixel = 0
RaindropGoodStatus.Position = UDim2.new(-0.103286386, 0, -0.101123594, 0)
RaindropGoodStatus.Size = UDim2.new(0, 426, 0, 50)
RaindropGoodStatus.Font = Enum.Font.SourceSans
RaindropGoodStatus.Text = "Raindrop is currently updated and working."
RaindropGoodStatus.TextColor3 = Color3.fromRGB(255, 255, 255)
RaindropGoodStatus.TextScaled = true
RaindropGoodStatus.TextSize = 22.000
RaindropGoodStatus.TextWrapped = true

RaindropBadStatus.Name = "RaindropBadStatus"
RaindropBadStatus.Parent = HomePage
RaindropBadStatus.BackgroundColor3 = Color3.fromRGB(216, 63, 43)
RaindropBadStatus.BorderSizePixel = 0
RaindropBadStatus.Position = UDim2.new(-0.103286386, 0, -0.101123594, 0)
RaindropBadStatus.Size = UDim2.new(0, 426, 0, 50)
RaindropBadStatus.Visible = false
RaindropBadStatus.Font = Enum.Font.SourceSans
RaindropBadStatus.Text = "Raindrop isn't updated. Please wait for one."
RaindropBadStatus.TextColor3 = Color3.fromRGB(255, 255, 255)
RaindropBadStatus.TextScaled = true
RaindropBadStatus.TextSize = 22.000
RaindropBadStatus.TextWrapped = true

VersionNumber.Name = "VersionNumber"
VersionNumber.Parent = HomePage
VersionNumber.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
VersionNumber.BackgroundTransparency = 1.000
VersionNumber.Position = UDim2.new(0.161971837, 0, 0.0861423239, 0)
VersionNumber.Size = UDim2.new(0, 200, 0, 50)
VersionNumber.Font = Enum.Font.SourceSans
VersionNumber.Text = "Raindrop Hub V1"
VersionNumber.TextColor3 = Color3.fromRGB(0, 0, 0)
VersionNumber.TextScaled = true
VersionNumber.TextSize = 14.000
VersionNumber.TextWrapped = true

Details.Name = "Details"
Details.Parent = HomePage
Details.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Details.BackgroundTransparency = 1.000
Details.Position = UDim2.new(-0.105633803, 0, 0.314606726, 0)
Details.Size = UDim2.new(0, 426, 0, 157)
Details.Font = Enum.Font.SourceSans
Details.Text =
    "Hello, and welcome to Raindrop Hub V1! This is my new hub created with players and user friendliness in mind. This hub will be recieving updates every week, and will auto update as it runs on a loadstring. I have released this as a Script-Ware exclusive for easy use. Only 2 pages of scripts are released currently, but the next update in 2 days will bring more then 3 new pages. I hope you enjoy!"
Details.TextColor3 = Color3.fromRGB(0, 0, 0)
Details.TextScaled = true
Details.TextSize = 14.000
Details.TextWrapped = true

ReleaseDate.Name = "Release Date"
ReleaseDate.Parent = HomePage
ReleaseDate.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ReleaseDate.BackgroundTransparency = 1.000
ReleaseDate.Position = UDim2.new(-0.103286386, 0, 0.228464425, 0)
ReleaseDate.Size = UDim2.new(0, 426, 0, 23)
ReleaseDate.Font = Enum.Font.SourceSans
ReleaseDate.Text = "4/24/2021 | By AuthenticTimes"
ReleaseDate.TextColor3 = Color3.fromRGB(0, 0, 0)
ReleaseDate.TextScaled = true
ReleaseDate.TextSize = 14.000
ReleaseDate.TextWrapped = true

SettingsPage.Name = "SettingsPage"
SettingsPage.Parent = Pages
SettingsPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SettingsPage.BackgroundTransparency = 1.000
SettingsPage.Size = UDim2.new(0, 425, 0, 266)
SettingsPage.Visible = false

Colors.Name = "Colors"
Colors.Parent = SettingsPage
Colors.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Colors.BackgroundTransparency = 1.000
Colors.Position = UDim2.new(0.0329411998, 0, 0.0300751776, 0)
Colors.Size = UDim2.new(0, 403, 0, 50)
Colors.Font = Enum.Font.SourceSans
Colors.Text = "Colors"
Colors.TextColor3 = Color3.fromRGB(0, 0, 0)
Colors.TextScaled = true
Colors.TextSize = 14.000
Colors.TextWrapped = true

Red.Name = "Red"
Red.Parent = SettingsPage
Red.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Red.BackgroundTransparency = 1.000
Red.BorderSizePixel = 3
Red.Position = UDim2.new(0.17411764, 0, 0.255639106, 0)
Red.Size = UDim2.new(0, 38, 0, 40)
Red.Image = "rbxassetid://3570695787"
Red.ImageColor3 = Color3.fromRGB(255, 66, 69)
Red.ScaleType = Enum.ScaleType.Slice
Red.SliceCenter = Rect.new(100, 100, 100, 100)
Red.SliceScale = 0.120

Orange.Name = "Orange"
Orange.Parent = SettingsPage
Orange.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Orange.BackgroundTransparency = 1.000
Orange.Position = UDim2.new(0.28705883, 0, 0.255639106, 0)
Orange.Size = UDim2.new(0, 38, 0, 40)
Orange.Image = "rbxassetid://3570695787"
Orange.ImageColor3 = Color3.fromRGB(255, 128, 0)
Orange.ScaleType = Enum.ScaleType.Slice
Orange.SliceCenter = Rect.new(100, 100, 100, 100)
Orange.SliceScale = 0.120

Yellow.Name = "Yellow"
Yellow.Parent = SettingsPage
Yellow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Yellow.BackgroundTransparency = 1.000
Yellow.Position = UDim2.new(0.399999976, 0, 0.255639106, 0)
Yellow.Size = UDim2.new(0, 38, 0, 40)
Yellow.Image = "rbxassetid://3570695787"
Yellow.ImageColor3 = Color3.fromRGB(223, 189, 18)
Yellow.ScaleType = Enum.ScaleType.Slice
Yellow.SliceCenter = Rect.new(100, 100, 100, 100)
Yellow.SliceScale = 0.120

Green.Name = "Green"
Green.Parent = SettingsPage
Green.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Green.BackgroundTransparency = 1.000
Green.Position = UDim2.new(0.517647028, 0, 0.255639106, 0)
Green.Size = UDim2.new(0, 38, 0, 40)
Green.Image = "rbxassetid://3570695787"
Green.ImageColor3 = Color3.fromRGB(103, 194, 32)
Green.ScaleType = Enum.ScaleType.Slice
Green.SliceCenter = Rect.new(100, 100, 100, 100)
Green.SliceScale = 0.120

Blue.Name = "Blue"
Blue.Parent = SettingsPage
Blue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Blue.BackgroundTransparency = 1.000
Blue.Position = UDim2.new(0.630588233, 0, 0.255639106, 0)
Blue.Size = UDim2.new(0, 38, 0, 40)
Blue.Image = "rbxassetid://3570695787"
Blue.ImageColor3 = Color3.fromRGB(73, 155, 255)
Blue.ScaleType = Enum.ScaleType.Slice
Blue.SliceCenter = Rect.new(100, 100, 100, 100)
Blue.SliceScale = 0.120

Purple.Name = "Purple"
Purple.Parent = SettingsPage
Purple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Purple.BackgroundTransparency = 1.000
Purple.Position = UDim2.new(0.748235285, 0, 0.255639106, 0)
Purple.Size = UDim2.new(0, 38, 0, 40)
Purple.Image = "rbxassetid://3570695787"
Purple.ImageColor3 = Color3.fromRGB(162, 55, 255)
Purple.ScaleType = Enum.ScaleType.Slice
Purple.SliceCenter = Rect.new(100, 100, 100, 100)
Purple.SliceScale = 0.120

TextButton_Roundify_12px.Name = "TextButton_Roundify_12px"
TextButton_Roundify_12px.Parent = SettingsPage
TextButton_Roundify_12px.Active = true
TextButton_Roundify_12px.AnchorPoint = Vector2.new(0.5, 0.5)
TextButton_Roundify_12px.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton_Roundify_12px.BackgroundTransparency = 1.000
TextButton_Roundify_12px.Position = UDim2.new(0.505882382, 0, 0.505639076, 0)
TextButton_Roundify_12px.Selectable = true
TextButton_Roundify_12px.Size = UDim2.new(0.28705883, 0, 0.116541356, 0)
TextButton_Roundify_12px.Image = "rbxassetid://3570695787"
TextButton_Roundify_12px.ImageColor3 = Color3.fromRGB(93, 146, 191)
TextButton_Roundify_12px.ScaleType = Enum.ScaleType.Slice
TextButton_Roundify_12px.SliceCenter = Rect.new(100, 100, 100, 100)
TextButton_Roundify_12px.SliceScale = 0.120

Regular.Name = "Regular"
Regular.Parent = SettingsPage
Regular.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Regular.BackgroundTransparency = 1.000
Regular.Position = UDim2.new(0.362352937, 0, 0.447368413, 0)
Regular.Size = UDim2.new(0, 122, 0, 31)
Regular.Font = Enum.Font.SourceSans
Regular.Text = "Regular"
Regular.TextColor3 = Color3.fromRGB(0, 0, 0)
Regular.TextScaled = true
Regular.TextSize = 14.000
Regular.TextWrapped = true

RedClick.Name = "RedClick"
RedClick.Parent = SettingsPage
RedClick.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
RedClick.BackgroundTransparency = 1.000
RedClick.Position = UDim2.new(0.17411764, 0, 0.255639106, 0)
RedClick.Size = UDim2.new(0, 38, 0, 40)
RedClick.Font = Enum.Font.SourceSans
RedClick.Text = " "
RedClick.TextColor3 = Color3.fromRGB(0, 0, 0)
RedClick.TextSize = 14.000

OrangeClick.Name = "OrangeClick"
OrangeClick.Parent = SettingsPage
OrangeClick.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
OrangeClick.BackgroundTransparency = 1.000
OrangeClick.Position = UDim2.new(0.28705883, 0, 0.255639106, 0)
OrangeClick.Size = UDim2.new(0, 38, 0, 40)
OrangeClick.Font = Enum.Font.SourceSans
OrangeClick.Text = " "
OrangeClick.TextColor3 = Color3.fromRGB(0, 0, 0)
OrangeClick.TextSize = 14.000

YellowClick.Name = "YellowClick"
YellowClick.Parent = SettingsPage
YellowClick.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YellowClick.BackgroundTransparency = 1.000
YellowClick.Position = UDim2.new(0.397647083, 0, 0.255639106, 0)
YellowClick.Size = UDim2.new(0, 38, 0, 40)
YellowClick.Font = Enum.Font.SourceSans
YellowClick.Text = " "
YellowClick.TextColor3 = Color3.fromRGB(0, 0, 0)
YellowClick.TextSize = 14.000

GreenClick.Name = "GreenClick"
GreenClick.Parent = SettingsPage
GreenClick.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
GreenClick.BackgroundTransparency = 1.000
GreenClick.Position = UDim2.new(0.517647088, 0, 0.255639106, 0)
GreenClick.Size = UDim2.new(0, 38, 0, 40)
GreenClick.Font = Enum.Font.SourceSans
GreenClick.Text = " "
GreenClick.TextColor3 = Color3.fromRGB(0, 0, 0)
GreenClick.TextSize = 14.000

BlueClick.Name = "BlueClick"
BlueClick.Parent = SettingsPage
BlueClick.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BlueClick.BackgroundTransparency = 1.000
BlueClick.Position = UDim2.new(0.630588293, 0, 0.255639106, 0)
BlueClick.Size = UDim2.new(0, 38, 0, 40)
BlueClick.Font = Enum.Font.SourceSans
BlueClick.Text = " "
BlueClick.TextColor3 = Color3.fromRGB(0, 0, 0)
BlueClick.TextSize = 14.000

PurpleClick.Name = "PurpleClick"
PurpleClick.Parent = SettingsPage
PurpleClick.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PurpleClick.BackgroundTransparency = 1.000
PurpleClick.Position = UDim2.new(0.748235345, 0, 0.255639106, 0)
PurpleClick.Size = UDim2.new(0, 38, 0, 40)
PurpleClick.Font = Enum.Font.SourceSans
PurpleClick.Text = " "
PurpleClick.TextColor3 = Color3.fromRGB(0, 0, 0)
PurpleClick.TextSize = 14.000

MoreSoon.Name = "MoreSoon"
MoreSoon.Parent = SettingsPage
MoreSoon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MoreSoon.BackgroundTransparency = 1.000
MoreSoon.Position = UDim2.new(0.0329411998, 0, 0.661654115, 0)
MoreSoon.Size = UDim2.new(0, 403, 0, 50)
MoreSoon.Font = Enum.Font.SourceSans
MoreSoon.Text = "More settings coming soon."
MoreSoon.TextColor3 = Color3.fromRGB(0, 0, 0)
MoreSoon.TextScaled = true
MoreSoon.TextSize = 14.000
MoreSoon.TextWrapped = true

AboutPage.Name = "AboutPage"
AboutPage.Parent = Pages
AboutPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AboutPage.BackgroundTransparency = 1.000
AboutPage.Size = UDim2.new(0, 425, 0, 266)
AboutPage.Visible = false

TextLabel.Parent = AboutPage
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Size = UDim2.new(0, 426, 0, 52)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "About"
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

TextLabel_2.Parent = AboutPage
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1.000
TextLabel_2.Position = UDim2.new(0.134117648, 0, 0.195488721, 0)
TextLabel_2.Size = UDim2.new(0, 312, 0, 171)
TextLabel_2.Font = Enum.Font.SourceSans
TextLabel_2.Text =
    "This GUI is created and designed by AuthenticTimes for Script-Ware. None of the scripts in the scripts section are owned by me. This is a script hub made to hold useful scripts. All of the scripts fully belong to the owners and I will not take any credit for them."
TextLabel_2.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_2.TextScaled = true
TextLabel_2.TextSize = 14.000
TextLabel_2.TextWrapped = true

ScriptsPage.Name = "ScriptsPage"
ScriptsPage.Parent = Pages
ScriptsPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ScriptsPage.BackgroundTransparency = 1.000
ScriptsPage.Size = UDim2.new(0, 425, 0, 266)
ScriptsPage.Visible = false

Page.Name = "Page"
Page.Parent = ScriptsPage
Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Page.BackgroundTransparency = 1.000
Page.Size = UDim2.new(0, 403, 0, 44)
Page.Font = Enum.Font.SourceSans
Page.Text = "Page"
Page.TextColor3 = Color3.fromRGB(0, 0, 0)
Page.TextScaled = true
Page.TextSize = 14.000
Page.TextWrapped = true

TypeOfScripts.Name = "TypeOfScripts"
TypeOfScripts.Parent = ScriptsPage
TypeOfScripts.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TypeOfScripts.BackgroundTransparency = 1.000
TypeOfScripts.Position = UDim2.new(0, 0, 0.124060147, 0)
TypeOfScripts.Size = UDim2.new(0, 426, 0, 44)
TypeOfScripts.Font = Enum.Font.SourceSans
TypeOfScripts.Text = "Admin Scripts"
TypeOfScripts.TextColor3 = Color3.fromRGB(0, 0, 0)
TypeOfScripts.TextScaled = true
TypeOfScripts.TextSize = 14.000
TypeOfScripts.TextWrapped = true

WhichNumber.Name = "WhichNumber"
WhichNumber.Parent = ScriptsPage
WhichNumber.Value = 1

Page1.Name = "Page1"
Page1.Parent = ScriptsPage
Page1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Page1.BackgroundTransparency = 1.000
Page1.Size = UDim2.new(0, 426, 0, 267)

InfiniteYield.Name = "InfiniteYield"
InfiniteYield.Parent = Page1
InfiniteYield.AnchorPoint = Vector2.new(0.5, 0.5)
InfiniteYield.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
InfiniteYield.BackgroundTransparency = 1.000
InfiniteYield.Position = UDim2.new(0.271999866, 0, 0.478751987, 0)
InfiniteYield.Size = UDim2.new(0.368999988, 0, 0.238112599, 0)
InfiniteYield.Image = "rbxassetid://3570695787"
InfiniteYield.ScaleType = Enum.ScaleType.Slice
InfiniteYield.SliceCenter = Rect.new(100, 100, 100, 100)
InfiniteYield.SliceScale = 0.120

InfiniteYieldButton.Name = "InfiniteYieldButton"
InfiniteYieldButton.Parent = InfiniteYield
InfiniteYieldButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
InfiniteYieldButton.BackgroundTransparency = 1.000
InfiniteYieldButton.BorderSizePixel = 0
InfiniteYieldButton.Position = UDim2.new(0.0176845193, 0, 0.046365913, 0)
InfiniteYieldButton.Size = UDim2.new(0, 150, 0, 56)
InfiniteYieldButton.Font = Enum.Font.SourceSans
InfiniteYieldButton.Text = "Infinite Yield"
InfiniteYieldButton.TextColor3 = Color3.fromRGB(0, 0, 0)
InfiniteYieldButton.TextScaled = true
InfiniteYieldButton.TextSize = 14.000
InfiniteYieldButton.TextWrapped = true

CMDX.Name = "CMD-X"
CMDX.Parent = Page1
CMDX.AnchorPoint = Vector2.new(0.5, 0.5)
CMDX.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CMDX.BackgroundTransparency = 1.000
CMDX.Position = UDim2.new(0.728000104, 0, 0.478751987, 0)
CMDX.Size = UDim2.new(0.369000107, 0, 0.238112777, 0)
CMDX.Image = "rbxassetid://3570695787"
CMDX.ScaleType = Enum.ScaleType.Slice
CMDX.SliceCenter = Rect.new(100, 100, 100, 100)
CMDX.SliceScale = 0.120

CMDXButton.Name = "CMDXButton"
CMDXButton.Parent = CMDX
CMDXButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CMDXButton.BackgroundTransparency = 1.000
CMDXButton.BorderSizePixel = 0
CMDXButton.Position = UDim2.new(0.0176845193, 0, 0.046365913, 0)
CMDXButton.Size = UDim2.new(0, 150, 0, 56)
CMDXButton.Font = Enum.Font.SourceSans
CMDXButton.Text = "CMD-X"
CMDXButton.TextColor3 = Color3.fromRGB(0, 0, 0)
CMDXButton.TextScaled = true
CMDXButton.TextSize = 14.000
CMDXButton.TextWrapped = true

PageNumber.Name = "PageNumber"
PageNumber.Parent = ScriptsPage
PageNumber.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PageNumber.BackgroundTransparency = 1.000
PageNumber.Position = UDim2.new(0.237647057, 0, 0, 0)
PageNumber.Size = UDim2.new(0, 309, 0, 44)
PageNumber.Font = Enum.Font.SourceSans
PageNumber.Text = "1"
PageNumber.TextColor3 = Color3.fromRGB(0, 0, 0)
PageNumber.TextScaled = true
PageNumber.TextSize = 14.000
PageNumber.TextWrapped = true

Right.Name = "Right"
Right.Parent = ScriptsPage
Right.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Right.BackgroundTransparency = 1.000
Right.Position = UDim2.new(0.543529391, 0, 0.909774423, 0)
Right.Size = UDim2.new(0, 24, 0, 27)
Right.Font = Enum.Font.SourceSans
Right.Text = ">"
Right.TextColor3 = Color3.fromRGB(0, 0, 0)
Right.TextSize = 30.000

Left.Name = "Left"
Left.Parent = ScriptsPage
Left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Left.BackgroundTransparency = 1.000
Left.Position = UDim2.new(0.399999976, 0, 0.917293251, 0)
Left.Size = UDim2.new(0, 20, 0, 23)
Left.Font = Enum.Font.SourceSans
Left.Text = "<"
Left.TextColor3 = Color3.fromRGB(0, 0, 0)
Left.TextSize = 30.000

PageNumberBottom.Name = "PageNumberBottom"
PageNumberBottom.Parent = ScriptsPage
PageNumberBottom.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PageNumberBottom.BackgroundTransparency = 1.000
PageNumberBottom.Position = UDim2.new(0.136470586, 0, 0.845864654, 0)
PageNumberBottom.Size = UDim2.new(0, 309, 0, 50)
PageNumberBottom.Font = Enum.Font.SourceSans
PageNumberBottom.Text = "1"
PageNumberBottom.TextColor3 = Color3.fromRGB(0, 0, 0)
PageNumberBottom.TextScaled = true
PageNumberBottom.TextSize = 14.000
PageNumberBottom.TextWrapped = true

Page2.Name = "Page2"
Page2.Parent = ScriptsPage
Page2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Page2.BackgroundTransparency = 1.000
Page2.Size = UDim2.new(0, 426, 0, 267)
Page2.Visible = false

DomainHub.Name = "DomainHub"
DomainHub.Parent = Page2
DomainHub.AnchorPoint = Vector2.new(0.5, 0.5)
DomainHub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
DomainHub.BackgroundTransparency = 1.000
DomainHub.Position = UDim2.new(0.271999866, 0, 0.478751987, 0)
DomainHub.Size = UDim2.new(0.368999988, 0, 0.238112599, 0)
DomainHub.Image = "rbxassetid://3570695787"
DomainHub.ScaleType = Enum.ScaleType.Slice
DomainHub.SliceCenter = Rect.new(100, 100, 100, 100)
DomainHub.SliceScale = 0.120

DomainHubButton.Name = "DomainHubButton"
DomainHubButton.Parent = DomainHub
DomainHubButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
DomainHubButton.BackgroundTransparency = 1.000
DomainHubButton.BorderSizePixel = 0
DomainHubButton.Position = UDim2.new(0.0176845193, 0, 0.046365913, 0)
DomainHubButton.Size = UDim2.new(0, 150, 0, 56)
DomainHubButton.Font = Enum.Font.SourceSans
DomainHubButton.Text = "Domain Hub"
DomainHubButton.TextColor3 = Color3.fromRGB(0, 0, 0)
DomainHubButton.TextScaled = true
DomainHubButton.TextSize = 14.000
DomainHubButton.TextWrapped = true

XXHub.Name = "XXHub"
XXHub.Parent = Page2
XXHub.AnchorPoint = Vector2.new(0.5, 0.5)
XXHub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
XXHub.BackgroundTransparency = 1.000
XXHub.Position = UDim2.new(0.728000104, 0, 0.478751987, 0)
XXHub.Size = UDim2.new(0.369000107, 0, 0.238112777, 0)
XXHub.Image = "rbxassetid://3570695787"
XXHub.ScaleType = Enum.ScaleType.Slice
XXHub.SliceCenter = Rect.new(100, 100, 100, 100)
XXHub.SliceScale = 0.120

XXHubButton.Name = "XXHubButton"
XXHubButton.Parent = XXHub
XXHubButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
XXHubButton.BackgroundTransparency = 1.000
XXHubButton.BorderSizePixel = 0
XXHubButton.Position = UDim2.new(0.0176845193, 0, 0.046365913, 0)
XXHubButton.Size = UDim2.new(0, 150, 0, 56)
XXHubButton.Font = Enum.Font.SourceSans
XXHubButton.Text = "XXHub"
XXHubButton.TextColor3 = Color3.fromRGB(0, 0, 0)
XXHubButton.TextScaled = true
XXHubButton.TextSize = 14.000
XXHubButton.TextWrapped = true

Page3.Name = "Page3"
Page3.Parent = ScriptsPage
Page3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Page3.BackgroundTransparency = 1.000
Page3.Size = UDim2.new(0, 426, 0, 267)
Page3.Visible = false

TextLabel_3.Parent = Page3
TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.BackgroundTransparency = 1.000
TextLabel_3.Position = UDim2.new(0, 0, 0.3670412, 0)
TextLabel_3.Size = UDim2.new(0, 426, 0, 80)
TextLabel_3.Font = Enum.Font.SourceSans
TextLabel_3.Text = "Way more scripts coming Tuesday this week!"
TextLabel_3.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_3.TextScaled = true
TextLabel_3.TextSize = 14.000
TextLabel_3.TextWrapped = true

BlockerButtons.Name = "BlockerButtons"
BlockerButtons.Parent = Frame
BlockerButtons.BackgroundColor3 = Color3.fromRGB(57, 57, 57)
BlockerButtons.BorderSizePixel = 0
BlockerButtons.Position = UDim2.new(0, 0, 0.0608108118, 0)
BlockerButtons.Size = UDim2.new(0, 49, 0, 11)

-- Scripts:

local function VLTSFZ_fake_script() -- MinimizeButton.MinimizeScript
    local script = Instance.new("LocalScript", MinimizeButton)

    script.Parent.MouseButton1Click:connect(
        function()
            if script.Parent.Parent.ImageTransparency == 0 then
                script.Parent.Parent.ImageTransparency = 1
                script.Parent.Parent.ButtonsHolder.Visible = false
                script.Parent.Parent.ButtonsBlocker.Visible = false
                script.Parent.Parent.Pages.Visible = false
            elseif script.Parent.Parent.ImageTransparency == 1 then
                script.Parent.Parent.ImageTransparency = 0
                script.Parent.Parent.ButtonsHolder.Visible = true
                script.Parent.Parent.ButtonsBlocker.Visible = true
                script.Parent.Parent.Pages.Visible = true
            end
        end
    )

    --                                                               ^
    --]]	Change "Credit" to the name of the frame                 ^
end
coroutine.wrap(VLTSFZ_fake_script)()
local function NHKWYT_fake_script() -- CloseButton.CloseScript
    local script = Instance.new("LocalScript", CloseButton)

    local frame = script.Parent.Parent.Parent.Frame

    script.Parent.MouseButton1Click:Connect(
        function()
            frame:TweenPosition(UDim2.new(0.442, 0, -1, 0), "Out", "Quad", "1")
            wait(1.5)
            script.Parent.Parent.Parent:Remove()
        end
    )
end
coroutine.wrap(NHKWYT_fake_script)()
local function NPFU_fake_script() -- Frame.Dragify
    local script = Instance.new("LocalScript", Frame)

    local UIS = game:GetService("UserInputService")
    function dragify(Frame)
        dragToggle = nil
        local dragSpeed = 0
        dragInput = nil
        dragStart = nil
        local dragPos = nil
        function updateInput(input)
            local Delta = input.Position - dragStart
            local Position =
                UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
            game:GetService("TweenService"):Create(Frame, TweenInfo.new(0.25), {Position = Position}):Play()
        end
        Frame.InputBegan:Connect(
            function(input)
                if
                    (input.UserInputType == Enum.UserInputType.MouseButton1 or
                        input.UserInputType == Enum.UserInputType.Touch) and
                        UIS:GetFocusedTextBox() == nil
                 then
                    dragToggle = true
                    dragStart = input.Position
                    startPos = Frame.Position
                    input.Changed:Connect(
                        function()
                            if input.UserInputState == Enum.UserInputState.End then
                                dragToggle = false
                            end
                        end
                    )
                end
            end
        )
        Frame.InputChanged:Connect(
            function(input)
                if
                    input.UserInputType == Enum.UserInputType.MouseMovement or
                        input.UserInputType == Enum.UserInputType.Touch
                 then
                    dragInput = input
                end
            end
        )
        game:GetService("UserInputService").InputChanged:Connect(
            function(input)
                if input == dragInput and dragToggle then
                    updateInput(input)
                end
            end
        )
    end

    dragify(script.Parent)
end
coroutine.wrap(NPFU_fake_script)()
local function OUEPYHC_fake_script() -- ScriptsButton.RotateScript
    local script = Instance.new("LocalScript", ScriptsButton)

    local Button = script.Parent

    function MouseEnter()
        Button.Rotation = -1
        wait(0.01)
        Button.Rotation = -2
        wait(0.01)
        Button.Rotation = -3
        wait(0.01)
        Button.Rotation = -4
        wait(0.01)
        Button.Rotation = -5
        wait(0.01)
        Button.Rotation = -6
    end

    function MouseLeave()
        Button.Rotation = -5
        wait(0.01)
        Button.Rotation = -4
        wait(0.01)
        Button.Rotation = -3
        wait(0.01)
        Button.Rotation = -2
        wait(0.01)
        Button.Rotation = -1
        wait(0.01)
        Button.Rotation = 0
    end

    Button.MouseEnter:connect(MouseEnter)
    Button.MouseLeave:connect(MouseLeave)
end
coroutine.wrap(OUEPYHC_fake_script)()
local function XBPV_fake_script() -- ScriptsButton.ScriptsClickScript
    local script = Instance.new("LocalScript", ScriptsButton)

    script.Parent.MouseButton1Click:connect(
        function()
            script.Parent.Parent.Parent.Pages.HomePage.Visible = false
            script.Parent.Parent.Parent.Pages.ScriptsPage.Visible = true
            script.Parent.Parent.Parent.Pages.SettingsPage.Visible = false
            script.Parent.Parent.Parent.Pages.AboutPage.Visible = false
        end
    )

    --                                                               ^
    --]]	Change "Credit" to the name of the frame                 ^
end
coroutine.wrap(XBPV_fake_script)()
local function VUCMLAO_fake_script() -- HomeButton.RotateScript
    local script = Instance.new("LocalScript", HomeButton)

    local Button = script.Parent

    function MouseEnter()
        Button.Rotation = -1
        wait(0.01)
        Button.Rotation = -2
        wait(0.01)
        Button.Rotation = -3
        wait(0.01)
        Button.Rotation = -4
        wait(0.01)
        Button.Rotation = -5
        wait(0.01)
        Button.Rotation = -6
    end

    function MouseLeave()
        Button.Rotation = -5
        wait(0.01)
        Button.Rotation = -4
        wait(0.01)
        Button.Rotation = -3
        wait(0.01)
        Button.Rotation = -2
        wait(0.01)
        Button.Rotation = -1
        wait(0.01)
        Button.Rotation = 0
    end

    Button.MouseEnter:connect(MouseEnter)
    Button.MouseLeave:connect(MouseLeave)
end
coroutine.wrap(VUCMLAO_fake_script)()
local function CHEDAXJ_fake_script() -- HomeButton.HomeClickScript
    local script = Instance.new("LocalScript", HomeButton)

    script.Parent.MouseButton1Click:connect(
        function()
            script.Parent.Parent.Parent.Pages.HomePage.Visible = true
            script.Parent.Parent.Parent.Pages.ScriptsPage.Visible = false
            script.Parent.Parent.Parent.Pages.SettingsPage.Visible = false
            script.Parent.Parent.Parent.Pages.AboutPage.Visible = false
        end
    )

    --                                                               ^
    --]]	Change "Credit" to the name of the frame                 ^
end
coroutine.wrap(CHEDAXJ_fake_script)()
local function IMUY_fake_script() -- SettingsButton.RotateScript
    local script = Instance.new("LocalScript", SettingsButton)

    local Button = script.Parent

    function MouseEnter()
        Button.Rotation = -1
        wait(0.01)
        Button.Rotation = -2
        wait(0.01)
        Button.Rotation = -3
        wait(0.01)
        Button.Rotation = -4
        wait(0.01)
        Button.Rotation = -5
        wait(0.01)
        Button.Rotation = -6
    end

    function MouseLeave()
        Button.Rotation = -5
        wait(0.01)
        Button.Rotation = -4
        wait(0.01)
        Button.Rotation = -3
        wait(0.01)
        Button.Rotation = -2
        wait(0.01)
        Button.Rotation = -1
        wait(0.01)
        Button.Rotation = 0
    end

    Button.MouseEnter:connect(MouseEnter)
    Button.MouseLeave:connect(MouseLeave)
end
coroutine.wrap(IMUY_fake_script)()
local function XVIL_fake_script() -- SettingsButton.SettingsClickScript
    local script = Instance.new("LocalScript", SettingsButton)

    script.Parent.MouseButton1Click:connect(
        function()
            script.Parent.Parent.Parent.Pages.HomePage.Visible = false
            script.Parent.Parent.Parent.Pages.ScriptsPage.Visible = false
            script.Parent.Parent.Parent.Pages.SettingsPage.Visible = true
            script.Parent.Parent.Parent.Pages.AboutPage.Visible = false
        end
    )

    --                                                               ^
    --]]	Change "Credit" to the name of the frame                 ^
end
coroutine.wrap(XVIL_fake_script)()
local function NLFX_fake_script() -- AboutButton.RotateScript
    local script = Instance.new("LocalScript", AboutButton)

    local Button = script.Parent

    function MouseEnter()
        Button.Rotation = -1
        wait(0.01)
        Button.Rotation = -2
        wait(0.01)
        Button.Rotation = -3
        wait(0.01)
        Button.Rotation = -4
        wait(0.01)
        Button.Rotation = -5
        wait(0.01)
        Button.Rotation = -6
    end

    function MouseLeave()
        Button.Rotation = -5
        wait(0.01)
        Button.Rotation = -4
        wait(0.01)
        Button.Rotation = -3
        wait(0.01)
        Button.Rotation = -2
        wait(0.01)
        Button.Rotation = -1
        wait(0.01)
        Button.Rotation = 0
    end

    Button.MouseEnter:connect(MouseEnter)
    Button.MouseLeave:connect(MouseLeave)
end
coroutine.wrap(NLFX_fake_script)()
local function HLXW_fake_script() -- AboutButton.SettingsClickScript
    local script = Instance.new("LocalScript", AboutButton)

    script.Parent.MouseButton1Click:connect(
        function()
            script.Parent.Parent.Parent.Pages.HomePage.Visible = false
            script.Parent.Parent.Parent.Pages.ScriptsPage.Visible = false
            script.Parent.Parent.Parent.Pages.SettingsPage.Visible = false
            script.Parent.Parent.Parent.Pages.AboutPage.Visible = true
        end
    )

    --                                                               ^
    --]]	Change "Credit" to the name of the frame                 ^
end
coroutine.wrap(HLXW_fake_script)()
local function RGUKBW_fake_script() -- Regular.ColorScript
    local script = Instance.new("LocalScript", Regular)

    script.Parent.MouseButton1Click:connect(
        function()
            script.Parent.Parent.Parent.Parent.ImageColor3 = Color3.fromRGB(62, 96, 126)
        end
    )

    --                                                               ^
    --]]	Change "Credit" to the name of the frame                 ^
end
coroutine.wrap(RGUKBW_fake_script)()
local function GEFMQEF_fake_script() -- RedClick.ColorScript
    local script = Instance.new("LocalScript", RedClick)

    script.Parent.MouseButton1Click:connect(
        function()
            script.Parent.Parent.Parent.Parent.ImageColor3 = Color3.fromRGB(255, 66, 69)
        end
    )

    --                                                               ^
    --]]	Change "Credit" to the name of the frame                 ^
end
coroutine.wrap(GEFMQEF_fake_script)()
local function YXQN_fake_script() -- OrangeClick.ColorScript
    local script = Instance.new("LocalScript", OrangeClick)

    script.Parent.MouseButton1Click:connect(
        function()
            script.Parent.Parent.Parent.Parent.ImageColor3 = Color3.fromRGB(255, 128, 0)
        end
    )

    --                                                               ^
    --]]	Change "Credit" to the name of the frame                 ^
end
coroutine.wrap(YXQN_fake_script)()
local function TKEXOCQ_fake_script() -- YellowClick.ColorScript
    local script = Instance.new("LocalScript", YellowClick)

    script.Parent.MouseButton1Click:connect(
        function()
            script.Parent.Parent.Parent.Parent.ImageColor3 = Color3.fromRGB(223, 189, 18)
        end
    )

    --                                                               ^
    --]]	Change "Credit" to the name of the frame                 ^
end
coroutine.wrap(TKEXOCQ_fake_script)()
local function AJCPKN_fake_script() -- GreenClick.ColorScript
    local script = Instance.new("LocalScript", GreenClick)

    script.Parent.MouseButton1Click:connect(
        function()
            script.Parent.Parent.Parent.Parent.ImageColor3 = Color3.fromRGB(103, 194, 32)
        end
    )

    --                                                               ^
    --]]	Change "Credit" to the name of the frame                 ^
end
coroutine.wrap(AJCPKN_fake_script)()
local function HOJN_fake_script() -- BlueClick.ColorScript
    local script = Instance.new("LocalScript", BlueClick)

    script.Parent.MouseButton1Click:connect(
        function()
            script.Parent.Parent.Parent.Parent.ImageColor3 = Color3.fromRGB(73, 155, 255)
        end
    )

    --                                                               ^
    --]]	Change "Credit" to the name of the frame                 ^
end
coroutine.wrap(HOJN_fake_script)()
local function ILLG_fake_script() -- PurpleClick.ColorScript
    local script = Instance.new("LocalScript", PurpleClick)

    script.Parent.MouseButton1Click:connect(
        function()
            script.Parent.Parent.Parent.Parent.ImageColor3 = Color3.fromRGB(162, 55, 255)
        end
    )

    --                                                               ^
    --]]	Change "Credit" to the name of the frame                 ^
end
coroutine.wrap(ILLG_fake_script)()
local function HKUE_fake_script() -- InfiniteYieldButton.RotateScript
    local script = Instance.new("LocalScript", InfiniteYieldButton)

    local Button = script.Parent.Parent

    function MouseEnter()
        Button.Position = UDim2.new(0.272, 0, 0.469, 0)
        wait(0.001)
        Button.Position = UDim2.new(0.272, 0, 0.459, 0)
        wait(0.001)
        Button.Position = UDim2.new(0.272, 0, 0.449, 0)
        wait(0.001)
        Button.Position = UDim2.new(0.272, 0, 0.439, 0)
    end

    function MouseLeave()
        Button.Position = UDim2.new(0.272, 0, 0.449, 0)
        wait(0.001)
        Button.Position = UDim2.new(0.272, 0, 0.459, 0)
        wait(0.001)
        Button.Position = UDim2.new(0.272, 0, 0.469, 0)
        wait(0.001)
        Button.Position = UDim2.new(0.272, 0, 0.479, 0)
    end

    Button.MouseEnter:connect(MouseEnter)
    Button.MouseLeave:connect(MouseLeave)
end
coroutine.wrap(HKUE_fake_script)()
local function EQSHIQ_fake_script() -- InfiniteYieldButton.Execute
    local script = Instance.new("LocalScript", InfiniteYieldButton)

    script.Parent.MouseButton1Click:connect(
        function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        end
    )

    --                                                               ^
    --]]	Change "Credit" to the name of the frame                 ^
end
coroutine.wrap(EQSHIQ_fake_script)()
local function PTNIDYD_fake_script() -- CMDXButton.Execute
    local script = Instance.new("LocalScript", CMDXButton)

    script.Parent.MouseButton1Click:connect(
        function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source", true))()
        end
    )

    --                                                               ^
    --]]	Change "Credit" to the name of the frame                 ^
end
coroutine.wrap(PTNIDYD_fake_script)()
local function BIGJUL_fake_script() -- CMDXButton.RotateScript
    local script = Instance.new("LocalScript", CMDXButton)

    local Button = script.Parent.Parent

    function MouseEnter()
        Button.Position = UDim2.new(0.728, 0, 0.469, 0)
        wait(0.001)
        Button.Position = UDim2.new(0.728, 0, 0.459, 0)
        wait(0.001)
        Button.Position = UDim2.new(0.728, 0, 0.449, 0)
        wait(0.001)
        Button.Position = UDim2.new(0.728, 0, 0.439, 0)
    end

    function MouseLeave()
        Button.Position = UDim2.new(0.728, 0, 0.449, 0)
        wait(0.001)
        Button.Position = UDim2.new(0.728, 0, 0.459, 0)
        wait(0.001)
        Button.Position = UDim2.new(0.728, 0, 0.469, 0)
        wait(0.001)
        Button.Position = UDim2.new(0.728, 0, 0.479, 0)
    end

    Button.MouseEnter:connect(MouseEnter)
    Button.MouseLeave:connect(MouseLeave)
end
coroutine.wrap(BIGJUL_fake_script)()
local function OIOB_fake_script() -- Right.LocalScript
    local script = Instance.new("LocalScript", Right)

    script.Parent.MouseButton1Click:connect(
        function()
            if script.Parent.Parent.WhichNumber.Value == 1 then
                script.Parent.Parent.PageNumberBottom.Text = 2
                script.Parent.Parent.Page1.Visible = false
                script.Parent.Parent.Page2.Visible = true
                script.Parent.Parent.PageNumber.Text = 2
                script.Parent.Parent.TypeOfScripts.Text = "Script Hubs"
                script.Parent.Parent.WhichNumber.Value = 2
            elseif script.Parent.Parent.WhichNumber.Value == 2 then
                script.Parent.Parent.PageNumberBottom.Text = 3
                script.Parent.Parent.Page1.Visible = false
                script.Parent.Parent.Page2.Visible = false
                script.Parent.Parent.Page3.Visible = true
                script.Parent.Parent.PageNumber.Text = 3
                script.Parent.Parent.TypeOfScripts.Text = "Coming Soon"
                script.Parent.Parent.WhichNumber.Value = 3
            end
        end
    )

    --                                                               ^
    --]]	Change "Credit" to the name of the frame                 ^
end
coroutine.wrap(OIOB_fake_script)()
local function WMRNI_fake_script() -- Left.LocalScript
    local script = Instance.new("LocalScript", Left)

    script.Parent.MouseButton1Click:connect(
        function()
            if script.Parent.Parent.WhichNumber.Value == 2 then
                script.Parent.Parent.PageNumberBottom.Text = 1
                script.Parent.Parent.Page1.Visible = true
                script.Parent.Parent.Page2.Visible = false
                script.Parent.Parent.PageNumber.Text = 1
                script.Parent.Parent.TypeOfScripts.Text = "Admin Scripts"
                script.Parent.Parent.WhichNumber.Value = 1
            elseif script.Parent.Parent.WhichNumber.Value == 3 then
                script.Parent.Parent.PageNumberBottom.Text = 2
                script.Parent.Parent.Page1.Visible = false
                script.Parent.Parent.Page2.Visible = true
                script.Parent.Parent.Page3.Visible = false
                script.Parent.Parent.PageNumber.Text = 2
                script.Parent.Parent.TypeOfScripts.Text = "Script Hubs"
                script.Parent.Parent.WhichNumber.Value = 2
            end
        end
    )

    --                                                               ^
    --]]	Change "Credit" to the name of the frame                 ^
end
coroutine.wrap(WMRNI_fake_script)()
local function IOWIC_fake_script() -- DomainHubButton.RotateScript
    local script = Instance.new("LocalScript", DomainHubButton)

    local Button = script.Parent.Parent

    function MouseEnter()
        Button.Position = UDim2.new(0.272, 0, 0.469, 0)
        wait(0.001)
        Button.Position = UDim2.new(0.272, 0, 0.459, 0)
        wait(0.001)
        Button.Position = UDim2.new(0.272, 0, 0.449, 0)
        wait(0.001)
        Button.Position = UDim2.new(0.272, 0, 0.439, 0)
    end

    function MouseLeave()
        Button.Position = UDim2.new(0.272, 0, 0.449, 0)
        wait(0.001)
        Button.Position = UDim2.new(0.272, 0, 0.459, 0)
        wait(0.001)
        Button.Position = UDim2.new(0.272, 0, 0.469, 0)
        wait(0.001)
        Button.Position = UDim2.new(0.272, 0, 0.479, 0)
    end

    Button.MouseEnter:connect(MouseEnter)
    Button.MouseLeave:connect(MouseLeave)
end
coroutine.wrap(IOWIC_fake_script)()
local function HELGJQD_fake_script() -- DomainHubButton.Execute
    local script = Instance.new("LocalScript", DomainHubButton)

    script.Parent.MouseButton1Click:connect(
        function()
            loadstring(game:HttpGet(("https://raw.githubusercontent.com/shlexsoftworks/Domain/main/source"), true))()
        end
    )

    --                                                               ^
    --]]	Change "Credit" to the name of the frame                 ^
end
coroutine.wrap(HELGJQD_fake_script)()
local function JWVU_fake_script() -- XXHubButton.Execute
    local script = Instance.new("LocalScript", XXHubButton)

    script.Parent.MouseButton1Click:connect(
        function()
            loadstring(game:HttpGet(("https://pastebin.com/raw/YVE4njap"), true))()
            loadstring(game:HttpGet(("https://pastebin.com/raw/RVNdRJCP"), true))()
        end
    )

    --                                                               ^
    --]]	Change "Credit" to the name of the frame                 ^
end
coroutine.wrap(JWVU_fake_script)()
local function XJKVU_fake_script() -- XXHubButton.RotateScript
    local script = Instance.new("LocalScript", XXHubButton)

    local Button = script.Parent.Parent

    function MouseEnter()
        Button.Position = UDim2.new(0.728, 0, 0.469, 0)
        wait(0.001)
        Button.Position = UDim2.new(0.728, 0, 0.459, 0)
        wait(0.001)
        Button.Position = UDim2.new(0.728, 0, 0.449, 0)
        wait(0.001)
        Button.Position = UDim2.new(0.728, 0, 0.439, 0)
    end

    function MouseLeave()
        Button.Position = UDim2.new(0.728, 0, 0.449, 0)
        wait(0.001)
        Button.Position = UDim2.new(0.728, 0, 0.459, 0)
        wait(0.001)
        Button.Position = UDim2.new(0.728, 0, 0.469, 0)
        wait(0.001)
        Button.Position = UDim2.new(0.728, 0, 0.479, 0)
    end

    Button.MouseEnter:connect(MouseEnter)
    Button.MouseLeave:connect(MouseLeave)
end
coroutine.wrap(XJKVU_fake_script)()
