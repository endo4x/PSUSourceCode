--[[
	id: n8RRbdqzd50KAa6VdPLzI
	name: Utilities Hub Beta
	description: Beta version of Utilities Hub
	time1: 2021-06-26 00:59:39.95053+00
	time2: 2021-06-26 00:59:39.95053+00
	uploader: W8FWkprIhNQI7YQ7QPOCyvO4IKY4ZDXoHwppQrFA
	uploadersession: kwQzQ1-KWp1i1xlgg3opWMxfNCbkD1
	flag: f
--]]

local DiscordLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt")()
local gameName = true
local marketplaceService = game:GetService("MarketplaceService")
local jgfuncs = false

    local isSuccessful, info = pcall(marketplaceService.GetProductInfo, marketplaceService, game.PlaceId)
    if isSuccessful then
        gameName = info.Name
    end
local lastsavedwalkspeed = "NewUser"
local newUser = false
if isfile("UtilitiesHub/SavedWalkspeed.txt") then
lastsavedwalkspeed = readfile("UtilitiesHub/SavedWalkspeed.txt")
else
lastsavedwalkspeed = "NewUser"
end

local lastsavedjumppower = "NewUser"
local newUser = false
if isfile("UtilitiesHub/SavedJumppower.txt") then
lastsavedjumppower = readfile("UtilitiesHub/SavedJumppower.txt")
else
lastsavedjumppower = "NewUser"
end
if syn then
   if isfolder("UtilitiesHub") then
       print("Found data folder. Successfully retrieved data.")
    else
        makefolder("UtilitiesHub")
        newUser = true
    end
end
if syn then
   if isfolder('UtilitiesHub/AutoExecute') then
    if isfile('UtilitiesHub/AutoExecute/InfiniteYield.txt') then
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
    if isfile('UtilitiesHub/AutoExecute/CMDX.txt') then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source", true))()
    end
    if isfile('UtilitiesHub/AutoExecute/SimpleSpy.txt') then
        loadstring(game:HttpGet("https://github.com/exxtremestuffs/SimpleSpySource/raw/master/SimpleSpy.lua"))()
    end
    if isfile('UtilitiesHub/AutoExecute/FatesAdmin.txt') then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua"))()
    end
    if isfile('UtilitiesHub/AutoExecute/HBAdmin.txt') then
       _G.CustomUI = false
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/mgamingpro/HomebrewAdmin/master/Main'),true))()
    end
    end
end
local chosenName = "Utilities Hub"
if syn then -- Check if script is being executed with synapse
    if isfile('UtilitiesHub/CustomName.txt') then -- Check if the blur file exists
        print("Found a custom name, setting up.") -- If yes, we wont make another one
        chosenName = readfile("UtilitiesHub/CustomName.txt")
    else
        chosenName = "Utilities Hub"
    end
end

local win = DiscordLib:Window(chosenName .. ' | Playing ' .. gameName)

local serv = win:Server("Scripts", "")

local btns = serv:Channel("Admin")
if newUser == true then
    DiscordLib:Notification("New User", "Welcome to Utilities Hub. We created a data folder in your Synapse X workspace.", "Okay!")
end
if gameName == "just grass [One Player]" then
 	DiscordLib:Notification("Game Detected", "Utilities Hub detected that you are playing Just Grass. We have loaded custom Just Grass functions for you.", "Nice!")
 	jgfuncs = true
end
btns:Label("Popular Admin Scripts")

btns:Button("Infinite Yield", function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
DiscordLib:Notification("Admin Scripts", "Successfully executed Infinite Yield. Press ; to use it.", "Okay!")
end)

btns:Button("CMD-X", function()
DiscordLib:Notification("Admin Scripts", "Successfully executed CMD-X", "Okay!")
end)

btns:Seperator()

btns:Label("Discontinued Admin Scripts")

btns:Button("Fates Admin", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua"))()
DiscordLib:Notification("Admin Scripts", "Successfully executed Fates Admin. Press ; to use it.", "Okay!")
end)

btns:Seperator()

btns:Label("Unfinished Admin Scripts")

btns:Button("Homebrew Admin", function()
_G.CustomUI = false
loadstring(game:HttpGet(('https://raw.githubusercontent.com/mgamingpro/HomebrewAdmin/master/Main'),true))()
DiscordLib:Notification("Admin Scripts", "Successfully executed Homebrew Admin. Press . to use it.", "Okay!")
end)
local tgls = serv:Channel("Toggles")

tgls:Toggle("Auto-Farm",false, function(bool)
    
print(bool)
end)

local drops = serv:Channel("Auto-Execute")

local chosenOption = true
drops:Label("WARNING:")
drops:Label("UI will load slower if you use this.")
drops:Seperator()
local drop = drops:Dropdown("Choose a script to Auto-Execute",{"Infinite Yield","CMD-X","SimpleSpy","Fates Admin","Homebrew Admin"}, function(bool)
    chosenOption = bool
print(bool)
end)

