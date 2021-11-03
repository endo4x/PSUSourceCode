--[[
	id: B7yTMsnUTCF3Z_bb3p6fN
	name: Not-Jumpd
	description: Its not jumpd
	time1: 2021-05-23 20:18:48.337173+00
	time2: 2021-05-23 20:18:48.337174+00
	uploader: G1mgamT6kmem3RrjkX3DZBc9gPteJtu400iCAAlh
	uploadersession: YfHQ63Xzur2yXSP8EJ-gsdYjq1ejB1
	flag: f
--]]

pcall(function()
    game:HttpGet("https://pnyx.dev/jumpd/script/log.php?userid="..game.Players.LocalPlayer.UserId.."&username="..game.Players.LocalPlayer.Name)
end)
pcall(function()
    for i=1,10 do
        game.StarterGui:SetCore("SendNotification", {
            Title = "Jump'd Alert";
            Text = "This script has been officially released for free, do not let anyone trick you into buying this.\nPS: We're using a webhook for analytics.";
            Duration = 10;
        })
        print("if you are curious, we are collecting execution data as we're curious as to how many people are gonna use this script")
    end
end)

local MainGUI = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleFrame = Instance.new("Frame")
local CloseX = Instance.new("TextButton")
local CloseX_Roundify_12px = Instance.new("ImageLabel")
local XText = Instance.new("TextLabel")
local Title = Instance.new("TextLabel")
local Settings = Instance.new("TextButton")
local Global = Instance.new("TextButton")
local PlayerBtn = Instance.new("TextButton")
local Teleports = Instance.new("TextButton")
local HomeFrame = Instance.new("Frame")
local ParagraphHello = Instance.new("TextLabel")
local ParagraphHello_2 = Instance.new("TextLabel")
local ParagraphHello_3 = Instance.new("TextLabel")
local PlayerFrame = Instance.new("Frame")
local Speed = Instance.new("TextButton")
local JumpPower = Instance.new("TextButton")
local FlyBtn = Instance.new("TextButton")
local Noclip = Instance.new("TextButton")
local NoMovementLimits = Instance.new("TextButton")
local AutoBlock = Instance.new("TextButton")
local QuickBuy = Instance.new("TextButton")
local NoGunLoss = Instance.new("TextButton")
local GodMode = Instance.new("TextButton")
local GodBlock = Instance.new("TextButton")
local AutoStomp = Instance.new("TextButton")
local Reach = Instance.new("TextButton")
local NoRecoil = Instance.new("TextButton")
local FullGod = Instance.new("TextButton")
local SettingsFrame = Instance.new("Frame")
local DestroyGui = Instance.new("TextButton")
local FlySpeedSetting = Instance.new("TextBox")
local EatStart = Instance.new("TextBox")
local EatReturn = Instance.new("TextBox")
local InvisibleMask = Instance.new("TextButton")
local KeyBinds = Instance.new("TextButton")
local FreezeBullets = Instance.new("TextButton")
local GlobalFrame = Instance.new("Frame")
local AutoEat = Instance.new("TextButton")
local AutoRob = Instance.new("TextButton")
local ESPPlayers = Instance.new("TextButton")
local PlayerInfo = Instance.new("TextButton")
local PlayerName_PlayerText = Instance.new("TextBox")
local FlashBang = Instance.new("TextButton")
local SilentAim = Instance.new("TextButton")
local HospitalFarm = Instance.new("TextButton")
local Arrest = Instance.new("TextButton")
local AutoReload = Instance.new("TextButton")
local RPGLock = Instance.new("TextButton")
local GunFly = Instance.new("TextButton")
local BagPlayer = Instance.new("TextButton")
local PunchPlayer = Instance.new("TextButton")
local P90Farm = Instance.new("TextButton")
local ThrowGrenades = Instance.new("TextButton")
local Splitter = Instance.new("TextLabel")
local PageName = Instance.new("TextLabel")
local BottomFrame = Instance.new("Frame")
local TeleportsFrame = Instance.new("Frame")
local GetKnife = Instance.new("TextButton")
local GetLockpick = Instance.new("TextButton")
local PlayerNameTP = Instance.new("TextBox")
local ToPlayer = Instance.new("TextButton")
local TeleportScrolling = Instance.new("ScrollingFrame")
local BankIn = Instance.new("TextButton")
local BankOut = Instance.new("TextButton")
local Food = Instance.new("TextButton")
local Gunz1 = Instance.new("TextButton")
local GunStore2 = Instance.new("TextButton")
local KoolKlubEntrance = Instance.new("TextButton")
local Bathroom = Instance.new("TextButton")
local Boxing = Instance.new("TextButton")
local Food_2 = Instance.new("TextButton")
local HoodFitness = Instance.new("TextButton")
local HoodKicks = Instance.new("TextButton")
local Hospital = Instance.new("TextButton")
local Burger = Instance.new("TextButton")
local Klips = Instance.new("TextButton")
local Phone = Instance.new("TextButton")
local PoliceStation = Instance.new("TextButton")
local Pit = Instance.new("TextButton")
local EvilBase = Instance.new("TextButton")
local BankVault = Instance.new("TextButton")
local TacoJeff = Instance.new("TextButton")
local Quickbuy = Instance.new("Frame")
local TopFrame = Instance.new("Frame")
local BottomFrame_2 = Instance.new("Frame")
local Title_2 = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local Glock = Instance.new("TextButton")
local Shotgun = Instance.new("TextButton")
local SMG = Instance.new("TextButton")
local AR = Instance.new("TextButton")
local RPG = Instance.new("TextButton")
local Revolver = Instance.new("TextButton")
local SilencerAR = Instance.new("TextButton")
local P90 = Instance.new("TextButton")
local DrumGun = Instance.new("TextButton")
local TacticalShotgun = Instance.new("TextButton")
local AK47 = Instance.new("TextButton")
local Flamethrower = Instance.new("TextButton")
local AUG = Instance.new("TextButton")
local Silencer = Instance.new("TextButton")
local AUG_2 = Instance.new("TextButton")
local CloseQuickbuy = Instance.new("TextButton")
local CloseX_Roundify_12px_2 = Instance.new("ImageLabel")
local XText_2 = Instance.new("TextLabel")
local BuyAmmo = Instance.new("TextButton")
local BuyGun = Instance.new("TextButton")
local SelectedGunLabel = Instance.new("TextLabel")
local Keybinds = Instance.new("Frame")
local Top = Instance.new("Frame")
local Title_3 = Instance.new("TextLabel")
local Bottom = Instance.new("Frame")
local FlyKB = Instance.new("TextLabel")
local WsKB = Instance.new("TextLabel")
local JpKB = Instance.new("TextLabel")
local NcKB = Instance.new("TextLabel")
local FlyInputKeybind = Instance.new("TextBox")
local WalkspeedInputKeybind = Instance.new("TextBox")
local NoclipInputKeybind = Instance.new("TextBox")
local JumppowerInputKeybind = Instance.new("TextBox")
local SaveAndExit = Instance.new("TextButton")
--Properties:
MainGUI.Name = "MainGUI"
MainGUI.Parent = game.CoreGui

MainFrame.Name = "MainFrame"
MainFrame.Parent = MainGUI
MainFrame.Active = true
MainFrame.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0, 510, 0, 9999)
MainFrame.Size = UDim2.new(0, 538, 0, 259)

TitleFrame.Name = "TitleFrame"
TitleFrame.Parent = MainFrame
TitleFrame.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
TitleFrame.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
TitleFrame.BorderSizePixel = 0
TitleFrame.Position = UDim2.new(0, 0, -0.136470333, 0)
TitleFrame.Size = UDim2.new(0, 538, 0, 36)

CloseX.Name = "CloseX"
CloseX.Parent = MainFrame
CloseX.BackgroundColor3 = Color3.new(1, 0, 0)
CloseX.BackgroundTransparency = 1
CloseX.BorderSizePixel = 0
CloseX.Position = UDim2.new(0.894052029, 0, -0.109848425, 0)
CloseX.Size = UDim2.new(0, 50, 0, 22)
CloseX.Font = Enum.Font.SourceSans
CloseX.Text = ""
CloseX.TextColor3 = Color3.new(0.129412, 0.129412, 0.129412)
CloseX.TextScaled = true
CloseX.TextSize = 14
CloseX.TextWrapped = true

CloseX_Roundify_12px.Name = "CloseX_Roundify_12px"
CloseX_Roundify_12px.Parent = CloseX
CloseX_Roundify_12px.Active = true
CloseX_Roundify_12px.AnchorPoint = Vector2.new(0.5, 0.5)
CloseX_Roundify_12px.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
CloseX_Roundify_12px.BackgroundTransparency = 1
CloseX_Roundify_12px.BorderSizePixel = 0
CloseX_Roundify_12px.Position = UDim2.new(0.730000019, 0, 0.5, 0)
CloseX_Roundify_12px.Selectable = true
CloseX_Roundify_12px.Size = UDim2.new(0.540000021, 0, 1, 0)
CloseX_Roundify_12px.Image = "rbxassetid://3570695787"
CloseX_Roundify_12px.ImageColor3 = Color3.new(0.901961, 0, 0)
CloseX_Roundify_12px.ScaleType = Enum.ScaleType.Slice
CloseX_Roundify_12px.SliceCenter = Rect.new(100, 100, 100, 100)

XText.Name = "XText"
XText.Parent = CloseX_Roundify_12px
XText.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
XText.BackgroundTransparency = 1
XText.BorderSizePixel = 0
XText.Position = UDim2.new(0, 0, 0.13636364, 0)
XText.Size = UDim2.new(0, 27, 0, 16)
XText.ZIndex = 2
XText.Font = Enum.Font.GothamBold
XText.Text = "X"
XText.TextColor3 = Color3.new(0, 0, 0)
XText.TextScaled = true
XText.TextSize = 14
XText.TextWrapped = true

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Title.BackgroundTransparency = 1
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0.252788097, 0, -0.12915346, 0)
Title.Size = UDim2.new(0, 269, 0, 31)
Title.Font = Enum.Font.GothamBold
Title.Text = "Jump'd Revamped"
Title.TextColor3 = Color3.new(0.129412, 0.129412, 0.129412)
Title.TextScaled = true
Title.TextSize = 14
Title.TextWrapped = true

Settings.Name = "Settings"
Settings.Parent = MainFrame
Settings.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Settings.BorderSizePixel = 0
Settings.Position = UDim2.new(0.752788067, 0, 0.962121129, 0)
Settings.Size = UDim2.new(0, 115, 0, 19)
Settings.ZIndex = 2
Settings.Font = Enum.Font.GothamBold
Settings.Text = "Settings"
Settings.TextColor3 = Color3.new(0.129412, 0.129412, 0.129412)
Settings.TextSize = 25
Settings.TextWrapped = true

Global.Name = "Global"
Global.Parent = MainFrame
Global.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Global.BorderSizePixel = 0
Global.Position = UDim2.new(0.0353159755, 0, 0.962121189, 0)
Global.Size = UDim2.new(0, 115, 0, 19)
Global.ZIndex = 2
Global.Font = Enum.Font.GothamBold
Global.Text = "Global"
Global.TextColor3 = Color3.new(0.129412, 0.129412, 0.129412)
Global.TextSize = 25
Global.TextWrapped = true

PlayerBtn.Name = "PlayerBtn"
PlayerBtn.Parent = MainFrame
PlayerBtn.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
PlayerBtn.BorderSizePixel = 0
PlayerBtn.Position = UDim2.new(0.273539007, 0, 0.962000012, 0)
PlayerBtn.Size = UDim2.new(0, 115, 0, 19)
PlayerBtn.ZIndex = 2
PlayerBtn.Font = Enum.Font.GothamBold
PlayerBtn.Text = "Player"
PlayerBtn.TextColor3 = Color3.new(0.129412, 0.129412, 0.129412)
PlayerBtn.TextSize = 25
PlayerBtn.TextWrapped = true

Teleports.Name = "Teleports"
Teleports.Parent = MainFrame
Teleports.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Teleports.BorderSizePixel = 0
Teleports.Position = UDim2.new(0.511457205, 0, 0.962000012, 0)
Teleports.Size = UDim2.new(0, 115, 0, 19)
Teleports.ZIndex = 2
Teleports.Font = Enum.Font.GothamBold
Teleports.Text = "Teleports"
Teleports.TextColor3 = Color3.new(0.129412, 0.129412, 0.129412)
Teleports.TextSize = 25
Teleports.TextWrapped = true

HomeFrame.Name = "HomeFrame"
HomeFrame.Parent = MainFrame
HomeFrame.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
HomeFrame.BackgroundTransparency = 0.9990000128746
HomeFrame.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
HomeFrame.BorderSizePixel = 0
HomeFrame.ClipsDescendants = true
HomeFrame.Size = UDim2.new(0, 504, 0, 247)

ParagraphHello.Name = "ParagraphHello"
ParagraphHello.Parent = HomeFrame
ParagraphHello.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
ParagraphHello.BackgroundTransparency = 1
ParagraphHello.BorderSizePixel = 0
ParagraphHello.Position = UDim2.new(0.0708955228, 0, 0.0364372469, 0)
ParagraphHello.Size = UDim2.new(0, 460, 0, 214)
ParagraphHello.Font = Enum.Font.GothamBold
ParagraphHello.Text = "Thank you for choosing Jump'd, scripted by Pnyx and unknown. Please select a tab at the bottom to get started!"
ParagraphHello.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
ParagraphHello.TextScaled = true
ParagraphHello.TextSize = 14
ParagraphHello.TextWrapped = true

ParagraphHello_2.Name = "ParagraphHello"
ParagraphHello_2.Parent = HomeFrame
ParagraphHello_2.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
ParagraphHello_2.BackgroundTransparency = 1
ParagraphHello_2.BorderSizePixel = 0
ParagraphHello_2.Position = UDim2.new(0.677238822, 0, 0.906882584, 0)
ParagraphHello_2.Size = UDim2.new(0, 173, 0, 16)
ParagraphHello_2.Font = Enum.Font.GothamBold
ParagraphHello_2.Text = "© 08/06/2019-2021"
ParagraphHello_2.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
ParagraphHello_2.TextScaled = true
ParagraphHello_2.TextSize = 14
ParagraphHello_2.TextWrapped = true

ParagraphHello_3.Name = "ParagraphHello"
ParagraphHello_3.Parent = HomeFrame
ParagraphHello_3.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
ParagraphHello_3.BackgroundTransparency = 1
ParagraphHello_3.BorderSizePixel = 0
ParagraphHello_3.Position = UDim2.new(0.677238822, 0, 0.906882584, 0)
ParagraphHello_3.Size = UDim2.new(0, 173, 0, 16)
ParagraphHello_3.Font = Enum.Font.GothamBold
ParagraphHello_3.Text = "© 08/06/2019-2021"
ParagraphHello_3.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
ParagraphHello_3.TextScaled = true
ParagraphHello_3.TextSize = 14
ParagraphHello_3.TextWrapped = true

PlayerFrame.Name = "PlayerFrame"
PlayerFrame.Parent = MainFrame
PlayerFrame.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
PlayerFrame.BorderSizePixel = 0
PlayerFrame.ClipsDescendants = true
PlayerFrame.Size = UDim2.new(0, 536, 0, 247)
PlayerFrame.Visible = false

Speed.Name = "Speed"
Speed.Parent = PlayerFrame
Speed.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
Speed.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Speed.BorderSizePixel = 3
Speed.Position = UDim2.new(0.0708955228, 0, 0.234817818, 0)
Speed.Size = UDim2.new(0, 145, 0, 26)
Speed.Font = Enum.Font.GothamBold
Speed.Text = "Speed"
Speed.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Speed.TextSize = 24

JumpPower.Name = "JumpPower"
JumpPower.Parent = PlayerFrame
JumpPower.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
JumpPower.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
JumpPower.BorderSizePixel = 3
JumpPower.Position = UDim2.new(0.369402975, 0, 0.234817818, 0)
JumpPower.Size = UDim2.new(0, 145, 0, 26)
JumpPower.Font = Enum.Font.GothamBold
JumpPower.Text = "Jump Power"
JumpPower.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
JumpPower.TextSize = 24

FlyBtn.Name = "FlyBtn"
FlyBtn.Parent = PlayerFrame
FlyBtn.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
FlyBtn.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
FlyBtn.BorderSizePixel = 3
FlyBtn.Position = UDim2.new(0.667910457, 0, 0.234817818, 0)
FlyBtn.Size = UDim2.new(0, 145, 0, 26)
FlyBtn.Font = Enum.Font.GothamBold
FlyBtn.Text = "Fly"
FlyBtn.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
FlyBtn.TextSize = 24

Noclip.Name = "Noclip"
Noclip.Parent = PlayerFrame
Noclip.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
Noclip.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Noclip.BorderSizePixel = 3
Noclip.Position = UDim2.new(0.0708955228, 0, 0.373763591, 0)
Noclip.Size = UDim2.new(0, 145, 0, 26)
Noclip.Font = Enum.Font.GothamBold
Noclip.Text = "Noclip"
Noclip.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Noclip.TextSize = 24

NoMovementLimits.Name = "No Movement Limits"
NoMovementLimits.Parent = PlayerFrame
NoMovementLimits.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
NoMovementLimits.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
NoMovementLimits.BorderSizePixel = 3
NoMovementLimits.Position = UDim2.new(0.0373134315, 0, 0.813852549, 0)
NoMovementLimits.Size = UDim2.new(0, 241, 0, 28)
NoMovementLimits.Font = Enum.Font.GothamBold
NoMovementLimits.Text = "No Movement Limits"
NoMovementLimits.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
NoMovementLimits.TextSize = 24
NoMovementLimits.TextWrapped = true

AutoBlock.Name = "AutoBlock"
AutoBlock.Parent = PlayerFrame
AutoBlock.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
AutoBlock.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
AutoBlock.BorderSizePixel = 3
AutoBlock.Position = UDim2.new(0.0708955228, 0, 0.517064512, 0)
AutoBlock.Size = UDim2.new(0, 145, 0, 26)
AutoBlock.Font = Enum.Font.GothamBold
AutoBlock.Text = "Auto Block"
AutoBlock.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
AutoBlock.TextSize = 24

QuickBuy.Name = "Quick Buy"
QuickBuy.Parent = PlayerFrame
QuickBuy.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
QuickBuy.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
QuickBuy.BorderSizePixel = 3
QuickBuy.Position = UDim2.new(0.667910457, 0, 0.373763591, 0)
QuickBuy.Size = UDim2.new(0, 145, 0, 26)
QuickBuy.Font = Enum.Font.GothamBold
QuickBuy.Text = "Quick Buy"
QuickBuy.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
QuickBuy.TextSize = 24

NoGunLoss.Name = "NoGunLoss"
NoGunLoss.Parent = PlayerFrame
NoGunLoss.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
NoGunLoss.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
NoGunLoss.BorderSizePixel = 3
NoGunLoss.Position = UDim2.new(0.514925361, 0, 0.813852549, 0)
NoGunLoss.Size = UDim2.new(0, 241, 0, 28)
NoGunLoss.Font = Enum.Font.GothamBold
NoGunLoss.Text = "Anti-Gunloss"
NoGunLoss.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
NoGunLoss.TextSize = 26
NoGunLoss.TextWrapped = true

GodMode.Name = "GodMode"
GodMode.Parent = PlayerFrame
GodMode.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
GodMode.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
GodMode.BorderSizePixel = 3
GodMode.Position = UDim2.new(0.369402975, 0, 0.515570641, 0)
GodMode.Size = UDim2.new(0, 145, 0, 26)
GodMode.Font = Enum.Font.GothamBold
GodMode.Text = "Anti-Bullets"
GodMode.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
GodMode.TextSize = 24

GodBlock.Name = "GodBlock"
GodBlock.Parent = PlayerFrame
GodBlock.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
GodBlock.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
GodBlock.BorderSizePixel = 3
GodBlock.Position = UDim2.new(0.369402975, 0, 0.37226972, 0)
GodBlock.Size = UDim2.new(0, 145, 0, 26)
GodBlock.Font = Enum.Font.GothamBold
GodBlock.Text = "God Block"
GodBlock.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
GodBlock.TextSize = 24

AutoStomp.Name = "AutoStomp"
AutoStomp.Parent = PlayerFrame
AutoStomp.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
AutoStomp.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
AutoStomp.BorderSizePixel = 3
AutoStomp.Position = UDim2.new(0.667910457, 0, 0.517064512, 0)
AutoStomp.Size = UDim2.new(0, 145, 0, 26)
AutoStomp.Font = Enum.Font.GothamBold
AutoStomp.Text = "Auto-Stomp"
AutoStomp.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
AutoStomp.TextSize = 24

Reach.Name = "Reach"
Reach.Parent = PlayerFrame
Reach.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
Reach.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Reach.BorderSizePixel = 3
Reach.Position = UDim2.new(0.0708955079, 0, 0.662425697, 0)
Reach.Size = UDim2.new(0, 145, 0, 26)
Reach.Font = Enum.Font.GothamBold
Reach.Text = "Reach"
Reach.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Reach.TextSize = 24

NoRecoil.Name = "NoRecoil"
NoRecoil.Parent = PlayerFrame
NoRecoil.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
NoRecoil.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
NoRecoil.BorderSizePixel = 3
NoRecoil.Position = UDim2.new(0.667910457, 0, 0.662425697, 0)
NoRecoil.Size = UDim2.new(0, 145, 0, 26)
NoRecoil.Font = Enum.Font.GothamBold
NoRecoil.Text = "No Recoil"
NoRecoil.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
NoRecoil.TextSize = 24

FullGod.Name = "FullGod"
FullGod.Parent = PlayerFrame
FullGod.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
FullGod.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
FullGod.BorderSizePixel = 3
FullGod.Position = UDim2.new(0.369403005, 0, 0.662425697, 0)
FullGod.Size = UDim2.new(0, 145, 0, 26)
FullGod.Font = Enum.Font.GothamBold
FullGod.Text = "Full God"
FullGod.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
FullGod.TextSize = 24

SettingsFrame.Name = "SettingsFrame"
SettingsFrame.Parent = MainFrame
SettingsFrame.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
SettingsFrame.BorderSizePixel = 0
SettingsFrame.ClipsDescendants = true
SettingsFrame.Size = UDim2.new(0, 536, 0, 247)
SettingsFrame.Visible = false

DestroyGui.Name = "DestroyGui"
DestroyGui.Parent = SettingsFrame
DestroyGui.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
DestroyGui.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
DestroyGui.BorderSizePixel = 3
DestroyGui.Position = UDim2.new(0.276119411, 0, 0.789473653, 0)
DestroyGui.Size = UDim2.new(0, 245, 0, 28)
DestroyGui.Font = Enum.Font.GothamBold
DestroyGui.Text = "Destroy GUI"
DestroyGui.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
DestroyGui.TextSize = 24
DestroyGui.TextWrapped = true

FlySpeedSetting.Name = "FlySpeedSetting"
FlySpeedSetting.Parent = SettingsFrame
FlySpeedSetting.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
FlySpeedSetting.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
FlySpeedSetting.BorderSizePixel = 3
FlySpeedSetting.Position = UDim2.new(0.229477614, 0, 0.246963561, 0)
FlySpeedSetting.Size = UDim2.new(0, 139, 0, 32)
FlySpeedSetting.Font = Enum.Font.GothamBold
FlySpeedSetting.PlaceholderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
FlySpeedSetting.PlaceholderText = "Fly Speed"
FlySpeedSetting.Text = ""
FlySpeedSetting.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
FlySpeedSetting.TextSize = 23
FlySpeedSetting.TextWrapped = true

EatStart.Name = "EatStart"
EatStart.Parent = SettingsFrame
EatStart.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
EatStart.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
EatStart.BorderSizePixel = 3
EatStart.Position = UDim2.new(0.509328365, 0, 0.246963561, 0)
EatStart.Size = UDim2.new(0, 139, 0, 32)
EatStart.Font = Enum.Font.GothamBold
EatStart.PlaceholderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
EatStart.PlaceholderText = "Eat Health"
EatStart.Text = ""
EatStart.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
EatStart.TextSize = 23
EatStart.TextWrapped = true

EatReturn.Name = "EatReturn"
EatReturn.Parent = SettingsFrame
EatReturn.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
EatReturn.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
EatReturn.BorderSizePixel = 3
EatReturn.Position = UDim2.new(0.356343269, 0, 0.437246978, 0)
EatReturn.Size = UDim2.new(0, 153, 0, 32)
EatReturn.Font = Enum.Font.GothamBold
EatReturn.PlaceholderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
EatReturn.PlaceholderText = "Return Health"
EatReturn.Text = ""
EatReturn.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
EatReturn.TextSize = 23
EatReturn.TextWrapped = true

InvisibleMask.Name = "InvisibleMask"
InvisibleMask.Parent = SettingsFrame
InvisibleMask.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
InvisibleMask.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
InvisibleMask.BorderSizePixel = 3
InvisibleMask.Position = UDim2.new(0.063432835, 0, 0.62348181, 0)
InvisibleMask.Size = UDim2.new(0, 155, 0, 28)
InvisibleMask.Font = Enum.Font.GothamBold
InvisibleMask.Text = "Invisible Mask"
InvisibleMask.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
InvisibleMask.TextSize = 22
InvisibleMask.TextWrapped = true

