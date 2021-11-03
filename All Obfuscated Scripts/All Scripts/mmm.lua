--[[
	id: -2_N5E-YTYWSIz4Ta3ymS
	name: mmm
	description: m
	time1: 2021-05-27 22:49:11.609422+00
	time2: 2021-05-27 22:49:11.609423+00
	uploader: seYJnfjCx6KjwX_7aQDi643O63iMIVdYBaVgoyya
	uploadersession: qhTmhyL-zPdyhF02stRXf6OOBmIFny
	flag: f
--]]

local Player = game.Players.LocalPlayer
local function firefakesignal(Button)
game:GetService("VirtualInputManager"):SendMouseButtonEvent(Button.AbsolutePosition.X + Button.AbsoluteSize.X / 2, Button.AbsolutePosition.Y + Button.AbsoluteSize.Y / 2 + 30, 0, true, lol, 1)
game:GetService("VirtualInputManager"):SendMouseButtonEvent(Button.AbsolutePosition.X + Button.AbsoluteSize.X / 2, Button.AbsolutePosition.Y + Button.AbsoluteSize.Y / 2 + 30, 0, false, lol, 1)
end 
local LoadingScreen1 = Player.PlayerGui:WaitForChild("LoadingScreen1", 60)
local LoadingScreen = Player.PlayerGui:WaitForChild("LoadingScreen", 60)
local Skip = LoadingScreen1.Frame.LoadingFrame.Skip
local pos;
local mt = getrawmetatable(game)
local oldNewIndex = mt.__newindex 
setreadonly(mt, false)
_G.Items = {} 
mt.__newindex = newcclosure(function(tbl, idx, new)
    if tbl == game:GetService("ReplicatedStorage").ItemSpawn and idx == "OnClientInvoke" then 
        
        local OldInvoke = new
        new = function(...)
            local args = {...}
               pcall(function()
                   table.insert(_G.Items, {Replica = args[2]["Replica"], CFrame = args[2]["CFrame"], CD = args[2]["CD"]})
                    end )
            return OldInvoke(...)
        end
    end 

    return oldNewIndex(tbl, idx, new)
end)

setreadonly(mt, true)
getscriptclosure(game:GetService("ReplicatedFirst"):WaitForChild("ItemSpawn"))()

repeat wait() until Skip.Visible

firefakesignal(Skip.TextButton, true)

repeat wait() until not LoadingScreen1.Parent

local Prestige = Player.PlayerStats.Prestige.Value
Player.PlayerStats.Prestige.Value = 0

firefakesignal(LoadingScreen.Play)

repeat wait() until not LoadingScreen.Parent

Player.PlayerStats.Prestige.Value = Prestige

Hook = hookfunction(getrawmetatable(game).__namecall, newcclosure(function(self, ...) 
   local args = {...} 
   if getnamecallmethod() == "InvokeServer" then 
       if args[1] == "idklolbrah2de"   then 
           return "  ___XP DE KEY"
      end
   end 
   return Hook(self, ...) 
end))

local mathrandom = math.random(_G.Min,_G.Max)
if _G.Num == nil then 
_G.Num = mathrandom
end 
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
function TPReturner()
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.playing) == tonumber(_G.Num) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                wait()
                pcall(function()
                    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                end)
                wait(4)
            end
        end
    end
end

function Teleport()
    while wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end




local function exists( item )
    for k, v in next, _G.Items do 
        if (v.Replica.Name == item) then return true end    
    end
    
    return false
end

warn("By CreativeHell&AnimeLover")
local deadalready = false 
while not deadalready do pcall(function()
local plr = game:GetService("Players").LocalPlayer 
if plr and plr.Character and plr.Character:FindFirstChild("Humanoid") then
    local A_1 = "PressedPlay"
local Event = game:GetService("Players").LocalPlayer.Character.RemoteEvent
Event:FireServer(A_1)

    plr.Character.Humanoid.Health = 0
    wait()
    repeat wait() until plr.CharacterAdded:Wait(3) 
    deadalready = true 

end 
end ) 
end 


local plr = game:GetService("Players").LocalPlayer
    while wait() do  pcall(function()
          if (not exists(_G.ItemFarm)) then
 Teleport()
else 
        local items = game:GetService("Workspace").Item_Spawns.Items
for i ,item in next, (_G.Items) do 
    if item["Replica"] and item["Replica"] ~= nil then 
        local name = item["Replica"].Name
        if name ~= nil and name == (_G.ItemFarm) then
           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = item.CFrame + Vector3.new(0,5,0)

           wait(0.5)
           game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,5,0)
           wait(0.5)
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,5,0)
           wait(0.5)
          fireclickdetector(item["CD"])
                table.remove(_G.Items,i)
                                 wait(1)
                                  
                  
end end end  end 
end )end