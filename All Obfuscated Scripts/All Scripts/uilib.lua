--[[
	id: TmeIe8IwVwqbBXUlI8qR-
	name: ui lib
	description: lib for hash
	time1: 2021-07-18 00:14:12.645499+00
	time2: 2021-07-18 00:14:12.6455+00
	uploader: 0MCmbsBbL5yZfANN4AwPidZnZoTTXDtvU-y5_yJ9
	uploadersession: 1KC-OdNoSUABYAjIMDFDkr6pAD2U99
	flag: f
--]]

--//locals
local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

--//services
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local InputService = game:GetService("UserInputService")
local CoreGuiService = game:GetService("CoreGui")
local ContentService = game:GetService("ContentProvider")

--//tables
local TweenInformation = {
    Default = TweenInfo.new(
        0.17,
        Enum.EasingStyle.Sine,
        Enum.EasingDirection.InOut,
        0,
        false,
        0
    )
}
local ComponentCount = {
    WindowCount = 0,
    TabCount = 0,
    SectionCount = 0,
    ButtonCount = 0,
    ToggleCount = 0,
    BoxCount = 0,
    LabelCount = 0,
    CutOffCount = 0
}
local Themes = {
    Default = {
        PrimaryColour = Color3.fromRGB(18,18,18),
        SecondaryColour = Color3.fromRGB(28,28,28),
        TextColour = Color3.fromRGB(200,200,200),
        UnFocusedText = Color3.fromRGB(160,160,160),
        Background = Color3.fromRGB(30,30,30),
        BackgroundBorder = Color3.fromRGB(23,23,23),
        HolderBorder = Color3.fromRGB(33,33,33),
        HolderColour = Color3.fromRGB(26,26,26),
        UnFocusedBorder = Color3.fromRGB(31,31,31),
        SectorBorder = Color3.fromRGB(21,21,21),
        AccentColour = Color3.fromRGB(73,142,197)
    }
}

--//functions
function addTweenInfo(name,tweenInfoTable)
    tweenInfoTable = {
        speed = tweenInfoTable.speed or 0.1,
        style = tweenInfoTable.style or Enum.EasingStyle.Sine,
        direction = tweenInfoTable.direction or Enum.EasingDirection.InOut,
        loop = tweenInfoTable.loop or 0,
        reverse = tweenInfoTable.reverse or false,
        delay = tweenInfoTable.delay or 0
    }
    TweenInformation[name] = TweenInfo.new(
        tweenInfoTable.speed,
        tweenInfoTable.style,
        tweenInfoTable.direction,
        tweenInfoTable.loop,
        tweenInfoTable.reverse,
        tweenInfoTable.delay
    )
end

function drag(obj,speed)
    toggled = nil
    input = nil
    start = nil
    function updateInput(input)
        local Delta = input.Position - start
        local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
        game:GetService("TweenService"):Create(obj, TweenInfo.new(speed), {Position = Position}):Play()
    end

    obj.InputBegan:Connect(function(inp)
        if (inp.UserInputType == Enum.UserInputType.MouseButton1) and UserInputService:GetFocusedTextBox() == nil then
            toggled = true
            start = inp.Position
            startPos = obj.Position
            inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then
                    toggled = false
                end
            end)
        end
    end)

    obj.InputChanged:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseMovement then
            input = inp
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(inp)
        if inp == input and toggled then
            updateInput(inp)
        end
    end)
end

function createTheme(ThemeName, ThemeInformation)
    ThemeInformation = {
        PrimaryColour = ThemeInformation.PrimaryColour or Themes.Default.PrimaryColour,
        SecondaryColour = ThemeInformation.SecondaryColour or Themes.Default.SecondaryColour,
        TextColour = ThemeInformation.TextColour or Themes.Default.TextColour,
        UnFocusedText = ThemeInformation.UnFocusedText or Themes.Default.UnFocusedText,
        Background = ThemeInformation.Background or Themes.Default.Background,
        BackgroundBorder = ThemeInformation.BackgroundBorder or Themes.Default.BackgroundBorder,
        HolderBorder = ThemeInformation.HolderBorder or Themes.Default.HolderBorder,
        HolderColour = ThemeInformation.HolderColour or Themes.Default.HolderColour,
        UnFocusedBorder = ThemeInformation.UnFocusedBorder or Themes.Default.UnFocusedBorder,
        SectorBorder = ThemeInformation.SectorBorder or Themes.Default.SectorBorder,
        AccentColour = ThemeInformation.AccentColour or Themes.Default.AccentColour
    }
    Themes[ThemeName] = ThemeInformation
end








--//library
local Library = {}
local MiscUI = Instance.new("ScreenGui")
MiscUI.Parent = CoreGuiService
MiscUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