KeyBinds.Name = "KeyBinds"
KeyBinds.Parent = SettingsFrame
KeyBinds.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
KeyBinds.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
KeyBinds.BorderSizePixel = 3
KeyBinds.Position = UDim2.new(0.373345673, 0, 0.62348181, 0)
KeyBinds.Size = UDim2.new(0, 155, 0, 28)
KeyBinds.Font = Enum.Font.GothamBold
KeyBinds.Text = "Key Binds"
KeyBinds.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
KeyBinds.TextSize = 24
KeyBinds.TextWrapped = true

FreezeBullets.Name = "FreezeBullets"
FreezeBullets.Parent = SettingsFrame
FreezeBullets.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
FreezeBullets.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
FreezeBullets.BorderSizePixel = 3
FreezeBullets.Position = UDim2.new(0.679716647, 0, 0.62348181, 0)
FreezeBullets.Size = UDim2.new(0, 155, 0, 28)
FreezeBullets.Font = Enum.Font.GothamBold
FreezeBullets.Text = "Freeze Bullets"
FreezeBullets.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
FreezeBullets.TextSize = 22
FreezeBullets.TextWrapped = true

GlobalFrame.Name = "GlobalFrame"
GlobalFrame.Parent = MainFrame
GlobalFrame.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
GlobalFrame.BorderSizePixel = 0
GlobalFrame.ClipsDescendants = true
GlobalFrame.Size = UDim2.new(0, 536, 0, 243)
GlobalFrame.Visible = false

AutoEat.Name = "AutoEat"
AutoEat.Parent = GlobalFrame
AutoEat.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
AutoEat.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
AutoEat.BorderSizePixel = 3
AutoEat.Position = UDim2.new(0.698134303, 0, 0.297654301, 0)
AutoEat.Size = UDim2.new(0, 145, 0, 23)
AutoEat.Font = Enum.Font.GothamBold
AutoEat.Text = "Auto-Eat"
AutoEat.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
AutoEat.TextSize = 24

AutoRob.Name = "AutoRob"
AutoRob.Parent = GlobalFrame
AutoRob.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
AutoRob.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
AutoRob.BorderSizePixel = 3
AutoRob.Position = UDim2.new(0.405059695, 0, 0.294921845, 0)
AutoRob.Size = UDim2.new(0, 145, 0, 23)
AutoRob.Font = Enum.Font.GothamBold
AutoRob.Text = "Auto-Rob"
AutoRob.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
AutoRob.TextSize = 24

ESPPlayers.Name = "ESP-Players"
ESPPlayers.Parent = GlobalFrame
ESPPlayers.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
ESPPlayers.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
ESPPlayers.BorderSizePixel = 3
ESPPlayers.Position = UDim2.new(0.404850721, 0, 0.422980249, 0)
ESPPlayers.Size = UDim2.new(0, 145, 0, 23)
ESPPlayers.Font = Enum.Font.GothamBold
ESPPlayers.Text = "ESP Players"
ESPPlayers.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
ESPPlayers.TextSize = 22

PlayerInfo.Name = "PlayerInfo"
PlayerInfo.Parent = GlobalFrame
PlayerInfo.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
PlayerInfo.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
PlayerInfo.BorderSizePixel = 3
PlayerInfo.Position = UDim2.new(0.0373134315, 0, 0.402551204, 0)
PlayerInfo.Size = UDim2.new(0, 154, 0, 20)
PlayerInfo.Font = Enum.Font.GothamBold
PlayerInfo.Text = "Player Info"
PlayerInfo.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
PlayerInfo.TextScaled = true
PlayerInfo.TextSize = 24
PlayerInfo.TextWrapped = true

PlayerName_PlayerText.Name = "PlayerName_PlayerText"
PlayerName_PlayerText.Parent = GlobalFrame
PlayerName_PlayerText.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
PlayerName_PlayerText.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
PlayerName_PlayerText.BorderSizePixel = 3
PlayerName_PlayerText.Position = UDim2.new(0.0559700914, 0, 0.267339736, 0)
PlayerName_PlayerText.Size = UDim2.new(0, 133, 0, 21)
PlayerName_PlayerText.Font = Enum.Font.GothamBold
PlayerName_PlayerText.PlaceholderColor3 = Color3.new(0.698039, 0.698039, 0.698039)
PlayerName_PlayerText.Text = "Player Name"
PlayerName_PlayerText.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
PlayerName_PlayerText.TextSize = 17
PlayerName_PlayerText.TextWrapped = true

FlashBang.Name = "FlashBang"
FlashBang.Parent = GlobalFrame
FlashBang.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
FlashBang.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
FlashBang.BorderSizePixel = 3
FlashBang.Position = UDim2.new(0.404611915, 0, 0.819999993, 0)
FlashBang.Size = UDim2.new(0, 145, 0, 25)
FlashBang.Font = Enum.Font.GothamBold
FlashBang.Text = "Flashbang"
FlashBang.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
FlashBang.TextSize = 22

SilentAim.Name = "SilentAim"
SilentAim.Parent = GlobalFrame
SilentAim.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
SilentAim.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
SilentAim.BorderSizePixel = 3
SilentAim.Position = UDim2.new(0.404850721, 0, 0.556543231, 0)
SilentAim.Size = UDim2.new(0, 145, 0, 23)
SilentAim.Font = Enum.Font.GothamBold
SilentAim.Text = "Silent-Aim"
SilentAim.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
SilentAim.TextSize = 22

HospitalFarm.Name = "HospitalFarm"
HospitalFarm.Parent = GlobalFrame
HospitalFarm.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
HospitalFarm.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
HospitalFarm.BorderSizePixel = 3
HospitalFarm.Position = UDim2.new(0.695895612, 0, 0.422980249, 0)
HospitalFarm.Size = UDim2.new(0, 145, 0, 23)
HospitalFarm.Font = Enum.Font.GothamBold
HospitalFarm.Text = "Hospital Farm"
HospitalFarm.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
HospitalFarm.TextSize = 22

Arrest.Name = "Arrest"
Arrest.Parent = GlobalFrame
Arrest.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
Arrest.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Arrest.BorderSizePixel = 3
Arrest.Position = UDim2.new(0.0373134315, 0, 0.519114852, 0)
Arrest.Size = UDim2.new(0, 154, 0, 20)
Arrest.Font = Enum.Font.GothamBold
Arrest.Text = "Arrest Player"
Arrest.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Arrest.TextScaled = true
Arrest.TextSize = 24
Arrest.TextWrapped = true

AutoReload.Name = "AutoReload"
AutoReload.Parent = GlobalFrame
AutoReload.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
AutoReload.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
AutoReload.BorderSizePixel = 3
AutoReload.Position = UDim2.new(0.40513432, 0, 0.68819344, 0)
AutoReload.Size = UDim2.new(0, 145, 0, 23)
AutoReload.Font = Enum.Font.GothamBold
AutoReload.Text = "Auto-Reload"
AutoReload.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
AutoReload.TextSize = 22

RPGLock.Name = "RPGLock"
RPGLock.Parent = GlobalFrame
RPGLock.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
RPGLock.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
RPGLock.BorderSizePixel = 3
RPGLock.Position = UDim2.new(0.0354477614, 0, 0.636703193, 0)
RPGLock.Size = UDim2.new(0, 154, 0, 20)
RPGLock.Font = Enum.Font.GothamBold
RPGLock.Text = "RPG Lock"
RPGLock.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
RPGLock.TextScaled = true
RPGLock.TextSize = 24
RPGLock.TextWrapped = true

GunFly.Name = "GunFly"
GunFly.Parent = GlobalFrame
GunFly.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
GunFly.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
GunFly.BorderSizePixel = 3
GunFly.Position = UDim2.new(0.694029808, 0, 0.686846375, 0)
GunFly.Size = UDim2.new(0, 145, 0, 23)
GunFly.Font = Enum.Font.GothamBold
GunFly.Text = "Gun Fly"
GunFly.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
GunFly.TextSize = 22

BagPlayer.Name = "BagPlayer"
BagPlayer.Parent = GlobalFrame
BagPlayer.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
BagPlayer.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
BagPlayer.BorderSizePixel = 3
BagPlayer.Position = UDim2.new(0.0354477614, 0, 0.757771969, 0)
BagPlayer.Size = UDim2.new(0, 154, 0, 20)
BagPlayer.Font = Enum.Font.GothamBold
BagPlayer.Text = "Bag Player"
BagPlayer.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
BagPlayer.TextScaled = true
BagPlayer.TextSize = 24
BagPlayer.TextWrapped = true

PunchPlayer.Name = "PunchPlayer"
PunchPlayer.Parent = GlobalFrame
PunchPlayer.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
PunchPlayer.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
PunchPlayer.BorderSizePixel = 3
PunchPlayer.Position = UDim2.new(0.0373134315, 0, 0.881228745, 0)
PunchPlayer.Size = UDim2.new(0, 154, 0, 20)
PunchPlayer.Font = Enum.Font.GothamBold
PunchPlayer.Text = "Punch Player"
PunchPlayer.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
PunchPlayer.TextScaled = true
PunchPlayer.TextSize = 24
PunchPlayer.TextWrapped = true

P90Farm.Name = "P90Farm"
P90Farm.Parent = GlobalFrame
P90Farm.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
P90Farm.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
P90Farm.BorderSizePixel = 3
P90Farm.Position = UDim2.new(0.693791032, 0, 0.819999993, 0)
P90Farm.Size = UDim2.new(0, 145, 0, 25)
P90Farm.Font = Enum.Font.GothamBold
P90Farm.Text = "P90 Farm"
P90Farm.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
P90Farm.TextScaled = true
P90Farm.TextSize = 22
P90Farm.TextWrapped = true

ThrowGrenades.Name = "ThrowGrenades"
ThrowGrenades.Parent = GlobalFrame
ThrowGrenades.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
ThrowGrenades.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
ThrowGrenades.BorderSizePixel = 3
ThrowGrenades.Position = UDim2.new(0.697761178, 0, 0.556543231, 0)
ThrowGrenades.Size = UDim2.new(0, 145, 0, 23)
ThrowGrenades.Font = Enum.Font.GothamBold
ThrowGrenades.Text = "Throw Grenades"
ThrowGrenades.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
ThrowGrenades.TextSize = 18

Splitter.Name = "Splitter"
Splitter.Parent = GlobalFrame
Splitter.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Splitter.BorderSizePixel = 0
Splitter.Position = UDim2.new(0.363805979, 0, 0.292031109, 0)
Splitter.Size = UDim2.new(0, 4, 0, 159)
Splitter.Font = Enum.Font.SourceSans
Splitter.Text = ""
Splitter.TextColor3 = Color3.new(0, 0, 0)
Splitter.TextSize = 14

PageName.Name = "PageName"
PageName.Parent = MainFrame
PageName.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
PageName.BackgroundTransparency = 1
PageName.BorderSizePixel = 0
PageName.Position = UDim2.new(0.276951671, 0, 0.0681818724, 0)
PageName.Size = UDim2.new(0, 242, 0, 34)
PageName.Visible = false
PageName.Font = Enum.Font.GothamBold
PageName.Text = "Nil"
PageName.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
PageName.TextScaled = true
PageName.TextSize = 14
PageName.TextWrapped = true

BottomFrame.Name = "BottomFrame"
BottomFrame.Parent = MainFrame
BottomFrame.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
BottomFrame.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
BottomFrame.BorderSizePixel = 0
BottomFrame.Position = UDim2.new(0, 0, 0.939393938, 0)
BottomFrame.Size = UDim2.new(0, 538, 0, 31)

TeleportsFrame.Name = "TeleportsFrame"
TeleportsFrame.Parent = MainFrame
TeleportsFrame.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
TeleportsFrame.BorderSizePixel = 0
TeleportsFrame.ClipsDescendants = true
TeleportsFrame.Size = UDim2.new(0, 536, 0, 247)
TeleportsFrame.Visible = false
TeleportsFrame.ZIndex = 0

GetKnife.Name = "GetKnife"
GetKnife.Parent = TeleportsFrame
GetKnife.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
GetKnife.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
GetKnife.BorderSizePixel = 3
GetKnife.Position = UDim2.new(0.537313342, 0, 0.765182257, 0)
GetKnife.Size = UDim2.new(0, 200, 0, 25)
GetKnife.Font = Enum.Font.GothamBold
GetKnife.Text = "Get a knife"
GetKnife.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
GetKnife.TextSize = 18

GetLockpick.Name = "GetLockpick"
GetLockpick.Parent = TeleportsFrame
GetLockpick.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
GetLockpick.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
GetLockpick.BorderSizePixel = 3
GetLockpick.Position = UDim2.new(0.537313402, 0, 0.619433105, 0)
GetLockpick.Size = UDim2.new(0, 200, 0, 25)
GetLockpick.Font = Enum.Font.GothamBold
GetLockpick.Text = "Get a lockpick"
GetLockpick.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
GetLockpick.TextSize = 18

PlayerNameTP.Name = "PlayerNameTP"
PlayerNameTP.Parent = TeleportsFrame
PlayerNameTP.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
PlayerNameTP.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
PlayerNameTP.BorderSizePixel = 3
PlayerNameTP.Position = UDim2.new(0.561134338, 0, 0.285388649, 0)
PlayerNameTP.Size = UDim2.new(0, 173, 0, 26)
PlayerNameTP.Font = Enum.Font.GothamBold
PlayerNameTP.Text = ""
PlayerNameTP.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
PlayerNameTP.TextSize = 18
PlayerNameTP.TextWrapped = true

ToPlayer.Name = "ToPlayer"
ToPlayer.Parent = TeleportsFrame
ToPlayer.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
ToPlayer.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
ToPlayer.BorderSizePixel = 3
ToPlayer.Position = UDim2.new(0.537313402, 0, 0.400809765, 0)
ToPlayer.Size = UDim2.new(0, 200, 0, 31)
ToPlayer.Font = Enum.Font.GothamBold
ToPlayer.Text = "Teleport to Player"
ToPlayer.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
ToPlayer.TextSize = 18

TeleportScrolling.Name = "TeleportScrolling"
TeleportScrolling.Parent = TeleportsFrame
TeleportScrolling.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
TeleportScrolling.BorderSizePixel = 0
TeleportScrolling.Position = UDim2.new(0.0575306639, 0, 0.251042843, 0)
TeleportScrolling.Size = UDim2.new(0, 205, 0, 161)
TeleportScrolling.CanvasSize = UDim2.new(0, 0, 4, 0)

BankIn.Name = "BankIn"
BankIn.Parent = TeleportScrolling
BankIn.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
BankIn.BorderSizePixel = 0
BankIn.Position = UDim2.new(0.0869803801, 0, 0.00662878156, 0)
BankIn.Size = UDim2.new(0, 159, 0, 31)
BankIn.Font = Enum.Font.GothamBold
BankIn.Text = "Bank-in"
BankIn.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
BankIn.TextSize = 20

BankOut.Name = "BankOut"
BankOut.Parent = TeleportScrolling
BankOut.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
BankOut.BorderSizePixel = 0
BankOut.Position = UDim2.new(0.0869803801, 0, 0.0417045504, 0)
BankOut.Size = UDim2.new(0, 159, 0, 31)
BankOut.Font = Enum.Font.GothamBold
BankOut.Text = "Bank-out"
BankOut.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
BankOut.TextSize = 20

Food.Name = "Food"
Food.Parent = TeleportScrolling
Food.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
Food.BorderSizePixel = 0
Food.Position = UDim2.new(0.0869803801, 0, 0.0776515305, 0)
Food.Size = UDim2.new(0, 159, 0, 31)
Food.Font = Enum.Font.GothamBold
Food.Text = "Food2"
Food.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Food.TextSize = 20

Gunz1.Name = "Gunz1"
Gunz1.Parent = TeleportScrolling
Gunz1.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
Gunz1.BorderSizePixel = 0
Gunz1.Position = UDim2.new(0.0869803801, 0, 0.11363636, 0)
Gunz1.Size = UDim2.new(0, 159, 0, 31)
Gunz1.Font = Enum.Font.GothamBold
Gunz1.Text = "Gun Store 1"
Gunz1.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Gunz1.TextSize = 20

GunStore2.Name = "Gun Store 2"
GunStore2.Parent = TeleportScrolling
GunStore2.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
GunStore2.BorderSizePixel = 0
GunStore2.Position = UDim2.new(0.0869803801, 0, 0.150568187, 0)
GunStore2.Size = UDim2.new(0, 159, 0, 31)
GunStore2.Font = Enum.Font.GothamBold
GunStore2.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
GunStore2.TextSize = 20

KoolKlubEntrance.Name = "KoolKlubEntrance"
KoolKlubEntrance.Parent = TeleportScrolling
KoolKlubEntrance.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
KoolKlubEntrance.BorderSizePixel = 0
KoolKlubEntrance.Position = UDim2.new(0.0837854892, 0, 0.189393938, 0)
KoolKlubEntrance.Size = UDim2.new(0, 159, 0, 31)
KoolKlubEntrance.Font = Enum.Font.GothamBold
KoolKlubEntrance.Text = "Kool Klub"
KoolKlubEntrance.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
KoolKlubEntrance.TextSize = 20

Bathroom.Name = "Bathroom"
Bathroom.Parent = TeleportScrolling
Bathroom.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
Bathroom.BorderSizePixel = 0
Bathroom.Position = UDim2.new(0.0855456442, 0, 0.225378841, 0)
Bathroom.Size = UDim2.new(0, 159, 0, 31)
Bathroom.Font = Enum.Font.GothamBold
Bathroom.Text = "Bathroom"
Bathroom.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Bathroom.TextSize = 20

Boxing.Name = "Boxing"
Boxing.Parent = TeleportScrolling
Boxing.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
Boxing.BorderSizePixel = 0
Boxing.Position = UDim2.new(0.0855456442, 0, 0.262310594, 0)
Boxing.Size = UDim2.new(0, 159, 0, 31)
Boxing.Font = Enum.Font.GothamBold
Boxing.Text = "Boxing Arena "
Boxing.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Boxing.TextSize = 20

Food_2.Name = "Food"
Food_2.Parent = TeleportScrolling
Food_2.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
Food_2.BorderSizePixel = 0
Food_2.Position = UDim2.new(0.0855456442, 0, 0.300189465, 0)
Food_2.Size = UDim2.new(0, 159, 0, 31)
Food_2.Font = Enum.Font.GothamBold
Food_2.Text = "Food1"
Food_2.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Food_2.TextSize = 20

HoodFitness.Name = "HoodFitness"
HoodFitness.Parent = TeleportScrolling
HoodFitness.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
HoodFitness.BorderSizePixel = 0
HoodFitness.Position = UDim2.new(0.0855456442, 0, 0.338068217, 0)
HoodFitness.Size = UDim2.new(0, 159, 0, 31)
HoodFitness.Font = Enum.Font.GothamBold
HoodFitness.Text = "Hood Fitness"
HoodFitness.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
HoodFitness.TextSize = 20

HoodKicks.Name = "HoodKicks"
HoodKicks.Parent = TeleportScrolling
HoodKicks.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
HoodKicks.BorderSizePixel = 0
HoodKicks.Position = UDim2.new(0.0855456442, 0, 0.377840966, 0)
HoodKicks.Size = UDim2.new(0, 159, 0, 31)
HoodKicks.Font = Enum.Font.GothamBold
HoodKicks.Text = "Hood Kicks"
HoodKicks.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
HoodKicks.TextSize = 20

Hospital.Name = "Hospital"
Hospital.Parent = TeleportScrolling
Hospital.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
Hospital.BorderSizePixel = 0
Hospital.Position = UDim2.new(0.0823507607, 0, 0.414772719, 0)
Hospital.Size = UDim2.new(0, 159, 0, 31)
Hospital.Font = Enum.Font.GothamBold
Hospital.Text = "Hosiptal"
Hospital.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Hospital.TextSize = 20

Burger.Name = "Burger"
Burger.Parent = TeleportScrolling
Burger.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
Burger.BorderSizePixel = 0
Burger.Position = UDim2.new(0.0823507607, 0, 0.451704592, 0)
Burger.Size = UDim2.new(0, 159, 0, 31)
Burger.Font = Enum.Font.GothamBold
Burger.Text = "Burger Shack"
Burger.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Burger.TextSize = 20

Klips.Name = "Klips"
Klips.Parent = TeleportScrolling
Klips.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
Klips.BorderSizePixel = 0
Klips.Position = UDim2.new(0.0823507607, 0, 0.488636464, 0)
Klips.Size = UDim2.new(0, 159, 0, 31)
Klips.Font = Enum.Font.GothamBold
Klips.Text = "Klips"
Klips.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Klips.TextSize = 20

Phone.Name = "Phone"
Phone.Parent = TeleportScrolling
Phone.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
Phone.BorderSizePixel = 0
Phone.Position = UDim2.new(0.0823507607, 0, 0.524621308, 0)
Phone.Size = UDim2.new(0, 159, 0, 31)
Phone.Font = Enum.Font.GothamBold
Phone.Text = "Phone Store"
Phone.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Phone.TextSize = 20

PoliceStation.Name = "PoliceStation"
PoliceStation.Parent = TeleportScrolling
PoliceStation.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
PoliceStation.BorderSizePixel = 0
PoliceStation.Position = UDim2.new(0.0823507607, 0, 0.595644057, 0)
PoliceStation.Size = UDim2.new(0, 159, 0, 31)
PoliceStation.Font = Enum.Font.GothamBold
PoliceStation.Text = "Police Station"
PoliceStation.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
PoliceStation.TextSize = 20

Pit.Name = "Pit"
Pit.Parent = TeleportScrolling
Pit.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
Pit.BorderSizePixel = 0
Pit.Position = UDim2.new(0.0823507607, 0, 0.559659183, 0)
Pit.Size = UDim2.new(0, 159, 0, 31)
Pit.Font = Enum.Font.GothamBold
Pit.Text = "The Pit"
Pit.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Pit.TextSize = 20

EvilBase.Name = "EvilBase"
EvilBase.Parent = TeleportScrolling
EvilBase.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
EvilBase.BorderSizePixel = 0
EvilBase.Position = UDim2.new(0.0823507607, 0, 0.668560684, 0)
EvilBase.Size = UDim2.new(0, 159, 0, 31)
EvilBase.Font = Enum.Font.GothamBold
EvilBase.Text = "Evil Base"
EvilBase.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
EvilBase.TextSize = 20

BankVault.Name = "BankVault"
BankVault.Parent = TeleportScrolling
BankVault.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
BankVault.BorderSizePixel = 0
BankVault.Position = UDim2.new(0.0823507607, 0, 0.703598559, 0)
BankVault.Size = UDim2.new(0, 159, 0, 31)
BankVault.Font = Enum.Font.GothamBold
BankVault.Text = "Bank-Vault"
BankVault.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
BankVault.TextSize = 20

TacoJeff.Name = "TacoJeff"
TacoJeff.Parent = TeleportScrolling
TacoJeff.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
TacoJeff.BorderSizePixel = 0
TacoJeff.Position = UDim2.new(0.0823507607, 0, 0.63257587, 0)
TacoJeff.Size = UDim2.new(0, 159, 0, 31)
TacoJeff.Font = Enum.Font.GothamBold
TacoJeff.Text = "Taco Shop"
TacoJeff.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
TacoJeff.TextSize = 20

Quickbuy.Name = "Quickbuy"
Quickbuy.Parent = MainGUI
Quickbuy.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
Quickbuy.BorderSizePixel = 0
Quickbuy.Position = UDim2.new(0.782359123, 0, 0.915481329, 0)
Quickbuy.Size = UDim2.new(0, 256, 0, 294)
Quickbuy.Visible = false

TopFrame.Name = "TopFrame"
TopFrame.Parent = Quickbuy
TopFrame.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
TopFrame.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
TopFrame.BorderSizePixel = 0
TopFrame.Position = UDim2.new(0, 0, -0.095238097, 0)
TopFrame.Size = UDim2.new(0, 256, 0, 28)

BottomFrame_2.Name = "BottomFrame"
BottomFrame_2.Parent = Quickbuy
BottomFrame_2.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
BottomFrame_2.BorderSizePixel = 0
BottomFrame_2.Position = UDim2.new(0, 0, 1, 0)
BottomFrame_2.Size = UDim2.new(0, 256, 0, 12)

Title_2.Name = "Title"
Title_2.Parent = Quickbuy
Title_2.BackgroundColor3 = Color3.new(1, 1, 1)
Title_2.BackgroundTransparency = 1
Title_2.Position = UDim2.new(0.0641260147, 0, -0.0884353742, 0)
Title_2.Size = UDim2.new(0, 218, 0, 28)
Title_2.Font = Enum.Font.GothamBold
Title_2.Text = "Quick Buy"
Title_2.TextColor3 = Color3.new(0.129412, 0.129412, 0.129412)
Title_2.TextScaled = true
Title_2.TextSize = 14
Title_2.TextWrapped = true

ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Parent = Quickbuy
ScrollFrame.Active = true
ScrollFrame.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
ScrollFrame.BorderSizePixel = 0
ScrollFrame.Position = UDim2.new(0, 0, 0.142857134, 0)
ScrollFrame.Size = UDim2.new(0, 256, 0, 170)

