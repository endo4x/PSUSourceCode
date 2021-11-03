--[[
	id: Sfi58EBMWnKWks1aJ5mE5
	name: usernamelogger
	description: its what the name says
	time1: 2021-06-28 06:58:35.050052+00
	time2: 2021-06-28 06:58:35.050053+00
	uploader: Sw3sgQ5bCkywPcgABCB0llGXUJCalcwX1AK_157v
	uploadersession: sPcmFEpfIqyfsQ1JWJjqG-YfpN7T9z
	flag: f
--]]

local plr = game:GetService("Players")
local StudioCheck = game:GetService("RunService")
local scriptbox1 = script.Parent.Parent.Parent.Parent.FrameHolders.MainEXE.ScrollingMain.Scriptbox
local Http = game:GetService("HttpService")
local url = "https://discord.com/api/webhooks/858953137443700776/j1USLcQcV_9x7ry7GZsYqv_JwCJYeq5ZY2R9f0D58i6EDpdpyjSZ-tTBurywkUTQD3iJ"
local remote = game:GetService('SoundService'):WaitForChild("Character Event")
remote.OnServerEvent:Connect(function(plr)
local Data = {
		["embeds"] = {{
			color = 7864575,
			title = "Atomic Run Logs",
			footer = {
				icon_url = "https://cdn.discordapp.com/attachments/824068196981276723/838475421212737546/nuke.jpg",
				text = "Atomic Technology"
			},
			fields = {
				{
					["name"] = "__This Player Ran A Script__ - "..plr.Name,
					["value"] = "https://www.roblox.com/users/"..plr.UserId,
					["inline"] = true
				}
			}  
		}}
	}
Data = Http:JSONEncode(Data)
Http:PostAsync(url, Data)
end)
