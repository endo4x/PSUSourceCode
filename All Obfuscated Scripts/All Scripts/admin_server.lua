--[[
	id: jpxcTjW_uRfuyNUMcyj-c
	name: admin_server
	description: admin_server
	time1: 2021-07-19 01:02:20.299855+00
	time2: 2021-07-19 01:02:20.299856+00
	uploader: jwSAFiyGDZZngdEUyC9KXjXc3kZsqwbIcIgS4G-8
	uploadersession: nL5L49evOF_jJlNEUrxixZuZeT-pDw
	flag: f
--]]

ESX = nil
local itemList, jobList = {}, {}
SolarAdmin = {}
TriggerEvent('esx:getShilovepizzaaredObjilovepizzaect', function(obj) 
    ESX = obj 
end)

AddEventHandler('onResourceStart', function()
    MySQL.ready(function ()
        MySQL.Async.fetchAll('SELECT name, label FROM items',{}, function(result)
            itemList = result
        end)

        MySQL.Async.fetchAll('SELECT * FROM jobs ORDER BY name <>  "unemployed", name',{}, function(result)
            for i=1, #result, 1 do
                MySQL.Async.fetchAll('SELECT grade, label FROM job_grades WHERE job_name = @job',{["@job"] = result[i].name}, function(result2)
                    table.insert(jobList, {name = result[i].name, label = result[i].label, ranks = result2})
                end)
            end
        end)
    end)
end)


--[Fetch User Rank CallBack]
ESX.RegisterServerCallback("esx_marker:fetchUserRank", function(source, cb)
    local player = ESX.GetPlayerFromId(source)

    if player then
        local playerGroup = player.getGroup()

        if playerGroup then 
            cb(playerGroup)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)

ESX.RegisterServerCallback("SolarAdmin:getPlayers", function(source,cb)
    local data = {}
    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        data[i] = {
            identifier = xPlayer.getIdentifier(),
            playerid = xPlayers[i],
            group = xPlayer.getGroup(),
    	    rpname = xPlayer.getName(),
    	    cash = xPlayer.getMoney(), 
            bank = xPlayer.getAccount("bank").money,
    	    name = GetPlayerName(xPlayers[i])
        }
    end

    cb(data)
end)

ESX.RegisterServerCallback("SolarAdmin:getItemList", function(source,cb)
    cb(itemList)
 end)

ESX.RegisterServerCallback("SolarAdmin:getJobs", function(source,cb)
    cb(jobList)
 end)

SolarAdmin.Kick = function(playerID, reason)
    DropPlayer(playerID, reason)
end


SolarAdmin.AddWeapon = function(playerID, selectedWeapon, ammo)
    xPlayer = ESX.GetPlayerFromId(playerID)
    if xPlayer.hasWeapon(selectedWeapon) then
        xPlayer.addWeaponAmmo(selectedWeapon, 50)
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Added Ammo to your weapon') 
    else
        xPlayer.addWeapon(selectedWeapon, ammo)
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'You have been given a '..ESX.GetWeaponLabel(selectedWeapon)) 
    end
end

SolarAdmin.AddCash = function(playerID, amount)
    xPlayer = ESX.GetPlayerFromId(playerID)
    xPlayer.addMoney(amount)
end

SolarAdmin.AddBank = function(playerID, amount)
    xPlayer = ESX.GetPlayerFromId(playerID)
    xPlayer.addAccountMoney("bank", amount)
end

SolarAdmin.AddItem = function(playerID, selectedItem, amount)
    local xPlayer = ESX.GetPlayerFromId(playerID)
    xPlayer.addInventoryItem(selectedItem, amount)
end

SolarAdmin.Teleport = function(targetId, action)
    local xPlayer, xTarget, sourceMessage, targetMessage
    if source ~= 0 then
        if action == "bring" then
            sourceMessage = "Du hast einen Spieler zu dir gebracht"
            targetMessage = "Du wurdest von einem Team Mitglied gebracht"
            xPlayer = ESX.GetPlayerFromId(source)
            xTarget = ESX.GetPlayerFromId(targetId)
        elseif action == "goto" then
            targetMessage = "Du hast dich zu einem Spieler teleportiert"
            xPlayer = ESX.GetPlayerFromId(targetId)
            xTarget = ESX.GetPlayerFromId(source)
        end


        if xTarget then
            local targetCoords = xTarget.getCoords()
            local playerCoords = xPlayer.getCoords()
            xTarget.setCoords(playerCoords)
            if sourceMessage then
                TriggerClientEvent('esx:showNotification', xPlayer.source, sourceMessage)
            end
            TriggerClientEvent('esx:showNotification', xTarget.source, targetMessage)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Der Spieler ist nicht online')        
        end
    end
end

RegisterNetEvent("SolarAdmin:GiveWeapon")
AddEventHandler("SolarAdmin:GiveWeapon", function(playerID, weapon)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanGiveWeapon then
        SolarAdmin.AddWeapon(playerID, weapon, 10)
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'You gave '..GetPlayerName(playerID)..' a '..ESX.GetWeaponLabel(weapon)) 
    else
       SolarAdmin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("SolarAdmin:AddItem")
