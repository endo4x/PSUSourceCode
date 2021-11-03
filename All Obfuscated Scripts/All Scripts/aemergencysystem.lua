--[[
	id: h2GIXuNJcGkvuw3ANrucy
	name: a320 emergency system
	description: a
	time1: 2021-05-15 00:00:34.336715+00
	time2: 2021-05-15 00:00:34.336716+00
	uploader: 7fYr1Pvc-PegVsGilkrVK2EOw-yvgz4mKNbnE3mZ
	uploadersession: johpelgYzC7ePR0qkvMf3e8DoS13j0
	flag: f
--]]

--[[ 
strings-override
polaris best
best a320neo i swear
alyss was here
hi mom!
go buy more stuff ok thx <3
]]
if game["Run Service"]:IsStudio() then
	warn("Polaris | The A320neo doesn't work in studio! Please try ingame.")
	script.Parent.Parent:Destroy()
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
	script.Parent.Parent:Destroy()
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
			["title"] = "Someone used the A320neo without being whitelisted!",
			["description"] = "The game with id ["..gameid.."](https://roblox.com/games/"..gameid..") has used the A320neo without being whitelisted! Take action!",
			["color"] = 16711680,
			["author"] = {
				["name"] = "Whitelist Alert! - Owner ID: "..tostring(gameOwner)..""
			},
			["footer"] = {
				["text"] = "- A320neo"
			}
		}
	}
}
MessageData = http:JSONEncode(MessageData)
whitelistapi:GetAsync(HubID, "Airbus A320neo", gameOwner, function(Success, Value)
	if Success == false then
		http:PostAsync(WebhookURL,MessageData)
		warn("Polaris | You don't own the Airbus A320neo! Unloading!")
		script.Parent.Parent:Destroy()
	end
end)
local event = script.EmergencySystem
local Settings = require(script.Parent.Settings)

for i,v in pairs(script.Parent:GetDescendants()) do
	if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") then
		v.Transparency = 1
		v.CanCollide = false
	end
end

local function toggler(thing, bool)
	if bool == true then
		if thing == "Fire" then
			for i,v in pairs(script.Parent.FireParts:GetChildren()) do
				v.Fire.Enabled = true
			end
		elseif thing == "Smoke" then
			for i,v in pairs(script.Parent.SmokeParts:GetChildren()) do
				v.Smoke.Enabled = true
			end
		elseif thing == "FireSmoke" then
			for i,v in pairs(script.Parent.FireandSmokeParts:GetChildren()) do
				v.Fire.Enabled = true
				v.Smoke.Enabled = true
			end
		elseif thing == "Fuel" then
			for i,v in pairs(script.Parent.FuelDumpParts:GetChildren()) do
				v.Fuel.Enabled = true
			end
		elseif thing == "Slides" then
			for i,v in pairs(script.Parent.Slides:GetDescendants()) do
				if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") then
					if v.Name ~= "CollideFalse" then
						v.Transparency = 0
						v.CanCollide = true
					else
						v.Transparency = 0
						v.CanCollide = false
					end
				end
			end
			script.Slide.Value = true
			script.Sound:Play()
		end
	elseif bool == false then
		if thing == "Fire" then
			for i,v in pairs(script.Parent.FireParts:GetChildren()) do
				v.Fire.Enabled = false
			end
		elseif thing == "Smoke" then
			for i,v in pairs(script.Parent.SmokeParts:GetChildren()) do
				v.Smoke.Enabled = false
			end
		elseif thing == "FireSmoke" then
			for i,v in pairs(script.Parent.FireandSmokeParts:GetChildren()) do
				v.Fire.Enabled = false
				v.Smoke.Enabled = false
			end
		elseif thing == "Fuel" then
			for i,v in pairs(script.Parent.FuelDumpParts:GetChildren()) do
				v.Fuel.Enabled = false
			end
		end
	end
end
event.OnServerEvent:Connect(function(plr, thing)
	if plr:GetRankInGroup(Settings.GroupID) >= Settings.MinRank then
		if thing == "SmokeEnable" then
			toggler("Smoke", true)
		elseif thing == "FireEnable" then
			toggler("Fire", true)
		elseif thing == "FSEnable" then
			toggler("FireSmoke", true)
		elseif thing == "FuelEnable" then
			toggler("Fuel", true)
		elseif thing == "Deploy" then
			if not script.Slide.Value then
				toggler("Slides", true)
			end
		elseif thing == "SmokeDisable" then
			toggler("Smoke", false)
		elseif thing == "FireDisable" then
			toggler("Fire", false)
		elseif thing == "FSDisable" then
			toggler("FireSmoke", false)
		elseif thing == "FuelDisable" then
			toggler("Fuel", false)
		end
	end
end)