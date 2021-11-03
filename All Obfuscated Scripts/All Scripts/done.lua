--[[
	id: mY-WXZ-d_3WPAlLln_soZ
	name: done
	description: bruh
	time1: 2021-06-21 10:40:47.290867+00
	time2: 2021-06-21 10:40:47.290868+00
	uploader: seYJnfjCx6KjwX_7aQDi643O63iMIVdYBaVgoyya
	uploadersession: qhTmhyL-zPdyhF02stRXf6OOBmIFny
	flag: f
--]]

getgenv().farming = {
    ["Rokakaka"] = false,
    ["Gold Coin"] = false,
    ["Mysterious Arrow"] = false,
    ["Diamond"] = false,
    ["Lucky Arrow"] = false,
    ["Zepellin's Headband"] = false,
    ["Quinton's Glove"] = false,
    ["Ancient Scroll"] = false,
    ["DEO's Diary"] = false,
    ["Steel Ball"] = false,
    ["Rib Cage of The Saint's Corpse"] = false,
    ["Pure Rokakaka"] = false,
    ["Stone Mask"] = false
}


local metatable = getrawmetatable(game)
local newindex = metatable.__newindex
setreadonly(metatable, false)
_G.Items = {}
metatable.__newindex = newcclosure(function(t, i, v)
    if t == game:GetService("ReplicatedStorage").ItemSpawn and i == "OnClientInvoke" then
        old = v
        v = function(...)
            local args = {...}
            table.insert(_G.Items, {
                Replica = args[2]["Replica"],
                CFrame = args[2]["CFrame"],
                CD = args[2]["CD"]
            })
            return old(...)
        end
    end
    return newindex(t, i, v)
end)


local plr = game:GetService("Players").LocalPlayer
local character = plr.Character or plr.CharacterAdded:Wait();
local core = game:GetService("StarterGui")
local checkscript = getscripthash
local runservice = game:GetService("RunService")
--
local function notify(message, daily)
    core:SetCore("SendNotification", {
        Title = "Alert System",
        Text = tostring(message),
        Duration = tonumber(daily)
    })
end

repeat wait() until character:FindFirstChild("HumanoidRootPart")

local Client
for i, v in pairs(getnilinstances()) do
    if v:IsA("ModuleScript") and v.Name == "Client" then
        Client = v
        break
    end
end

local hash = "86d29efcf2fbf285c355410ca70ea8bdd5cbfc9b7abedb3a8166ef091d69b1138d24a1697781e352422dc1537b58277d"

notify("Checking Detections", 5)
if checkscript(Client) ~= tostring(hash) then
    notify("Warning yba have been updated if you still using the gui you agree that you might get banned", 15)
else
    notify("You All Good No Updates Detected!", 5)
end

notify("Applying Bypass")

local metatable = getrawmetatable(game)
local namecall = metatable.__namecall 
setreadonly(metatable,false)
metatable.__namecall = newcclosure(function(self,...)
    local args = {...} 
    local method = getnamecallmethod()
    if method == "InvokeServer" then 
        if args[1] == "idklolbrah2de" then
            return "  ___XP DE KEY"
        elseif  args[1] == "SigL" or method:lower() == "kick" then
            return wait(9e9)
          end 
      end 
     return namecall(self,...)
end ) 
local metatable = getrawmetatable(game)
local index = metatable.__index
setreadonly(metatable, false)
metatable.__index = newcclosure(function(t, k)
    if t == "Humanoid" and k == "WalkSpeed" then
        return 16
    elseif t == "Humanoid" and k == "JumpPower" then
        return 50
    end
    return index(t, k)
end)
notify("Applied")

local function start()
    fireproximityprompt(workspace.Dialogues["ShiftPlox, The Travelling Merchant"].ProximityPrompt, 0)
    wait()
end

-- Functions
function attack()
    local args = {
        [1] = "Attack",
        [2] = "m1"
    }
    game.Players.LocalPlayer.Character.RemoteFunction:InvokeServer(unpack(args))
end

local function sellitem()
    local A_1 = "EndDialogue"
    local A_2 = {
        ["NPC"] = "Merchant",
        ["Option"] = "Option2",
        ["Dialogue"] = "Dialogue1"
    }
    local Event = game:GetService("Players").LocalPlayer.Character.RemoteEvent
    Event:FireServer(A_1, A_2)

    local A_1 = "EndDialogue"
    local A_2 = {
        ["NPC"] = "Merchant",
        ["Option"] = "Option2",
        ["Dialogue"] = "Dialogue5"
    }
    local Event = game:GetService("Players").LocalPlayer.Character.RemoteEvent
    Event:FireServer(A_1, A_2)
