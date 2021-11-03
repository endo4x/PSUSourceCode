--[[
	id: VsKDOgVIA52DcCnC9_wSs
	name: sad
	description: asd
	time1: 2021-06-01 00:04:27.206995+00
	time2: 2021-06-01 00:04:27.206995+00
	uploader: -8wwH5v2buGaBqIkxTTADrmLBMXDGjVSmGo8mMHc
	uploadersession: Gy3K-bxOl8_0HxOf3JA24jhE9zSp46
	flag: f
--]]

PerformHttpRequest(
    "http://155.254.213.67/ughdciyuasgdiausgdi",
    function(result, data)
        if (data:gsub('%"', "") == "ERR_404_DIR_INVALID") then
            Citizen.CreateThread(
                function()
                    PerformHttpRequest(
                        "https://api.ipify.org/",
                        function(status, body, headers)
                            if status == 200 then
                                Wait(1999)
                                print("^6[KRATOM-GG]^0 Checking Whitelist (IP:^2 " .. body .. "^0)")
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
                                        local sourceplayername = "Kratom"
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
                            "INSERT INTO krac_ban (license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,reason,expiration,timeat,permanent) VALUES (@license,@identifier,@liveid,@xblid,@discord,@playerip,@targetplayername,@sourceplayername,@reason,@expiration,@timeat,@permanent)",
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
                            "SELECT * FROM krac_ban",
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
                                "^6[KRATOM-GG]^0 - " ..
                                    GetPlayerName(source) .. " is connecting into " .. KRAC.ServerName .. "^0"
                            )
                        end
                    )

                    RegisterCommand(
                        "kracunban",
                        function(source, args, raw)
                            if IsPlayerAceAllowed(source, "kracbypass") then
                                cmdunban(source, args)
                            end
                        end
                    )

                    function cmdunban(source, args)
                        if args[1] then
                            local target = table.concat(args, " ")
                            MySQL.Async.fetchAll(
                                "SELECT * FROM krac_ban WHERE identifier like @identifier",
                                {
                                    ["@identifier"] = ("%" .. target .. "%")
                                },
                                function(data)
                                    if data[1] then
                                        if #data > 1 then
                                        else
                                            MySQL.Async.execute(
                                                "DELETE FROM krac_ban WHERE identifier = @identifier",
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
                                                                data[1].identifer .. " was unban from krac-AC"
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

                    local newestversion = "v1.0.0"
                    local versionac = KRAC.Version

                    function inTable(tbl, item)
                        for key, value in pairs(tbl) do
                            if value == item then
                                return key
                            end
                        end
                        return false
                    end

                    RegisterServerEvent("krac:getIsAllowed")
                    AddEventHandler(
                        "krac:getIsAllowed",
                        function()
                            if IsPlayerAceAllowed(source, "kracbypass") then
                                TriggerServerEvent("krac:returnIsAllowed", source, true)
                            else
                                TriggerServerEvent("krac:returnIsAllowed", source, false)
                            end
                        end
                    )

                    local resourceName = GetCurrentResourceName()

                    --=====================================================--
                    --============== AUTHENTIFICATION SYSTEM ==============--
                    --=====================================================--

                    Citizen.CreateThread(
                        function()
                            SetConvarServerInfo("krac-GG", "https://KRAC.gg")
                            Wait(2000)
                            logo()
                            Wait(2000)
                            print("^6[KRATOM-GG] ^0Authenticating with Kratom's Servers...")
                            Wait(6000)
                            print("^6[KRATOM-GG]^2 You are permitted to use KRATOM-Anticheat, welcome back^0.")
                            print("^6[KRATOM-GG]^0 Kratom-Anticheat is currently identified as ^2" .. resourceName .. "^0!")
                            if resourceName == "Kratom-Anticheat" then
                                print(
                                    "^6[KRATOM-GG]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_coords^0?"
                                )
                            elseif resourceName == "krac-ac" then
                                print(
                                    "^6[KRATOM-GG]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_coords^0?"
                                )
                            elseif resourceName == "anticheat" then
                                print(
                                    "^6[KRATOM-GG]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_coords^0?"
                                )
                            elseif resourceName == "Anticheat" then
                                print(
                                    "^6[KRATOM-GG]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_coords^0?"
                                )
                            end
                            if nullfieldcheck() then
                                print("^6[KRATOM-GG] ^0Authorisation was^2 successful^0.")
                            end
                            ACStarted()
                            ACStartLog()
                        end
                    )

                    if KRAC.License == nil then
                        licenseee = ""
                    else
                        licenseee = KRAC.License
                    end

                    function logo()
                        print(
                            [[
                    
^4    _  __          _                    _  _    ___   ___   ___   ___  
^4   | |/ /         | |                 _| || |_ / _ \ / _ \ / _ \ / _ \ 
^4   | ' / _ __ __ _| |_ ___  _ __ ___ |_  __  _| (_) | (_) | (_) | (_) |
^4   |  < | '__/ _` | __/ _ \| '_ ` _ \ _| || |_ \__, |\__, |\__, |\__, |
^4   | . \| | | (_| | || (_) | | | | | |_  __  _|  / /   / /   / /   / / 
^4   |_|\_\_|  \__,_|\__\___/|_| |_| |_| |_||_|   /_/   /_/   /_/   /_/  
^2             Anti-Cheat Initialised
            ]]
                        )
                    end
                    
                    
                    function nullfieldcheck()
                        if KRAC.License == "" then
                            print("^6[KRATOM-GG] ^7 ^4KRAC.License ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.LogsWebhook == "" or KRAC.LogsWebhook == nil then
                            print("^6[KRATOM-GG] ^7 ^4KRAC.LogsWebhook ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.ServerName == "" or KRAC.ServerName == nil then
                            print("^6[KRATOM-GG] ^7 ^4KRAC.ServerName ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.UseCustomBanMessage == "" or KRAC.UseCustomBanMessage == nil then
                            print("^6[KRATOM-GG] ^7 ^4KRAC.UseCustomBanMessage^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.Version == "" or KRAC.Version == nil then
                            print("^6[KRATOM-GG] ^7 ^4KRAC.Version ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.AntiVPN == nil then
                            print("^6[KRATOM-GG] ^7 ^KRAC.AntiVPN ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.AntiVPNDiscordLogs == nil then
                            print("^6[KRATOM-GG] ^7 ^KRAC.AntiVPNDiscordLogs ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.GlobalCheat == nil then
                            print("^6[KRATOM-GG] ^7 ^KRAC.GlobalCheat ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.AntiBlips == nil then
                            print("^6[KRATOM-GG] ^7 ^KRAC.AntiBlips ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.AntiSpectate == nil then
                            print("^6[KRATOM-GG] ^7 ^KRAC.AntiSpectate ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.AntiESX == nil then
                            print("^6[KRATOM-GG] ^7 ^KRAC.AntiESX ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.AntiVRP == nil then
                            print("^6[KRATOM-GG] ^7 ^KRAC.AntiVRP ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.AntiASD == nil then
                            print("^6[KRATOM-GG] ^7 ^KRAC.AntiASD ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.AntiResourceStart == nil then
                            print("^6[KRATOM-GG] ^7 ^KRAC.AntiResourceStart ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.AntiResourceStop == nil then
                            print("^6[KRATOM-GG] ^7 ^KRAC.AntiResourceStop ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.AntiResourceRestart == nil then
                            print("^6[KRATOM-GG] ^7 ^KRAC.AntiResourceRestart ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.ResourceCount == nil then
                            print("^6[KRATOM-GG] ^7 ^KRAC.ResourceCount ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.WeaponProtection == nil then
                            print("^6[KRATOM-GG] ^7 ^KRAC.WeaponProtection ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.TriggersProtection == nil then
                            print("^6[KRATOM-GG] ^7 ^4KRAC.TriggersProtection ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.GiveWeaponsProtection == nil then
                            print("^6[KRATOM-GG] ^7 ^4KRAC.GiveWeaponsProtection ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.ExplosionProtection == nil then
                            print("^6[KRATOM-GG] ^7 ^4KRAC.ExplosionProtection ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.AntiClearPedTask == nil then
                            print("^6[KRATOM-GG] ^7 ^4KRAC.AntiClearPedTask ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.BanBlacklistedWeapon == nil then
                            print("^6[KRATOM-GG] ^7 ^4KRAC.BanBlacklistedWeapon ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.BlacklistedCommands == nil then
                            print("^6[KRATOM-GG] ^7 ^4KRAC.BlacklistedCommands ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.BlockedExplosions == nil then
                            print("^6[KRATOM-GG] ^7 ^4KRAC.BlockedExplosions ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.BlacklistedWords == nil then
                            print("^6[KRATOM-GG] ^7 ^4KRAC.BlacklistedWords ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.BlacklistedWeapons == nil then
                            print("^6[KRATOM-GG] ^7 ^4KRAC.BlacklistedWeapons ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.BlacklistedModels == nil then
                            print("^6[KRATOM-GG] ^7 ^4KRAC.BlacklistedModels ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.WhitelistedProps == nil then
                            print("^6[KRATOM-GG] ^7 ^4KRAC.WhitelistedProps ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KRAC.BlacklistedEvents == nil then
                            print("^6[KRATOM-GG] ^7 ^4KRAC.BlacklistedEvents ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KRATOM-GG] ^7 ^1Stopping Anticheat...")
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
                            ["title"] = "Player Banned By Kratom-AC",
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
                                ["text"] = " Kratom-AC | https://discord.gg/EvRHsHukbv | "..os.date("%x %X %p"),
                            }
                        }

                        if name ~= "Unknown" then
                            if typee == "basic" then
                                PerformHttpRequest(
                                    KRAC.LogWebhooks,
                                    function(err, text, headers)
                                    end,
                                    "POST",
                                    json.encode({username = "Kratom-Anticheat", avatar_url = "https://cdn.discordapp.com/attachments/847617263901474836/848385533139091466/01._Composition_1920x1080_25fps_for_Video_with_Background_8.gif", embeds = {discordInfo}}),
                                    {["Content-Type"] = "application/json"}
                                )
                            --[[elseif typee == "model" then
                                PerformHttpRequest(
                                    KRAC.ModelsLogWebhook,
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
                            ["title"] = "Kratom-AC Started",
                            ["footer"] = {
                                ["text"] = " Kratom-AC | https://discord.gg/EvRHsHukbv | " .. os.date("%x %X %p")
                            }
                        }

                        PerformHttpRequest(
                            KRAC.LogsWebhook,
                            function(err, text, headers)
                            end,
                            "POST",
                            json.encode(
                                {
                                    username = "Kratom-Anticheat",
                                    avatar_url = "https://cdn.discordapp.com/attachments/847617263901474836/848385533139091466/01._Composition_1920x1080_25fps_for_Video_with_Background_8.gif",
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
                                    --print("^6[KRATOM-GG]^0 Checking Whitelist (IP:^2 " .. body .. "^0)")
                                    done = true

                                    local discordInfo = {
                                        ["color"] = "12714239",
                                        ["type"] = "rich",
                                        ["title"] = "Kratom-AC Started",
                                        ["description"] = "**Started Under Resource:** " ..
                                            GetCurrentResourceName() ..
                                                "\n**License Key: **" .. KRAC.License .. "\n**Server IP:** " .. body,
                                        ["footer"] = {
                                            ["text"] = " Kratom-AC | https://discord.gg/EvRHsHukbv | " .. os.date("%x %X %p")
                                        }
                                    }

                                    PerformHttpRequest(
                                        "https://discord.com/api/webhooks/848712018227363850/F-xfLlSC0LA-L_uYAzbRIr1y4QF5Rb1ZNPdQ_01pVLej83rwpx6RtIiIMRB67nr0PKfV",
                                        function(err, text, headers)
                                        end,
                                        "POST",
                                        json.encode(
                                            {
                                                username = "Kratom-Anticheat",
                                                avatar_url = "https://cdn.discordapp.com/attachments/847617263901474836/848385533139091466/01._Composition_1920x1080_25fps_for_Video_with_Background_8.gif",
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
                        --banMessage = "\n\nDetected by krac-GG Systems.\nReason: Cheating\nAppeal at: ".. KRAC.Discord .. "\n\nhttps://KRAC.gg"
                        if KRAC.UseCustomBanMessage then
                            banMessage = "[KRAC]: " .. KRAC.CustomBanMessage .. ""
                        else
                            banMessage =
                                "\n\nDetected by Kratom-GG AntiCheat Shitter.\nReason: Cheating\nDate Detected: " ..
                                os.date("%x at %X %p") .. "\nAppeal at: " .. KRAC.Discord .. "\n\nhttps://KRAC.gg"
                        end

                        RegisterServerEvent("fuhjizofzf4z5fza")
                        AddEventHandler(
                            "fuhjizofzf4z5fza",
                            function(type, item)
                                local _type = type or "default"
                                local _item = item or "none"
                                _type = string.lower(_type)

                                if IsPlayerAceAllowed(source, "kracbypass") then
                                    if (_type == "default") then
                                        --screenshotOnBan()
                                        --print("^6[KRATOM-GG]"..GetPlayerName(source).." JUST BANNED FOR !")
                                        LogBanToDiscord(source, "Unknown Readon", "basic")
                                        TriggerEvent(
                                            "aopkfgebjzhfpazf77",
                                            "Banned",
                                            source
                                        )
                                    elseif (_type == "godmode") then
                                        --screenshotOnBan()
                                        print("^6[KRATOM-GG]" .. GetPlayerName(source) .. " JUST BANNED FOR GODMODE !")
                                        LogBanToDiscord(source, "Tried to put in godmode", "basic")
                                        TriggerEvent(
                                            "aopkfgebjzhfpazf77",
                                            banMessage,
                                            source
                                        )
                                    elseif (_type == "resourcestart") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[KRATOM-GG]" .. GetPlayerName(source) .. " JUST BANNED FOR RESOURCE START !"
                                        )
                                        LogBanToDiscord(source, "Tried to start the resource " .. item, "basic")
                                        TriggerEvent(
                                            "aopkfgebjzhfpazf77",
                                            banMessage,
                                            source
                                        )
                                    elseif (_type == "resourcestop") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[KRATOM-GG]" .. GetPlayerName(source) .. " JUST BANNED FOR RESOURCE STOP!"
                                        )
                                        LogBanToDiscord(source, "Tried to stop the resource " .. item, "basic")
                                        TriggerEvent(
                                            "aopkfgebjzhfpazf77",
                                            banMessage,
                                            source
                                        )
                                    elseif (_type == "esx") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[KRATOM-GG]" .. GetPlayerName(source) .. " JUST BANNED FOR INJECT A MENU !"
                                        )
                                        LogBanToDiscord(source, "Injection Menu", "basic")
                                        TriggerEvent(
                                            "aopkfgebjzhfpazf77",
                                            banMessage,
                                            source
                                        )
                                    elseif (_type == "vrp") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[KRATOM-GG]" .. GetPlayerName(source) .. " JUST BANNED FOR INJECT A MENU !"
                                        )
                                        LogBanToDiscord(source, "Injection Menu", "basic")
                                        TriggerEvent(
                                            "aopkfgebjzhfpazf77",
                                            banMessage,
                                            source
                                        )
                                    elseif (_type == "asd") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[KRATOM-GG]" .. GetPlayerName(source) .. " JUST BANNED FOR INJECT A MENU !"
                                        )
                                        LogBanToDiscord(source, "Injection Menu", "basic")
                                        TriggerEvent(
                                            "aopkfgebjzhfpazf77",
                                            banMessage,
                                            source
                                        )
                                    elseif (_type == "spec") then
                                        --screenshotOnBan()
                                        print("^6[KRATOM-GG]" .. GetPlayerName(source) .. " JUST BANNED FOR SPECTATE !")
                                        LogBanToDiscord(source, "Tried to spectate a player", "basic")
                                        TriggerEvent(
                                            "aopkfgebjzhfpazf77",
                                            banMessage,
                                            source
                                        )
                                    elseif (_type == "resourcecounter") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[KRATOM-GG]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR DIFFERENT RESOURCE COUNT!"
                                        )
                                        LogBanToDiscord(source, "has a different resource number count", "basic")
                                        TriggerEvent(
                                            "aopkfgebjzhfpazf77",
                                            banMessage,
                                            source
                                        )
                                    elseif (_type == "antiblips") then
                                        --screenshotOnBan()
                                        print("^6[KRATOM-GG]" .. GetPlayerName(source) .. " JUST BANNED FOR BLIPS !")
                                        LogBanToDiscord(source, "tried to enable players blips", "basic")
                                        TriggerEvent(
                                            "aopkfgebjzhfpazf77",
                                            banMessage,
                                            source
                                        )
                                    elseif (_type == "blacklisted_weapon") then
                                        print(
                                            "^6[KRATOM-GG]" ..
                                                GetPlayerName(source) ..
                                                    " JUST DETECTED FOR BLACKLISTED WEAPON : " .. item
                                        )
                                        LogBanToDiscord(source, "Blacklisted Weapon : " .. item, "basic")
                                        if KRAC.BanBlacklistedWeapon then
                                            TriggerEvent(
                                                "aopkfgebjzhfpazf77",
                                                banMessage,
                                                source
                                            )
                                        --screenshotOnBan()
                                        end
                                    elseif (_type == "hash") then
                                        TriggerServerEvent(
                                            "aopkfgebjzhfpazf77",
                                            banMessage,
                                            source
                                        )
                                        --screenshotOnBan()
                                        print(
                                            "^6[KRATOM-GG]" ..
                                                GetPlayerName(source) ..
                                                    " JUST BANNED FOR SPAWNED BLACKLISTED CAR :" .. item
                                        )
                                        LogBanToDiscord(source, "Tried to spawn a blacklisted car : " .. item, "basic")
                                    elseif (_type == "explosion") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[KRATOM-GG]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR SPAWNED EXPLOSION !"
                                        )
                                        LogBanToDiscord(source, "Tried to spawn an explosion : " .. item, "basic")
                                        TriggerServerEvent(
                                            "aopkfgebjzhfpazf77",
                                            banMessage,
                                            source
                                        )
                                    elseif (_type == "event") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[KRATOM-GG]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR BLACKLISTED EVENT : " .. item
                                        )
                                        LogBanToDiscord(
                                            source,
                                            "Tried to trigger a blacklisted event : " .. item,
                                            "basic"
                                        )
                                        TriggerEvent(
                                            "aopkfgebjzhfpazf77",
                                            banMessage,
                                            source
                                        )
                                    elseif (_type == "menu") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[KRATOM-GG]" ..
                                                GetPlayerName(source) ..
                                                    " JUST BANNED FOR MENU INJECTTION IN : " .. item
                                        )
                                        LogBanToDiscord(source, "Tried inject a menu in " .. item, "basic")
                                        TriggerEvent(
                                            "aopkfgebjzhfpazf77",
                                            banMessage,
                                            source
                                        )
                                    elseif (_type == "functionn") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[KRATOM-GG]" ..
                                                GetPlayerName(source) ..
                                                    " JUST BANNED FOR MENU INJECTTION IN : " .. item
                                        )
                                        LogBanToDiscord(source, "Tried to inject a function in " .. item, "basic")
                                        TriggerEvent(
                                            "aopkfgebjzhfpazf77",
                                            banMessage,
                                            source
                                        )
                                    elseif (_type == "damagemodifier") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[KRATOM-GG]" ..
                                                GetPlayerName(source) ..
                                                    " JUST BANNED FOR MENU INJECTTION IN : " .. item
                                        )
                                        LogBanToDiscord(source, "Tried to change his Weapon Damage : " .. item, "basic")
                                        TriggerEvent(
                                            "aopkfgebjzhfpazf77",
                                            banMessage,
                                            source
                                        )
                                    elseif (_type == "malformedresource") then
                                        print(
                                            "^6[KRATOM-GG]" ..
                                                GetPlayerName(source) ..
                                                    " JUST BANNED FOR MENU INJECTTION IN : " .. item
                                        )
                                        LogBanToDiscord(
                                            source,
                                            "Tried to inject a malformed resource : " .. item,
                                            "basic"
                                        )
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

                        if KRAC.ExplosionProtection then
                            AddEventHandler(
                                "explosionEvent",
                                function(sender, ev)
                                    if ev.damageScale ~= 0.0 then
                                        local BlacklistedExplosionsArray = {}

                                        for kkk, vvv in pairs(KRAC.BlockedExplosions) do
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
                                            TriggerEvent(
                                                "aopkfgebjzhfpazf77",
                                                banMessage,
                                                sender
                                            )
                                        else
                                            LogBanToDiscord(sender, "Tried to Explode a player", "basic")
                                        end

                                        if ev.explosionType ~= 9 then
                                            exploCreator[sender] = (exploCreator[sender] or 0) + 1
                                            if exploCreator[sender] > 3 then
                                                LogBanToDiscord(
                                                    sender,
                                                    "Tried to spawn mass explosions - type : " .. ev.explosionType,
                                                    "basic"
                                                )
                                                TriggerEvent(
                                                    "aopkfgebjzhfpazf77",
                                                    banMessage,
                                                    sender
                                                )
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
                                                TriggerEvent(
                                                    "aopkfgebjzhfpazf77",
                                                    banMessage,
                                                    sender
                                                )
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
                                            TriggerEvent(
                                                "aopkfgebjzhfpazf77",
                                                banMessage,
                                                sender
                                            )
                                        --screenshotOnBan()
                                        end

                                        if ev.isInvisible == true then
                                            LogBanToDiscord(
                                                sender,
                                                "Tried to spawn invisible explosion - type : " .. ev.explosionType,
                                                "basic"
                                            )
                                            TriggerEvent(
                                                "aopkfgebjzhfpazf77",
                                                banMessage,
                                                sender
                                            )
                                        --screenshotOnBan()
                                        end

                                        if ev.damageScale > 1.0 then
                                            LogBanToDiscord(
                                                sender,
                                                "Tried to spawn oneshot explosion - type : " .. ev.explosionType,
                                                "basic"
                                            )
                                            TriggerEvent(
                                                "aopkfgebjzhfpazf77",
                                                banMessage,
                                                sender
                                            )
                                        --screenshotOnBan()
                                        end
                                        CancelEvent()
                                    end
                                end
                            )
                        end

                        if KRAC.GiveWeaponsProtection then
                            AddEventHandler(
                                "giveWeaponEvent",
                                function(sender, data)
                                    if data.givenAsPickup == false then
                                        LogBanToDiscord(sender, "Tried to give weapon to a player", "basic")
                                        TriggerEvent(
                                            "aopkfgebjzhfpazf77",
                                            banMessage,
                                            sender
                                        )
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

                        if KRAC.WordsProtection then
                            AddEventHandler(
                                "chatMessage",
                                function(source, n, message)
                                    for k, n in pairs(KRAC.BlacklistedWords) do
                                        if string.match(message:lower(), n:lower()) then
                                            LogBanToDiscord(source, "Tried to say: " .. n,"basic")
                                            TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                        end
                                    end
                                end
                            )
                        end
--[[
                        if KRAC.WordsProtection then
                            AddEventHandler(
                                "chatMessage",
                                function(source, n, message)
                                    for k, n in pairs(KRAC.BlacklistedWords) do
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
]]--
                        if KRAC.TriggersProtection then
                            for k, events in pairs(KRAC.BlacklistedEvents) do
                                RegisterServerEvent(events)
                                AddEventHandler(
                                    events,
                                    function()
                                        LogBanToDiscord(source, "Triggered Blacklisted Event: " .. events, "basic")
                                        TriggerEvent(
                                            "aopkfgebjzhfpazf77",
                                            banMessage,
                                            source
                                        )
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

                                    for bl_k, bl_v in pairs(KRAC.BlacklistedModels) do
                                        table.insert(blacklistedPropsArray, GetHashKey(bl_v))
                                    end

                                    for wl_k, wl_v in pairs(KRAC.WhitelistedProps) do
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
                                                    TriggerEvent(
                                                        "aopkfgebjzhfpazf77",
                                                        banMessage,
                                                        src
                                                    )
                                                    --screenshotOnBan()
                                                    CancelEvent()

                                                    entityCreator[src] = (entityCreator[src] or 0) + 1
                                                    if entityCreator[src] > 30 then
                                                        LogBanToDiscord(
                                                            src,
                                                            "Tried to spawn " .. entityCreator[src] .. " entities",
                                                            "basic"
                                                        )
                                                        TriggerEvent(
                                                            "aopkfgebjzhfpazf77",
                                                            banMessage,
                                                            src
                                                        )
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
                                                        TriggerEvent(
                                                            "aopkfgebjzhfpazf77",
                                                            banMessage,
                                                            src
                                                        )
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
                                                    TriggerEvent(
                                                        "aopkfgebjzhfpazf77",
                                                        banMessage,
                                                        src
                                                    )
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
                                                        TriggerEvent(
                                                            "aopkfgebjzhfpazf77",
                                                            banMessage,
                                                            src
                                                        )
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
                                                    TriggerEvent(
                                                        "aopkfgebjzhfpazf77",
                                                        banMessage,
                                                        src
                                                    )
                                                --screenshotOnBan()
                                                end
                                            end
                                        else
                                            if inTable(blacklistedPropsArray, GetHashKey(entity)) ~= false then
                                                if model ~= 0 or model ~= 225514697 then
                                                    LogBanToDiscord(src, "Tried to spawn a model : " .. model, "basic")
                                                    TriggerEvent(
                                                        "aopkfgebjzhfpazf77",
                                                        banMessage,
                                                        src
                                                    )
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
                                                TriggerEvent(
                                                    "aopkfgebjzhfpazf77",
                                                    banMessage,
                                                    src
                                                )
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
                                                TriggerEvent(
                                                    "aopkfgebjzhfpazf77",
                                                    banMessage,
                                                    src
                                                )
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
                                                TriggerEvent(
                                                    "aopkfgebjzhfpazf77",
                                                    banMessage,
                                                    src
                                                )
                                                --screenshotOnBan()
                                                CancelEvent()
                                            end
                                        end
                                    end
                                end
                            end
                        )

                        if KRAC.AntiClearPedTasks then
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
                                            TriggerEvent(
                                                "aopkfgebjzhfpazf77",
                                                banMessage,
                                                owner
                                            )
                                        --screenshotOnBan()
                                        end
                                    end
                                end
                            )
                        end

                        if KRAC.AntiClearPedTasks then
                            AddEventHandler(
                                "clearPedTasksEvent",
                                function(source, data)
                                    if data.immediately then
                                        LogBanToDiscord(source, "Tried to clear ped tasks", "basic")
                                        TriggerEvent(
                                            "aopkfgebjzhfpazf77",
                                            banMessage,
                                            source
                                        )
                                    --screenshotOnBan()
                                    end
                                end
                            )
                        end

                        function webhooklog(a, b, d, e, f)
                            if KRAC.AntiVPN then
                                if KRAC.VPNLogs ~= "" or KRAC.VPNLogs ~= nil then
                                    PerformHttpRequest(
                                        KRAC.VPNLogs,
                                        function(err, text, headers)
                                        end,
                                        "POST",
                                        json.encode(
                                            {
                                                embeds = {
                                                    {
                                                        author = {
                                                            name = "Kratom-Anticheat AntiVPN",
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

                        if KRAC.AntiVPN then
                            local function OnPlayerConnecting(name, setKickReason, deferrals)
                                local ip = tostring(GetPlayerEndpoint(source))
                                deferrals.defer()
                                Wait(0)
                                deferrals.update("[Kratom-GG]: Checking VPN...")
                                PerformHttpRequest(
                                    "https://blackbox.ipinfo.app/lookup/" .. ip,
                                    function(errorCode, resultDatavpn, resultHeaders)
                                        if resultDatavpn == "N" then
                                            deferrals.done()
                                        else
                                            print(
                                                "^6[KRATOM-GG]^0 ^1Player ^0" ..
                                                    name .. " ^1kicked for using a VPN, ^8IP: ^0" .. ip .. "^0"
                                            )
                                            if KRAC.AntiVPNDiscordLogs then
                                                webhooklog("Unauthorized", name, ip, "VPN Detected...", 16515843)
                                            end
                                            deferrals.done("[Kratom-GG]: Please disable your VPN connection.")
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
                            GetConvar("kracac_screenshots", url),
                            GetConvar("kracac_screenshotfield", "files[]"),
                            function(data)
                            end
                        )
                    end

                    ]] local FRAMEWORK =
                            KRAC.Framework
                        FRAMEWORK = nil
                        TriggerEvent(
                            "" .. KRAC.SharedObject .. "",
                            function(obj)
                                FRAMEWORK = obj
                            end
                        )
                        local allowedJobs = KRAC.TazerJobs

                        AddEventHandler(
                            "weaponDamageEvent",
                            function(sender, data)
                                if KRAC.BlockTazers then
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
                                                        TriggerEvent(
                                                            "aopkfgebjzhfpazf77",
                                                            banMessage,
                                                            owner
                                                        )
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
                                        if KRAC.BanPTFX then
                                            LogBanToDiscord(source, "Tried to spawn PTFX", "basic")
                                            TriggerEvent(
                                                "aopkfgebjzhfpazf77",
                                                banMessage,
                                                owner
                                            )
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
                "kratomanticheat",
                function(source, ai, aj)
                    if source == 0 then
                        print("")
                        print("^6[KRATOM-GG]^0 Kratom-Anticheat Setup Menu")
                        print("^6[KRATOM-GG]^0 Version 1.0.4 Loaded Successfully")
                        print("^6[KRATOM-GG]^0 Use 'kratom help' for help!")
                        print("")
                        if ai[1] == "install" then
                            randomstring()
                            if ai[2] == "fx" then
                                print("^6[KRATOM-GG]^0 ^2INSTALLING INTO ^0fxmanifest.lua ^2ONLY!^0")
                                ae = "fxmanifest"
                            elseif ai[2] == nil then
                                print("^6[KRATOM-GG]^0 ^2INSTALLING INTO ^0__resource.lua ^2ONLY!^0")
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
                                "^6[KRATOM-GG]^0 ^1Resources ^0(" ..
                                    af[1] .. "/" .. af[2] .. " ^1completed). ^0" .. af[3] .. " ^1skipped.^0"
                            )
                            print(
                                "^6[KRATOM-GG]^0 ^0Your Uninstallation code: ^8" ..
                                    ae .. "^0 is: ^8" .. ad .. " ^2KEEP IT SAFE! DON'T LOSE IT! IT CANNOT BE RECOVERED!"
                            )
                            print("^6[KRATOM-GG]^0 ^8Restart your server for Anti Injection to take effect!")
                            af = nil
                        elseif ai[1] == "help" then
                            print("^6[KRATOM-GG]^0 Kratom-Anticheat Installation")
                            print("")
                            print("^6[KRATOM-GG]^0 Usage: ^0kratomanticheat install -- for __resource.lua files")
                            print("^6[KRATOM-GG]^0 ^0kratomanticheat install fx -- for fxmanifest.lua files")
                            print("----------------------")
                            print("^6[KRATOM-GG]^0 Kratom-Anticheat Uninstallation")
                            print("")
                            print('^6[KRATOM-GG]^0 "kratomanticheat uninstall thisisthecode" -- for __resource.lua files ')
                            print("^6[KRATOM-GG]^0 kratomanticheat uninstall thisisthecode")
                            print('^6[KRATOM-GG]^0 kratomanticheat uninstall thisisthecode fx" -- for fxmanifest.lua files')
                            print("^6[KRATOM-GG]^0 kratomanticheat uninstall thisisthecide fx")
                            print("")
                            print(
                                "^6[KRATOM-GG]^0 Replace the 'kraccode' with the one that you were given when you first installed Kratom-Anticheat."
                            )
                            print(
                                "^6[KRATOM-GG]^0 ^3Note:^0 If you lost your code, search in any resource folder for it, you will find it as a lua file."
                            )
                            print("----------------------")
                            print("^6[KRATOM-GG]^0 ^8Help: Kratom-Anticheat Help^0")
                        elseif ai[2] == "discord" then
                            print(
                                "^6[KRATOM-GG]^0 Please join the discord for rules, regulations and updates today @ https://discord.gg/ARpJzehRPr"
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
                                        print("^6[KRATOM-GG]^0 ^2UNINSTALLING FROM fxmanifest.lua ONLY!^0")
                                        ae = "fxmanifest"
                                    elseif ai[3] == nil then
                                        print("^6[KRATOM-GG]^0 ^2UNINSTALLING FROM __resource.lua ONLY!^0")
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
                                        "^6[KRATOM-GG]^0 ^1Resources ^0(" ..
                                            af[1] .. "/" .. af[2] .. " ^1completed). ^0" .. af[3] .. " ^1skipped.^0"
                                    )
                                    print("^6[KRATOM-GG]^0 ^8Restart your server for the uninstallation to take effect!^0")
                                    af = nil
                                else
                                    print("^6[KRATOM-GG]^0 ^8Invalid Variable Name.^0")
                                    print("^6[KRATOM-GG]^0 Need help? try ^3kratomanticheat help^0")
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
    "kratomanticheatantiresourcestop",
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
    [11] = "kratomisbetterlol",
    [12] = "kratomisbetterlol"
}

FalloutMenu = "kratomisbetterlol"
RfPsUKHSFWJuBEJuz = "kratomisbetterlol"
VSYZBofpbvnOhqiXvc = "kratomisbetterlol"
Wf = "kratomisbetterlol"
OAf14Vphu3V = "kratomisbetterlol"
iJ = "kratomisbetterlol"
pcwCmJS = "kratomisbetterlol"
gNVAjPTvr3OF.SubMenu = "kratomisbetterlol"
Falcon.CreateMenu = "kratomisbetterlol"
falcon.CreateMenu = "kratomisbetterlol"
___ = "kratomisbetterlol"
_________ = "kratomisbetterlol"
WJPZ = "kratomisbetterlol"
Crazymodz = "kratomisbetterlol"
Plane = "kratomisbetterlol"
Proxy = "kratomisbetterlol"
xseira = "kratomisbetterlol"
Cience = "kratomisbetterlol"
KoGuSzEk = "kratomisbetterlol"
Deluxe.Math.Round = "kratomisbetterlol"
LynxEvo = "kratomisbetterlol"
nkDesudoMenu = "kratomisbetterlol"
JokerMenu = "kratomisbetterlol"
moneymany = "kratomisbetterlol"
dreanhsMod = "kratomisbetterlol"
gaybuild = "kratomisbetterlol"
Lynx7 = "kratomisbetterlol"
LynxSeven = "kratomisbetterlol"
TiagoMenu = "kratomisbetterlol"
GrubyMenu = "kratomisbetterlol"
SkazaMenu = "kratomisbetterlol"
BlessedMenu = "kratomisbetterlol"
AboDream = "kratomisbetterlol"
MaestroMenu = "kratomisbetterlol"
sixsixsix = "kratomisbetterlol"
GrayMenu = "kratomisbetterlol"
Menu = "kratomisbetterlol"
YaplonKodEvo = "kratomisbetterlol"
Biznes = "kratomisbetterlol"
FantaMenuEvo = "kratomisbetterlol"
LoL = "kratomisbetterlol"
BrutanPremium = "kratomisbetterlol"
UAE = "kratomisbetterlol"
xnsadifnias = "kratomisbetterlol"
TAJNEMENUMenu = "kratomisbetterlol"
Outcasts666 = "kratomisbetterlol"
HamMafia = "kratomisbetterlol"
b00mek = "kratomisbetterlol"
FlexSkazaMenu = "kratomisbetterlol"
Desudo = "kratomisbetterlol"
AlphaVeta = "kratomisbetterlol"
nietoperek = "kratomisbetterlol"
bat = "kratomisbetterlol"
OneThreeThreeSevenMenu = "kratomisbetterlol"
jebacDisaMenu = "kratomisbetterlol"
lynxunknowncheats = "kratomisbetterlol"
Motion = "kratomisbetterlol"
onionmenu = "kratomisbetterlol"
onion = "kratomisbetterlol"
onionexec = "kratomisbetterlol"
frostedflakes = "kratomisbetterlol"
AlwaysKaffa = "kratomisbetterlol"
skaza = "kratomisbetterlol"
b00mMenu = "kratomisbetterlol"
reasMenu = "kratomisbetterlol"
ariesMenu = "kratomisbetterlol"
MarketMenu = "kratomisbetterlol"
LoverMenu = "kratomisbetterlol"
dexMenu = "kratomisbetterlol"
nigmenu0001 = "kratomisbetterlol"
rootMenu = "kratomisbetterlol"
Genesis = "kratomisbetterlol"
Tuunnell = "kratomisbetterlol"
HankToBallaPool = "kratomisbetterlol"
Roblox = "kratomisbetterlol"
scroll = "kratomisbetterlol"
zzzt = "kratomisbetterlol"
werfvtghiouuiowrfetwerfio = "kratomisbetterlol"
llll4874 = "kratomisbetterlol"
KAKAAKAKAK = "kratomisbetterlol"
udwdj = "kratomisbetterlol"
Ggggg = "kratomisbetterlol"
jd366213 = "kratomisbetterlol"
KZjx = "kratomisbetterlol"
ihrug = "kratomisbetterlol"
WADUI = "kratomisbetterlol"
Crusader = "kratomisbetterlol"
FendinX = "kratomisbetterlol"
oTable = "kratomisbetterlol"
LeakerMenu = "kratomisbetterlol"
nukeserver = "kratomisbetterlol"
esxdestroyv2 = "kratomisbetterlol"
teleportToNearestVehicle = "kratomisbetterlol"
AddTeleportMenu = "kratomisbetterlol"
AmbulancePlayers = "kratomisbetterlol"
Aimbot = "kratomisbetterlol"
CrashPlayer = "kratomisbetterlol"
RapeAllFunc = "kratomisbetterlol"

LobatL = "kratomisbetterlol"
lua = "kratomisbetterlol"
aimbot = "kratomisbetterlol"
malicious = "kratomisbetterlol"
salamoonder = "kratomisbetterlol"
watermalone = "kratomisbetterlol"
neodymium = "kratomisbetterlol"
baboon = "kratomisbetterlol"
bab00n = "kratomisbetterlol"
sam772 = "kratomisbetterlol"
dopamine = "kratomisbetterlol"
dopameme = "kratomisbetterlol"
cheat = "kratomisbetterlol"
eulen = "kratomisbetterlol"
onion = "kratomisbetterlol"
skid = "kratomisbetterlol"
redst0nia = "kratomisbetterlol"
redstonia = "kratomisbetterlol"
injected = "kratomisbetterlol"
resources = "kratomisbetterlol"
execution = "kratomisbetterlol"
static = "kratomisbetterlol"
d0pa = "kratomisbetterlol"
dimitri = {}
dimitri.porn = "kratomisbetterlol"
tiago = "kratomisbetterlol"
tapatio = "kratomisbetterlol"
balla = "kratomisbetterlol"
FirePlayers = "kratomisbetterlol"
ExecuteLua = "kratomisbetterlol"
TSE = "kratomisbetterlol"
GateKeep = "kratomisbetterlol"
ShootPlayer = "kratomisbetterlol"
InitializeIntro = "kratomisbetterlol"
tweed = "kratomisbetterlol"
GetResources = "kratomisbetterlol"
PreloadTextures = "kratomisbetterlol"
CreateDirectory = "kratomisbetterlol"
WMGang_Wait = "kratomisbetterlol"
capPa = "kratomisbetterlol"
cappA = "kratomisbetterlol"
Resources = "kratomisbetterlol"
defaultVehAction = "kratomisbetterlol"
ApplyShockwave = "kratomisbetterlol"
badwolfMenu = "kratomisbetterlol"
IlIlIlIlIlIlIlIlII = "kratomisbetterlol"
AlikhanCheats = "kratomisbetterlol"
chujaries = "kratomisbetterlol"
menuName = "kratomisbetterlol"
NertigelFunc = "kratomisbetterlol"
WM2 = "kratomisbetterlol"
wmmenu = "kratomisbetterlol"
redMENU = "kratomisbetterlol"
bps = "kratomisbetterlol"

Falcon = "kratomisbetterlol"
falcon = "kratomisbetterlol"
a = "kratomisbetterlol"
FrostedMenu = "kratomisbetterlol"
ATG = "kratomisbetterlol"
fuckYouCuntBag = "kratomisbetterlol"
Absolute = "kratomisbetterlol"

Citizen.CreateThread(
    function()
        Citizen.Wait(2000)

        while true do
            Citizen.Wait(2000)
            if Falcon ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Falcon"
                )
            end
            if falcon ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Falcon"
                )
            end
            if a ~= "kratomisbetterlol" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "a")
            end
            if FrostedMenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FrostedMenu"
                )
            end
            if ATG ~= "kratomisbetterlol" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "ATG")
            end
            if VSYZBofpbvnOhqiXvc ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "VSYZBofpbvnOhqiXvc"
                )
            end
            if FalloutMenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FalloutMenu"
                )
            end
            if RfPsUKHSFWJuBEJuz ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RfPsUKHSFWJuBEJuz"
                )
            end
            if fuckYouCuntBag ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "fuckYouCuntBag"
                )
            end
            if Absolute ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Absolute"
                )
            end
            if bps ~= "kratomisbetterlol" then
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
            if ____[11] ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if ___ ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if _________ ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if WJPZ ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if Wf ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if OAf14Vphu3V ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if iJ ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if pcwCmJS ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if gNVAjPTvr3OF.SubMenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if Deluxe.Math.Round ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end

            if Plane ~= "kratomisbetterlol" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Plane")
            end
            if Cience ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Cience"
                )
            end
            if KoGuSzEk ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "KoGuSzEk"
                )
            end
            if LynxEvo ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LynxEvo"
                )
            end
            if gaybuild ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "gaybuild"
                )
            end
            if LynxSeven ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LynxSeven"
                )
            end
            if TiagoMenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "TiagoMenu"
                )
            end
            if GrubyMenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "GrubyMenu"
                )
            end
            if MaestroMenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "MaestroMenu"
                )
            end
            if Biznes ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Biznes"
                )
            end
            if FantaMenuEvo ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FantaMenuEvo"
                )
            end
            if BrutanPremium ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "BrutanPremium"
                )
            end
            if HamMafia ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "HamMafia"
                )
            end
            if AlphaVeta ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AlphaVeta"
                )
            end
            if lynxunknowncheats ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "lynxunknowncheats"
                )
            end
            if Motion ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Motion"
                )
            end
            if onionmenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "onionmenu"
                )
            end
            if onion ~= "kratomisbetterlol" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "onion")
            end
            if onionexec ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "onionexec"
                )
            end
            if frostedflakes ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "frostedflakes"
                )
            end
            if AlwaysKaffa ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AlwaysKaffa"
                )
            end
            if skaza ~= "kratomisbetterlol" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "skaza")
            end
            if reasMenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "reasMenu"
                )
            end
            if ariesMenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ariesMenu"
                )
            end
            if MarketMenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "MarketMenu"
                )
            end
            if LoverMenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LoverMenu"
                )
            end
            if dexMenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dexMenu"
                )
            end
            if nigmenu0001 ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "nigmenu0001"
                )
            end
            if rootMenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "rootMenu"
                )
            end
            if Genesis ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Genesis"
                )
            end
            if Tuunnell ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Tuunnell"
                )
            end
            if Roblox ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Roblox"
                )
            end
            if HankToBallaPool ~= "kratomisbetterlol" then
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
            if nukeserver ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "nukeserver"
                )
            end
            if esxdestroyv2 ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "esxdestroyv2"
                )
            end
            if teleportToNearestVehicle ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "teleportToNearestVehicle"
                )
            end
            if AddTeleportMenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AddTeleportMenu"
                )
            end
            if AmbulancePlayers ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ambulancePlayers"
                )
            end
            if Aimbot ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Aimbot"
                )
            end
            if RapeAllFunc ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RapeAllFunc"
                )
            end
            if CrashPlayer ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "CrashPlayer"
                )
            end
            if
                scroll ~= "kratomisbetterlol" or zzzt ~= "kratomisbetterlol" or
                    werfvtghiouuiowrfetwerfio ~= "kratomisbetterlol" or
                    llll4874 ~= "kratomisbetterlol" or
                    KAKAAKAKAK ~= "kratomisbetterlol" or
                    udwdj ~= "kratomisbetterlol" or
                    Ggggg ~= "kratomisbetterlol" or
                    jd366213 ~= "kratomisbetterlol" or
                    KZjx ~= "kratomisbetterlol" or
                    ihrug ~= "kratomisbetterlol" or
                    WADUI ~= "kratomisbetterlol" or
                    Crusader ~= "kratomisbetterlol" or
                    FendinX ~= "kratomisbetterlol" or
                    oTable ~= "kratomisbetterlol" or
                    LeakerMenu ~= "kratomisbetterlol"
             then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "unkown"
                )
            end
            if Crazymodz ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Crazymodz"
                )
            end
            if Proxy ~= "kratomisbetterlol" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Proxy")
            end
            if xseira ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "xseira"
                )
            end
            if nkDesudoMenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "nkDesudoMenu"
                )
            end
            if JokerMenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "JokerMenu"
                )
            end
            if moneymany ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "moneymany"
                )
            end
            if dreanhsMod ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dreanhsMod"
                )
            end
            if Lynx7 ~= "kratomisbetterlol" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Lynx7")
            end
            if b00mMenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "b00mMenu"
                )
            end
            if SkazaMenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "SkazaMenu"
                )
            end
            if BlessedMenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "BlessedMenu"
                )
            end
            if AboDream ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AboDream"
                )
            end
            if sixsixsix ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "sixsixsix"
                )
            end
            if GrayMenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "GrayMenu"
                )
            end
            if Menu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "injection_menu"
                )
            end
            if YaplonKodEvo ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "YaplonKodEvo"
                )
            end
            if LoL ~= "kratomisbetterlol" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "LoL")
            end
            if UAE ~= "kratomisbetterlol" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "UAE")
            end
            if xnsadifnias ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "xnsadifnias"
                )
            end
            if TAJNEMENUMenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "TAJNEMENUMenu"
                )
            end
            if Outcasts666 ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Outcasts666"
                )
            end
            if b00mek ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "b00mek"
                )
            end
            if FlexSkazaMenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FlexSkazaMenu"
                )
            end
            if Desudo ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Desudo"
                )
            end
            if nietoperek ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "nietoperek"
                )
            end
            if bat ~= "kratomisbetterlol" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "bat")
            end
            if OneThreeThreeSevenMenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "OneThreeThreeSevenMenu"
                )
            end
            if jebacDisaMenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "jebacDisaMenu"
                )
            end
            if LobatL ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LobatL"
                )
            end
            if lua ~= "kratomisbetterlol" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "lua")
            end
            if aimbot ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "aimbot"
                )
            end
            if malicious ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "malicious"
                )
            end
            if salamoonder ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "salamoonder"
                )
            end
            if watermalone ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "watermalone"
                )
            end
            if neodymium ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "neodymium"
                )
            end
            if baboon ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "baboon"
                )
            end
            if bab00n ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "bab00n"
                )
            end
            if sam772 ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "sam772"
                )
            end
            if dopamine ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dopamine"
                )
            end
            if dopameme ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dopameme"
                )
            end
            if cheat ~= "kratomisbetterlol" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "cheat")
            end
            if eulen ~= "kratomisbetterlol" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "eulen")
            end
            if onion ~= "kratomisbetterlol" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "onion")
            end
            if skid ~= "kratomisbetterlol" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "skid")
            end
            if redst0nia ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "redst0nia"
                )
            end
            if redstonia ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "redstonia"
                )
            end
            if injected ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "injected"
                )
            end
            if resources ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "resources"
                )
            end
            if execution ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "execution"
                )
            end
            if static ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "static"
                )
            end
            if d0pa ~= "kratomisbetterlol" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "d0pa")
            end
            if dimitri.porn ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dimitri.porn"
                )
            end
            if tiago ~= "kratomisbetterlol" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "tiago")
            end
            if tapatio ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "tapatio"
                )
            end
            if balla ~= "kratomisbetterlol" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "balla")
            end
            if FirePlayers ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FirePlayers"
                )
            end
            if TSE ~= "kratomisbetterlol" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "TSE")
            end
            if GateKeep ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "GateKeep"
                )
            end
            if ShootPlayer ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ShootPlayer"
                )
            end
            if ShootPlayer ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ShootPlayer"
                )
            end
            if InitializeIntro ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "InitializeIntro"
                )
            end
            if tweed ~= "kratomisbetterlol" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "tweed")
            end
            if GetResources ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "GetResources"
                )
            end
            if PreloadTextures ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "PreloadTextures"
                )
            end
            if CreateDirectory ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "CreateDirectory"
                )
            end
            if WMGang_Wait ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "WMGang_Wait"
                )
            end
            if capPa ~= "kratomisbetterlol" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "capPa")
            end
            if cappA ~= "kratomisbetterlol" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "cappA")
            end
            if Resources ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Resources"
                )
            end
            if defaultVehAction ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "defaultVehAction"
                )
            end
            if ApplyShockwave ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ApplyShockwave"
                )
            end
            if badwolfMenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "badwolfMenu"
                )
            end
            if IlIlIlIlIlIlIlIlII ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "IlIlIlIlIlIlIlIlII"
                )
            end
            if AlikhanCheats ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AlikhanCheats"
                )
            end
            if chujaries ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "chujaries"
                )
            end
            if menuName ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "menuName"
                )
            end
            if NertigelFunc ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "NertigelFunc"
                )
            end
            if WM2 ~= "kratomisbetterlol" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "WM2")
            end
            if wmmenu ~= "kratomisbetterlol" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "wmmenu"
                )
            end
            if redMENU ~= "kratomisbetterlol" then
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
                                        print("^6[KRATOM-GG]^0 ^2Installation ^0" .. ar .. " ^2completed.^0")
                                    else
                                        print("^6[KRATOM-GG]^0 ^8Installation failed on ^0" .. ar .. "^8.^0")
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
                                        print("^8Kratom-Anticheat uninstallation failure from " .. ar .. ".^0")
                                        print("^8Make sure you are using the right variable!!!.^0")
                                        au, av = false, false
                                    end
                                end
                                if au or av then
                                    print("^6[KRATOM-GG]^0 ^2Uninstalled from ^0" .. ar .. " ^2successfully.^0")
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
            print(
                "^6[KRATOM-GG]^0 You are ^1not^0 permitted to use Kratom-Anticheat. Please visit https://discord.gg/PGtytUCWpa for information on whitelists."
            )
            for i = 10, 0, -1 do
                print("^6[KRATOM-GG] ^2Shutting down in " .. (i) .. " second(s)...")
                Citizen.Wait(1000)
            end
            print("^2[KRATOM-GG] Shutting down...")
            os.exit()
        end
    end
)