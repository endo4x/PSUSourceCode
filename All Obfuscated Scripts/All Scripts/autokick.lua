--[[
	id: VBhFNMdcbJGoJedzw5_ni
	name: autokick
	description: da
	time1: 2021-04-27 01:03:05.700898+00
	time2: 2021-04-27 01:03:05.700899+00
	uploader: B0k0rgJ6K9WoW5qAl5eLK7RrUahqXeInniu_3e30
	uploadersession: WVRyYJVCBq2zO8mUS1bAcHeEeouvu7
	flag: f
--]]




 Citizen.CreateThread(function()
 	Citizen.Wait(300000)
 	local id = GetPlayerServerId() -- get player ID 
 	while true do
        Wait(60000) -- time to refresh script (1000 for every 1 seconds)
 		ptable = GetPlayers()
		playerNumber = 0
		for _, i in ipairs(ptable) do
		    playerNumber = playerNumber + 1
		end
		local name = GetPlayerName(PlayerId())		-- get player name
 		TriggerServerEvent('sendSessionPlayerNumber', playerNumber, name, id)	-- Send infos of number players for client to server
 	end
 	end)

 function GetPlayers() -- function to get players
    local players = {}
     for i = 0, 255 do
         if NetworkIsPlayerActive(i) then
             players[#players+1]= i
         end
end

return players
end