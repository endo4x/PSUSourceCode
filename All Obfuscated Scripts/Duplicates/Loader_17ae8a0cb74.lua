--[[
	id: Sgb7mDnp__WAhuCV6R5BN
	name: Loader
	description: Loader for script
	time1: 2021-06-22 03:23:23.757646+00
	time2: 2021-06-22 03:23:23.757652+00
	uploader: hgrfPIwb39h_kmXkTOlAynB23ARoTsLeW1ISIQhO
	uploadersession: Xuk8dhdV6Oq6PQMNYMhhZRdfCfBr_f
	flag: f
--]]

-- Gui to Lua
-- Version: 3.2

-- Instances:

local PixelHub = Instance.new("Folder")
local PixelHubLoader = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Background = Instance.new("ImageLabel")
local ConfirmKey = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local Shadow = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local TextLabel = Instance.new("TextLabel")
local EnterKey = Instance.new("ImageLabel")
local TextBox = Instance.new("TextBox")
local CloseButton = Instance.new("ImageButton")
local PixelHubStart = Instance.new("ScreenGui")
local Main_2 = Instance.new("Frame")
local Background_2 = Instance.new("ImageLabel")
local Execute = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local TextLabel_2 = Instance.new("TextLabel")
local clear = Instance.new("ImageButton")
local check = Instance.new("ImageButton")
local Save = Instance.new("TextButton")
local TextLabel_3 = Instance.new("TextLabel")

--Properties:

PixelHub.Name = "PixelHub"
PixelHub.Parent = game:WaitForChild("CoreGui")

PixelHubLoader.Name = "PixelHub Loader"
PixelHubLoader.Parent = PixelHub
PixelHubLoader.Enabled = false

Main.Name = "Main"
Main.Parent = PixelHubLoader
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Main.BackgroundTransparency = 1.000
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.Size = UDim2.new(0, 300, 0, 150)
Main.ZIndex = 2

Background.Name = "Background"
Background.Parent = Main
Background.AnchorPoint = Vector2.new(0.5, 0.5)
Background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Background.BackgroundTransparency = 1.000
Background.Position = UDim2.new(0.5, 0, 0.5, 0)
Background.Size = UDim2.new(1, 50, 1, 50)
Background.Image = "rbxassetid://3570695787"
Background.ImageColor3 = Color3.fromRGB(0, 0, 0)
Background.ScaleType = Enum.ScaleType.Slice
Background.SliceCenter = Rect.new(100, 100, 100, 100)
Background.SliceScale = 0.250

ConfirmKey.Name = "ConfirmKey"
ConfirmKey.Parent = Background
ConfirmKey.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
ConfirmKey.BorderSizePixel = 0
ConfirmKey.Position = UDim2.new(0.240714297, 0, 0.650000036, 0)
ConfirmKey.Size = UDim2.new(0, 180, 0, 45)
ConfirmKey.ZIndex = 2
ConfirmKey.Font = Enum.Font.GothamSemibold
ConfirmKey.Text = ""
ConfirmKey.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmKey.TextScaled = true
ConfirmKey.TextSize = 14.000
ConfirmKey.TextWrapped = true

UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = ConfirmKey

Shadow.Name = "Shadow"
Shadow.Parent = ConfirmKey
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BorderSizePixel = 0
Shadow.Size = UDim2.new(1, 0, 1, 4)

UICorner_2.CornerRadius = UDim.new(1, 0)
UICorner_2.Parent = Shadow

TextLabel.Parent = ConfirmKey
TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderColor3 = Color3.fromRGB(27, 42, 53)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.5, 0, 0.544444442, 0)
TextLabel.Size = UDim2.new(1, -20, 1, -20)
TextLabel.ZIndex = 2
TextLabel.Font = Enum.Font.GothamSemibold
TextLabel.Text = "Confirm Key"
TextLabel.TextColor3 = Color3.fromRGB(255, 163, 26)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

