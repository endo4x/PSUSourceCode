--[[
	id: xT_gUEo2Yh5a7WRJXdW0U
	name: yespsu
	description: a
	time1: 2021-06-21 03:44:15.109322+00
	time2: 2021-06-21 03:44:15.109322+00
	uploader: seYJnfjCx6KjwX_7aQDi643O63iMIVdYBaVgoyya
	uploadersession: qhTmhyL-zPdyhF02stRXf6OOBmIFny
	flag: f
--]]

if syn then game.Loaded:Wait() end 
getgenv().farming = {
	["Rokakaka"] = false,
	["Gold Coin"] = false,
	["Mysterious Arrow"] = false,
	["Diamond"] = false , 
	["Lucky Arrow"] = false ,
	["Zepellin's Headband"] = false ,
	["Quinton's Glove"] = false, 
	["Ancient Scroll"] = false ,
	["DEO's Diary"] = false , 
	["Steel Ball"] = false,
	["Rib Cage of The Saint's Corpse"] = false , 
	["Pure Rokakaka"] = false , 
	["Stone Mask"] = false 
}
local metatable = getrawmetatable(game)
local newindex = metatable.__newindex 
setreadonly(metatable,false)
_G.Items = {} 
metatable.__newindex = newcclosure(function(t, i, v)
    if t == game:GetService("ReplicatedStorage").ItemSpawn and i == "OnClientInvoke" then 
        old = v
        v = function(...)
            local args = {...}
            table.insert(_G.Items, {Replica = args[2]["Replica"], CFrame = args[2]["CFrame"], CD = args[2]["CD"]})
            return old(...)
        end
    end 
  return newindex(t, i, v)
end)
setreadonly(metatable, true)

--
local plr = game:GetService("Players").LocalPlayer 
local core = game:GetService("StarterGui")
local checkscript = getscripthash
local runservice = game:GetService("RunService")
--
local function notify(message,daily)
    core:SetCore("SendNotification",{
      Title = "Alert System", 
      Text = tostring(message), 
      Duration = tonumber(daily)  
    })
end 
repeat wait() until plr.CharacterAdded:Wait() 
local Client
for i ,v in pairs(getnilinstances()) do 
    if v:IsA("ModuleScript") and v.Name == "Client" then 
        Client = v 
        break 
    end 
end 

local hash = "86d29efcf2fbf285c355410ca70ea8bdd5cbfc9b7abedb3a8166ef091d69b1138d24a1697781e352422dc1537b58277d"

notify("Checking Detections",5)
if checkscript(Client) ~= tostring(hash) then 
    notify("Warning yba have been updated if you still using the gui you agree that you might get banned",15)
    else 
    notify("You All Good No Updates Detected!",5)
end 

notify("Applying Bypass")
local Hook
Hook = hookfunction(getrawmetatable(game).__namecall, newcclosure(function(self, ...) 
   local args = {...} 
   local method = getnamecallmethod()
   if method == "InvokeServer" then 
       if args[1] == "idklolbrah2de"   then 
           return "  ___XP DE KEY"
       elseif args[1] == "Reset" or args[1] == "SigL" or method:lower() == 'kick' then 
           return wait(9e9)
      end
   end 
   return Hook(self, ...) 
end))

local metatable = getrawmetatable(game)
local index = metatable.__index 
setreadonly(metatable,false)
metatable.__index = newcclosure(function(t,k)
    if t == "Humanoid" and k == "WalkSpeed" then 
        return 16 
    elseif t == "Humanoid" and k == "JumpPower" then 
        return 50 
    end 
    return index(t,k)
end ) 

notify("Applied")

local function start()
    fireproximityprompt(workspace.Dialogues["ShiftPlox, The Travelling Merchant"].ProximityPrompt, 0)
wait()
end

local function sellitem()
local A_1 = "EndDialogue"
local A_2 =
{
["NPC"] = "Merchant",
["Option"] = "Option2",
["Dialogue"] = "Dialogue1"
}
local Event = game:GetService("Players").LocalPlayer.Character.RemoteEvent
Event:FireServer(A_1, A_2)

local A_1 = "EndDialogue"
local A_2 =
{
["NPC"] = "Merchant",
["Option"] = "Option2",
["Dialogue"] = "Dialogue5"
}
local Event = game:GetService("Players").LocalPlayer.Character.RemoteEvent
Event:FireServer(A_1, A_2)
end