end

local function spin()
    local A_1 = "DialogueInteracted"
    local A_2 = {
        ["DialogueName"] = "Item Machine",
        ["Speaker"] = "Item Machine"
    }
    local Event = game:GetService("Players").LocalPlayer.Character.RemoteEvent
    Event:FireServer(A_1, A_2)

    local A_1 = "EndDialogue"
    local A_2 = {
        ["NPC"] = "Item Machine",
        ["Option"] = "Option1",
        ["Dialogue"] = "Dialogue1"
    }
    local Event = game:GetService("Players").LocalPlayer.Character.RemoteEvent
    Event:FireServer(A_1, A_2)
end
--

repeat wait() until plr.LoadedData.Value == true 
wait(10) 

game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
    wait(1)
    local remotes = {}

    for i, v in pairs(getgc()) do
        if typeof(v) == "function" and tostring(getfenv(v).script) == "Client" and #debug.getprotos(v) == 7 then
            for i2, v2 in pairs(debug.getupvalues(v)) do
                table.insert(remotes, tostring(v2))
            end
            if table.find(remotes, "RemoteEvent") and table.find(remotes, "RemoteFunction") then
               pcall(function()
                    table.foreach(debug.getconstants(v),print)
                    local constants = debug.getconstants(v)
                     for i3 ,k in pairs(constants) do 
                         debug.setconstant(v,1,nil)
                           debug.setconstant(v,2,nil)
                       end 
                    end)
                break
            end
        end
    end
end ) 

-- Weird ass  shit--

-- Grab tools
tools = {}
for i, v in pairs(game.ReplicatedStorage.Tool_Replicas:GetChildren()) do
    table.insert(tools, v.Name)
end

-- Grab Locations


locations = {}
for i, v in pairs(game:GetService("Workspace").Locations:GetChildren()) do
    table.insert(locations, v.Name)
end

-- Grab  npc's

npcs2 = {}
for i, v in pairs(game.Workspace.Dialogues:GetChildren()) do
    table.insert(npcs2, v.Name)
end

-- Npcs
npcs = {} -- this is the issue.
table.insert(npcs, "None")
table.insert(npcs, "Officer Sam")
table.insert(npcs, "Deputy Bertrude")
table.insert(npcs, "Lion Abbacho's Partner")
table.insert(npcs, "Homless Man Jill")
table.insert(npcs, "Dracula")
table.insert(npcs, "Zeppelin")
table.insert(npcs, "Cars")
table.insert(npcs, "Dopey")
table.insert(npcs, "Deo")
table.insert(npcs, "Rico Pushie")

-- Mobs

-- Get NPCs
-- Mobs

mobs = {}
for i, v in pairs(game:GetService("Workspace").Mob_Spawns:GetChildren()) do
    if table.find(mobs, v.Name) then
    else
        table.insert(mobs, v.Name)
    end
end

for i, v in pairs(game:GetService("Workspace")["Mob_Spawns2"]:GetChildren()) do
    if table.find(mobs, v.Name) then
        else
        table.insert(mobs, v.Name)
    end
end


--
local Library = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/fluxlib.txt")()
local Window = Library:Window("YBA", "yba cuz yes")
local ItemFarm = Window:Tab("Item Farm","")
local miscsec = Window:Tab("Misc","")
local autofarm = Window:Tab("Auto Farming","")
local autosellsec = Window:Tab("Auto Sell","")
local autoarcade = Window:Tab("Auto Arcade","")
local TeleportTab = Window:Tab("Teleports","")
local Credits = Window:Tab("Credits","")


-- Choose mob
autofarm:Dropdown("MOB", mobs, function(currentOption)
    getgenv().Mob = currentOption
end)

-- Choose  quest
autofarm:Dropdown("NPC OF QUEST NAME", npcs, function(currentOption)
    if currentOption == "None" or currentOption == nil then
        getgenv().AutoQuest = false
    else
        getgenv().AutoQuestTarget = currentOption
        getgenv().AutoQuest = true
    end
end)

-- Enable autofarm
autofarm:Toggle("Enable", "",false, function(state)
    getgenv().Autofarm = state
    wait(0.1)
    if getgenv().Autofarm == true then
        spawn(function()
            if getgenv().AutoQuest == true then
                AutoQuest()
            end
        end)
    end
end)

