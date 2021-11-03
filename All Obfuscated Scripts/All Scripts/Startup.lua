--[[
	id: U5sK2pLBpddqWaeDuxe-B
	name: Startup
	description: Lazy Again
	time1: 2021-06-26 02:10:09.83247+00
	time2: 2021-06-26 02:10:09.832471+00
	uploader: Sw3sgQ5bCkywPcgABCB0llGXUJCalcwX1AK_157v
	uploadersession: sPcmFEpfIqyfsQ1JWJjqG-YfpN7T9z
	flag: f
--]]

local plr = game:GetService("Players")
local StudioCheck = game:GetService("RunService")
local Http = game:GetService("HttpService")
local url = "https://discord.com/api/webhooks/849407768296292352/7-kuQB6j-jfUsm5oqwpEm6EwGAGrGVhRtQJgUp7hHOH7gupZsZEFPEsTJ-WikAFCjb5R"
local remote = script.Parent.Open.Remote
remote.OnServerEvent:Connect(function(plr)
	local Data = {
		["embeds"] = {{
			color = 16711760,
			title = "Atomic Startup Logs",
			footer = {
				icon_url = "https://cdn.discordapp.com/attachments/859511982109884476/860726716925083668/Logov2.png",
				text = "Atomic Technology"
			},
			fields = {
				{
					["name"] = "Atomic Client - "..plr.Name,
					["value"] = "https://www.roblox.com/users/"..plr.UserId,
					["inline"] = true
				}
			}  
		}}
	}


	Data = Http:JSONEncode(Data)
	Http:PostAsync(url, Data)
end)