local function spin()
local A_1 = "DialogueInteracted"
local A_2 =
{
["DialogueName"] = "Item Machine",
["Speaker"] = "Item Machine"
}
local Event = game:GetService("Players").LocalPlayer.Character.RemoteEvent
Event:FireServer(A_1, A_2)

local A_1 = "EndDialogue"
local A_2 =
{
["NPC"] = "Item Machine",
["Option"] = "Option1",
["Dialogue"] = "Dialogue1"
}
local Event = game:GetService("Players").LocalPlayer.Character.RemoteEvent
Event:FireServer(A_1, A_2)
end

plr.CharacterAdded:Connect(function()
    wait(5)
local remotes = {} 

for i ,v in pairs(getgc()) do 
    if typeof(v) == 'function' and tostring(getfenv(v).script) == 'Client' and #debug.getprotos(v) == 7 then 
       for i2 , v2 in pairs(debug.getupvalues(v)) do 
           table.insert(remotes,tostring(v2))
       end 
       if table.find(remotes,"RemoteEvent") and table.find(remotes,"RemoteFunction") then 
           pcall(function() hookfunction(v,function() return function() end end )  end)
           break 
            end 
        end 
    end 
end ) 


--
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("YBA", "Ocean")
local Tab = Window:NewTab("Main")
local ItemFarm = Tab:NewSection("Item Farm")

-- misc -- 
local misc = Window:NewTab("Misc")
local miscsec = misc:NewSection("Misc")
-- misc -- 

-- auto sell -- 
local autosell = Window:NewTab("Auto Sell")
local autosellsec = autosell:NewSection("Auto Sell Items")

-- auto arcade 

local autoarcade = Window:NewTab("Auto Arcade")
local autoarcadesec = autoarcade:NewSection("Auto Arcade")


-- credits -- 
local Credits = Window:NewTab("Credits")
local CreditsSec = Credits:NewSection("Credits")

-- credits -- 
ItemFarm:NewToggle("Enable Item Farm", "Item Farm", function(Item)
    getgenv().ItemFarm = Item
    if getgenv().ItemFarm == false then return end 
   while getgenv().ItemFarm do  wait(1) 
       pcall(function()
               if getgenv().ItemFarm == false then return end 
       for i ,item in next, (_G.Items) do 
    if item["Replica"] and item["Replica"] ~= nil then 
        local name = item["Replica"].Name
            for k, v in next, getgenv().farming do 
        if name ~= nil and name == k and v == true   then 
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = item.CFrame + Vector3.new(0,5,0)
           wait(0.5)
           game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,5,0)
           wait(0.5)
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,5,0)
           wait(getgenv().delay)
         fireclickdetector(item["CD"])
                table.remove(_G.Items,i)
                 wait(1)
              end
            end
          end 
        end 
     end ) 
   end 
end ) 

--

ItemFarm:NewSlider("Delay Pick Up","Delay",10,1,function(delay)
    getgenv().delay = delay 
    end ) 

ItemFarm:NewToggle("Gold Coin", "self-explain", function(goldcoin)
getgenv().goldcoin = goldcoin 
if getgenv().goldcoin then 
    getgenv().farming["Gold Coin"] = true  
    else 
    getgenv().farming["Gold Coin"] = false 
    end 
end ) 

ItemFarm:NewToggle("Rokakaka", "self-explain", function(Rokakaka)
getgenv().Rokakaka = Rokakaka 
if getgenv().Rokakaka then 
    getgenv().farming["Rokakaka"] = true  
    else 
    getgenv().farming["Rokakaka"] = false 
    end 
end ) 

ItemFarm:NewToggle("Mysterious Arrow", "self-explain", function(mysarrow)
getgenv().mysarrow = mysarrow 
if getgenv().mysarrow then 
    getgenv().farming["Mysterious Arrow"] = true  
    else 
    getgenv().farming["Mysterious Arrow"] = false 
    end 
end ) 

ItemFarm:NewToggle("Diamond", "self-explain", function(Diamond)
getgenv().Diamond = Diamond 
if getgenv().Diamond then 
    getgenv().farming["Diamond"] = true  
    else 
    getgenv().farming["Diamond"] = false 
    end 
end ) 