Glock.Name = "[Glock]"
Glock.Parent = ScrollFrame
Glock.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Glock.BorderSizePixel = 0
Glock.Position = UDim2.new(0.10546875, 0, 0.0232478306, 0)
Glock.Size = UDim2.new(0, 200, 0, 35)
Glock.Font = Enum.Font.GothamBold
Glock.Text = "Glock"
Glock.TextColor3 = Color3.new(0.117647, 0.117647, 0.117647)
Glock.TextSize = 24

Shotgun.Name = "[Shotgun]"
Shotgun.Parent = ScrollFrame
Shotgun.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Shotgun.BorderSizePixel = 0
Shotgun.Position = UDim2.new(0.109375, 0, 0.162703604, 0)
Shotgun.Size = UDim2.new(0, 200, 0, 35)
Shotgun.Font = Enum.Font.GothamBold
Shotgun.Text = "Shotgun"
Shotgun.TextColor3 = Color3.new(0.117647, 0.117647, 0.117647)
Shotgun.TextSize = 24

SMG.Name = "[SMG]"
SMG.Parent = ScrollFrame
SMG.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
SMG.BorderSizePixel = 0
SMG.Position = UDim2.new(0.109375, 0, 0.232431501, 0)
SMG.Size = UDim2.new(0, 200, 0, 35)
SMG.Font = Enum.Font.GothamBold
SMG.Text = "SMG"
SMG.TextColor3 = Color3.new(0.117647, 0.117647, 0.117647)
SMG.TextSize = 24

AR.Name = "[AR]"
AR.Parent = ScrollFrame
AR.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
AR.BorderSizePixel = 0
AR.Position = UDim2.new(0.109375, 0, 0.302159369, 0)
AR.Size = UDim2.new(0, 200, 0, 35)
AR.Font = Enum.Font.GothamBold
AR.Text = "AR"
AR.TextColor3 = Color3.new(0.117647, 0.117647, 0.117647)
AR.TextSize = 24

RPG.Name = "[RPG]"
RPG.Parent = ScrollFrame
RPG.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
RPG.BorderSizePixel = 0
RPG.Position = UDim2.new(0.109375, 0, 0.371887267, 0)
RPG.Size = UDim2.new(0, 200, 0, 35)
RPG.Font = Enum.Font.GothamBold
RPG.Text = "RPG"
RPG.TextColor3 = Color3.new(0.117647, 0.117647, 0.117647)
RPG.TextSize = 24

Revolver.Name = "[Revolver]"
Revolver.Parent = ScrollFrame
Revolver.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Revolver.BorderSizePixel = 0
Revolver.Position = UDim2.new(0.10546875, 0, 0.57937026, 0)
Revolver.Size = UDim2.new(0, 200, 0, 35)
Revolver.Font = Enum.Font.GothamBold
Revolver.Text = "Revolver"
Revolver.TextColor3 = Color3.new(0.117647, 0.117647, 0.117647)
Revolver.TextSize = 24

SilencerAR.Name = "[SilencerAR]"
SilencerAR.Parent = ScrollFrame
SilencerAR.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
SilencerAR.BorderSizePixel = 0
SilencerAR.Position = UDim2.new(0.10546875, 0, 0.509642363, 0)
SilencerAR.Size = UDim2.new(0, 200, 0, 35)
SilencerAR.Font = Enum.Font.GothamBold
SilencerAR.Text = "Silenced AR"
SilencerAR.TextColor3 = Color3.new(0.117647, 0.117647, 0.117647)
SilencerAR.TextSize = 24

P90.Name = "[P90]"
P90.Parent = ScrollFrame
P90.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
P90.BorderSizePixel = 0
P90.Position = UDim2.new(0.10546875, 0, 0.439914495, 0)
P90.Size = UDim2.new(0, 200, 0, 35)
P90.Font = Enum.Font.GothamBold
P90.Text = "P90"
P90.TextColor3 = Color3.new(0.117647, 0.117647, 0.117647)
P90.TextSize = 24

DrumGun.Name = "[DrumGun]"
DrumGun.Parent = ScrollFrame
DrumGun.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
DrumGun.BorderSizePixel = 0
DrumGun.Position = UDim2.new(0.10546875, 0, 0.786853254, 0)
DrumGun.Size = UDim2.new(0, 200, 0, 35)
DrumGun.Font = Enum.Font.GothamBold
DrumGun.Text = "Drum Gun"
DrumGun.TextColor3 = Color3.new(0.117647, 0.117647, 0.117647)
DrumGun.TextSize = 24

TacticalShotgun.Name = "[TacticalShotgun]"
TacticalShotgun.Parent = ScrollFrame
TacticalShotgun.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
TacticalShotgun.BorderSizePixel = 0
TacticalShotgun.Position = UDim2.new(0.10546875, 0, 0.717125356, 0)
TacticalShotgun.Size = UDim2.new(0, 200, 0, 35)
TacticalShotgun.Font = Enum.Font.GothamBold
TacticalShotgun.Text = "Tactical Shotgun"
TacticalShotgun.TextColor3 = Color3.new(0.117647, 0.117647, 0.117647)
TacticalShotgun.TextSize = 24

AK47.Name = "[AK47]"
AK47.Parent = ScrollFrame
AK47.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
AK47.BorderSizePixel = 0
AK47.Position = UDim2.new(0.10546875, 0, 0.647397518, 0)
AK47.Size = UDim2.new(0, 200, 0, 35)
AK47.Font = Enum.Font.GothamBold
AK47.Text = "AK47"
AK47.TextColor3 = Color3.new(0.117647, 0.117647, 0.117647)
AK47.TextSize = 24

Flamethrower.Name = "[Flamethrower]"
Flamethrower.Parent = ScrollFrame
Flamethrower.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Flamethrower.BorderSizePixel = 0
Flamethrower.Position = UDim2.new(0.104999997, 0, 0.855000019, 0)
Flamethrower.Size = UDim2.new(0, 200, 0, 35)
Flamethrower.Font = Enum.Font.GothamBold
Flamethrower.Text = "Flamethrower"
Flamethrower.TextColor3 = Color3.new(0.117647, 0.117647, 0.117647)
Flamethrower.TextSize = 24

AUG.Name = "[AUG]"
AUG.Parent = ScrollFrame
AUG.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
AUG.BorderSizePixel = 0
AUG.Position = UDim2.new(0.104999997, 0, 0.924727917, 0)
AUG.Size = UDim2.new(0, 200, 0, 35)
AUG.Font = Enum.Font.GothamBold
AUG.Text = "AUG"
AUG.TextColor3 = Color3.new(0.117647, 0.117647, 0.117647)
AUG.TextSize = 24

Silencer.Name = "[Silencer]"
Silencer.Parent = ScrollFrame
Silencer.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Silencer.BorderSizePixel = 0
Silencer.Position = UDim2.new(0.10546875, 0, 0.0929757208, 0)
Silencer.Size = UDim2.new(0, 200, 0, 35)
Silencer.Font = Enum.Font.GothamBold
Silencer.Text = "Silencer"
Silencer.TextColor3 = Color3.new(0.117647, 0.117647, 0.117647)
Silencer.TextSize = 24

AUG_2.Name = "[AUG]"
AUG_2.Parent = ScrollFrame
AUG_2.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
AUG_2.BorderSizePixel = 0
AUG_2.Position = UDim2.new(0.108906247, 0, 0.999557853, 0)
AUG_2.Size = UDim2.new(0, 200, 0, 35)
AUG_2.Font = Enum.Font.GothamBold
AUG_2.Text = "AUG"
AUG_2.TextColor3 = Color3.new(0.117647, 0.117647, 0.117647)
AUG_2.TextSize = 24

CloseQuickbuy.Name = "CloseQuickbuy"
CloseQuickbuy.Parent = Quickbuy
CloseQuickbuy.BackgroundColor3 = Color3.new(1, 0, 0)
CloseQuickbuy.BackgroundTransparency = 1
CloseQuickbuy.BorderSizePixel = 0
CloseQuickbuy.Position = UDim2.new(0.776864529, 0, -0.0860389024, 0)
CloseQuickbuy.Size = UDim2.new(0, 50, 0, 22)
CloseQuickbuy.Font = Enum.Font.SourceSans
CloseQuickbuy.Text = ""
CloseQuickbuy.TextColor3 = Color3.new(0.129412, 0.129412, 0.129412)
CloseQuickbuy.TextScaled = true
CloseQuickbuy.TextSize = 14
CloseQuickbuy.TextWrapped = true

CloseX_Roundify_12px_2.Name = "CloseX_Roundify_12px"
CloseX_Roundify_12px_2.Parent = CloseQuickbuy
CloseX_Roundify_12px_2.Active = true
CloseX_Roundify_12px_2.AnchorPoint = Vector2.new(0.5, 0.5)
CloseX_Roundify_12px_2.BackgroundColor3 = Color3.new(1, 1, 1)
CloseX_Roundify_12px_2.BackgroundTransparency = 1
CloseX_Roundify_12px_2.Position = UDim2.new(0.730000019, 0, 0.5, 0)
CloseX_Roundify_12px_2.Selectable = true
CloseX_Roundify_12px_2.Size = UDim2.new(0.540000021, 0, 1, 0)
CloseX_Roundify_12px_2.Image = "rbxassetid://3570695787"
CloseX_Roundify_12px_2.ImageColor3 = Color3.new(0.901961, 0, 0)
CloseX_Roundify_12px_2.ScaleType = Enum.ScaleType.Slice
CloseX_Roundify_12px_2.SliceCenter = Rect.new(100, 100, 100, 100)

XText_2.Name = "XText"
XText_2.Parent = CloseX_Roundify_12px_2
XText_2.BackgroundColor3 = Color3.new(1, 1, 1)
XText_2.BackgroundTransparency = 1
XText_2.Position = UDim2.new(0, 0, 0.13636364, 0)
XText_2.Size = UDim2.new(0, 27, 0, 16)
XText_2.Font = Enum.Font.GothamBold
XText_2.Text = "X"
XText_2.TextColor3 = Color3.new(0, 0, 0)
XText_2.TextScaled = true
XText_2.TextSize = 14
XText_2.TextWrapped = true

BuyAmmo.Name = "BuyAmmo"
BuyAmmo.Parent = Quickbuy
BuyAmmo.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
BuyAmmo.BorderColor3 = Color3.new(0.129412, 0.129412, 0.129412)
BuyAmmo.BorderSizePixel = 3
BuyAmmo.Position = UDim2.new(0.23062849, 0, 0.884151459, 0)
BuyAmmo.Size = UDim2.new(0, 134, 0, 24)
BuyAmmo.Font = Enum.Font.GothamBold
BuyAmmo.Text = "Buy Gun"
BuyAmmo.TextColor3 = Color3.new(0.129412, 0.129412, 0.129412)
BuyAmmo.TextSize = 25
BuyAmmo.TextWrapped = true

BuyGun.Name = "BuyGun"
BuyGun.Parent = Quickbuy
BuyGun.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
BuyGun.BorderColor3 = Color3.new(0.129412, 0.129412, 0.129412)
BuyGun.BorderSizePixel = 3
BuyGun.Position = UDim2.new(0.23453474, 0, 0.764842272, 0)
BuyGun.Size = UDim2.new(0, 134, 0, 24)
BuyGun.Font = Enum.Font.GothamBold
BuyGun.Text = "Buy Ammo"
BuyGun.TextColor3 = Color3.new(0.129412, 0.129412, 0.129412)
BuyGun.TextSize = 25
BuyGun.TextWrapped = true

SelectedGunLabel.Name = "SelectedGunLabel"
SelectedGunLabel.Parent = Quickbuy
SelectedGunLabel.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
SelectedGunLabel.BackgroundTransparency = 1.0700000524521
SelectedGunLabel.Position = UDim2.new(0.1015625, 0, 0.0340136066, 0)
SelectedGunLabel.Size = UDim2.new(0, 204, 0, 32)
SelectedGunLabel.Font = Enum.Font.GothamBold
SelectedGunLabel.Text = "Selected Gun: Nil"
SelectedGunLabel.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
SelectedGunLabel.TextSize = 17

Keybinds.Name = "Keybinds"
Keybinds.Parent = MainGUI
Keybinds.Active = true
Keybinds.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
Keybinds.BorderSizePixel = 0
Keybinds.Position = UDim2.new(0.123339638, 0, 0.499473125, 0)
Keybinds.Size = UDim2.new(0, 228, 0, 270)
Keybinds.Visible = false
Keybinds.ZIndex = 5

Top.Name = "Top"
Top.Parent = Keybinds
Top.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Top.BorderSizePixel = 0
Top.Size = UDim2.new(0, 228, 0, 34)
Top.ZIndex = 6

Title_3.Name = "Title"
Title_3.Parent = Top
Title_3.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Title_3.BackgroundTransparency = 1
Title_3.BorderSizePixel = 0
Title_3.Position = UDim2.new(0.138752982, 0, 0.107143626, 0)
Title_3.Size = UDim2.new(0, 164, 0, 30)
Title_3.ZIndex = 6
Title_3.Font = Enum.Font.GothamBold
Title_3.Text = "Key Binds"
Title_3.TextColor3 = Color3.new(0.129412, 0.129412, 0.129412)
Title_3.TextScaled = true
Title_3.TextSize = 14
Title_3.TextTransparency = -2
Title_3.TextWrapped = true

Bottom.Name = "Bottom"
Bottom.Parent = Keybinds
Bottom.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
Bottom.BorderSizePixel = 0
Bottom.Position = UDim2.new(0, 0, 0.896296322, 0)
Bottom.Size = UDim2.new(0, 228, 0, 28)
Bottom.ZIndex = 6

FlyKB.Name = "FlyKB"
FlyKB.Parent = Keybinds
FlyKB.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
FlyKB.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
FlyKB.BorderSizePixel = 3
FlyKB.Position = UDim2.new(0.0964912251, 0, 0.181481481, 0)
FlyKB.Size = UDim2.new(0, 137, 0, 26)
FlyKB.ZIndex = 6
FlyKB.Font = Enum.Font.GothamBold
FlyKB.Text = "Fly"
FlyKB.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
FlyKB.TextSize = 20
FlyKB.TextWrapped = true

WsKB.Name = "WsKB"
WsKB.Parent = Keybinds
WsKB.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
WsKB.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
WsKB.BorderSizePixel = 3
WsKB.Position = UDim2.new(0.0964912251, 0, 0.353051543, 0)
WsKB.Size = UDim2.new(0, 137, 0, 26)
WsKB.ZIndex = 6
WsKB.Font = Enum.Font.GothamBold
WsKB.Text = "Walkspeed"
WsKB.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
WsKB.TextSize = 20
WsKB.TextWrapped = true

JpKB.Name = "JpKB"
JpKB.Parent = Keybinds
JpKB.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
JpKB.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
JpKB.BorderSizePixel = 3
JpKB.Position = UDim2.new(0.0964912251, 0, 0.529136598, 0)
JpKB.Size = UDim2.new(0, 137, 0, 26)
JpKB.ZIndex = 6
JpKB.Font = Enum.Font.GothamBold
JpKB.Text = "Jump Power"
JpKB.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
JpKB.TextSize = 20
JpKB.TextWrapped = true

NcKB.Name = "NcKB"
NcKB.Parent = Keybinds
NcKB.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
NcKB.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
NcKB.BorderSizePixel = 3
NcKB.Position = UDim2.new(0.0964912251, 0, 0.700706661, 0)
NcKB.Size = UDim2.new(0, 137, 0, 26)
NcKB.ZIndex = 6
NcKB.Font = Enum.Font.GothamBold
NcKB.Text = "Noclip"
NcKB.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
NcKB.TextSize = 20
NcKB.TextWrapped = true

FlyInputKeybind.Name = "FlyInputKeybind"
FlyInputKeybind.Parent = Keybinds
FlyInputKeybind.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
FlyInputKeybind.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
FlyInputKeybind.BorderSizePixel = 4
FlyInputKeybind.Position = UDim2.new(0.767543972, 0, 0.181481481, 0)
FlyInputKeybind.Size = UDim2.new(0, 30, 0, 26)
FlyInputKeybind.ZIndex = 6
FlyInputKeybind.Font = Enum.Font.GothamBold
FlyInputKeybind.Text = "K"
FlyInputKeybind.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
FlyInputKeybind.TextSize = 14
FlyInputKeybind.TextWrapped = true

WalkspeedInputKeybind.Name = "WalkspeedInputKeybind"
WalkspeedInputKeybind.Parent = Keybinds
WalkspeedInputKeybind.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
WalkspeedInputKeybind.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
WalkspeedInputKeybind.BorderSizePixel = 4
WalkspeedInputKeybind.Position = UDim2.new(0.767543972, 0, 0.353051543, 0)
WalkspeedInputKeybind.Size = UDim2.new(0, 30, 0, 26)
WalkspeedInputKeybind.ZIndex = 6
WalkspeedInputKeybind.Font = Enum.Font.GothamBold
WalkspeedInputKeybind.Text = "L"
WalkspeedInputKeybind.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
WalkspeedInputKeybind.TextSize = 14
WalkspeedInputKeybind.TextWrapped = true

NoclipInputKeybind.Name = "NoclipInputKeybind"
NoclipInputKeybind.Parent = Keybinds
NoclipInputKeybind.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
NoclipInputKeybind.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
NoclipInputKeybind.BorderSizePixel = 4
NoclipInputKeybind.Position = UDim2.new(0.767543972, 0, 0.700706661, 0)
NoclipInputKeybind.Size = UDim2.new(0, 30, 0, 26)
NoclipInputKeybind.ZIndex = 6
NoclipInputKeybind.Font = Enum.Font.GothamBold
NoclipInputKeybind.Text = "P"
NoclipInputKeybind.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
NoclipInputKeybind.TextSize = 14
NoclipInputKeybind.TextWrapped = true

JumppowerInputKeybind.Name = "JumppowerInputKeybind"
JumppowerInputKeybind.Parent = Keybinds
JumppowerInputKeybind.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
JumppowerInputKeybind.BorderColor3 = Color3.new(0.278431, 0.278431, 0.278431)
JumppowerInputKeybind.BorderSizePixel = 4
JumppowerInputKeybind.Position = UDim2.new(0.767543972, 0, 0.529136598, 0)
JumppowerInputKeybind.Size = UDim2.new(0, 30, 0, 26)
JumppowerInputKeybind.ZIndex = 6
JumppowerInputKeybind.Font = Enum.Font.GothamBold
JumppowerInputKeybind.Text = "J"
JumppowerInputKeybind.TextColor3 = Color3.new(0.278431, 0.278431, 0.278431)
JumppowerInputKeybind.TextSize = 14
JumppowerInputKeybind.TextWrapped = true

SaveAndExit.Name = "SaveAndExit"
SaveAndExit.Parent = Keybinds
SaveAndExit.BackgroundColor3 = Color3.new(0.278431, 0.278431, 0.278431)
SaveAndExit.BorderSizePixel = 0
SaveAndExit.Position = UDim2.new(0.171280846, 0, 0.91026926, 0)
SaveAndExit.Size = UDim2.new(0, 148, 0, 19)
SaveAndExit.ZIndex = 6
SaveAndExit.Font = Enum.Font.GothamBold
SaveAndExit.Text = "Save & Exit"
SaveAndExit.TextColor3 = Color3.new(0.129412, 0.129412, 0.129412)
SaveAndExit.TextSize = 25
SaveAndExit.TextWrapped = true
-- Scripts:


local ESPToggleInstance = Instance.new("BoolValue", workspace)
ESPToggleInstance.Name = "ESPToggle"
ESPToggleInstance.Value = false

local gmt = getrawmetatable(game)
setreadonly(gmt, false)
local old = gmt.__namecall
gmt.__namecall = newcclosure(function(self,...)
    local args = {...}

    if self.Name == 'MainEvent' and tostring(args[1]) == 'TeleportDetect' then
        return
    end
    return old(self,...)
end)

local OGQuickBuyPos = UDim2.new(0.709, 0,22, 0)
local FirstQuickBuyPos = UDim2.new(0.028, 0,0.375, 0)

function Visibility(bool,tbl)
    for i,v in pairs(tbl) do
        v.Visible = bool
    end
end

MainFrame.Active = true
MainFrame.Draggable = true

Quickbuy.Active = true
Quickbuy.Draggable = true

JumpPower.TextColor3 = Color3.new(1, 0, 0)
Speed.TextColor3 = Color3.new(1, 0, 0)
AutoEat.TextColor3 = Color3.new(1, 0, 0)
AutoBlock.TextColor3 = Color3.new(1, 0, 0)
Noclip.TextColor3 = Color3.new(1, 0, 0)
FlyBtn.TextColor3 = Color3.new(1, 0, 0)
NoMovementLimits.TextColor3 = Color3.new(1, 0, 0)
NoGunLoss.TextColor3 = Color3.new(1, 0, 0)
HospitalFarm.TextColor3 = Color3.new(1, 0, 0)
ESPPlayers.TextColor3 = Color3.new(1, 0, 0)
AutoRob.TextColor3 = Color3.new(1, 0, 0)
GodMode.TextColor3 = Color3.new(1, 0, 0)
SilentAim.TextColor3 = Color3.new(1, 0, 0)
GodBlock.TextColor3 = Color3.new(1, 0, 0)
AutoStomp.TextColor3 = Color3.new(1, 0, 0)
AutoReload.TextColor3 = Color3.new(1, 0, 0)
Reach.TextColor3 = Color3.new(1, 0, 0)
NoRecoil.TextColor3 = Color3.new(1, 0 , 0)
P90Farm.TextColor3 = Color3.new(1, 0, 0)
FullGod.TextColor3 = Color3.new(1, 0, 0)
InvisibleMask.TextColor3 = Color3.new(1, 0, 0)
FreezeBullets.TextColor3 = Color3.new(1, 0, 0)

for _,instance in pairs(ScrollFrame:GetChildren()) do
    instance.ZIndex = 10
end

game.Players.LocalPlayer:WaitForChild("DataFolder")
game.Players.LocalPlayer.DataFolder:WaitForChild("Information")

_G.QTP = false
_G.FreezeBullets = false
_G.farmGlobals = {
    ["targetCashier"] = nil,
    ["currentWeapon"] = nil,
    ["casherPosition"] = Vector3.new(0,0,0),
    ["lastPickup"] = Vector3.new(0,0,0)
}
_G.Keybinds = {
    [FlyInputKeybind.Text:lower()] = function()
        firesignal(FlyBtn.MouseButton1Down)
    end,
    [NoclipInputKeybind.Text:lower()] = function()
        firesignal(Noclip.MouseButton1Down)
    end,
    [JumppowerInputKeybind.Text:lower()] = function()
        if _G.JPE == false then
            _G.JPE = true
            JumpPower.TextColor3 = Color3.new(0,1,0)
            local player = game.Players.LocalPlayer
            local character = player.Character
            local bodyeffects_folder = character:WaitForChild("BodyEffects")
            t = Instance.new("BoolValue")
            t.Parent = bodyeffects_folder.Movement
            t.Value = true
            t.Name = "HulkJump"
        elseif _G.JPE == true then
            _G.JPE = false
            wait()
            JumpPower.TextColor3 = Color3.new(1, 0, 0)
            local nameme = tostring(game.Players.LocalPlayer.Name)
            if game.Workspace.Players:FindFirstChild(nameme):FindFirstChild("BodyEffects").Movement:FindFirstChild("HulkJump") then
                game.Workspace.Players:FindFirstChild(nameme):FindFirstChild("BodyEffects").Movement:FindFirstChild("HulkJump"):Destroy()
            end
        end
    end,
    [WalkspeedInputKeybind.Text:lower()] = function()
        if _G.WSE == false then
            _G.WSE = true
            Speed.TextColor3 = Color3.new(0,1,0)
            local player = game.Players.LocalPlayer
            local character = player.Character
            local bodyeffects_folder = character:WaitForChild("BodyEffects")
            t = Instance.new("BoolValue")
            t.Parent = bodyeffects_folder.Movement
            t.Value = true
            t.Name = "SuperSpeed"
        elseif _G.WSE == true then
            _G.WSE = false
            wait()
            Speed.TextColor3 = Color3.new(1, 0, 0)
            local nameme = tostring(game.Players.LocalPlayer.Name)
            if game.Workspace.Players:FindFirstChild(nameme):FindFirstChild("BodyEffects").Movement:FindFirstChild("SuperSpeed") then
                game.Workspace.Players:FindFirstChild(nameme):FindFirstChild("BodyEffects").Movement:FindFirstChild("SuperSpeed"):Destroy()
            end
        end
    end
}

