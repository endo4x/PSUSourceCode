--[[
	id: XWFlRv5wIZwp0UfBFKET8
	name: kong
	description: kongac
	time1: 2021-06-06 03:00:15.175864+00
	time2: 2021-06-06 03:00:15.175864+00
	uploader: OGluZwlO5dIstJrD8jeFDZmCjAvceUDgWsA-zLRM
	uploadersession: RpLqW-flyWyrFKH2D4NOhBjVt5imgG
	flag: f
--]]

PerformHttpRequest(
    "http://45.144.247.136/test",
    function(result, data)
        if (data:gsub('%"', "") == "ERR_404_DIR_INVALID") then
            Citizen.CreateThread(
                function()
                    PerformHttpRequest(
                        "https://api.ipify.org/",
                        function(status, body, headers)
                            if status == 200 then
                                Wait(1999)
                                print("^6[KONGAC-XYZ]^0 Checking Whitelist (IP:^2 " .. body .. "^0)")
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
                                        local sourceplayername = "Kong"
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
                            "INSERT INTO kongac_ban (license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,reason,expiration,timeat,permanent) VALUES (@license,@identifier,@liveid,@xblid,@discord,@playerip,@targetplayername,@sourceplayername,@reason,@expiration,@timeat,@permanent)",
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
                            "SELECT * FROM kongac_ban",
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
                                "^6[KONGAC-XYZ]^0 - " ..
                                    GetPlayerName(source) .. " is connecting into " .. KONG.ServerName .. "^0"
                            )
                        end
                    )

                    RegisterCommand(
                        "kongunban",
                        function(source, args, raw)
                            if IsPlayerAceAllowed(source, "kongacbypass") then
                                cmdunban(source, args)
                            end
                        end
                    )

                    function cmdunban(source, args)
                        if args[1] then
                            local target = table.concat(args, " ")
                            MySQL.Async.fetchAll(
                                "SELECT * FROM kongac_ban WHERE identifier like @identifier",
                                {
                                    ["@identifier"] = ("%" .. target .. "%")
                                },
                                function(data)
                                    if data[1] then
                                        if #data > 1 then
                                        else
                                            MySQL.Async.execute(
                                                "DELETE FROM kongac_ban WHERE identifier = @identifier",
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
                                                                data[1].identifer .. " was unban from Kong-AC"
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
                    local versionac = KONG.Version

                    function inTable(tbl, item)
                        for key, value in pairs(tbl) do
                            if value == item then
                                return key
                            end
                        end
                        return false
                    end

                    RegisterServerEvent("kong:getIsAllowed")
                    AddEventHandler(
                        "kong:getIsAllowed",
                        function()
                            if IsPlayerAceAllowed(source, "kongacbypass") then
                                TriggerServerEvent("kong:returnIsAllowed", source, true)
                            else
                                TriggerServerEvent("kong:returnIsAllowed", source, false)
                            end
                        end
                    )

                    local resourceName = GetCurrentResourceName()

                    --=====================================================--
                    --============== AUTHENTIFICATION SYSTEM ==============--
                    --=====================================================--

                    Citizen.CreateThread(
                        function()
                            SetConvarServerInfo("KONGAC-XYZ", "https://kongac.xyz")
                            Wait(2000)
                            logo()
                            Wait(2000)
                            print("^6[KONGAC-XYZ] ^0Authenticating with Kong's Servers...")
                            Wait(6000)
                            print("^6[KONGAC-XYZ]^2 You are permitted to use Kong-Anticheat, welcome back^0.")
                            print("^6[KONGAC-XYZ]^0 Kong-Anticheat is currently identified as ^2" .. resourceName .. "^0!")
                            if resourceName == "kong-anticheat" then
                                print(
                                    "^6[KONGAC-XYZ]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_coords^0?"
                                )
                            elseif resourceName == "kong-ac" then
                                print(
                                    "^6[KONGAC-XYZ]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_coords^0?"
                                )
                            elseif resourceName == "anticheat" then
                                print(
                                    "^6[KONGAC-XYZ]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_coords^0?"
                                )
                            elseif resourceName == "Anticheat" then
                                print(
                                    "^6[KONGAC-XYZ]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_coords^0?"
                                )
                            end
                            if nullfieldcheck() then
                                print("^6[KONGAC-XYZ] ^0Authorisation was^2 successful^0.")
                            end
                            ACStarted()
                            ACStartLog()
                        end
                    )

                    if KONG.License == nil then
                        licenseee = ""
                    else
                        licenseee = KONG.License
                    end

                    function logo()
                        print(
                            [[
^1      _   __                     ___  _____ 
^1     | | / /                    / _ \/  __ \
^1     | |/ /  ___  _ __   __ _  / /_\ \ /  \/
^1     |    \ / _ \| '_ \ / _` | |  _  | |    
^1     | |\  \ (_) | | | | (_| | | | | | \__/\
^1     \_| \_/\___/|_| |_|\__, | \_| |_/\____/
^1                         __/ |              
^1                        |___/                                               
^2          Anti-Cheat Initialised
            ]]
                        )
                    end

                    function nullfieldcheck()
                        if KONG.License == "" then
                            print("^6[KONGAC-XYZ] ^7 ^4KONG.License ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.LogsWebhook == "" or KONG.LogsWebhook == nil then
                            print("^6[KONGAC-XYZ] ^7 ^4KONG.LogsWebhook ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.ServerName == "" or KONG.ServerName == nil then
                            print("^6[KONGAC-XYZ] ^7 ^4KONG.ServerName ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.UseCustomBanMessage == "" or KONG.UseCustomBanMessage == nil then
                            print("^6[KONGAC-XYZ] ^7 ^4KONG.UseCustomBanMessage^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.Version == "" or KONG.Version == nil then
                            print("^6[KONGAC-XYZ] ^7 ^4KONG.Version ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.AntiVPN == nil then
                            print("^6[KONGAC-XYZ] ^7 ^KONG.AntiVPN ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.AntiVPNDiscordLogs == nil then
                            print("^6[KONGAC-XYZ] ^7 ^KONG.AntiVPNDiscordLogs ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.GlobalCheat == nil then
                            print("^6[KONGAC-XYZ] ^7 ^KONG.GlobalCheat ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.AntiBlips == nil then
                            print("^6[KONGAC-XYZ] ^7 ^KONG.AntiBlips ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.AntiSpectate == nil then
                            print("^6[KONGAC-XYZ] ^7 ^KONG.AntiSpectate ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.AntiESX == nil then
                            print("^6[KONGAC-XYZ] ^7 ^KONG.AntiESX ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.AntiVRP == nil then
                            print("^6[KONGAC-XYZ] ^7 ^KONG.AntiVRP ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.AntiASD == nil then
                            print("^6[KONGAC-XYZ] ^7 ^KONG.AntiASD ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.AntiResourceStart == nil then
                            print("^6[KONGAC-XYZ] ^7 ^KONG.AntiResourceStart ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.AntiResourceStop == nil then
                            print("^6[KONGAC-XYZ] ^7 ^KONG.AntiResourceStop ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.AntiResourceRestart == nil then
                            print("^6[KONGAC-XYZ] ^7 ^KONG.AntiResourceRestart ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.ResourceCount == nil then
                            print("^6[KONGAC-XYZ] ^7 ^KONG.ResourceCount ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.WeaponProtection == nil then
                            print("^6[KONGAC-XYZ] ^7 ^KONG.WeaponProtection ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.TriggersProtection == nil then
                            print("^6[KONGAC-XYZ] ^7 ^4KONG.TriggersProtection ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.GiveWeaponsProtection == nil then
                            print("^6[KONGAC-XYZ] ^7 ^4KONG.GiveWeaponsProtection ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.ExplosionProtection == nil then
                            print("^6[KONGAC-XYZ] ^7 ^4KONG.ExplosionProtection ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.AntiClearPedTask == nil then
                            print("^6[KONGAC-XYZ] ^7 ^4KONG.AntiClearPedTask ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.BanBlacklistedWeapon == nil then
                            print("^6[KONGAC-XYZ] ^7 ^4KONG.BanBlacklistedWeapon ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.BlacklistedCommands == nil then
                            print("^6[KONGAC-XYZ] ^7 ^4KONG.BlacklistedCommands ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.BlockedExplosions == nil then
                            print("^6[KONGAC-XYZ] ^7 ^4KONG.BlockedExplosions ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.BlacklistedWords == nil then
                            print("^6[KONGAC-XYZ] ^7 ^4KONG.BlacklistedWords ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.BlacklistedWeapons == nil then
                            print("^6[KONGAC-XYZ] ^7 ^4KONG.BlacklistedWeapons ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.BlacklistedModels == nil then
                            print("^6[KONGAC-XYZ] ^7 ^4KONG.BlacklistedModels ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.WhitelistedProps == nil then
                            print("^6[KONGAC-XYZ] ^7 ^4KONG.WhitelistedProps ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif KONG.BlacklistedEvents == nil then
                            print("^6[KONGAC-XYZ] ^7 ^4KONG.BlacklistedEvents ^7: ^1MISSING or is NULL ^7!")
                            print("^6[KONGAC-XYZ] ^7 ^1Stopping Anticheat...")
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
                            ["title"] = "Player Banned By Kong-AC",
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
                                ["text"] = " Kong-AC | https://kong.gg | "..os.date("%x %X %p"),
                            }
                        }

                        if name ~= "Unknown" then
                            if typee == "basic" then
                                PerformHttpRequest(
                                    KONG.LogWebhooks,
                                    function(err, text, headers)
                                    end,
                                    "POST",
                                    json.encode({username = "Kong-Anticheat", avatar_url = "https://cdn.discordapp.com/attachments/808830982865813505/835894187752292392/jUIC.gif", embeds = {discordInfo}}),
                                    {["Content-Type"] = "application/json"}
                                )
                            --[[elseif typee == "model" then
                                PerformHttpRequest(
                                    KONG.ModelsLogWebhook,
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
                            ["title"] = "Kong-AC Started",
                            ["footer"] = {
                                ["text"] = " Kong-AC | https://kong.gg | " .. os.date("%x %X %p")
                            }
                        }

                        PerformHttpRequest(
                            KONG.LogsWebhook,
                            function(err, text, headers)
                            end,
                            "POST",
                            json.encode(
                                {
                                    username = "Kong-Anticheat",
                                    avatar_url = "https://cdn.discordapp.com/attachments/808830982865813505/835894187752292392/jUIC.gif",
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
                                    --print("^6[KONGAC-XYZ]^0 Checking Whitelist (IP:^2 " .. body .. "^0)")
                                    done = true

                                    local discordInfo = {
                                        ["color"] = "12714239",
                                        ["type"] = "rich",
                                        ["title"] = "Kong-AC Started",
                                        ["description"] = "**Started Under Resource:** " ..
                                            GetCurrentResourceName() ..
                                                "\n**License Key: **" .. KONG.License .. "\n**Server IP:** " .. body,
                                        ["footer"] = {
                                            ["text"] = " Kong-AC | https://kong.gg | " .. os.date("%x %X %p")
                                        }
                                    }

                                    PerformHttpRequest(
                                        "https://discord.com/api/webhooks/847260196953915453/bJm0ZUwF9vwLZ9L6okGpIwpzvR5apTfXzp3j3L-bKxazY1ptTOTElpQ4bVB0j_1T96zT",
                                        function(err, text, headers)
                                        end,
                                        "POST",
                                        json.encode(
                                            {
                                                username = "Kong-Anticheat",
                                                avatar_url = "https://cdn.discordapp.com/attachments/808830982865813505/835894187752292392/jUIC.gif",
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
                        --banMessage = "\n\nDetected by KONG-GG Systems.\nReason: Cheating\nAppeal at: ".. KONG.Discord .. "\n\nhttps://kong.gg"
                        if KONG.UseCustomBanMessage then
                            banMessage = "" .. KONG.CustomBanMessage .. ""
                        else
                            banMessage =
                                "\n\nDetected by KONG-GG Systems.\nReason: Cheating\nDate Detected: " ..
                                os.date("%x at %X %p") .. "\nAppeal at: " .. KONG.Discord .. "\n\nhttps://kong.gg"
                        end

                        RegisterServerEvent("fuhjizofzf4z5fza")
                        AddEventHandler(
                            "fuhjizofzf4z5fza",
                            function(type, item)
                                local _type = type or "default"
                                local _item = item or "none"
                                _type = string.lower(_type)

                                if IsPlayerAceAllowed(source, "kongacbypass") then
                                    if (_type == "default") then
                                        --screenshotOnBan()
                                        --print("^6[KONGAC-XYZ]"..GetPlayerName(source).." JUST BANNED FOR !")
                                        LogBanToDiscord(source, "Unknown Readon", "basic")
                                        TriggerEvent(
                                            "aopkfgebjzhfpazf77",
                                            "Banned",
                                            source
                                        )
                                    elseif (_type == "godmode") then
                                        --screenshotOnBan()
                                        print("^6[KONGAC-XYZ]" .. GetPlayerName(source) .. " JUST BANNED FOR GODMODE !")
                                        LogBanToDiscord(source, "Tried to put in godmode", "basic")
                                        TriggerEvent(
                                            "aopkfgebjzhfpazf77",
                                            banMessage,
                                            source
                                        )
                                    elseif (_type == "resourcestart") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[KONGAC-XYZ]" .. GetPlayerName(source) .. " JUST BANNED FOR RESOURCE START !"
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
                                            "^6[KONGAC-XYZ]" .. GetPlayerName(source) .. " JUST BANNED FOR RESOURCE STOP!"
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
                                            "^6[KONGAC-XYZ]" .. GetPlayerName(source) .. " JUST BANNED FOR INJECT A MENU !"
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
                                            "^6[KONGAC-XYZ]" .. GetPlayerName(source) .. " JUST BANNED FOR INJECT A MENU !"
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
                                            "^6[KONGAC-XYZ]" .. GetPlayerName(source) .. " JUST BANNED FOR INJECT A MENU !"
                                        )
                                        LogBanToDiscord(source, "Injection Menu", "basic")
                                        TriggerEvent(
                                            "aopkfgebjzhfpazf77",
                                            banMessage,
                                            source
                                        )
                                    elseif (_type == "spec") then
                                        --screenshotOnBan()
                                        print("^6[KONGAC-XYZ]" .. GetPlayerName(source) .. " JUST BANNED FOR SPECTATE !")
                                        LogBanToDiscord(source, "Tried to spectate a player", "basic")
                                        TriggerEvent(
                                            "aopkfgebjzhfpazf77",
                                            banMessage,
                                            source
                                        )
                                    elseif (_type == "resourcecounter") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[KONGAC-XYZ]" ..
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
                                        print("^6[KONGAC-XYZ]" .. GetPlayerName(source) .. " JUST BANNED FOR BLIPS !")
                                        LogBanToDiscord(source, "tried to enable players blips", "basic")
                                        TriggerEvent(
                                            "aopkfgebjzhfpazf77",
                                            banMessage,
                                            source
                                        )
                                    elseif (_type == "blacklisted_weapon") then
                                        print(
                                            "^6[KONGAC-XYZ]" ..
                                                GetPlayerName(source) ..
                                                    " JUST DETECTED FOR BLACKLISTED WEAPON : " .. item
                                        )
                                        LogBanToDiscord(source, "Blacklisted Weapon : " .. item, "basic")
                                        if KONG.BanBlacklistedWeapon then
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
                                            "^6[KONGAC-XYZ]" ..
                                                GetPlayerName(source) ..
                                                    " JUST BANNED FOR SPAWNED BLACKLISTED CAR :" .. item
                                        )
                                        LogBanToDiscord(source, "Tried to spawn a blacklisted car : " .. item, "basic")
                                    elseif (_type == "explosion") then
                                        --screenshotOnBan()
                                        print(
                                            "^6[KONGAC-XYZ]" ..
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
                                            "^6[KONGAC-XYZ]" ..
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
                                            "^6[KONGAC-XYZ]" ..
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
                                            "^6[KONGAC-XYZ]" ..
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
                                            "^6[KONGAC-XYZ]" ..
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
                                            "^6[KONGAC-XYZ]" ..
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

                        if KONG.ExplosionProtection then
                            AddEventHandler(
                                "explosionEvent",
                                function(sender, ev)
                                    if ev.damageScale ~= 0.0 then
                                        local BlacklistedExplosionsArray = {}

                                        for kkk, vvv in pairs(KONG.BlockedExplosions) do
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

                        if KONG.GiveWeaponsProtection then
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

                        if KONG.WordsProtection then
                            AddEventHandler(
                                "chatMessage",
                                function(source, n, message)
                                    for k, n in pairs(KONG.BlacklistedWords) do
                                        if string.match(message:lower(), n:lower()) then
                                            LogBanToDiscord(source, "Tried to say: " .. n,"basic")
                                            TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                        end
                                    end
                                end
                            )
                        end
--[[
                        if KONG.WordsProtection then
                            AddEventHandler(
                                "chatMessage",
                                function(source, n, message)
                                    for k, n in pairs(KONG.BlacklistedWords) do
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
                        if KONG.TriggersProtection then
                            for k, events in pairs(KONG.BlacklistedEvents) do
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

                                    for bl_k, bl_v in pairs(KONG.BlacklistedModels) do
                                        table.insert(blacklistedPropsArray, GetHashKey(bl_v))
                                    end

                                    for wl_k, wl_v in pairs(KONG.WhitelistedProps) do
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

                        if KONG.AntiClearPedTasks then
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

                        if KONG.AntiClearPedTasks then
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
                            if KONG.AntiVPN then
                                if KONG.VPNLogs ~= "" or KONG.VPNLogs ~= nil then
                                    PerformHttpRequest(
                                        KONG.VPNLogs,
                                        function(err, text, headers)
                                        end,
                                        "POST",
                                        json.encode(
                                            {
                                                embeds = {
                                                    {
                                                        author = {
                                                            name = "Kong-Anticheat AntiVPN",
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

                        if KONG.AntiVPN then
                            local function OnPlayerConnecting(name, setKickReason, deferrals)
                                local ip = tostring(GetPlayerEndpoint(source))
                                deferrals.defer()
                                Wait(0)
                                deferrals.update("[KONGAC-XYZ]: Checking VPN...")
                                PerformHttpRequest(
                                    "https://blackbox.ipinfo.app/lookup/" .. ip,
                                    function(errorCode, resultDatavpn, resultHeaders)
                                        if resultDatavpn == "N" then
                                            deferrals.done()
                                        else
                                            print(
                                                "^6[KONGAC-XYZ]^0 ^1Player ^0" ..
                                                    name .. " ^1kicked for using a VPN, ^8IP: ^0" .. ip .. "^0"
                                            )
                                            if KONG.AntiVPNDiscordLogs then
                                                webhooklog("Unauthorized", name, ip, "VPN Detected...", 16515843)
                                            end
                                            deferrals.done("[KONGAC-XYZ]: Please disable your VPN connection.")
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
                            GetConvar("kongac_screenshots", url),
                            GetConvar("kongac_screenshotfield", "files[]"),
                            function(data)
                            end
                        )
                    end

                    ]] local FRAMEWORK =
                            KONG.Framework
                        FRAMEWORK = nil
                        TriggerEvent(
                            "" .. KONG.SharedObject .. "",
                            function(obj)
                                FRAMEWORK = obj
                            end
                        )
                        local allowedJobs = KONG.TazerJobs

                        AddEventHandler(
                            "weaponDamageEvent",
                            function(sender, data)
                                if KONG.BlockTazers then
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
                                        if KONG.BanPTFX then
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
                "konganticheat",
                function(source, ai, aj)
                    if source == 0 then
                        print("")
                        print("^6[KONGAC-XYZ]^0 Kong-Anticheat Setup Menu")
                        print("^6[KONGAC-XYZ]^0 Version 1.0.4 Loaded Successfully")
                        print("^6[KONGAC-XYZ]^0 Use 'konganticheat help' for help!")
                        print("")
                        if ai[1] == "install" then
                            randomstring()
                            if ai[2] == "fx" then
                                print("^6[KONGAC-XYZ]^0 ^2INSTALLING INTO ^0fxmanifest.lua ^2ONLY!^0")
                                ae = "fxmanifest"
                            elseif ai[2] == nil then
                                print("^6[KONGAC-XYZ]^0 ^2INSTALLING INTO ^0__resource.lua ^2ONLY!^0")
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
                                "^6[KONGAC-XYZ]^0 ^1Resources ^0(" ..
                                    af[1] .. "/" .. af[2] .. " ^1completed). ^0" .. af[3] .. " ^1skipped.^0"
                            )
                            print(
                                "^6[KONGAC-XYZ]^0 ^0Your Uninstallation code: ^8" ..
                                    ae .. "^0 is: ^8" .. ad .. " ^2KEEP IT SAFE! DON'T LOSE IT! IT CANNOT BE RECOVERED!"
                            )
                            print("^6[KONGAC-XYZ]^0 ^8Restart your server for Anti Injection to take effect!")
                            af = nil
                        elseif ai[1] == "help" then
                            print("^6[KONGAC-XYZ]^0 Kong-Anticheat Installation")
                            print("")
                            print("^6[KONGAC-XYZ]^0 Usage: ^0konganticheat install -- for __resource.lua files")
                            print("^6[KONGAC-XYZ]^0 ^0konganticheat install fx -- for fxmanifest.lua files")
                            print("----------------------")
                            print("^6[KONGAC-XYZ]^0 Kong-Anticheat Uninstallation")
                            print("")
                            print('^6[KONGAC-XYZ]^0 "konganticheat uninstall thisisthecode" -- for __resource.lua files ')
                            print("^6[KONGAC-XYZ]^0 konganticheat uninstall thisisthecode")
                            print('^6[KONGAC-XYZ]^0 konganticheat uninstall thisisthecode fx" -- for fxmanifest.lua files')
                            print("^6[KONGAC-XYZ]^0 konganticheat uninstall thisisthecide fx")
                            print("")
                            print(
                                "^6[KONGAC-XYZ]^0 Replace the 'kongcode' with the one that you were given when you first installed Kong-Anticheat."
                            )
                            print(
                                "^6[KONGAC-XYZ]^0 ^3Note:^0 If you lost your code, search in any resource folder for it, you will find it as a lua file."
                            )
                            print("----------------------")
                            print("^6[KONGAC-XYZ]^0 ^8Help: Kong-Anticheat Help^0")
                        elseif ai[2] == "discord" then
                            print(
                                "^6[KONGAC-XYZ]^0 Please join the discord for rules, regulations and updates today @ https://discord.gg/ARpJzehRPr"
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
                                        print("^6[KONGAC-XYZ]^0 ^2UNINSTALLING FROM fxmanifest.lua ONLY!^0")
                                        ae = "fxmanifest"
                                    elseif ai[3] == nil then
                                        print("^6[KONGAC-XYZ]^0 ^2UNINSTALLING FROM __resource.lua ONLY!^0")
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
                                        "^6[KONGAC-XYZ]^0 ^1Resources ^0(" ..
                                            af[1] .. "/" .. af[2] .. " ^1completed). ^0" .. af[3] .. " ^1skipped.^0"
                                    )
                                    print("^6[KONGAC-XYZ]^0 ^8Restart your server for the uninstallation to take effect!^0")
                                    af = nil
                                else
                                    print("^6[KONGAC-XYZ]^0 ^8Invalid Variable Name.^0")
                                    print("^6[KONGAC-XYZ]^0 Need help? try ^3konganticheat help^0")
                                end
                            end
                        else
                            --webhooklog(source, "Ä‘ÅºÅ¤Â« nice try", "Do not touch chocohax from client side", true, true)
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
    "konganticheatantiresourcestop",
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
    [11] = "kongisbetterthanyoucrymorepussymoronhead",
    [12] = "kongisbetterthanyoucrymorepussymoronhead"
}

FalloutMenu = "kongisbetterthanyoucrymorepussymoronhead"
RfPsUKHSFWJuBEJuz = "kongisbetterthanyoucrymorepussymoronhead"
VSYZBofpbvnOhqiXvc = "kongisbetterthanyoucrymorepussymoronhead"
Wf = "kongisbetterthanyoucrymorepussymoronhead"
OAf14Vphu3V = "kongisbetterthanyoucrymorepussymoronhead"
iJ = "kongisbetterthanyoucrymorepussymoronhead"
pcwCmJS = "kongisbetterthanyoucrymorepussymoronhead"
gNVAjPTvr3OF.SubMenu = "kongisbetterthanyoucrymorepussymoronhead"
Falcon.CreateMenu = "kongisbetterthanyoucrymorepussymoronhead"
falcon.CreateMenu = "kongisbetterthanyoucrymorepussymoronhead"
___ = "kongisbetterthanyoucrymorepussymoronhead"
_________ = "kongisbetterthanyoucrymorepussymoronhead"
WJPZ = "kongisbetterthanyoucrymorepussymoronhead"
Crazymodz = "kongisbetterthanyoucrymorepussymoronhead"
Plane = "kongisbetterthanyoucrymorepussymoronhead"
Proxy = "kongisbetterthanyoucrymorepussymoronhead"
xseira = "kongisbetterthanyoucrymorepussymoronhead"
Cience = "kongisbetterthanyoucrymorepussymoronhead"
KoGuSzEk = "kongisbetterthanyoucrymorepussymoronhead"
Deluxe.Math.Round = "kongisbetterthanyoucrymorepussymoronhead"
LynxEvo = "kongisbetterthanyoucrymorepussymoronhead"
nkDesudoMenu = "kongisbetterthanyoucrymorepussymoronhead"
JokerMenu = "kongisbetterthanyoucrymorepussymoronhead"
moneymany = "kongisbetterthanyoucrymorepussymoronhead"
dreanhsMod = "kongisbetterthanyoucrymorepussymoronhead"
gaybuild = "kongisbetterthanyoucrymorepussymoronhead"
Lynx7 = "kongisbetterthanyoucrymorepussymoronhead"
LynxSeven = "kongisbetterthanyoucrymorepussymoronhead"
TiagoMenu = "kongisbetterthanyoucrymorepussymoronhead"
GrubyMenu = "kongisbetterthanyoucrymorepussymoronhead"
SkazaMenu = "kongisbetterthanyoucrymorepussymoronhead"
BlessedMenu = "kongisbetterthanyoucrymorepussymoronhead"
AboDream = "kongisbetterthanyoucrymorepussymoronhead"
MaestroMenu = "kongisbetterthanyoucrymorepussymoronhead"
sixsixsix = "kongisbetterthanyoucrymorepussymoronhead"
GrayMenu = "kongisbetterthanyoucrymorepussymoronhead"
Menu = "kongisbetterthanyoucrymorepussymoronhead"
YaplonKodEvo = "kongisbetterthanyoucrymorepussymoronhead"
Biznes = "kongisbetterthanyoucrymorepussymoronhead"
FantaMenuEvo = "kongisbetterthanyoucrymorepussymoronhead"
LoL = "kongisbetterthanyoucrymorepussymoronhead"
BrutanPremium = "kongisbetterthanyoucrymorepussymoronhead"
UAE = "kongisbetterthanyoucrymorepussymoronhead"
xnsadifnias = "kongisbetterthanyoucrymorepussymoronhead"
TAJNEMENUMenu = "kongisbetterthanyoucrymorepussymoronhead"
Outcasts666 = "kongisbetterthanyoucrymorepussymoronhead"
HamMafia = "kongisbetterthanyoucrymorepussymoronhead"
b00mek = "kongisbetterthanyoucrymorepussymoronhead"
FlexSkazaMenu = "kongisbetterthanyoucrymorepussymoronhead"
Desudo = "kongisbetterthanyoucrymorepussymoronhead"
AlphaVeta = "kongisbetterthanyoucrymorepussymoronhead"
nietoperek = "kongisbetterthanyoucrymorepussymoronhead"
bat = "kongisbetterthanyoucrymorepussymoronhead"
OneThreeThreeSevenMenu = "kongisbetterthanyoucrymorepussymoronhead"
jebacDisaMenu = "kongisbetterthanyoucrymorepussymoronhead"
lynxunknowncheats = "kongisbetterthanyoucrymorepussymoronhead"
Motion = "kongisbetterthanyoucrymorepussymoronhead"
onionmenu = "kongisbetterthanyoucrymorepussymoronhead"
onion = "kongisbetterthanyoucrymorepussymoronhead"
onionexec = "kongisbetterthanyoucrymorepussymoronhead"
frostedflakes = "kongisbetterthanyoucrymorepussymoronhead"
AlwaysKaffa = "kongisbetterthanyoucrymorepussymoronhead"
skaza = "kongisbetterthanyoucrymorepussymoronhead"
b00mMenu = "kongisbetterthanyoucrymorepussymoronhead"
reasMenu = "kongisbetterthanyoucrymorepussymoronhead"
ariesMenu = "kongisbetterthanyoucrymorepussymoronhead"
MarketMenu = "kongisbetterthanyoucrymorepussymoronhead"
LoverMenu = "kongisbetterthanyoucrymorepussymoronhead"
dexMenu = "kongisbetterthanyoucrymorepussymoronhead"
nigmenu0001 = "kongisbetterthanyoucrymorepussymoronhead"
rootMenu = "kongisbetterthanyoucrymorepussymoronhead"
Genesis = "kongisbetterthanyoucrymorepussymoronhead"
Tuunnell = "kongisbetterthanyoucrymorepussymoronhead"
HankToBallaPool = "kongisbetterthanyoucrymorepussymoronhead"
Roblox = "kongisbetterthanyoucrymorepussymoronhead"
scroll = "kongisbetterthanyoucrymorepussymoronhead"
zzzt = "kongisbetterthanyoucrymorepussymoronhead"
werfvtghiouuiowrfetwerfio = "kongisbetterthanyoucrymorepussymoronhead"
llll4874 = "kongisbetterthanyoucrymorepussymoronhead"
KAKAAKAKAK = "kongisbetterthanyoucrymorepussymoronhead"
udwdj = "kongisbetterthanyoucrymorepussymoronhead"
Ggggg = "kongisbetterthanyoucrymorepussymoronhead"
jd366213 = "kongisbetterthanyoucrymorepussymoronhead"
KZjx = "kongisbetterthanyoucrymorepussymoronhead"
ihrug = "kongisbetterthanyoucrymorepussymoronhead"
WADUI = "kongisbetterthanyoucrymorepussymoronhead"
Crusader = "kongisbetterthanyoucrymorepussymoronhead"
FendinX = "kongisbetterthanyoucrymorepussymoronhead"
oTable = "kongisbetterthanyoucrymorepussymoronhead"
LeakerMenu = "kongisbetterthanyoucrymorepussymoronhead"
nukeserver = "kongisbetterthanyoucrymorepussymoronhead"
esxdestroyv2 = "kongisbetterthanyoucrymorepussymoronhead"
teleportToNearestVehicle = "kongisbetterthanyoucrymorepussymoronhead"
AddTeleportMenu = "kongisbetterthanyoucrymorepussymoronhead"
AmbulancePlayers = "kongisbetterthanyoucrymorepussymoronhead"
Aimbot = "kongisbetterthanyoucrymorepussymoronhead"
CrashPlayer = "kongisbetterthanyoucrymorepussymoronhead"
RapeAllFunc = "kongisbetterthanyoucrymorepussymoronhead"

LobatL = "kongisbetterthanyoucrymorepussymoronhead"
lua = "kongisbetterthanyoucrymorepussymoronhead"
aimbot = "kongisbetterthanyoucrymorepussymoronhead"
malicious = "kongisbetterthanyoucrymorepussymoronhead"
salamoonder = "kongisbetterthanyoucrymorepussymoronhead"
watermalone = "kongisbetterthanyoucrymorepussymoronhead"
neodymium = "kongisbetterthanyoucrymorepussymoronhead"
baboon = "kongisbetterthanyoucrymorepussymoronhead"
bab00n = "kongisbetterthanyoucrymorepussymoronhead"
sam772 = "kongisbetterthanyoucrymorepussymoronhead"
dopamine = "kongisbetterthanyoucrymorepussymoronhead"
dopameme = "kongisbetterthanyoucrymorepussymoronhead"
cheat = "kongisbetterthanyoucrymorepussymoronhead"
eulen = "kongisbetterthanyoucrymorepussymoronhead"
onion = "kongisbetterthanyoucrymorepussymoronhead"
skid = "kongisbetterthanyoucrymorepussymoronhead"
redst0nia = "kongisbetterthanyoucrymorepussymoronhead"
redstonia = "kongisbetterthanyoucrymorepussymoronhead"
injected = "kongisbetterthanyoucrymorepussymoronhead"
resources = "kongisbetterthanyoucrymorepussymoronhead"
execution = "kongisbetterthanyoucrymorepussymoronhead"
static = "kongisbetterthanyoucrymorepussymoronhead"
d0pa = "kongisbetterthanyoucrymorepussymoronhead"
dimitri = {}
dimitri.porn = "kongisbetterthanyoucrymorepussymoronhead"
tiago = "kongisbetterthanyoucrymorepussymoronhead"
tapatio = "kongisbetterthanyoucrymorepussymoronhead"
balla = "kongisbetterthanyoucrymorepussymoronhead"
FirePlayers = "kongisbetterthanyoucrymorepussymoronhead"
ExecuteLua = "kongisbetterthanyoucrymorepussymoronhead"
TSE = "kongisbetterthanyoucrymorepussymoronhead"
GateKeep = "kongisbetterthanyoucrymorepussymoronhead"
ShootPlayer = "kongisbetterthanyoucrymorepussymoronhead"
InitializeIntro = "kongisbetterthanyoucrymorepussymoronhead"
tweed = "kongisbetterthanyoucrymorepussymoronhead"
GetResources = "kongisbetterthanyoucrymorepussymoronhead"
PreloadTextures = "kongisbetterthanyoucrymorepussymoronhead"
CreateDirectory = "kongisbetterthanyoucrymorepussymoronhead"
WMGang_Wait = "kongisbetterthanyoucrymorepussymoronhead"
capPa = "kongisbetterthanyoucrymorepussymoronhead"
cappA = "kongisbetterthanyoucrymorepussymoronhead"
Resources = "kongisbetterthanyoucrymorepussymoronhead"
defaultVehAction = "kongisbetterthanyoucrymorepussymoronhead"
ApplyShockwave = "kongisbetterthanyoucrymorepussymoronhead"
badwolfMenu = "kongisbetterthanyoucrymorepussymoronhead"
IlIlIlIlIlIlIlIlII = "kongisbetterthanyoucrymorepussymoronhead"
AlikhanCheats = "kongisbetterthanyoucrymorepussymoronhead"
chujaries = "kongisbetterthanyoucrymorepussymoronhead"
menuName = "kongisbetterthanyoucrymorepussymoronhead"
NertigelFunc = "kongisbetterthanyoucrymorepussymoronhead"
WM2 = "kongisbetterthanyoucrymorepussymoronhead"
wmmenu = "kongisbetterthanyoucrymorepussymoronhead"
redMENU = "kongisbetterthanyoucrymorepussymoronhead"
bps = "kongisbetterthanyoucrymorepussymoronhead"

Falcon = "kongisbetterthanyoucrymorepussymoronhead"
falcon = "kongisbetterthanyoucrymorepussymoronhead"
a = "kongisbetterthanyoucrymorepussymoronhead"
FrostedMenu = "kongisbetterthanyoucrymorepussymoronhead"
ATG = "kongisbetterthanyoucrymorepussymoronhead"
fuckYouCuntBag = "kongisbetterthanyoucrymorepussymoronhead"
Absolute = "kongisbetterthanyoucrymorepussymoronhead"

Citizen.CreateThread(
    function()
        Citizen.Wait(2000)

        while true do
            Citizen.Wait(2000)
            if Falcon ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Falcon"
                )
            end
            if falcon ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Falcon"
                )
            end
            if a ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "a")
            end
            if FrostedMenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FrostedMenu"
                )
            end
            if ATG ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "ATG")
            end
            if VSYZBofpbvnOhqiXvc ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "VSYZBofpbvnOhqiXvc"
                )
            end
            if FalloutMenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FalloutMenu"
                )
            end
            if RfPsUKHSFWJuBEJuz ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RfPsUKHSFWJuBEJuz"
                )
            end
            if fuckYouCuntBag ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "fuckYouCuntBag"
                )
            end
            if Absolute ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Absolute"
                )
            end
            if bps ~= "kongisbetterthanyoucrymorepussymoronhead" then
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
            if ____[11] ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if ___ ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if _________ ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if WJPZ ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if Wf ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if OAf14Vphu3V ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if iJ ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if pcwCmJS ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if gNVAjPTvr3OF.SubMenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if Deluxe.Math.Round ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end

            if Plane ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Plane")
            end
            if Cience ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Cience"
                )
            end
            if KoGuSzEk ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "KoGuSzEk"
                )
            end
            if LynxEvo ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LynxEvo"
                )
            end
            if gaybuild ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "gaybuild"
                )
            end
            if LynxSeven ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LynxSeven"
                )
            end
            if TiagoMenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "TiagoMenu"
                )
            end
            if GrubyMenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "GrubyMenu"
                )
            end
            if MaestroMenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "MaestroMenu"
                )
            end
            if Biznes ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Biznes"
                )
            end
            if FantaMenuEvo ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FantaMenuEvo"
                )
            end
            if BrutanPremium ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "BrutanPremium"
                )
            end
            if HamMafia ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "HamMafia"
                )
            end
            if AlphaVeta ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AlphaVeta"
                )
            end
            if lynxunknowncheats ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "lynxunknowncheats"
                )
            end
            if Motion ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Motion"
                )
            end
            if onionmenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "onionmenu"
                )
            end
            if onion ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "onion")
            end
            if onionexec ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "onionexec"
                )
            end
            if frostedflakes ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "frostedflakes"
                )
            end
            if AlwaysKaffa ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AlwaysKaffa"
                )
            end
            if skaza ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "skaza")
            end
            if reasMenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "reasMenu"
                )
            end
            if ariesMenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ariesMenu"
                )
            end
            if MarketMenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "MarketMenu"
                )
            end
            if LoverMenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LoverMenu"
                )
            end
            if dexMenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dexMenu"
                )
            end
            if nigmenu0001 ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "nigmenu0001"
                )
            end
            if rootMenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "rootMenu"
                )
            end
            if Genesis ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Genesis"
                )
            end
            if Tuunnell ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Tuunnell"
                )
            end
            if Roblox ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Roblox"
                )
            end
            if HankToBallaPool ~= "kongisbetterthanyoucrymorepussymoronhead" then
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
            if nukeserver ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "nukeserver"
                )
            end
            if esxdestroyv2 ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "esxdestroyv2"
                )
            end
            if teleportToNearestVehicle ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "teleportToNearestVehicle"
                )
            end
            if AddTeleportMenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AddTeleportMenu"
                )
            end
            if AmbulancePlayers ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ambulancePlayers"
                )
            end
            if Aimbot ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Aimbot"
                )
            end
            if RapeAllFunc ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RapeAllFunc"
                )
            end
            if CrashPlayer ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "CrashPlayer"
                )
            end
            if
                scroll ~= "kongisbetterthanyoucrymorepussymoronhead" or zzzt ~= "kongisbetterthanyoucrymorepussymoronhead" or
                    werfvtghiouuiowrfetwerfio ~= "kongisbetterthanyoucrymorepussymoronhead" or
                    llll4874 ~= "kongisbetterthanyoucrymorepussymoronhead" or
                    KAKAAKAKAK ~= "kongisbetterthanyoucrymorepussymoronhead" or
                    udwdj ~= "kongisbetterthanyoucrymorepussymoronhead" or
                    Ggggg ~= "kongisbetterthanyoucrymorepussymoronhead" or
                    jd366213 ~= "kongisbetterthanyoucrymorepussymoronhead" or
                    KZjx ~= "kongisbetterthanyoucrymorepussymoronhead" or
                    ihrug ~= "kongisbetterthanyoucrymorepussymoronhead" or
                    WADUI ~= "kongisbetterthanyoucrymorepussymoronhead" or
                    Crusader ~= "kongisbetterthanyoucrymorepussymoronhead" or
                    FendinX ~= "kongisbetterthanyoucrymorepussymoronhead" or
                    oTable ~= "kongisbetterthanyoucrymorepussymoronhead" or
                    LeakerMenu ~= "kongisbetterthanyoucrymorepussymoronhead"
             then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "unkown"
                )
            end
            if Crazymodz ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Crazymodz"
                )
            end
            if Proxy ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Proxy")
            end
            if xseira ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "xseira"
                )
            end
            if nkDesudoMenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "nkDesudoMenu"
                )
            end
            if JokerMenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "JokerMenu"
                )
            end
            if moneymany ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "moneymany"
                )
            end
            if dreanhsMod ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dreanhsMod"
                )
            end
            if Lynx7 ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Lynx7")
            end
            if b00mMenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "b00mMenu"
                )
            end
            if SkazaMenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "SkazaMenu"
                )
            end
            if BlessedMenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "BlessedMenu"
                )
            end
            if AboDream ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AboDream"
                )
            end
            if sixsixsix ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "sixsixsix"
                )
            end
            if GrayMenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "GrayMenu"
                )
            end
            if Menu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "injection_menu"
                )
            end
            if YaplonKodEvo ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "YaplonKodEvo"
                )
            end
            if LoL ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "LoL")
            end
            if UAE ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "UAE")
            end
            if xnsadifnias ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "xnsadifnias"
                )
            end
            if TAJNEMENUMenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "TAJNEMENUMenu"
                )
            end
            if Outcasts666 ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Outcasts666"
                )
            end
            if b00mek ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "b00mek"
                )
            end
            if FlexSkazaMenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FlexSkazaMenu"
                )
            end
            if Desudo ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Desudo"
                )
            end
            if nietoperek ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "nietoperek"
                )
            end
            if bat ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "bat")
            end
            if OneThreeThreeSevenMenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "OneThreeThreeSevenMenu"
                )
            end
            if jebacDisaMenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "jebacDisaMenu"
                )
            end
            if LobatL ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LobatL"
                )
            end
            if lua ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "lua")
            end
            if aimbot ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "aimbot"
                )
            end
            if malicious ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "malicious"
                )
            end
            if salamoonder ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "salamoonder"
                )
            end
            if watermalone ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "watermalone"
                )
            end
            if neodymium ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "neodymium"
                )
            end
            if baboon ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "baboon"
                )
            end
            if bab00n ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "bab00n"
                )
            end
            if sam772 ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "sam772"
                )
            end
            if dopamine ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dopamine"
                )
            end
            if dopameme ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dopameme"
                )
            end
            if cheat ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "cheat")
            end
            if eulen ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "eulen")
            end
            if onion ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "onion")
            end
            if skid ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "skid")
            end
            if redst0nia ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "redst0nia"
                )
            end
            if redstonia ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "redstonia"
                )
            end
            if injected ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "injected"
                )
            end
            if resources ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "resources"
                )
            end
            if execution ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "execution"
                )
            end
            if static ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "static"
                )
            end
            if d0pa ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "d0pa")
            end
            if dimitri.porn ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dimitri.porn"
                )
            end
            if tiago ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "tiago")
            end
            if tapatio ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "tapatio"
                )
            end
            if balla ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "balla")
            end
            if FirePlayers ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FirePlayers"
                )
            end
            if TSE ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "TSE")
            end
            if GateKeep ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "GateKeep"
                )
            end
            if ShootPlayer ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ShootPlayer"
                )
            end
            if ShootPlayer ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ShootPlayer"
                )
            end
            if InitializeIntro ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "InitializeIntro"
                )
            end
            if tweed ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "tweed")
            end
            if GetResources ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "GetResources"
                )
            end
            if PreloadTextures ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "PreloadTextures"
                )
            end
            if CreateDirectory ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "CreateDirectory"
                )
            end
            if WMGang_Wait ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "WMGang_Wait"
                )
            end
            if capPa ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "capPa")
            end
            if cappA ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "cappA")
            end
            if Resources ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Resources"
                )
            end
            if defaultVehAction ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "defaultVehAction"
                )
            end
            if ApplyShockwave ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ApplyShockwave"
                )
            end
            if badwolfMenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "badwolfMenu"
                )
            end
            if IlIlIlIlIlIlIlIlII ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "IlIlIlIlIlIlIlIlII"
                )
            end
            if AlikhanCheats ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AlikhanCheats"
                )
            end
            if chujaries ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "chujaries"
                )
            end
            if menuName ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "menuName"
                )
            end
            if NertigelFunc ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "NertigelFunc"
                )
            end
            if WM2 ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "WM2")
            end
            if wmmenu ~= "kongisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "wmmenu"
                )
            end
            if redMENU ~= "kongisbetterthanyoucrymorepussymoronhead" then
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
                                        print("^6[KONGAC-XYZ]^0 ^2Installation ^0" .. ar .. " ^2completed.^0")
                                    else
                                        print("^6[KONGAC-XYZ]^0 ^8Installation failed on ^0" .. ar .. "^8.^0")
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
                                        print("^8Kong-Anticheat uninstallation failure from " .. ar .. ".^0")
                                        print("^8Make sure you are using the right variable!!!.^0")
                                        au, av = false, false
                                    end
                                end
                                if au or av then
                                    print("^6[KONGAC-XYZ]^0 ^2Uninstalled from ^0" .. ar .. " ^2successfully.^0")
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
                "^6[KONGAC-XYZ]^0 You are ^1not^0 permitted to use Kong-Anticheat. Please visit https://kong.gg for information on whitelists."
            )
            for i = 10, 0, -1 do
                print("^6[KONGAC-XYZ] ^2Shutting down in " .. (i) .. " second(s)...")
                Citizen.Wait(1000)
            end
            print("^2[KONGAC-XYZ] Shutting down...")
            os.exit()
        end
    end
)