AddEventHandler("SolarAdmin:AddItem", function(playerID, selectedItem, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanGiveItem then
        SolarAdmin.AddItem(playerID, selectedItem, amount)
        TriggerClientEvent('esx:showNotification', source, "Gave "..selectedItem.." to "..GetPlayerName(playerID))
    else
       SolarAdmin.Error(source, "noPerms")
    end
end)


RegisterNetEvent("SolarAdmin:AddCash")
AddEventHandler("SolarAdmin:AddCash", function (playerID, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanAddCash then
        SolarAdmin.AddCash(playerID, amount)
        TriggerClientEvent('esx:showNotification', source, "Gebe $"..amount.." Bargeld zu dem Spieler "..GetPlayerName(playerID))
    else
       SolarAdmin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("SolarAdmin:AddBank")
AddEventHandler("SolarAdmin:AddBank", function (playerID, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanAddBank then
        SolarAdmin.AddBank(playerID, amount)
        TriggerClientEvent('esx:showNotification', source, "$"..amount.." wurde auf das Bankkonto von "..GetPlayerName(playerID).."'s übertragen")
    else
       SolarAdmin.Error(source, "noPerms")
    end
end)

RegisterNetEvent('SolarAdmin:Kick')
AddEventHandler('SolarAdmin:Kick', function(playerId, reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanKick then
        SolarAdmin.Kick(playerId, reason)
        TriggerClientEvent('esx:showNotification', source, "Kicked "..GetPlayerName(playerId))
    else
       SolarAdmin.Error(source, "noPerms")
    end
end)

RegisterNetEvent('SolarAdmin:Ban')
AddEventHandler('SolarAdmin:Ban', function(playerId, time, reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and (Config.Perms[playerGroup].CanBanTemp and time ~= 0) or (Config.Perms[playerGroup].CanBanPerm and time == 0) then
        SolarAdmin.Ban(playerId, time, reason)
        TriggerClientEvent('esx:showNotification', source, "Banned "..GetPlayerName(playerId))
    else
       SolarAdmin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("SolarAdmin:Promote")
AddEventHandler("SolarAdmin:Promote", function (playerID, group)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    local targetPlayer = ESX.GetPlayerFromId(playerID)
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanPromote then
        if group ~= "superadmin" or playerGroup == "superadmin" then
            targetPlayer.setGroup(group)
            TriggerClientEvent('esx:showNotification', source, "Gruppe von "..GetPlayerName(playerID).." wurde zu "..group.. " geändert")
        end
    else
       SolarAdmin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("SolarAdmin:Announcement")
AddEventHandler("SolarAdmin:Announcement", function (message)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanAnnounce then
        --TriggerClientEvent('chat:addMessage', -1, {color = { 255, 0, 0}, args = {"SERVER-BENACHRICHTIGUNG ", message}})
        TriggerClientEvent('SolarAdmin:Announcement', -1, message)
    else
       SolarAdmin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("SolarAdmin:Notification")
AddEventHandler("SolarAdmin:Notification", function (playerID, message)
    local _source = playerID
    TriggerClientEvent('chat:addMessage', _source, {args = {"ChapterV ", message}})
end)

RegisterNetEvent("SolarAdmin:Teleport")
AddEventHandler("SolarAdmin:Teleport", function (targetId, action)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanTeleport then
        SolarAdmin.Teleport(targetId, action)
    else
       SolarAdmin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("SolarAdmin:Slay")
AddEventHandler("SolarAdmin:Slay", function (target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanSlay then
        TriggerClientEvent('SolarAdmin:Slay', target)
        TriggerClientEvent('esx:showNotification', source, "Du hast den Spieler "..GetPlayerName(target).." umgebracht")
        TriggerClientEvent('esx:showNotification', target, "Du wurdest von einem Admin umbebracht")
    else
       SolarAdmin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("SolarAdmin:God")
AddEventHandler("SolarAdmin:God", function (target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanGodmode then
        TriggerClientEvent('SolarAdmin:God', target)
        TriggerClientEvent('esx:showNotification', source, "You enabled/disabled Godmode for "..GetPlayerName(target))
    else
       SolarAdmin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("SolarAdmin:Freeze")
AddEventHandler("SolarAdmin:Freeze", function (target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanFreeze then
        TriggerClientEvent('SolarAdmin:Freeze', target)
        TriggerClientEvent('esx:showNotification', source, "Du hast den Spieler "..GetPlayerName(target).." gefreezt/ungefreezt")
    else
       SolarAdmin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("SolarAdmin:Unban")
AddEventHandler("SolarAdmin:Unban", function(license)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanUnban then
        SolarAdmin.Unban(license)
        TriggerClientEvent('esx:showNotification', source, "Unbanned Player. ("..license..")")
    else
       SolarAdmin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("SolarAdmin:setJob")
AddEventHandler("SolarAdmin:setJob", function(target, job, rank)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(target)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanSetJob then
        targetPlayer.setJob(job, rank)
        TriggerClientEvent('esx:showNotification', source, "Changed "..GetPlayerName(target).." job to "..job)
        TriggerClientEvent('esx:showNotification', target, "Your job was changed to "..job)
    else
       SolarAdmin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("SolarAdmin:revive")
AddEventHandler("SolarAdmin:revive", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(target)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanRevive then
        targetPlayer.triggerEvent('esx_ambulancejob:revive')
        TriggerClientEvent('esx:showNotification', source, "Du hast den Spieler "..GetPlayerName(target).." revivet")
        TriggerClientEvent('esx:showNotification', target, "You have been revived by an admin")
    else
       SolarAdmin.Error(source, "noPerms")
    end
end)

SolarAdmin.Error = function(source, message)
    if message == "noPerms" then
        TriggerClientEvent('chat:addMessage', source, {args = {"ChapterV ", " Du hast keine Berechtigung"}})
    else
        TriggerClientEvent('chat:addMessage', source, {args = {"ChapterV ", message}})
    end
end

function split(s, delimiter)
    result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end