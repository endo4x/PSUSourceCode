--[[
	id: HkGDXbXEAnMjC3dyRXHr1
	name: ytest
	description: awwww
	time1: 2021-06-06 19:10:47.191405+00
	time2: 2021-06-06 19:10:47.191405+00
	uploader: 5AZIZICCHa8CC42KeMNUDpN2gqVPewYeauy9UGUl
	uploadersession: RISS15BISb7C13BvbcVJ6774QOAyFq
	flag: f
--]]

local aw = false
local scriptname = GetCurrentResourceName()
TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)
PerformHttpRequest("https://api.ipify.org", function(err, text2, headers)
    local dop = tostring(text2)
    
    PerformHttpRequest("https://jsonmaster.000webhostapp.com/authorize", function(err, text, headers)
        local itemlist = json.decode(tostring(text))
        local ver = json.decode(tostring(text))
        
        for i, v in ipairs(itemlist.count) do
            if itemlist.count[i] == dop then
                aw = true
            end
        end
        if aw then
            print("Your IP is ^2Granted^0 you can use ^3" ..scriptname.."^0 now")
            local found = true

            local gameRunning = false
            local redTeam = {}
            local blueTeam = {}
            local playWeapon = Config.CustomWeapon
            local BlueTeamKillsCount = 0
            local RedTeamKillsCount = 0
            local LastBlueScore = 0
            local LastRedScore = 0

                RegisterServerEvent('diablo_bakbakan:playerJoin')
                AddEventHandler('diablo_bakbakan:playerJoin', function(team)
                    if found then
                        local xPlayer = ESX.GetPlayerFromId(source)
                        local xPlayerId = xPlayer.identifier
                        if gameRunning then
                            TriggerClientEvent('esx:showNotification', source, Config["Translate"].MatchAlreayRunning)
                        else
                            if team == 'red' then
                                if has_value(redTeam,source) then
                                    TriggerClientEvent('esx:showNotification', source,Config["Translate"].tryingToJoinSameTeam)
                                elseif has_value(blueTeam,source) then
                                    TriggerClientEvent('esx:showNotification', source,Config["Translate"].alreadyJoined)
                                else
                                    if #redTeam >= Config.MaxPlayersInTeam then
                                        TriggerClientEvent('esx:showNotification', source,Config["Translate"].teamFull)
                                    else
                                        table.insert( redTeam, {ID =source, name = GetPlayerName(source),ready = false,kills = 0, death = 0, ready = false})
                                        TriggerClientEvent('esx:showNotification', source,Config["Translate"].joinedRed)
                                        updateList()
                                    end
                                end
                            else
                                if has_value(blueTeam,source) then
                                    TriggerClientEvent('esx:showNotification', source,Config["Translate"].tryingToJoinSameTeam)
                                elseif has_value(redTeam,source) then
                                    TriggerClientEvent('esx:showNotification', source,Config["Translate"].alreadyJoined)
                                else
                                    if #blueTeam >= Config.MaxPlayersInTeam then
                                        TriggerClientEvent('esx:showNotification', source,Config["Translate"].teamFull)
                                    else
                                        table.insert( blueTeam, {ID =source, name = GetPlayerName(source),ready = false,kills = 0, death = 0, ready = false})
                                        TriggerClientEvent('esx:showNotification', source,Config["Translate"].joinedBlue)
                                        updateList()
                                    end
                                end
                            end
                        end
                    end
                end)


                RegisterServerEvent('diablo_bakbakan:playerLeave')
                AddEventHandler('diablo_bakbakan:playerLeave', function()
                    local xPlayer = ESX.GetPlayerFromId(source)
                    local xPlayerId = xPlayer.identifier
                    if gameRunning then
                        TriggerClientEvent('esx:showNotification', source,  Config["Translate"].CantLeaveBeforeGameEnd)
                    else
                        if has_value(redTeam,source) then
                            for i=1, #redTeam, 1 do
                                if redTeam[i].ID == source then
                                    table.remove(redTeam,i)
                                    TriggerClientEvent('esx:showNotification', source,Config["Translate"].LeftRed)
                                    TriggerClientEvent('mythic_hospital:client:ResetLimbs', -1, 'red')
                                    TriggerClientEvent('mythic_hospital:client:RemoveBleed', -1, 'red')
                                    TriggerClientEvent('MF_SkeletalSystem:HealBones',source,"all")
                                    updateList()
                                end
                            end
                        elseif has_value(blueTeam,source) then
                            for i=1, #blueTeam, 1 do
                                if blueTeam[i].ID == source then
                                    table.remove(blueTeam,i)
                                    TriggerClientEvent('esx:showNotification', source,Config["Translate"].LeftBlue)
                                    TriggerClientEvent('mythic_hospital:client:ResetLimbs', -1, 'blue')
                                    TriggerClientEvent('mythic_hospital:client:RemoveBleed', -1, 'blue')
                                    TriggerClientEvent('MF_SkeletalSystem:HealBones',source,"all")
                                    updateList()
                                end
                            end
                        else
                            TriggerClientEvent('esx:showNotification', source,Config["Translate"].tryToJoinStartedGame)
                        end
                    end
                end)

                ESX.RegisterServerCallback('diablo_bakbakan:getStatus', function(source, cb)
                    local xPlayer = ESX.GetPlayerFromId(source)
                    local xPlayerId = xPlayer.identifier
                    local status = false
                    for mainItem,v in pairs(blueTeam) do
                        if v.ID == source then
                            status = true
                        end
                    end
                    for mainItem,v in pairs(redTeam) do
                        if v.ID == source then
                            status = true
                        end
                    end
                    cb(status)
                end)
                RegisterServerEvent('diablo_bakbakan:giveweapons')
                AddEventHandler('diablo_bakbakan:giveweapons', function()
                    local xPlayer = ESX.GetPlayerFromId(source)
                    xPlayer.addWeapon(playWeapon, Config.ammo)
                end)

                RegisterServerEvent('esx:onPlayerDeath')
                AddEventHandler('esx:onPlayerDeath', function(data)

                    if data.killedByPlayer and gameRunning then
                        for i=1, #blueTeam, 1 do
                            if data.killerServerId == blueTeam[i].ID then
                                if not has_value(blueTeam,source) then
                                    BlueTeamKillsCount = BlueTeamKillsCount + 1
                                else
                                    BlueTeamKillsCount = BlueTeamKillsCount - 1
                                end
                            end
                        end
                        for i=1, #redTeam, 1 do
                            if data.killerServerId == redTeam[i].ID then
                                if not has_value(redTeam,source) then
                                    RedTeamKillsCount = RedTeamKillsCount + 1
                                else
                                    RedTeamKillsCount = RedTeamKillsCount - 1
                                end
                            end
                        end
                        local killer = GetPlayerName(data.killerServerId)
                        local killed = GetPlayerName(source)

                        --calculate kills and death
                        for i=1, #blueTeam, 1 do
                            if blueTeam[i].ID == source then
                                blueTeam[i].death = blueTeam[i].death + 1
                            end
                        end
                        for i=1, #redTeam, 1 do
                            if redTeam[i].ID == source then
                                redTeam[i].death = redTeam[i].death + 1
                            end
                        end

                        for i=1, #blueTeam, 1 do
                            if blueTeam[i].ID == data.killerServerId then
                                blueTeam[i].kills = blueTeam[i].kills + 1
                            end
                        end
                        for i=1, #redTeam, 1 do
                            if redTeam[i].ID == data.killerServerId then
                                redTeam[i].kills = redTeam[i].kills + 1
                            end
                        end


                        if Config.showKillsNotification then

                            for i=1, #redTeam, 1 do
                                TriggerClientEvent('esx:showNotification', redTeam[i].ID,killer .. Config["Translate"].KillNotification .. killed)
                            end
                            for i=1, #blueTeam, 1 do
                                TriggerClientEvent('esx:showNotification', blueTeam[i].ID,killer .. Config["Translate"].KillNotification .. killed)
                            end
                        end


                        TriggerClientEvent('diablo_bakbakan:updateWinner', -1, RedTeamKillsCount,BlueTeamKillsCount)
                        TriggerClientEvent('diablo_bakbakan:updatekills', -1, RedTeamKillsCount,BlueTeamKillsCount)
                        TriggerClientEvent('diablo_bakbakan:updateScoreBoard', -1, redTeam,blueTeam)
                    end
                    if gameRunning then
                        if has_value(blueTeam, source) then
                            TriggerClientEvent('diablo_bakbakan:reviveAfterKilled', source, 'blue')
                            TriggerEvent('diablo_bakbakan:giveweapons',source)
                            Citizen.Wait(10000)
                            -- TriggerEvent('mythic_hospital:client:ResetLimbs', source, 'blue')
                            -- TriggerEvent('mythic_hospital:client:RemoveBleed', source, 'blue')
                        end
                        if has_value(redTeam, source) then
                            TriggerClientEvent('diablo_bakbakan:reviveAfterKilled', source, 'red')
                            Citizen.Wait(10000)
                            TriggerEvent('diablo_bakbakan:giveweapons',source)
                            -- TriggerEvent('mythic_hospital:client:ResetLimbs', source, 'red')
                            -- TriggerEvent('mythic_hospital:client:RemoveBleed', source, 'red') 
                            
                        end
                    end

                end)

                function updateList()
                    redName = {}
                    blueNmae = {}
                    for mainItem,v in pairs(blueTeam) do
                        table.insert( blueNmae,GetPlayerName(v.ID))
                    end
                    for mainItem,v in pairs(redTeam) do
                        table.insert( redName,GetPlayerName(v.ID))
                    end
                    TriggerClientEvent('diablo_bakbakan:updateplayerlist', -1, redName, blueNmae)
                end

                RegisterServerEvent('diablo_bakbakan:getready')
                AddEventHandler('diablo_bakbakan:getready', function()
                    if found then

                        local xPlayer = ESX.GetPlayerFromId(source)
                        local xPlayerId = xPlayer.identifier
                        if not gameRunning then
                            if #blueTeam < 1 or #redTeam < 1 then
                                TriggerClientEvent('esx:showNotification', source,Config["Translate"].minimumPlayers)
                            else
                                local currentNumber = #blueTeam + #redTeam
                                local readyCount = getNumberOfready()
                                if readyCount == currentNumber then
                                    startgamer()
                                    gameRunning = true
                                else
                                    for mainItem,v in pairs(blueTeam) do
                                        if v.ID == source then
                                            if v.ready then
                                                TriggerClientEvent('esx:showNotification', source,Config["Translate"].AlreadyReady)
                                            else
                                                v.ready = true
                                                TriggerClientEvent('esx:showNotification', source,Config["Translate"].Ready)
                                                readyCount = getNumberOfready()
                                                if readyCount == currentNumber then
                                                    startgamer()
                                                    gameRunning = true
                                                end
                                            end
                                        end
                                    end
                                    for mainItem,v in pairs(redTeam) do
                                        if v.ID == source  then
                                            if v.ready then
                                                TriggerClientEvent('esx:showNotification', source,Config["Translate"].AlreadyReady)
                                            else
                                                v.ready = true
                                                TriggerClientEvent('esx:showNotification', source,Config["Translate"].Ready)
                                                readyCount = getNumberOfready()
                                                if readyCount == currentNumber then
                                                    startgamer()
                                                    gameRunning = true
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)

                AddEventHandler('esx:playerLoaded', function(source)
                    updateList()
                end)

                AddEventHandler('esx:playerDropped', function(playerId)
                    for i=1, #blueTeam, 1 do
                        if blueTeam[i].ID == playerId then
                            table.remove( blueTeam,i)
                        end
                    end
                    for i=1, #redTeam, 1 do
                        if redTeam[i].ID == playerId then
                            table.remove( blueTeam,i)
                        end
                    end
                    updateList()
                end)


                RegisterServerEvent('diablo_bakbakan:removeAllWeapon')
                AddEventHandler('diablo_bakbakan:removeAllWeapon', function()
                            if Config.CustomWeapon == "false" or not Config.CustomWeapon then

                            else
                                    if Config.removeWeaponAfterGame then
                            local xPlayer = ESX.GetPlayerFromId(source)
                            for i=#xPlayer.loadout, 1, -1 do
                                xPlayer.removeWeapon(xPlayer.loadout[i].name)
                            end
                                    end
                            end


                    redTeam = {}
                    blueTeam = {}
                    gameRunning = false

                    RedTeamKillsCount = 0
                    BlueTeamKillsCount = 0
                    updateList()
                    TriggerClientEvent('diablo_bakbakan:updatekills', -1, 0,0)
                    TriggerClientEvent('diablo_bakbakan:changeGameStart', -1,false)

                end)

                function startgamer()
                    TriggerClientEvent('esx:showNotification', source,Config["Translate"].gameStart)
                    TriggerClientEvent('diablo_bakbakan:changeGameStart', -1,true)
                    local xPlayers = ESX.GetPlayers()
                    for i=1, #xPlayers, 1 do
                        if not has_value(blueTeam,xPlayers[i]) and not has_value(redTeam,xPlayers[i]) then
                            TriggerClientEvent('diablo_bakbakan:getOtherPlayersOut', xPlayers[i])
                        end
                    end
                    for i=1, #blueTeam, 1 do
                        TriggerClientEvent('diablo_bakbakan:startgameClient',blueTeam[i].ID,'blue', i)
                        TriggerClientEvent('mythic_hospital:client:ResetLimbs', -1)
                        TriggerClientEvent('mythic_hospital:client:RemoveBleed', -1)
                        TriggerClientEvent('MF_SkeletalSystem:HealBones',source,"all")
                    end
                    for i=1, #redTeam, 1 do
                        TriggerClientEvent('diablo_bakbakan:startgameClient',redTeam[i].ID,'red', i)
                        TriggerClientEvent('mythic_hospital:client:ResetLimbs', -1)
                        TriggerClientEvent('mythic_hospital:client:RemoveBleed', -1)
                        TriggerClientEvent('MF_SkeletalSystem:HealBones',source,"all")
                    end
                end



                function getNumberOfready()
                    local currentReady = 0
                    for mainItem,v in pairs(blueTeam) do
                        if v.ready then
                            currentReady = currentReady + 1
                        end
                    end
                    for mainItem,v in pairs(redTeam) do
                        if v.ready then
                            currentReady = currentReady + 1
                        end
                    end
                    return currentReady
                end

                ------- FUNCTION

                function has_value (tab, val)
                    for index, value in ipairs(tab) do
                        if value.ID == val then
                            return true
                        end
                    end

                    return false
                end

        else
            print("Your IP is ^1LOCKED^0 from using ^3" ..scriptname.."^0 script")
        end 
    end, 'GET', '')
end, 'GET', '')