-- Auto Quest
function AutoQuest()
    for i, v in pairs(game:GetService("Workspace").Dialogues:GetChildren()) do
        if string.match(v.Name:lower(), getgenv().AutoQuestTarget:lower()) or v.Name == AutoQuestTarget then
            wait()
            local tbl_0x0000000024eed817 = {
                ["NPC"] = getgenv().AutoQuestTarget,
                ["Option"] = "Option1",
                ["Dialogue"] = "Dialogue5"
            }
            local tbl_main = {"EndDialogue", tbl_0x0000000024eed817}
            game:GetService("Workspace").Living[game.Players.LocalPlayer.Name].RemoteEvent:FireServer(unpack(tbl_main))
            local tbl_0x0000000024eed817 = {
                ["NPC"] = getgenv().AutoQuestTarget,
                ["Option"] = "Option1",
                ["Dialogue"] = "Dialogue7"
            }
            local tbl_main = {"EndDialogue", tbl_0x0000000024eed817}
            game:GetService("Workspace").Living[game.Players.LocalPlayer.Name].RemoteEvent:FireServer(unpack(tbl_main))
            local A_1 = "EndDialogue"
            local A_2 = {
                ["NPC"] = getgenv().AutoQuestTarget,
                ["Option"] = "Option1",
                ["Dialogue"] = "Dialogue4"
            }
            game:GetService("Workspace").Living.FrownDontSmile.RemoteEvent:FireServer(A_1, A_2)
        end
    end
end
spawn(function()
    while wait(2) do
        pcall(function()
            for i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.HUD:GetChildren()) do
                if v.Name == "QuestCompleted" and v.Visible == true and getgenv().AutoQuest == true then
                    AutoQuest()
                end
            end
        end)
    end
end)

-- Autofarm
local Offset = {
    Angles = CFrame.Angles(0, 0, 0),
    Offsets = CFrame.new(0, 0, 4)
}
spawn(function()
    while wait() do
        -- pcall(function()
        if getgenv().Autofarm then
            for i, v in pairs(workspace.Living:GetChildren()) do
                if v.Name == getgenv().Mob and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and
                    v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and
                    v:FindFirstChild("Humanoid").Health >= 0 then
                    repeat
                        wait()
                        spawn(function()
                            if retard then
                                To3(v.HumanoidRootPart.CFrame * Offset.Angles * Offset.Offsets)
                            else
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame *
                                                                                                 Offset.Angles *
                                                                                                 Offset.Offsets
                            end
                        end)
                        spawn(function()
                            attack()
                        end)
                    until v == nil or v.Parent == nil or getgenv().Autofarm == false or v.Health.Value == 0
                end
            end
        end
        -- end)
    end
end)

-- Auto skills--

-- Enable autofarm
autofarm:Toggle("E", "Uses your skills for autofarm",false, function(state)
    E = state
end)

spawn(function()
    pcall(function()
        while wait(3) do
            if E then
                local A_1 = "InputBegan"
                local A_2 = {
                    ["Input"] = Enum.KeyCode.E
                }
                game:GetService("Players").LocalPlayer.Character.RemoteEvent:FireServer(A_1, A_2)
            end
        end
    end)
end)

-- Enable autofarm
autofarm:Toggle("R", "Uses your skills for autofarm",false, function(state)
    R = state
end)

spawn(function()
    pcall(function()
        while wait(3) do
            if R then
                local A_1 = "InputBegan"
                local A_2 = {
                    ["Input"] = Enum.KeyCode.R
                }
                game:GetService("Players").LocalPlayer.Character.RemoteEvent:FireServer(A_1, A_2)
            end
        end
    end)
end)

-- Enable autofarm
autofarm:Toggle("T", "Uses your skills for autofarm",false, function(state)
    T = state
end)

spawn(function()
    pcall(function()
        while wait(3) do
            if T then
                local A_1 = "InputBegan"
                local A_2 = {
                    ["Input"] = Enum.KeyCode.T
                }
                game:GetService("Players").LocalPlayer.Character.RemoteEvent:FireServer(A_1, A_2)
            end
        end
    end)
end)

-- Enable autofarm
autofarm:Toggle("Y", "Uses your skills for autofarm",false, function(state)
    Y = state
end)

spawn(function()
    pcall(function()
        while wait(3) do
            if T then
                local A_1 = "InputBegan"
                local A_2 = {
                    ["Input"] = Enum.KeyCode.Y
                }
                game:GetService("Players").LocalPlayer.Character.RemoteEvent:FireServer(A_1, A_2)
            end
        end
    end)
end)

-- Enable autofarm
autofarm:Toggle("F", "Uses your skills for autofarm",false, function(state)
    F = state
end)

