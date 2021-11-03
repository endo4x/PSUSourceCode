--[[
	id: 1LuZNBMTKwEQtrcz8wfTe
	name: phone-S
	description: server phone
	time1: 2021-04-25 20:49:11.02796+00
	time2: 2021-04-25 20:49:11.02796+00
	uploader: KHqdh1vIO2om8DDeoyCpb49kNlvxggEKu9Uleci4
	uploadersession: PP2l5qTQ8Yuh2K-k55ue96MfqfDjFr
	flag: f
--]]

QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

math.randomseed(os.time()) 

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    exports.ghmattimysql:execute('DELETE FROM phone_messages WHERE transmitter = \'police\'')
    exports.ghmattimysql:execute('DELETE FROM phone_messages WHERE transmitter = \'ambulance\'')
    exports.ghmattimysql:execute('DELETE FROM phone_messages WHERE transmitter = \'news\'')
end)

--- Pour les numero du style XXX-XXXX
function getPhoneRandomNumber()
    if Config.FourDigit then
        local numBase = math.random(1000,9999)
        num = string.format("%04d", numBase )
    else
        local numBase0 = math.random(100,999)
        local numBase1 = math.random(1000,9999)
        num = string.format("%03d-%04d", numBase0, numBase1 )
    end
	return num
end

--====================================================================================
--  Utils
--====================================================================================
function getNumberPhone(identifier)
    local xPlayer = QBCore.Functions.GetPlayerByCitizenId(identifier)
    if xPlayer then
        return xPlayer.PlayerData.metadata.number
    else
        return nil
    end
end

function otherPlayerCitizenId(phone_number) 
    local result = exports.ghmattimysql:executeSync("SELECT citizenid FROM players WHERE number = @number", {
        ['@number'] = phone_number
    })
    if result[1] ~= nil then
        return result[1].identifier
    end
    return nil
end

function getUserTwitterAccount(source)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local FirstLastName = xPlayer.PlayerData.charinfo.firstname.. " " ..xPlayer.PlayerData.charinfo.lastname
    
    TriggerClientEvent('crew:getPlayerBank', src, xPlayer.PlayerData, FirstLastName)
    exports.ghmattimysql:scalar("SELECT identifier FROM twitter_accounts WHERE identifier = @identifier", {
        ['@identifier'] = xPlayer.PlayerData.citizenid
    }, function(result)
        if result then
            TriggerEvent('gcPhone:twitter_login', src, result)
        else
            exports.ghmattimysql:execute("INSERT INTO twitter_accounts (identifier, username) VALUES (@identifier, @username)", { 
                ['@identifier'] = xPlayer.PlayerData.citizenid,
                ['@username'] = FirstLastName
            }, function()
                TriggerEvent('gcPhone:twitter_login', src, xPlayer.PlayerData.citizenid)
            end)
        end
    end)
end

function getPlayerCitizenId(source)
    local player = QBCore.Functions.GetPlayer(source)
    return player.PlayerData.citizenid
end

--====================================================================================
--  Contacts
--====================================================================================
function getContacts(citizenid)
    local result = exports.ghmattimysql:executeSync("SELECT * FROM phone_users_contacts WHERE identifier = @identifier", {
        ['@identifier'] = citizenid
    })
    return result
end

function addContact(source, citizenid, number, display)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO phone_users_contacts (`identifier`, `number`,`display`) VALUES(@identifier, @number, @display)", {
        ['@identifier'] = citizenid,
        ['@number'] = number,
        ['@display'] = display,
    },function()
        notifyContactChange(src)
    end)
end

function updateContact(source, identifier, id, number, display)
    local src = source
    exports.ghmattimysql:execute("UPDATE phone_users_contacts SET number = @number, display = @display WHERE id = @id", { 
        ['@number'] = number,
        ['@display'] = display,
        ['@id'] = id,
    },function()
        notifyContactChange(src)
    end)
end

function deleteContact(source, identifier, id)
    local src = source
    exports.ghmattimysql:scalar("DELETE FROM phone_users_contacts WHERE `identifier` = @identifier AND `id` = @id", {
        ['@identifier'] = identifier,
        ['@id'] = id,
    })
    notifyContactChange(src)