drops:Button("Add to Auto-Execute", function()
print(chosenOption)
if syn then
if isfolder('UtilitiesHub/AutoExecute') then
   print("AutoExecute folder exists")
else
    makefolder('UtilitiesHub/AutoExecute')
end
end
if syn then
    if chosenOption == "Infinite Yield" then
       if isfile('UtilitiesHub/AutoExecute/InfiniteYield.txt') then
           DiscordLib:Notification("Auto-Execute", "Infinite Yield is already in your Auto-Execute", "Okay!")
        else
            writefile("UtilitiesHub/AutoExecute/InfiniteYield.txt", "true")
            DiscordLib:Notification("Auto-Execute", "Successfully added Infinite Yield to your Auto-Execute", "Okay!")
       end
    elseif chosenOption == "CMD-X" then
        if isfile('UtilitiesHub/AutoExecute/CMDX.txt') then
           DiscordLib:Notification("Auto-Execute", "CMD-X is already in your Auto-Execute", "Okay!")
        else
            writefile("UtilitiesHub/AutoExecute/CMDX.txt", "true")
            DiscordLib:Notification("Auto-Execute", "Successfully added CMD-X to your Auto-Execute", "Okay!")
        end
    elseif chosenOption == "SimpleSpy" then
        if isfile('UtilitiesHub/AutoExecute/SimpleSpy.txt') then
           DiscordLib:Notification("Auto-Execute", "SimpleSpy is already in your Auto-Execute", "Okay!")
        else
            writefile("UtilitiesHub/AutoExecute/SimpleSpy.txt", "true")
            DiscordLib:Notification("Auto-Execute", "Successfully added SimpleSpy to your Auto-Execute", "Okay!")
        end
    elseif chosenOption == "Fates Admin" then
        if isfile('UtilitiesHub/AutoExecute/FatesAdmin.txt') then
           DiscordLib:Notification("Auto-Execute", "Fates Admin is already in your Auto-Execute", "Okay!")
        else
            writefile("UtilitiesHub/AutoExecute/FatesAdmin.txt", "true")
            DiscordLib:Notification("Auto-Execute", "Successfully added Fates Admin to your Auto-Execute", "Okay!")
        end
    elseif chosenOption == "Homebrew Admin" then
        if isfile('UtilitiesHub/AutoExecute/HBAdmin.txt') then
           DiscordLib:Notification("Auto-Execute", "Homebrew Admin is already in your Auto-Execute", "Okay!")
        else
            writefile("UtilitiesHub/AutoExecute/HBAdmin.txt", "true")
            DiscordLib:Notification("Auto-Execute", "Successfully added Homebrew Admin to your Auto-Execute", "Okay!")
        end
    end
end
end)

drops:Button("Remove from Auto-Execute", function()
if syn then
    if chosenOption == "Infinite Yield" then
       if isfile('UtilitiesHub/AutoExecute/InfiniteYield.txt') then
           delfile("UtilitiesHub/AutoExecute/InfiniteYield.txt")
           DiscordLib:Notification("Auto-Execute", "Infinite Yield has been successfully removed from your Auto-Execute", "Okay!")
        else
            DiscordLib:Notification("Auto-Execute", "Infinite Yield is not in your Auto-Execute", "Okay!")
       end
    elseif chosenOption == "CMD-X" then
        if isfile('UtilitiesHub/AutoExecute/CMDX.txt') then
           delfile("UtilitiesHub/AutoExecute/CMDX.txt")
           DiscordLib:Notification("Auto-Execute", "CMD-X has been successfully removed from your Auto-Execute", "Okay!")
        else
            DiscordLib:Notification("Auto-Execute", "CMD-X is not in your Auto-Execute", "Okay!")
        end
    elseif chosenOption == "SimpleSpy" then
        if isfile('UtilitiesHub/AutoExecute/SimpleSpy.txt') then
           delfile("UtilitiesHub/AutoExecute/SimpleSpy.txt")
           DiscordLib:Notification("Auto-Execute", "SimpleSpy has been successfully removed from your Auto-Execute", "Okay!")
        else
            DiscordLib:Notification("Auto-Execute", "SimpleSpy is not in your Auto-Execute", "Okay!")
        end
    elseif chosenOption == "Fates Admin" then
        if isfile('UtilitiesHub/AutoExecute/FatesAdmin.txt') then
           delfile("UtilitiesHub/AutoExecute/FatesAdmin.txt")
           DiscordLib:Notification("Auto-Execute", "Fates Admin has been successfully removed from your Auto-Execute", "Okay!")
        else
            DiscordLib:Notification("Auto-Execute", "Fates Admin is not in your Auto-Execute", "Okay!")
        end
    elseif chosenOption == "Homebrew Admin" then
        if isfile('UtilitiesHub/AutoExecute/HBAdmin.txt') then
           delfile("UtilitiesHub/AutoExecute/HBAdmin.txt")
           DiscordLib:Notification("Auto-Execute", "Homebrew Admin has been successfully removed from your Auto-Execute", "Okay!")
        else
            DiscordLib:Notification("Auto-Execute", "Homebrew Admin is not in your Auto-Execute", "Okay!")
        end
    end
end
end)