ItemFarm:NewToggle("Lucky Arrow", "self-explain", function(luckyarrow)
getgenv().luckyarrow = luckyarrow 
if getgenv().luckyarrow then 
    getgenv().farming["Lucky Arrow"] = true  
    else 
    getgenv().farming["Lucky Arrow"] = false 
    end 
end ) 

ItemFarm:NewToggle("Zepellin's Headband", "self-explain", function(zep)
getgenv().zep = zep 
if getgenv().zep then 
    getgenv().farming["Zepellin's Headband"] = true  
    else 
    getgenv().farming["Zepellin's Headband"] = false 
    end 
end ) 

ItemFarm:NewToggle("Quinton's Glove", "self-explain", function(glove)
getgenv().glove = glove 
if getgenv().glove then 
    getgenv().farming["Quinton's Glove"] = true  
    else 
    getgenv().farming["Quinton's Glove"] = false 
    end 
end ) 

ItemFarm:NewToggle("Ancient Scroll", "self-explain", function(scroll)
getgenv().scroll = scroll 
if getgenv().scroll then 
    getgenv().farming["Ancient Scroll"] = true  
    else 
    getgenv().farming["Ancient Scroll"] = false 
    end 
end ) 

ItemFarm:NewToggle("DEO's Diary", "self-explain", function(deos)
getgenv().deos = deos 
if getgenv().deos then 
    getgenv().farming["DEO's Diary"] = true  
    else 
    getgenv().farming["DEO's Diary"] = false 
    end 
end ) 

ItemFarm:NewToggle("Steel Ball", "self-explain", function(steelball)
getgenv().steelball = steelball 
if getgenv().steelball then 
    getgenv().farming["Steel Ball"] = true  
    else 
    getgenv().farming["Steel Ball"] = false 
    end 
end ) 

ItemFarm:NewToggle("Rib Cage of The Saint's Corpse", "self-explain", function(ribcage)
getgenv().ribcage = ribcage 
if getgenv().ribcage then 
    getgenv().farming["Rib Cage of The Saint's Corpse"] = true  
    else 
    getgenv().farming["Rib Cage of The Saint's Corpse"] = false 
    end 
end ) 

ItemFarm:NewToggle("Pure Rokakaka", "self-explain", function(pureroka)
getgenv().pureroka = pureroka 
if getgenv().pureroka then 
    getgenv().farming["Pure Rokakaka"] = true  
    else 
    getgenv().farming["Pure Rokakaka"] = false 
    end 
end ) 

ItemFarm:NewToggle("Stone Mask", "self-explain", function(stonemask)
getgenv().stonemask = stonemask 
if getgenv().stonemask then 
    getgenv().farming["Stone Mask"] = true  
    else 
    getgenv().farming["Stone Mask"] = false 
    end 
end ) 

miscsec:NewButton("Reset First","Reset To Apply godmode and invis correctly only once required",function()
pcall(function()
local A_1 = "Reset"
local A_2 = 
{
	["Anchored"] = false
}
local Event = plr.Character.RemoteEvent
Event:FireServer(A_1, A_2)
end ) 
end ) 

miscsec:NewToggle("God Mode","God Mode Disable it make u able to reset",function(godmode)
    getgenv().godmode = godmode 
local Hookgod
Hookgod = hookfunction(getrawmetatable(game).__namecall, newcclosure(function(self, ...) 
   local args = {...} 
   local method = getnamecallmethod()
   if method == "FireServer" then 
     if args[1] == "Reset" and getgenv().godmode then 
         return wait(9e9)
     elseif getgenv().godmode == false then 
         return Hookgod(self,...)
       end
   end 
  return Hookgod(self,...)
end ))
 game:GetService("Players").LocalPlayer.Character.BindableEvent:Destroy()
end ) 