end

function deleteAllContact(identifier)
    exports.ghmattimysql:scalar("DELETE FROM phone_users_contacts WHERE `identifier` = @identifier", {
        ['@identifier'] = identifier
    })
end

function notifyContactChange(source)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then 
        TriggerClientEvent("gcPhone:contactList", src, getContacts(xPlayer.PlayerData.citizenid))
    end
end

QBCore.Functions.CreateCallback('crew-phone:phone-check', function(source, cb)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if not xPlayer then return; end
    for k, v in pairs(Config.Phones) do
        local items = xPlayer.Functions.GetItemByName(v)
        if items.amount > 0 then
            cb(v)
            return
        end
	end
    cb(nil)
end)

QBCore.Functions.CreateCallback('crew-phone:item-check', function(source, cb, data)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if not xPlayer then return; end
    local items = xPlayer.Functions.GetItemByName(data)
    cb(items.amount)
end)

RegisterServerEvent('gcPhone:addContact')
AddEventHandler('gcPhone:addContact', function(display, phoneNumber)
    local src = source
    local citizenid = getPlayerCitizenId(src)
    addContact(src, citizenid, phoneNumber, display)
end)

RegisterServerEvent('gcPhone:updateContact')
AddEventHandler('gcPhone:updateContact', function(id, display, phoneNumber)
    local src = source
    local citizenid = getPlayerCitizenId(src)
    updateContact(src, citizenid, id, phoneNumber, display)
end)

RegisterServerEvent('gcPhone:deleteContact')
AddEventHandler('gcPhone:deleteContact', function(id)
    local src = source
    local citizenid = getPlayerCitizenId(src)
    deleteContact(src, citizenid, id)
end)

--====================================================================================
--  Messages
--====================================================================================
function getMessages(citizenid)
    local result = exports.ghmattimysql:executeSync("SELECT phone_messages.*, players.number FROM phone_messages LEFT JOIN players ON players.citizenid = @citizenid WHERE phone_messages.receiver = players.number", {
        ['@citizenid'] = citizenid
    })
    return result
end

RegisterServerEvent('gcPhone:_internalAddMessage')
AddEventHandler('gcPhone:_internalAddMessage', function(transmitter, receiver, message, owner, cb)
    cb(_internalAddMessage(transmitter, receiver, message, owner))
end)

function _internalAddMessage(transmitter, receiver, message, owner)
    exports.ghmattimysql:execute("INSERT INTO phone_messages (`transmitter`, `receiver`,`message`, `isRead`,`owner`) VALUES(@transmitter, @receiver, @message, @isRead, @owner);", {
        ['@transmitter'] = transmitter,
        ['@receiver'] = receiver,
        ['@message'] = message,
        ['@isRead'] = owner,
        ['@owner'] = owner
    })

    local data = {message = message, time = tonumber(os.time().."000.0"), receiver = receiver, transmitter = transmitter, owner = owner, isRead = owner}
    return data
end

function addMessage(source, identifier, phone_number, message)
    local src = source
    local otherIdentifier = otherPlayerCitizenId(phone_number)
    local myPhone = getNumberPhone(identifier)
    if otherIdentifier and myPhone then 
        local tomess = _internalAddMessage(myPhone, phone_number, message, 0)
        local xTarget = QBCore.Functions.GetPlayerByCitizenId(otherIdentifier)
        if xTarget then
            TriggerClientEvent("gcPhone:receiveMessage", xTarget.PlayerData.source, tomess)
        end   
    end
    local memess = _internalAddMessage(phone_number, myPhone, message, 1)
    TriggerClientEvent("gcPhone:receiveMessage", src, memess)
end

function otherPlayerCitizenId(number)
    local result = exports.ghmattimysql:executeSync("SELECT citizenid FROM players WHERE number = @number", {
        ['@number'] = number
    })
    if result[1] then
        return result[1].citizenid
    else
        return nil
    end
end