spawn(function()
    pcall(function()
        while wait(3) do
            if FireServer then
                local A_1 = "InputBegan"
                local A_2 = {
                    ["Input"] = Enum.KeyCode.F
                }
                game:GetService("Players").LocalPlayer.Character.RemoteEvent:FireServer(A_1, A_2)
            end
        end
    end)
end)

-- Enable autofarm
autofarm:Toggle("H", "Uses your skills for autofarm",false, function(state)
    H = state
end)

spawn(function()
    pcall(function()
        while wait(3) do
            if H then
                local A_1 = "InputBegan"
                local A_2 = {
                    ["Input"] = Enum.KeyCode.H
                }
                game:GetService("Players").LocalPlayer.Character.RemoteEvent:FireServer(A_1, A_2)
            end
        end
    end)
end)

-- Enable autofarm
autofarm:Toggle("B", "Uses your skills for autofarm",false, function(state)
    B = state
end)

spawn(function()
    pcall(function()
        while wait(3) do
            if Bar then
                local A_1 = "InputBegan"
                local A_2 = {
                    ["Input"] = Enum.KeyCode.B
                }
                game:GetService("Players").LocalPlayer.Character.RemoteEvent:FireServer(A_1, A_2)
            end
        end
    end)
end)

-- Enable autofarm
autofarm:Toggle("G", "Uses your skills for autofarm",false, function(state)
    G = state
end)

spawn(function()
    pcall(function()
        while wait(3) do
            if G then
                local A_1 = "InputBegan"
                local A_2 = {
                    ["Input"] = Enum.KeyCode.G
                }
                game:GetService("Players").LocalPlayer.Character.RemoteEvent:FireServer(A_1, A_2)
            end
        end
    end)
end)

-- Enable autofarm
autofarm:Toggle("X", "Uses your skills for autofarm",false, function(state)
    X = state
end)

spawn(function()
    pcall(function()
        while wait(3) do
            if X then
                local A_1 = "InputBegan"
                local A_2 = {
                    ["Input"] = Enum.KeyCode.X
                }
                game:GetService("Players").LocalPlayer.Character.RemoteEvent:FireServer(A_1, A_2)
            end
        end
    end)
end)

-- Enable autofarm
autofarm:Toggle("C", "Uses your skills for autofarm",false, function(state)
    C = state
end)

spawn(function()
    pcall(function()
        while wait(3) do
            if C then
                local A_1 = "InputBegan"
                local A_2 = {
                    ["Input"] = Enum.KeyCode.C
                }
                game:GetService("Players").LocalPlayer.Character.RemoteEvent:FireServer(A_1, A_2)
            end
        end
    end)
end)

autofarm:Toggle("Level Farm", "",false, function(state)
    getgenv().LevelFarm = state
end)

autofarm:Toggle("Farm Boss", "",false, function(state)
    getgenv().Boss = state
end)