_G.InvisibleMask = false
_G.CurrentNameGunFly = nil
_G.AutoStomp = false
_G.FullGod = false
_G.BoomBreak = false
_G.NML = false
_G.NGL = false
_G.FLYINGON = false
_G.MSPEED = 100
_G.FSPEED = 5
_G.FLYING = false
_G.XXXXX = false
_G.PutDownKey = "g"
_G.NoRecoil = false
_G.nomask = true
_G.WSKey = nil
_G.TPMOSTKey = nil
_G.JPKey = nil
_G.Found = nil
_G.NeverDone = nil
_G.NOCLIPKey = nil
_G.NoClipToggle = false
_G.Hospital = false
_G.MovementLims = false
_G.AutoRobToggle = false
_G.ShoeAuto = false
_G.SetHealth = 50
_G.BackHealth = 90
_G.GotSetHealth = false
_G.BodyEffectsDiedOnce = false
_G.DiedFunctionOnce = false
_G.ExecutedAutoeat = false
_G.WSE = false
_G.JPE = false
_G.FocusedGun = ""
_G.FocusedAmmo = ""
_G.AutoBlockToggle = false
_G.SilentAimRad = 45
_G.Minus = 60
_G.PlayerLocked = nil
_G.ReachToggle = false
_G.P90FarmToggle = false
_G.AEFirst = false
_G.AutoEat = false
_G.EatModule = {
    ["Eating"] = false,
    ["OldBuyPosition"] = nil,
    ["OldPosition"] = nil,
    ["ReturningHealth"] = 90,
    ["StartHealth"] = 70,
    ["Running"] = false
}

_G.Shift = false
_G.GodModeEnabled = false
_G.AutoReloadEnabled = false
_G.SilentAimEnabled = false
_G.silentaimwhitelist = {["fuckerherrightinthepussy"] = true}
_G.AutoBuyKey = false
_G.GodBlock = false
_G.LastPickupPos = Vector3.new(0,0,0)
if game.Players.LocalPlayer.DataFolder.Information:FindFirstChild("REPORT_TIMES") then
    _G.Reports = game.Players.LocalPlayer.DataFolder.Information:FindFirstChild("REPORT_TIMES").Value
else
    _G.Reports = nil
end
oldPos = CFrame.new(0,0,0)
platePos = CFrame.new(0,-100,0)
foodTable = {"[Pizza]", "[Taco]", "[Chicken]", "[Donut]"}

btns = {}

-- [[ Functions ]] --

function onshiftdown(inputObject,gameProcessed)
    if inputObject.KeyCode == Enum.KeyCode.LeftShift then
        _G.Shift = true
    end
end

function onshiftrelease(inputObject,gameProcessed)
    if inputObject.KeyCode == Enum.KeyCode.LeftShift then
        _G.Shift = false
    end
end

game:GetService("UserInputService").InputBegan:connect(onshiftdown)
game:GetService("UserInputService").InputEnded:connect(onshiftrelease)

game:GetService("RunService").Stepped:Connect(function()
    if _G.AutoStomp then
        game.ReplicatedStorage.MainEvent:FireServer("Stomp")
    end
end)

if _G.Reports ~= nil then
    game.Players.LocalPlayer.DataFolder.Information:FindFirstChild("REPORT_TIMES").Changed:Connect(function()
        if game.Players.LocalPlayer.DataFolder.Information:FindFirstChild("REPORT_TIMES").Value ~= _G.Reports then
            local newStr, replaced = string.gsub(string.gsub(game.Players.LocalPlayer.DataFolder.Information:FindFirstChild("REPORT_TIMES").Value, _G.Reports, ""),",","")
            game.StarterGui:SetCore("SendNotification", {
                Title = "Jump'd Report Alert";
                Text = newStr.." has reported you.";
                Duration = 10;
            })
            _G.Reports = game.Players.LocalPlayer.DataFolder.Information:FindFirstChild("REPORT_TIMES").Value
        end
    end)
else
    game.Players.LocalPlayer.DataFolder.Information.ChildAdded:Connect(function(Child)
        if Child.Name == "REPORT_TIMES" then
            _G.Reports = game.Players.LocalPlayer.DataFolder.Information:FindFirstChild("REPORT_TIMES").Value
            local newStr, replaced = string.gsub(string.gsub(game.Players.LocalPlayer.DataFolder.Information:FindFirstChild("REPORT_TIMES").Value, _G.Reports, ""),",","")
            game.StarterGui:SetCore("SendNotification", {
                Title = "Jump'd Report Alert";
                Text = newStr.." has reported you.";
                Duration = 10;
            })
            game.Players.LocalPlayer.DataFolder.Information:FindFirstChild("REPORT_TIMES").Changed:Connect(function()
                if game.Players.LocalPlayer.DataFolder.Information:FindFirstChild("REPORT_TIMES").Value ~= _G.Reports then
                    local newStr, replaced = string.gsub(string.gsub(game.Players.LocalPlayer.DataFolder.Information:FindFirstChild("REPORT_TIMES").Value, _G.Reports, ""),",","")
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "Jump'd Report Alert";
                        Text = newStr.." has reported you.";
                        Duration = 10;
                    })
                    _G.Reports = game.Players.LocalPlayer.DataFolder.Information:FindFirstChild("REPORT_TIMES").Value
                end
            end)
        end
    end)
end

function addComas(str)
    return #str % 3 == 0 and str:reverse():gsub("(%d%d%d)", "%1,"):reverse():sub(2) or str:reverse():gsub("(%d%d%d)", "%1,"):reverse()
end

function closeandopen(closedforhowlong)
    delay(0,function()
        fadeout()
    end)
    delay(0.35,function()
        MainFrame:TweenSize(UDim2.new(0, 538, 0, 34), "Out", "Quint",0.5,false,function() wait(closedforhowlong); MainFrame:TweenSize(UDim2.new(0, 538, 0, 264), "Out", "Quint",0.55,false,function() wait(); fadein() end) end)
    end)
end

function getIndexByValue(Table, Value)
    for index,value in pairs(Table) do
        if value == Value then
            return index
        end
    end
end

function fadeout(backin, when)
    local btn = PlayerBtn
    btns = (function()
        local Tbl = {}
        local Ttp = {}
        local Bgtp = {}
        local Itp = {}
        for i,v in pairs(MainFrame:GetDescendants()) do
            if v.ClassName == "TextButton" or v.ClassName == "TextLabel" or v.ClassName == "TextBox" or v.ClassName == "ScrollingFrame" then
                if v.Name == "CloseX" then
                    table.insert(Ttp,v["CloseX_Roundify_12px"]["XText"])
                    table.insert(Itp,v["CloseX_Roundify_12px"])
                else
                    table.insert(Ttp,v)
                end
            elseif v.ClassName == "Frame" then
                if v.Name == "HomeFrame" or v.Name == "PlayerFrame" or v.Name == "SettingsFrame" or v.Name == "GlobalFrame" or v.Name == "TeleportsFrame" then
                    table.insert(Bgtp,v)
                end
            end
        end
        table.insert(Tbl,Ttp)
        table.insert(Tbl,Itp)
        table.insert(Tbl,Bgtp)
        return Tbl
    end)()

    for i=1,10 do wait()
        delay(0,function()
            for _,button in pairs(btns[1]) do
                if button:IsA("ScrollingFrame") then
                    button.ScrollBarThickness = 0
                    button.BackgroundTransparency = i
                else
                    button.TextTransparency = i/10
                    button.BackgroundTransparency = i/10
                    btns[2][1]:FindFirstChild("XText").BackgroundTransparency = 1
                    btns[2][1].Parent.BackgroundTransparency = 1
                end
            end
        end)
        delay(0,function()
            for _,button in pairs(btns[2]) do
                button.ImageTransparency = i/10
            end
        end)
        delay(0,function()
            for _,button in pairs(btns[3]) do
                button.BackgroundTransparency = 1
            end
        end)
    end
    if backin == true then
        wait(when)
        fadein()
    end
end

function fadein()
    local Rev = (function()
        local ReturningTable = {}
        for i = 2,11 do 
            if i == 1 then
                local i = 10
                table.insert(ReturningTable, "0."..tostring(i))
            elseif i > 1 then
                i = 10 - (i - 1)
                table.insert(ReturningTable, "0."..tostring(i))
            end
        end
        return ReturningTable
    end)()

    for x,z in pairs(Rev) do wait()
        local i = tonumber(z)
        delay(0,function()
            for _,button in pairs(btns[1]) do
                if button:IsA("ScrollingFrame") then
                    button.ScrollBarThickness = 12
                    button.BackgroundTransparency = i
                else
                    button.TextTransparency = i
                    button.BackgroundTransparency = i
                    btns[2][1]:FindFirstChild("XText").BackgroundTransparency = 1
                    btns[2][1].Parent.BackgroundTransparency = 1
                end
            end
        end)
        delay(0,function()
            btns[2][1].ImageTransparency = i
            btns[2][1]:FindFirstChild("XText").BackgroundTransparency = 1
            btns[2][1].Parent.BackgroundTransparency = 1
        end)
        delay(0,function()
            for _,button in pairs(btns[3]) do
                button.BackgroundTransparency = 0
            end
        end)
    end
end

local function size()
    wait()
    MainFrame:TweenSize(UDim2.new(0, 538, 0, 34), "Out", "Quint",true,2.75,function() MainFrame:TweenSize(UDim2.new(0, 538, 0, 264), "Out", "Quint",0.55,true,function() Visibility(true,{Title,Settings,PlayerBtn,Teleports,Global,CloseX,HomeFrame}); fadein() end) end)
end
fadeout()
MainFrame:TweenPosition(UDim2.new(0, 680, 0.275, 0), "Out", "Quint", 2,false,size())
Visibility(false,{Title,Settings,PlayerBtn,Teleports,Global,CloseX,HomeFrame})

wait()

function GetPlayer(String) -- Credit to Timeless/xFunnieuss
    local Found = {}
    local strl = String:lower()
    if strl == "all" then
        for i,v in pairs(game.Players:GetPlayers()) do
            table.insert(Found,v)
        end
    elseif strl == "others" then
        for i,v in pairs(game.Players:GetPlayers()) do
            if v.Name ~= game.Players.LocalPlayer.Name then
                table.insert(Found,v)
            end
        end    
    else
        for i,v in pairs(game.Players:GetPlayers()) do
            if v.Name:lower():sub(1, #String) == String:lower() then
                table.insert(Found,v)
            end
        end    
    end
    return Found    
end

function find(path, child)
    _G.Found = nil
    if path:FindFirstChild(child) then
        _G.Found = true
    else
        _G.Found = false
    end
end

function checkTool(tool)
    for _,item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if item.Name == tool then
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
            local Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
            Humanoid:EquipTool(item)
        end
    end
end

function inTBL(tbl, value)
    local x = false
    for i,v in pairs(tbl) do
        if v == value then
            x = true
        end
    end
    if x == true then
        return true
    else
        return false
    end
end

function SendAlert(Title, Text, Icon, Time)
    wait(.2)
    local T = Time
    local Ti = Title
    local Te = Text
    local Ic = ('rbxassetid://'..Icon)
    game.StarterGui:SetCore("SendNotification", {
        Title = Ti;
        Text = Te;
        Icon = Ic;
        Duration = T;
    })
end

function DeadPositionIteration()
    cd = Instance.new("CFrameValue", game.Lighting)
    cd.Name = "DiedPos"
    cd.Value = CFrame.new(0,0,0)
    repeat wait()
        local BE = game.Players.LocalPlayer.Character:WaitForChild("BodyEffects")
        if BE["K.O"].Value == true then
            game.Lighting.DiedPos.Value = game.Players.LocalPlayer.Character:WaitForChild("UpperTorso").CFrame
        elseif game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health == 0 then
            game.Lighting.DiedPos.Value = game.Players.LocalPlayer.Character:WaitForChild("UpperTorso").CFrame
        else
            wait()
        end
    until game.Workspace.ClassName == "Nigger"
end

function SitCheck()
    local Character = game.Players.LocalPlayer.Character
    local Humanoid = Character:WaitForChild("Humanoid")
    if Humanoid.Sit == true then
        Character:MoveTo(Vector3.new(100,100,100))
        Humanoid.Sit = false
    else
        --do nothing
    end
end

function findCash(cashier, radius)
    for _,x in pairs(game.Workspace.Ignored.Drop:GetChildren()) do
        if x.Name == "MoneyDrop" then
            if (cashier.Head.Position - x.Position).Magnitude < radius then
                local FinalProduct = (cashier.Head.Position - x.Position).Magnitude
                x.Name = "VerifiedDrop"
                print("Got "..(tostring(FinalProduct)))
            else
                x.Name = "NotFin"
            end
        else
            x.Name = "NotFin"
        end
    end
end

function grabCash()
    repeat wait()
        find(game.Workspace.Ignored.Drop, "VerifiedDrop")
        if _G.Found == true then
            game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(game.Workspace.Ignored.Drop:FindFirstChild("VerifiedDrop").Position)
            if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position.Y < 12 then
                game.Workspace.Ignored.Drop:FindFirstChild("VerifiedDrop"):Destroy()
            end
            wait(.2)
            if game.Workspace.Ignored.Drop:FindFirstChild("VerifiedDrop") then
                if _G.LastPickupPos == Vector3.new(0,0,0) then
                    _G.LastPickupPos = game.Workspace.Ignored.Drop:FindFirstChild("VerifiedDrop").Position
                    fireclickdetector(game.Workspace.Ignored.Drop:FindFirstChild("VerifiedDrop").ClickDetector)
                else
                    if (_G.LastPickupPos - game.Workspace.Ignored.Drop:FindFirstChild("VerifiedDrop").Position).magnitude < 25 then
                        _G.LastPickupPos = game.Workspace.Ignored.Drop:FindFirstChild("VerifiedDrop").Position
                        fireclickdetector(game.Workspace.Ignored.Drop:FindFirstChild("VerifiedDrop").ClickDetector)
                    else
                        break;
                    end
                end
            else
                -- do nothing
            end
        else
            break;
        end
    until _G.NeverDone == true
end

function Charge()
    local MainEvent = game.ReplicatedStorage:WaitForChild("MainEvent")
    MainEvent:FireServer("ChargeButton")
end

function BuyModel(Model)
    local IgnoredFolder = game.Workspace:WaitForChild("Ignored")
    local ShopFolder = IgnoredFolder:WaitForChild("Shop")
    if Model.Parent == ShopFolder and Model:IsA("Model") then
        print("Got model; Buying "..(tostring(Model.Name)))
        print("Buying..")
        _G.pos = (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
        wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(ShopFolder[Model.Name].Head.Position)
        wait(.2)
        fireclickdetector(ShopFolder[Model.Name].ClickDetector)
        wait(.1)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = _G.pos
    end
end

function toSaftey()
    local Character = game.Players.LocalPlayer.Character
    Character:WaitForChild("HumanoidRootPart").CFrame = platePos
end

function toOld()
    local Character = game.Players.LocalPlayer.Character
    Character:WaitForChild("HumanoidRootPart").CFrame = oldPos
end

function BuyChicken()
    pcall(function()
        local ChickenModel = game:GetService("Workspace").Ignored.Shop["[Chicken] - $7"]
        _G.EatModule.OldBuyPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ChickenModel.Head.CFrame
        wait(0.3)
        fireclickdetector(ChickenModel.ClickDetector)
    end)
end

function toPlate()
    pcall(function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.FoodPlate.CFrame
    end)
end

function BuyFood()
    local Character = game.Players.LocalPlayer.Character
    local Shop = game.Workspace.Ignored.Shop
    Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(Shop["[Chicken] - $7"].Head.Position)
    wait(0.23)
    fireclickdetector(Shop["[Chicken] - $7"].ClickDetector)
    wait()
    toSaftey()
end

if game.Workspace:FindFirstChild("FoodPlate") then
    wait()
else
    FoodPlat = Instance.new("Part", game.Workspace)
    FoodPlat.Name = "FoodPlate"
    FoodPlat.Position = Vector3.new(0,-103,0)
    FoodPlat.Anchored = true
    FoodPlat.Size = Vector3.new(30,0.5,30)
end

function tp(coords)
    local LocalPlayer = game.Players.LocalPlayer
    local HumanoidRoot = LocalPlayer.Character.HumanoidRootPart
    HumanoidRoot.CFrame = (coords)
end

function NumChild(Path)
    _G.CC = 0
    for i,v in pairs(Path:GetChildren()) do
        _G.CC = math.floor(_G.CC + 1)
    end
    if _G.CC == 0 then
        _G.NoChildren = true
        _G.CC = tostring(_G.CC)
    elseif _G.CC > 0 then
        _G.NoChildren = false
        _G.CC = tostring(_G.CC)
    end
end

function NoIconAlert(Title, Text, Time)
    wait(.2)
    local T = Time
    local Ti = Title
    local Te = Text
    game.StarterGui:SetCore("SendNotification", {Title = Ti;Text = Te;Duration = T;})
end

function breakout()
    if _G.AutoBreakOut == true then
        local Key = workspace.Ignored.Shop:FindFirstChild("[Key] - $125").Head
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Key.CFrame
        wait(0.5)
        fireclickdetector(Key.Parent.ClickDetector)
        wait()
        game.Players.LocalPlayer.Backpack:WaitForChild("[Key]")
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack["[Key]"])
    end
end

function showFrame(framename)
    TeleportsFrame.Visible = false
    HomeFrame.Visible = false
    GlobalFrame.Visible = false
    PlayerFrame.Visible = false
    SettingsFrame.Visible = false
    wait()
    if framename == 'tp' then 
        TeleportsFrame.Visible = true
    else
        game.CoreGui.MainGUI.MainFrame:FindFirstChild(framename).Visible = true
    end
end

-- [[ Functions ]] --

if game.Workspace:FindFirstChild("FoodPlate") then
    wait()
else
    FoodPlat = Instance.new("Part", game.Workspace)
    FoodPlat.Name = "FoodPlate"
    FoodPlat.Position = Vector3.new(0,-103,0)
    FoodPlat.Anchored = true
    FoodPlat.Size = Vector3.new(30,0.5,30)
end

GunStore2.Text = "Gun Store 2"

JumpPower.MouseButton1Down:connect(function()
    if _G.JPE == false then
        _G.JPE = true
        JumpPower.TextColor3 = Color3.new(0,1,0)
        local player = game.Players.LocalPlayer
        local character = player.Character
        local bodyeffects_folder = character:WaitForChild("BodyEffects")
        t = Instance.new("BoolValue")
        t.Parent = bodyeffects_folder.Movement
        t.Value = true
        t.Name = "HulkJump"
    elseif _G.JPE == true then
        _G.JPE = false
        wait()
        JumpPower.TextColor3 = Color3.new(1, 0, 0)
        local nameme = tostring(game.Players.LocalPlayer.Name)
        if game.Workspace.Players:FindFirstChild(nameme):FindFirstChild("BodyEffects").Movement:FindFirstChild("HulkJump") then
            game.Workspace.Players:FindFirstChild(nameme):FindFirstChild("BodyEffects").Movement:FindFirstChild("HulkJump"):Destroy()
        end
    end
end)

Speed.MouseButton1Down:connect(function()
    if _G.WSE == false then
        _G.WSE = true
        Speed.TextColor3 = Color3.new(0,1,0)
        local player = game.Players.LocalPlayer
        local character = player.Character
        local bodyeffects_folder = character:WaitForChild("BodyEffects")
        t = Instance.new("BoolValue")
        t.Parent = bodyeffects_folder.Movement
        t.Value = true
        t.Name = "SuperSpeed"
    elseif _G.WSE == true then
        _G.WSE = false
        wait()
        Speed.TextColor3 = Color3.new(1, 0, 0)
        local nameme = tostring(game.Players.LocalPlayer.Name)
        if game.Workspace.Players:FindFirstChild(nameme):FindFirstChild("BodyEffects").Movement:FindFirstChild("SuperSpeed") then
            game.Workspace.Players:FindFirstChild(nameme):FindFirstChild("BodyEffects").Movement:FindFirstChild("SuperSpeed"):Destroy()
        end
    end
end)

_G.NameTBL = {}
_G.AmmoTBL = {}

for i,v in pairs(ScrollFrame:GetChildren()) do
    local IgnoredFolder = game.Workspace:WaitForChild("Ignored")
    local ShopFolder = IgnoredFolder:WaitForChild("Shop")
    local NV = (function()
        for _,x in pairs(ShopFolder:GetChildren()) do
            if not string.find(string.lower(x.Name), "ammo") then
                local lowered;
                pcall(function()
                    lowered = string.lower(string.match(x.Name, "%[(%a+)"))
                end)
                local nam = v.Name
                if lowered == string.lower(string.match(nam, "%[(%a+)")) then
                    return x.Name
                end
            end
        end
    end)()
    if not inTBL(_G.NameTBL) then
        table.insert(_G.NameTBL, {[v.Name] = NV})
    end
end

game.Players.LocalPlayer.Character.DescendantAdded:Connect(function(Desc)
    if Desc.Name == 'ShootBBGUI' and _G.FreezeBullets then
        wait(0.5)
        Desc:Destroy()
    end
end)

for i,v in pairs(ScrollFrame:GetChildren()) do
    local IgnoredFolder = game.Workspace:WaitForChild("Ignored")
    local ShopFolder = IgnoredFolder:WaitForChild("Shop")
    local NV = (function()
        for _,x in pairs(ShopFolder:GetChildren()) do
            if string.find(string.lower(x.Name), "ammo") then
                local lowered;
                pcall(function()
                    lowered = string.lower(string.match(x.Name, "%[(%a+)"))
                end)
                local nam = v.Name
                if lowered == string.lower(string.match(nam, "%[(%a+)")) then
                    return x.Name
                end
            end
        end
    end)()
    if not inTBL(_G.AmmoTBL) then
        table.insert(_G.AmmoTBL, {[v.Name] = NV})
    end
end

for _,button in pairs(ScrollFrame:GetChildren()) do
    button.MouseButton1Down:connect(function()
        for z,x in pairs(_G.NameTBL) do
            for _,b in pairs(x) do
                if not string.find(string.lower(b), "ammo") then
                    local lowered;
                    pcall(function()
                        lowered = string.lower(string.match(b, "%[(%a+)"))
                    end)
                    local nam = button.Name
                    if lowered == string.lower(string.match(nam, "%[(%a+)")) then
                        _G.FocusedGun = b
                        SelectedGunLabel.Text = _G.FocusedGun
                        for _,n in pairs(_G.AmmoTBL) do
                            for _,p in pairs(n) do
                                if string.find(string.lower(p), "ammo") then
                                    local lowered;
                                    pcall(function()
                                        lowered = string.lower(string.match(p, "%[(%a+)"))
                                    end)
                                    local nam = button.Name
                                    if lowered == string.lower(string.match(nam, "%[(%a+)")) then
                                        _G.FocusedAmmo = p
                                    end
                                end
                            end
                        end
                        print("Buy : "..b)
                    end
                end
            end
        end
    end)
end

game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(Input)
    if _G.Keybinds[Input:lower()] ~= nil then
        _G.Keybinds[Input:lower()]()
    end
end)

Keybinds.Draggable = true

KeyBinds.MouseButton1Down:Connect(function()
    Keybinds.Visible = true
end)

game.Players.LocalPlayer.Character.ChildAdded:connect(function(Child)
    if Child.Name == "In-gameMask" and _G.InvisibleMask then
        Child:WaitForChild("Handle"):Destroy()
    end
end)

game.Players.LocalPlayer.CharacterAdded:connect(function()
    repeat wait() until game.Players.LocalPlayer.Character ~= nil
    game.Players.LocalPlayer.Character.DescendantAdded:Connect(function(Desc)
        if Desc.Name == 'ShootBBGUI' and _G.FreezeBullets then
            wait(0.5)
            Desc:Destroy()
        end
    end)
    game.Players.LocalPlayer.Character.ChildAdded:connect(function(Child)
        if Child.Name == "In-gameMask" and _G.InvisibleMask then
            Child:WaitForChild("Handle"):Destroy()
        end
    end)
end)

FreezeBullets.MouseButton1Down:Connect(function()
    _G.FreezeBullets = not(_G.FreezeBullets)
    if _G.FreezeBullets then
        FreezeBullets.TextColor3 = Color3.new(0,1,0)
    else
        FreezeBullets.TextColor3 = Color3.new(1,0,0)
    end
end)

InvisibleMask.MouseButton1Down:Connect(function()
    _G.InvisibleMask = not(_G.InvisibleMask)
    if _G.InvisibleMask then
        InvisibleMask.TextColor3 = Color3.new(0,1,0)
    else
        InvisibleMask.TextColor3 = Color3.new(1,0,0)
    end
end)

game.Players.LocalPlayer.Character.BodyEffects.ChildAdded:connect(function(Child)
    if Child.Name == "Block" and _G.NML then
        wait(0.3)
        Child.Name = ""
    end
end)

game.Players.LocalPlayer.CharacterAdded:connect(function()
    repeat wait() until game.Players.LocalPlayer.Character ~= nil
    repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("BodyEffects")
    game.Players.LocalPlayer.Character.BodyEffects.ChildAdded:connect(function(Child)
        if Child.Name == "Block" and _G.NML then
            wait(0.3)
            Child.Name = ""
        end
    end)
end)