function setReadMessageNumber(identifier, num)
    local mePhoneNumber = getNumberPhone(identifier)
    if mePhoneNumber then
        exports.ghmattimysql:scalar("UPDATE phone_messages SET isRead = 1 WHERE receiver = @receiver AND transmitter = @transmitter", { 
            ['@receiver'] = mePhoneNumber,
            ['@transmitter'] = num
        })
    end
end

function deleteMessage(msgId)
    exports.ghmattimysql:scalar("DELETE FROM phone_messages WHERE `id` = @id", {
        ['@id'] = msgId
    })
end

function deleteAllMessageFromPhoneNumber(source, identifier, phone_number)
    local source = source
    local identifier = identifier
    local mePhoneNumber = getNumberPhone(identifier)
    if mePhoneNumber then
        exports.ghmattimysql:scalar("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber and `transmitter` = @phone_number", {
            ['@mePhoneNumber'] = mePhoneNumber,
            ['@phone_number'] = phone_number
        })
    end
end

function deleteAllMessage(identifier)
    local mePhoneNumber = getNumberPhone(identifier)
    if mePhoneNumber then
        exports.ghmattimysql:scalar("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber", {
            ['@mePhoneNumber'] = mePhoneNumber
        })
    end
end

RegisterServerEvent('gcPhone:sendMessage')
AddEventHandler('gcPhone:sendMessage', function(phoneNumber, message)
    local src = source
    local identifier = getPlayerCitizenId(src)
    addMessage(src, identifier, phoneNumber, message)
end)

RegisterServerEvent('gcPhone:sendMessageSystem')
AddEventHandler('gcPhone:sendMessageSystem', function(phoneNumber, name, message, id)
    local src = source
    if id then src = id end
    addMessageSystem(src, phoneNumber, message, name)
end)

function addMessageSystem(source, number, message, name)
    local src = source
    local memess = _internalAddMessage(name, number,  message, 0)
    TriggerClientEvent("gcPhone:receiveMessage", src, memess)
end

RegisterServerEvent('gcPhone:deleteMessage')
AddEventHandler('gcPhone:deleteMessage', function(msgId)
    deleteMessage(msgId)
end)

RegisterServerEvent('gcPhone:deleteMessageNumber')
AddEventHandler('gcPhone:deleteMessageNumber', function(number)
    local src = source
    local citizenid = getPlayerCitizenId(src)
    deleteAllMessageFromPhoneNumber(src, citizenid, number)
end)

RegisterServerEvent('gcPhone:deleteAllMessage')
AddEventHandler('gcPhone:deleteAllMessage', function()
    local src = source
    local citizenid = getPlayerCitizenId(src)
    deleteAllMessage(citizenid)
end)

RegisterServerEvent('gcPhone:setReadMessageNumber')
AddEventHandler('gcPhone:setReadMessageNumber', function(num)
    local src = source
    local citizenid = getPlayerCitizenId(src)
    setReadMessageNumber(citizenid, num)
end)

RegisterServerEvent('gcPhone:deleteALL')
AddEventHandler('gcPhone:deleteALL', function()
    local src = source
    local citizenid = getPlayerCitizenId(src)
    deleteAllMessage(citizenid)
    deleteAllContact(citizenid)
    appelsDeleteAllHistorique(citizenid)
    TriggerClientEvent("gcPhone:contactList", src, {})
    TriggerClientEvent("gcPhone:allMessage", src, {})
    TriggerClientEvent("appelsDeleteAllHistorique", src, {})
end)

--====================================================================================
--  Gestion des appels
--====================================================================================
local AppelsEnCours = {}
local PhoneFixeInfo = {}
local lastIndexCall = 10

function getHistoriqueCall(num)
    local result = exports.ghmattimysql:executeSync("SELECT * FROM phone_calls WHERE phone_calls.owner = @num ORDER BY time DESC LIMIT 10", {
        ['@num'] = num
    })
    return result
end

function sendHistoriqueCall(src, num) 
    local histo = getHistoriqueCall(num)
    TriggerClientEvent('gcPhone:historiqueCall', src, histo)