EnterKey.Name = "EnterKey"
EnterKey.Parent = Background
EnterKey.AnchorPoint = Vector2.new(0.5, 0.5)
EnterKey.BackgroundColor3 = Color3.fromRGB(255, 163, 26)
EnterKey.BackgroundTransparency = 1.000
EnterKey.Position = UDim2.new(0.498571575, 0, 0.375, 0)
EnterKey.Size = UDim2.new(0, 250, 0, 50)
EnterKey.Image = "rbxassetid://3570695787"
EnterKey.ImageColor3 = Color3.fromRGB(255, 163, 26)
EnterKey.ScaleType = Enum.ScaleType.Slice
EnterKey.SliceCenter = Rect.new(100, 100, 100, 100)
EnterKey.SliceScale = 0.250

TextBox.Parent = EnterKey
TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BackgroundTransparency = 1.000
TextBox.BorderSizePixel = 0
TextBox.Position = UDim2.new(0.495999992, 0, 0.495000005, 0)
TextBox.Size = UDim2.new(0, 250, 0, 50)
TextBox.Font = Enum.Font.SourceSans
TextBox.Text = "Enter Key"
TextBox.TextColor3 = Color3.fromRGB(38, 38, 38)
TextBox.TextScaled = true
TextBox.TextSize = 30.000
TextBox.TextWrapped = true

CloseButton.Name = "CloseButton"
CloseButton.Parent = Background
CloseButton.BackgroundTransparency = 1.000
CloseButton.LayoutOrder = 4
CloseButton.Position = UDim2.new(0.926724553, 0, -0.00390505791, 0)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.ZIndex = 2
CloseButton.Image = "rbxassetid://3926305904"
CloseButton.ImageRectOffset = Vector2.new(4, 4)
CloseButton.ImageRectSize = Vector2.new(24, 24)

PixelHubStart.Name = "PixelHub Start"
PixelHubStart.Parent = PixelHub

Main_2.Name = "Main"
Main_2.Parent = PixelHubStart
Main_2.AnchorPoint = Vector2.new(0.5, 0.5)
Main_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Main_2.BackgroundTransparency = 1.000
Main_2.BorderSizePixel = 0
Main_2.Position = UDim2.new(0.5, 0, 0.5, 0)
Main_2.Size = UDim2.new(0, 200, 0, 200)

Background_2.Name = "Background"
Background_2.Parent = Main_2
Background_2.AnchorPoint = Vector2.new(0.5, 0.5)
Background_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Background_2.BackgroundTransparency = 1.000
Background_2.Position = UDim2.new(0.5, 0, 0.5, 0)
Background_2.Size = UDim2.new(1, 50, 1, 50)
Background_2.Image = "rbxassetid://3570695787"
Background_2.ImageColor3 = Color3.fromRGB(0, 0, 0)
Background_2.ScaleType = Enum.ScaleType.Slice
Background_2.SliceCenter = Rect.new(100, 100, 100, 100)
Background_2.SliceScale = 0.250

Execute.Name = "Execute"
Execute.Parent = Background_2
Execute.BackgroundColor3 = Color3.fromRGB(255, 163, 26)
Execute.BorderSizePixel = 0
Execute.Position = UDim2.new(0.140000001, 0, 0.224000007, 0)
Execute.Size = UDim2.new(0, 180, 0, 45)
Execute.ZIndex = 2
Execute.Font = Enum.Font.GothamSemibold
Execute.Text = ""
Execute.TextColor3 = Color3.fromRGB(255, 255, 255)
Execute.TextScaled = true
Execute.TextSize = 14.000
Execute.TextWrapped = true

UICorner_3.CornerRadius = UDim.new(1, 0)
UICorner_3.Parent = Execute

TextLabel_2.Parent = Execute
TextLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1.000
TextLabel_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
TextLabel_2.BorderSizePixel = 0
TextLabel_2.Position = UDim2.new(0.5, 0, 0.5, 0)
TextLabel_2.Size = UDim2.new(1, -20, 1, -20)
TextLabel_2.ZIndex = 2
TextLabel_2.Font = Enum.Font.GothamSemibold
TextLabel_2.Text = "Execute Script"
TextLabel_2.TextColor3 = Color3.fromRGB(27, 27, 27)
TextLabel_2.TextScaled = true
TextLabel_2.TextSize = 14.000
TextLabel_2.TextWrapped = true