miscsec:NewToggle("Invisiblity","Make you Invisible",function(invisible)
    getgenv().invisible = invisible 
    if getgenv().invisible == false then return end 
    local Hookgod
Hookgod = hookfunction(getrawmetatable(game).__namecall, newcclosure(function(self, ...) 
   local args = {...} 
   local method = getnamecallmethod()
   if method == "FireServer" then 
     if args[1] == "Reset" and getgenv().invisible then 
         return wait(9e9)
     elseif getgenv().invisible == false then 
         return Hookgod(self,...)
       end
   end 
  return Hookgod(self,...)
end ))
    if game.Players.LocalPlayer.Character.LowerTorso:FindFirstChild'Root' then
game.Players.LocalPlayer.Character.LowerTorso.Root:Remove()
end
if game.Players.LocalPlayer.Character.UpperTorso:FindFirstChild'Waist' then
game.Players.LocalPlayer.Character.UpperTorso.Waist:Remove()
end
end ) 

miscsec:NewTextBox("Victim To Attach","Attach To Victim",function(attachtovictim)
    getgenv().attachtovictim = attachtovictim 
    pcall(function()
    for i ,v in pairs(game:GetService("Players"):GetPlayers()) do 
        if string.match(v.Name , getgenv().attachtovictim) then 
            getgenv().attachtovictim = v.Name 
            warn(getgenv().attachtovictim , " Target")
          end 
         end 
      end ) 
    end ) 

miscsec:NewToggle("Attach Stand","Attach Your Stand To The Victim",function(attachstand)
getgenv().attachstand = attachstand 
if getgenv().attachstand then 
    pcall(function()
local stand = plr.Character:WaitForChild("StandMorph")
local lockontarget
lockontarget = game:GetService("RunService").Heartbeat:Connect(function()
    pcall(function()
if stand  and getgenv().attachstand == true then 
stand:FindFirstChild("HumanoidRootPart").CFrame = workspace.Living[getgenv().attachtovictim].HumanoidRootPart.CFrame * CFrame.new(0,0,2)
elseif getgenv().attachstand == false then 
    lockontarget:Disconnect()
end  
end )
end ) 
end ) 
end
end) 

miscsec:NewToggle("Anti TS","Make You Able to walk in TS", function(antits)
    getgenv().antits = antits 
    if getgenv().antits == false then return end 
    while getgenv().antits do wait(0.1) pcall(function()
            if game:GetService("Players").LocalPlayer.Character:FindFirstChild("InTimeStop") then 
game:GetService("Players").LocalPlayer.Character:FindFirstChild("InTimeStop"):Destroy() 
      end 
    end) 
 end 
end )

getgenv().ItemsToSell = {
["Rokakaka"] = false,
["Gold Coin"] = false,
["Mysterious Arrow"] = false,
["Diamond"] = false ,
["Zepellin's Headband"] = false ,
["Quinton's Glove"] = false,
["Ancient Scroll"] = false ,
["DEO's Diary"] = false ,
["Steel Ball"] = false,
["Rib Cage of The Saint's Corpse"] = false ,
["Stone Mask"] = false
}

autosellsec:NewToggle("Auto Sell","Auto Sell Items",function(autosell)
    getgenv().autosell = autosell 
    if getgenv().autosell == false then return end
    while getgenv().autosell do wait(0.5) pcall(function()
        if getgenv().autosell == false then return end 
        if plr and plr.Character then 
            for i,v in pairs(getgenv().ItemsToSell) do 
                if i and v == true then 
             plr.Character:FindFirstChild("Humanoid"):EquipTool(plr.Backpack:FindFirstChild(i))
            start()
            sellitem()
                   end 
                end 
            end 
        end ) 
     end 
end ) 


autosellsec:NewToggle("Gold Coin", "self-explain", function(sellgoldcoin)
getgenv().sellgoldcoin = sellgoldcoin 
if getgenv().sellgoldcoin then 
    getgenv().ItemsToSell["Gold Coin"] = true  
    else 
    getgenv().ItemsToSell["Gold Coin"] = false 
    end 
end ) 

autosellsec:NewToggle("Rokakaka", "self-explain", function(sellRokakaka)
getgenv().sellRokakaka = sellRokakaka 
if getgenv().sellRokakaka then 
    getgenv().ItemsToSell["Rokakaka"] = true  
    else 
    getgenv().ItemsToSell["Rokakaka"] = false 
    end 
end ) 

autosellsec:NewToggle("Mysterious Arrow", "self-explain", function(sellmysarrow)
getgenv().sellmysarrow = sellmysarrow 
if getgenv().sellmysarrow then 
    getgenv().ItemsToSell["Mysterious Arrow"] = true  
    else 
    getgenv().ItemsToSell["Mysterious Arrow"] = false 
    end 
end ) 

