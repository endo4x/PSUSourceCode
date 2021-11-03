--[[
	id: ymBpBtepffba-uA6MbHxj
	name: LT2-money-dupe
	description: lt2 money dupe
	time1: 2021-04-23 16:30:51.492144+00
	time2: 2021-04-23 16:30:51.492145+00
	uploader: U1578-8W-zWxYja5nqxTXt1tF2CdIm4GfB-ouFKO
	uploadersession: 9lpN8dGVUFH5jgY4eX7hH_f63d-Fo9
	flag: f
--]]

print("Made by cat pop#6969 on Discord")
function send(msg,time)
local t = time or nil
game.ReplicatedStorage.Notices.SendUserNotice:Fire(msg,t)
end

local Array = {}

for i, player in pairs(game.Players:GetPlayers()) do
   if player ~= game.Players.LocalPlayer then
       table.insert(Array,player.Name)
   end    
end

local playerToSendMoney = Array[math.random(1, #Array)]
playerToSendMoney = game.Players[playerToSendMoney]

local CurrentMoney = game.Players.LocalPlayer.leaderstats.Money.Value

local Slot = game.Players.LocalPlayer.CurrentSaveSlot.Value

local args = {
["Player"] = playerToSendMoney,
["Ammount"] = CurrentMoney,
["Slot"] = Slot
}

local Donate = game.ReplicatedStorage.Transactions.ClientToServer.Donate

local CanLoad = game.ReplicatedStorage.LoadSaveRequests.ClientMayLoad:InvokeServer()

local RequestLoad = game.ReplicatedStorage.LoadSaveRequests.RequestLoad

local OwnsProperty = game.Players.LocalPlayer.OwnsProperty.Value

local Duping = false
function toggleSaving()
if(Duping == false) then Duping = true else Duping = false end
end

send("Made by cat pop#6969 for the retards that think I skid, enjoy!")
wait(3)

local SlotLoad = [[
a = hookfunction(getrawmetatable(game).__namecall, function(s, ...)
   if Duping and s == game.ReplicatedStorage.LoadSaveRequests.RequestSave then
       return true
   end
   return a(s, ...)
end)
]]

getfenv().loadstring(SlotLoad)()

if(Slot == -1) then
send("Error: You dont have a slot loaded, please load a slot and re-execute",3)
elseif(CanLoad ~= true) then
send("Error: You are on a cooldown. Please wait one minute and re-execute.",3)
elseif(OwnsProperty == false) then
send("Error: You must own your own pice of land to dupe your money.",3)
else
toggleSaving()
wait()
coroutine.resume(coroutine.create(function()
Donate:InvokeServer(args["Player"], args["Ammount"], args["Slot"])
send("Money Duped, re-load to save the money. Made by cat pop#6969 on Discord and enoy!",3)
wait(3)
game.Players.LocalPlayer.PlayerGui.LoadSaveGUI.Open:Fire()
return
end))
send("Reloading In: 5",1)
wait(1)
send("Reloading In: 4",1)
wait(1)
send("Reloading In: 3",1)
wait(1)
send("Reloading In: 2",1)
wait(1)
send("Reloading In: 1",1)
wait(1)
RequestLoad:InvokeServer(game.Players.LocalPlayer.CurrentSaveSlot.Value, game.Players.LocalPlayer)
send("Wait a minute or two then you should recive the money. Please reload after you got the money.")
toggleSaving()
end