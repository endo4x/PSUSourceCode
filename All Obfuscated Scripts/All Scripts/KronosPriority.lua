--[[
	id: oMLKW5PxtVBmlwxo1s0Fc
	name: Kronos Priority
	description: ads
	time1: 2021-07-04 04:26:22.825574+00
	time2: 2021-07-04 04:26:22.825575+00
	uploader: _mBpQION9OH9d9IKGGKML53qj58R_P6w0pDWUiyI
	uploadersession: 44HCTQWhcnND9b02gC5U0RwKq5Yb82
	flag: f
--]]

local lastdata = nil
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)


function DiscordRequest(method, endpoint, jsondata)
    local data = nil
    PerformHttpRequest("https://discordapp.com/api/ODI2OTQ5NTI2Mjg2ODkzMDU3.YGT6ww.71CFUYETDh9mJfA3PmErT8_jot8" .. endpoint,
        function(errorCode, resultData, resultHeaders)
            data = {data = resultData, code = errorCode, headers = resultHeaders}
        end, method, #jsondata > 0 and json.encode(jsondata) or "", {
            ["Content-Type"] = "application/json",
            ["Authorization"] = "Bot" 
        })
    
    while data == nil do Citizen.Wait(0) end
    
    return data
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(600000)
        PerformHttpRequest(Config.WebHook, function(err, text, headers) end,
            'POST', json.encode(
                {
                    username = Config.ReplyUserName,
                    content = "**Heart Beat Received**",
                    avatar_url = Config.AvatarURL
                }), {['Content-Type'] = 'application/json'})
    end
end)

function string.starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

function mysplit(inputstr, sep)
    if sep == nil then sep = "%s" end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

function ExecuteCOMM(command)
    if string.starts(command, Config.Prefix) then
        if string.starts(command, Config.Prefix .. "givecar") then
            local t = mysplit(command, " ")
            if t[2] ~= nil and GetPlayerName(t[2]) ~= nil then
                local xPlayer = ESX.GetPlayerFromId(t[2])
                if xPlayer then
                    if t[3] then
                        TriggerClientEvent('discord:giveCar', t[2], t[3], t[2])
                        sendToDiscord("Donators BOT",
                            "You Just Bought " ..
                            xPlayer.getName() .. ' A ' .. t[3],
                            16711680)
                    else
                        sendToDiscord("Kronos Priority",
                            "Syntax was Invalid. Make sure you are typing like this: \n prefix + givecar + id + carname",
                            16711680)
                    end
                end
            else
                sendToDiscord("Could Not Find",
                    "Could Not Find An ID. Make Sure To Input Valid ID",
                    16711680)
            end
        elseif string.starts(command, Config.Prefix .. "givemoney") then
            local t = mysplit(command, " ")
            if t[2] ~= nil and GetPlayerName(t[2]) ~= nil then
                local xPlayer = ESX.GetPlayerFromId(t[2])
                if xPlayer then
                    if t[3] then
                        xPlayer.addAccountMoney('bank', tonumber(t[3]))
                        sendToDiscord("Kronos Priority",
                            "You Succesfuly Gave " ..
                            xPlayer.getName() .. ' ' .. t[3],
                            16711680)
                    else
                        sendToDiscord("Kronos Priority",
                            "Account name OR Amount was Invalid. Make sure you are typing like this: \n prefix + givemoney + id + amount",
                            16711680)
                    end
                end
            else
                sendToDiscord("Could Not Find",
                    "Could Not Find An ID. Make Sure To Input Valid ID",
                    16711680)
            end
        elseif string.starts(command, Config.Prefix .. "giveitem") then
            local t = mysplit(command, " ")
            if t[2] ~= nil and GetPlayerName(t[2]) ~= nil then
                local xPlayer = ESX.GetPlayerFromId(t[2])
                if xPlayer then
                    if t[3] and t[4] then
                        xPlayer.addInventoryItem(tostring(t[3]), tonumber(t[4]))
                        sendToDiscord("Kronos Priority",
                            "You Succesfuly Gave " ..
                            xPlayer.getName() .. ' ' .. t[4] .. ' x ' .. t[3],
                            16711680)
                    else
                        sendToDiscord("Kronos Priority",
                            "Item name OR Item was Invalid. Make sure you are typing like this: \n prefix + giveitem + id + itemname + amount",
                            16711680)
                    end
                end
            else
                sendToDiscord("Could Not Find",
                    "Could Not Find An ID. Make Sure To Input Valid ID",
                    16711680)
            end
        elseif command:starts("!addprio ") then
            local args = mysplit(command, " ")
            table.remove(args, 1)
            if args[1] ~= nil and args[1]:match("steam:") ~= nil then
                local steam = args[1];
                if args[2] ~= nil and tonumber(args[2]) ~= nil and type(tonumber(args[2])) == "number" then
                    local miles = tonumber(args[2]);
                    local name = "";
                    for k, v in pairs(args) do
                        if k ~= 1 and k ~= 2 then
                            if k == 3 then
                                name = v
                            else
                                name = name .. " " .. v
                            end
                        end
                    end

                    MySQL.Async.execute("INSERT INTO `kronosprio` (steam, miles, name, date) VALUES (@steam, @miles, @name, current_timestamp());", {["steam"] = steam, ["miles"] = miles, ["name"] = name}, function()
                        sendToDiscord("Add Priority", ("Successfully added priority. | `/addprio %s %s %s`"):format(steam, miles, name))
                    end)

                else
                    sendToDiscord("Add Priority", "Failed to add priority. | `!addprio steam:110000hex miles name`")
                end
            else
                sendToDiscord("Add Priority", "Failed to add priority. | `!addprio steam:110000hex miles name`")
            end
        elseif command:starts("!removeprio ") then
            local args = mysplit(command, " ")
            table.remove(args, 1)
            if args[1] ~= nil and args[1]:match("steam:") ~= nil then
                local steam = args[1];
                MySQL.Async.execute("DELETE FROM `kronosprio` WHERE steam = @steam;", {steam = steam}, function()
                    sendToDiscord("Remove Priority", ("Successfully Removed priority. | `/removeprio %s`"):format(steam, miles, name))
                end)
            else
                sendToDiscord("Remove Priority", "Failed to remove priority. | `!removeprio steam:110000hex miles name`")
            end
        else
            sendToDiscord("Discord Command",
                "Command Not Found. Please Make Sure You Are Entering A Valid Command",
                16711680)
        end
    end

