--[[
	id: Fapv34ztCkUmhbqc1CLVd
	name: Ebbe Auto
	description: Server
	time1: 2021-04-23 14:37:48.520988+00
	time2: 2021-04-23 14:37:48.520989+00
	uploader: upmaKftPebf1aacTSUlrUVzIhYdYC6Nowa8t9ti2
	uploadersession: res167k3kt5XoYHIb4FdWDI5eEUNQn
	flag: f
--]]

ESX = nil
local time_out = {}


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('tracker', function (source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('tracker', 1)

    TriggerClientEvent('EBBE-AutoTracker:checkPlateItem', source)
end)

RegisterServerEvent("EBBE-AutoTracker:getActivePlates")
AddEventHandler("EBBE-AutoTracker:getActivePlates", function()
    TriggerClientEvent("EBBE-AutoTracker:getActivePlates", source, time_out)
end)

RegisterServerEvent("EBBE-AutoTracker:setActivePlates")
AddEventHandler("EBBE-AutoTracker:setActivePlates", function(plate)
    time_out[plate] = false
end)

RegisterServerEvent("EBBE-AutoTracker:removeActivePlate")
AddEventHandler("EBBE-AutoTracker:removeActivePlate", function(plate)
    time_out[plate] = time_out[nil]
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent("EBBE-AutoTracker:updateActivePlate", xPlayers[i], plate)
    end
end)