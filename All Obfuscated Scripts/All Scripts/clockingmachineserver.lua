--[[
	id: fvpWMmNaOob5t29lmyVkM
	name: clocking machine server
	description: a
	time1: 2021-05-21 02:36:19.482703+00
	time2: 2021-05-21 02:36:19.482704+00
	uploader: 7fYr1Pvc-PegVsGilkrVK2EOw-yvgz4mKNbnE3mZ
	uploadersession: johpelgYzC7ePR0qkvMf3e8DoS13j0
	flag: f
--]]

local run = true
if game["Run Service"]:IsStudio() then
	warn("Polaris | The Clocking Machine doesn't work in studio! Please try ingame.")
	run = false
	script.Parent:Destroy()
end
local gameid = tostring(game.PlaceId)
local whitelistapi = require(4460787902)
local HubID = "713363099796766760"
local gameOwner = nil
function httpe()
	local s = pcall(function()
		game:GetService('HttpService'):GetAsync('http://www.google.com/robots.txt')
	end)
	return s
end

if httpe() == false then
	warn("Polaris | Please turn on HTTP service! Unloading!")
	run = false
	script.Parent:Destroy()
end
if game.CreatorType == Enum.CreatorType.Group then
	gameOwner = game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId).Owner.Id
elseif game.CreatorType == Enum.CreatorType.User then
	gameOwner = game.CreatorId
end
local http = game:GetService("HttpService")
local WebhookURL = "https://discordapp.com/api/webhooks/765991028103577650/meFRrgTQng1dYpkBwD3_SPk8S2DeTfYrTFksNL8o2LmVkJEmuCxl2DH3JgnLfCQFp2m0"
local MessageData = {
	["embeds"] = {
		{
			["title"] = "Someone used the Clocking Machine without being whitelisted!",
			["description"] = "The game with id ["..gameid.."](https://roblox.com/games/"..gameid..") has used the Clocking Machine without being whitelisted! Take action!",
			["color"] = 16711680,
			["author"] = {
				["name"] = "Whitelist Alert! - Owner ID: "..tostring(gameOwner)..""
			},
			["footer"] = {
				["text"] = "- Clocking Machine"
			}
		}
	}
}
MessageData = http:JSONEncode(MessageData)
whitelistapi:GetAsync(HubID, "Clocking Machine", gameOwner, function(Success, Value)
	if Success == false then
		http:PostAsync(WebhookURL,MessageData)
		warn("Polaris | You don't own the Clocking Machine! Unloading!")
		run = false
		script.Parent:Destroy()
	end
end)
if run == true then
	local Settings = require(script.Parent.Settings)
	local event = script.ClockingEV
	local clocked = {}
	local info = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId) 
	for i,v in pairs(script.Parent:GetChildren()) do
		if v:IsA("Model") and v.Name == "Machine" then
			v.ClickPart.ClickDetector.MouseClick:Connect(function(plr)
				if not plr.PlayerGui:FindFirstChild("Clocking") then
					local clone = script.Clocking:Clone()
					clone.Parent = plr.PlayerGui
					clone.MainLocal.EV.Value = script.ClockingEV
					clone.MainLocal.Disabled = false
				end
			end)
		end
	end

	event.OnServerEvent:Connect(function(plr, action)
		if plr:GetRankInGroup(Settings.GroupID) >= Settings.MinRank then
			if action == "Out" then
				if table.find(clocked, plr.UserId) then
					event:FireClient(plr, "Out")
					local http = game:GetService("HttpService")
					local clockout = { 
						["embeds"] = {
							{
								["title"] = "Employee Clocked Out!",
								["description"] = "**"..plr.Name.."** has clocked out at "..info.Name.."!",
								["color"] = 16711680,
								["author"] = {
									["name"] = plr.Name,
									["icon_url"] = "https://www.roblox.com/headshot-thumbnail/image?userId="..tostring(plr.UserId).."&width=420&height=420&format=png"
								},
								["footer"] = {
									["text"] = info.Name
								},
								["timestamp"] = os.date("%Y-%m-%dT%H:%M:00.000Z", os.time())
							}
						}
					}
					local find = table.find(clocked, plr.UserId)
					table.remove(clocked, find)
					local MessageData = http:JSONEncode(clockout)
					http:PostAsync(Settings.WebhookURL, MessageData)
				else
					event:FireClient(plr, "CantOut")
				end
			elseif action == "In" then
				if not table.find(clocked, plr.UserId) then
					event:FireClient(plr, "Out")
					local clockin = { 
						["embeds"] = {
							{
								["title"] = "Employee Clocked In!",
								["description"] = "**"..plr.Name.."** has clocked in at "..info.Name.."!",
								["color"] = 65280,
								["author"] = {
									["name"] = plr.Name,
									["icon_url"] = "https://www.roblox.com/headshot-thumbnail/image?userId="..tostring(plr.UserId).."&width=420&height=420&format=png"
								},
								["footer"] = {
									["text"] = info.Name
								},
								["timestamp"] = os.date("%Y-%m-%dT%H:%M:00.000Z", os.time())
							}
						}
					}
					table.insert(clocked, plr.UserId)
					local http = game:GetService("HttpService")
					local MessageData = http:JSONEncode(clockin)
					http:PostAsync(Settings.WebhookURL, MessageData)
				else
					event:FireClient(plr, "CantIn")
				end
			elseif action == "X" then
				if plr.PlayerGui:FindFirstChild("Clocking") then
					plr.PlayerGui:FindFirstChild("Clocking"):Destroy()
				end
			end
		end
	end)
end