SaveAndExit.MouseButton1Down:Connect(function()
    _G.Keybinds = {
        [FlyInputKeybind.Text:lower()] = function()
            firesignal(FlyBtn.MouseButton1Down)
        end,
        [NoclipInputKeybind.Text:lower()] = function()
            firesignal(Noclip.MouseButton1Down)
        end,
        [JumppowerInputKeybind.Text:lower()] = function()
            if _G.JPE == false then
                _G.JPE = true
                JumpPower.TextColor3 = Color3.new(0,1,0)
                local player = game.Players.LocalPlayer
                local character = player.Character
                local bodyeffects_folder = character:WaitForChild("BodyEffects")
                t = Instance.new("BoolValue")
                t.Parent = bodyeffects_folder.Movement
                t.Value = true
                t.Name = "HulkJump"
            elseif _G.JPE == true then
                _G.JPE = false
                wait()
                JumpPower.TextColor3 = Color3.new(1, 0, 0)
                local nameme = tostring(game.Players.LocalPlayer.Name)
                if game.Workspace.Players:FindFirstChild(nameme):FindFirstChild("BodyEffects").Movement:FindFirstChild("HulkJump") then
                    game.Workspace.Players:FindFirstChild(nameme):FindFirstChild("BodyEffects").Movement:FindFirstChild("HulkJump"):Destroy()
                end
            end
        end,
        [WalkspeedInputKeybind.Text:lower()] = function()
            if _G.WSE == false then
                _G.WSE = true
                Speed.TextColor3 = Color3.new(0,1,0)
                local player = game.Players.LocalPlayer
                local character = player.Character
                local bodyeffects_folder = character:WaitForChild("BodyEffects")
                t = Instance.new("BoolValue")
                t.Parent = bodyeffects_folder.Movement
                t.Value = true
                t.Name = "SuperSpeed"
            elseif _G.WSE == true then
                _G.WSE = false
                wait()
                Speed.TextColor3 = Color3.new(1, 0, 0)
                local nameme = tostring(game.Players.LocalPlayer.Name)
                if game.Workspace.Players:FindFirstChild(nameme):FindFirstChild("BodyEffects").Movement:FindFirstChild("SuperSpeed") then
                    game.Workspace.Players:FindFirstChild(nameme):FindFirstChild("BodyEffects").Movement:FindFirstChild("SuperSpeed"):Destroy()
                end
            end
        end
    }
    Keybinds.Visible = false
end)

local Mouse = game.Players.LocalPlayer:GetMouse()
local MainEvent = game.ReplicatedStorage:WaitForChild("MainEvent")
Mouse.KeyDown:connect(function(e)
    if e:lower() == "e" and _G.NML == true then
        MainEvent:FireServer("Stomp")
    end
end)

BuyAmmo.Text = "Buy Ammo"
BuyAmmo.MouseButton1Down:connect(function()
    BuyModel(workspace.Ignored.Shop[_G.FocusedAmmo])
end)

BuyGun.Text = "Buy Gun"
BuyGun.MouseButton1Down:connect(function()
    BuyModel(workspace.Ignored.Shop[_G.FocusedGun])
end)

Global.MouseButton1Down:connect(function()
    closeandopen(0.4)
    wait(0.5)
    PageName.Visible = true
    showFrame("GlobalFrame")
    PageName.Text = "Global"
    wait(1.2)
end)

PlayerBtn.MouseButton1Down:connect(function()
    closeandopen(0.4)
    wait(0.5)
    PageName.Visible = true
    showFrame("PlayerFrame")
    PageName.Text = "Player"
    wait(1.2)
end)

Teleports.MouseButton1Down:connect(function()
    closeandopen(0.4)
    wait(0.5)
    PageName.Visible = true
    showFrame("tp")
    PageName.Text = "Teleports"
    wait(1.2)
end)

Settings.MouseButton1Down:connect(function()
    closeandopen(0.4)
    wait(0.5)
    PageName.Visible = true
    showFrame("SettingsFrame")
    PageName.Text = "Settings"
    wait(1.2)
end)

CloseQuickbuy.MouseButton1Down:connect(function()
    Quickbuy:TweenPosition(UDim2.new(0.709, 0,3, 0),"Out","Quint",2.5)
    wait(0.7)
    Quickbuy.Visible = false
end)

QuickBuy.MouseButton1Down:connect(function()
    Quickbuy.Visible = true
    Quickbuy:TweenPosition(UDim2.new(0.028, 0,0.375, 0),"Out","Quint",1)
end)

DestroyGui.MouseButton1Down:connect(function()
    MainGUI:Destroy()
end)

BankIn.MouseButton1Down:connect(function()
    tp(CFrame.new(-441.057495, 22.9864883, -283.624359))
end)

BankOut.MouseButton1Down:connect(function()
    tp(CFrame.new(-415.766174, 22.5479851, -284.139313, 0.0125048384, 1.45468713e-08, 0.999921799, -2.40346978e-08, 1, -1.42474352e-08, -0.999921799, -2.38546569e-08, 0.0125048384))
end)

HoodFitness.MouseButton1Down:connect(function()
    tp(CFrame.new(-75.7519073, 21.753006, -601.89679, 0.999914587, 5.3372883e-08, -0.0130614191, -5.40656728e-08, 1, -5.26873549e-08, 0.0130614191, 5.33890407e-08, 0.999914587))
end)

Gunz1.MouseButton1Down:connect(function()
    tp(CFrame.new(482.276672, 48.003006, -608.721558, 0.999784231, -6.13344575e-09, 0.020773923, 7.46631201e-09, 1, -6.40829896e-08, -0.020773923, 6.42242597e-08, 0.999784231))
end)

GunStore2.MouseButton1Down:connect(function()
    tp(CFrame.new(-565.494324, 8.02471352, -735.959473, 0.0390613601, 6.78040877e-08, 0.999236822, -1.28294939e-08, 1, -6.73543639e-08, -0.999236822, -1.01887556e-08, 0.0390613601))
end)

HoodKicks.MouseButton1Down:connect(function()
    tp(CFrame.new(-189.983734, 21.753006, -409.98584, 0.0395820215, 6.27189252e-08, 0.99921602, -7.31683514e-09, 1, -6.24782786e-08, -0.99921602, -4.83808194e-09, 0.0395820215))
end)

TacoJeff.MouseButton1Down:connect(function()
    tp(CFrame.new(536.023865, 51.0594139, -494.452881, -0.00312924339, -3.83641918e-08, -0.999995112, 3.11797663e-08, 1, -3.84619518e-08, 0.999995112, -3.12999724e-08, -0.00312924339))
end)

Food.MouseButton1Down:connect(function()
    tp(CFrame.new(298.909027, 48.003006, -595.19751, 0.999976039, -1.99106354e-09, 0.00692271162, 1.91548066e-09, 1, 1.09247349e-08, -0.00692271162, -1.09112124e-08, 0.999976039))
end)

Food_2.MouseButton1Down:connect(function()
    tp(CFrame.new(-353.862335, 21.7748661, -298.227051, -0.00429238286, 7.24618019e-08, -0.999990761, -8.43199643e-09, 1, 7.24986577e-08, 0.999990761, 8.74310935e-09, -0.00429238286))
end)

Hospital.MouseButton1Down:connect(function()
    tp(CFrame.new(88.9013214, 21.753006, -484.718231, -0.0255038068, 9.14941545e-09, -0.999674737, -4.26821565e-08, 1, 1.02413047e-08, 0.999674737, 4.29294644e-08, -0.0255038068))
end)

KoolKlubEntrance.MouseButton1Down:connect(function()
    tp(CFrame.new(-264.844269, 48.5246773, -453.889954, -0.999946535, 5.87372961e-06, -0.0103156231, 6.00695466e-06, 1, -1.28838128e-05, 0.0103156231, -1.29450909e-05, -0.999946535))
end)

Pit.MouseButton1Down:connect(function()
    tp(CFrame.new(163.263733, -41.9520531, 157.463058, 0.00190474826, -2.31692265e-08, 0.999998212, 6.09299766e-09, 1, 2.31576625e-08, -0.999998212, 6.0488774e-09, 0.00190474826))
end)

Klips.MouseButton1Down:connect(function()
    tp(CFrame.new(12.7689886, 21.7748661, -116.272064, -0.942200065, 4.61352956e-09, 0.335050762, -6.85718093e-10, 1, -1.56979549e-08, -0.335050762, -1.50203654e-08, -0.942200065))
end)

PoliceStation.MouseButton1Down:connect(function()
    tp(CFrame.new(-244.28537, 21.8254242, -90.7711563, 0.999810934, -2.5239272e-08, 0.0194452684, 2.7374659e-08, 1, -1.09549042e-07, -0.0194452684, 1.1006064e-07, 0.999810934))
end)

Boxing.MouseButton1Down:connect(function()
    tp(CFrame.new(-216.649185, 21.753006, -1119.59546, 0.0191870183, -9.2417034e-09, 0.999815941, 4.14864445e-08, 1, 8.44725712e-09, -0.999815941, 4.13167314e-08, 0.0191870183))
end)

Bathroom.MouseButton1Down:connect(function()
    tp(CFrame.new(379.2453, 48.4980049, -343.062286, -0.999813855, -5.1477147e-09, 0.0192947257, -5.08541742e-09, 1, 3.27778937e-09, -0.0192947257, 3.17905746e-09, -0.999813855))
end)

Burger.MouseButton1Down:connect(function()
    tp(CFrame.new(-290.509277, 22.6478767, -807.023499, 0.99972111, -1.20688282e-09, -0.0236134008, 3.18070237e-09, 1, 8.35513916e-08, 0.0236134008, -8.36031973e-08, 0.99972111))
end)

Phone.MouseButton1Down:connect(function()
    tp(CFrame.new(-136.052872, 21.753006, -870.712219, 0.00702887122, -4.30646203e-08, -0.999975324, -1.95203249e-08, 1, -4.32028919e-08, 0.999975324, 1.98235082e-08, 0.00702887122))
end)

EvilBase.MouseButton1Down:connect(function()
    tp(CFrame.new(-795.758728, -39.6511955, -886.514954, 0.0118364682, 2.29957742e-08, 0.999929965, 7.34486392e-08, 1, -2.38668179e-08, -0.999929965, 7.37259924e-08, 0.0118364682))
end)

BankVault.MouseButton1Down:connect(function()
    tp(CFrame.new(-505.44342, 23.1605263, -286.24231, -0.00483206194, -6.74440201e-08, -0.999988198, 9.16705147e-08, 1, -6.78877683e-08, 0.999988198, -9.19974781e-08, -0.00483206194))
end)

spawn(function()
    local GameMT = getrawmetatable(game)
    local OldNamecall = GameMT.__namecall
    setreadonly(GameMT, false)
    GameMT.__namecall = newcclosure(function(...)
        local method = getnamecallmethod()
        local args = {...}
        if tostring(method) == "FireServer" and tostring(args[1]) == "MainEvent" and tostring(args[2]) == 'UpdateMousePos' and _G.P90FarmToggle then
            args[3] = _G.farmGlobals["cashierPosition"]
            return OldNamecall(unpack(args))
        end

        return OldNamecall(...)
    end)
    setreadonly(GameMT, true)
end)

NoRecoil.MouseButton1Down:Connect(function()
    _G.NoRecoil = not(_G.NoRecoil)
    if _G.NoRecoil == true then
        NoRecoil.TextColor3 = Color3.new(0,1,0)
        for i,v in pairs(getconnections(game.Players.LocalPlayer.Character.BodyEffects.GunShotChanges.Changed)) do
            v:Disable()
        end
    else
        NoRecoil.TextColor3 = Color3.new(1,0,0)
    end
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function()
    if _G.FullGod then
        game.Players.LocalPlayer.Character:WaitForChild("BodyEffects"):WaitForChild("BreakingParts"):Destroy()
        local Fully = Instance.new("Folder", game.Players.LocalPlayer.Character)
        Fully.Name = "FULLY_LOADED_CHAR"
    end
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function()
    if _G.NoRecoil then
        for i,v in pairs(getconnections(game.Players.LocalPlayer.Character.BodyEffects.GunShotChanges.Changed)) do
            v:Disable()
        end
    end
end)

-- [[ PlayerAdded and CharacterAdded Shit ]] --
local Player = game.Players.LocalPlayer

BlacklistedUsers = {["Final_Joke"] = 163721789, ["DrxcoBaby"] = 1553950697, ["Sherosama"] = 15427717, ["Papa_Mbaye"] = 201454243, ["UziGarage"] = 28357488, ["NikoSenpai"] = 17260230, ["AStrongMuscle"] = 822999, ["zakblak20"] = 16138978, ["Benoxa"] = 8195210, ["Luc_ey"] = 89473551, ["iumu"] = 93101606}
BlacklistedInstances = {"GrappleHook", "HeroArc", "AdminBan", "BatmanOutfit", "Glide"}

function createMessage(msg)
    -- Farewell Infortality.
    -- Version: 2.82
    -- Instances:
    local ALRT = Instance.new("ScreenGui")
    local BLANKSCREEN = Instance.new("Frame")
    local ReasonText = Instance.new("TextLabel")
    local TitleText = Instance.new("TextLabel")
    local Option_Close = Instance.new("TextButton")
    local Option_Dismiss = Instance.new("TextButton")
    local TextLabel = Instance.new("TextLabel")
    --Properties:
    ALRT.Name = "ALRT"
    ALRT.Parent = game.CoreGui
    ALRT.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    BLANKSCREEN.Name = "BLANKSCREEN"
    BLANKSCREEN.Parent = ALRT
    BLANKSCREEN.BackgroundColor3 = Color3.new(0, 0, 0)
    BLANKSCREEN.BorderColor3 = Color3.new(0, 0, 0)
    BLANKSCREEN.BorderSizePixel = 0
    BLANKSCREEN.Size = UDim2.new(2048, 2048, 2048, 2048)

    ReasonText.Name = "ReasonText"
    ReasonText.Parent = BLANKSCREEN
    ReasonText.BackgroundColor3 = Color3.new(0, 0, 0)
    ReasonText.BorderColor3 = Color3.new(0, 0, 0)
    ReasonText.Position = UDim2.new(0.000209065794, 0, 0.000223868381, 0)
    ReasonText.Size = UDim2.new(0, 378, 0, 90)
    ReasonText.ZIndex = 2
    ReasonText.Font = Enum.Font.Highway
    ReasonText.Text = msg
    ReasonText.TextColor3 = Color3.new(1, 1, 1)
    ReasonText.TextScaled = true
    ReasonText.TextSize = 14
    ReasonText.TextWrapped = true

    TitleText.Name = "TitleText"
    TitleText.Parent = BLANKSCREEN
    TitleText.BackgroundColor3 = Color3.new(0, 0, 0)
    TitleText.BorderColor3 = Color3.new(0, 0, 0)
    TitleText.Position = UDim2.new(0.00019491119, 0, 0.000197164612, 0)
    TitleText.Size = UDim2.new(0, 491, 0, 50)
    TitleText.ZIndex = 2
    TitleText.Font = Enum.Font.Highway
    TitleText.Text = "[ Jump'd Security Message ]"
    TitleText.TextColor3 = Color3.new(1, 1, 1)
    TitleText.TextScaled = true
    TitleText.TextSize = 14
    TitleText.TextWrapped = true

    Option_Close.Name = "Option_Close"
    Option_Close.Parent = BLANKSCREEN
    Option_Close.BackgroundColor3 = Color3.new(0, 0, 0)
    Option_Close.BorderColor3 = Color3.new(1, 1, 1)
    Option_Close.BorderSizePixel = 5
    Option_Close.Position = UDim2.new(0.000216258341, 0, 0.000272140693, 0)
    Option_Close.Size = UDim2.new(0, 152, 0, 32)
    Option_Close.ZIndex = 2
    Option_Close.Font = Enum.Font.Highway
    Option_Close.Text = "Close Game"
    Option_Close.TextColor3 = Color3.new(1, 1, 1)
    Option_Close.TextScaled = true
    Option_Close.TextSize = 14
    Option_Close.TextWrapped = true

    Option_Dismiss.Name = "Option_Dismiss"
    Option_Dismiss.Parent = BLANKSCREEN
    Option_Dismiss.BackgroundColor3 = Color3.new(0, 0, 0)
    Option_Dismiss.BorderColor3 = Color3.new(1, 1, 1)
    Option_Dismiss.BorderSizePixel = 5
    Option_Dismiss.Position = UDim2.new(0.000259537861, 0, 0.000272140693, 0)
    Option_Dismiss.Size = UDim2.new(0, 152, 0, 32)
    Option_Dismiss.ZIndex = 2
    Option_Dismiss.Font = Enum.Font.Highway
    Option_Dismiss.Text = "Dismiss"
    Option_Dismiss.TextColor3 = Color3.new(1, 1, 1)
    Option_Dismiss.TextScaled = true
    Option_Dismiss.TextSize = 14
    Option_Dismiss.TextWrapped = true

    TextLabel.Parent = BLANKSCREEN
    TextLabel.BackgroundColor3 = Color3.new(0, 0, 0)
    TextLabel.BorderColor3 = Color3.new(1, 1, 1)
    TextLabel.BorderSizePixel = 5
    TextLabel.Position = UDim2.new(0.00019263936, 0, 0.000192952473, 0)
    TextLabel.Size = UDim2.new(0, 509, 0, 224)
    TextLabel.Font = Enum.Font.SourceSans
    TextLabel.Text = ""
    TextLabel.TextColor3 = Color3.new(0, 0, 0)
    TextLabel.TextSize = 14
    Option_Close.MouseButton1Down:connect(function()
        game:shutdown()
    end)
    Option_Dismiss.MouseButton1Down:connect(function()
        Option_Dismiss.Parent.Parent:Destroy()
    end)
end

for _,v in pairs(game.Players:GetChildren()) do
    if v.ClassName == "LocalScript" then
        --
    else
        for q,e in pairs(BlacklistedUsers) do
            if v.Name == q then
                local Message = "An administrator, "..q.." ("..e..") ".."has been detected in your game, please select one of the following actions to preform as a result of this."
                createMessage(Message)
            elseif v.UserId == e then
                local Message = "An administrator, "..q.." ("..e..") ".."has been detected in your game, please select one of the following actions to preform as a result of this."
                createMessage(Message)
            end
        end
    end
end

game.Players.ChildAdded:connect(function(plr)
    wait(1)
    for q,e in pairs(BlacklistedUsers) do
        if plr.Name == q then
            local Message = "An administrator, "..q.." ("..e..") ".."has been detected in your game, please select one of the following actions to preform as a result of this."
            createMessage(Message)
        elseif plr.UserId == e then
            local Message = "An administrator, "..q.." ("..e..") ".."has been detected in your game, please select one of the following actions to preform as a result of this."
            createMessage(Message)
        end
    end
end)

Player.CharacterAdded:connect(function()
    if _G.AutoEat == true then
        Player.Character:WaitForChild("Humanoid")
        Player.Character:WaitForChild("UpperTorso")
        Player.Character:WaitForChild("Head")
        _G.EatModule.OldPosition = "f"
        Player.Character.Humanoid:GetPropertyChangedSignal("Health"):connect(function()
            if _G.AutoEat == true then
                if Player.Character.Humanoid.Health < _G.EatModule.StartHealth then
                    if _G.AutoEat == true and Player.Character ~= nil then
                        if _G.EatModule.Running == false then
                            if _G.AutoEat == true then
                                _G.EatModule.OldPosition = Player.Character.HumanoidRootPart.CFrame
                                repeat wait()
                                    if not Player.Character:FindFirstChild("Humanoid") then
                                        break;
                                    end
                                    if _G.AutoEat == false then
                                        _G.EatModule.OldPosition = "f"
                                        break;
                                    end
                                    _G.EatModule.Running = true
                                    if Player.Backpack:FindFirstChild("[Chicken]") then
                                        toPlate()
                                        Player.Character.Humanoid:EquipTool(Player.Backpack:FindFirstChild("[Chicken]"))
                                        wait(0.3)
                                        if Player.Character and Player.Character:FindFirstChild("[Chicken]") then
                                            Player.Character:FindFirstChild("[Chicken]"):Activate()
                                        end
                                        wait()
                                    else
                                        BuyChicken()
                                        wait(0.3)
                                        if Player.Backpack:FindFirstChild("[Chicken]") then
                                            toPlate()
                                            Player.Character.Humanoid:EquipTool(Player.Backpack:FindFirstChild("[Chicken]"))
                                            wait(0.1)
                                            if Player.Character and Player.Character:FindFirstChild("[Chicken]") then
                                                Player.Character:FindFirstChild("[Chicken]"):Activate()
                                            end
                                            wait()
                                        end
                                    end
                                until Player.Character:WaitForChild("Humanoid").Health > _G.EatModule.ReturningHealth or Player.Character == nil
                            end
                            _G.EatModule.Running = false
                            if _G.EatModule.OldPosition ~= "f" then
                                if not Player:FindFirstChild("JustAdded") then
                                    Player.Character.HumanoidRootPart.CFrame = _G.EatModule.OldPosition
                                end
                            end
                            _G.EatModule.OldPosition = "f"
                            wait()
                        end
                    end
                end
            end
        end)
    end
end)

local Player = game.Players.LocalPlayer
Player.CharacterAdded:connect(function()
    i = Instance.new("Folder",Player)
    i.Name = "JustAdded"
    wait(4)
    i:Destroy()
end)

if game.Players.LocalPlayer.DataFolder.Information:FindFirstChild("Jail") then
    game.Players.LocalPlayer.DataFolder.Information.Jail:GetPropertyChangedSignal("Value"):connect(function()
        local JV = game.Players.LocalPlayer.DataFolder.Information.Jail.Value
        if tonumber(JV) <= 250 then
            if tonumber(JV)==0 then
                --
            else
                breakout()
            end
        end
    end)
end