clear.Name = "clear"
clear.Parent = Background_2
clear.BackgroundTransparency = 1.000
clear.LayoutOrder = 3
clear.Position = UDim2.new(0.176464111, 0, 0.785494626, 0)
clear.Size = UDim2.new(0, 50, 0, 50)
clear.ZIndex = 2
clear.Image = "rbxassetid://3926305904"
clear.ImageRectOffset = Vector2.new(924, 724)
clear.ImageRectSize = Vector2.new(36, 36)

check.Name = "check"
check.Parent = Background_2
check.BackgroundTransparency = 1.000
check.LayoutOrder = 4
check.Position = UDim2.new(0.619014978, 0, 0.78302598, 0)
check.Size = UDim2.new(0, 50, 0, 50)
check.ZIndex = 2
check.Image = "rbxassetid://3926305904"
check.ImageRectOffset = Vector2.new(312, 4)
check.ImageRectSize = Vector2.new(24, 24)

Save.Name = "Save"
Save.Parent = Background_2
Save.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
Save.BorderSizePixel = 0
Save.Position = UDim2.new(0.140000001, 0, 0.54400003, 0)
Save.Size = UDim2.new(0, 180, 0, 45)
Save.ZIndex = 2
Save.Font = Enum.Font.GothamSemibold
Save.Text = ""
Save.TextColor3 = Color3.fromRGB(255, 255, 255)
Save.TextScaled = true
Save.TextSize = 14.000
Save.TextWrapped = true

TextLabel_3.Parent = Save
TextLabel_3.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.BackgroundTransparency = 1.000
TextLabel_3.BorderColor3 = Color3.fromRGB(27, 42, 53)
TextLabel_3.BorderSizePixel = 0
TextLabel_3.Position = UDim2.new(0.5, 0, 0.5, 0)
TextLabel_3.Size = UDim2.new(1, -20, 1, -20)
TextLabel_3.ZIndex = 2
TextLabel_3.Font = Enum.Font.GothamSemibold
TextLabel_3.Text = "Save Key"
TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.TextScaled = true
TextLabel_3.TextSize = 14.000
TextLabel_3.TextWrapped = true

-- Scripts:

local function UDVDHQ_fake_script() -- PixelHubLoader.Loader
    local script = Instance.new("LocalScript", PixelHubLoader)

    local config
    local folder = script.Parent.Parent
    local loader = script.Parent
    local close = loader.Main.Background.CloseButton
    local enter = loader.Main.Background.EnterKey
    local confirm = loader.Main.Background.ConfirmKey

    confirm.MouseButton1Click:connect(
        function()
            config = game:GetService("HttpService"):JSONDecode(readfile("pixelhub.fun"))
            _G.Key = enter.TextBox.Text
            local settings = {
                Key = _G.Key,
                QuickLoad = config.QuickLoad
            }
            writefile("pixelhub.fun", game:GetService("HttpService"):JSONEncode(settings))
            folder:Destroy()
            _G.Settings = {
                ["key"] = _G.Key,
                ["whitelist"] = "https://riprippixel.000webhostapp.com/script/whitelist.php?key=",
                ["blacklist"] = "https://riprippixel.000webhostapp.com/script/blacklist.php?userid=",
                ["webhook"] = game:HttpGet("https://riprippixel.000webhostapp.com/script/webhook.php?key=pixel"),
                ["text"] = "Invalid Key"
            }
            _G.keycheck = game:HttpGet(_G.Settings.whitelist .. _G.Settings.key)
            _G.blacklistcheck = game:HttpGet(_G.Settings.blacklist .. game:GetService("Players").LocalPlayer.UserId)
            if _G.keycheck == nil then
                _G.keycheck = "Invalid"
            end
            if _G.blacklistcheck == "blacklisted" then
                _G.blacklistcheck = true
            else
                _G.blacklistcheck = false
            end
            local a = os.date("%X", os.time())
            local b = game:GetService("Players").LocalPlayer
            local c = {
                content = "<@&829021839027863594>",
                embeds = {
                    {
                        title = "PixelHub Executed!",
                        description = "**" .. b.Name .. "** is using PixelHub! \n Time: " .. a,
                        type = "rich",
                        url = "https://www.roblox.com/users/" .. b.UserId .. "/profile",
                        color = 000000,
                        author = {
                            name = "riprippixel#6969",
                            url = "http://discord.com/users/631574325262155796",
                            icon_url = "https://cdn.discordapp.com/avatars/631574325262155796/634116b78c81b6e6041b3d26325aa0c8.png?size=256"
                        },
                        thumbnail = {
                            url = "https://cdn.discordapp.com/icons/812077049526616085/d6e571847e4ff0cae0b767ad2ecac8ee.png"
                        },
                        image = {
                            url = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username=" ..
                                tostring(b.Name)
                        }
                    },
                    {
                        title = "User Info",
                        description = "User: " ..
                            b.Name ..
                                " | " ..
                                    b.UserId ..
                                        "\n Key: " ..
                                            _G.Key ..
                                                " | " ..
                                                    _G.keycheck ..
                                                        " Key" .. "\n Blacklisted: " .. tostring(_G.blacklistcheck),
                        author = {
                            name = "pixelhub.fun",
                            icon_url = "https://cdn.discordapp.com/icons/812077049526616085/d6e571847e4ff0cae0b767ad2ecac8ee.png"
                        }
                    }
                }
            }
            local d = game:GetService("HttpService"):JSONEncode(c)
            local e = {["content-type"] = "application/json"}
            request = syn.request
            local f = {Url = _G.Settings.webhook, Body = d, Method = "POST", Headers = e}
            request(f)
            if _G.blacklistcheck == true then
                b:kick("Blacklisted")
            elseif _G.isLoader ~= true then
                b:kick("Wrong Script")
            end
            loadstring(game:HttpGet("https://riprippixel.000webhostapp.com/script/script"))()
        end
    )

    close.MouseButton1Click:connect(
        function()
            folder:Destroy()
        end
    )
