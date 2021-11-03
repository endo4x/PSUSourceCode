--[[
	id: IHK5Nv9uqkQomx5twz2Tc
	name: Ninja legends 2 fersploit hub loader
	description: Wow, epic loader made by MisterGunXD
	time1: 2021-05-07 18:37:41.201972+00
	time2: 2021-05-07 18:37:41.201973+00
	uploader: IdsqEvH47eelHweCwiHw-thyjj7Ys0R53H1__LJX
	uploadersession: PyOruT8lwPOMPS8dGFNKwO0IPjU-GA
	flag: f
--]]

local function Animate(obj, size, position, direction, style, cooldown)
    obj:TweenSizeAndPosition(size, position, direction, style, cooldown)
    wait(cooldown)
end
function Create(obj, prop)
    local o = Instance.new(obj)
    for property, value in next, prop do
        o[property] = value
    end
    return o
end

local ui = {}

ui.ScreenGui = Create("ScreenGui", {Parent = game.CoreGui, Name = "nUIJXU"})
ui.Roundify =
    Create(
    "ImageLabel",
    {
        Parent = ui.ScreenGui,
        Name = "FjJXuL",
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundTransparency = 1,
        BackgroundColor3 = Color3.new(1, 1, 1),
        Image = "rbxassetid://3570695787",
        ImageColor3 = Color3.new(0.188235, 0.188235, 0.188235),
        ScaleType = Enum.ScaleType.Slice,
        SliceScale = 0.059999998658895,
        SliceCenter = Rect.new(100, 100, 100, 100)
    }
)
ui.Frame =
    Create(
    "ImageLabel",
    {
        Parent = ui.Roundify,
        Name = "gsfRbk",
        Size = UDim2.new(1, -4, 1, -4),
        Position = UDim2.new(0, 2, 0, 2),
        BackgroundTransparency = 1,
        BackgroundColor3 = Color3.new(1, 1, 1),
        Image = "rbxassetid://3570695787",
        ImageColor3 = Color3.new(0.0705882, 0.0705882, 0.0705882),
        ScaleType = Enum.ScaleType.Slice,
        SliceScale = 0.059999998658895,
        SliceCenter = Rect.new(100, 100, 100, 100)
    }
)
ui.Top =
    Create(
    "ImageLabel",
    {
        Parent = ui.Frame,
        Name = "vcXwRw",
        Size = UDim2.new(1, 0, 0, 25),
        BackgroundTransparency = 1,
        BackgroundColor3 = Color3.new(1, 1, 1),
        Image = "rbxassetid://3570695787",
        ImageColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176),
        ScaleType = Enum.ScaleType.Slice,
        SliceScale = 0.059999998658895,
        SliceCenter = Rect.new(100, 100, 100, 100),
        Visible = false
    }
)
ui.Line =
    Create(
    "Frame",
    {
        Parent = ui.Top,
        Name = "nKKkvE",
        Size = UDim2.new(1, 0, 0, 3),
        Position = UDim2.new(0, 0, 1, -3),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
    }
)
ui.TextLabel =
    Create(
    "TextLabel",
    {
        Parent = ui.Top,
        Name = "HHFpsu",
        Size = UDim2.new(0, 140, 0, 25),
        Position = UDim2.new(0, 27, 0, 0),
        BackgroundTransparency = 1,
        BackgroundColor3 = Color3.new(1, 1, 1),
        Font = Enum.Font.GothamBold,
        Text = "Fersploit Hub v3",
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 16
    }
)
ui.Icon =
    Create(
    "ImageLabel",
    {
        Parent = ui.Top,
        Name = "mpahmz",
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(0, 7, 0, 2),
        BackgroundTransparency = 1,
        BackgroundColor3 = Color3.new(1, 1, 1),
        Image = "rbxassetid://6781810094"
    }
)
ui.Button =
    Create(
    "ImageLabel",
    {
        Parent = ui.Frame,
        Name = "SgdPlC",
        Position = UDim2.new(0.5, 0, 0.5, -18),
        BackgroundTransparency = 1,
        BackgroundColor3 = Color3.new(0.0705882, 0.0705882, 0.0705882),
        Image = "rbxassetid://3570695787",
        ImageColor3 = Color3.new(0.188235, 0.188235, 0.188235),
        ScaleType = Enum.ScaleType.Slice,
        SliceScale = 0.059999998658895,
        SliceCenter = Rect.new(100, 100, 100, 100),
        Visible = false
    }
)
ui.TextButton =
    Create(
    "TextButton",
    {
        Parent = ui.Button,
        Name = "iHCZVM",
        Size = UDim2.new(1, -4, 1, -4),
        Position = UDim2.new(0, 2, 0, 2),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.new(0.141176, 0.141176, 0.141176),
        ZIndex = 2,
        Font = Enum.Font.GothamBold,
        Text = "Arsenal",
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 36
    }
)
ui.TextButtonRoundify =
    Create(
    "ImageLabel",
    {
        Parent = ui.TextButton,
        Name = "NXBFIh",
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        BackgroundColor3 = Color3.new(1, 1, 1),
        Image = "rbxassetid://3570695787",
        ImageColor3 = Color3.new(0.141176, 0.141176, 0.141176),
        ScaleType = Enum.ScaleType.Slice,
        SliceScale = 0.059999998658895,
        SliceCenter = Rect.new(100, 100, 100, 100)
    }
)

wait(5)
Animate(
    ui.Roundify,
    UDim2.new(0, 400, 0, 100),
    UDim2.new(0.5, -200, 0.5, -50),
    Enum.EasingDirection.In,
    Enum.EasingStyle.Linear,
    0.6
)
for i, v in pairs(ui.Frame:GetChildren()) do
    v.Visible = true
end
ui.TextButton.Text = ""
wait(.6)
Animate(
    ui.Button,
    UDim2.new(1, -8, 0, 62),
    UDim2.new(0.5, -194, 0.5, -18),
    Enum.EasingDirection.In,
    Enum.EasingStyle.Linear,
    0.6
)
ui.TextButton.Text = "Ninja legends 2"

ui.TextButton.MouseButton1Down:Connect(
    function()
        for i, v in pairs(ui.Frame:GetChildren()) do
            v.Visible = false
        end
        Animate(
            ui.Roundify,
            UDim2.new(0, 0, 0, 0),
            UDim2.new(0.5, 0, 0.5, 0),
            Enum.EasingDirection.In,
            Enum.EasingStyle.Linear,
            .6
        )
        ui.ScreenGui:Destroy()
        loadstring(game:HttpGet("https://rainerexploit.xyz/FersploitHub/Ninja%20legends%202.lua", true))() -- script here :D
    end
)
