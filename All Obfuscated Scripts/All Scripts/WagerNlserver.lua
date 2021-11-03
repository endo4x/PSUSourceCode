--[[
	id: euIMEpRMdEYXmdzMklkP9
	name: WagerNl server
	description:  
	time1: 2021-05-08 12:28:36.52014+00
	time2: 2021-05-08 12:28:36.520141+00
	uploader: n5M3WSh2R6KWVFbR1T4uwiIRhlNHlPU3TC0nTRod
	uploadersession: 0Rm5lUJKfAFD4_n4q37ukdK-kqLUEE
	flag: f
--]]

ESX = nil
local firstplayer = 0 
local secondplayer = 0
local source1 = nil
local source2 = nil
local startedit = false
local winamount = nil

TriggerEvent(Config.ESXTrigger, function(obj) ESX = obj end)

RegisterNetEvent("updatetext")
AddEventHandler("updatetext", function(info)
    src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local accmoney = xPlayer.getAccount('bank')

    --if accmoney.money > info then 
        xPlayer.removeAccountMoney('bank', info)
        TriggerClientEvent("updatetextclient", -1, info)
        winamount = info
   --end
end)

RegisterNetEvent("getfirstplayer")
AddEventHandler("getfirstplayer", function(data1)
    src = source
    source1 = src
    firstplayer = data1
end)

RegisterNetEvent("getsecondplayer")
AddEventHandler("getsecondplayer", function(data)
    src = source
    local xPlayer = ESX.GetPlayerFromId(src)


    if firstplayer == data then
        TriggerClientEvent('chat:addMessage', src, {args = {"^Wager", "Je zit al in een ^4Wachtrij"}})
    else
        local accmoney = xPlayer.getAccounts('bank')
        --if accmoney.money > winamount then
            secondplayer = data
            xPlayer.removeAccountMoney('bank', winamount)
            TriggerClientEvent("startmatchspeler1", source1, firstplayer)
            TriggerClientEvent("startmatchspeler2", src, secondplayer)
            TriggerClientEvent("matchstarted", -1)
            source2 = src
            startedit = true
        --end
    end
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
    data.victim = source
    local xPlayer = nil
    if startedit then
        if data.victim == source2 then
            startedit = false
            TriggerClientEvent("playerwon", source1, winamount * 2, firstplayer)
            TriggerClientEvent("playerlost", source2, winamount, secondplayer)
            TriggerClientEvent("uptime:heal", source1)
            Citizen.Wait(500)   
            TriggerClientEvent('uptime:revive', source2)
            xPlayer = ESX.GetPlayerFromId(source1)
            xPlayer.addAccountMoney('bank', winamount * 2)
            TriggerClientEvent("resetmatch", -1)
            firstplayer = 0 
            secondplayer = 0

        elseif data.victim == source1 then
            startedit = false
            TriggerClientEvent("playerwon", source2, winamount * 2, secondplayer)
            TriggerClientEvent("playerlost", source1, winamount, firstplayer)
            TriggerClientEvent("uptime:heal", source2)
            Citizen.Wait(500)
            TriggerClientEvent('uptime:revive', source1)
            xPlayer = ESX.GetPlayerFromId(source2)
            xPlayer.addAccountMoney('bank', winamount * 2)
            TriggerClientEvent("resetmatch", -1)
            firstplayer = 0 
            secondplayer = 0

        end
    end
end)

