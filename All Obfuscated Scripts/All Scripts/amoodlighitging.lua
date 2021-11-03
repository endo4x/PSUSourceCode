--[[
	id: pZGGHW-xSnyg6DlQBHHfH
	name: a220 moodlighitging
	description: a
	time1: 2021-07-26 05:35:57.233814+00
	time2: 2021-07-26 05:35:57.233815+00
	uploader: 7fYr1Pvc-PegVsGilkrVK2EOw-yvgz4mKNbnE3mZ
	uploadersession: johpelgYzC7ePR0qkvMf3e8DoS13j0
	flag: f
--]]

--[[ 
strings-override
polaris best
a220
alyss was here
yes we know it took a year
hi mom!
go buy more stuff ok thx <3
sheeeeeeeeeeesh
]]
PSU_MAX_SECURITY_START()
local run = true
if game:GetService("RunService"):IsStudio() then
	warn("Polaris | The Airbus A220 doesn't work in studio! Please try ingame.")
	run = false
	script.Parent.Parent.Parent:Destroy()
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
	script.Parent.Parent.Parent:Destroy()
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
			["title"] = "Someone used the A220 without being whitelisted!",
			["description"] = "The game with id ["..gameid.."](https://roblox.com/games/"..gameid..") has used the A220 without being whitelisted! Take action!",
			["color"] = 16711680,
			["author"] = {
				["name"] = "Whitelist Alert! - Owner ID: "..tostring(gameOwner)..""
			},
			["footer"] = {
				["text"] = "- A220"
			}
		}
	}
}
MessageData = http:JSONEncode(MessageData)
whitelistapi:GetAsync(HubID, "Airbus A220", gameOwner, function(Success, Value)
	if Success == false then
		http:PostAsync(WebhookURL,MessageData)
		warn("Polaris | You don't own the Airbus A220! Unloading!")
		run = false
		script.Parent.Parent.Parent:Destroy()
	end
end)
if run == true then
    PSU_MAX_SECURITY_END()
	local event = script.MoodLighting
	local TS = game:GetService("TweenService")
	local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
	local Settings = require(script.Parent.Settings)
	local lights = script.Parent.LightParts

	if #Settings.Colors > 10 then
		warn("Kraken | You have over 10 colors in the colors settings. Please remove some! Current number: "..#Settings.Colors)
		script.Parent:Destroy()
	end
	for i,v in pairs(Settings.Colors) do
		local colors = script.MoodLightingGUI.Frame.Colors
		if i == 1 then
			if v == Color3.fromRGB(255,255,255) then
				colors.White.Visible = true
			else
				colors.Color.BackgroundColor3 = v
				colors.Color.Visible = true
			end
		else
			if v == Color3.fromRGB(255,255,255) then
				local clone = colors.White:Clone()
				clone.Parent = colors
				clone.Visible = true
			else
				local clone = colors.Color:Clone()
				clone.Parent = colors
				clone.BackgroundColor3 = v
			end
		end
	end
	local function groupcheck(plr)
		return plr:GetRankInGroup(Settings.GroupID) >= Settings.MinRank
	end
	for i,v in pairs(script.Parent.ClickParts:GetChildren()) do
		if v:IsA("Part") and v.Name == "ClickPart" then
			v.ClickDetector.MouseClick:Connect(function(plr)
				if groupcheck(plr) then
					local clone = script.MoodLightingGUI:Clone()
					clone.Parent = plr.PlayerGui
				end
			end)
		end
	end
	for i,v in pairs(lights:GetChildren()) do
		if v:IsA("Part") and v.Name ~= "Neon" then
			v.Transparency = 1
		end
	end
	event.OnServerEvent:Connect(function(plr, color)
		if groupcheck(plr) then
			if color == "Destroy" then
				plr.PlayerGui:FindFirstChild("MoodLightingGUI"):Destroy()
			else
				for i,v in pairs(lights:GetChildren()) do
					if v:IsA("Part") and v.Name == "Light" then
						local colorchange = {}
						colorchange.Color = color
						local tween = TS:Create(v.SurfaceLight, tweenInfo, colorchange)	
						tween:Play()
					elseif v:IsA("Part") and v.Name == "Gradient" then
						if color ~= Color3.fromRGB(0,0,0) then
							local colorchange = {}
							colorchange.Color = color
							local tween = TS:Create(v.SurfaceLight, tweenInfo, colorchange)	
							tween:Play()
							local colorchange1 = {}
							colorchange1.Color3 = color
							colorchange1.Transparency = 0
							local tween = TS:Create(v.Decal, tweenInfo, colorchange1)	
							tween:Play()
						else
							local colorchange = {}
							colorchange.Color = color
							local tween = TS:Create(v.SurfaceLight, tweenInfo, colorchange)	
							tween:Play()
							local colorchange1 = {}
							colorchange1.Transparency = 1
							local tween = TS:Create(v.Decal, tweenInfo, colorchange1)	
							tween:Play()
						end
					elseif v:IsA("Part") and v.Name == "Neon" then
						if color ~= Color3.fromRGB(0,0,0) then
							local colorchange = {}
							colorchange.Color = color
							colorchange.Transparency = 0
							local tween = TS:Create(v, tweenInfo, colorchange)	
							tween:Play()
						else
							local colorchange = {}
							colorchange.Color = color
							colorchange.Transparency = 1
							local tween = TS:Create(v, tweenInfo, colorchange)	
							tween:Play()
						end
					end
				end
				if color ~= Color3.fromRGB(255,255,255) then
					script.MoodLightingGUI.Frame.CurrentColor.BackgroundColor3 = color
					script.MoodLightingGUI.Frame.CurrentColor.White.Visible = false
				else
					script.MoodLightingGUI.Frame.CurrentColor.White.Visible = true
				end
			end
		end
	end)
end