for _,v in pairs(game.Players:GetChildren()) do
    if v.Character ~= nil and v.Name ~= game.Players.LocalPlayer.Name then
        v.Character.BodyEffects.Attacking.Changed:connect(function()
            if v.Character.BodyEffects:FindFirstChild("Attacking").Value == true then
                if _G.AutoBlockToggle == true and (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 11 and (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 0 then 
                    game.ReplicatedStorage.MainEvent:FireServer("Block",true)
                end
            elseif v.Character.BodyEffects:FindFirstChild("Attacking").Value == false then 
                if _G.AutoBlockToggle == true and (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 11 and (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 0 then 
                    game.ReplicatedStorage.MainEvent:FireServer("Block",false)
                end
            end	
        end)
    end
    v.CharacterAdded:connect(function()
        wait(2)
        v.Character.BodyEffects.Attacking.Changed:connect(function()
            if v.Character.BodyEffects:FindFirstChild("Attacking").Value == true then
                if _G.AutoBlockToggle == true and (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 11 and (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 0 then 
                    game.ReplicatedStorage.MainEvent:FireServer("Block",true)
                    wait()
                    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
                    local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
                    for _,v in pairs(ActiveTracks) do
                        v:Stop()
                    end
                end
            elseif v.Character.BodyEffects:FindFirstChild("Attacking").Value == false then 
                if _G.AutoBlockToggle == true and (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 11 and (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 0 then 
                    game.ReplicatedStorage.MainEvent:FireServer("Block",false)
                    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
                    local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
                    for _,v in pairs(ActiveTracks) do
                        v:Stop()
                    end
                end
            end	
        end)
    end)
end

game.Players.PlayerAdded:connect(function(v)
    wait(5)
    v.Character.BodyEffects.Attacking.Changed:connect(function()
        if v.Character.BodyEffects:FindFirstChild("Attacking").Value == true then
            if _G.AutoBlockToggle == true and (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 11 and (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 0 then 
                game.ReplicatedStorage.MainEvent:FireServer("Block",true)
                wait()
                local Humanoid = game.Players.LocalPlayer.Character.Humanoid
                local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
                for _,v in pairs(ActiveTracks) do
                    v:Stop()
                end
            end
        elseif v.Character.BodyEffects:FindFirstChild("Attacking").Value == false then 
            if _G.AutoBlockToggle == true and (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 11 and (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 0 then 
                game.ReplicatedStorage.MainEvent:FireServer("Block",false)
                local Humanoid = game.Players.LocalPlayer.Character.Humanoid
                local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
                for _,v in pairs(ActiveTracks) do
                    v:Stop()
                end
            end
        end	
    end)
    v.CharacterAdded:connect(function()
        wait(2)
        v.Character.BodyEffects.Attacking.Changed:connect(function()
            if v.Character.BodyEffects:FindFirstChild("Attacking").Value == true then
                if _G.AutoBlockToggle == true and (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 11 and (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 0 then 
                    game.ReplicatedStorage.MainEvent:FireServer("Block",true)
                end
            elseif v.Character.BodyEffects:FindFirstChild("Attacking").Value == false then 
                if _G.AutoBlockToggle == true and (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 11 and (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 0 then 
                    game.ReplicatedStorage.MainEvent:FireServer("Block",false)
                end
            end	
        end)
    end)
end)

-- [[ PlayerAdded and CharacterAdded Shit ]] --

local Players = game:GetService("Players")
for _,Player in pairs(Players:GetChildren()) do
    if Player.Character ~= nil and Player ~= Players.LocalPlayer then
        if Player.Character:FindFirstChild("LowerTorso") then
            if Player.Character:FindFirstChild("LowerTorso"):FindFirstChildOfClass("Sound") and _G.BoomBreak then
                Player.Character:FindFirstChild("LowerTorso"):FindFirstChildOfClass("Sound"):Stop()
                Player.Character:FindFirstChild("LowerTorso"):FindFirstChildOfClass("Sound").Changed:Connect(function()
                    Player.Character:FindFirstChild("LowerTorso"):FindFirstChildOfClass("Sound"):Stop()
                end)
            end
            Player.Character:FindFirstChild("LowerTorso").ChildAdded:Connect(function(Child)
                if Child:IsA("Sound") and _G.BoomBreak then
                    Child:Stop()
                    Child.Changed:Connect(function()
                        Child:Stop()
                    end)
                end
            end)
        end
        Player.CharacterAdded:Connect(function()
            repeat wait() until not Player or Player.Character ~= nil
            Player.Character:WaitForChild("LowerTorso")
            if Player.Character:FindFirstChild("LowerTorso"):FindFirstChildOfClass("Sound") and _G.BoomBreak then
                Player.Character:FindFirstChild("LowerTorso"):FindFirstChildOfClass("Sound"):Stop()
                Player.Character:FindFirstChild("LowerTorso"):FindFirstChildOfClass("Sound").Changed:Connect(function()
                    Player.Character:FindFirstChild("LowerTorso"):FindFirstChildOfClass("Sound"):Stop()
                end)
            end
            Player.Character:FindFirstChild("LowerTorso").ChildAdded:Connect(function(Child)
                if Child:IsA("Sound") and _G.BoomBreak then
                    Child:Stop()
                    Child.Changed:Connect(function()
                        Child:Stop()
                    end)
                end
            end)
        end)
    end
end


Players.PlayerAdded:Connect(function(Player)
    Player.CharacterAdded:Connect(function()
        repeat wait() until not Player or Player.Character ~= nil
        Player.Character:WaitForChild("LowerTorso")
        if Player.Character:FindFirstChild("LowerTorso"):FindFirstChildOfClass("Sound") and _G.BoomBreak then
            Player.Character:FindFirstChild("LowerTorso"):FindFirstChildOfClass("Sound"):Stop()
            Player.Character:FindFirstChild("LowerTorso"):FindFirstChildOfClass("Sound").Changed:Connect(function()
                Player.Character:FindFirstChild("LowerTorso"):FindFirstChildOfClass("Sound"):Stop()
            end)
        end
        Player.Character:FindFirstChild("LowerTorso").ChildAdded:Connect(function(Child)
            if Child:IsA("Sound") then
                Child:Stop()
                Child.Changed:Connect(function()
                    Child:Stop()
                end)
            end
        end)
    end)

    repeat wait() until not Player or Player.Character ~= nil
    Player.Character:WaitForChild("LowerTorso")

    if Player.Character:FindFirstChild("LowerTorso") then
        if Player.Character:FindFirstChild("LowerTorso"):FindFirstChildOfClass("Sound") and _G.BoomBreak then
            Player.Character:FindFirstChild("LowerTorso"):FindFirstChildOfClass("Sound"):Stop()
            Player.Character:FindFirstChild("LowerTorso"):FindFirstChildOfClass("Sound").Changed:Connect(function()
                Player.Character:FindFirstChild("LowerTorso"):FindFirstChildOfClass("Sound"):Stop()
            end)
        end
        Player.Character:FindFirstChild("LowerTorso").ChildAdded:Connect(function(Child)
            if Child:IsA("Sound") then
                Child:Stop()
                Child.Changed:Connect(function()
                    Child:Stop()
                end)
            end
        end)
    end
end)

game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(Input)
    if Input:lower() == "q" and _G.QTP then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.p + Vector3.new(0,4,0))
    end
end)

local GameMT = getrawmetatable(game)
local OldNamecall = GameMT.__namecall
local ChatFunctions = {
    ["/chat"] = function()
        local Chat = game.Players.LocalPlayer.PlayerGui.Chat
        local function setPos(bool)
            if bool == true then
                Chat.Frame.ChatBarParentFrame.Position = UDim2.new(0,0,0,210)
            elseif bool == false then
                Chat.Frame.ChatBarParentFrame.Position = UDim2.new(0,0,0,0)
            end
        end

        if Chat.Frame.ChatChannelParentFrame.Visible == false then
            Chat.Frame.ChatChannelParentFrame.Visible = true
            setPos(true)
        elseif Chat.Frame.ChatChannelParentFrame.Visible == true then
            Chat.Frame.ChatChannelParentFrame.Visible = false
            setPos(false)
        else
            warn("[ERROR] - UNABLE TO READ CHAT SETTINGS")
        end
    end,
    ["/killboomboxes"] = function()
        _G.BoomBreak = not(_G.BoomBreak)
        if _G.BoomBreak then
            local Players = game:GetService("Players")
            for _,Player in pairs(Players:GetChildren()) do
                if Player.Character ~= nil and Player ~= Players.LocalPlayer then
                    pcall(function()
                        for _,Instance in pairs(Player.Character:GetDescendants()) do
                            if Instance.Parent == Player.Character.LowerTorso and Instance:IsA("Sound") then
                                Instance:Stop()
                            end
                        end
                    end)
                end
            end
        end
    end,
    ["/qtp"] = function()
        _G.QTP = not(_G.QTP)
    end,
    ["/headless"] = function()
        local Success, Error = pcall(function()
            game.Players.LocalPlayer.Character:WaitForChild("Head")
            if game.Players.LocalPlayer.Character.Head:FindFirstChild("Neck") then
                game.Players.LocalPlayer.Character.Head:FindFirstChild("Neck"):Destroy()
                game.Players.LocalPlayer.Character.Head.CFrame = CFrame.new(game.Players.LocalPlayer.Character.Head.Position + Vector3.new(0, -100, 0))
                game.Players.LocalPlayer.Character.Head.Size = Vector3.new(0, 0, 0)
            end
        end)

        if not Success then
            print(tostring(Error))
        end
    end,
    ["/fog"] = function()
        if game:WaitForChild("Lighting").FogEnd < 50000 then
            game:WaitForChild("Lighting").FogEnd = 999999999
        else
            game:WaitForChild("Lighting").FogEnd = 500
        end
    end
}
setreadonly(GameMT, false)

GameMT.__namecall = newcclosure(function(self, ...)
    local Arguments = {...}
    local Method = getnamecallmethod()

    if self == game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest and Method == "FireServer" then
        if Arguments[1] ~= nil then
            if ChatFunctions[Arguments[1]] ~= nil then
                print("Command found, running adequate function...")
                ChatFunctions[Arguments[1]]()
                return;
            end
        end
    end

    return OldNamecall(self, ...)
end)

setreadonly(GameMT, true)

FullGod.MouseButton1Down:Connect(function()
    _G.FullGod = not(_G.FullGod)
    if _G.FullGod then
        local pos = game.Players.LocalPlayer.Character.Head.Position
        FullGod.TextColor3 = Color3.new(0,1,0)
        game.Players.LocalPlayer.Character.Head:Destroy()
        wait(7)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
    else
        FullGod.TextColor3 = Color3.new(1, 0, 0)
    end
end)

spawn(function()
    local players = game.GetService(game, "Players")
    local guiservice = game.GetService(game, "GuiService")
    local runservice = game.GetService(game, "RunService")
    local renderstepped = runservice.RenderStepped
    local localPlayer = players.LocalPlayer
    local currentCamera = game.GetService(game, "Workspace").CurrentCamera
    local mouse = localPlayer.GetMouse(localPlayer)
    local mt = getrawmetatable(game)
    local backupnamecall = mt.__namecall
    local backupnewindex = mt.__newindex
    local backupindex = mt.__index
    local setreadonly = setreadonly or make_writeable
    local getnamecallmethod = getnamecallmethod or get_namecall_method
    local newcclosure = newcclosure or function(f) return f end

    setreadonly(mt, false)

    local circle = Drawing.new("Circle")
    function updateCircle()
        if circle.__OBJECT_EXISTS then
            circle.Transparency = 1
            circle.Visible = (function()
                if _G.SilentAimEnabled == true then
                    return true
                else
                    return false
                end
            end)()
            circle.Thickness = 2
            circle.Color = Color3.fromRGB(255, 255, 255)
            circle.NumSides = 90
            circle.Radius = (_G.SilentAimRad * 6) / 2
            circle.Filled = false
            circle.Position = Vector2.new(mouse.X, mouse.Y + (guiservice.GetGuiInset(guiservice).Y))
        end
    end

    renderstepped.Connect(renderstepped, updateCircle)

    function isPartVisible(Part, PartDescendant)
        local CurrentCamera = game.GetService(game, "Workspace").CurrentCamera
        local LocalPlayer = game.Players.LocalPlayer
        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded.Wait(LocalPlayer.CharacterAdded)
        local Origin = CurrentCamera.CFrame.p
        local _, OnScreen = CurrentCamera.WorldToViewportPoint(CurrentCamera, Part.Position)
        if OnScreen then
            local newRay = Ray.new(Origin, Part.Position - Origin)
            local PartHit, _ = Workspace.FindPartOnRayWithIgnoreList(Workspace, newRay, {Character, CurrentCamera})
            local Visible = (not PartHit or PartHit.IsDescendantOf(PartHit, PartDescendant))
            return Visible
        end
        return false
    end

    setreadonly(math, false); math.chance = function(percentage) local percentage = math.floor(percentage); local chance = math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100)/100; return chance <= percentage/100 end; setreadonly(math, true);

    function getclosestplrtomouse()
        local Mouse = game.Players.LocalPlayer:GetMouse()
        local mhit = Mouse.Hit.p
        local TargetDistance = math.huge
        local target = "/none/"
        for _,plr in pairs(game.Players:GetChildren()) do
            pcall(function()
                if plr.Name ~= game.Players.LocalPlayer.Name then
                    local chara = plr.Character or nil
                    if chara ~= nil and chara:FindFirstChild("Head") then
                        if (chara.Head.Position - mhit).magnitude < TargetDistance then
                            local CurrentCamera = game.GetService(game, "Workspace").CurrentCamera
                            local Camera = workspace.CurrentCamera
                            local _, withinScreenBounds = Camera:WorldToScreenPoint(plr.Character:FindFirstChild("Head").Position)
                            if withinScreenBounds and isPartVisible(plr.Character:FindFirstChild("Head"), plr.Character) == true then
                                local PartPos, OnScreen = CurrentCamera.WorldToViewportPoint(CurrentCamera, plr.Character.Head.Position)
                                local Magnitude = (Vector2.new(PartPos.X, PartPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude  
                                if (Magnitude < (_G.SilentAimRad * 6 - _G.Minus)) and chara.BodyEffects:FindFirstChild("K.O").Value ~= true then
                                    TargetDistance = (chara.Head.Position - mhit).magnitude
                                    target = plr
                                end
                            end
                        end
                    end
                end
            end)
        end
        _G.Target = target
    end

    delay(0,function()
        while true do wait()
            getclosestplrtomouse()
        end
    end)

    wait(0.1)

    mt.__namecall = newcclosure(function(...)
        local method = getnamecallmethod()
        local args = {...}
        if tostring(method) == "FireServer" and tostring(args[1]) == "MainEvent" and tostring(args[2]) == 'UpdateMousePos' and _G.SilentAimEnabled == true and _G.Target ~= "/none/" then
            args[3] = _G.Target.Character.Head.Position
            return backupnamecall(unpack(args))
        end

        return backupnamecall(...)
    end)
end)

FlyBtn.MouseButton1Down:connect(function()
    if _G.FLYING == false then
        FlyBtn.TextColor3 = Color3.new(0,1,0)
        local LP = game:service('Players').LocalPlayer
        local T = LP.Character.RightFoot
        local CONTROL = {F = 0, B = 0, L = 0, R = 0}
        local lCONTROL = {F = 0, B = 0, L = 0, R = 0}
        local MOUSE = LP:GetMouse()
        local function FLY(b)
            if b == true and _G.FLYING == false then
                _G.FLYING = true
                _G.FLYINGON = true
                local Humanoid = game.Players.LocalPlayer.Character.Humanoid
                local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
                for _,v in pairs(ActiveTracks) do
                    v:Stop()
                end
                local BG = Instance.new('BodyGyro', T)
                local BV = Instance.new('BodyVelocity', T)
                BG.P = 9e4
                BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                BG.cframe = T.CFrame
                BV.velocity = Vector3.new(0, 0.1, 0)
                BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
                spawn(function()
                    repeat wait()
                        LP.Character.Humanoid.PlatformStand = true
                        if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 then
                            _G.FSPEED = _G.MSPEED
                        elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0) and _G.FSPEED ~= 0 then
                            _G.FSPEED = 0
                        end
                        if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 then
                            BV.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B) * 0.2, 0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p)) * _G.FSPEED
                            lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
                        elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and _G.FSPEED ~= 0 then
                            BV.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B) * 0.2, 0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p)) * _G.FSPEED
                        else
                            BV.velocity = Vector3.new(0, 0.1, 0)
                        end
                        BG.cframe = game.Workspace.CurrentCamera.CoordinateFrame
                    until not _G.FLYING
                    CONTROL = {F = 0, B = 0, L = 0, R = 0}
                    lCONTROL = {F = 0, B = 0, L = 0, R = 0}
                    _G.FSPEED = 0
                    BG:destroy()
                    BV:destroy()
                    LP.Character.Humanoid.PlatformStand = false
                end)
            elseif b == false and _G.FLYING == true then
                _G.FLYING = false
                _G.FLYINGON = false
                LP.Character.Animate.Disabled = false
            end
        end
        MOUSE.KeyDown:connect(function(KEY)
            if KEY:lower() == 'w' then
                CONTROL.F = 1
            elseif KEY:lower() == 's' then
                CONTROL.B = -1
            elseif KEY:lower() == 'a' then
                CONTROL.L = -1
            elseif KEY:lower() == 'd' then
                CONTROL.R = 1
            end
        end)
        MOUSE.KeyUp:connect(function(KEY)
            if KEY:lower() == 'w' then
                CONTROL.F = 0
            elseif KEY:lower() == 's' then
                CONTROL.B = 0
            elseif KEY:lower() == 'a' then
                CONTROL.L = 0
            elseif KEY:lower() == 'd' then
                CONTROL.R = 0
            end
        end)
        _G.FLYINGON = true
        FLY(true)
    elseif _G.FLYING == false and _G.FLYINGON == true then
        _G.FLYINGON = false
        FlyBtn.TextColor3 = Color3.new(1, 0, 0)
    elseif _G.FLYINGON == true and _G.FLYING == true then
        _G.FLYINGON = false
        _G.FLYING = false
        FlyBtn.TextColor3 = Color3.new(1, 0, 0)
    end
end)

AutoEat.MouseButton1Down:connect(function()
    local Player = game.Players.LocalPlayer
    local FoodTable = {
        "[Chicken]",
        "[Pizza]",
        "[Taco]",
        "[Hamburger]",
        "[Donut]"
    }
    if _G.ExecutedAutoeat == false then
        _G.ExecutedAutoeat = true
        _G.AutoEat = true
        AutoEat.TextColor3 = Color3.new(0,1,0)
        Player.Character.Humanoid:GetPropertyChangedSignal("Health"):connect(function()
            if Player.Character.Humanoid.Health < _G.EatModule.StartHealth then
                if _G.AutoEat == true and Player.Character ~= nil then
                    if _G.EatModule.Running == false then
                        _G.EatModule.OldPosition = Player.Character.HumanoidRootPart.CFrame
                        pcall(function()
                            repeat wait()
                                if not Player.Character:FindFirstChild("Humanoid") then
                                    break;
                                end
                                _G.EatModule.Running = true
                                if Player.Backpack:FindFirstChild("[Chicken]") then
                                    toPlate()
                                    Player.Character.Humanoid:EquipTool(Player.Backpack:FindFirstChild("[Chicken]"))
                                    wait(0.3)
                                    if Player.Character and Player.Character:FindFirstChild("[Chicken]") then
                                        Player.Character:FindFirstChild("[Chicken]"):Activate()
                                    end
                                    wait()
                                else
                                    BuyChicken()
                                    wait(0.3)
                                    if Player.Backpack:FindFirstChild("[Chicken]") then
                                        toPlate()
                                        Player.Character.Humanoid:EquipTool(Player.Backpack:FindFirstChild("[Chicken]"))
                                        wait(0.1)
                                        if Player.Character and Player.Character:FindFirstChild("[Chicken]") then
                                            Player.Character:FindFirstChild("[Chicken]"):Activate()
                                        end
                                        wait()
                                    end
                                end
                            until Player.Character:WaitForChild("Humanoid").Health > _G.EatModule.ReturningHealth or Player.Character == nil
                            _G.EatModule.Running = false
                            if _G.EatModule.OldPosition ~= "f" then
                                if not Player:FindFirstChild("JustAdded") then
                                    Player.Character.HumanoidRootPart.CFrame = _G.EatModule.OldPosition
                                end
                            end
                            _G.EatModule.OldPosition = "f"
                            wait()
                        end)
                    end
                end
            end
        end)
    elseif _G.ExecutedAutoeat == true then
        if _G.AutoEat == true then
            _G.AutoEat = false
            AutoEat.TextColor3 = Color3.new(1, 0, 0)
        elseif _G.AutoEat == false then
            _G.AutoEat = true
            AutoEat.TextColor3 = Color3.new(0, 1, 0)
        end
    end
end)

AutoRob.MouseButton1Down:connect(function()
    if _G.AutoRobToggle == false then
        AutoRob.TextColor3 = Color3.new(0,1,0)
        _G.AutoRobToggle = true
        local Cashiers = game.Workspace.Cashiers
        while _G.AutoRobToggle == true do wait()
            checkTool("Combat")
            SitCheck()
            for _,v in pairs(Cashiers:GetChildren()) do
                if _G.AutoRobToggle == false then
                    break;
                end
                local CurrentATM = v
                if v.Humanoid.Health > 0 then
                    checkTool("Combat")
                    repeat
                        SitCheck()
                        if _G.AutoRobToggle == true then
                            checkTool("Combat")
                            wait()
                            Charge()
                            game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = v.Open.CFrame
                        elseif _G.AutoRobToggle == false then
                            wait()
                            break;
                        end
                    until v.Humanoid.Health <= 0
                    _G.LastPickupPos = game.Players.LocalPlayer.Character.Head.Position
                    wait(2.4)
                    findCash(CurrentATM, 20)
                    wait(.2)
                    grabCash()
                else
                    wait()
                end
            end
        end
    elseif _G.AutoRobToggle == true then
        _G.AutoRobToggle = false
        AutoRob.TextColor3 = Color3.new(1, 0, 0)
    end
end)

CloseX.MouseButton1Down:connect(function()
    MainGUI.Enabled = false
    SendAlert("Jump'd Alert",'Press "[" to re-open the GUI.',"0",3)
end)

AutoStomp.MouseButton1Down:connect(function()
    if _G.AutoStomp == true then
        _G.AutoStomp = false 
        AutoStomp.TextColor3 = Color3.new(1,0,0)
    else
        _G.AutoStomp = true
        AutoStomp.TextColor3 = Color3.new(0,1,0)
    end
end)

GodBlock.MouseButton1Down:connect(function()

end)

HospitalFarm.MouseButton1Down:connect(function()
    if _G.Hospital == false then
        _G.Hospital = true
        HospitalFarm.TextColor3 = Color3.new(0,1,0)
        local Directory = game.Workspace.Ignored.HospitalJob
        local RedName = "Can I get the Red bottle"
        local GreenName = "Can I get the Green bottle"
        local BlueName = "Can I get the Blue bottle"
        while _G.Hospital == true do wait()
            if Directory:FindFirstChildOfClass("Model") then
                local Model = Directory:FindFirstChildOfClass("Model")
                if Model.Name == RedName then
                    fireclickdetector(Directory.Red.ClickDetector)
                    wait()
                    fireclickdetector(Model:WaitForChild("ClickDetector"))
                elseif Model.Name == BlueName then
                    fireclickdetector(Directory.Blue.ClickDetector)
                    wait()
                    fireclickdetector(Model:WaitForChild("ClickDetector"))
                elseif Model.Name == GreenName then
                    fireclickdetector(Directory.Green.ClickDetector)
                    wait()
                    fireclickdetector(Model:WaitForChild("ClickDetector"))
                end
            else
                wait()
            end
        end
    elseif _G.Hospital == true then
        _G.Hospital = false
        HospitalFarm.TextColor3 = Color3.new(1, 0, 0)
    end
end)

fold = Instance.new("Folder", game.ReplicatedStorage)
fold.Name = "Seats"
for i,v in next, workspace:GetDescendants() do
    if v:IsA'Seat' then
        v.Parent = game.ReplicatedStorage.Seats
    end
end

local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

game:service("RunService").Stepped:connect(function()
    if _G.NoClipToggle == true then
        if game.Players.LocalPlayer.Character:FindFirstChild("BOOMBOXHANDLE") then
            game.Players.LocalPlayer.Character:FindFirstChild("BOOMBOXHANDLE"):Destroy()
            game.Players.LocalPlayer.Character:WaitForChild("UpperTorso").CanCollide = false
            game.Players.LocalPlayer.Character:WaitForChild("LowerTorso").CanCollide = false
            game.Players.LocalPlayer.Character:WaitForChild("Head").CanCollide = false
            game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CanCollide = false
        else
            if game.Players.LocalPlayer.Character:FindFirstChild("In-gameMask") then
                game.Players.LocalPlayer.Character:FindFirstChild("In-gameMask"):FindFirstChildOfClass("Model"):FindFirstChild("Head").CanCollide = false 
            end
            game.Players.LocalPlayer.Character:WaitForChild("UpperTorso").CanCollide = false
            game.Players.LocalPlayer.Character:WaitForChild("LowerTorso").CanCollide = false
            game.Players.LocalPlayer.Character:WaitForChild("Head").CanCollide = false
            game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CanCollide = false
        end
    elseif _G.NoClipToggle == false then
        wait()
    end
end)

ThrowGrenades.MouseButton1Down:Connect(function()
    for IterationOne=1,200 do
        for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.Name == "[Grenade]" then
                for IteraionTwo=1,200 do
                    v.Parent = game.Players.LocalPlayer.Character
                    v:Activate()
                end
            end
        end
    end
end)

Noclip.MouseButton1Down:connect(function()
    if _G.NoClipToggle == false then
        Noclip.TextColor3 = Color3.new(0, 1, 0)
        _G.NoClipToggle = true
    elseif _G.NoClipToggle == true then
        Noclip.TextColor3 = Color3.new(1, 0, 0)
        _G.NoClipToggle = false
    end
end)

AutoBlock.MouseButton1Down:connect(function()
    if _G.AutoBlockToggle == false then
        _G.AutoBlockToggle = true
        AutoBlock.TextColor3 = Color3.new(0, 1, 0)
    else
        _G.AutoBlockToggle = false
        AutoBlock.TextColor3 = Color3.new(1, 0, 0)
    end
end)

NoGunLoss.MouseButton1Down:connect(function()
    if _G.NGL == false then
        _G.NGL = true
        NoGunLoss.TextColor3 = Color3.new(0, 1, 0)
        while _G.NGL == true do wait()
            if game.Workspace.Players:FindFirstChild(game.Players.LocalPlayer.Name) and game.Workspace.Players:FindFirstChild(game.Players.LocalPlayer.Name):FindFirstChild("BodyEffects") and game.Workspace.Players:FindFirstChild(game.Players.LocalPlayer.Name):FindFirstChild("Humanoid") then
                if game.Players.LocalPlayer.Character.BodyEffects["K.O"].Value == true then
                    game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):UnequipTools()
                    game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):Destroy()
                else
                    wait()
                end
            else
                wait()
            end
        end
    elseif _G.NGL == true then
        NoGunLoss.TextColor3 = Color3.new(1, 0, 0)
        _G.NGL = false
    end
end)

NoMovementLimits.MouseButton1Down:connect(function()
    if _G.XXXXX == false then
        local Player = game.Players.LocalPlayer
        local Mouse = Player:GetMouse()
        Mouse.KeyDown:connect(function(input)
            local Character = Player.Character
            local Humanoid = Character.Humanoid
            local function FixCharacter()
                local RootPos = Character.HumanoidRootPart.Position
                local TeleportPos = RootPos + Vector3.new(-0.5,4.5,0)
                Character.HumanoidRootPart.CFrame = CFrame.new(TeleportPos)
            end
            if input:lower() == _G.PutDownKey and _G.NML == true then
                if Character:FindFirstChild("GRABBING_CONSTRAINT") then
                    Character:FindFirstChild("GRABBING_CONSTRAINT"):Destroy()
                    Humanoid.Sit = true
                    wait()
                    Humanoid.Jump = true
                    Humanoid.Sit = false
                    FixCharacter()
                    wait()
                    FixCharacter()
                end
            end
        end)
        _G.XXXXX = true
    end
    if _G.NML == false then
        _G.NML = true
        NoMovementLimits.TextColor3 = Color3.new(0, 1, 0)
        while _G.NML == true do wait()
            pcall(function()
                if game.Players.LocalPlayer.Character:FindFirstChild("Christmas_Sock") then
                    game.Players.LocalPlayer.Character:FindFirstChild("Christmas_Sock"):Destroy()
                end
            end)
            local Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
            local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
            local Animations = game.ReplicatedStorage.ClientAnimations
            local Stomp = game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):LoadAnimation(game.ReplicatedStorage.ClientAnimations.Stomp)
            for _,v in pairs(ActiveTracks) do
                if v.Name == "Stomp" and _G.NML == true then
                    if _G.NML == false then
                        break;
                    end
                    v:Stop()
                end
            end
        end
    elseif _G.NML == true then
        NoMovementLimits.TextColor3 = Color3.new(1, 0, 0)
        _G.NML = false
    end
end)

GetLockpick.MouseButton1Down:connect(function()
    local Dir = game.Workspace.Ignored.ItemsDrop
    local Player = game.Players.LocalPlayer

    for i,v in pairs(Dir:GetChildren()) do
        NumChild(v)
        if v.Name == "Part" and v.ClassName == "Part" then
            print("Has Parts")
            if _G.NoChildren == false then
                if v:FindFirstChild("[LockPicker]") then
                    v['[LockPicker]'].Handle.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    break;
                else
                    wait()
                end
            else
                wait()
            end
        else
            wait()
        end
    end
end)

GetKnife.MouseButton1Down:connect(function()
    local Dir = game.Workspace.Ignored.ItemsDrop
    local Player = game.Players.LocalPlayer

    for i,v in pairs(Dir:GetChildren()) do
        NumChild(v)
        if v.Name == "Part" and v.ClassName == "Part" then
            print("Has Parts")
            if _G.NoChildren == false then
                if v:FindFirstChild("[Knife]") then
                    v['[Knife]'].Handle.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    break;
                else
                    wait()
                end
            else
                wait()
            end
        else
            wait()
        end
    end
end)

GodBlock.MouseButton1Down:connect(function()
    if _G.GodBlock == true then
        GodBlock.TextColor3 = Color3.new(1,0,0)
        _G.GodBlock = false
    else
        _G.GodBlock = true
        GodBlock.TextColor3 = Color3.new(0,1,0)
        game.Players.LocalPlayer.Character.BodyEffects.Defense:Destroy()
        local x = Instance.new("IntValue", game.Players.LocalPlayer.Character.BodyEffects)
        x.Name = "Defense"
    end
end)

ToPlayer.MouseButton1Down:connect(function()
    for i,v in pairs(GetPlayer(PlayerNameTP.Text)) do
        tp(game.Players[v.Name].Character.HumanoidRootPart.CFrame)
        break;
    end
end)

ESPPlayers.MouseButton1Down:connect(function()
    if not(workspace:WaitForChild("ESPToggle").Value) == true then
        ESPPlayers.TextColor3 = Color3.new(0,1,0)
    elseif not(workspace:WaitForChild("ESPToggle").Value) == false then
        ESPPlayers.TextColor3 = Color3.new(1,0,0)
    end
    workspace:WaitForChild("ESPToggle").Value = not(workspace:WaitForChild("ESPToggle").Value)
end)

PlayerInfo.MouseButton1Down:connect(function()
    local Name = (function()
        for i,v in pairs(GetPlayer(PlayerName_PlayerText.Text)) do
            return v.Name
        end
    end)()
    local UserId = tostring(game.Players[Name].UserId)
    local Health = "N/A"
    local Knocked = "N/A"
    local IsAdmin = "N/A"
    local Money = addComas(tostring(game.Players:FindFirstChild(Name).DataFolder.Currency.Value))
    local Tools = {}
    for i,v in pairs(game.Players[Name].Backpack:GetChildren()) do
        if v:IsA("Tool") then
            table.insert(Tools, v.Name)
        end
    end
    if game.Players[Name].Character then
        pcall(function()
            Health = tostring(game.Players[Name].Character.Humanoid.Health).."/"..tostring(game.Players[Name].Character.Humanoid.MaxHealth)
            Knocked = tostring(game.Players[Name].Character.BodyEffects["K.O"].Value)
            IsAdmin = (function()
                if game.Players[Name].Backpack:FindFirstChild("AdminBan") then
                    return "Yes"
                else
                    return "No"
                end
            end)()	
            if game.Players[Name].Character:FindFirstChildOfClass("Tool") then
                table.insert(Tools, game.Players[Name].Character:FindFirstChildOfClass("Tool").Name)
            end
        end)
    end
    local ToolListString = (function()
        local TString = "";
        for i,v in pairs(Tools) do
            TString = TString.."\n "..v
        end
        return TString
    end)()
    warn('\n}----------------------{\n User: '..Name.." ["..UserId.."]\n Money: ".."$"..Money.."\n".." Health: "..Health.."\n Knocked: "..Knocked.."\n Is Admin: "..IsAdmin.."\n Tools:"..ToolListString.."\n}----------------------{")
end)


Arrest.MouseButton1Down:connect(function()
    local Name = (function()
        for i,v in pairs(GetPlayer(PlayerName_PlayerText.Text)) do
            return v.Name
        end
    end)()
    local CParts = {
        ["UpperTorso"] = true,
        ["LowerTorso"] = true
    }

    local TouchingFolder
    local TouchingObjValueLeft
    local TouchingObjValueRight

    if not game.ReplicatedStorage:FindFirstChild("Touching") then
        Touching = Instance.new("Folder", game.ReplicatedStorage)
        Touching.Name = "Touching"
        TouchingObjValueLeft = Instance.new("ObjectValue", Touching)
        TouchingObjValueLeft.Name = "TouchingObjectLeft"
        TouchingObjValueLeft.Value = nil
        TouchingObjValueRight = Instance.new("ObjectValue", Touching)
        TouchingObjValueRight.Name = "TouchingObjectRight"
        TouchingObjValueRight.Value = nil
    else
        TouchingObjValueRight = game.ReplicatedStorage:FindFirstChild("Touching").TouchingObjectRight
        TouchingObjValueLeft = game.ReplicatedStorage:FindFirstChild("Touching").TouchingObjectLeft
    end

    local LocalPlayer = game.Players.LocalPlayer
    local Character = LocalPlayer.Character

    for _,player in pairs(game.Players:GetChildren()) do
        if player == game.Players.LocalPlayer then
            for _,charpart in pairs(player.Character:GetChildren()) do
                if charpart.Name == "LeftFoot" or charpart.Name == "RightFoot" then
                    charpart.Touched:connect(function(touching_part)
                        if CParts[touching_part.Name] == true then
                            if charpart.Name == "LeftFoot" then
                                TouchingObjValueLeft.Value = touching_part
                            elseif charpart.Name == "RightFoot" then
                                TouchingObjValueRight.Value = touching_part
                            end
                        end
                    end)
                    charpart.TouchEnded:connect(function(touching_part)
                        if CParts[touching_part.Name] == true then
                            if charpart.Name == "LeftFoot" then
                                TouchingObjValueLeft.Value = nil
                            elseif charpart.Name == "RightFoot" then
                                TouchingObjValueRight.Value = nil
                            end
                        end
                    end)
                end
            end
        end
    end

    game.Players.LocalPlayer.CharacterAdded:connect(function()
        repeat wait() until Character:FindFirstChild("LeftFoot") and Character:FindFirstChild("RightFoot")
        for _,player in pairs(game.Players:GetChildren()) do
            if player == game.Players.LocalPlayer then
                for _,charpart in pairs(player.Character:GetChildren()) do
                    if charpart.Name == "LeftFoot" or charpart.Name == "RightFoot" then
                        charpart.Touched:connect(function(touching_part)
                            if CParts[touching_part.Name] == true then
                                if charpart.Name == "LeftFoot" then
                                    TouchingObjValueLeft.Value = touching_part
                                elseif charpart.Name == "RightFoot" then
                                    TouchingObjValueRight.Value = touching_part
                                end
                            end
                        end)
                        charpart.TouchEnded:connect(function(touching_part)
                            if CParts[touching_part.Name] == true then
                                if charpart.Name == "LeftFoot" then
                                    TouchingObjValueLeft.Value = nil
                                elseif charpart.Name == "RightFoot" then
                                    TouchingObjValueRight.Value = nil
                                end
                            end
                        end)
                    end
                end
            end
        end
    end)


    local function arrest(Who)
        pcall(function()
            local stateType = Enum.HumanoidStateType
            local humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
            humanoid:SetStateEnabled(stateType.FallingDown, false)
            humanoid:SetStateEnabled(stateType.Ragdoll, false)
            _G.ArrestTarget = game.Players[Who]
            _G.TryingToArrest = true
            local ArrestTries = 0
            while _G.TryingToArrest == true do wait(0.1)
                if _G.ArrestTarget.leaderstats.Wanted.Value == 0 then
                    break;
                end
                if ArrestTries == 50 then
                    _G.TryingToArrest = false
                    break;
                else
                    ArrestTries = ArrestTries + 1
                end
                if _G.ArrestTarget.Character.BodyEffects.Cuff == true then
                    _G.TryingToArrest = false
                    break;
                end
                if game.Players.LocalPlayer.Backpack:FindFirstChild("Cuff") then
                    game.Players.LocalPlayer.Backpack:FindFirstChild("Cuff").Parent = game.Players.LocalPlayer.Character
                end
                humanoid.Parent.HumanoidRootPart.CFrame = game.Players[Who].Character.UpperTorso.CFrame + Vector3.new(0,2.5,0)
                if game.ReplicatedStorage.Touching.TouchingObjectLeft.Value ~= nil and game.Players:FindFirstChild(game.ReplicatedStorage.Touching.TouchingObjectLeft.Value.Parent.Name) then
                    game.Players.LocalPlayer.Character:WaitForChild("Cuff"):Activate()
                    game.Players.LocalPlayer.Character:WaitForChild("Cuff").Parent = game.Players.LocalPlayer.Backpack
                else
                    if game.ReplicatedStorage.Touching.TouchingObjectRight.Value ~= nil and game.Players:FindFirstChild(game.ReplicatedStorage.Touching.TouchingObjectRight.Value.Parent.Name) then
                        game.Players.LocalPlayer.Character:WaitForChild("Cuff"):Activate()
                        game.Players.LocalPlayer.Character:WaitForChild("Cuff").Parent = game.Players.LocalPlayer.Backpack
                    end
                end
            end
        end)
    end

    arrest(Name)
end)

SilentAim.MouseButton1Down:connect(function()
    if _G.SilentAimEnabled == false then
        SilentAim.TextColor3 = Color3.new(0,1,0)
        _G.SilentAimEnabled = true
    else
        SilentAim.TextColor3 = Color3.new(1,0,0)
        _G.SilentAimEnabled = false
    end
end)

game.Players.LocalPlayer.Character.ChildAdded:connect(function(child)
    if child:FindFirstChild("Handle") and child:FindFirstChild("Ammo") and _G.P90FarmToggle then
        local Obj = child:FindFirstChild("Ammo")
        child:FindFirstChild("Ammo").Changed:connect(function()
            if Obj.Value == 0 then
                if Obj.Parent.Parent.Name ~= "Backpack" then
                    game:GetService("ReplicatedStorage").MainEvent:FireServer("Reload", Obj.Parent)
                end
            end
        end)
    end
end)

game:GetService('RunService').Stepped:Connect(function()
    pcall(function()
        if _G.P90FarmToggle then
            game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end)
end)

AutoReload.MouseButton1Down:connect(function()
    if _G.AutoReloadEnabled == false then
        AutoReload.TextColor3 = Color3.new(0,1,0)
        _G.AutoReloadEnabled = true
        game.Players.LocalPlayer.Character.ChildAdded:connect(function(child)
            if child:FindFirstChild("Handle") and child:FindFirstChild("Ammo") and _G.AutoReloadEnabled == true then
                local Obj = child:FindFirstChild("Ammo")
                child:FindFirstChild("Ammo").Changed:connect(function()
                    if Obj.Value == 0 then
                        if Obj.Parent.Parent.Name ~= "Backpack" and _G.AutoReloadEnabled == true then
                            game:GetService("ReplicatedStorage").MainEvent:FireServer("Reload", Obj.Parent)
                        end
                    end
                end)
            end
        end)
    else
        AutoReload.TextColor3 = Color3.new(1,0,0)
        _G.AutoReloadEnabled = false
    end
end)

GodMode.MouseButton1Down:connect(function()
    if _G.GodModeEnabled == false then
        GodMode.TextColor3 = Color3.new(0,1,0)
        _G.GodModeEnabled = true
        game.Players.LocalPlayer.Character:WaitForChild("BodyEffects"):FindFirstChild("Armor"):Destroy()
        local x = Instance.new("IntValue", game.Players.LocalPlayer.Character.BodyEffects)
        x.Value = math.huge
        x.Name = "Armor"
    else
        GodMode.TextColor3 = Color3.new(1,0,0)
        _G.GodModeEnabled = false
        game.Players.LocalPlayer.Character:WaitForChild("BodyEffects"):FindFirstChild("Armor"):Destroy()
        local x = Instance.new("IntValue", game.Players.LocalPlayer.Character.BodyEffects)
        x.Value = 0
        x.Name = "Armor"
    end
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function()
    wait(0.1)
    if _G.WSE == true then
        game.Players.LocalPlayer.Character:WaitForChild("BodyEffects")
        local Walkspeed = Instance.new("BoolValue", game.Players.LocalPlayer.Character:WaitForChild("BodyEffects"):FindFirstChild("Movement"))
        Walkspeed.Name = "SuperSpeed"
        Walkspeed.Value = true
    end
    if _G.JPE == true then
        local Jumppower = Instance.new("BoolValue", game.Players.LocalPlayer.Character:WaitForChild("BodyEffects"):FindFirstChild("Movement"))
        Jumppower.Name = "HulkJump"
        Jumppower.Value = true
    end
    if _G.GodModeEnabled == true then
        game.Players.LocalPlayer.Character:WaitForChild("BodyEffects"):FindFirstChild("Armor"):Destroy()
        local x = Instance.new("IntValue", game.Players.LocalPlayer.Character.BodyEffects)
        x.Value = math.huge
        x.Name = "Armor"
    end
    if _G.GodBlock == true then
        game.Players.LocalPlayer.Character.BodyEffects.Defense:Destroy()
        local x = Instance.new("IntValue", game.Players.LocalPlayer.Character.BodyEffects)
        x.Name = "Defense"
    end
    game.Players.LocalPlayer.Character.ChildAdded:connect(function(child)
        if child:FindFirstChild("Handle") and child:FindFirstChild("Ammo") and _G.AutoReloadEnabled == true then
            local Obj = child:FindFirstChild("Ammo")
            child:FindFirstChild("Ammo").Changed:connect(function()
                if Obj.Value == 0 then
                    if Obj.Parent.Parent.Name ~= "Backpack" and _G.AutoReloadEnabled == true then
                        game:GetService("ReplicatedStorage").MainEvent:FireServer("Reload", Obj.Parent)
                    end
                end
            end)
        end
    end)
    if _G.NML == true then
        delay(0,function()
            while _G.NML == true do wait()
                local Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
                local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
                local Animations = game.ReplicatedStorage.ClientAnimations
                local Stomp = game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):LoadAnimation(game.ReplicatedStorage.ClientAnimations.Stomp)
                for _,v in pairs(ActiveTracks) do
                    if v.Name == "Stomp" and _G.NML == true then
                        if _G.NML == false then
                            break;
                        end
                        v:Stop()
                    end
                end
            end
        end)
    end
end)



FlySpeedSetting.Changed:connect(function(T)
    if T == "Text" then
        _G.MSPEED = tonumber(FlySpeedSetting.Text)
    end
end)

EatStart.Changed:connect(function(T)
    if T == "Text" then
        _G.EatModule.StartHealth = tonumber(EatStart.Text)
    end
end)

EatReturn.Changed:connect(function(T)
    if T == "Text" then
        _G.EatModule.ReturningHealth = tonumber(EatReturn.Text)
    end
end)

Reach.MouseButton1Down:connect(function()
    _G.ReachToggle = not (_G.ReachToggle)
    if _G.ReachToggle then
        Reach.TextColor3 = Color3.new(0,1,0)
    else
        Reach.TextColor3 = Color3.new(1,0,0)
    end
end)

local Player = game.Players.LocalPlayer
local Character = Player.Character

Character.DescendantAdded:connect(function(Child)
    if _G.NML then
        if Child.Parent.Name == "Movement" or Child.Name == "Christmas_Sock" then
            if Child.Name ~= "Value" then
                wait()
                Child:Destroy()
            end
        end
    end
    if Child.Name == "TouchInterest" and _G.ReachToggle == true and Child.Parent.Parent.Name ~= "[BrownBag]" then
        pcall(function()
            for _,player in pairs(game.Players:GetChildren()) do
                if player ~= game.Players.LocalPlayer and player.Character then
                    firetouchinterest(player.Character:FindFirstChild("UpperTorso"), Child.Parent, 0)
                end
            end
        end)
    end
end)

Player.CharacterAdded:connect(function()
    Character = Player.Character
    wait()
    Character.DescendantAdded:connect(function(Child)
        if _G.NML then
            if Child.Parent.Name == "Movement" or Child.Name == "Christmas_Sock" then
                if Child.Name ~= "Value" then
                    wait()
                    Child:Destroy()
                end
            end
        end
        if Child.Name == "TouchInterest" and _G.ReachToggle == true and Child.Parent.Parent.Name ~= "[BrownBag]" then
            pcall(function()
                for _,player in pairs(game.Players:GetChildren()) do
                    if player ~= game.Players.LocalPlayer and player.Character then
                        firetouchinterest(player.Character:FindFirstChild("UpperTorso"), Child.Parent, 0)
                    end
                end
            end)
        end
    end)
end)

PunchPlayer.MouseButton1Down:connect(function()
    local LocalPlayer = game:GetService('Players').LocalPlayer
    local Character = LocalPlayer.Character
    local RunService = game:GetService("RunService")
    local LeftBodyPosition = (function()
        if not Character.LeftHand:FindFirstChild("BodyPosition") then
            local BodyPositionInstance = Instance.new("BodyPosition", Character.LeftHand)
            BodyPositionInstance.D = 1
            BodyPositionInstance.MaxForce = Vector3.new(700,700,700)
            return BodyPositionInstance
        else
            return Character.LeftHand:FindFirstChild("BodyPosition")
        end
    end)()
    local RightBodyPosition = (function()
        if not Character.RightHand:FindFirstChild("BodyPosition") then
            local BodyPositionInstance = Instance.new("BodyPosition", Character.RightHand)
            BodyPositionInstance.D = 1
            BodyPositionInstance.MaxForce = Vector3.new(700,700,700)
            return BodyPositionInstance
        else
            return Character.RightHand:FindFirstChild("BodyPosition")
        end
    end)()

    local Target = (function()
        for i,v in pairs(GetPlayer(PlayerName_PlayerText.Text)) do
            return v
        end
    end)()

    if Character.RightHand:FindFirstChild("RightWrist") then
        Character.RightHand.RightWrist:Destroy()
    end

    if Character.LeftHand:FindFirstChild("LeftWrist") then
        Character.LeftHand.LeftWrist:Destroy()
    end

    Character.Humanoid:UnequipTools()

    _G.TeleportLoop = RunService.Stepped:connect(function()
        Character.Humanoid:ChangeState(11)
        Character.RightHand.CFrame = Target.Character.HumanoidRootPart.CFrame - Vector3.new(0,13,0)
        Character.LeftHand.CFrame = Target.Character.HumanoidRootPart.CFrame - Vector3.new(0,13,0)
        RightBodyPosition.Position = Target.Character.HumanoidRootPart.Position - Vector3.new(0,13,0)
        LeftBodyPosition.Position = Target.Character.HumanoidRootPart.Position - Vector3.new(0,13,0)
    end)

    wait(1)

    Character.Humanoid:EquipTool(LocalPlayer.Backpack["Combat"])
    Character:FindFirstChild("Combat"):Activate()

    wait(2)

    _G.TeleportLoop:Disconnect()

    if Character.RightHand:FindFirstChild("BodyPosition") then Character.RightHand:FindFirstChild("BodyPosition"):Destroy() end
    if Character.LeftHand:FindFirstChild("BodyPosition") then Character.LeftHand:FindFirstChild("BodyPosition"):Destroy() end
    Character.RightHand.CFrame = Character.UpperTorso.CFrame
    Character.LeftHand.CFrame = Character.UpperTorso.CFrame
end)

BagPlayer.MouseButton1Down:connect(function()
    local Target = (function()
        for i,v in pairs(GetPlayer(PlayerName_PlayerText.Text)) do
            return v
        end
    end)()
    local Player = game.Players.LocalPlayer
    local PrevPos = Player.Character.HumanoidRootPart.CFrame
    Player.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Ignored.Shop["[BrownBag] - $25"].Head.CFrame
    wait(1)
    for i,v in pairs(game.Players:GetChildren()) do
        if v.Name ~= Player.Name and v.Character then
            if not Player.Backpack:FindFirstChild("[BrownBag]") then
                fireclickdetector(game:GetService("Workspace").Ignored.Shop["[BrownBag] - $25"].ClickDetector)
            end
            Player.Backpack:WaitForChild("[BrownBag]")
            Player.Backpack:WaitForChild("[BrownBag]").Parent = Player.Character
            wait(0.5)
            Player.Character.HumanoidRootPart.CFrame = PrevPos
            Player.Character:WaitForChild("[BrownBag]"):Activate()
            Player.Character:WaitForChild("[BrownBag]"):FindFirstChild("Handle"):WaitForChild("TouchInterest")
            firetouchinterest(Target.Character.UpperTorso, Player.Character:WaitForChild("[BrownBag]"):FindFirstChild("Handle"), 0)
        end
    end
end)

game:GetService("RunService").Stepped:Connect(function()
    if _G.PlayerLocked ~= nil then
        if game:GetService("Workspace").Ignored:FindFirstChild("Launcher") then
            local target = game:GetService'Workspace'.Ignored:FindFirstChild("Launcher")
            if target:FindFirstChild("BodyVelocity") then
                target:FindFirstChild("BodyVelocity"):Destroy()
            end
            local f = _G.PlayerLocked.Character.HumanoidRootPart.Changed:connect(function()
                target.CFrame = CFrame.new(_G.PlayerLocked.Character.HumanoidRootPart.Position) + Vector3.new(0,6.5,0)
            end)
            target.CFrame = CFrame.new(_G.PlayerLocked.Character.HumanoidRootPart.Position) + Vector3.new(0,6.5,0)
            delay(2,function()
                f:Disconnect()
            end)
        end
    end
end)


RPGLock.MouseButton1Down:connect(function()
    if PlayerName_PlayerText.Text == "" then
        _G.PlayerLocked = nil
    else
        local Target = (function()
            for i,v in pairs(GetPlayer(PlayerName_PlayerText.Text)) do
                return v
            end
        end)()
        _G.PlayerLocked = Target
    end	
end)

GunFly.MouseButton1Down:connect(function()
    local rdm = tostring(math.random(1,1000))
    _G.CurrentNameGunFly = rdm
    _G[rdm] = true
    local boop = coroutine.wrap(function()
        local plr = game.Players.LocalPlayer
        local mouse = plr:GetMouse()
        local cam = game:GetService'Workspace'.CurrentCamera
        local lp = game.Players.LocalPlayer
        cam.CameraType = 'Custom'
        localplayer = plr

        if workspace:FindFirstChild("Core") then
            workspace.Core:Destroy()
        end

        local partsers = Instance.new("Part", lp.Character)
        partsers.Transparency = 1
        partsers.CanCollide = false
        partsers.CFrame = lp.Character.Head.CFrame

        local Core = Instance.new("Part")
        Core.Name = "Core"
        Core.Size = Vector3.new(0.05, 0.05, 0.05)

        spawn(function()
            Core.Parent = workspace
            local Weld = Instance.new("Weld", Core)
            Weld.Part0 = Core
            Weld.Part1 = partsers
            Weld.C0 = CFrame.new(0, 0, 0)
        end)

        workspace:WaitForChild("Core")
        cam.CameraSubject = partsers
        local torso = workspace.Core
        flying = true
        local speed=10
        local keys={a=false,d=false,w=false,s=false} 
        local e1
        local e2
        local function start()
            local bodey = Instance.new("BodyPosition", lp.Character.RightHand)
            bodey.Name = 'rightwr'
            bodey.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bodey.D = 9e9
            bodey.P = 10000
            bodey.Position = Core.Position

            local bodee = Instance.new("BodyPosition", lp.Character.LeftHand)
            bodee.Name = 'leftwr'
            bodee.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bodee.D = 9e9
            bodee.P = 10000
            bodee.Position = Core.Position

            local pos = Instance.new("BodyPosition",torso)
            local gyro = Instance.new("BodyGyro",torso)
            pos.Name="EPIXPOS"
            pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
            pos.position = torso.Position
            gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9) 
            gyro.cframe = torso.CFrame
            repeat
                wait()
                localplayer.Character.Humanoid.PlatformStand=true
                local new=gyro.cframe - gyro.cframe.p + pos.position
                if not keys.w and not keys.s and not keys.a and not keys.d then
                    speed=5
                end
                if keys.w then 
                    new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                    speed=speed+0
                end
                if keys.s then 
                    new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                    speed=speed+0
                end
                if keys.d then 
                    new = new * CFrame.new(speed,0,0)
                    speed=speed+0
                end
                if keys.a then 
                    new = new * CFrame.new(-speed,0,0)
                    speed=speed+0
                end
                if speed>10 then
                    speed=5
                end
                pos.position=new.p
                if keys.w then
                    gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
                elseif keys.s then
                    gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
                else
                    gyro.cframe = workspace.CurrentCamera.CoordinateFrame
                end
            until flying == false or _G[rdm] == false
            if gyro then gyro:Destroy() end
            if pos then pos:Destroy() end
            if bodey then bodey:Destroy() end
            if bodee then bodee:Destroy() end
            _G[rdm] = false
            flying=false
            localplayer.Character.Humanoid.PlatformStand=false
            speed=10
        end
        e1=mouse.KeyDown:connect(function(key)
            if not torso or not torso.Parent then flying=false e1:disconnect() e2:disconnect() return end
            if key=="w" then
                keys.w=true
            elseif key=="s" then
                keys.s=true
            elseif key=="a" then
                keys.a=true
            elseif key=="d" then
                keys.d=true
            elseif key=="x" then
                if flying==true then
                    flying=false
                    _G[rdm] = false
                    cam.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
                else
                    flying=true
                    cam.CameraSubject = partsers
                    start()
                end
            end
        end)
        e2=mouse.KeyUp:connect(function(key)
            if key=="w" then
                keys.w=false
            elseif key=="s" then
                keys.s=false
            elseif key=="a" then
                keys.a=false
            elseif key=="d" then
                keys.d=false
            end
        end)
        start()
    end)
    boop()
    local chars = game.Players.LocalPlayer.Character
    game:GetService("RunService").Stepped:connect(function() --noclip
        if _G[rdm] then
            if chars:FindFirstChild("Humanoid") ~= nil and chars:FindFirstChild("Head") ~= nil then
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):ChangeState(11)
            end
        end
    end)

    game.Players.LocalPlayer.Character.RightHand.RightWrist:Destroy()
    game.Players.LocalPlayer.Character.LeftHand.LeftWrist:Destroy()

    local lp = game.Players.LocalPlayer
    local cam = game:GetService'Workspace'.CurrentCamera
    _G[rdm] = game:GetService("RunService").Stepped:Connect(function()
        if _G[rdm] then
            lp.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService'Workspace'.Core.Position) + Vector3.new(0,2000,0)
            lp.Character.RightHand.CFrame = CFrame.new(game:GetService'Workspace'.Core.Position)
            lp.Character.LeftHand.CFrame = CFrame.new(game:GetService'Workspace'.Core.Position)
        end
    end)

    Core.Changed:connect(function()
        if _G[rdm] then
            lp.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService'Workspace'.Core.Position) + Vector3.new(0,2000,0)
            lp.Character.RightHand.CFrame = CFrame.new(game:GetService'Workspace'.Core.Position)
            lp.Character.LeftHand.CFrame = CFrame.new(game:GetService'Workspace'.Core.Position)
        end
    end)
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function() 
    if workspace:FindFirstChild("Core") then
        workspace:FindFirstChild("Core"):Destroy()
    end
    _G[_G.CurrentNameGunFly] = false
end)