function Library.SendNotification(NotificationConfiguration)
    NotificationConfiguration = {
        Title = NotificationConfiguration.Title or "Notification",
        Information = NotificationConfiguration.Information or "",
        Duration = NotificationConfiguration.Duration or 7
    }

    local notifications = Instance.new("Folder")
    local notificationsListing = Instance.new("UIListLayout")
    local notifHolder = Instance.new("Frame")
    local list = Instance.new("UIListLayout")
    local pad = Instance.new("UIPadding")
    local notification = Instance.new("Frame")
    local notificationLayout = Instance.new("UIListLayout")
    local background = Instance.new("Frame")
    local holderPadding = Instance.new("UIPadding")
    local holderLayout = Instance.new("UIListLayout")
    local holder = Instance.new("Frame")
    local header = Instance.new("TextLabel")
    local headerPadding = Instance.new("UIPadding")
    local headerLayout = Instance.new("UIListLayout")
    local infoText = Instance.new("TextLabel")
    local InfoPadding = Instance.new("UIPadding")

    notifications.Name = "notifications"
    notifications.Parent = MiscUI

    notificationsListing.Name = "notificationsListing"
    notificationsListing.Parent = notifications
    notificationsListing.HorizontalAlignment = Enum.HorizontalAlignment.Left
    notificationsListing.SortOrder = Enum.SortOrder.LayoutOrder
    notificationsListing.VerticalAlignment = Enum.VerticalAlignment.Top

    notifHolder.Name = "notifHolder"
    notifHolder.Parent = notifications
    notifHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    notifHolder.BackgroundTransparency = 1.000
    notifHolder.Size = UDim2.new(0, 400,0, 9999)

    list.Name = "list"
    list.Parent = notifHolder
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.VerticalAlignment = Enum.VerticalAlignment.Top
    list.Padding = UDim.new(0, 5)

    pad.Name = "pad"
    pad.Parent = notifHolder
    pad.PaddingBottom = UDim.new(0, 13)
    pad.PaddingLeft = UDim.new(0, 13)
    pad.PaddingRight = UDim.new(0, 13)
    pad.PaddingTop = UDim.new(0, 13)

    notification.Name = "notification"
    notification.Parent = notifHolder
    notification.BackgroundColor3 = SelectedTheme.AccentColour
    notification.BorderColor3 = SelectedTheme.Background
    notification.BorderSizePixel = 2
    notification.Position = UDim2.new(0.00831026025, 0, 0.521212101, 0)
    notification.Size = UDim2.new(0, 377, 0, 110)

    notificationLayout.Name = "notificationLayout"
    notificationLayout.Parent = notification
    notificationLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    notificationLayout.SortOrder = Enum.SortOrder.LayoutOrder
    notificationLayout.VerticalAlignment = Enum.VerticalAlignment.Center

    background.Name = "background"
    background.Parent = notification
    background.BackgroundColor3 = SelectedTheme.Background
    background.BorderColor3 = SelectedTheme.SecondaryColour
    background.BorderMode = "Inset"
    background.Position = UDim2.new(0.00265251985, 0, 0.00604303041, 0)
    background.Size = UDim2.new(0, 375, 0, 108)

    holderPadding.Name = "holderPadding"
    holderPadding.Parent = background
    holderPadding.PaddingTop = UDim.new(0, 28)

    holderLayout.Name = "holderLayout"
    holderLayout.Parent = background
    holderLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    holderLayout.SortOrder = Enum.SortOrder.LayoutOrder
    holderLayout.VerticalAlignment = Enum.VerticalAlignment.Center

    holder.Name = "holder"
    holder.Parent = background
    holder.BackgroundColor3 = SelectedTheme.HolderColour
    holder.BorderColor3 = SelectedTheme.HolderBorder
    holder.BorderMode = "Middle"
    holder.Position = UDim2.new(0.0157086831, 0, -0.0112989098, 0)
    holder.Size = UDim2.new(0, 369, 0, 73)

    header.Name = "header"
    header.Parent = holder
    header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    header.BackgroundTransparency = 1.000
    header.Position = UDim2.new(-0.00637982786, 0, -0.413293242, 0)
    header.Size = UDim2.new(0, 371, 0, 26)
    header.Font = Enum.Font.Code
    header.Text = NotificationConfiguration.Title
    header.TextColor3 = SelectedTheme.TextColour
    header.TextSize = 16.000
    header.TextStrokeTransparency = 0.000
    header.TextXAlignment = Enum.TextXAlignment.Left
    header.TextYAlignment = Enum.TextYAlignment.Top

    headerPadding.Name = "headerPadding"
    headerPadding.Parent = header
    headerPadding.PaddingLeft = UDim.new(0, 7)
    headerPadding.PaddingTop = UDim.new(0, 4)

    headerLayout.Name = "headerLayout"
    headerLayout.Parent = header
    headerLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    headerLayout.SortOrder = Enum.SortOrder.LayoutOrder
    headerLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom

    infoText.Name = "infoText"
    infoText.Parent = holder
    infoText.AnchorPoint = Vector2.new(0.5, 0.5)
    infoText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    infoText.BackgroundTransparency = 1.000
    infoText.Position = UDim2.new(0.5, 0, 0.5, 0)
    infoText.Size = UDim2.new(0, 367, 0, 71)
    infoText.Font = Enum.Font.Code
    infoText.Text = NotificationConfiguration.Information
    infoText.TextColor3 = SelectedTheme.UnFocusedText
    infoText.TextSize = 13.000
    infoText.TextStrokeTransparency = 0.000
    infoText.TextWrapped = true
    infoText.TextXAlignment = Enum.TextXAlignment.Left
    infoText.TextYAlignment = Enum.TextYAlignment.Top

    InfoPadding.Name = "InfoPadding"
    InfoPadding.Parent = infoText
    InfoPadding.PaddingLeft = UDim.new(0, 5)
    InfoPadding.PaddingRight = UDim.new(0, 5)
    InfoPadding.PaddingTop = UDim.new(0, 4)

    wait(NotificationConfiguration.Duration)
    notification:Destroy()