end

function saveAppels (appelInfo)
    if appelInfo.extraData == nil or appelInfo.extraData.useNumber == nil then
        exports.ghmattimysql:execute("INSERT INTO phone_calls (`owner`, `num`,`incoming`, `accepts`) VALUES(@owner, @num, @incoming, @accepts)", {
            ['@owner'] = appelInfo.transmitter_num,
            ['@num'] = appelInfo.receiver_num,
            ['@incoming'] = 1,
            ['@accepts'] = appelInfo.is_accepts
        }, function()
            notifyNewAppelsHisto(appelInfo.transmitter_src, appelInfo.transmitter_num)
        end)
    end
    if appelInfo.is_valid == true then
        local num = appelInfo.transmitter_num
        if appelInfo.hidden == true then
            mun = "###-####"
        end
        exports.ghmattimysql:execute("INSERT INTO phone_calls (`owner`, `num`,`incoming`, `accepts`) VALUES(@owner, @num, @incoming, @accepts)", {
            ['@owner'] = appelInfo.receiver_num,
            ['@num'] = num,
            ['@incoming'] = 0,
            ['@accepts'] = appelInfo.is_accepts
        }, function()
            if appelInfo.receiver_src ~= nil then
                notifyNewAppelsHisto(appelInfo.receiver_src, appelInfo.receiver_num)
            end
        end)
    end
end

function notifyNewAppelsHisto (src, num) 
    sendHistoriqueCall(src, num)
end

RegisterServerEvent('gcPhone:getHistoriqueCall')
AddEventHandler('gcPhone:getHistoriqueCall', function()
    local src = source
    local citizenid = getPlayerCitizenId(src)
    local num = getNumberPhone(citizenid)
    if num then
        sendHistoriqueCall(src, num)
    end
end)

RegisterServerEvent('gcPhone:internal_startCall')
AddEventHandler('gcPhone:internal_startCall', function(source, phone_number, rtcOffer, extraData)
    local src = source
    if FixePhone[phone_number] ~= nil then
        onCallFixePhone(src, phone_number, rtcOffer, extraData)
        return
    end
    
    local rtcOffer = rtcOffer
    if phone_number == nil or phone_number == '' then 
        print('BAD CALL NUMBER IS NIL')
        return
    end

    local hidden = string.sub(phone_number, 1, 1) == '#'
    if hidden == true then
        phone_number = string.sub(phone_number, 2)
    end

    local indexCall = lastIndexCall
    lastIndexCall = lastIndexCall + 1

    local srcIdentifier = getPlayerCitizenId(src)

    local srcPhone = ''
    if extraData ~= nil and extraData.useNumber ~= nil then
        srcPhone = extraData.useNumber
    else
        srcPhone = getNumberPhone(srcIdentifier)
    end
    local destPlayer = otherPlayerCitizenId(phone_number)
    local is_valid = destPlayer ~= nil and destPlayer ~= srcIdentifier
    AppelsEnCours[indexCall] = {
        id = indexCall,
        transmitter_src = src,
        transmitter_num = srcPhone,
        receiver_src = nil,
        receiver_num = phone_number,
        is_valid = destPlayer ~= nil,
        is_accepts = false,
        hidden = hidden,
        rtcOffer = rtcOffer,
        extraData = extraData
    }

    if is_valid == true then
        local xTarget = QBCore.Functions.GetPlayerByCitizenId(destPlayer)
        if xTarget then
            AppelsEnCours[indexCall].receiver_src = xTarget.PlayerData.source
            TriggerClientEvent('gcPhone:waitingCall', src, AppelsEnCours[indexCall], true)
            TriggerClientEvent('gcPhone:waitingCall', xTarget.PlayerData.source, AppelsEnCours[indexCall], false) -- karşı oyuncuyu arama
            TriggerClientEvent('gcPhone:TgiannSes', -1, xTarget.PlayerData.source)
        else
            TriggerClientEvent('gcPhone:waitingCall', src, AppelsEnCours[indexCall], true)
        end
        
    else
        TriggerClientEvent('gcPhone:waitingCall', src, AppelsEnCours[indexCall], true)
    end
end)