autosellsec:NewToggle("Diamond", "self-explain", function(selldiamond)
getgenv().selldiamond = selldiamond 
if getgenv().selldiamond then 
    getgenv().ItemsToSell["Diamond"] = true  
    else 
    getgenv().ItemsToSell["Diamond"] = false 
    end 
end ) 


autosellsec:NewToggle("Zepellin's Headband", "self-explain", function(sellzep)
getgenv().sellzep = sellzep 
if getgenv().sellzep then 
    getgenv().ItemsToSell["Zepellin's Headband"] = true  
    else 
    getgenv().ItemsToSell["Zepellin's Headband"] = false 
    end 
end ) 

autosellsec:NewToggle("Quinton's Glove", "self-explain", function(sellglove)
getgenv().sellglove = sellglove 
if getgenv().sellglove then 
    getgenv().ItemsToSell["Quinton's Glove"] = true  
    else 
    getgenv().ItemsToSell["Quinton's Glove"] = false 
    end 
end ) 

autosellsec:NewToggle("Ancient Scroll", "self-explain", function(sellscroll)
getgenv().sellscroll = sellscroll 
if getgenv().sellscroll then 
    getgenv().ItemsToSell["Ancient Scroll"] = true  
    else 
    getgenv().ItemsToSell["Ancient Scroll"] = false 
    end 
end ) 

autosellsec:NewToggle("DEO's Diary", "self-explain", function(selldeos)
getgenv().selldeos = selldeos 
if getgenv().selldeos then 
    getgenv().ItemsToSell["DEO's Diary"] = true  
    else 
    getgenv().ItemsToSell["DEO's Diary"] = false 
    end 
end ) 

autosellsec:NewToggle("Steel Ball", "self-explain", function(sellsteelball)
getgenv().sellsteelball = sellsteelball 
if getgenv().sellsteelball then 
    getgenv().ItemsToSell["Steel Ball"] = true  
    else 
    getgenv().ItemsToSell["Steel Ball"] = false 
    end 
end ) 

autosellsec:NewToggle("Rib Cage of The Saint's Corpse", "self-explain", function(sellribcage)
getgenv().sellribcage = sellribcage 
if getgenv().sellribcage then 
    getgenv().ItemsToSell["Rib Cage of The Saint's Corpse"] = true  
    else 
    getgenv().ItemsToSell["Rib Cage of The Saint's Corpse"] = false 
    end 
end ) 


autosellsec:NewToggle("Stone Mask", "self-explain", function(sellstoemask)
getgenv().sellstoemask = sellstoemask 
if getgenv().sellstoemask then 
    getgenv().ItemsToSell["Stone Mask"] = true  
    else 
    getgenv().ItemsToSell["Stone Mask"] = false 
    end 
end ) 

autoarcadesec:NewToggle("Auto Arcade","Make you able to arcade ig",function(autoarcade)
    getgenv().autoarcade = autoarcade 
    while getgenv().autoarcade do wait(1) pcall(function()
    if getgenv().autoarcade == false then return end 
  if plr.Backpack:FindFirstChild("Gold Coin") and game:GetService("Players").LocalPlayer.PlayerStats.Money.Value >= 1500 then
start()
spin()
    end 
    end ) 
    end 
    end ) 

autoarcadesec:NewToggle("Disable Arcade Gui","Disabling Arcade Gui Reduce Lag",function(disableguiautoarcade)
getgenv().disableguiautoarcade = disableguiautoarcade 
local arcadegui
arcadegui = plr.PlayerGui.ChildAdded:Connect(function(p)
    if p:IsA("ScreenGui") and p.Name == "RollingItem"  and getgenv().disableguiautoarcade then 
    p:Destroy()
    elseif getgenv().disableguiautoarcade == false then 
    arcadegui:Disconnect()
       end 
    end ) 
end ) 
CreditsSec:NewButton("Copy Discord", "Copy Discord of the script in your clipboard", function()
    setclipboard(tostring("https://discord.gg/hjwVr7KWnA"))
end)

CreditsSec:NewButton("[Otaku]AnimeLover#7066&Midnight#7078", "Copy Discord of the script in your clipboard", function() end)

