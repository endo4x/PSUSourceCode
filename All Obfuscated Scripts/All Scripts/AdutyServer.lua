--[[
	id: 78uE4EJSLh1jOznEUmEnW
	name: Aduty Server
	description: s
	time1: 2021-07-03 22:50:07.20106+00
	time2: 2021-07-03 22:50:07.201066+00
	uploader: endILJ7HNjVIZCz1DajtBSeklWVeOgx1J3h9pS6d
	uploadersession: pPgYfyAQ9sdYSqaqndOnhd6Gu11Uxe
	flag: f
--]]

local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj  end)

local savedCoords   = {}

ESX.RegisterServerCallback("Admin:getRankFromPlayer", function(source, cb)
    local player = ESX.GetPlayerFromId(source)

    if player ~= nil then
        local playerGroup = player.getGroup()

        if playerGroup ~= nil then 
            cb(playerGroup)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)

function sendToDiscord(color, name, title, message, footer)
	local embed = {
		  {
			  ["color"] = color,
			  ["title"] = "**".. title .."**",
			  ["description"] = message,
			  ["footer"] = {
				  ["text"] = footer,
			  },
		  }
	  }  
	PerformHttpRequest('https://canary.discord.com/api/webhooks/848298307487137822/RHHF4JHAmqEOV5IYEsy3OEq_0U0QHenn1LlisHsGUngLSjPCewWbN3HApsNFxQZztXKV', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('bringplayertome')
AddEventHandler('bringplayertome', function(target,x,y,z)
    TriggerClientEvent('teleport', target, x, y, z)
end)


RegisterServerEvent('reloadchar')
AddEventHandler('reloadchar', function(target)
    TriggerClientEvent('rw:setplayerinclouds', target)
    Wait(500)
    TriggerClientEvent('rw:endjoinsession', target)
end)

local ticketData = {}

RegisterServerEvent('rw:closeTicket')
AddEventHandler('rw:closeTicket', function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("notify", ticketData[id]["id"], 3, "TICKETSYSTEM", "Dein Ticket wurde von dem " .. xPlayer.getGroup(source) .. " " .. GetPlayerName(source) .. " geschlossen.", 2500)
    TriggerClientEvent("notify", source, 3, "TICKETSYSTEM", "Du hast das Ticket geschlossen.", 2500)
    ticketData[id] = nil
end)

TriggerEvent("notify", 3, "TICKETSYSTEM","Du hast ein Ticket abgesendet.", 2500)

RegisterServerEvent('rw:revive')
AddEventHandler('rw:revive', function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("notify", ticketData[id]["id"], 3, "TICKETSYSTEM", "der " .. xPlayer.getGroup(source) .. " " .. GetPlayerName(source) .. " hat dich durch dein Ticket wiederbelebt!", 2500)
    TriggerClientEvent('esx_ambulancejob:revive', tonumber(ticketData[id]["id"]))
    TriggerClientEvent("notify", source, 3, "TICKETSYSTEM", " Spieler wiederbelebt!", 2500)
end)

RegisterServerEvent('adminspawnned')
AddEventHandler('adminspawnned', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("notify", source, 3, "ADMINISTRATION", "Deine Rechte wurden erfolgreich inizialisiert! dein Rang:" .. xPlayer.getGroup(source), 3000)
end)



RegisterCommand("supportcancel", function(source, args)
    TriggerClientEvent("notify", source, 3, "TICKETSYSTEM", "Du hast dein Ticket geschlossen.", 2500)
    for k, v in pairs(ticketData) do
        if k ~= nil then
            if ticketData[k]["id"] == source then
                ticketData[k] = nil
            end
        end
    end
end, false)

RegisterServerEvent('rw:loadSupportAPP')
AddEventHandler('rw:loadSupportAPP', function()
    for k, v in pairs(ticketData) do
        if k ~= nil then
            TriggerClientEvent('rw:addTicket', source, ticketData[k]["name"], ticketData[k]["id"], ticketData[k]["msg"], tostring(k))
        end
    end
end)

RegisterCommand("resetjob", function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "Projektleiter" or xPlayer.getGroup() == "Teamvertrauter" or xPlayer.getGroup() == "Manager" or xPlayer.getGroup() == "Superadmin" or xPlayer.getGroup() == "Admin" or xPlayer.getGroup() == "Moderator" or xPlayer.getGroup() == "Supporter" or xPlayer.getGroup() == "Guide" then
        if(source > 0)then
            --Player
     
            if(#args == 1) then
                local xPlayer = ESX.GetPlayerFromId(args[1])
                --TriggerClientEvent('notifications', source, "#1df5fc", "ADMINISTRATION", "Job erfolgreich zurückgesetzt!")
                TriggerClientEvent("notify", source, 4, "ADMINISTRATION", "Job erfolgreich zurückgesetzt!", 2500)
                --TriggerClientEvent('notifications', args[1], "#1df5fc", "ADMINISTRATION", "dein Job wurde von dem " .. xPlayer.getGroup(source) .. " " .. GetPlayerName(source) .. " zurückgesetzt!")
                TriggerClientEvent("notify",  args[1], 4, "ADMINISTRATION", "dein Job wurde von dem " .. xPlayer.getGroup(source) .. " " .. GetPlayerName(source) .. " zurückgesetzt!", 2500)
                xPlayer.setJob('unemployed', 0)
    else
        local xPlayer = ESX.GetPlayerFromId(source)
        --TriggerClientEvent('notifications', source, "#1df5fc", "ADMINISTRATION", "deine Job wurde erfolgreich zurückgesetzt!!")
        TriggerClientEvent("notify", source, 4, "ADMINISTRATION", "deine Job wurde erfolgreich zurückgesetzt!!", 2500)
        xPlayer.setJob('unemployed', 0)
    end
        else
            TriggerClientEvent('notifications', source, "#1df5fc", "Admin-DV", "dazu hast du keine Rechte.")
        end
    end
    end, false)



RegisterServerEvent('sendticket')
AddEventHandler('sendticket', function(msg)
    ticketData[math.random(100,999)] = {["msg"] = msg, ["name"] = GetPlayerName(source), ["id"] = source}
    TriggerClientEvent('Adminnotify', -1, msg, GetPlayerName(source) .. " | ID: " .. source)
    sendToDiscord("12745742", "Ticketsystem", GetPlayerName(source) .." | ID: ".. source .."", "\n**Grund:** "..msg, "Ticketsystem v1.0 by NEXUS")
    TriggerClientEvent('rw:addTicket', -1, GetPlayerName(source), source, msg, "/")
end)

RegisterCommand("skin", function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "Projektleiter" or xPlayer.getGroup() == "Teamvertrauter" or xPlayer.getGroup() == "Manager" or xPlayer.getGroup() == "Superadmin" or xPlayer.getGroup() == "Admin" or xPlayer.getGroup() == "Moderator" or xPlayer.getGroup() == "Supporter" or xPlayer.getGroup() == "Guide" then
        if(source > 0)then
            --Player
     
            if(#args == 1) then
        TriggerClientEvent('esx_skin:openSaveableMenu', args[1])
    else
        TriggerClientEvent('esx_skin:openSaveableMenu', source)
    end
        else
            --TriggerClientEvent('notifications', source, "#1df5fc", "Admin-DV", "dazu hast du keine Rechte.")
            TriggerClientEvent("notify", source, 4, "ADMINISTRATION", "dazu hast du keine Rechte.", 2500)
        end
    end
    end, false)


RegisterServerEvent('tc')
AddEventHandler('tc', function(msg)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('Adminnotify2', -1, msg, xPlayer.getGroup(source) .. " " .. GetPlayerName(source) .. "")
end)








ESX.RegisterServerCallback('rw:getGroup', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.getGroup())
end)


RegisterCommand("car", function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == "Projektleiter" or xPlayer.getGroup() == "Teamvertrauter" or xPlayer.getGroup() == "Manager" or xPlayer.getGroup() == "Superadmin" or xPlayer.getGroup() == "Admin" then
        if(source > 0)then
            --Player
     
            if(#args == 1) then
       -- TriggerClientEvent('notifications', source, "#1df5fc", "AdminISTRATION", "du hast das Fahrzeug " .. args[1] .. " erfolgreich gespawnt")
        TriggerClientEvent("notify", source, 4, "ADMINISTRATION","du hast das Fahrzeug " .. args[1] .. " erfolgreich gespawnt", 2500)
        sendToDiscord("12745742", "Ticketsystem", "FAHRZEUG SPAWN", GetPlayerName(source) .. " hat sich das Fahrzeug " .. args[1] .. " gespawnt!", "Ticketsystem v1.0 by NEXUS")
        TriggerClientEvent('esx:spawnVehicle', source, args[1])
		else
			--TriggerClientEvent('notifications', source, "#1df5fc", "Admin-SPAWN", "Ungültiges Fahrzeug")
            TriggerClientEvent("notify", source, 4, "ADMINISTRATION","Ungültiges Fahrzeug", 2500)
        end
    else
        TriggerClientEvent("notify", source, 4, "ADMINISTRATION", "dazu hast du keine Rechte.", 2500)
    end
 end
	end, false)

    RegisterCommand("dv", function(source, args, user)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getGroup() == "Projektleiter" or xPlayer.getGroup() == "Teamvertrauter" or xPlayer.getGroup() == "Manager" or xPlayer.getGroup() == "Superadmin" or xPlayer.getGroup() == "Admin" or xPlayer.getGroup() == "Moderator" or xPlayer.getGroup() == "Supporter" then
            TriggerClientEvent("notify", source, 4, "ADMINISTRATION", "Fahrzeug entfernt!", 2500)
            TriggerClientEvent('esx:deleteVehicle', source, args[1])
            else
                TriggerClientEvent("notify", source, 4, "ADMINISTRATION", "dazu hast du keine Rechte.", 2500)
            end
        end, false)

        RegisterCommand("revive", function(source, args, user)
            local xPlayer = ESX.GetPlayerFromId(source)
            if xPlayer.getGroup() == "Projektleiter" or xPlayer.getGroup() == "Teamvertrauter" or xPlayer.getGroup() == "Manager" or xPlayer.getGroup() == "Superadmin" or xPlayer.getGroup() == "Admin" or xPlayer.getGroup() == "Moderator" or xPlayer.getGroup() == "Supporter" then
                if(source > 0)then
                    --Player
             
                    if(#args == 1) then
                        --TriggerClientEvent('notifications', args[1], "#1df5fc", "Admin-REVIVE", "du wurdest von dem " .. xPlayer.getGroup(source) .. " " .. GetPlayerName(source) .. " wiederbelebt!" )
                        TriggerClientEvent("notify", args[1], 4, "ADMINISTRATION", "du wurdest von dem " .. xPlayer.getGroup(source) .. " " .. GetPlayerName(source) .. " wiederbelebt!", 2500)
                TriggerClientEvent('esx_ambulancejob:revive', tonumber(args[1]))
            else
                TriggerClientEvent('esx_ambulancejob:revive', tonumber(source))
               -- TriggerClientEvent('notifications', source, "#1df5fc", "Admin-REVIVE", "du hast dich selbst wiederbelebt!")
                TriggerClientEvent("notify", source, 4, "ADMINISTRATION", "du hast dich selbst wiederbelebt!", 2500)
            end
                else
                    --TriggerClientEvent('notifications', source, "#1df5fc", "Admin-REVIVE", "dazu hast du keine Rechte.")
                    TriggerClientEvent("notify", source, 4, "ADMINISTRATION", "dazu hast du keine Rechte.", 2500)
                end
            end
            end, false)


        RegisterCommand("kick", function(source, args, user)
            local xPlayer = ESX.GetPlayerFromId(source)
            if xPlayer.getGroup() == "Projektleiter" or xPlayer.getGroup() == "Teamvertrauter" or xPlayer.getGroup() == "Manager" or xPlayer.getGroup() == "Superadmin" or xPlayer.getGroup() == "Admin" or xPlayer.getGroup() == "Moderator" or xPlayer.getGroup() == "Supporter" or xPlayer.getGroup() == "Guide" then
                sendToDiscord("12745742", "Ticketsystem", "KICK", GetPlayerName(source) .. " hat den Spieler " .. GetPlayerName(args[1]) .. " gekickt!", "Ticketsystem v1.0 by NEXUS")
                if args[1] then
                    if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
                        local player = tonumber(args[1])
            
                        -- User permission check
                        TriggerEvent("es:getPlayerFromId", player, function(target)
            
                            local reason = args
                            table.remove(reason, 1)
                            if(#reason == 0)then
                                reason = "[NEXUS] du wurdest vom Server gekickt"
                            else
                                reason = "[NEXUS] du wurdest gekickt mit dem Grund: " .. table.concat(reason, " ")
                            end
            
                            TriggerClientEvent('grv_notifyannounce:display', -1, '', "der " .. xPlayer.getGroup(source) .. "  " .. GetPlayerName(source) .. " hat den Spieler " .. GetPlayerName(player) .. " vom Server gekickt", 15000, false)
                            DropPlayer(player, reason)
                        end)
                    end
                else
                    TriggerClientEvent('notifications', source, "#1df5fc", "Admin-CLEAR", "dazu hast du keine Rechte.")
                end
            end
            end, false)
                
            

        
        
    RegisterCommand("clearw", function(source, args, user)
        local xPlayer
        local xPlayer = ESX.GetPlayerFromId(source)
        local reason = args   
        if xPlayer.getGroup() == "Projektleiter" or xPlayer.getGroup() == "Teamvertrauter" or xPlayer.getGroup() == "Manager" or xPlayer.getGroup() == "Superadmin" or xPlayer.getGroup() == "Admin" then
            if(#reason == 0)then
               -- TriggerClientEvent('notifications', source, "#1df5fc", "Admin-CLEAR", "du hast dein Waffenrad erfolgreich zurückgesetzt!")
                TriggerClientEvent("notify", source, 4, "ADMINISTRATION", "du hast dein Waffenrad erfolgreich zurückgesetzt!", 2500)
                if args[1] then
                    xPlayer = ESX.GetPlayerFromId(source)
                else
                    xPlayer = ESX.GetPlayerFromId(source)
                end
                for i=#xPlayer.loadout, 1, -1 do
                    xPlayer.removeWeapon(xPlayer.loadout[i].name)
                end
            else
               --TriggerClientEvent('notifications', source, "#1df5fc", "Admin-CLEAR", "du hast das Waffenrad des Spieler's " .. GetPlayerName(args[1]) .. " zurückgesetzt!")
                TriggerClientEvent("notify", source, 4, "ADMINISTRATION", "du hast das Waffenrad des Spieler's " .. GetPlayerName(args[1]) .. " zurückgesetzt!", 2500)
            end
            sendToDiscord("12745742", "Ticketsystem", "WAFFEN-CLEAR", GetPlayerName(source) .. " das Waffenrad von " .. GetPlayerName(args[1]) .. " zurückgesetzt!", "Ticketsystem v1.0 by NEXUS")
            local xPlayer

            if args[1] then
                xPlayer = ESX.GetPlayerFromId(args[1])
            else
                xPlayer = ESX.GetPlayerFromId(source)
            end
            for i=#xPlayer.loadout, 1, -1 do
                xPlayer.removeWeapon(xPlayer.loadout[i].name)
        end
            else
                TriggerClientEvent("notify", source, 4, "ADMINISTRATION", "Dazu hast du keine Rechte", 2500)
            end
        end, false)




                
                RegisterCommand("clearinv", function(source, args, user)
                    local xPlayer
                    local xPlayer = ESX.GetPlayerFromId(source) --         
                    local reason = args   
                    if xPlayer.getGroup() == "Projektleiter" or xPlayer.getGroup() == "Teamvertrauter" or xPlayer.getGroup() == "Manager" or xPlayer.getGroup() == "Superadmin" or xPlayer.getGroup() == "Admin" then
                        if(#reason == 0)then
                            --TriggerClientEvent('notifications', source, "#1df5fc", "Admin-CLEAR", "du hast dein Inventar erfolgreich zurückgesetzt!")
                            TriggerClientEvent("notify", source, 4, "ADMINISTRATION", "du hast dein Inventar erfolgreich zurückgesetzt!", 2500)
                            if args[1] then
                                xPlayer = ESX.GetPlayerFromId(source)
                            else
                                xPlayer = ESX.GetPlayerFromId(source)
                            end
                            for i=1, #xPlayer.inventory, 1 do
                                if xPlayer.inventory[i].count > 0 then
                                    xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
                            end
                        end
                        else
                           -- TriggerClientEvent('notifications', source, "#1df5fc", "Admin-CLEAR", "du hast das Inventar des Spieler's " .. GetPlayerName(args[1]) .. " zurückgesetzt!")
                            TriggerClientEvent("notify", source, 4, "ADMINISTRATION", "du hast das Inventar des Spieler's " .. GetPlayerName(args[1]) .. " zurückgesetzt!", 2500)
                        end
                        sendToDiscord("12745742", "Ticketsystem", "INVENTAR-CLEAR", GetPlayerName(source) .. " das inventar von " .. GetPlayerName(args[1]) .. " zurückgesetzt!", "Ticketsystem v1.0 by NEXUS")
                        local xPlayer
            
                        if args[1] then
                            xPlayer = ESX.GetPlayerFromId(args[1])
                        else
                            xPlayer = ESX.GetPlayerFromId(source)
                        end
                        for i=1, #xPlayer.inventory, 1 do
                            if xPlayer.inventory[i].count > 0 then
                                xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
                        end
                    end
                        else
                            TriggerClientEvent("notify", source, 4, "ADMINISTRATION", "Dazu hast du keine Rechte!", 2500)
                        end
                    end, false)

                    RegisterCommand("give", function(source, args, user)
                        local _source = source
                        local xPlayer = ESX.GetPlayerFromId(args[1])
                        local item    = args[2]
                        local count   = (args[3] == nil and 1 or tonumber(args[3]))
                    
                        local xPlayer = ESX.GetPlayerFromId(source)
                        if xPlayer.getGroup() == "Projektleiter" or xPlayer.getGroup() == "Teamvertrauter" or xPlayer.getGroup() == "Manager" or xPlayer.getGroup() == "Superadmin" or xPlayer.getGroup() == "Admin" then
                            local xPlayer = ESX.GetPlayerFromId(args[1])
                               -- TriggerClientEvent('notifications', args[1], "#1df5fc", "AdminISTRATION", "dir wurde das Item " .. item .. " gegeben!")
                                TriggerClientEvent("notify", args[1], 4, "ADMINISTRATION", "dir wurde das Item " .. item .. " gegeben!", 2500)
                                --TriggerClientEvent('notifications', source, "#1df5fc", "Admin-GIVE", "Item "  .. item .. " erfolgreich gegeben!")
                                TriggerClientEvent("notify", source, 4, "ADMINISTRATION", "Item "  .. item .. " erfolgreich gegeben!", 2500)
                            sendToDiscord("12745742", "ITEM - GEGEBEN", "ITEM-LOG", GetPlayerName(source) .. " hat " .. GetPlayerName(args[1]) .. " das Item " .. item .. " " .. count .. "x gegeben!", "LOGS v1.0 by NEXUS")
                            if count ~= nil then
                                if xPlayer.getInventoryItem(item) ~= nil then
                                    xPlayer.addInventoryItem(item, count)
                                end
                            else
                                TriggerClientEvent("notify", source, 4, "ADMINISTRATION", "Dazu hast du keine Rechte!", 2500)
                            end
                        end
                        end, false)
    

                

                        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
                        RegisterCommand("a", function(source, args, user)
                            local xPlayers = ESX.GetPlayers()
                            local argString = table.concat(args, " ")
                            local xPlayer = ESX.GetPlayerFromId(source)
                            if xPlayer.getGroup() == "Projektleiter" or xPlayer.getGroup() == "Teamvertrauter" or xPlayer.getGroup() == "Manager" or xPlayer.getGroup() == "Superadmin" then
                                sendToDiscord("12745742", "Ticketsystem", "ANNOUNCE", GetPlayerName(source) .. " hat einen Announce gemacht \n**Grund:** " .. argString .. "", "Ticketsystem v1.0 by NEXUS")
                                for i=1, #xPlayers, 1 do    
                                    TriggerClientEvent('samj_global_notification:showNotification',  xPlayers[i],argString)
                                    end
                                else
                                    TriggerClientEvent("notify", args[1], 4, "ADMINISTRATION", "Dazu hast du keine Rechte", 2500)
                                end
                            end, false)
                




                            RegisterCommand("w", function(source, args, user)
                                local xPlayer    = ESX.GetPlayerFromId(args[1])
                                local weaponName = string.upper(args[2])
                            
                                local xPlayer = ESX.GetPlayerFromId(source)
                                if xPlayer.getGroup() == "Projektleiter" or xPlayer.getGroup() == "Teamvertrauter" or xPlayer.getGroup() == "Manager" or xPlayer.getGroup() == "Superadmin" or xPlayer.getGroup() == "Admin" then
                                    local xPlayer = ESX.GetPlayerFromId(args[1])
                                    --TriggerClientEvent('notifications', args[1], "#1df5fc", "Admin-GIVE", "dir wurde die Waffe "  .. weaponName .. " gegeben!")
                                    TriggerClientEvent("notify", args[1], 4, "ADMINISTRATION", "dir wurde die Waffe "  .. weaponName .. " gegeben!", 2500)
                                   -- TriggerClientEvent('notifications', source, "#1df5fc", "Admin-GIVE", "Waffe "  .. weaponName .. " erfolgreich gegeben!")
                                    TriggerClientEvent("notify", source, 4, "ADMINISTRATION", "Waffe "  .. weaponName .. " erfolgreich gegeben!", 2500)
                                    sendToDiscord("12745742", "WAFFEN - GEGEBEN", "WAFFEN-LOG", GetPlayerName(source) .. " hat " .. GetPlayerName(args[1]) .. " die Waffe " .. weaponName ..  " gegeben!", "LOGS v1.0 by NEXUS")
                                    xPlayer.addWeapon("weapon_" .. weaponName, tonumber(args[3]))
                                    else
                                        TriggerClientEvent("notify", args[1], 4, "ADMINISTRATION", "Dazu hast du keine Rechte", 2500)
                                    end
                                end, false)

            
        RegisterCommand("job", function(source, args, user)
            local xPlayer = ESX.GetPlayerFromId(source)
            if xPlayer.getGroup() == "Projektleiter" or xPlayer.getGroup() == "Teamvertrauter" or xPlayer.getGroup() == "Manager" or xPlayer.getGroup() == "Superadmin" or xPlayer.getGroup() == "Admin" then
                if tonumber(args[1]) and args[2] and tonumber(args[3]) then
                    local xPlayer = ESX.GetPlayerFromId(args[1])
                --TriggerClientEvent('notifications', source, "#1df5fc", "Admin-SET", "Job gesetzt!")
                TriggerClientEvent("notify", source, 4, "ADMINISTRATION", "Job " .. args[2] ..  " gesetzt!", 2500)
                TriggerClientEvent("notify", args[1], 4, "ADMINISTRATION", "dir wurde der Job " .. args[2] .. " von dem " .. xPlayer.getGroup(source) .. " " .. GetPlayerName(source) .. " gestzt!", 4000)
               -- TriggerClientEvent('notifications', args[1], "#1df5fc", "ADMINISTRATION", "dir wurde der Job " .. args[2] .. " von dem " .. xPlayer.getGroup(source) .. " " .. GetPlayerName(source) .. " gestzt!")
                if xPlayer then
                    if ESX.DoesJobExist(args[2], args[3]) then
                        xPlayer.setJob(args[2], args[3])
                    end
                end
                else
                    TriggerClientEvent("notify", args[1], 4, "ADMINISTRATION", "Dazu hast du keine Rechte", 2500)
                end
            end
            end, false)

            RegisterCommand("aduty", function(source, args, user)
                local xPlayer = ESX.GetPlayerFromId(source)
                if xPlayer.getGroup() == "Projektleiter" or xPlayer.getGroup() == "Teamvertrauter" or xPlayer.getGroup() == "Manager" or xPlayer.getGroup() == "Superadmin" or xPlayer.getGroup() == "Admin" or xPlayer.getGroup() == "Moderator" or xPlayer.getGroup() == "Supporter" or xPlayer.getGroup() == "Guide" then
                    TriggerClientEvent('toggleAduty', source)
                else
                    TriggerClientEvent("notify", args[1], 4, "ADMINISTRATION", "Dazu hast du keine Rechte", 2500)
                end
            end, false)

                



RegisterCommand("kill", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "Projektleiter" or xPlayer.getGroup() == "Teamvertrauter" or xPlayer.getGroup() == "Manager" or xPlayer.getGroup() == "Superadmin" or xPlayer.getGroup() == "Admin" or xPlayer.getGroup() == "Moderator" or xPlayer.getGroup() == "Supporter" or xPlayer.getGroup() == "Guide" then
        TriggerClientEvent('es_Admin:kill', args[1])
        
    else
        TriggerClientEvent("notify", args[1], 4, "ADMINISTRATION", "Dazu hast du keine Rechte", 2500)
    end
end, false)

RegisterCommand("troll", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "Projektleiter" or xPlayer.getGroup() == "Teamvertrauter" or xPlayer.getGroup() == "Manager" or xPlayer.getGroup() == "Superadmin" or xPlayer.getGroup() == "Admin" or xPlayer.getGroup() == "Moderator" or xPlayer.getGroup() == "Supporter" or xPlayer.getGroup() == "Guide" then
        TriggerClientEvent('es_Admin:slap', args[1])
    else
        TriggerClientEvent("notify", args[1], 4, "ADMINISTRATION", "Dazu hast du keine Rechte", 2500)
    end
end, false)

RegisterCommand("freez", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "Projektleiter" or xPlayer.getGroup() == "Teamvertrauter" or xPlayer.getGroup() == "Manager" or xPlayer.getGroup() == "Superadmin" or xPlayer.getGroup() == "Admin" or xPlayer.getGroup() == "Moderator" or xPlayer.getGroup() == "Supporter" or xPlayer.getGroup() == "Guide" then
        TriggerClientEvent('easyadmin.freeze', args[1])
    else
        TriggerClientEvent("notify", args[1], 4, "ADMINISTRATION", "Dazu hast du keine Rechte", 2500)
    end
end, false)


RegisterCommand("adutyaus", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "Projektleiter" then
        TriggerClientEvent('toggleAduty', args[1])
    else
        TriggerClientEvent("notify", args[1], 4, "ADMINISTRATION", "Dazu hast du keine Rechte", 2500)
    end
end, false)			





RegisterCommand("cuff", function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "Projektleiter" or xPlayer.getGroup() == "Teamvertrauter" or xPlayer.getGroup() == "Manager" or xPlayer.getGroup() == "Superadmin" or xPlayer.getGroup() == "Admin" or xPlayer.getGroup() == "Moderator" or xPlayer.getGroup() == "Supporter" then
        if(source > 0)then
            --Player
     
            if(#args == 1) then
        TriggerClientEvent('esx_policejob:handcuff', args[1])
    else
        TriggerClientEvent('esx_policejob:handcuff', source)
    end
        else
            TriggerClientEvent("notify", args[1], 4, "ADMINISTRATION", "Dazu hast du keine Rechte", 2500)
        end
    end
    end, false)



    