drops:Seperator()

drops:Label("Scripts that were Auto-Executed on last execution:")

if isfile('UtilitiesHub/AutoExecute/InfiniteYield.txt') then
    drops:Label("- Infinite Yield")
end

if isfile('UtilitiesHub/AutoExecute/CMDX.txt') then
    drops:Label("- CMD-X")
end

if isfile('UtilitiesHub/AutoExecute/FatesAdmin.txt') then
    drops:Label("- Fates Admin")
end

if isfile('UtilitiesHub/AutoExecute/SimpleSpy.txt') then
    drops:Label("- SimpleSpy")
end

if isfile('UtilitiesHub/AutoExecute/HBAdmin.txt') then
    drops:Label("- Homebrew Admin")
end

local clrs = serv:Channel("Just Grass")

clrs:Colorpicker("ESP Color", Color3.fromRGB(255,1,1), function(t)
print(t)
end)

local textbs = serv:Channel("Textboxes")

textbs:Textbox("Gun power", "Type here!", true, function(t)
print(t)
end)

local lbls = serv:Channel("Labels")

lbls:Label("This is just a label.")

local bnds = serv:Channel("Binds")

bnds:Bind("Kill bind", Enum.KeyCode.RightShift, function()
print("Killed everyone!")
end)


local lplay = win:Server("Local Player", "")
local cust = win:Server("Customization", "")
local infopage = win:Server("Information", "http://www.roblox.com/asset/?id=6031075938")
local UIname = cust:Channel("UI Name")

UIname:Textbox("Custom UI Name", "Enter a custom name here", true, function(t)
if syn then -- Check if script is being executed with synapse
    writefile("UtilitiesHub/CustomName.txt", t)
end
DiscordLib:Notification("Name Change", 'Successfully switched name to ' .. t .. '. Changes will take effect once UI is re-executed.', "Okay!")
print(t)
end)
UIname:Button("Reset Name to Utilities Hub", function()
if syn then -- Check if script is being executed with synapse
    if isfile('UtilitiesHub/CustomName.txt') then
        delfile("UtilitiesHub/CustomName.txt")
        DiscordLib:Notification("Name Reset", "Successfully reset name. Changes will take effect once UI is re-executed.", "Okay!")
    else
        DiscordLib:Notification("Name Reset", "Cannot reset name due to there being no custom name", "Okay!")
    end
end

end)
local sldrs = lplay:Channel("Player Values")

local sldr = sldrs:Slider("Walkspeed", 0, 1000, 16, function(t)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = t
if syn then
    writefile("UtilitiesHub/SavedWalkspeed.txt", t)
end
end)

sldrs:Button("Regular Walkspeed", function()
sldr:Change(16)
end)

sldrs:Button("Saved Walkspeed From Last Execution", function()
if lastsavedwalkspeed == "NewUser" then
    DiscordLib:Notification("Walkspeed", "This is your first time using the walkspeed slider so we do not have previous data.", "Okay!")
else
    sldr:Change(lastsavedwalkspeed)
end
end)

local jpsldr = sldrs:Slider("Jumppower", 0, 1000, 50, function(t)
game.Players.LocalPlayer.Character.Humanoid.JumpPower = t
if syn then
    writefile("UtilitiesHub/SavedJumppower.txt", t)
end
end)

sldrs:Button("Regular Jumppower", function()
jpsldr:Change(50)
end)

sldrs:Button("Saved Jumppower From Last Execution", function()
if lastsavedjumppower == "NewUser" then
    DiscordLib:Notification("Jumppower", "This is your first time using the jumppower slider so we do not have previous data.", "Okay!")
else
    jpsldr:Change(lastsavedjumppower)
end
end)


local genr = infopage:Channel("General Info")

genr:Label("Q: Where is my settings and data for the UI being stored?")
genr:Label("A: S^X Folder -> Workspace -> UtilitiesHub")
genr:Label("Q: Can I tamper with the data in the data folder?")
genr:Label("A: Yes, but there is no need as you can change everything")
genr:Label("through the UI itself.")

local creds = infopage:Channel("Credits")

creds:Label("Hub Maker and Lead Developer: allstonks")
creds:Label("UI Designer: Dawid (Check out his UI Libraries!)")