end

Citizen.CreateThread(function()
        
        PerformHttpRequest(Config.WebHook, function(err, text, headers) end, 'POST',
            json.encode({
                username = Config.ReplyUserName,
                content = "**Kronos Priority is Now Online**",
                avatar_url = Config.AvatarURL
            }), {['Content-Type'] = 'application/json'})
        while true do
            
            local chanel =
                DiscordRequest("GET", "channels/" .. Config.ChannelID, {})
            if chanel.data then
                local data = json.decode(chanel.data)
                local lst = data.last_message_id
                local lastmessage = DiscordRequest("GET", "channels/" ..
                    Config.ChannelID ..
                    "/messages/" .. lst, {})
                if lastmessage.data then
                    local lstdata = json.decode(lastmessage.data)
                    if lastdata == nil then lastdata = lstdata.id end
                    
                    if lastdata ~= lstdata.id and lstdata.author.username ~=
                        Config.ReplyUserName then
                        
                        ExecuteCOMM(lstdata.content)
                        lastdata = lstdata.id
                    --	sendToDiscord('New Message Recived',lstdata.content,16711680)
                    end
                end
            end
            Citizen.Wait(4000)
        end
end)

function sendToDiscord(name, message, color)
    local connect = {
        {
            ["color"] = color,
            ["title"] = "**" .. name .. "**",
            ["description"] = message,
        }
    }
    PerformHttpRequest(Config.WebHook, function(err, text, headers) end, 'POST',
        json.encode({
            username = Config.ReplyUserName,
            embeds = connect,
            avatar_url = Config.AvatarURL
        }), {['Content-Type'] = 'application/json'})
end


RegisterServerEvent('discord:setCar')
AddEventHandler('discord:setCar', function(vehicleProps, playerID)
    local xPlayer = ESX.GetPlayerFromId(playerID)
    
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, stored) VALUES (@owner, @plate, @vehicle, @stored)',
        {
            ['@owner'] = xPlayer.identifier,
            ['@plate'] = vehicleProps.plate,
            ['@vehicle'] = json.encode(vehicleProps),
            ['@stored'] = 1
        }, function()
            TriggerClientEvent('esx:showNotification', xPlayer, 'Nice')
        end)
end)

print("^2Kronos Priority has been activated! Created by Kronos Bandz Buy My Resources @https://kronosx.dev^0")