--[[
	id: BSX7lIn44O-eyQdJNcEom
	name: myscript
	description: \nif syn then \n    game.Loaded:Wait()\nend \nlocal Player = game.Players.LocalPlayer\nlocal function firefakesignal(Button)\ngame:GetService("VirtualInputManager"):SendMouseButtonEvent(Button.AbsolutePosition.X + Button.AbsoluteSize.X / 2, Button.AbsolutePosition.Y + Button.AbsoluteSize.Y / 2 + 30, 0, true, lol, 1)\ngame:GetService("VirtualInputManager"):SendMouseButtonEvent(Button.AbsolutePosition.X + Button.AbsoluteSize.X / 2, Button.AbsolutePosition.Y + Button.AbsoluteSize.Y / 2 + 30, 0, false, lol, 1)\nend \nlocal LoadingScreen1 = Player.PlayerGui:WaitForChild("LoadingScreen1", 60)\nlocal LoadingScreen = Player.PlayerGui:WaitForChild("LoadingScreen", 60)\nlocal Skip = LoadingScreen1.Frame.LoadingFrame.Skip\nlocal pos;\nlocal mt = getrawmetatable(game)\nlocal oldNewIndex = mt.__newindex \nsetreadonly(mt, false)\n_G.Items = {} \nmt.__newindex = newcclosure(function(tbl, idx, new)\n    if tbl == game:GetService("ReplicatedStorage").ItemSpawn and idx == "OnClientInvoke" then \n        \n        local OldInvoke = new\n        new = function(...)\n            local args = {...}\n               pcall(function()\n                   print(args[2]["Replica"],args[2]["CFrame"],args[2]["CD"])\n                   table.insert(_G.Items, {Replica = args[2]["Replica"], CFrame = args[2]["CFrame"], CD = args[2]["CD"]})\n                    end )\n            return OldInvoke(...)\n        end\n    end \n\n    return oldNewIndex(tbl, idx, new)\nend)\n\nsetreadonly(mt, true)\ngetscriptclosure(game:GetService("ReplicatedFirst"):WaitForChild("ItemSpawn"))()\n\nrepeat wait() until Skip.Visible\n\nfirefakesignal(Skip.TextButton, true)\n\nrepeat wait() until not LoadingScreen1.Parent\n\nlocal Prestige = Player.PlayerStats.Prestige.Value\nPlayer.PlayerStats.Prestige.Value = 0\n\nfirefakesignal(LoadingScreen.Play)\n\nrepeat wait() until not LoadingScreen.Parent\n\nPlayer.PlayerStats.Prestige.Value = Prestige\n\nHook = hookfunction(getrawmetatable(game).__namecall, newcclosure(function(self, ...) \n   local args = {...} \n   if getnamecallmethod() == "InvokeServer" then \n       if args[1] == "idklolbrah2de"   then \n           return "  ___XP DE KEY"\n      end\n   end \n   return Hook(self, ...) \nend))\n\nlocal mathrandom = math.random(_G.Min,_G.Max)\nif _G.Num == nil then \n_G.Num = mathrandom\nend \nlocal PlaceID = 2809202155\nlocal AllIDs = {}\nlocal foundAnything = ""\nlocal actualHour = os.date("!*t").hour\nfunction TPReturner()\n    local Site;\n    if foundAnything == "" then\n        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))\n    else\n        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))\n    end\n    local ID = ""\n    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then\n        foundAnything = Site.nextPageCursor\n    end\n    local num = 0;\n    for i,v in pairs(Site.data) do\n        local Possible = true\n        ID = tostring(v.id)\n        if tonumber(v.playing) == tonumber(_G.Num) then\n                pcall(function()\n                    game:GetService("TeleportService"):TeleportToPlaceInstance(2809202155, ID, game:GetService("Players").LocalPlayer)\n                end)\n                wait(4)\n            end\n        end\n    end\n\nfunction Teleport()\n    while wait() do\n        pcall(function()\n            TPReturner()\n            if foundAnything ~= "" then\n                TPReturner()\n            end\n        end)\n    end\nend\n\n\n\n\nlocal function exists( item )\n    for k, v in next, _G.Items do \n        if (v.Replica.Name == item) then return true end    \n    end\n    \n    return false\nend\n\nwarn("By CreativeHell&AnimeLover")\ngame.StarterGui:SetCore("SendNotification",{\nTitle = "Hi :D",\nText = "By AnimeLover&CreativeHell",\nIcon = "",\nDuration = 10;\n})\n\nwait(math.random(10,11))\n\nlocal plr = game:GetService("Players").LocalPlayer\n    while wait() do  pcall(function()\n          if (not exists(_G.ItemFarm)) then\n Teleport()\nelse \n        local items = game:GetService("Workspace").Item_Spawns.Items\nfor i ,item in next, (_G.Items) do \n    if item["Replica"] and item["Replica"] ~= nil then \n        local name = item["Replica"].Name\n        if name ~= nil and name == (_G.ItemFarm) then\n           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = item.CFrame + Vector3.new(0,5,0)\n\n           wait(0.5)\n           game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,5,0)\n           wait(0.5)\n            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,5,0)\n           wait(0.5)\n          fireclickdetector(item["CD"])\n                table.remove(_G.Items,i)\n                                 wait(1)\n                                  \n                  \nend end end  end \nend )end\n\n
	time1: 2021-06-07 13:50:59.860505+00
	time2: 2021-06-07 13:50:59.860506+00
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
local PlaceID = 2809202155
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
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
                pcall(function()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(2809202155, ID, game:GetService("Players").LocalPlayer)
                end)
                wait(4)
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
game.StarterGui:SetCore("SendNotification",{
Title = "Hi :D",
Text = "By AnimeLover&CreativeHell",
Icon = "",
Duration = 10;
})

wait(math.random(10,11))

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