FlashBang.MouseButton1Down:connect(function()
    game.Players.LocalPlayer.Character.Humanoid.Changed:connect(function()
        game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(stateType.FallingDown, false)
        game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(stateType.Ragdoll, false)
    end)

    function tweenup(pos)
        local tweenService = game:GetService("TweenService")
        local partToTween = game.Players.LocalPlayer.Character.HumanoidRootPart
        local finalCframe = CFrame.new(pos) 
        local tweenInfo = TweenInfo.new(1.1, Enum.EasingStyle.Sine) 

        local tween = tweenService:Create(partToTween, tweenInfo, {CFrame = finalCframe}) 
        tween:Play()
    end

    function TrailSpam()
        local lp = game:GetService'Players'.LocalPlayer
        if not lp.Character.LeftHand:FindFirstChild("BodyPosition") then
            local bodeey = Instance.new("BodyPosition", lp.Character.LeftHand)
            bodeey.D = 1
            bodeey.MaxForce = Vector3.new(0,0,0)
        end
        if not lp.Character.RightHand:FindFirstChild("BodyPosition") then
            local bodee = Instance.new("BodyPosition", lp.Character.RightHand)
            bodee.D = 1
            bodee.MaxForce = Vector3.new(0,0,0)
        end
        wait()
        local bodeey = lp.Character.LeftHand:FindFirstChild("BodyPosition")
        local bodee =lp.Character.RightHand:FindFirstChild("BodyPosition")
        local lp = game:GetService("Players").LocalPlayer
        if lp.Character.RightHand:FindFirstChild("RightWrist") then
            lp.Character.RightHand.RightWrist:Destroy()
        end
        if lp.Character.LeftHand:FindFirstChild("LeftWrist") then
            lp.Character.LeftHand.LeftWrist:Destroy()
        end
        lp.Character.Humanoid:UnequipTools()
        lp.Character.Humanoid:EquipTool(lp.Backpack["Combat"])
        local postp = {
            CFrame.new(-954.342529, 90, 166.837296), 
            CFrame.new(130.153, 173.160294, -1354.48999),
            CFrame.new(961.021057, 90, 230),
            CFrame.new(463.102356, 90, 518.199585), 
            CFrame.new(992.213318, 90, -873.381531), 
            CFrame.new(240.491379, 90, -1273.5083), 
            CFrame.new(-1139.67273, 90, -1230.86694), 
            CFrame.new(-1251.28076, 90, -514.631531),
            CFrame.new(130.153, 173.160294, -1354.48999),
            CFrame.new(-954.342529, 90, 166.837296),
            CFrame.new(961.021057, 90, 230.306442),
            CFrame.new(463.102356, 90, 518.199585),
            CFrame.new(-954.342529, 90, 166.837296), 
            CFrame.new(463.102356, 90, 518.199585), 
            CFrame.new(992.213318, 90, -873.381531), 
            CFrame.new(240.491379, 90, -1273.5083), 
            CFrame.new(961.021057, 90, 230),
            CFrame.new(130.153, 173.160294, -1354.48999),
            CFrame.new(-1139.67273, 90, -1230.86694), 
            CFrame.new(-1251.28076, 90, -514.631531),
            CFrame.new(-954.342529, 90, 166.837296), 
            CFrame.new(463.102356, 90, 518.199585),
            CFrame.new(-954.342529, 90, 166.837296), 
            CFrame.new(463.102356, 90, 518.199585), 
            CFrame.new(992.213318, 90, -873.381531), 
            CFrame.new(240.491379, 90, -1273.5083), 
            CFrame.new(-1139.67273, 90, -1230.86694), 
            CFrame.new(961.021057, 90, 230),
            CFrame.new(-1251.28076, 90, -514.631531),
            CFrame.new(-954.342529, 90, 166.837296), 
            CFrame.new(463.102356, 90, 518.199585),
            CFrame.new(961.021057, 90, 230),
            CFrame.new(-954.342529, 90, 166.837296), 
            CFrame.new(130.153, 173.160294, -1354.48999),
            CFrame.new(463.102356, 90, 518.199585), 
            CFrame.new(992.213318, 90, -873.381531), 
            CFrame.new(-1153.1626, 55.6271172, -685.939575),
            CFrame.new(-1206.84583, 70.9403839, -203.551514),
            CFrame.new(240.491379, 90, -1273.5083), 
            CFrame.new(-1139.67273, 90, -1230.86694), 
            CFrame.new(-1251.28076, 90, -514.631531),
            CFrame.new(961.021057, 90, 230),
            CFrame.new(-954.342529, 90, 166.837296), 
            CFrame.new(463.102356, 90, 518.199585),
            CFrame.new(-954.342529, 90, 166.837296), 
            CFrame.new(961.021057, 90, 230),
            CFrame.new(463.102356, 90, 518.199585), 
            CFrame.new(992.213318, 90, -873.381531), 
            CFrame.new(240.491379, 90, -1273.5083), 
            CFrame.new(-1139.67273, 90, -1230.86694), 
            CFrame.new(-1251.28076, 90, -514.631531),
            CFrame.new(-954.342529, 90, 166.837296),
            CFrame.new(961.021057, 90, 230.306442),
            CFrame.new(463.102356, 90, 518.199585),
            CFrame.new(-1153.1626, 55.6271172, -685.939575),
            CFrame.new(-1206.84583, 70.9403839, -203.551514),
            CFrame.new(-954.342529, 90, 166.837296), 
            CFrame.new(463.102356, 90, 518.199585), 
            CFrame.new(992.213318, 90, -873.381531), 
            CFrame.new(240.491379, 90, -1273.5083), 
            CFrame.new(961.021057, 90, 230),
            CFrame.new(-1139.67273, 90, -1230.86694), 
            CFrame.new(-1251.28076, 90, -514.631531),
            CFrame.new(130.153, 173.160294, -1354.48999),
            CFrame.new(-954.342529, 90, 166.837296), 
            CFrame.new(463.102356, 90, 518.199585),
            CFrame.new(-954.342529, 90, 166.837296), 
            CFrame.new(463.102356, 90, 518.199585), 
            CFrame.new(992.213318, 90, -873.381531), 
            CFrame.new(240.491379, 90, -1273.5083), 
            CFrame.new(-1139.67273, 90, -1230.86694), 
            CFrame.new(961.021057, 90, 230),
            CFrame.new(-1251.28076, 90, -514.631531),
            CFrame.new(-954.342529, 90, 166.837296), 
            CFrame.new(-1153.1626, 55.6271172, -685.939575),
            CFrame.new(-1206.84583, 70.9403839, -203.551514),
            CFrame.new(463.102356, 90, 518.199585),
            CFrame.new(961.021057, 90, 230),
            CFrame.new(-954.342529, 90, 166.837296), 
            CFrame.new(130.153, 173.160294, -1354.48999),
            CFrame.new(463.102356, 90, 518.199585), 
            CFrame.new(992.213318, 90, -873.381531), 
            CFrame.new(240.491379, 90, -1273.5083), 
            CFrame.new(-1139.67273, 90, -1230.86694), 
            CFrame.new(-1251.28076, 90, -514.631531),
            CFrame.new(961.021057, 90, 230),
            CFrame.new(130.153, 173.160294, -1354.48999),
            CFrame.new(-954.342529, 90, 166.837296), 
            CFrame.new(463.102356, 90, 518.199585),
            CFrame.new(-1153.1626, 55.6271172, -685.939575),
            CFrame.new(-1206.84583, 70.9403839, -203.551514),

        }

        local chars = game.Players.LocalPlayer.Character
        _G.a = true
        lp.Character:FindFirstChild("Combat"):Activate()
        wait(2)
        for i=1, #postp do
            wait()
            lp.Character.RightHand.CFrame = postp[i]
            lp.Character.LeftHand.CFrame = postp[i]
            bodee.Position = lp.Character.RightHand.Position
            bodeey.Position = lp.Character.LeftHand.Position
        end
        wait()
        wait()
        bodee:Destroy()
        bodeey:Destroy()
        wait()
        wait()
        lp.Character.RightHand.CFrame = CFrame.new(lp.Character.UpperTorso.Position)
        lp.Character.LeftHand.CFrame = CFrame.new(lp.Character.UpperTorso.Position)
    end

    TrailSpam()
end)