coroutine.wrap(function()
    while wait(.5) do
        if getgenv().LevelFarm == true then
            if game:GetService("Players").LocalPlayer.PlayerStats.Level.Value < 10 and
                game:GetService("Players").LocalPlayer.PlayerStats.Level.Value > 0 then
                getgenv().Mob = "Thug"
                getgenv().AutoQuestTarget = "Officer Sam"
                getgenv().Autofarm = true
                getgenv().AutoQuest = true
                AutoQuest()
            elseif game:GetService("Players").LocalPlayer.PlayerStats.Level.Value > 9 and
                game:GetService("Players").LocalPlayer.PlayerStats.Level.Value < 15 then
                getgenv().Mob = "Corrupt Police"
                getgenv().AutoQuestTarget = "Deputy Bertrude"
                getgenv().Autofarm = true
                getgenv().AutoQuest = true
                AutoQuest()
            elseif game:GetService("Players").LocalPlayer.PlayerStats.Level.Value > 14 and
                game:GetService("Players").LocalPlayer.PlayerStats.Level.Value < 20 then
                getgenv().Mob = "Alpha Thug"
                getgenv().AutoQuestTarget = "Lion Abbacho's Partner"
                getgenv().Autofarm = true
                getgenv().AutoQuest = true
                AutoQuest()
            elseif game:GetService("Players").LocalPlayer.PlayerStats.Level.Value > 19 and
                game:GetService("Players").LocalPlayer.PlayerStats.Level.Value < 30 then
                getgenv().Mob = "Zombie Henchman"
                getgenv().AutoQuestTarget = "Dracula"
                getgenv().Autofarm = true
                getgenv().AutoQuest = true
                AutoQuest()
            elseif game:GetService("Players").LocalPlayer.PlayerStats.Level.Value > 30 and
                game:GetService("Players").LocalPlayer.PlayerStats.Level.Value < 35 and getgenv().Boss then
                getgenv().Mob = "Dio"
                getgenv().AutoQuestTarget = "Dopey"
                getgenv().Autofarm = true
                getgenv().AutoQuest = true
                AutoQuest()
            elseif game:GetService("Players").LocalPlayer.PlayerStats.Level.Value > 30 and
                game:GetService("Players").LocalPlayer.PlayerStats.Level.Value < 35 and not getgenv().Boss then
                getgenv().Mob = "Zombie Henchman"
                getgenv().AutoQuestTarget = "Dracula"
                getgenv().Autofarm = true
                getgenv().AutoQuest = true
                AutoQuest()
            elseif game:GetService("Players").LocalPlayer.PlayerStats.Level.Value > 35 and
                game:GetService("Players").LocalPlayer.PlayerStats.Level.Value < 50 and getgenv().Boss then
                getgenv().Mob = "Joe"
                getgenv().AutoQuestTarget = "Dio"
                getgenv().Autofarm = true
                getgenv().AutoQuest = true
                AutoQuest()
            elseif game:GetService("Players").LocalPlayer.PlayerStats.Level.Value > 35 and
                game:GetService("Players").LocalPlayer.PlayerStats.Level.Value < 50 and not getgenv().Boss then
                getgenv().Mob = "Zombie Henchman"
                getgenv().AutoQuestTarget = "Dracula"
                getgenv().Autofarm = true
                getgenv().AutoQuest = true
                AutoQuest()
            end
        end
    end
end)()

coroutine.wrap(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
        vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)
end)()

-- TeleportSection
coroutine.wrap(function()
    for i, v in pairs(locations) do
        TeleportTab:Button(v, "Teleports you to" .. v, function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                game:GetService("Workspace").Locations[v].CFrame
        end)
    end
end)()
coroutine.wrap(function()
    for i, v in pairs(game:GetService("Workspace").Mob_Spawns:GetChildren()) do
        TeleportTab:Button(v.Name, "Teleports you to" .. v.Name, function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
        end)
    end
end)

coroutine.wrap(function()
    for i, v in pairs(game:GetService("Workspace").Mob_Spawns2:GetChildren()) do
        TeleportTab:Button(v.Name, "Teleports you to" .. v.Name, function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
        end)
    end
end)()
coroutine.wrap(function()
    for i, v in pairs(game:GetService("Workspace").Dialogues:GetChildren()) do
        TeleportTab:Button(v.Name, "Teleports you to" .. v.Name, function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
        end)
    end
end)()

--
ItemFarm:Toggle("Enable Item Farm", "Item Farm",false, function(Item)
    getgenv().ItemFarm = Item
    if getgenv().ItemFarm == false then
        return
    end
    while getgenv().ItemFarm do
        wait(1)
        pcall(function()
            if getgenv().ItemFarm == false then
                return
            end
            for i, item in next, (_G.Items) do
                if item["Replica"] and item["Replica"] ~= nil then
                    local name = item["Replica"].Name
                    for k, v in next, getgenv().farming do
                        if name ~= nil and name == k and v == true then
                            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = item.CFrame +
                                                                                                           Vector3.new(
                                    0, 5, 0)
                            wait(0.5)
                            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService(
                                                                                                           "Players").LocalPlayer
                                                                                                           .Character
                                                                                                           .HumanoidRootPart
                                                                                                           .CFrame +
                                                                                                           Vector3.new(
                                    0, 5, 0)
                            wait(0.5)
                            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService(
                                                                                                           "Players").LocalPlayer
                                                                                                           .Character
                                                                                                           .HumanoidRootPart
                                                                                                           .CFrame +
                                                                                                           Vector3.new(
                                    0, 5, 0)
                            wait(getgenv().delay)
                            fireclickdetector(item["CD"])
                            table.remove(_G.Items, i)
                            wait(1)
                        end
                    end
                end
            end
        end)
    end
end)

--

ItemFarm:Slider("Delay Pick Up", "Delay",0, 10, 1, function(delay)
    getgenv().delay = delay
end)

ItemFarm:Toggle("Gold Coin", "self-explain",false, function(goldcoin)
    getgenv().goldcoin = goldcoin
    if getgenv().goldcoin then
        getgenv().farming["Gold Coin"] = true
    else
        getgenv().farming["Gold Coin"] = false
    end
end)