end
coroutine.wrap(UDVDHQ_fake_script)()
local function BPJTV_fake_script() -- PixelHubStart.Start
    local script = Instance.new("LocalScript", PixelHubStart)

    local config
    local settings = {
        Key = false,
        QuickLoad = false
    }
    if isfile("pixelhub.fun") then
        config = game:GetService("HttpService"):JSONDecode(readfile("pixelhub.fun"))
        local settings = {
            Key = config.Key,
            QuickLoad = config.QuickLoad
        }
    else
        writefile("pixelhub.fun", game:GetService("HttpService"):JSONEncode(settings))
        repeat
            wait()
        until isfile("pixelhub.fun")
    end
    local folder = script.Parent.Parent
    local start = script.Parent
    local loader = script.Parent.Parent["PixelHub Loader"]
    local check = start.Main.Background.check
    local clear = start.Main.Background.clear
    local exec = start.Main.Background.Execute
    local save = start.Main.Background.Save
    local savetext = save.TextLabel

    config = game:GetService("HttpService"):JSONDecode(readfile("pixelhub.fun"))
    if config.QuickLoad == true then
        check.ImageColor3 = Color3.new(0, 1, 0)
        clear.ImageColor3 = Color3.new(1, 1, 1)
        settings.QuickLoad = true
    elseif config.QuickLoad == false then
        clear.ImageColor3 = Color3.new(1, 0, 0)
        check.ImageColor3 = Color3.new(1, 1, 1)
        settings.QuickLoad = false
    end

    check.MouseButton1Click:connect(
        function()
            check.ImageColor3 = Color3.new(0, 1, 0)
            clear.ImageColor3 = Color3.new(1, 1, 1)
            settings.QuickLoad = true
        end
    )
    clear.MouseButton1Click:connect(
        function()
            clear.ImageColor3 = Color3.new(1, 0, 0)
            check.ImageColor3 = Color3.new(1, 1, 1)
            settings.QuickLoad = false
        end
    )
    save.MouseButton1Click:connect(
        function()
            for i = 1, 3 do
                if config.Key ~= false then
                    savetext.Text = ("Key: " .. config.Key .. " (" .. (4 - i) .. ")")
                else
                    savetext.Text = ("No Key Saved" .. " (" .. (4 - i) .. ")")
                end
                wait(1)
            end
            savetext.Text = ("Save Key")
        end
    )
    exec.MouseButton1Click:connect(
        function()
            _G.isLoader = true
            config = game:GetService("HttpService"):JSONDecode(readfile("pixelhub.fun"))
            start:Destroy()
            if
                isfile("pixelhub.fun") and config.QuickLoad == true and config.Key ~= false and
                    settings.QuickLoad == true
             then
                _G.Key = config.Key
                folder:Destroy()
                _G.Settings = {
                    ["key"] = _G.Key,
                    ["whitelist"] = "https://riprippixel.000webhostapp.com/script/whitelist.php?key=",
                    ["blacklist"] = "https://riprippixel.000webhostapp.com/script/blacklist.php?userid=",
                    ["webhook"] = game:HttpGet("https://riprippixel.000webhostapp.com/script/webhook.php?key=pixel"),
                    ["text"] = "Invalid Key"
                }
                _G.keycheck = game:HttpGet(_G.Settings.whitelist .. _G.Settings.key)
                _G.blacklistcheck = game:HttpGet(_G.Settings.blacklist .. game:GetService("Players").LocalPlayer.UserId)
                if _G.keycheck == nil then
                    _G.keycheck = "Invalid"
                end
                if _G.blacklistcheck == "blacklisted" then
                    _G.blacklistcheck = true
                else
                    _G.blacklistcheck = false
                end
                local a = os.date("%X", os.time())
                local b = game:GetService("Players").LocalPlayer
                local c = {
                    content = "<@&829021839027863594>",
                    embeds = {
                        {
                            title = "PixelHub Executed!",
                            description = "**" .. b.Name .. "** is using PixelHub! \n Time: " .. a,
                            type = "rich",
                            url = "https://www.roblox.com/users/" .. b.UserId .. "/profile",
                            color = 000000,
                            author = {
                                name = "riprippixel#6969",
                                url = "http://discord.com/users/631574325262155796",
                                icon_url = "https://cdn.discordapp.com/avatars/631574325262155796/634116b78c81b6e6041b3d26325aa0c8.png?size=256"
                            },
                            thumbnail = {
                                url = "https://cdn.discordapp.com/icons/812077049526616085/d6e571847e4ff0cae0b767ad2ecac8ee.png"
                            },
                            image = {
                                url = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username=" ..
                                    tostring(b.Name)
                            }
                        },
                        {
                            title = "User Info",
                            description = "User: " ..
                                b.Name ..
                                    " | " ..
                                        b.UserId ..
                                            "\n Key: " ..
                                                _G.Key ..
                                                    " | " ..
                                                        _G.keycheck ..
                                                            " Key" .. "\n Blacklisted: " .. tostring(_G.blacklistcheck),
                            author = {
                                name = "pixelhub.fun",
                                icon_url = "https://cdn.discordapp.com/icons/812077049526616085/d6e571847e4ff0cae0b767ad2ecac8ee.png"
                            }
                        }
                    }
                }
                local d = game:GetService("HttpService"):JSONEncode(c)
                local e = {["content-type"] = "application/json"}
                request = syn.request
                local f = {Url = _G.Settings.webhook, Body = d, Method = "POST", Headers = e}
                request(f)
                if _G.blacklistcheck == true then
                    b:kick("Blacklisted")
                elseif _G.isLoader ~= true then
                    b:kick("Wrong Script")
                end
                loadstring(game:HttpGet("https://riprippixel.000webhostapp.com/script/script"))()
            else
                writefile("pixelhub.fun", game:GetService("HttpService"):JSONEncode(settings))
                repeat
                    wait()
                until isfile("pixelhub.fun")
                loader.Enabled = true
            end
        end
    )
end
coroutine.wrap(BPJTV_fake_script)()