end
function Library.Create(Configuration)
    ComponentCount.WindowCount = ComponentCount.WindowCount + 1
    Configuration = {
        Header = Configuration.Header or "Window " .. ComponentCount.WindowCount,
        DragState = Configuration.DragState or true,
        DragLatency = Configuration.DragLatency or 0.07,
        Theme = Configuration.Theme or Themes["Default"],
        Keybind = Configuration.Keybind or Enum.KeyCode.Insert
    }
    SelectedTheme = Themes[Configuration.Theme]

    addTweenInfo("button_release",{
        speed = 0.12,
        style = Enum.EasingStyle.Sine,
        direction = Enum.EasingDirection.InOut,
        loop = 0,
        reverse = false,
        delay = 0
    })
    

    for i,v in next, game.CoreGui:GetDescendants() do
        if v.Name == "background" and v.Parent.Name == "border" and v.Parent.Parent.Name == "ScreenGui" then
            v.Parent.Parent:Destroy()
        end
    end

    local ScreenGui = Instance.new("ScreenGui")
    local border = Instance.new("Frame")
    local background = Instance.new("Frame")
    local holderPadding = Instance.new("UIPadding")
    local holder = Instance.new("Frame")
    local header = Instance.new("TextLabel")
    local headerPadding = Instance.new("UIPadding")
    local headerDesign = Instance.new("Frame")
    local headerBarLayout = Instance.new("UIListLayout")
    local headerBar = Instance.new("Frame")
    local headerLayout = Instance.new("UIListLayout")
    local tabButtons = Instance.new("Frame")
    local tabButtonsLayout = Instance.new("UIListLayout")
    local tabButtonsPadding = Instance.new("UIPadding")
    local tabHolder = Instance.new("Frame")
    local holderLayout = Instance.new("UIListLayout")
    local backgroundLayout = Instance.new("UIListLayout")

    ScreenGui.Parent = CoreGuiService
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    border.Name = "border"
    border.Parent = ScreenGui
    border.AnchorPoint = Vector2.new(0.5,0.5)
    border.BackgroundColor3 = SelectedTheme.AccentColour
    border.BorderColor3 = SelectedTheme.Background
    border.BorderMode = "Outline"
    border.BorderSizePixel = 2
    border.Position = UDim2.new(0.5,0,0.5,0)
    border.Size = UDim2.new(0, 599, 0, 405)

    background.Name = "background"
    background.Parent = border
    background.BackgroundColor3 = SelectedTheme.Background
    background.BorderColor3 = SelectedTheme.BackgroundBorder
    background.Position = UDim2.new(0.0878323913, 0, 0.174545467, 0)
    background.Size = UDim2.new(0, 595, 0, 401)

    holderPadding.Name = "holderPadding"
    holderPadding.Parent = background
    holderPadding.PaddingTop = UDim.new(0, 49)

    holder.Name = "holder"
    holder.Parent = background
    holder.BackgroundColor3 = SelectedTheme.HolderColour
    holder.BorderColor3 = SelectedTheme.HolderBorder
    holder.Position = UDim2.new(0.00504201697, 0, 0.105985038, 0)
    holder.Size = UDim2.new(0, 589, 0, 346)

    header.Name = "header"
    header.Parent = holder
    header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    header.BackgroundTransparency = 1.000
    header.Position = UDim2.new(-0.00100000005, 0, -0.153999999, 0)
    header.Size = UDim2.new(0, 589, 0, 39)
    header.Font = Enum.Font.Code
    header.Text = Configuration.Header
    header.TextColor3 = Color3.fromRGB(185, 185, 185)
    header.TextSize = 16.000
    header.TextStrokeTransparency = 0.000
    header.TextYAlignment = Enum.TextYAlignment.Top

    headerPadding.Name = "headerPadding"
    headerPadding.Parent = header
    headerPadding.PaddingTop = UDim.new(0, 4)

    headerDesign.Name = "headerDesign"
    headerDesign.Parent = header
    headerDesign.BackgroundColor3 = SelectedTheme.AccentColour
    headerDesign.BorderSizePixel = 0
    headerDesign.Position = UDim2.new(0.432937175, 0, 0.589743614, 0)
    headerDesign.Size = UDim2.new(0, (#Configuration.Header * 10)+4, 0, 16)

    headerBarLayout.Name = "headerBarLayout"
    headerBarLayout.Parent = headerDesign
    headerBarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    headerBarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    headerBarLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom

    headerBar.Name = "headerBar"
    headerBar.Parent = headerDesign
    headerBar.BackgroundColor3 = SelectedTheme.Background
    headerBar.BorderSizePixel = 0
    headerBar.Position = UDim2.new(-0.0895522386, 0, 0.0625, 0)
    headerBar.Size = UDim2.new(0, (#Configuration.Header * 10)+4, 0, 15)

    headerLayout.Name = "headerLayout"
    headerLayout.Parent = header
    headerLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    headerLayout.SortOrder = Enum.SortOrder.LayoutOrder
    headerLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom

    tabButtons.Name = "tabButtons"
    tabButtons.Parent = holder
    tabButtons.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tabButtons.BackgroundTransparency = 1.000
    tabButtons.Position = UDim2.new(0.00100000005, 0, -0.0810000002, 0)
    tabButtons.Size = UDim2.new(0, 589, 0, 29)

    tabButtonsLayout.Name = "tabButtonsLayout"
    tabButtonsLayout.Parent = tabButtons
    tabButtonsLayout.FillDirection = Enum.FillDirection.Horizontal
    tabButtonsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabButtonsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    tabButtonsLayout.Padding = UDim.new(0, 2)

    tabButtonsPadding.Name = "tabButtonsPadding"
    tabButtonsPadding.Parent = tabButtons
    tabButtonsPadding.PaddingLeft = UDim.new(0, 0)

    tabHolder.Name = "tabHolder"
    tabHolder.Parent = holder
    tabHolder.AnchorPoint = Vector2.new(0.5, 0.5)
    tabHolder.BackgroundColor3 = SelectedTheme.HolderColour
    tabHolder.BackgroundTransparency = 1.000
    tabHolder.BorderColor3 = SelectedTheme.HolderBorder
    tabHolder.Position = UDim2.new(0.5, 0, 0.5, 0)
    tabHolder.Size = UDim2.new(0, 589, 0, 346)

    holderLayout.Name = "holderLayout"
    holderLayout.Parent = background
    holderLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    holderLayout.SortOrder = Enum.SortOrder.LayoutOrder
    holderLayout.VerticalAlignment = Enum.VerticalAlignment.Center

    backgroundLayout.Name = "backgroundLayout"
    backgroundLayout.Parent = border
    backgroundLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    backgroundLayout.SortOrder = Enum.SortOrder.LayoutOrder
    backgroundLayout.VerticalAlignment = Enum.VerticalAlignment.Center

    if Configuration.DragState then
        drag(border,Configuration.DragLatency)
    end

    UserInputService.InputBegan:Connect(function(inp)
        if inp.KeyCode == Configuration.Keybind then
            border.Visible = not border.Visible 
        end
    end)

    function changeText(newText)    
        while wait() do
            header.Text = newText
        end
    end







    local TabHandler = {}
    local isFirstTab = true

    function TabHandler:AddTab(TabConfiguration)
        ComponentCount.TabCount = ComponentCount.TabCount + 1
        TabConfiguration = {
            Name = TabConfiguration.Name or "Tab " .. ComponentCount.TabCount
        }

        tabSelected = false

        local tabButton = Instance.new("TextButton")
        local bottom = Instance.new("Folder")
        local tabButtonDesign = Instance.new("Frame")
        local tabButtonDesignLayout = Instance.new("UIListLayout")
        local top = Instance.new("Folder")
        local tabButtonDesignLayout2 = Instance.new("UIListLayout")
        local tabButtonDesign2 = Instance.new("Frame")
        local tab = Instance.new("Frame")
        local tabLayout = Instance.new("UIListLayout")
        local left = Instance.new("ScrollingFrame")
        local leftLayout = Instance.new("UIListLayout")
        local leftPadding = Instance.new("UIPadding")
        local right = Instance.new("ScrollingFrame")
        local rightLayout = Instance.new("UIListLayout")
        local rightPadding = Instance.new("UIPadding")
        local tabButtonDesignPadding2 = Instance.new("UIPadding")

        tab.Name = "tab"
        tab.Parent = tabHolder
        tab.AnchorPoint = Vector2.new(0.5, 0.5)
        tab.BackgroundColor3 = SelectedTheme.HolderColour
        tab.BackgroundTransparency = 1.000
        tab.BorderColor3 = SelectedTheme.HolderBorder
        tab.Position = UDim2.new(0.5, 0, 0.5, 0)
        tab.Size = UDim2.new(0, 589, 0, 346)
        tab.Visible = false

        tabLayout.Name = "tabLayout"
        tabLayout.Parent = tab
        tabLayout.FillDirection = Enum.FillDirection.Horizontal
        tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        tabLayout.VerticalAlignment = Enum.VerticalAlignment.Center

        left.Name = "left"
        left.Parent = tab
        left.Active = true
        left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        left.BackgroundTransparency = 1.000
        left.BorderSizePixel = 0
        left.Position = UDim2.new(-0.503105402, 0, 0.00144508667, 0)
        left.Size = UDim2.new(0, 294, 0, 345)
        left.CanvasSize = UDim2.new(0, 0, 0, 0)
        left.ScrollBarThickness = 0

        leftLayout.Name = "leftLayout"
        leftLayout.Parent = left
        leftLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        leftLayout.SortOrder = Enum.SortOrder.LayoutOrder
        leftLayout.Padding = UDim.new(0, 3)

        leftPadding.Name = "leftPadding"
        leftPadding.Parent = left
        leftPadding.PaddingLeft = UDim.new(0, -1)
        leftPadding.PaddingRight = UDim.new(0, 1)
        leftPadding.PaddingTop = UDim.new(0, 5)

        right.Name = "right"
        right.Parent = tab
        right.Active = true
        right.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        right.BackgroundTransparency = 1.000
        right.BorderSizePixel = 0
        right.Position = UDim2.new(-0.503105402, 0, 0.00144508667, 0)
        right.Size = UDim2.new(0, 294, 0, 345)
        right.CanvasSize = UDim2.new(0, 0, 0, 0)
        right.ScrollBarThickness = 0

        rightLayout.Name = "rightLayout"
        rightLayout.Parent = right
        rightLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        rightLayout.SortOrder = Enum.SortOrder.LayoutOrder
        rightLayout.Padding = UDim.new(0, 3)

        rightPadding.Name = "rightPadding"
        rightPadding.Parent = right
        rightPadding.PaddingLeft = UDim.new(0, -1)
        rightPadding.PaddingTop = UDim.new(0, 5)

        tabButton.Name = "tabButton"
        tabButton.Parent = tabButtons
        tabButton.BackgroundColor3 = SelectedTheme.HolderColour
        tabButton.BackgroundTransparency = 0.200
        tabButton.BorderColor3 = SelectedTheme.UnFocusedBorder
        tabButton.Position = UDim2.new(-0.00339558581, 0, 0.0517241396, 0)
        tabButton.Size = UDim2.new(0, #TabConfiguration.Name*10, 0, 26)
        tabButton.AutoButtonColor = false
        tabButton.Font = Enum.Font.Code
        tabButton.Text = TabConfiguration.Name
        tabButton.TextColor3 = SelectedTheme.UnFocusedText
        tabButton.TextSize = 14.000
        tabButton.TextStrokeTransparency = 0.000

        bottom.Name = "bottom"
        bottom.Parent = tabButton

        tabButtonDesign.Name = "tabButtonDesign"
        tabButtonDesign.Parent = bottom
        tabButtonDesign.BackgroundColor3 = SelectedTheme.HolderColour
        tabButtonDesign.BorderColor3 = SelectedTheme.HolderColour
        tabButtonDesign.BorderSizePixel = 2
        tabButtonDesign.Size = UDim2.new(0, (#tabButton.Text*10)-4, 0, 1)
        tabButtonDesign.Visible = false

        tabButtonDesignLayout.Name = "tabButtonDesignLayout"
        tabButtonDesignLayout.Parent = bottom
        tabButtonDesignLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        tabButtonDesignLayout.SortOrder = Enum.SortOrder.LayoutOrder
        tabButtonDesignLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom

        top.Name = "top"
        top.Parent = tabButton

        tabButtonDesignLayout2.Name = "tabButtonDesignLayout2"
        tabButtonDesignLayout2.Parent = top
        tabButtonDesignLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
        tabButtonDesignLayout2.SortOrder = Enum.SortOrder.LayoutOrder

        tabButtonDesign2.Name = "tabButtonDesign2"
        tabButtonDesign2.Parent = top
        tabButtonDesign2.BackgroundColor3 = SelectedTheme.AccentColour
        tabButtonDesign2.BorderColor3 = SelectedTheme.HolderColour
        tabButtonDesign2.BorderSizePixel = 0
        tabButtonDesign2.Size = UDim2.new(0, (#tabButton.Text*10), 0, 1)
        tabButtonDesign2.Visible = false

        tabButtonDesignPadding2.Name = "tabButtonDesignPadding2"
        tabButtonDesignPadding2.Parent = top
        tabButtonDesignPadding2.PaddingTop = UDim.new(0, 2)
        
        local function updateSize(arch)
            local csL,csR
            csL = leftLayout.AbsoluteContentSize
            left.CanvasSize = UDim2.new(0,csL.X,0,(csL.Y)+5)
            csR = rightLayout.AbsoluteContentSize
            right.CanvasSize = UDim2.new(0,csR.X,0,(csR.Y)+5)
        end
        if isFirstTab then
            tab.Visible = true
            tabButton.TextColor3 = SelectedTheme.AccentColour
            tabButton.BackgroundTransparency = 0
            tabButtonDesign.Visible = true
            tabButtonDesign2.Visible = true
            updateSize()
        end
        tabButton.MouseButton1Down:Connect(function()
            for i,v in next, tabHolder:GetChildren() do
                v.Visible = false
            end
            for z,x in next, tabButtons:GetChildren() do
                if x:IsA("TextButton") then
                    x.TextColor3 = SelectedTheme.UnFocusedText
                    x.BackgroundTransparency = 0.2
                    x.bottom.tabButtonDesign.Visible = false
                    x.top.tabButtonDesign2.Visible = false
                end
            end
            tab.Visible = true
            tabButton.TextColor3 = SelectedTheme.AccentColour
            tabButton.BackgroundTransparency = 0
            tabButtonDesign.Visible = true
            tabButtonDesign2.Visible = true
            updateSize()
        end)
        isFirstTab = false
        updateSize()









        local SectorHandler = {}

        function SectorHandler:CreateSector(SectorConfiguration)
            ComponentCount.SectionCount = ComponentCount.SectionCount + 1
            SectorConfiguration = {
                SectorHeader = SectorConfiguration.SectorHeader or "Sector " .. ComponentCount.SectionCount
            }

            local align
            if leftLayout.AbsoluteContentSize.Y > rightLayout.AbsoluteContentSize.Y then
                align = right
            else 
                align = left
            end

            local section = Instance.new("Frame")
            local sectionLayout = Instance.new("UIListLayout")
            local topBar = Instance.new("Frame")
            local sectionHeader = Instance.new("TextLabel")
            local sectionHeaderPadding = Instance.new("UIPadding")

            section.Name = "section"
            section.Parent = align
            section.BackgroundColor3 = SelectedTheme.SecondaryColour
            section.BorderColor3 = SelectedTheme.SectorBorder
            section.BorderSizePixel = 2
            section.Position = UDim2.new(0.0204081628, 0, 0.466666669, 0)
            section.Size = UDim2.new(0, 283, 0, 32)

            sectionLayout.Name = "sectionLayout"
            sectionLayout.Parent = section
            sectionLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            sectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
            sectionLayout.Padding = UDim.new(0, 3)

            topBar.Name = "topBar"
            topBar.Parent = section
            topBar.BackgroundColor3 = SelectedTheme.AccentColour
            topBar.BorderSizePixel = 0
            topBar.Size = UDim2.new(0, 282, 0, 1)

            sectionHeader.Name = "sectionHeader"
            sectionHeader.Parent = section
            sectionHeader.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sectionHeader.BackgroundTransparency = 1.000
            sectionHeader.Position = UDim2.new(0, 0, 0.012987013, 0)
            sectionHeader.Size = UDim2.new(0, 283, 0, 23)
            sectionHeader.Font = Enum.Font.Code
            sectionHeader.Text = SectorConfiguration.SectorHeader
            sectionHeader.TextColor3 = SelectedTheme.TextColour
            sectionHeader.TextSize = 15.000
            sectionHeader.TextStrokeTransparency = 0.000
            sectionHeader.TextXAlignment = Enum.TextXAlignment.Left

            sectionHeaderPadding.Name = "sectionHeaderPadding"
            sectionHeaderPadding.Parent = sectionHeader
            sectionHeaderPadding.PaddingBottom = UDim.new(0, 1)
            sectionHeaderPadding.PaddingLeft = UDim.new(0, 7)
            sectionHeaderPadding.PaddingTop = UDim.new(0, -7)

            if SectorConfiguration.SectorHeader == "" then
                sectionHeader:Destroy()
            end

            local function updateSectorSize()
                local sc
                sc = sectionLayout.AbsoluteContentSize
                section.Size = UDim2.new(0,283,0,(sc.Y)+5)
                updateSize()
            end

            updateSize()









            local ComponentHandler = {}

            function ComponentHandler:CreateCutOff(CutOffConfiguration)
                ComponentCount.CutOffCount = ComponentCount.CutOffCount + 1
                CutOffConfiguration = {
                    Style = CutOffConfiguration.Style or "one",
                    Transparency = CutOffConfiguration.Transparency or 0
                }

                local cutOff = Instance.new("Frame")

                cutOff.Name = "cutOff_1"
                cutOff.Parent = section
                cutOff.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
                cutOff.BorderSizePixel = 0
                cutOff.Position = UDim2.new(0.323321551, 0, 0.138528138, 0)
                cutOff.Size = UDim2.new(0, 267, 0, 1)
                cutOff.BackgroundTransparency = CutOffConfiguration.Transparency
                if string.find(string.lower(tostring(CutOffConfiguration.Style)),"one") then
                    cutOff.BackgroundColor3 = Color3.fromRGB(75,75,75)
                elseif string.find(string.lower(tostring(CutOffConfiguration.Style)),"two") then
                    cutOff.BackgroundColor3 = Color3.fromRGB(140,140,140)
                elseif string.find(string.lower(tostring(CutOffConfiguration.Style)),"three") then
                    cutOff.BackgroundColor3 = SelectedTheme.AccentColour
                end
                updateSectorSize()
            end

            function ComponentHandler:CreateLabel(LabelConfiguration)
                ComponentCount.LabelCount = ComponentCount.LabelCount + 1
                LabelConfiguration = {
                    Text = LabelConfiguration.Text or "Label " .. ComponentCount.LabelCount,
                    Alignment = LabelConfiguration.Alignment or Enum.TextXAlignment.Left
                }
                local labelLeft = Instance.new("TextLabel")
                local sectionHeaderPadding3 = Instance.new("UIPadding")

                labelLeft.Name = "labelLeft"
                labelLeft.Parent = section
                labelLeft.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                labelLeft.BackgroundTransparency = 1.000
                labelLeft.Position = UDim2.new(0, 0, 0.275862068, 0)
                labelLeft.Size = UDim2.new(0, 283, 0, 20)
                labelLeft.Font = Enum.Font.Code
                labelLeft.Text = LabelConfiguration.Text
                labelLeft.TextColor3 = Color3.fromRGB(200, 200, 200)
                labelLeft.TextSize = 13.000
                labelLeft.TextStrokeTransparency = 0.000
                labelLeft.TextXAlignment = LabelConfiguration.Alignment

                sectionHeaderPadding3.Name = "sectionHeaderPadding3"
                sectionHeaderPadding3.Parent = labelLeft
                sectionHeaderPadding3.PaddingLeft = UDim.new(0, 10)

                updateSectorSize()
            end

            function ComponentHandler:CreateButton(ButtonConfiguration)
                ComponentCount.ButtonCount = ComponentCount.ButtonCount + 1
                ButtonConfiguration = {
                    Text = ButtonConfiguration.Text or "Button " .. ComponentCount.ButtonCount,
                    Style = ButtonConfiguration.Style or "Default",
                    Script = ButtonConfiguration.Script or function() print(Text .. " | [script]") end
                }

                local buttonClick = Instance.new("TextButton")
                local buttonLayout = Instance.new("UIListLayout")
                local buttonDesign1 = Instance.new("Frame")
                local buttonTextLayout = Instance.new("UIListLayout")
                local buttonText = Instance.new("TextLabel")

                buttonClick.Name = "buttonClick"
                buttonClick.Parent = section
                buttonClick.BackgroundColor3 = SelectedTheme.PrimaryColour
                buttonClick.BorderColor3 = SelectedTheme.HolderColour
                buttonClick.BorderSizePixel = 2
                buttonClick.Position = UDim2.new(0.0848056525, 0, 0.400000006, 0)
                buttonClick.Size = UDim2.new(0, 265, 0, 20)
                buttonClick.AutoButtonColor = false
                buttonClick.Font = Enum.Font.Code
                buttonClick.Text = ""
                buttonClick.TextColor3 = Color3.fromRGB(200, 200, 200)
                buttonClick.TextSize = 13.000
                buttonClick.TextStrokeTransparency = 0.000
                buttonClick.TextXAlignment = Enum.TextXAlignment.Left

                buttonLayout.Name = "buttonLayout"
                buttonLayout.Parent = buttonClick
                buttonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                buttonLayout.SortOrder = Enum.SortOrder.LayoutOrder
                buttonLayout.VerticalAlignment = Enum.VerticalAlignment.Center

                buttonDesign1.Name = "buttonDesign1"
                buttonDesign1.Parent = buttonClick
                buttonDesign1.BackgroundColor3 = SelectedTheme.SectorBorder
                buttonDesign1.BorderColor3 = SelectedTheme.HolderColour
                buttonDesign1.BorderMode = "Middle"
                buttonDesign1.Size = UDim2.new(0, 262, 0, 17)

                buttonTextLayout.Name = "buttonTextLayout"
                buttonTextLayout.Parent = buttonDesign1
                buttonTextLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                buttonTextLayout.SortOrder = Enum.SortOrder.LayoutOrder
                buttonTextLayout.VerticalAlignment = Enum.VerticalAlignment.Center

                buttonText.Name = "buttonText"
                buttonText.Parent = buttonDesign1
                buttonText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                buttonText.BackgroundTransparency = 1.000
                buttonText.Size = UDim2.new(0, 262, 0, 17)
                buttonText.Font = Enum.Font.Code
                buttonText.LineHeight = 1.050
                buttonText.Text = ButtonConfiguration.Text
                buttonText.TextColor3 = SelectedTheme.TextColour
                buttonText.TextSize = 13.000
                buttonText.TextStrokeTransparency = 0.000
                
                if string.find(string.lower(ButtonConfiguration.Style),"find") then
                    buttonClick.MouseButton1Down:Connect(function()
                        TweenService:Create(buttonDesign1,TweenInformation.button_release,{BackgroundColor3 = SelectedTheme.PrimaryColour}):Play()
                    end)
                    buttonClick.MouseButton1Up:Connect(function()
                        TweenService:Create(buttonDesign1,TweenInformation.button_release,{BackgroundColor3 = SelectedTheme.HolderColour}):Play()
                        wait(0.12)
                        TweenService:Create(buttonDesign1,TweenInformation.button_release,{BackgroundColor3 = SelectedTheme.SectorBorder}):Play()
                    end)
                end

                buttonClick.MouseButton1Click:Connect(function()
                    ButtonConfiguration.Script()
                end)

                updateSectorSize()
                updateSize()
            end

            function ComponentHandler:CreateToggle(ToggleConfiguration)
                ComponentCount.ToggleCount = ComponentCount.ToggleCount + 1
                ToggleConfiguration = {
                    Text = ToggleConfiguration.Text or "Toggle " .. ComponentCount.ToggleCount,
                    Mode = ToggleConfiguration.Mode or "loop",
                    Style = ToggleConfiguration.Style or "default",
                    Delay = ToggleConfiguration.Delay or 0,
                    Script = ToggleConfiguration.Script or function() end
                }

                local toggleButton = Instance.new("TextButton")
                local toggleLayout = Instance.new("UIListLayout")
                local toggleDesign1 = Instance.new("Frame")
                local toggleDesignLayout1 = Instance.new("UIListLayout")
                local toggleDesign2 = Instance.new("Frame")
                local toggleDesignLayout2 = Instance.new("UIListLayout")
                local togglePadding = Instance.new("UIPadding")
                local toggleHeader = Instance.new("TextLabel")
                local sectionHeaderPadding = Instance.new("UIPadding")

                toggleButton.Name = "toggleButton"
                toggleButton.Parent = section
                toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                toggleButton.BackgroundTransparency = 1.000
                toggleButton.BorderSizePixel = 0
                toggleButton.Size = UDim2.new(0, 283, 0, 20)
                toggleButton.AutoButtonColor = false
                toggleButton.Font = Enum.Font.Code
                toggleButton.Text = ""
                toggleButton.TextColor3 = Color3.fromRGB(200, 200, 200)
                toggleButton.TextSize = 13.000
                toggleButton.TextStrokeTransparency = 0.000
                toggleButton.TextXAlignment = Enum.TextXAlignment.Left

                toggleLayout.Name = "toggleLayout"
                toggleLayout.Parent = toggleButton
                toggleLayout.FillDirection = Enum.FillDirection.Horizontal
                toggleLayout.SortOrder = Enum.SortOrder.LayoutOrder
                toggleLayout.VerticalAlignment = Enum.VerticalAlignment.Center
                toggleLayout.Padding = UDim.new(0, 8)

                toggleDesign1.Name = "toggleDesign1"
                toggleDesign1.Parent = toggleButton
                toggleDesign1.BackgroundColor3 = SelectedTheme.PrimaryColour
                toggleDesign1.BorderColor3 = SelectedTheme.SecondaryColour
                toggleDesign1.BorderSizePixel = 2
                toggleDesign1.Size = UDim2.new(0, 15, 0, 15)

                toggleDesignLayout1.Name = "toggleDesignLayout1"
                toggleDesignLayout1.Parent = toggleDesign1
                toggleDesignLayout1.HorizontalAlignment = Enum.HorizontalAlignment.Center
                toggleDesignLayout1.SortOrder = Enum.SortOrder.LayoutOrder
                toggleDesignLayout1.VerticalAlignment = Enum.VerticalAlignment.Center

                toggleDesign2.Name = "toggleDesign2"
                toggleDesign2.Parent = toggleDesign1
                toggleDesign2.BackgroundColor3 = SelectedTheme.SectorBorder
                toggleDesign2.BorderColor3 = SelectedTheme.HolderColour
                toggleDesign2.BorderMode = "Middle"
                toggleDesign2.Size = UDim2.new(0, 12, 0, 12)

                toggleDesignLayout2.Name = "toggleDesignLayout2"
                toggleDesignLayout2.Parent = toggleDesign2
                toggleDesignLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
                toggleDesignLayout2.SortOrder = Enum.SortOrder.LayoutOrder
                toggleDesignLayout2.VerticalAlignment = Enum.VerticalAlignment.Center

                togglePadding.Name = "togglePadding"
                togglePadding.Parent = toggleButton
                togglePadding.PaddingLeft = UDim.new(0, 11)
                togglePadding.PaddingRight = UDim.new(0, -24)

                toggleHeader.Name = "toggleHeader"
                toggleHeader.Parent = toggleButton
                toggleHeader.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                toggleHeader.BackgroundTransparency = 1.000
                toggleHeader.Position = UDim2.new(0.120141342, 0, 0, 0)
                toggleHeader.Size = UDim2.new(0, 247, 0, 20)
                toggleHeader.Font = Enum.Font.Code
                toggleHeader.LineHeight = 1.100
                toggleHeader.Text = ToggleConfiguration.Text
                toggleHeader.TextColor3 = SelectedTheme.TextColour
                toggleHeader.TextSize = 13.000
                toggleHeader.TextStrokeTransparency = 0.000
                toggleHeader.TextXAlignment = Enum.TextXAlignment.Left

                sectionHeaderPadding.Name = "sectionHeaderPadding"
                sectionHeaderPadding.Parent = toggleHeader

                local Toggled = false;

                toggleButton.MouseButton1Click:Connect(function()
                    Toggled = not Toggled
                    ToggleColour = Toggled and SelectedTheme.AccentColour or SelectedTheme.SectorBorder
                    toggleDesign2.BackgroundColor3 = ToggleColour
                    if string.find(string.lower(ToggleConfiguration.Mode),"check") then
                        if Toggled then
                            ToggleConfiguration.Script()
                        end
                    elseif string.find(string.lower(ToggleConfiguration.Mode),"loop") then
                        while Toggled and wait(ToggleConfiguration.Delay) do
                            ToggleConfiguration.Script()
                        end
                    end
                end)

                updateSectorSize()
                updateSize()
            end

            function ComponentHandler:CreateBox(BoxConfiguration)
                BoxConfiguration = {
                    Text = BoxConfiguration.Text or "Box " .. ComponentCount.BoxCount,
                    PlaceHolder = BoxConfiguration.PlaceHolder or "nil",
                    Style = BoxConfiguration.Style or "default",
                    Script = BoxConfiguration.Script or function() end
                }

                local textBox = Instance.new("TextLabel")
                local sectionHeaderPadding = Instance.new("UIPadding")
                local boxHolder = Instance.new("Frame")
                local box = Instance.new("TextBox")
                local boxLayout = Instance.new("UIListLayout")

                textBox.Name = "textBox"
                textBox.Parent = section
                textBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                textBox.BackgroundTransparency = 1.000
                textBox.Position = UDim2.new(0, 0, 0.275862068, 0)
                textBox.Size = UDim2.new(0, 283, 0, 20)
                textBox.Font = Enum.Font.Code
                textBox.Text = BoxConfiguration.Text
                textBox.TextColor3 = SelectedTheme.TextColour
                textBox.TextSize = 13.000
                textBox.TextStrokeTransparency = 0.000
                textBox.TextXAlignment = Enum.TextXAlignment.Left

                sectionHeaderPadding.Name = "sectionHeaderPadding"
                sectionHeaderPadding.Parent = textBox
                sectionHeaderPadding.PaddingLeft = UDim.new(0, 10)

                boxHolder.Name = "boxHolder"
                boxHolder.Parent = textBox
                boxHolder.BackgroundColor3 = SelectedTheme.PrimaryColour
                boxHolder.BorderColor3 = SelectedTheme.SecondaryColour
                boxHolder.BorderSizePixel = 2
                boxHolder.Position = UDim2.new(0.681999981, 0, 0.100000001, 0)
                boxHolder.Size = UDim2.new(0, 79, 0, 16)

                box.Name = "box"
                box.Parent = boxHolder
                box.BackgroundColor3 = SelectedTheme.SectorBorder
                box.BorderColor3 = SelectedTheme.HolderColour 
                box.BorderMode = "Middle"
                box.Position = UDim2.new(0.682208478, 0, 0.100000001, 0)
                box.Size = UDim2.new(0, 76, 0, 13)
                box.ClearTextOnFocus = false
                box.Font = Enum.Font.Code
                box.PlaceholderColor3 = SelectedTheme.UnFocusedText
                box.PlaceholderText = "placeholder"
                box.Text = ""
                box.TextColor3 = SelectedTheme.TextColour
                box.TextSize = 11.000
                box.TextTruncate = "AtEnd"

                boxLayout.Name = "boxLayout"
                boxLayout.Parent = boxHolder
                boxLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                boxLayout.SortOrder = Enum.SortOrder.LayoutOrder
                boxLayout.VerticalAlignment = Enum.VerticalAlignment.Center

                box.FocusLost:Connect(function(EnterPressed)
                    if not EnterPressed then
                        return
                    end
                    BoxConfiguration.Script(box.Text)
                end)
                
                updateSectorSize()
                updateSize()
            end
            return ComponentHandler
        end
        return SectorHandler
    end
    return TabHandler
end
return Library