ItemFarm:Toggle("Rokakaka", "self-explain",false, function(Rokakaka)
    getgenv().Rokakaka = Rokakaka
    if getgenv().Rokakaka then
        getgenv().farming["Rokakaka"] = true
    else
        getgenv().farming["Rokakaka"] = false
    end
end)

ItemFarm:Toggle("Mysterious Arrow", "self-explain",false, function(mysarrow)
    getgenv().mysarrow = mysarrow
    if getgenv().mysarrow then
        getgenv().farming["Mysterious Arrow"] = true
    else
        getgenv().farming["Mysterious Arrow"] = false
    end
end)

ItemFarm:Toggle("Diamond", "self-explain",false, function(Diamond)
    getgenv().Diamond = Diamond
    if getgenv().Diamond then
        getgenv().farming["Diamond"] = true
    else
        getgenv().farming["Diamond"] = false
    end
end)

ItemFarm:Toggle("Lucky Arrow", "self-explain",false, function(luckyarrow)
    getgenv().luckyarrow = luckyarrow
    if getgenv().luckyarrow then
        getgenv().farming["Lucky Arrow"] = true
    else
        getgenv().farming["Lucky Arrow"] = false
    end
end)

ItemFarm:Toggle("Zepellin's Headband", "self-explain",false, function(zep)
    getgenv().zep = zep
    if getgenv().zep then
        getgenv().farming["Zepellin's Headband"] = true
    else
        getgenv().farming["Zepellin's Headband"] = false
    end
end)

ItemFarm:Toggle("Quinton's Glove", "self-explain",false, function(glove)
    getgenv().glove = glove
    if getgenv().glove then
        getgenv().farming["Quinton's Glove"] = true
    else
        getgenv().farming["Quinton's Glove"] = false
    end
end)

ItemFarm:Toggle("Ancient Scroll", "self-explain",false, function(scroll)
    getgenv().scroll = scroll
    if getgenv().scroll then
        getgenv().farming["Ancient Scroll"] = true
    else
        getgenv().farming["Ancient Scroll"] = false
    end
end)

ItemFarm:Toggle("DEO's Diary", "self-explain",false, function(deos)
    getgenv().deos = deos
    if getgenv().deos then
        getgenv().farming["DEO's Diary"] = true
    else
        getgenv().farming["DEO's Diary"] = false
    end
end)

ItemFarm:Toggle("Steel Ball", "self-explain",false, function(steelball)
    getgenv().steelball = steelball
    if getgenv().steelball then
        getgenv().farming["Steel Ball"] = true
    else
        getgenv().farming["Steel Ball"] = false
    end
end)

ItemFarm:Toggle("Rib Cage of The Saint's Corpse", "self-explain",false, function(ribcage)
    getgenv().ribcage = ribcage
    if getgenv().ribcage then
        getgenv().farming["Rib Cage of The Saint's Corpse"] = true
    else
        getgenv().farming["Rib Cage of The Saint's Corpse"] = false
    end
end)

ItemFarm:Toggle("Pure Rokakaka", "self-explain",false, function(pureroka)
    getgenv().pureroka = pureroka
    if getgenv().pureroka then
        getgenv().farming["Pure Rokakaka"] = true
    else
        getgenv().farming["Pure Rokakaka"] = false
    end
end)

ItemFarm:Toggle("Stone Mask", "self-explain",false, function(stonemask)
    getgenv().stonemask = stonemask
    if getgenv().stonemask then
        getgenv().farming["Stone Mask"] = true
    else
        getgenv().farming["Stone Mask"] = false
    end
end)

miscsec:Button("Reset First", "Reset To Apply godmode and invis correctly only once required", function()
    pcall(function()
        local A_1 = "Reset"
        local A_2 = {
            ["Anchored"] = false
        }
        local Event = plr.Character.RemoteEvent
        Event:FireServer(A_1, A_2)
    end)
end)

miscsec:Toggle("God Mode", "God Mode Disable it make u able to reset",false, function(godmode)
    getgenv().godmode = godmode
    if getgenv().godmode == false then return end  
        local metatable = getrawmetatable(game)
        local namecall = metatable.__namecall 
        setreadonly(metatable,false)
        metatable.__namecall = newcclosure(function(self,...)
        local args = {...}
        local method = getnamecallmethod()
        if method == "InvokeServer" then
            if args[1] == "Reset" and getgenv().godmode then
                return wait(9e9)
            elseif getgenv().godmode == false then
                return namecall(self, ...)
            end
        end
        return namecall(self, ...)
        end)
        pcall(function()
    game:GetService("Players").LocalPlayer.Character.BindableEvent:Destroy()
  end ) 
end)