RegisterServerEvent('gcPhone:startCall')
AddEventHandler('gcPhone:startCall', function(phone_number, rtcOffer, extraData)
    TriggerEvent('gcPhone:internal_startCall', source, phone_number, rtcOffer, extraData)
end)

RegisterServerEvent('gcPhone:candidates')
AddEventHandler('gcPhone:candidates', function (callId, candidates)
    if AppelsEnCours[callId] ~= nil then
        local src = source
        local to = AppelsEnCours[callId].transmitter_src
        if src == to then 
            to = AppelsEnCours[callId].receiver_src
        end
        TriggerClientEvent('gcPhone:candidates', to, candidates)
    end
end)

RegisterServerEvent('gcPhone:acceptCall')
AddEventHandler('gcPhone:acceptCall', function(infoCall, rtcAnswer)
    local id = infoCall.id
    if AppelsEnCours[id] ~= nil then
        if PhoneFixeInfo[id] ~= nil then
            onAcceptFixePhone(source, infoCall, rtcAnswer)
            return
        end
        AppelsEnCours[id].receiver_src = infoCall.receiver_src or AppelsEnCours[id].receiver_src
        if AppelsEnCours[id].transmitter_src ~= nil and AppelsEnCours[id].receiver_src ~= nil then
            local xPlayer = QBCore.Functions.GetPlayer(AppelsEnCours[id].transmitter_src)
            local tPlayer = QBCore.Functions.GetPlayer(AppelsEnCours[id].receiver_src)
            if tPlayer and xPlayer then
                AppelsEnCours[id].is_accepts = true
                AppelsEnCours[id].rtcAnswer = rtcAnswer
                TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].transmitter_src, AppelsEnCours[id], true)
                SetTimeout(1000, function() -- change to +1000, if necessary.
                    if AppelsEnCours[id].receiver_src ~= nil and AppelsEnCours[id] ~= nil then
                        TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].receiver_src, AppelsEnCours[id], false)
                        exports["saltychat"]:EstablishCall(AppelsEnCours[id].transmitter_src, AppelsEnCours[id].receiver_src)
                    end
                end)
                TriggerClientEvent("gcPhone:stop-call-sound", -1, AppelsEnCours[id].receiver_src)
                saveAppels(AppelsEnCours[id])
            end
        end
    end
end)

RegisterServerEvent('gcPhone:rejectCall')
AddEventHandler('gcPhone:rejectCall', function (infoCall)
    local id = infoCall.id
    if AppelsEnCours[id] ~= nil then
        if PhoneFixeInfo[id] ~= nil then
            onRejectFixePhone(source, infoCall)
            return
        end
        exports["saltychat"]:EndCall(AppelsEnCours[id].transmitter_src, AppelsEnCours[id].receiver_src)
        if AppelsEnCours[id].transmitter_src ~= nil then
            TriggerClientEvent('gcPhone:rejectCall', AppelsEnCours[id].transmitter_src)
        end
        if AppelsEnCours[id].receiver_src ~= nil then
            TriggerClientEvent('gcPhone:rejectCall', AppelsEnCours[id].receiver_src)
        end

        if AppelsEnCours[id].is_accepts == false then 
            saveAppels(AppelsEnCours[id])
        end
        TriggerClientEvent("gcPhone:stop-call-sound", -1, AppelsEnCours[id].receiver_src)
        TriggerEvent('gcPhone:removeCall', AppelsEnCours)
        AppelsEnCours[id] = nil
    end
end)

RegisterServerEvent('gcPhone:appelsDeleteHistorique')
AddEventHandler('gcPhone:appelsDeleteHistorique', function (numero)
    local src = source
    local citizenid = getPlayerCitizenId(src)
    local srcPhone = getNumberPhone(citizenid)
    if srcPhone then
        exports.ghmattimysql:scalar("DELETE FROM phone_calls WHERE `owner` = @owner AND `num` = @num", {
            ['@owner'] = srcPhone,
            ['@num'] = numero
        })
    end
end)

