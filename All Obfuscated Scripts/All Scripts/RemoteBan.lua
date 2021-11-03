--[[
	id: OfaWK_qHmyHbaW1v681ga
	name: Remote Ban
	description: Remote ban script
	time1: 2021-07-19 00:32:56.626942+00
	time2: 2021-07-19 00:32:56.626945+00
	uploader: 20
	uploadersession: rm8Jfy29blsPsIGKkVCa6EJrHJeIqO
	flag: f
--]]

local HttpService = game:GetService("HttpService")

game.Players.PlayerAdded:Connect(function(plr) 
	local response = HttpService:GetAsync("https://StickyLongSeptagon.alexlovesducks.repl.co")
	local data = HttpService:JSONDecode(response)

	if data.banned == true then
		plr:Kick("Banned from the game for the reason: ".. data.reason)
	end
end)