miscsec:Toggle("Invisiblity", "Make you Invisible",false, function(invisible)
    getgenv().invisible = invisible
      
        if getgenv().invisible == false then return end  
        local metatable = getrawmetatable(game)
        local namecall = metatable.__namecall 
        setreadonly(metatable,false)
        metatable.__namecall = newcclosure(function(self,...)
        local args = {...}
        local method = getnamecallmethod()
        if method == "InvokeServer" then
            if args[1] == "Reset" and getgenv().invisible then
                return wait(9e9)
            elseif getgenv().invisible == false then
                return namecall(self, ...)
            end
        end
        return namecall(self, ...)
        end)
        pcall(function()
    if game.Players.LocalPlayer.Character.LowerTorso:FindFirstChild "Root" then
        game.Players.LocalPlayer.Character.LowerTorso.Root:Remove()
    end
    if game.Players.LocalPlayer.Character.UpperTorso:FindFirstChild "Waist" then
        game.Players.LocalPlayer.Character.UpperTorso.Waist:Remove()
    end
    end )
end ) 

miscsec:Textbox("Victim To Attach", "Attach To Victim",false, function(attachtovictim)
    getgenv().attachtovictim = attachtovictim
    pcall(function()
        for i, v in pairs(game:GetService("Players"):GetPlayers()) do
            if string.match(v.Name, getgenv().attachtovictim) then
                getgenv().attachtovictim = v.Name
                warn(getgenv().attachtovictim, " Target")
            end
        end
    end)
end)



miscsec:Toggle("Attach Stand", "Attach Your Stand To The Victim",false, function(attachstand)
    getgenv().attachstand = attachstand
    if getgenv().attachstand then
        print(getgenv().attachstand )
        pcall(function()
            local stand = plr.Character:WaitForChild("StandMorph")
            local lockontarget
            lockontarget = game:GetService("RunService").Heartbeat:Connect(function()
                pcall(function()
                    if stand and getgenv().attachstand == true then
                        stand:FindFirstChild("HumanoidRootPart").CFrame =
                            workspace.Living[getgenv().attachtovictim].HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                    elseif getgenv().attachstand == false then
                        lockontarget:Disconnect()
                    end
                end)
            end)
        end)
    end
end)

miscsec:Toggle("Anti TS", "Make You Able to walk in TS",false, function(antits)
    getgenv().antits = antits
    if getgenv().antits == false then
        return
    end
    while getgenv().antits do
        wait(0.1)
        pcall(function()
            if game:GetService("Players").LocalPlayer.Character:FindFirstChild("InTimeStop") then
                game:GetService("Players").LocalPlayer.Character:FindFirstChild("InTimeStop"):Destroy()
            end
        end)
    end
end)

getgenv().ItemsToSell = {
    ["Rokakaka"] = false,
    ["Gold Coin"] = false,
    ["Mysterious Arrow"] = false,
    ["Diamond"] = false,
    ["Zepellin's Headband"] = false,
    ["Quinton's Glove"] = false,
    ["Ancient Scroll"] = false,
    ["DEO's Diary"] = false,
    ["Steel Ball"] = false,
    ["Rib Cage of The Saint's Corpse"] = false,
    ["Stone Mask"] = false
}

autosellsec:Toggle("Auto Sell", "Auto Sell Items",false, function(autosell)
    getgenv().autosell = autosell
    if getgenv().autosell == false then
        return
    end
    while getgenv().autosell do
        wait(0.5)
        pcall(function()
            if getgenv().autosell == false then
                return
            end
            if plr and plr.Character then
                for i, v in pairs(getgenv().ItemsToSell) do
                    if i and v == true then
                        plr.Character:FindFirstChild("Humanoid"):EquipTool(plr.Backpack:FindFirstChild(i))
                        start()
                        sellitem()
                    end
                end
            end
        end)
    end
end)

autosellsec:Toggle("Gold Coin", "self-explain",false, function(sellgoldcoin)
    getgenv().sellgoldcoin = sellgoldcoin
    if getgenv().sellgoldcoin then
        getgenv().ItemsToSell["Gold Coin"] = true
    else
        getgenv().ItemsToSell["Gold Coin"] = false
    end
end)

autosellsec:Toggle("Rokakaka", "self-explain",false, function(sellRokakaka)
    getgenv().sellRokakaka = sellRokakaka
    if getgenv().sellRokakaka then
        getgenv().ItemsToSell["Rokakaka"] = true
    else
        getgenv().ItemsToSell["Rokakaka"] = false
    end
end)