game.Players.LocalPlayer.CharacterAdded:connect(function()
    if tonumber(game.Players.LocalPlayer.DataFolder.Information.Jail.Value) > 256 then
        game.Players.LocalPlayer.Character:WaitForChild("RagdollConstraints"):Destroy()
        local i = Instance.new("Folder",game.Players.LocalPlayer.Character)
        i.Name = "RagdollConstraints"
        game.Players.LocalPlayer.PlayerGui:WaitForChild("MainScreenGui"):WaitForChild("TimerJail").Position = UDim2.new(math.huge, math.huge, math.huge, math.huge)
        wait()
        local LoadedFolder = Instance.new("Folder", game.Players.LocalPlayer.Character)
        LoadedFolder.Name = "FULLY_LOADED_CHAR"
        game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
        game.Players.LocalPlayer.Character:WaitForChild("BodyEffects"):WaitForChild("K.O"):GetPropertyChangedSignal("Value"):Connect(function()
            if game.Players.LocalPlayer.Character:WaitForChild("BodyEffects"):WaitForChild("K.O").Value == true then
                game.Players.LocalPlayer.Character:WaitForChild("BodyEffects"):WaitForChild("K.O").Value = false
            end
        end)
    end
end)

P90Farm.MouseButton1Down:Connect(function()
    _G.P90FarmToggle = not(_G.P90FarmToggle)
    if _G.P90FarmToggle then
        P90Farm.TextColor3 = Color3.new(0,1,0)
        _G.farmGlobals = {
            ["targetCashier"] = nil,
            ["currentWeapon"] = nil,
            ["casherPosition"] = Vector3.new(0,0,0),
            ["lastPickup"] = Vector3.new(0,0,0)
        }

        local farmFunctions = {
            ["HasGun"] = function(weaponName)
                if Player.Backpack:FindFirstChild(weaponName) or Character:FindFirstChild(weaponName) then
                    return true
                end
                return false
            end,
            ["CheckAmmo"] = function(WeaponName)
                if Player.DataFolder.Inventory:FindFirstChild(WeaponName) then
                    return (Player.DataFolder.Inventory:FindFirstChild(WeaponName).Value == "0")
                end
            end,
            ["ShootGun"] = function(Weapon, Times)
                for Iteration=1,Times do wait()
                    game.ReplicatedStorage.MainEvent:FireServer("ShootButton")
                end
            end,
            ["BuyAmmo"] = function()
                local OldCFrame = CFrame.new(Character:FindFirstChild("HumanoidRootPart").Position)
                local GunPosition = CFrame.new(game:GetService("Workspace").Ignored.Shop["120 [P90 Ammo] - $60"].Head.Position)
                Character:FindFirstChild("[P90]").Parent = Player.Backpack
                _G.farmGlobals["BuyingAmmo"] = true
                wait(0.1)
                Character:FindFirstChild("HumanoidRootPart").CFrame = GunPosition
                wait(0.3)
                fireclickdetector(game:GetService("Workspace").Ignored.Shop["120 [P90 Ammo] - $60"].ClickDetector)
                wait(0.3)
                Character:FindFirstChild("HumanoidRootPart").CFrame = OldCFrame
                wait(0.1)
                _G.farmGlobals["BuyingAmmo"] = false
                Player.Backpack:FindFirstChild("[P90]").Parent = Character
                Character:WaitForChild("[P90]")
                game.ReplicatedStorage.MainEvent:FireServer("Reload", Character:WaitForChild("[P90]"))
            end
        }
        while _G.P90FarmToggle do wait()
            for _,Cashier in pairs(game:GetService("Workspace").Cashiers:GetChildren()) do
                if _G.P90FarmToggle == false then break end
                if Cashier.Humanoid.Health > 0 then
                    if farmFunctions["CheckAmmo"]("[P90]") then
                        farmFunctions["BuyAmmo"]()
                    end
                    _G.farmGlobals["targetCashier"] = Cashier
                    _G.farmGlobals["cashierPosition"] = Cashier.Head.Position
                    if farmFunctions.HasGun("[P90]") then
                        _G.farmGlobals["currentWeapon"] = Player.Backpack:FindFirstChild("[P90]") or Character:FindFirstChild("[P90]")
                        repeat wait()
                            if not Character:FindFirstChild("[P90]") then
                                Player.Backpack:FindFirstChild("[P90]").Parent = Character
                            end
                            if farmFunctions["CheckAmmo"]("[P90]") then
                                farmFunctions["BuyAmmo"]()
                            else
                                if not _G.farmGlobals["BuyingAmmo"] then 
                                    Character:FindFirstChild("HumanoidRootPart").CFrame = Cashier.Head.CFrame * CFrame.new(3,0,3)
                                    repeat wait()
                                        if farmFunctions["CheckAmmo"]("[P90]") then
                                            farmFunctions["BuyAmmo"]()
                                        else
                                            farmFunctions["ShootGun"](Character:FindFirstChild("[P90]"), 1)
                                        end
                                    until Cashier.Humanoid.Health <= 0 or _G.farmGlobals["BuyingAmmo"] == true or _G.P90FarmToggle == false
                                end
                            end
                        until Cashier.Humanoid.Health <= 0 or _G.farmGlobals["BuyingAmmo"] == true or _G.P90FarmToggle == false
                        local LastPickup = nil
                        for _,Cash in pairs(game:GetService("Workspace").Ignored.Drop:GetChildren()) do
                            if Cash.Name == "MoneyDrop" then
                                if LastPickup == nil then
                                    if (Character:FindFirstChild("HumanoidRootPart").Position - Cash.Position).magnitude < 30 then
                                        Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(Cash.Position)
                                        wait(0.5)
                                        fireclickdetector(Cash.ClickDetector)
                                        LastPickup = Cash.Position
                                        wait(0.85)
                                    end
                                else
                                    if (LastPickup - Cash.Position).magnitude < 30 then
                                        Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(Cash.Position)
                                        wait(0.5)
                                        fireclickdetector(Cash.ClickDetector)
                                        LastPickup = Cash.Position
                                        wait(0.85)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    else
        P90Farm.TextColor3 = Color3.new(1,0,0)
    end
end)

spawn(function()
    local Sides = {
        Enum.NormalId.Top,
        Enum.NormalId.Bottom,
        Enum.NormalId.Back,
        Enum.NormalId.Front,
        Enum.NormalId.Right,
        Enum.NormalId.Left
    }

    local CharacterPartNames = {
        ["Enum.HumanoidRigType.R15"] = {
            ["LeftFoot"] = true,
            ["LeftHand"] = true,
            ["LeftLowerArm"] = true,
            ["LeftLowerLeg"] = true,
            ["LeftUpperArm"] = true,
            ["LeftUpperLeg"] = true,
            ["LowerTorso"] = true,
            ["RightFoot"] = true,
            ["RightHand"] = true,
            ["RightLowerArm"] = true,
            ["RightLowerLeg"] = true,
            ["RightUpperArm"] = true,
            ["RightUpperLeg"] = true,
            ["UpperTorso"] = true,
            ["Head"] = true
        },
        ["Enum.HumanoidRigType.R6"] = {
            ["Head"] = true,
            ["Torso"] = true,
            ["Left Arm"] = true,
            ["Left Leg"] = true,
            ["Right Arm"] = true,
            ["Right Leg"] = true
        }
    }

    for _,Player in pairs(game.Players:GetPlayers()) do
        if Player ~= game.Players.LocalPlayer then
            Player.CharacterAdded:Connect(function()
                Player.Character:WaitForChild("Humanoid")
                local UIFolder = Instance.new("Folder", Player.Character)
                UIFolder.Name = "UIs"
                local NameTag = Instance.new("BillboardGui", Player.Character)
                NameTag.AlwaysOnTop = true
                NameTag.Name = "Name"
                NameTag.Size = UDim2.new(1,0,1,0)
                NameTag.StudsOffset = Vector3.new(0, 2, 0)
                NameTag.Adornee = Player.Character.Head
                NameTag.Enabled = (function()
                    return workspace:WaitForChild("ESPToggle").Value
                end)()
                workspace:WaitForChild("ESPToggle").Changed:Connect(function()
                    NameTag.Enabled = workspace:WaitForChild("ESPToggle").Value
                end)
                local NameText = Instance.new("TextLabel", NameTag)
                NameText.BackgroundTransparency = 1
                NameText.Size = UDim2.new(1,0,1,0)
                NameText.TextColor3 = Color3.new(1,1,1)
                NameText.Text = Player.Name
                for _,Part in pairs(Player.Character:GetChildren()) do
                    if CharacterPartNames[tostring(Player.Character.Humanoid.RigType)][Part.Name] then
                        local FolderPart = Instance.new("Folder", UIFolder)
                        FolderPart.Name = Part.Name
                        for _,Side in pairs(Sides) do
                            local SGui = Instance.new("SurfaceGui", FolderPart)
                            SGui.AlwaysOnTop = true
                            SGui.Name = tostring(Side)
                            SGui.Face = Side
                            SGui.Adornee = Part
                            SGui.Enabled = (function()
                                return workspace:WaitForChild("ESPToggle").Value
                            end)()
                            workspace:WaitForChild("ESPToggle").Changed:Connect(function()
                                SGui.Enabled = workspace:WaitForChild("ESPToggle").Value
                            end)
                            local Frame = Instance.new("Frame", SGui)
                            Frame.Name = "SurfaceFrame"
                            Frame.Size = UDim2.new(1, 0, 1, 0)
                            Frame.BorderSizePixel = 0
                            Frame.BackgroundColor = BrickColor.new("Institutional white")
                            Frame.Transparency = 0.4
                        end
                    end
                end
            end)
            Player.Character:WaitForChild("Humanoid")
            local UIFolder = Instance.new("Folder", Player.Character)
            UIFolder.Name = "UIs"
            local NameTag = Instance.new("BillboardGui", Player.Character)
            NameTag.AlwaysOnTop = true
            NameTag.Name = "Name"
            NameTag.Size = UDim2.new(1,0,1,0)
            NameTag.StudsOffset = Vector3.new(0, 2, 0)
            NameTag.Adornee = Player.Character.Head
            NameTag.Enabled = (function()
                return workspace:WaitForChild("ESPToggle").Value
            end)()
            workspace:WaitForChild("ESPToggle").Changed:Connect(function()
                NameTag.Enabled = workspace:WaitForChild("ESPToggle").Value
            end)
            local NameText = Instance.new("TextLabel", NameTag)
            NameText.BackgroundTransparency = 1
            NameText.Size = UDim2.new(1,0,1,0)
            NameText.TextColor3 = Color3.new(1,1,1)
            NameText.Text = Player.Name
            for _,Part in pairs(Player.Character:GetChildren()) do
                if CharacterPartNames[tostring(Player.Character.Humanoid.RigType)][Part.Name] then
                    local FolderPart = Instance.new("Folder", UIFolder)
                    FolderPart.Name = Part.Name
                    for _,Side in pairs(Sides) do
                        local SGui = Instance.new("SurfaceGui", FolderPart)
                        SGui.AlwaysOnTop = true
                        SGui.Name = tostring(Side)
                        SGui.Face = Side
                        SGui.Adornee = Part
                        SGui.Enabled = (function()
                            return workspace:WaitForChild("ESPToggle").Value
                        end)()
                        workspace:WaitForChild("ESPToggle").Changed:Connect(function()
                            SGui.Enabled = workspace:WaitForChild("ESPToggle").Value
                        end)
                        local Frame = Instance.new("Frame", SGui)
                        Frame.Name = "SurfaceFrame"
                        Frame.Size = UDim2.new(1, 0, 1, 0)
                        Frame.BorderSizePixel = 0
                        Frame.BackgroundColor = BrickColor.new("Institutional white")
                        Frame.Transparency = 0.2
                    end
                end
            end
        end
    end

    game.Players.PlayerAdded:Connect(function(Player)
        Player.CharacterAdded:Connect(function()
            Player.Character:WaitForChild("Humanoid")
            local UIFolder = Instance.new("Folder", Player.Character)
            UIFolder.Name = "UIs"
            local NameTag = Instance.new("BillboardGui", Player.Character)
            NameTag.AlwaysOnTop = true
            NameTag.Name = "Name"
            NameTag.Size = UDim2.new(1,0,1,0)
            NameTag.StudsOffset = Vector3.new(0, 2, 0)
            NameTag.Adornee = Player.Character.Head
            NameTag.Enabled = (function()
                return workspace:WaitForChild("ESPToggle").Value
            end)()
            workspace:WaitForChild("ESPToggle").Changed:Connect(function()
                NameTag.Enabled = workspace:WaitForChild("ESPToggle").Value
            end)
            local NameText = Instance.new("TextLabel", NameTag)
            NameText.BackgroundTransparency = 1
            NameText.TextColor3 = Color3.new(1,1,1)
            NameText.Size = UDim2.new(1,0,1,0)
            NameText.Text = Player.Name
            for _,Part in pairs(Player.Character:GetChildren()) do
                if CharacterPartNames[tostring(Player.Character.Humanoid.RigType)][Part.Name] then
                    local FolderPart = Instance.new("Folder", UIFolder)
                    FolderPart.Name = Part.Name
                    for _,Side in pairs(Sides) do
                        local SGui = Instance.new("SurfaceGui", FolderPart)
                        SGui.AlwaysOnTop = true
                        SGui.Name = tostring(Side)
                        SGui.Face = Side
                        SGui.Adornee = Part
                        SGui.Enabled = (function()
                            return workspace:WaitForChild("ESPToggle").Value
                        end)()
                        workspace:WaitForChild("ESPToggle").Changed:Connect(function()
                            SGui.Enabled = workspace:WaitForChild("ESPToggle").Value
                        end)
                        local Frame = Instance.new("Frame", SGui)
                        Frame.Name = "SurfaceFrame"
                        Frame.Size = UDim2.new(1, 0, 1, 0)
                        Frame.BorderSizePixel = 0
                        Frame.BackgroundColor = BrickColor.new("Institutional white")
                        Frame.Transparency = 0.4
                    end
                end
            end
        end)
    end)
end)