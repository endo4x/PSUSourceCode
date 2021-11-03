--[[
	id: Z57UFopA36_TyYIQKu0AG
	name: Can dlog - client
	description: Can dlog - client
	time1: 2021-04-29 23:14:21.050934+00
	time2: 2021-04-29 23:14:21.050935+00
	uploader: 0lXSC9Q-U1coaa_LJ3Y4z0ksSbDtOnFnk-FHONUw
	uploadersession: bT8lPMVQRr9_avVe8cLBcyHEwpKwPL
	flag: f
--]]

--client 
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100000)
	end
end)

local firstSpawn = true
player = PlayerId()
AddEventHandler("playerSpawned", function()
    if firstSpawn then
    SetPlayerControl(player, false, 0)
    firstSpawn = false
    Wait(7000)
    TriggerServerEvent("esx:canlog")
    SetPlayerControl(player, true, 0)
    firstSpawn = false
    end
end)


exports('discord', function(message, color, channel)
	TriggerServerEvent('ClientDiscord', message, color, channel)
end)