autosellsec:Toggle("Mysterious Arrow", "self-explain",false, function(sellmysarrow)
    getgenv().sellmysarrow = sellmysarrow
    if getgenv().sellmysarrow then
        getgenv().ItemsToSell["Mysterious Arrow"] = true
    else
        getgenv().ItemsToSell["Mysterious Arrow"] = false
    end
end)

autosellsec:Toggle("Diamond", "self-explain",false, function(selldiamond)
    getgenv().selldiamond = selldiamond
    if getgenv().selldiamond then
        getgenv().ItemsToSell["Diamond"] = true
    else
        getgenv().ItemsToSell["Diamond"] = false
    end
end)

autosellsec:Toggle("Zepellin's Headband", "self-explain",false, function(sellzep)
    getgenv().sellzep = sellzep
    if getgenv().sellzep then
        getgenv().ItemsToSell["Zepellin's Headband"] = true
    else
        getgenv().ItemsToSell["Zepellin's Headband"] = false
    end
end)

autosellsec:Toggle("Quinton's Glove", "self-explain",false, function(sellglove)
    getgenv().sellglove = sellglove
    if getgenv().sellglove then
        getgenv().ItemsToSell["Quinton's Glove"] = true
    else
        getgenv().ItemsToSell["Quinton's Glove"] = false
    end
end)

autosellsec:Toggle("Ancient Scroll", "self-explain",false, function(sellscroll)
    getgenv().sellscroll = sellscroll
    if getgenv().sellscroll then
        getgenv().ItemsToSell["Ancient Scroll"] = true
    else
        getgenv().ItemsToSell["Ancient Scroll"] = false
    end
end)

autosellsec:Toggle("DEO's Diary", "self-explain",false, function(selldeos)
    getgenv().selldeos = selldeos
    if getgenv().selldeos then
        getgenv().ItemsToSell["DEO's Diary"] = true
    else
        getgenv().ItemsToSell["DEO's Diary"] = false
    end
end)

autosellsec:Toggle("Steel Ball", "self-explain",false, function(sellsteelball)
    getgenv().sellsteelball = sellsteelball
    if getgenv().sellsteelball then
        getgenv().ItemsToSell["Steel Ball"] = true
    else
        getgenv().ItemsToSell["Steel Ball"] = false
    end
end)

autosellsec:Toggle("Rib Cage of The Saint's Corpse", "self-explain",false, function(sellribcage)
    getgenv().sellribcage = sellribcage
    if getgenv().sellribcage then
        getgenv().ItemsToSell["Rib Cage of The Saint's Corpse"] = true
    else
        getgenv().ItemsToSell["Rib Cage of The Saint's Corpse"] = false
    end
end)

autosellsec:Toggle("Stone Mask", "self-explain",false, function(sellstoemask)
    getgenv().sellstoemask = sellstoemask
    if getgenv().sellstoemask then
        getgenv().ItemsToSell["Stone Mask"] = true
    else
        getgenv().ItemsToSell["Stone Mask"] = false
    end
end)

autoarcade:Toggle("Auto Arcade", "Make you able to arcade ig",false, function(autoarcade)
    getgenv().autoarcade = autoarcade
    while getgenv().autoarcade do
        wait(1)
        pcall(function()
            if getgenv().autoarcade == false then
                return
            end
            if plr.Backpack:FindFirstChild("Gold Coin") and
                game:GetService("Players").LocalPlayer.PlayerStats.Money.Value >= 1500 then
                start()
                spin()
            end
        end)
    end
end)

autoarcade:Toggle("Disable Arcade Gui", "Disabling Arcade Gui Reduce Lag",false, function(disableguiautoarcade)
    getgenv().disableguiautoarcade = disableguiautoarcade
    local arcadegui
    arcadegui = plr.PlayerGui.ChildAdded:Connect(function(p)
        if p:IsA("ScreenGui") and p.Name == "RollingItem" and getgenv().disableguiautoarcade then
            p:Destroy()
        elseif getgenv().disableguiautoarcade == false then
            arcadegui:Disconnect()
        end
    end)
end)
Credits:Button("Copy Discord", "Copy Discord of the script in your clipboard", function()
    setclipboard(tostring("https://discord.gg/hjwVr7KWnA"))
end)

Credits:Button("[Otaku]AnimeLover#7066&Midnight#7078", "Copy Discord of the script in your clipboard", function()
end)
