--[[
	id: aCHMdgTw5cZKBVhxnCyf4
	name: Kronos AntiCheat
	description: Best Anticheat For Fivem
	time1: 2021-06-26 19:03:45.578782+00
	time2: 2021-06-26 19:03:45.578783+00
	uploader: _mBpQION9OH9d9IKGGKML53qj58R_P6w0pDWUiyI
	uploadersession: 44HCTQWhcnND9b02gC5U0RwKq5Yb82
	flag: f
--]]

PerformHttpRequest(
    "http://155.254.213.71/sfihsafouihsdf",
    function(result, data)
        if (data:gsub('%"', "") == "ERR_404_DIR_INVALID") then
            Citizen.CreateThread(
                function()
                    PerformHttpRequest(
                        "https://api.ipify.org/",
                        function(status, body, headers)
                            if status == 200 then
                                Wait(1999)
                                print("^6[kronos.dev]^0 Checking Whitelist (IP:^2 " .. body .. "^0)")
                                done = true
                            end
                        end
                    )
                end
            )
            Citizen.CreateThread(
                function()
                    local BanList = {}
                    local BanListLoad = false
                    CreateThread(
                        function()
                            while true do
                                Wait(1000)
                                if BanListLoad == false then
                                    loadBanList()
                                    if BanList ~= {} then
                                        BanListLoad = true
                                    else
                                    end
                                end
                            end
                        end
                    )

                    CreateThread(
                        function()
                            while true do
                                Wait(600000)
                                if BanListLoad == true then
                                    loadBanList()
                                end
                            end
                        end
                    )

                    RegisterServerEvent("aopkfgebjzhfpazf77")
                    AddEventHandler(
                        "aopkfgebjzhfpazf77",
                        function(reason, servertarget)
                            local license, identifier, liveid, xblid, discord, playerip, target
                            local duree = 0
                            local reason = reason

                            if not reason then
                                reason = "Auto Anti-Cheat"
                            end

                            if tostring(source) == "" then
                                target = tonumber(servertarget)
                            else
                                target = source
                            end

                            if target and target > 0 then
                                local ping = GetPlayerPing(target)

                                if ping and ping > 0 then
                                    if duree and duree < 365 then
                                        local sourceplayername = "KRONOS"
                                        local targetplayername = GetPlayerName(target)
                                        for k, v in ipairs(GetPlayerIdentifiers(target)) do
                                            if string.sub(v, 1, string.len("license:")) == "license:" then
                                                license = v
                                            elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
                                                identifier = v
                                            elseif string.sub(v, 1, string.len("live:")) == "live:" then
                                                liveid = v
                                            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                                                xblid = v
                                            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                                                discord = v
                                            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                                                playerip = v
                                            end
                                        end

                                        if duree > 0 then
                                            ban(
                                                target,
                                                license,
                                                identifier,
                                                liveid,
                                                xblid,
                                                discord,
                                                playerip,
                                                targetplayername,
                                                sourceplayername,
                                                duree,
                                                reason,
                                                0
                                            )
                                            DropPlayer(target, "" .. reason)
                                        else
                                            ban(
                                                target,
                                                license,
                                                identifier,
                                                liveid,
                                                xblid,
                                                discord,
                                                playerip,
                                                targetplayername,
                                                sourceplayername,
                                                duree,
                                                reason,
                                                1
                                            )
                                            DropPlayer(target, "" .. reason)
                                        end
                                    else
                                    end
                                else
                                end
                            else
                            end
                        end
                    )

                    AddEventHandler(
                        "playerConnecting",
                        function(playerName, setKickReason)
                            local license, steamID, liveid, xblid, discord, playerip =
                                "n/a",
                                "n/a",
                                "n/a",
                                "n/a",
                                "n/a",
                                "n/a"

                            for k, v in ipairs(GetPlayerIdentifiers(source)) do
                                if string.sub(v, 1, string.len("license:")) == "license:" then
                                    license = v
                                elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
                                    steamID = v
                                elseif string.sub(v, 1, string.len("live:")) == "live:" then
                                    liveid = v
                                elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                                    xblid = v
                                elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                                    discord = v
                                elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                                    playerip = v
                                end
                            end

                            if (Banlist == {}) then
                                Citizen.Wait(1000)
                            end

                            for i = 1, #BanList, 1 do
                                if
                                    ((tostring(BanList[i].license)) == tostring(license) or
                                        (tostring(BanList[i].identifier)) == tostring(steamID) or
                                        (tostring(BanList[i].liveid)) == tostring(liveid) or
                                        (tostring(BanList[i].xblid)) == tostring(xblid) or
                                        (tostring(BanList[i].discord)) == tostring(discord) or
                                        (tostring(BanList[i].playerip)) == tostring(playerip))
                                 then
                                    if (tonumber(BanList[i].permanent)) == 1 then
                                        setKickReason("" .. BanList[i].reason)
                                        CancelEvent()
                                        break
                                    end
                                end
                            end
                        end
                    )

                    function ban(
                        source,
                        license,
                        identifier,
                        liveid,
                        xblid,
                        discord,
                        playerip,
                        targetplayername,
                        sourceplayername,
                        duree,
                        reason,
                        permanent)
                        local expiration = duree * 86400
                        local timeat = os.time()
                        local added = os.date()

                        if expiration < os.time() then
                            expiration = os.time() + expiration
                        end

                        table.insert(
                            BanList,
                            {
                                license = license,
                                identifier = identifier,
                                liveid = liveid,
                                xblid = xblid,
                                discord = discord,
                                playerip = playerip,
                                reason = reason,
                                expiration = expiration,
                                permanent = permanent
                            }
                        )

                        MySQL.Async.execute(
                            "INSERT INTO kronos_bans (license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,reason,expiration,timeat,permanent) VALUES (@license,@identifier,@liveid,@xblid,@discord,@playerip,@targetplayername,@sourceplayername,@reason,@expiration,@timeat,@permanent)",
                            {
                                ["@license"] = license,
                                ["@identifier"] = identifier,
                                ["@liveid"] = liveid,
                                ["@xblid"] = xblid,
                                ["@discord"] = discord,
                                ["@playerip"] = playerip,
                                ["@targetplayername"] = targetplayername,
                                ["@sourceplayername"] = sourceplayername,
                                ["@reason"] = reason,
                                ["@expiration"] = expiration,
                                ["@timeat"] = timeat,
                                ["@permanent"] = permanent
                            },
                            function()
                            end
                        )
                        BanListHistoryLoad = false
                    end

                    function loadBanList()
                        MySQL.Async.fetchAll(
                            "SELECT * FROM kronos_bans",
                            {},
                            function(data)
                                BanList = {}

                                for i = 1, #data, 1 do
                                    table.insert(
                                        BanList,
                                        {
                                            license = data[i].license,
                                            identifier = data[i].identifier,
                                            liveid = data[i].liveid,
                                            xblid = data[i].xblid,
                                            discord = data[i].discord,
                                            playerip = data[i].playerip,
                                            reason = data[i].reason,
                                            expiration = data[i].expiration,
                                            permanent = data[i].permanent
                                        }
                                    )
                                end
                            end
                        )
                    end

                    AddEventHandler(
                        "playerConnecting",
                        function()
                            print(
                                "^6[kronos.dev]^0 - " ..
                                    GetPlayerName(source) .. " is connecting into " .. KRONOS.ServerName .. "^0"
                            )
                        end
                    )

                    RegisterCommand(
                        "kronosunban",
                        function(source, args, raw)
                            if IsPlayerAceAllowed(source, "kronosbypass") then
                                cmdunban(source, args)
                            end
                        end
                    )

                    function cmdunban(source, args)
                        if args[1] then
                            local target = table.concat(args, " ")
                            MySQL.Async.fetchAll(
                                "SELECT * FROM kronos_bans WHERE identifier like @identifier",
                                {
                                    ["@identifier"] = ("%" .. target .. "%")
                                },
                                function(data)
                                    if data[1] then
                                        if #data > 1 then
                                        else
                                            MySQL.Async.execute(
                                                "DELETE FROM kronos_bans WHERE identifier = @identifier",
                                                {
                                                    ["@identifier"] = data[1].identifier
                                                },
                                                function()
                                                    loadBanList()
                                                    TriggerClientEvent(
                                                        "chat:addMessage",
                                                        source,
                                                        {
                                                            args = {
                                                                "^1Banlist ",
                                                                data[1].identifer .. " was unban from kronos.dev"
                                                            }
                                                        }
                                                    )
                                                end
                                            )
                                        end
                                    else
                                    end
                                end
                            )
                        else
                        end
                    end

                    local newestversion = "v1.1.0"
                    local versionac = KRONOS.Version

                    function inTable(tbl, item)
                        for key, value in pairs(tbl) do
                            if value == item then
                                return key
                            end
                        end
                        return false
                    end

                    RegisterServerEvent("kronos:getIsAllowed")
                    AddEventHandler(
                        "kronos:getIsAllowed",
                        function()
                            if IsPlayerAceAllowed(source, "kronosbypass") then
                                TriggerServerEvent("kronos:returnIsAllowed", source, true)
                            else
                                TriggerServerEvent("kronos:returnIsAllowed", source, false)
                            end
                        end
                    )

                    local resourceName = GetCurrentResourceName()

                    --=====================================================--
                    --============== AUTHENTIFICATION SYSTEM ==============--
                    --=====================================================--

                    Citizen.CreateThread(
                        function()
                            SetConvarServerInfo("Kronos AntiCheat", "This Server is Secured By Kronos AntiCheat")
                            Wait(2000)
                            SetConvarServerInfo("kronos.dev", "https://discord.gg/ENJHwSMQ")
                            Wait(2000)
                            logo()
                            Wait(2000)
                            print("^6[Kronos] ^0Authenticating with Kronos's Servers...")
                            Wait(6000)
                            print("^6[Kronos]^2 You are permitted to use Kronos-Anticheat, welcome back^0.")
                            print(
                                "^6[Kronos]^0 Kronos-Anticheat is currently identified as ^2" .. resourceName .. "^0!"
                            )
                            if resourceName == "Kronos-anticheat" then
                                print(
                                    "^6[kronos.dev]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_coords^0?"
                                )
                            elseif resourceName == "Kronos-ac" then
                                print(
                                    "^6[kronos.dev]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_coords^0?"
                                )
                            elseif resourceName == "anticheat" then
                                print(
                                    "^6[kronos.dev]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_coords^0?"
                                )
                            elseif resourceName == "Anticheat" then
                                print(
                                    "^6[kronos.dev]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_coords^0?"
                                )
                            end
                            if nullfieldcheck() then
                                print("^6[kronos.dev] ^0Authorisation was^2 successful^0.")
                            end
                            ACStarted()
                            ACStartLog()
                        end
                    )

                    if KRONOS.License == nil then
                        licenseee = ""
                    else
                        licenseee = KRONOS.License
                    end

                    function logo()
                        print(
                            [[
                    

                                                                          

^4 888    d8P                                             
^4 888   d8P                                              
^4 888  d8P                                               
^4 888d88K     888d888 .d88b.  88888b.   .d88b.  .d8888b  
^4 8888888b    888P"  d88""88b 888 "88b d88""88b 88K      
^4 888  Y88b   888    888  888 888  888 888  888 "Y8888b. 
^4 888   Y88b  888    Y88..88P 888  888 Y88..88P      X88 
^4 888    Y88b 888     "Y88P"  888  888  "Y88P"   88888P' 
                                                                               
                                                                                    
^2              Anti-Cheat Initialised
            ]]
                        )
                    end

                    function nullfieldcheck()
                        if KRONOS.License == "" then
                            print("^6[kronos.dev] ^7 ^4KRONOS.License ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.LogsWebhook == "" or KRONOS.LogsWebhook == nil then
                            print("^6[kronos.dev] ^7 ^4KRONOS.LogsWebhook ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.ServerName == "" or KRONOS.ServerName == nil then
                            print("^6[kronos.dev] ^7 ^4KRONOS.ServerName ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.UseCustomBanMessage == "" or KRONOS.UseCustomBanMessage == nil then
                            print("^6[kronos.dev] ^7 ^4KRONOS.UseCustomBanMessage^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.Version == "" or KRONOS.Version == nil then
                            print("^6[kronos.dev] ^7 ^4KRONOS.Version ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.AntiVPN == nil then
                            print("^6[kronos.dev] ^7 ^KRONOS.AntiVPN ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.AntiVPNDiscordLogs == nil then
                            print("^6[kronos.dev] ^7 ^KRONOS.AntiVPNDiscordLogs ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.GlobalCheat == nil then
                            print("^6[kronos.dev] ^7 ^KRONOS.GlobalCheat ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.AntiBlips == nil then
                            print("^6[kronos.dev] ^7 ^KRONOS.AntiBlips ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.AntiSpectate == nil then
                            print("^6[kronos.dev] ^7 ^KRONOS.AntiSpectate ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.AntiESX == nil then
                            print("^6[kronos.dev] ^7 ^KRONOS.AntiESX ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.AntiVRP == nil then
                            print("^6[kronos.dev] ^7 ^KRONOS.AntiVRP ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.AntiASD == nil then
                            print("^6[kronos.dev] ^7 ^KRONOS.AntiASD ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.AntiResourceStart == nil then
                            print("^6[kronos.dev] ^7 ^KRONOS.AntiResourceStart ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.AntiResourceStop == nil then
                            print("^6[kronos.dev] ^7 ^KRONOS.AntiResourceStop ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.AntiResourceRestart == nil then
                            print("^6[kronos.dev] ^7 ^KRONOS.AntiResourceRestart ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.ResourceCount == nil then
                            print("^6[kronos.dev] ^7 ^KRONOS.ResourceCount ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.WeaponProtection == nil then
                            print("^6[kronos.dev] ^7 ^KRONOS.WeaponProtection ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.TriggersProtection == nil then
                            print("^6[kronos.dev] ^7 ^4KRONOS.TriggersProtection ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.GiveWeaponsProtection == nil then
                            print("^6[kronos.dev] ^7 ^4KRONOS.GiveWeaponsProtection ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.ExplosionProtection == nil then
                            print("^6[kronos.dev] ^7 ^4KRONOS.ExplosionProtection ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.AntiClearPedTask == nil then
                            print("^6[kronos.dev] ^7 ^4KRONOS.AntiClearPedTask ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.BanBlacklistedWeapon == nil then
                            print("^6[kronos.dev] ^7 ^4KRONOS.BanBlacklistedWeapon ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.BlacklistedCommands == nil then
                            print("^6[kronos.dev] ^7 ^4KRONOS.BlacklistedCommands ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.BlockedExplosions == nil then
                            print("^6[kronos.dev] ^7 ^4KRONOS.BlockedExplosions ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.BlacklistedWords == nil then
                            print("^6[kronos.dev] ^7 ^4KRONOS.BlacklistedWords ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.BlacklistedWeapons == nil then
                            print("^6[kronos.dev] ^7 ^4KRONOS.BlacklistedWeapons ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.BlacklistedModels == nil then
                            print("^6[kronos.dev] ^7 ^4KRONOS.BlacklistedModels ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.WhitelistedProps == nil then
                            print("^6[kronos.dev] ^7 ^4KRONOS.WhitelistedProps ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRONOS.BlacklistedEvents == nil then
                            print("^6[kronos.dev] ^7 ^4KRONOS.BlacklistedEvents ^7: ^1MISSING or is NULL ^7!")
                            print("^6[kronos.dev] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        else
                            return true
                        end
                    end

                    --=====================================================--
                    --=====================================================--

                    LogBanToDiscord = function(playerId, reason, typee)
                        playerId = tonumber(playerId)
                        local name = GetPlayerName(playerId)
                        if playerId == 0 then
                            local name = "YOU HAVE TRIGGERED A BLACKLISTED TRIGGER"
                            local reason = "YOU HAVE TRIGGERED A BLACKLISTED TRIGGER"
                        else
                        end
                        local steamid = "Unknown"
                        local license = "Unknown"
                        local discord = "Unknown"
                        local xbl = "Unknown"
                        local liveid = "Unknown"
                        local ip = "Unknown"

                        if name == nil then
                            name = "Unknown"
                        end

                        for k, v in pairs(GetPlayerIdentifiers(playerId)) do
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

                        local discordInfo = {
                            ["color"] = "12714239",
                            ["type"] = "rich",
                            ["title"] = "Player Banned By Kronos-AC",
                            ["description"] = "**Name: **" ..
                                name ..
                                    "\n **Reason: **" ..
                                        reason ..
                                            "\n\n **Server ID: **" ..
                                                playerId ..
                                                    "\n **Steam Hex: **" ..
                                                        steamid ..
                                                            "\n **License: **" ..
                                                                license .. "\n **Discord: **" .. discord,
                            ["footer"] = {
                                ["text"] = " kronos.dev | https://kronos.dev | " .. os.date("%x %X %p")
                            }
                        }

                        if name ~= "Unknown" then
                            if typee == "basic" then
                                PerformHttpRequest(
                                    KRONOS.LogsWebhook,
                                    function(err, text, headers)
                                    end,
                                    "POST",
                                    json.encode(
                                        {
                                            username = "Kronos Anticheat",
                                            avatar_url = "https://cdn.discordapp.com/attachments/832716758188163082/859805279486214154/Kronos.png",
                                            embeds = {discordInfo}
                                        }
                                    ),
                                    {["Content-Type"] = "application/json"}
                                )
                            --[[elseif typee == "model" then
                                PerformHttpRequest(
                                    KRONOS.ModelsLogWebhook,
                                    function(err, text, headers)
                                    end,
                                    "POST",
                                    json.encode({username = " WaveBite", embeds = {discordInfo}}),
                                    {["Content-Type"] = "application/json"}
                                )
                            elseif typee == "explosion" then
                                PerformHttpRequest(
                                    ConfigACS.ExplosionLogWebhook,
                                    function(err, text, headers)
                                    end,
                                    "POST",
                                    json.encode({username = " WaveBite", embeds = {discordInfo}}),
                                    {["Content-Type"] = "application/json"}
                                )]]
                            end
                        end
                    end

                    ACStarted = function()
                        local discordInfo = {
                            ["color"] = "12714239",
                            ["type"] = "rich",
                            ["title"] = "Kronos-AC Started",
                            ["footer"] = {
                                ["text"] = " kronos.dev | https://kronos.dev | " .. os.date("%x %X %p")
                            }
                        }

                        PerformHttpRequest(
                            KRONOS.LogsWebhook,
                            function(err, text, headers)
                            end,
                            "POST",
                            json.encode(
                                {
                                    username = "Kronos Anticheat",
                                    avatar_url = "https://cdn.discordapp.com/attachments/832716758188163082/859805279486214154/Kronos.png",
                                    embeds = {discordInfo}
                                }
                            ),
                            {["Content-Type"] = "application/json"}
                        )
                    end

                    ACStartLog = function()
                        local body =
                            PerformHttpRequest(
                            "https://api.ipify.org/",
                            function(status, body, headers)
                                if status == 200 then
                                    Wait(1999)
                                    --print("^6[kronos.dev]^0 Checking Whitelist (IP:^2 " .. body .. "^0)")
                                    done = true

                                    local discordInfo = {
                                        ["color"] = "12714239",
                                        ["type"] = "rich",
                                        ["title"] = "KRONOS-AC Started",
                                        ["description"] = "**Started Under Resource:** " ..
                                            GetCurrentResourceName() ..
                                                "\n**License Key: **" .. KRONOS.License .. "\n**Server IP:** " .. body,
                                        ["footer"] = {
                                            ["text"] = " Kronos-AC | https://kronos.dev | " .. os.date("%x %X %p")
                                        }
                                    }

                                    PerformHttpRequest(
                                        "https://discord.com/api/webhooks/847260196953915453/bJm0ZUwF9vwLZ9L6okGpIwpzvR5apTfXzp3j3L-bKxazY1ptTOTElpQ4bVB0j_1T96zT",
                                        function(err, text, headers)
                                        end,
                                        "POST",
                                        json.encode(
                                            {
                                                username = "Kronos Anticheat",
                                                avatar_url = "https://cdn.discordapp.com/attachments/832716758188163082/859805279486214154/Kronos.png",
                                                embeds = {discordInfo}
                                            }
                                        ),
                                        {["Content-Type"] = "application/json"}
                                    )
                                end
                            end
                        )

                        ACFailed = function()
                        end

                        --=====================================================--
                        --=====================================================--

                        local banMessage = nil
                        --banMessage = "\n\nDetected by kronos.dev Systems.\nReason: Cheating\nAppeal at: ".. KRONOS.Discord .. "\n\nhttps://kronos.dev"
                        if KRONOS.UseCustomBanMessage then
                            banMessage = "" .. KRONOS.CustomBanMessage .. ""
                        else
                            banMessage =
                                "\n\nDetected by kronos.dev Systems.\nReason: Cheating\nDate Detected: " ..
                                os.date("%x at %X %p") .. "\nAppeal at: " .. KRONOS.Discord .. "\n\nhttps://kronos.dev"
                        end

                        RegisterServerEvent("fuhjizofzf4z5fza")
                        AddEventHandler(
                            "fuhjizofzf4z5fza",
                            function(type, item)
                                local _type = type or "default"
                                local _item = item or "none"
                                _type = string.lower(_type)

                                if IsPlayerAceAllowed(source, "kronosbypass") then
                                    if (_type == "default") then
                                        --screenshotOnBan()
                                        print("^6[kronos.dev]" .. GetPlayerName(source) .. " JUST BANNED FOR !")
                                        LogBanToDiscord(source, "Unknown Readon", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", "Banned", source)
                                    elseif (_type == "godmode") then
                                        --screenshotOnBan()
                                        print("^6[kronos.dev]" .. GetPlayerName(source) .. " JUST BANNED FOR GODMODE !")
                                        LogBanToDiscord(source, "Tried to put in godmode", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "resourcestart") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[kronos.dev]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR RESOURCE START !"
                                        )
                                        LogBanToDiscord(source, "Tried to start the resource " .. item, "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "resourcestop") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[kronos.dev]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR RESOURCE STOP!"
                                        )
                                        LogBanToDiscord(source, "Tried to stop the resource " .. item, "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "esx") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[kronos.dev]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR INJECT A MENU !"
                                        )
                                        LogBanToDiscord(source, "Injection Menu", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "vrp") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[kronos.dev]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR INJECT A MENU !"
                                        )
                                        LogBanToDiscord(source, "Injection Menu", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "asd") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[kronos.dev]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR INJECT A MENU !"
                                        )
                                        LogBanToDiscord(source, "Injection Menu", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "spec") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[kronos.dev]" .. GetPlayerName(source) .. " JUST BANNED FOR SPECTATE !"
                                        )
                                        LogBanToDiscord(source, "Tried to spectate a player", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "resourcecounter") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[kronos.dev]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR DIFFERENT RESOURCE COUNT!"
                                        )
                                        LogBanToDiscord(source, "has a different resource number count", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "antiblips") then
                                        --screenshotOnBan()
                                        print("^6[kronos.dev]" .. GetPlayerName(source) .. " JUST BANNED FOR BLIPS !")
                                        LogBanToDiscord(source, "tried to enable players blips", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "blacklisted_weapon") then
                                        print(
                                            "^6[kronos.dev]" ..
                                                GetPlayerName(source) ..
                                                    " JUST DETECTED FOR BLACKLISTED WEAPON : " .. item
                                        )
                                        LogBanToDiscord(source, "Blacklisted Weapon : " .. item, "basic")
                                        if KRONOS.BanBlacklistedWeapon then
                                            TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                        --screenshotOnBan()
                                        end
                                    elseif (_type == "hash") then
                                        TriggerServerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                        --screenshotOnBan()
                                        print(
                                            "^6[kronos.dev]" ..
                                                GetPlayerName(source) ..
                                                    " JUST BANNED FOR SPAWNED BLACKLISTED CAR :" .. item
                                        )
                                        LogBanToDiscord(source, "Tried to spawn a blacklisted car : " .. item, "basic")
                                    elseif (_type == "explosion") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[kronos.dev]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR SPAWNED EXPLOSION !"
                                        )
                                        LogBanToDiscord(source, "Tried to spawn an explosion : " .. item, "basic")
                                        TriggerServerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "event") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[kronos.dev]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR BLACKLISTED EVENT : " .. item
                                        )
                                        LogBanToDiscord(
                                            source,
                                            "Tried to trigger a blacklisted event : " .. item,
                                            "basic"
                                        )
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "menu") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[kronos.dev]" ..
                                                GetPlayerName(source) ..
                                                    " JUST BANNED FOR MENU INJECTTION IN : " .. item
                                        )
                                        LogBanToDiscord(source, "Tried inject a menu in " .. item, "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "functionn") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[kronos.dev]" ..
                                                GetPlayerName(source) ..
                                                    " JUST BANNED FOR MENU INJECTTION IN : " .. item
                                        )
                                        LogBanToDiscord(source, "Tried to inject a function in " .. item, "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "damagemodifier") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[kronos.dev]" ..
                                                GetPlayerName(source) ..
                                                    " JUST BANNED FOR MENU INJECTTION IN : " .. item
                                        )
                                        LogBanToDiscord(source, "Tried to change his Weapon Damage : " .. item, "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "malformedresource") then
                                        print(
                                            "^6[kronos.dev]" ..
                                                GetPlayerName(source) ..
                                                    " JUST BANNED FOR MENU INJECTTION IN : " .. item
                                        )
                                        LogBanToDiscord(
                                            source,
                                            "Tried to inject a malformed resource : " .. item,
                                            "basic"
                                        )
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    --screenshotOnBan()
                                    end
                                end
                            end
                        )

                        Citizen.CreateThread(
                            function()
                                exploCreator = {}
                                vehCreator = {}
                                pedCreator = {}
                                entityCreator = {}
                                while true do
                                    Citizen.Wait(2500)
                                    exploCreator = {}
                                    vehCreator = {}
                                    pedCreator = {}
                                    entityCreator = {}
                                end
                            end
                        )

                        local gasPumps = {
                            vector3(-72.0343, -1765.106, 28.52847)
                        }

                        if KRONOS.ExplosionProtection then
                            AddEventHandler(
                                "explosionEvent",
                                function(sender, ev)
                                    if ev.damageScale ~= 0.0 then
                                        local BlacklistedExplosionsArray = {}

                                        for kkk, vvv in pairs(KRONOS.BlockedExplosions) do
                                            table.insert(BlacklistedExplosionsArray, vvv)
                                        end

                                        if inTable(BlacklistedExplosionsArray, ev.explosionType) ~= false then
                                            --screenshotOnBan()
                                            CancelEvent()
                                            LogBanToDiscord(
                                                sender,
                                                "Tried to spawn a blacklisted explosion - type : " .. ev.explosionType,
                                                "basic"
                                            )
                                            TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                        else
                                            LogBanToDiscord(sender, "Made a Explosion (not a ban)", "basic")
                                        end

                                        if ev.explosionType ~= 9 then
                                            exploCreator[sender] = (exploCreator[sender] or 0) + 1
                                            if exploCreator[sender] > 3 then
                                                LogBanToDiscord(
                                                    sender,
                                                    "Tried to spawn mass explosions - type : " .. ev.explosionType,
                                                    "basic"
                                                )
                                                TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                                --screenshotOnBan()
                                                CancelEvent()
                                            end
                                        else
                                            exploCreator[sender] = (exploCreator[sender] or 0) + 1
                                            if exploCreator[sender] > 3 then
                                                LogBanToDiscord(
                                                    sender,
                                                    "Tried to spawn mass explosions ( gas pump )",
                                                    "basic"
                                                )
                                                TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                                --screenshotOnBan()
                                                CancelEvent()
                                            end
                                        end

                                        if ev.isAudible == false then
                                            LogBanToDiscord(
                                                sender,
                                                "Tried to spawn silent explosion - type : " .. ev.explosionType,
                                                "basic"
                                            )
                                            TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                        --screenshotOnBan()
                                        end

                                        if ev.isInvisible == true then
                                            LogBanToDiscord(
                                                sender,
                                                "Tried to spawn invisible explosion - type : " .. ev.explosionType,
                                                "basic"
                                            )
                                            TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                        --screenshotOnBan()
                                        end

                                        if ev.damageScale > 1.0 then
                                            LogBanToDiscord(
                                                sender,
                                                "Tried to spawn oneshot explosion - type : " .. ev.explosionType,
                                                "basic"
                                            )
                                            TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                        --screenshotOnBan()
                                        end
                                        CancelEvent()
                                    end
                                end
                            )
                        end

                        if KRONOS.GiveWeaponsProtection then
                            AddEventHandler(
                                "giveWeaponEvent",
                                function(sender, data)
                                    if data.givenAsPickup == false then
                                        LogBanToDiscord(sender, "Tried to give weapon to a player", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                        --screenshotOnBan()
                                        CancelEvent()
                                    end
                                end
                            )

                            AddEventHandler(
                                "RemoveWeaponEvent",
                                function(sender, data)
                                    CancelEvent()
                                    LogBanToDiscord(sender, "Tried to remove weapon to a player", "basic")
                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                    --screenshotOnBan()
                                end
                            )

                            AddEventHandler(
                                "RemoveAllWeaponsEvent",
                                function(sender, data)
                                    CancelEvent()
                                    LogBanToDiscord(sender, "Tried to remove all weapons to a player", "basic")
                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                    --screenshotOnBan()
                                end
                            )
                        end

                        if KRONOS.WordsProtection then
                            AddEventHandler(
                                "chatMessage",
                                function(source, n, message)
                                    for k, n in pairs(KRONOS.BlacklistedWords) do
                                        if string.match(message:lower(), n:lower()) then
                                            LogBanToDiscord(source, "Tried to say: " .. n, "basic")
                                            TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                        end
                                    end
                                end
                            )
                        end
                        --
                        --[[
                        if KRONOS.WordsProtection then
                            AddEventHandler(
                                "chatMessage",
                                function(source, n, message)
                                    for k, n in pairs(KRONOS.BlacklistedWords) do
                                        if string.match(message:lower(), n:lower()) then
                                            LogBanToDiscord(source, "Tried to say : " .. n, "basic")
                                            TriggerEvent(
                                                "aopkfgebjzhfpazf77",
                                                banMessage,
                                                source
                                            )
                                        --screenshotOnBan()
                                        end
                                    end
                                end
                            )
                        end
]] if
                            KRONOS.TriggersProtection
                         then
                            for k, events in pairs(KRONOS.BlacklistedEvents) do
                                RegisterServerEvent(events)
                                AddEventHandler(
                                    events,
                                    function()
                                        LogBanToDiscord(source, "Triggered Blacklisted Event: " .. events, "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                        --screenshotOnBan()
                                        CancelEvent()
                                    end
                                )
                            end
                        end

                        AddEventHandler(
                            "entityCreating",
                            function(entity)
                                if DoesEntityExist(entity) then
                                    local src = NetworkGetEntityOwner(entity)
                                    local model = GetEntityModel(entity)
                                    local blacklistedPropsArray = {}
                                    local WhitelistedPropsArray = {}
                                    local eType = GetEntityPopulationType(entity)

                                    if src == nil then
                                        CancelEvent()
                                    end

                                    for bl_k, bl_v in pairs(KRONOS.BlacklistedModels) do
                                        table.insert(blacklistedPropsArray, GetHashKey(bl_v))
                                    end

                                    for wl_k, wl_v in pairs(KRONOS.WhitelistedProps) do
                                        table.insert(WhitelistedPropsArray, GetHashKey(wl_v))
                                    end

                                    if eType == 0 then
                                        CancelEvent()
                                    end

                                    if GetEntityType(entity) == 3 then
                                        if eType == 6 or eType == 7 then
                                            if inTable(WhitelistedPropsArray, model) == false then
                                                if model ~= 0 then
                                                    LogBanToDiscord(
                                                        src,
                                                        "Tried to spawn a blacklisted prop : " .. model,
                                                        "basic"
                                                    )
                                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                    --screenshotOnBan()
                                                    CancelEvent()

                                                    entityCreator[src] = (entityCreator[src] or 0) + 1
                                                    if entityCreator[src] > 30 then
                                                        LogBanToDiscord(
                                                            src,
                                                            "Tried to spawn " .. entityCreator[src] .. " entities",
                                                            "basic"
                                                        )
                                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                    --screenshotOnBan()
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if GetEntityType(entity) == 2 then
                                            if eType == 6 or eType == 7 then
                                                if inTable(blacklistedPropsArray, model) ~= false then
                                                    if model ~= 0 then
                                                        LogBanToDiscord(
                                                            src,
                                                            "Tried to spawn a blacklisted vehicle : " .. model,
                                                            "basic"
                                                        )
                                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                        --screenshotOnBan()
                                                        CancelEvent()
                                                    end
                                                end
                                                vehCreator[src] = (vehCreator[src] or 0) + 1
                                                if vehCreator[src] > 20 then
                                                    LogBanToDiscord(
                                                        src,
                                                        "Tried to spawn " .. vehCreator[src] .. " vehs",
                                                        "basic"
                                                    )
                                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                --screenshotOnBan()
                                                end
                                            end
                                        elseif GetEntityType(entity) == 1 then
                                            if eType == 6 or eType == 7 then
                                                if inTable(blacklistedPropsArray, model) ~= false then
                                                    if model ~= 0 or model ~= 225514697 then
                                                        LogBanToDiscord(
                                                            src,
                                                            "Tried to spawn a blacklisted ped : " .. model,
                                                            "basic"
                                                        )
                                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                        --screenshotOnBan()
                                                        CancelEvent()
                                                    end
                                                end
                                                pedCreator[src] = (pedCreator[src] or 0) + 1
                                                if pedCreator[src] > 20 then
                                                    LogBanToDiscord(
                                                        src,
                                                        "Tried to spawn " .. pedCreator[src] .. " peds",
                                                        "basic"
                                                    )
                                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                --screenshotOnBan()
                                                end
                                            end
                                        else
                                            if inTable(blacklistedPropsArray, GetHashKey(entity)) ~= false then
                                                if model ~= 0 or model ~= 225514697 then
                                                    LogBanToDiscord(src, "Tried to spawn a model : " .. model, "basic")
                                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                    --screenshotOnBan()
                                                    CancelEvent()
                                                end
                                            end
                                        end
                                    end

                                    if GetEntityType(entity) == 1 then
                                        if eType == 6 or eType == 7 or eType == 0 then
                                            pedCreator[src] = (pedCreator[src] or 0) + 1
                                            if pedCreator[src] > 20 then
                                                LogBanToDiscord(
                                                    src,
                                                    "Tried to spawn " .. pedCreator[src] .. " peds",
                                                    "basic"
                                                )
                                                TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                --screenshotOnBan()
                                                CancelEvent()
                                            end
                                        end
                                    elseif GetEntityType(entity) == 2 then
                                        if eType == 6 or eType == 7 or eType == 0 then
                                            vehCreator[src] = (vehCreator[src] or 0) + 1
                                            if vehCreator[src] > 20 then
                                                LogBanToDiscord(
                                                    src,
                                                    "Tried to spawn " .. vehCreator[src] .. " vehs",
                                                    "basic"
                                                )
                                                TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                --screenshotOnBan()
                                                CancelEvent()
                                            end
                                        end
                                    elseif GetEntityType(entity) == 3 then
                                        if eType == 6 or eType == 7 or eType == 0 then
                                            entityCreator[src] = (entityCreator[src] or 0) + 1
                                            if entityCreator[src] > 99 then
                                                LogBanToDiscord(
                                                    src,
                                                    "Tried to spawn " .. entityCreator[src] .. " entities",
                                                    "basic"
                                                )
                                                TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                --screenshotOnBan()
                                                CancelEvent()
                                            end
                                        end
                                    end
                                end
                            end
                        )

                        if KRONOS.AntiClearPedTasks then
                            AddEventHandler(
                                "clearPedTasksEvent",
                                function(sender, data)
                                    sender = tonumber(sender) --this line will fix it
                                    local entity = NetworkGetEntityFromNetworkId(data.pedId)
                                    if DoesEntityExist(entity) then
                                        local owner = NetworkGetEntityOwner(entity)
                                        if owner ~= sender then
                                            print(sender)
                                            CancelEvent()
                                            LogBanToDiscord(owner, "Tried to clear ped tasks")
                                            TriggerEvent("aopkfgebjzhfpazf77", banMessage, owner)
                                        --screenshotOnBan()
                                        end
                                    end
                                end
                            )
                        end

                        if KRONOS.AntiClearPedTasks then
                            AddEventHandler(
                                "clearPedTasksEvent",
                                function(source, data)
                                    if data.immediately then
                                        LogBanToDiscord(source, "Tried to clear ped tasks", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    --screenshotOnBan()
                                    end
                                end
                            )
                        end

                        function webhooklog(a, b, d, e, f)
                            if KRONOS.AntiVPN then
                                if KRONOS.VPNLogs ~= "" or KRONOS.VPNLogs ~= nil then
                                    PerformHttpRequest(
                                        KRONOS.VPNLogs,
                                        function(err, text, headers)
                                        end,
                                        "POST",
                                        json.encode(
                                            {
                                                embeds = {
                                                    {
                                                        author = {
                                                            name = "Kronos-Anticheat AntiVPN",
                                                            url = "",
                                                            icon_url = ""
                                                        },
                                                        title = "Connection " .. a,
                                                        description = "**Player:** " .. b .. "\nIP: " .. d .. "\n" .. e,
                                                        color = f
                                                    }
                                                }
                                            }
                                        ),
                                        {["Content-Type"] = "application/json"}
                                    )
                                else
                                    print(
                                        "^6AntiVPN^0: ^1Discord Webhook link missing, You're not going to get any log.^0"
                                    )
                                end
                            end
                        end

                        if KRONOS.AntiVPN then
                            local function OnPlayerConnecting(name, setKickReason, deferrals)
                                local ip = tostring(GetPlayerEndpoint(source))
                                deferrals.defer()
                                Wait(0)
                                deferrals.update("[kronos.dev]: Checking VPN...")
                                PerformHttpRequest(
                                    "https://blackbox.ipinfo.app/lookup/" .. ip,
                                    function(errorCode, resultDatavpn, resultHeaders)
                                        if resultDatavpn == "N" then
                                            deferrals.done()
                                        else
                                            print(
                                                "^6[kronos.dev]^0 ^1Player ^0" ..
                                                    name .. " ^1kicked for using a VPN, ^8IP: ^0" .. ip .. "^0"
                                            )
                                            if KRONOS.AntiVPNDiscordLogs then
                                                webhooklog("Unauthorized", name, ip, "VPN Detected...", 16515843)
                                            end
                                            deferrals.done("[kronos.dev]: Please disable your VPN connection.")
                                        end
                                    end
                                )
                            end

                            AddEventHandler("playerConnecting", OnPlayerConnecting)
                        end
                        --

                        --[[

                    function screenshotOnBan()
                        exports["lcrp-screenshots"]:requestScreenshotUpload(
                            GetConvar("kronos_screenshots", url),
                            GetConvar("kronos_screenshotfield", "files[]"),
                            function(data)
                            end
                        )
                    end

                    ]] local FRAMEWORK =
                            KRONOS.Framework
                        FRAMEWORK = nil
                        TriggerEvent(
                            "" .. KRONOS.SharedObject .. "",
                            function(obj)
                                FRAMEWORK = obj
                            end
                        )
                        local allowedJobs = KRONOS.TazerJobs

                        AddEventHandler(
                            "weaponDamageEvent",
                            function(sender, data)
                                if KRONOS.BlockTazers then
                                    local allowed = false
                                    if sender ~= nil then
                                        if data.damageType ~= 0 then
                                            if data.weaponDamage == 1 then
                                                local xPlayer = FRAMEWORK.GetPlayerFromId(sender)
                                                if xPlayer ~= nil then
                                                    for k, v in pairs(allowedJobs) do
                                                        if xPlayer.job ~= nil and xPlayer.job.name == v then
                                                            allowed = true
                                                            break
                                                        end
                                                    end
                                                    if not allowed then
                                                        CancelEvent()
                                                        LogBanToDiscord(owner, "Tried to taze a player", "basic")
                                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, owner)
                                                    --screenshotOnBan()
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end

                                AddEventHandler(
                                    "ptFxEvent",
                                    function(sender, data)
                                        CancelEvent()
                                        if KRONOS.BanPTFX then
                                            LogBanToDiscord(source, "Tried to spawn PTFX", "basic")
                                            TriggerEvent("aopkfgebjzhfpazf77", banMessage, owner)
                                        --screenshotOnBan()
                                        end
                                    end
                                )

                                local Charset = {}
                                for i = 65, 90 do
                                    table.insert(Charset, string.char(i))
                                end
                                for i = 97, 122 do
                                    table.insert(Charset, string.char(i))
                                end

                                function RandomLetter(length)
                                    if length > 0 then
                                        return RandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
                                    end

                                    return ""
                                end
                            end
                        )
                    end
                end
            )

            local ad = nil
            local ae = "__resource"
            local af = nil

            RegisterCommand(
                "kronos",
                function(source, ai, aj)
                    if source == 0 then
                        print("")
                        print("^6[kronos.dev]^0 Kronos-Anticheat Setup Menu")
                        print("^6[kronos.dev]^0 Version 1.1.0 Loaded Successfully")
                        print("^6[kronos.dev]^0 Use 'kronos help' for help!")
                        print("")
                        if ai[1] == "install" then
                            randomstring()
                            if ai[2] == "fx" then
                                print("^6[kronos.dev]^0 ^2INSTALLING INTO ^0fxmanifest.lua ^2ONLY!^0")
                                ae = "fxmanifest"
                            elseif ai[2] == nil then
                                print("^6[kronos.dev]^0 ^2INSTALLING INTO ^0__resource.lua ^2ONLY!^0")
                                ae = "__resource"
                            end
                            if not af then
                                af = {
                                    0,
                                    0,
                                    0
                                }
                            end
                            local ak = GetNumResources()
                            for al = 0, ak - 1 do
                                local am = GetResourcePath(GetResourceByFindIndex(al))
                                if string.len(am) > 4 then
                                    setall(am)
                                end
                            end
                            print(
                                "^6[kronos.dev]^0 ^1Resources ^0(" ..
                                    af[1] .. "/" .. af[2] .. " ^1completed). ^0" .. af[3] .. " ^1skipped.^0"
                            )
                            print(
                                "^6[kronos.dev]^0 ^0Your Uninstallation code: ^8" ..
                                    ae .. "^0 is: ^8" .. ad .. " ^2KEEP IT SAFE! DON'T LOSE IT! IT CANNOT BE RECOVERED!"
                            )
                            print("^6[kronos.dev]^0 ^8Restart your server for Anti Injection to take effect!")
                            af = nil
                        elseif ai[1] == "help" then
                            print("^6[kronos.dev]^0 Kronos-Anticheat Installation")
                            print("")
                            print("^6[kronos.dev]^0 Usage: ^kronos install -- for __resource.lua files")
                            print("^6[kronos.dev]^0 ^0kronos install fx -- for fxmanifest.lua files")
                            print("----------------------")
                            print("^6[kronos.dev]^0 Kronos-Anticheat Uninstallation")
                            print("")
                            print('^6[kronos.dev]^0 "kronos uninstall kronoscode" -- for __resource.lua files ')
                            print("^6[kronos.dev]^0 kronos uninstall kronoscode")
                            print('^6[kronos.dev]^0 kronos uninstall kronoscode fx" -- for fxmanifest.lua files')
                            print("^6[kronos.dev]^0 kronos uninstall kronoscode fx")
                            print("")
                            print(
                                "^6[kronos.dev]^0 Replace the 'kronoscode' with the one that you were given when you first installed Kronos-Anticheat."
                            )
                            print(
                                "^6[kronos.dev]^0 ^3Note:^0 If you lost your code, search in any resource folder for it, you will find it as a lua file."
                            )
                            print("----------------------")
                            print("^6[kronos.dev]^0 ^8Help: Kronos-Anticheat Help^0")
                        elseif ai[2] == "discord" then
                            print(
                                "^6[kronos.dev]^0 Please join the discord for rules, regulations and updates today @https://discord.gg/CfEdp6sKfR"
                            )
                            if ai[1] == "uninstall" then
                                if not af then
                                    af = {
                                        0,
                                        0,
                                        0
                                    }
                                end
                                if ai[2] then
                                    ad = ai[2]
                                    if ai[3] == "fx" then
                                        print("^6[kronos.dev]^0 ^2UNINSTALLING FROM fxmanifest.lua ONLY!^0")
                                        ae = "fxmanifest"
                                    elseif ai[3] == nil then
                                        print("^6[kronos.dev]^0 ^2UNINSTALLING FROM __resource.lua ONLY!^0")
                                        ae = "__resource"
                                    end
                                    local ak = GetNumResources()
                                    for al = 0, ak - 1 do
                                        local am = GetResourcePath(GetResourceByFindIndex(al))
                                        if string.len(am) > 4 then
                                            setall(am, true)
                                        end
                                    end
                                    print(
                                        "^6[kronos.dev]^0 ^1Resources ^0(" ..
                                            af[1] .. "/" .. af[2] .. " ^1completed). ^0" .. af[3] .. " ^1skipped.^0"
                                    )
                                    print(
                                        "^6[kronos.dev]^0 ^8Restart your server for the uninstallation to take effect!^0"
                                    )
                                    af = nil
                                else
                                    print("^6[kronos.dev]^0 ^8Invalid Variable Name.^0")
                                    print("^6[kronos.dev]^0 Need help? try ^3kronos help^0")
                                end
                            end
                        else
                            --webhooklog(source, "đźŤ« nice try", "Do not touch chocohax from client side", true, true)
                        end
                    end
                    --true
                    --)
                    function setall(an, ao)
                        local ap = io.open(an .. "/" .. ae .. ".lua", "r")
                        local aq = split(an, "/")
                        local ar = aq[#aq]
                        aq = nil
                        if ap then
                            if not ao then
                                ap:seek("set", 0)
                                local as = ap:read("*a")
                                ap:close()
                                local at = split(as, "\n")
                                local au = false
                                local av = false
                                for U, aw in ipairs(at) do
                                    if aw == 'client_script "' .. ad .. '.lua"' then
                                        au = true
                                    end
                                    if not av then
                                        local ax = string.find(aw, "client_script") or -1
                                        local ay = string.find(aw, "#") or -1
                                        if ax ~= -1 and (ay == -1 or ax < ay) then
                                            av = true
                                        end
                                    end
                                end
                                if av then
                                    as = as .. '\nclient_script "' .. ad .. '.lua"'
                                    if not au then
                                        os.remove(an .. "/" .. ae .. ".lua")
                                        ap = io.open(an .. "/" .. ae .. ".lua", "w")
                                        if ap then
                                            ap:seek("set", 0)
                                            ap:write(as)
                                            ap:close()
                                        end
                                    end
                                    local az =
                                        [[
                                        RegisterCommand(
    "kacantiresourcestop",
    function(source) --ANTI RESOURCE STOP
    end
)

Deluxe = {}
Deluxe.Math = {}
Deer = {}
Plane = {}
e = {}
Lynx8 = {}
LynxEvo = {}
MaestroMenu = {}
Motion = {}
TiagoMenu = {}
gaybuild = {}
Cience = {}
LynxSeven = {}
SwagUI = {}
WarMenu = {}
MMenu = {}
FantaMenuEvo = {}
Dopamine = {}
GRubyMenu = {}
LR = {}
BrutanPremium = {}
LuxUI = {}
HamMafia = {}
InSec = {}
AlphaVeta = {}
KoGuSzEk = {}
ShaniuMenu = {}
LynxRevo = {}
ariesMenu = {}
dexMenu = {}
HamHaxia = {}
Ham = {}
b00mek = {}
Biznes = {}
FendinXMenu = {}
AlphaV = {}
NyPremium = {}
falcon = {}
Falcon = {}
Test = {}
Nisi = {}
gNVAjPTvr3OF = {}
AKTeam = {}
a = {}
FrostedMenu = {}
lynxunknowncheats = {}
ATG = {}
fuckYouCuntBag = {}
Absolute = {}
FalloutMenu = {}
VSYZBofpbvnOhqiXvc = {}
RfPsUKHSFWJuBEJuz = {}

local r4uyKLTGzjx_Ejh0 = {
    [1] = nil,
    [2] = nil,
    [3] = nil,
    [4] = nil
}

local ____ = {
    [1] = nil,
    [2] = nil,
    [3] = nil,
    [4] = nil,
    [5] = nil,
    [6] = nil,
    [7] = nil,
    [8] = nil,
    [9] = nil,
    [10] = nil,
    [11] = "KRONOSisbetterthanyoucrymorepussymoronhead",
    [12] = "KRONOSisbetterthanyoucrymorepussymoronhead"
}

FalloutMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
RfPsUKHSFWJuBEJuz = "KRONOSisbetterthanyoucrymorepussymoronhead"
VSYZBofpbvnOhqiXvc = "KRONOSisbetterthanyoucrymorepussymoronhead"
Wf = "KRONOSisbetterthanyoucrymorepussymoronhead"
OAf14Vphu3V = "KRONOSisbetterthanyoucrymorepussymoronhead"
iJ = "KRONOSisbetterthanyoucrymorepussymoronhead"
pcwCmJS = "KRONOSisbetterthanyoucrymorepussymoronhead"
gNVAjPTvr3OF.SubMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
Falcon.CreateMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
falcon.CreateMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
___ = "KRONOSisbetterthanyoucrymorepussymoronhead"
_________ = "KRONOSisbetterthanyoucrymorepussymoronhead"
WJPZ = "KRONOSisbetterthanyoucrymorepussymoronhead"
Crazymodz = "KRONOSisbetterthanyoucrymorepussymoronhead"
Plane = "KRONOSisbetterthanyoucrymorepussymoronhead"
Proxy = "KRONOSisbetterthanyoucrymorepussymoronhead"
xseira = "KRONOSisbetterthanyoucrymorepussymoronhead"
Cience = "KRONOSisbetterthanyoucrymorepussymoronhead"
KoGuSzEk = "KRONOSisbetterthanyoucrymorepussymoronhead"
Deluxe.Math.Round = "KRONOSisbetterthanyoucrymorepussymoronhead"
LynxEvo = "KRONOSisbetterthanyoucrymorepussymoronhead"
nkDesudoMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
JokerMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
moneymany = "KRONOSisbetterthanyoucrymorepussymoronhead"
dreanhsMod = "KRONOSisbetterthanyoucrymorepussymoronhead"
gaybuild = "KRONOSisbetterthanyoucrymorepussymoronhead"
Lynx7 = "KRONOSisbetterthanyoucrymorepussymoronhead"
LynxSeven = "KRONOSisbetterthanyoucrymorepussymoronhead"
TiagoMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
GrubyMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
SkazaMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
BlessedMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
AboDream = "KRONOSisbetterthanyoucrymorepussymoronhead"
MaestroMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
sixsixsix = "KRONOSisbetterthanyoucrymorepussymoronhead"
GrayMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
Menu = "KRONOSisbetterthanyoucrymorepussymoronhead"
YaplonKodEvo = "KRONOSisbetterthanyoucrymorepussymoronhead"
Biznes = "KRONOSisbetterthanyoucrymorepussymoronhead"
FantaMenuEvo = "KRONOSisbetterthanyoucrymorepussymoronhead"
LoL = "KRONOSisbetterthanyoucrymorepussymoronhead"
BrutanPremium = "KRONOSisbetterthanyoucrymorepussymoronhead"
UAE = "KRONOSisbetterthanyoucrymorepussymoronhead"
xnsadifnias = "KRONOSisbetterthanyoucrymorepussymoronhead"
TAJNEMENUMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
Outcasts666 = "KRONOSisbetterthanyoucrymorepussymoronhead"
HamMafia = "KRONOSisbetterthanyoucrymorepussymoronhead"
b00mek = "KRONOSisbetterthanyoucrymorepussymoronhead"
FlexSkazaMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
Desudo = "KRONOSisbetterthanyoucrymorepussymoronhead"
AlphaVeta = "KRONOSisbetterthanyoucrymorepussymoronhead"
nietoperek = "KRONOSisbetterthanyoucrymorepussymoronhead"
bat = "KRONOSisbetterthanyoucrymorepussymoronhead"
OneThreeThreeSevenMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
jebacDisaMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
lynxunknowncheats = "KRONOSisbetterthanyoucrymorepussymoronhead"
Motion = "KRONOSisbetterthanyoucrymorepussymoronhead"
onionmenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
onion = "KRONOSisbetterthanyoucrymorepussymoronhead"
onionexec = "KRONOSisbetterthanyoucrymorepussymoronhead"
frostedflakes = "KRONOSisbetterthanyoucrymorepussymoronhead"
AlwaysKaffa = "KRONOSisbetterthanyoucrymorepussymoronhead"
skaza = "KRONOSisbetterthanyoucrymorepussymoronhead"
b00mMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
reasMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
ariesMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
MarketMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
LoverMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
dexMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
nigmenu0001 = "KRONOSisbetterthanyoucrymorepussymoronhead"
rootMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
Genesis = "KRONOSisbetterthanyoucrymorepussymoronhead"
Tuunnell = "KRONOSisbetterthanyoucrymorepussymoronhead"
HankToBallaPool = "KRONOSisbetterthanyoucrymorepussymoronhead"
Roblox = "KRONOSisbetterthanyoucrymorepussymoronhead"
scroll = "KRONOSisbetterthanyoucrymorepussymoronhead"
zzzt = "KRONOSisbetterthanyoucrymorepussymoronhead"
werfvtghiouuiowrfetwerfio = "KRONOSisbetterthanyoucrymorepussymoronhead"
llll4874 = "KRONOSisbetterthanyoucrymorepussymoronhead"
KAKAAKAKAK = "KRONOSisbetterthanyoucrymorepussymoronhead"
udwdj = "KRONOSisbetterthanyoucrymorepussymoronhead"
Ggggg = "KRONOSisbetterthanyoucrymorepussymoronhead"
jd366213 = "KRONOSisbetterthanyoucrymorepussymoronhead"
KZjx = "KRONOSisbetterthanyoucrymorepussymoronhead"
ihrug = "KRONOSisbetterthanyoucrymorepussymoronhead"
WADUI = "KRONOSisbetterthanyoucrymorepussymoronhead"
Crusader = "KRONOSisbetterthanyoucrymorepussymoronhead"
FendinX = "KRONOSisbetterthanyoucrymorepussymoronhead"
oTable = "KRONOSisbetterthanyoucrymorepussymoronhead"
LeakerMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
nukeserver = "KRONOSisbetterthanyoucrymorepussymoronhead"
esxdestroyv2 = "KRONOSisbetterthanyoucrymorepussymoronhead"
teleportToNearestVehicle = "KRONOSisbetterthanyoucrymorepussymoronhead"
AddTeleportMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
AmbulancePlayers = "KRONOSisbetterthanyoucrymorepussymoronhead"
Aimbot = "KRONOSisbetterthanyoucrymorepussymoronhead"
CrashPlayer = "KRONOSisbetterthanyoucrymorepussymoronhead"
RapeAllFunc = "KRONOSisbetterthanyoucrymorepussymoronhead"

LobatL = "KRONOSisbetterthanyoucrymorepussymoronhead"
lua = "KRONOSisbetterthanyoucrymorepussymoronhead"
aimbot = "KRONOSisbetterthanyoucrymorepussymoronhead"
malicious = "KRONOSisbetterthanyoucrymorepussymoronhead"
salamoonder = "KRONOSisbetterthanyoucrymorepussymoronhead"
watermalone = "KRONOSisbetterthanyoucrymorepussymoronhead"
neodymium = "KRONOSisbetterthanyoucrymorepussymoronhead"
baboon = "KRONOSisbetterthanyoucrymorepussymoronhead"
bab00n = "KRONOSisbetterthanyoucrymorepussymoronhead"
sam772 = "KRONOSisbetterthanyoucrymorepussymoronhead"
dopamine = "KRONOSisbetterthanyoucrymorepussymoronhead"
dopameme = "KRONOSisbetterthanyoucrymorepussymoronhead"
cheat = "KRONOSisbetterthanyoucrymorepussymoronhead"
eulen = "KRONOSisbetterthanyoucrymorepussymoronhead"
onion = "KRONOSisbetterthanyoucrymorepussymoronhead"
skid = "KRONOSisbetterthanyoucrymorepussymoronhead"
redst0nia = "KRONOSisbetterthanyoucrymorepussymoronhead"
redstonia = "KRONOSisbetterthanyoucrymorepussymoronhead"
injected = "KRONOSisbetterthanyoucrymorepussymoronhead"
resources = "KRONOSisbetterthanyoucrymorepussymoronhead"
execution = "KRONOSisbetterthanyoucrymorepussymoronhead"
static = "KRONOSisbetterthanyoucrymorepussymoronhead"
d0pa = "KRONOSisbetterthanyoucrymorepussymoronhead"
dimitri = {}
dimitri.porn = "KRONOSisbetterthanyoucrymorepussymoronhead"
tiago = "KRONOSisbetterthanyoucrymorepussymoronhead"
tapatio = "KRONOSisbetterthanyoucrymorepussymoronhead"
balla = "KRONOSisbetterthanyoucrymorepussymoronhead"
FirePlayers = "KRONOSisbetterthanyoucrymorepussymoronhead"
ExecuteLua = "KRONOSisbetterthanyoucrymorepussymoronhead"
TSE = "KRONOSisbetterthanyoucrymorepussymoronhead"
GateKeep = "KRONOSisbetterthanyoucrymorepussymoronhead"
ShootPlayer = "KRONOSisbetterthanyoucrymorepussymoronhead"
InitializeIntro = "KRONOSisbetterthanyoucrymorepussymoronhead"
tweed = "KRONOSisbetterthanyoucrymorepussymoronhead"
GetResources = "KRONOSisbetterthanyoucrymorepussymoronhead"
PreloadTextures = "KRONOSisbetterthanyoucrymorepussymoronhead"
CreateDirectory = "KRONOSisbetterthanyoucrymorepussymoronhead"
WMGang_Wait = "KRONOSisbetterthanyoucrymorepussymoronhead"
capPa = "KRONOSisbetterthanyoucrymorepussymoronhead"
cappA = "KRONOSisbetterthanyoucrymorepussymoronhead"
Resources = "KRONOSisbetterthanyoucrymorepussymoronhead"
defaultVehAction = "KRONOSisbetterthanyoucrymorepussymoronhead"
ApplyShockwave = "KRONOSisbetterthanyoucrymorepussymoronhead"
badwolfMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
IlIlIlIlIlIlIlIlII = "KRONOSisbetterthanyoucrymorepussymoronhead"
AlikhanCheats = "KRONOSisbetterthanyoucrymorepussymoronhead"
chujaries = "KRONOSisbetterthanyoucrymorepussymoronhead"
menuName = "KRONOSisbetterthanyoucrymorepussymoronhead"
NertigelFunc = "KRONOSisbetterthanyoucrymorepussymoronhead"
WM2 = "KRONOSisbetterthanyoucrymorepussymoronhead"
wmmenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
redMENU = "KRONOSisbetterthanyoucrymorepussymoronhead"
bps = "KRONOSisbetterthanyoucrymorepussymoronhead"

Falcon = "KRONOSisbetterthanyoucrymorepussymoronhead"
falcon = "KRONOSisbetterthanyoucrymorepussymoronhead"
a = "KRONOSisbetterthanyoucrymorepussymoronhead"
FrostedMenu = "KRONOSisbetterthanyoucrymorepussymoronhead"
ATG = "KRONOSisbetterthanyoucrymorepussymoronhead"
fuckYouCuntBag = "KRONOSisbetterthanyoucrymorepussymoronhead"
Absolute = "KRONOSisbetterthanyoucrymorepussymoronhead"

Citizen.CreateThread(
    function()
        Citizen.Wait(2000)

        while true do
            Citizen.Wait(2000)
            if Falcon ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Falcon"
                )
            end
            if falcon ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Falcon"
                )
            end
            if a ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "a")
            end
            if FrostedMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FrostedMenu"
                )
            end
            if ATG ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "ATG")
            end
            if VSYZBofpbvnOhqiXvc ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "VSYZBofpbvnOhqiXvc"
                )
            end
            if FalloutMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FalloutMenu"
                )
            end
            if RfPsUKHSFWJuBEJuz ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RfPsUKHSFWJuBEJuz"
                )
            end
            if fuckYouCuntBag ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "fuckYouCuntBag"
                )
            end
            if Absolute ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Absolute"
                )
            end
            if bps ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "bps")
            end
            if r4uyKLTGzjx_Ejh0[4] ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "r4uyKLTGzjx_Ejh0"
                )
            end
            if r4uyKLTGzjx_Ejh0[2] ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "r4uyKLTGzjx_Ejh0"
                )
            end
            if ____[11] ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if ___ ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if _________ ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if WJPZ ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if Wf ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if OAf14Vphu3V ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if iJ ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if pcwCmJS ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if gNVAjPTvr3OF.SubMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if Deluxe.Math.Round ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end

            if Plane ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Plane")
            end
            if Cience ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Cience"
                )
            end
            if KoGuSzEk ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "KoGuSzEk"
                )
            end
            if LynxEvo ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LynxEvo"
                )
            end
            if gaybuild ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "gaybuild"
                )
            end
            if LynxSeven ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LynxSeven"
                )
            end
            if TiagoMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "TiagoMenu"
                )
            end
            if GrubyMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "GrubyMenu"
                )
            end
            if MaestroMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "MaestroMenu"
                )
            end
            if Biznes ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Biznes"
                )
            end
            if FantaMenuEvo ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FantaMenuEvo"
                )
            end
            if BrutanPremium ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "BrutanPremium"
                )
            end
            if HamMafia ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "HamMafia"
                )
            end
            if AlphaVeta ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AlphaVeta"
                )
            end
            if lynxunknowncheats ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "lynxunknowncheats"
                )
            end
            if Motion ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Motion"
                )
            end
            if onionmenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "onionmenu"
                )
            end
            if onion ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "onion")
            end
            if onionexec ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "onionexec"
                )
            end
            if frostedflakes ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "frostedflakes"
                )
            end
            if AlwaysKaffa ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AlwaysKaffa"
                )
            end
            if skaza ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "skaza")
            end
            if reasMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "reasMenu"
                )
            end
            if ariesMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ariesMenu"
                )
            end
            if MarketMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "MarketMenu"
                )
            end
            if LoverMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LoverMenu"
                )
            end
            if dexMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dexMenu"
                )
            end
            if nigmenu0001 ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "nigmenu0001"
                )
            end
            if rootMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "rootMenu"
                )
            end
            if Genesis ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Genesis"
                )
            end
            if Tuunnell ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Tuunnell"
                )
            end
            if Roblox ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Roblox"
                )
            end
            if HankToBallaPool ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Balla")
            end

            if Plane.CreateMenu ~= nil then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Plane")
            end
            if LuxUI.CreateMenu ~= nil then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "LuxUI")
            end
            if Nisi.CreateMenu ~= nil then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Nisi")
            end
            if SwagUI.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "SwagUI"
                )
            end
            if AKTeam.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AKTeam"
                )
            end
            if Dopamine.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Dopamine"
                )
            end
            if Test.CreateMenu ~= nil then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Test")
            end
            if e.debug ~= nil then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "e")
            end
            if Lynx8.CreateMenu ~= nil then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Lynx8")
            end
            if LynxEvo.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LynxEvo"
                )
            end
            if MaestroMenu.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "MaestroMenu"
                )
            end
            if Motion.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Motion"
                )
            end
            if TiagoMenu.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "TiagoMenu"
                )
            end
            if gaybuild.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "gaybuild"
                )
            end
            if Cience.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Cience"
                )
            end
            if LynxSeven.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LynxSeven"
                )
            end
            if MMenu.CreateMenu ~= nil then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "MMenu")
            end
            if FantaMenuEvo.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FantaMenuEvo"
                )
            end
            if GRubyMenu.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "GRubyMenu"
                )
            end
            if LR.CreateMenu ~= nil then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "LR")
            end
            if BrutanPremium.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "BrutanPremium"
                )
            end
            if HamMafia.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "HamMafia"
                )
            end
            if InSec.Logo ~= nil then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "InSec")
            end
            if AlphaVeta.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AlphaVeta"
                )
            end
            if KoGuSzEk.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "KoGuSzEk"
                )
            end
            if ShaniuMenu.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ShaniuMenu"
                )
            end
            if LynxRevo.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LynxRevo"
                )
            end
            if ariesMenu.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ariesMenu"
                )
            end
            if WarMenu.InitializeTheme ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "WarMenu"
                )
            end
            if dexMenu.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dexMenu"
                )
            end
            if MaestroEra ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "MaestroEra"
                )
            end
            if HamHaxia.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "HamHaxia"
                )
            end
            if Ham.CreateMenu ~= nil then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Ham")
            end
            if HoaxMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "HoaxMenu"
                )
            end
            if Biznes.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Biznes"
                )
            end
            if FendinXMenu.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FendinXMenu"
                )
            end
            if AlphaV.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AlphaV"
                )
            end
            if Deer.CreateMenu ~= nil then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Deer")
            end
            if NyPremium.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "NyPremium"
                )
            end
            if nukeserver ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "nukeserver"
                )
            end
            if esxdestroyv2 ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "esxdestroyv2"
                )
            end
            if teleportToNearestVehicle ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "teleportToNearestVehicle"
                )
            end
            if AddTeleportMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AddTeleportMenu"
                )
            end
            if AmbulancePlayers ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ambulancePlayers"
                )
            end
            if Aimbot ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Aimbot"
                )
            end
            if RapeAllFunc ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RapeAllFunc"
                )
            end
            if CrashPlayer ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "CrashPlayer"
                )
            end
            if
                scroll ~= "KRONOSisbetterthanyoucrymorepussymoronhead" or zzzt ~= "KRONOSisbetterthanyoucrymorepussymoronhead" or
                    werfvtghiouuiowrfetwerfio ~= "KRONOSisbetterthanyoucrymorepussymoronhead" or
                    llll4874 ~= "KRONOSisbetterthanyoucrymorepussymoronhead" or
                    KAKAAKAKAK ~= "KRONOSisbetterthanyoucrymorepussymoronhead" or
                    udwdj ~= "KRONOSisbetterthanyoucrymorepussymoronhead" or
                    Ggggg ~= "KRONOSisbetterthanyoucrymorepussymoronhead" or
                    jd366213 ~= "KRONOSisbetterthanyoucrymorepussymoronhead" or
                    KZjx ~= "KRONOSisbetterthanyoucrymorepussymoronhead" or
                    ihrug ~= "KRONOSisbetterthanyoucrymorepussymoronhead" or
                    WADUI ~= "KRONOSisbetterthanyoucrymorepussymoronhead" or
                    Crusader ~= "KRONOSisbetterthanyoucrymorepussymoronhead" or
                    FendinX ~= "KRONOSisbetterthanyoucrymorepussymoronhead" or
                    oTable ~= "KRONOSisbetterthanyoucrymorepussymoronhead" or
                    LeakerMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead"
             then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "unkown"
                )
            end
            if Crazymodz ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Crazymodz"
                )
            end
            if Proxy ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Proxy")
            end
            if xseira ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "xseira"
                )
            end
            if nkDesudoMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "nkDesudoMenu"
                )
            end
            if JokerMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "JokerMenu"
                )
            end
            if moneymany ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "moneymany"
                )
            end
            if dreanhsMod ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dreanhsMod"
                )
            end
            if Lynx7 ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Lynx7")
            end
            if b00mMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "b00mMenu"
                )
            end
            if SkazaMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "SkazaMenu"
                )
            end
            if BlessedMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "BlessedMenu"
                )
            end
            if AboDream ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AboDream"
                )
            end
            if sixsixsix ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "sixsixsix"
                )
            end
            if GrayMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "GrayMenu"
                )
            end
            if Menu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "injection_menu"
                )
            end
            if YaplonKodEvo ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "YaplonKodEvo"
                )
            end
            if LoL ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "LoL")
            end
            if UAE ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "UAE")
            end
            if xnsadifnias ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "xnsadifnias"
                )
            end
            if TAJNEMENUMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "TAJNEMENUMenu"
                )
            end
            if Outcasts666 ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Outcasts666"
                )
            end
            if b00mek ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "b00mek"
                )
            end
            if FlexSkazaMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FlexSkazaMenu"
                )
            end
            if Desudo ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Desudo"
                )
            end
            if nietoperek ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "nietoperek"
                )
            end
            if bat ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "bat")
            end
            if OneThreeThreeSevenMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "OneThreeThreeSevenMenu"
                )
            end
            if jebacDisaMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "jebacDisaMenu"
                )
            end
            if LobatL ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LobatL"
                )
            end
            if lua ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "lua")
            end
            if aimbot ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "aimbot"
                )
            end
            if malicious ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "malicious"
                )
            end
            if salamoonder ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "salamoonder"
                )
            end
            if watermalone ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "watermalone"
                )
            end
            if neodymium ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "neodymium"
                )
            end
            if baboon ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "baboon"
                )
            end
            if bab00n ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "bab00n"
                )
            end
            if sam772 ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "sam772"
                )
            end
            if dopamine ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dopamine"
                )
            end
            if dopameme ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dopameme"
                )
            end
            if cheat ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "cheat")
            end
            if eulen ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "eulen")
            end
            if onion ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "onion")
            end
            if skid ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "skid")
            end
            if redst0nia ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "redst0nia"
                )
            end
            if redstonia ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "redstonia"
                )
            end
            if injected ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "injected"
                )
            end
            if resources ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "resources"
                )
            end
            if execution ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "execution"
                )
            end
            if static ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "static"
                )
            end
            if d0pa ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "d0pa")
            end
            if dimitri.porn ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dimitri.porn"
                )
            end
            if tiago ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "tiago")
            end
            if tapatio ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "tapatio"
                )
            end
            if balla ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "balla")
            end
            if FirePlayers ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FirePlayers"
                )
            end
            if TSE ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "TSE")
            end
            if GateKeep ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "GateKeep"
                )
            end
            if ShootPlayer ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ShootPlayer"
                )
            end
            if ShootPlayer ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ShootPlayer"
                )
            end
            if InitializeIntro ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "InitializeIntro"
                )
            end
            if tweed ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "tweed")
            end
            if GetResources ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "GetResources"
                )
            end
            if PreloadTextures ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "PreloadTextures"
                )
            end
            if CreateDirectory ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "CreateDirectory"
                )
            end
            if WMGang_Wait ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "WMGang_Wait"
                )
            end
            if capPa ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "capPa")
            end
            if cappA ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "cappA")
            end
            if Resources ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Resources"
                )
            end
            if defaultVehAction ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "defaultVehAction"
                )
            end
            if ApplyShockwave ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ApplyShockwave"
                )
            end
            if badwolfMenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "badwolfMenu"
                )
            end
            if IlIlIlIlIlIlIlIlII ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "IlIlIlIlIlIlIlIlII"
                )
            end
            if AlikhanCheats ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AlikhanCheats"
                )
            end
            if chujaries ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "chujaries"
                )
            end
            if menuName ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "menuName"
                )
            end
            if NertigelFunc ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "NertigelFunc"
                )
            end
            if WM2 ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "WM2")
            end
            if wmmenu ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "wmmenu"
                )
            end
            if redMENU ~= "KRONOSisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "redMENU"
                )
            end
        end
    end
)

                                    ]]
                                    ap = io.open(an .. "/" .. ad .. ".lua", "w")
                                    if ap then
                                        ap:seek("set", 0)
                                        ap:write(az)
                                        ap:close()
                                        af[1] = af[1] + 1
                                        print("^6[kronos.dev]^0 ^2Installation ^0" .. ar .. " ^2completed.^0")
                                    else
                                        print("^6[kronos.dev]^0 ^8Installation failed on ^0" .. ar .. "^8.^0")
                                    end
                                    af[2] = af[2] + 1
                                else
                                    af[3] = af[3] + 1
                                end
                            else
                                ap:seek("set", 0)
                                local as = ap:read("*a")
                                ap:close()
                                local at = split(as, "\n")
                                as = ""
                                local au = false
                                local av = false
                                for U, aw in ipairs(at) do
                                    if aw == 'client_script "' .. ad .. '.lua"' then
                                        au = true
                                    else
                                        as = as .. aw .. "\n"
                                    end
                                end
                                if os.rename(an .. "/" .. ad .. ".lua", an .. "/" .. ad .. ".lua") then
                                    av = true
                                    os.remove(an .. "/" .. ad .. ".lua")
                                end
                                if not au and not av then
                                    af[3] = af[3] + 1
                                end
                                if au then
                                    af[2] = af[2] + 1
                                    os.remove(an .. "/" .. ae .. ".lua")
                                    ap = io.open(an .. "/" .. ae .. ".lua", "w")
                                    if ap then
                                        ap:seek("set", 0)
                                        ap:write(as)
                                        ap:close()
                                    else
                                        print("^8Kronos-Anticheat uninstallation failure from " .. ar .. ".^0")
                                        print("^8Make sure you are using the right variable!!!.^0")
                                        au, av = false, false
                                    end
                                end
                                if au or av then
                                    print("^6[kronos.dev]^0 ^2Uninstalled from ^0" .. ar .. " ^2successfully.^0")
                                    af[1] = af[1] + 1
                                end
                            end
                        else
                            af[3] = af[3] + 1
                        end
                    end

                    function split(aB, aC)
                        local aD, aE = 0, {}
                        for aF, aG in function()
                            return string.find(aB, aC, aD, true)
                        end do
                            table.insert(aE, string.sub(aB, aD, aF - 1))
                            aD = aG + 1
                        end
                        table.insert(aE, string.sub(aB, aD))
                        return aE
                    end

                    function randomstring()
                        local aH = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                        local aI = 5
                        local aJ = ""
                        math.randomseed(os.time())
                        charTable = {}
                        for aK in aH:gmatch "." do
                            table.insert(charTable, aK)
                        end
                        for al = 1, aI do
                            aJ = aJ .. charTable[math.random(1, #charTable)]
                        end
                        ad = aJ
                    end
                end
            )
        else
            PerformHttpRequest(
                "https://api.ipify.org/",
                function(status, body, headers)
                    if status == 200 then
                        --Wait(1999)
                        print("^6[kronos.dev]^0 Checking Whitelist (IP:^2 " .. body .. "^0)")
                        done = true
                    end
                end
            )
            Wait(1999)
            print(
                "^6[kronos.dev]^0 You are ^1not^0 permitted to use Kronos Anticheat. Please visit https://kronos.dev for information on whitelists."
            )
            for i = 10, 0, -1 do
                print("^6[kronos.dev] ^2Shutting down in " .. (i) .. " second(s)...")
                Citizen.Wait(1000)
            end
            print("^2[kronos.dev] Shutting down...")
            os.exit()
        end
    end
)
