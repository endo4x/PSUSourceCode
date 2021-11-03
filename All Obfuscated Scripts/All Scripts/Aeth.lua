--[[
	id: 9uusoKJaVhyoxbk3I6vvd
	name: Aeth
	description: yes
	time1: 2021-04-25 05:27:28.576471+00
	time2: 2021-04-25 05:27:28.576472+00
	uploader: ttbmFjdN-pmYaSmBXCWzQ1wao7I4YsXZyauEBwp7
	uploadersession: We_kQxgTMyjgo_TRKeuGOKWj-JYWNk
	flag: f
--]]


local Library = loadstring(game:HttpGet("https://pastebin.com/raw/JDqrguuu"))()

do
    local AgentHub = game.Players.LocalPlayer.PlayerGui:FindFirstChild("ovGJf1u0JA")
    if AgentHub then AgentHub:Destroy() end
end

local Window = Library.CreateLib("AgentHub - Aethelbeorn","Ocean")
local Tab = Window:NewTab("Main")
local Key = Window:NewTab("Keybinds")
local credits = Window:NewTab("Credits")

local Main = Tab:NewSection("Main")
local Keybinds = Key:NewSection("Keybinds")


local creditscredits = credits:NewSection("credits")

creditscredits:NewButton("Creator - xe#0001")
creditscredits:NewButton("Kavo Ui Library")
creditscredits:NewButton("https://discord.gg/BwKQbUkr3k")





--<< Locals >>--
local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()


--<< Main Section >>-- 
Main:NewButton("Ragdoll", "floppa", function(state)
    local args = {
        [1] = "Fall"
    }
    
    game:GetService("ReplicatedStorage").Fall_Request:FireServer(unpack(args))
end)

    
Main:NewButton("Instant Self Revive", "revive me i have a raygun", function(state)

local sex = game.Players.LocalPlayer.Character.Humanoid
local xd = "(#%*#%*#%A@$#*%#)(%#)%&#*"

workspace[game.Players.LocalPlayer.Name].Stomp_Kick_Revive_Client.Revive_Event:FireServer(sex, xd)
end)
Main:NewToggle("Unlimited Stamina","fast forever" ,function(state)
    local mydata = require(game:GetService("Players").LocalPlayer.PlayerGui.Client.Status.Stamina.Data)
if state then
	mydata.Using_Rate = 0
else
    mydata.Using_Rate = 0.5
end
end);

Main:NewToggle("Regen Stamina Fast","fast regen" ,function(state)
    local mydata = require(game:GetService("Players").LocalPlayer.PlayerGui.Client.Status.Stamina.Data)
if state then
	mydata.Regen_Rate = 15
	mydata.Regen_Rate_2 = 15
else
    mydata.Regen_Rate = 1.2
	mydata.Regen_Rate_2 = 2
end
end)

Main:NewToggle("Infinite Jump","jump forever" ,function(state)
    _G.state = state
    Mouse.KeyDown:connect(function(k)
    if _G.state == true then
    if k:byte() == 32 then
    Humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    Humanoid:ChangeState("Jumping")
    wait(0.1)
    Humanoid:ChangeState("Seated")
    end
    end
    end)
end);



--<< Combat >>--


--<< Keybinds >>--
Keybinds:NewKeybind("Toggle UI","open or close cheat",Enum.KeyCode.RightShift,function()
	Library:ToggleUI()
end);