function appelsDeleteAllHistorique(srcIdentifier)
    local srcPhone = getNumberPhone(srcIdentifier)
    if srcPhone then
        exports.ghmattimysql:scalar("DELETE FROM phone_calls WHERE `owner` = @owner", {
            ['@owner'] = srcPhone
        })
    end
end

RegisterServerEvent('gcPhone:appelsDeleteAllHistorique')
AddEventHandler('gcPhone:appelsDeleteAllHistorique', function ()
    local src = source
    local citizenid = getPlayerCitizenId(src)
    appelsDeleteAllHistorique(citizenid)
end)

--====================================================================================
--  OnLoad
--====================================================================================
RegisterServerEvent('crew:onPlayerLoaded')
AddEventHandler('crew:onPlayerLoaded',function(source)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local citizenid = xPlayer.PlayerData.citizenid
    local myPhoneNumber = xPlayer.PlayerData.metadata.number
    
    TriggerClientEvent("crew:updatePhone", src, myPhoneNumber, getContacts(citizenid), getMessages(citizenid))
    sendHistoriqueCall(src, myPhoneNumber)
  
    getUserTwitterAccount(src)
end)

RegisterCommand('telfix', function(source)
    TriggerEvent('crew:onPlayerLoaded', source) 
end)

--====================================================================================
--  App 
--====================================================================================
function onCallFixePhone (source, phone_number, rtcOffer, extraData)
    local indexCall = lastIndexCall
    lastIndexCall = lastIndexCall + 1

    local hidden = string.sub(phone_number, 1, 1) == '#'
    if hidden == true then
        phone_number = string.sub(phone_number, 2)
    end
    local src = source
    local citizenid = getPlayerCitizenId(source)

    local srcPhone = ''
    if extraData ~= nil and extraData.useNumber ~= nil then
        srcPhone = extraData.useNumber
    else
        srcPhone = getNumberPhone(citizenid)
    end

    AppelsEnCours[indexCall] = {
        id = indexCall,
        transmitter_src = src,
        transmitter_num = srcPhone,
        receiver_src = nil,
        receiver_num = phone_number,
        is_valid = false,
        is_accepts = false,
        hidden = hidden,
        rtcOffer = rtcOffer,
        extraData = extraData,
        coords = FixePhone[phone_number].coords
    }
    
    PhoneFixeInfo[indexCall] = AppelsEnCours[indexCall]

    TriggerClientEvent('gcPhone:notifyFixePhoneChange', -1, PhoneFixeInfo)
    TriggerClientEvent('gcPhone:waitingCall', src, AppelsEnCours[indexCall], true)
end

function onAcceptFixePhone(source, infoCall, rtcAnswer)
    local id = infoCall.id
    
    AppelsEnCours[id].receiver_src = source
    if AppelsEnCours[id].transmitter_src ~= nil and AppelsEnCours[id].receiver_src ~= nil then
        AppelsEnCours[id].is_accepts = true
        AppelsEnCours[id].forceSaveAfter = true
        AppelsEnCours[id].rtcAnswer = rtcAnswer
        PhoneFixeInfo[id] = nil
        TriggerClientEvent('gcPhone:notifyFixePhoneChange', -1, PhoneFixeInfo)
        TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].transmitter_src, AppelsEnCours[id], true)
	    SetTimeout(1000, function() -- change to +1000, if necessary.
       		TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].receiver_src, AppelsEnCours[id], false)
	    end)
        saveAppels(AppelsEnCours[id])
    end
end

function onRejectFixePhone(source, infoCall, rtcAnswer)
    local id = infoCall.id
    PhoneFixeInfo[id] = nil
    TriggerClientEvent('gcPhone:notifyFixePhoneChange', -1, PhoneFixeInfo)
    TriggerClientEvent('gcPhone:rejectCall', AppelsEnCours[id].transmitter_src)
    if AppelsEnCours[id].is_accepts == false then
        saveAppels(AppelsEnCours[id])
    end
    AppelsEnCours[id] = nil
end