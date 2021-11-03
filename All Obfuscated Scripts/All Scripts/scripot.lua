--[[
	id: r0gH4STPboO-NNVhCN-J3
	name: scripot
	description: script
	time1: 2021-04-24 01:54:38.313398+00
	time2: 2021-04-24 01:54:38.313399+00
	uploader: OGluZwlO5dIstJrD8jeFDZmCjAvceUDgWsA-zLRM
	uploadersession: RpLqW-flyWyrFKH2D4NOhBjVt5imgG
	flag: f
--]]

local useJSON = false

PerformHttpRequest(
    "http://45.144.247.88/sfihsafouihsdf",
    function(result, data)
        if (data:gsub('%"', "") == "ERR_404_DIR_INVALID") then
            Citizen.CreateThread(
                function()
                    PerformHttpRequest(
                        "https://api.ipify.org/",
                        function(status, body, headers)
                            if status == 200 then
                                Wait(1999)
                                print("^6[NCAC-AC]^0 Checking Whitelist (IP:^2 " .. body .. "^0)")
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
                                        --print(Text.banlistloaded)
                                        BanListLoad = true
                                    else
                                        --print(Text.starterror)
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
                                    loadBanList() -- banlist se recharge tout les 10 minutes ^^
                                end
                            end
                        end
                    )

                    --How to use from server side : TriggerEvent("BanSql:ICheat", "Auto-Cheat Custom Reason",TargetId)
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
                                        local sourceplayername = "ncac"
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
                                            ) --Timed ban here
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
                                            ) --Perm ban here
                                            DropPlayer(target, "" .. reason)
                                        end
                                    else
                                        --print("BanSql Error : Auto-Cheat-Ban time invalid.")
                                    end
                                else
                                    --print("BanSql Error : Auto-Cheat-Ban target are not online.")
                                end
                            else
                                --print("BanSql Error : Auto-Cheat-Ban have recive invalid id.")
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

                            --Si Banlist pas chargée
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
                        --calcul total expiration (en secondes)
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

                        if not useJSON then
                            MySQL.Async.execute(
                                "INSERT INTO NCACac_ban (license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,reason,expiration,timeat,permanent) VALUES (@license,@identifier,@liveid,@xblid,@discord,@playerip,@targetplayername,@sourceplayername,@reason,@expiration,@timeat,@permanent)",
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
                        else
                            SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(BanList, {indent=true}), -1)
                        end
                        BanListHistoryLoad = false
                    end

                    function loadBanList()
                        if not useJSON then
                            MySQL.Async.fetchAll(
                                "SELECT * FROM NCACac_ban",
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
                        else
                            local json_ban = LoadResourceFile(GetCurrentResourceName(), "bans.json") or json.encode({})
                            BanList = json.decode(json_ban)
                        end
                    end

                    AddEventHandler(
                        "playerConnecting",
                        function()
                            print(
                                "^6[NCAC-AC]^0 - " ..
                                    GetPlayerName(source) .. " is connecting into " .. NCAC.ServerName .. "^0"
                            )
                        end
                    )

                    RegisterCommand(
                        "ncacunban",
                        function(source, args, raw)
                            if IsPlayerAceAllowed(source, "ncacacbypass") then
                                cmdunban(source, args)
                            end
                        end
                    )

                    function cmdunban(source, args)
                        if args[1] then
                            local target = table.concat(args, " ")
                            if not useJSON then
                                MySQL.Async.fetchAll(
                                    "SELECT * FROM NCACac_ban WHERE identifier like @identifier",
                                    {
                                        ["@identifier"] = ("%" .. target .. "%")
                                    },
                                    function(data)
                                        if data[1] then
                                            if #data > 1 then
                                            else
                                                MySQL.Async.execute(
                                                    "DELETE FROM NCACac_bans WHERE identifier = @identifier",
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
                                                                    data[1].identifer .. " was unban from NCAC-AC"
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
                                local found = false

                                for banid, identifiers in pairs(BanList) do
                                    for _, identifier in pairs(identifiers) do
                                        if identifier == target then
                                            table.remove(BanList, banid)
                                            SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(BanList, {indent=true}), -1)
                                            found = true
                                            break
                                        end
                                    end
                                    if found then
                                        break
                                    end
                                end
                            end
                        else
                        end
                    end

                    local newestversion = "v1.0.0"
                    local versionac = NCAC.Version

                    function inTable(tbl, item)
                        for key, value in pairs(tbl) do
                            if value == item then
                                return key
                            end
                        end
                        return false
                    end

                    RegisterServerEvent("ncac:getIsAllowed")
                    AddEventHandler(
                        "ncac:getIsAllowed",
                        function()
                            if IsPlayerAceAllowed(source, "ncacacbypass") then
                                TriggerServerEvent("ncac:returnIsAllowed", source, true)
                            else
                                TriggerServerEvent("ncac:returnIsAllowed", source, false)
                            end
                        end
                    )

                    local resourceName = GetCurrentResourceName()

                    --=====================================================--
                    --============== AUTHENTIFICATION SYSTEM ==============--
                    --=====================================================--

                    Citizen.CreateThread(
                        function()
                            SetConvarServerInfo("ncac-GG", "https://NCAC.gg")
                            Wait(2000)
                            logo()
                            Wait(2000)
                            print("^6[NCAC-AC] ^0Authenticating with NCAC's Servers...")
                            Wait(6000)
                            print("^6[NCAC-AC]^2 You are permitted to use NCAC-Anticheat, welcome back^0.")
                            print("^6[NCAC-AC]^0 NCAC-Anticheat is currently identified as ^2" .. resourceName .. "^0!")
                            if resourceName == "ncac-anticheat" then
                                print(
                                    "^6[NCAC-AC]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_coords^0?"
                                )
                            elseif resourceName == "ncac-ac" then
                                print(
                                    "^6[NCAC-AC]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_coords^0?"
                                )
                            elseif resourceName == "anticheat" then
                                print(
                                    "^6[NCAC-AC]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_coords^0?"
                                )
                            elseif resourceName == "Anticheat" then
                                print(
                                    "^6[NCAC-AC]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_coords^0?"
                                )
                            end
                            if nullfieldcheck() then
                                print("^6[NCAC-AC] ^0Authorisation was^2 successful^0.")
                            end
                            ACStarted()
                        end
                    )

                    if NCAC.License == nil then
                        licenseee = ""
                    else
                        licenseee = NCAC.License
                    end

                    function logo()
                        print(
                            [[
                    
^6 _   _  ____    _    ____ 
^6 | \ | |/ ___|  / \  / ___|
^6 |  \| | |     / _ \| |    
^6 | |\  | |___ / ___ \ |___ 
^6 |_| \_|\____/_/   \_\____|
^2 NCAC has been Started.
            ]]
                        )
                    end

                    function nullfieldcheck()
                        if NCAC.License == "" then
                            print("^6[NCAC-AC] ^7 ^4NCAC.License ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.LogBanWebhook == "" or NCAC.LogBanWebhook == nil then
                            print("^6[NCAC-AC] ^7 ^4NCAC.LogBanWebhook ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.ServerName == "" or NCAC.ServerName == nil then
                            print("^6[NCAC-AC] ^7 ^4NCAC.ServerName ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.UseCustomBanMessage == "" or NCAC.UseCustomBanMessage == nil then
                            print("^6[NCAC-AC] ^7 ^4NCAC.UseCustomBanMessage^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.Version == "" or NCAC.Version == nil then
                            print("^6[NCAC-AC] ^7 ^4NCAC.Version ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.AntiVPN == nil then
                            print("^6[NCAC-AC] ^7 ^NCAC.AntiVPN ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.AntiVPNDiscordLogs == nil then
                            print("^6[NCAC-AC] ^7 ^NCAC.AntiVPNDiscordLogs ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.GlobalCheat == nil then
                            print("^6[NCAC-AC] ^7 ^NCAC.GlobalCheat ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.AntiBlips == nil then
                            print("^6[NCAC-AC] ^7 ^NCAC.AntiBlips ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.AntiSpectate == nil then
                            print("^6[NCAC-AC] ^7 ^NCAC.AntiSpectate ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.AntiESX == nil then
                            print("^6[NCAC-AC] ^7 ^NCAC.AntiESX ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.AntiVRP == nil then
                            print("^6[NCAC-AC] ^7 ^NCAC.AntiVRP ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.AntiASD == nil then
                            print("^6[NCAC-AC] ^7 ^NCAC.AntiASD ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.AntiResourceStart == nil then
                            print("^6[NCAC-AC] ^7 ^NCAC.AntiResourceStart ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.AntiResourceStop == nil then
                            print("^6[NCAC-AC] ^7 ^NCAC.AntiResourceStop ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.AntiResourceRestart == nil then
                            print("^6[NCAC-AC] ^7 ^NCAC.AntiResourceRestart ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.ResourceCount == nil then
                            print("^6[NCAC-AC] ^7 ^NCAC.ResourceCount ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.WeaponProtection == nil then
                            print("^6[NCAC-AC] ^7 ^NCAC.WeaponProtection ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.TriggersProtection == nil then
                            print("^6[NCAC-AC] ^7 ^4NCAC.TriggersProtection ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.GiveWeaponsProtection == nil then
                            print("^6[NCAC-AC] ^7 ^4NCAC.GiveWeaponsProtection ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.ExplosionProtection == nil then
                            print("^6[NCAC-AC] ^7 ^4NCAC.ExplosionProtection ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.AntiClearPedTask == nil then
                            print("^6[NCAC-AC] ^7 ^4NCAC.AntiClearPedTask ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.BanBlacklistedWeapon == nil then
                            print("^6[NCAC-AC] ^7 ^4NCAC.BanBlacklistedWeapon ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.BlacklistedCommands == nil then
                            print("^6[NCAC-AC] ^7 ^4NCAC.BlacklistedCommands ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.BlockedExplosions == nil then
                            print("^6[NCAC-AC] ^7 ^4NCAC.BlockedExplosions ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.BlacklistedWords == nil then
                            print("^6[NCAC-AC] ^7 ^4NCAC.BlacklistedWords ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.BlacklistedWeapons == nil then
                            print("^6[NCAC-AC] ^7 ^4NCAC.BlacklistedWeapons ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.BlacklistedModels == nil then
                            print("^6[NCAC-AC] ^7 ^4NCAC.BlacklistedModels ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.WhitelistedProps == nil then
                            print("^6[NCAC-AC] ^7 ^4NCAC.WhitelistedProps ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        elseif NCAC.BlacklistedEvents == nil then
                            print("^6[NCAC-AC] ^7 ^4NCAC.BlacklistedEvents ^7: ^1MISSING or is NULL ^7!")
                            print("^6[NCAC-AC] ^7 ^1Stopping Anticheat...")
                            Wait(10000)
                            os.exit()
                        else
                            return true
                        end
                    end

                    --=====================================================--
                    --=====================================================--

                    RecordBanViaDiscord = function(playerId, reason, typee)
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
                            ["title"] = "Player Banned By NCAC-AC",
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
                                ["text"] = " NCAC-AC | https://NCAC.gg "
                            }
                        }

                        if name ~= "Unknown" then
                            if typee == "basic" then
                                PerformHttpRequest(
                                    NCAC.LogBanWebhook,
                                    function(err, text, headers)
                                    end,
                                    "POST",
                                    json.encode({username = " NCACac", embeds = {discordInfo}}),
                                    {["Content-Type"] = "application/json"}
                                )
                            end
                        end
                    end

                    ACStarted = function()
                        local discordInfo = {
                            ["color"] = "12714239",
                            ["type"] = "rich",
                            ["title"] = "ncac-AC Started",
                            ["footer"] = {
                                ["text"] = "ncac-AC | https://NCAC.gg"
                            }
                        }

                        PerformHttpRequest(
                            NCAC.LogBanWebhook,
                            function(err, text, headers)
                            end,
                            "POST",
                            json.encode({username = " NCACac", embeds = {discordInfo}}),
                            {["Content-Type"] = "application/json"}
                        )
                    end

                    ACFailed = function()
                    end

                    --=====================================================--
                    --=====================================================--

                    local banMessage = nil
                    --banMessage = "\n\nDetected by NCAC-GG Systems.\nReason: Cheating\nAppeal at: ".. NCAC.Discord .. "\n\nhttps://NCAC.gg"
                    if NCAC.UseCustomBanMessage then
                        banMessage = "" .. NCAC.CustomBanMessage .. ""
                    else
                        banMessage =
                            "\n\nDetected by NCAC-GG Systems.\nReason: Cheating\nAppeal at: " ..
                            NCAC.Discord .. "\n\nhttps://NCAC.gg"
                    end

                    RegisterServerEvent("fuhjizofzf4z5fza")
                    AddEventHandler(
                        "fuhjizofzf4z5fza",
                        function(type, item)
                            local _type = type or "default"
                            local _item = item or "none"
                            _type = string.lower(_type)

                            if IsPlayerAceAllowed(source, "ncacacbypass") then
                                if (_type == "default") then
                                    --print("^6[NCAC-AC]"..GetPlayerName(source).." JUST BANNED FOR !")
                                    RecordBanViaDiscord(source, "Unknown Readon", "basic")
                                    TriggerEvent("aopkfgebjzhfpazf77", "Tu es ban", source)
                                elseif (_type == "godmode") then
                                    print("^6[NCAC-AC]" .. GetPlayerName(source) .. " JUST BANNED FOR GODMODE !")
                                    RecordBanViaDiscord(source, "Tried to put in godmod", "basic")
                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                elseif (_type == "resourcestart") then
                                    print("^6[NCAC-AC]" .. GetPlayerName(source) .. " JUST BANNED FOR RESOURCE START !")
                                    RecordBanViaDiscord(source, "Tried to start the resource " .. item, "basic")
                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                elseif (_type == "resourcestop") then
                                    print("^6[NCAC-AC]" .. GetPlayerName(source) .. " JUST BANNED FOR RESOURCE STOP!")
                                    RecordBanViaDiscord(source, "Tried to stop the resource " .. item, "basic")
                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                elseif (_type == "esx") then
                                    print("^6[NCAC-AC]" .. GetPlayerName(source) .. " JUST BANNED FOR INJECT A MENU !")
                                    RecordBanViaDiscord(source, "Injection Menu", "basic")
                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                elseif (_type == "vrp") then
                                    print("^6[NCAC-AC]" .. GetPlayerName(source) .. " JUST BANNED FOR INJECT A MENU !")
                                    RecordBanViaDiscord(source, "Injection Menu", "basic")
                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                elseif (_type == "asd") then
                                    print("^6[NCAC-AC]" .. GetPlayerName(source) .. " JUST BANNED FOR INJECT A MENU !")
                                    RecordBanViaDiscord(source, "Injection Menu", "basic")
                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                elseif (_type == "spec") then
                                    print("^6[NCAC-AC]" .. GetPlayerName(source) .. " JUST BANNED FOR SPECTATE !")
                                    RecordBanViaDiscord(source, "Tried to spectate a player", "basic")
                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                elseif (_type == "resourcecounter") then
                                    print(
                                        "^6[NCAC-AC]" ..
                                            GetPlayerName(source) .. " JUST BANNED FOR DIFFERENT RESOURCE COUNT!"
                                    )
                                    RecordBanViaDiscord(source, "has a different resource number count", "basic")
                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                elseif (_type == "antiblips") then
                                    print("^6[NCAC-AC]" .. GetPlayerName(source) .. " JUST BANNED FOR BLIPS !")
                                    RecordBanViaDiscord(source, "tried to enable players blips", "basic")
                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                elseif (_type == "blacklisted_weapon") then
                                    print(
                                        "^6[NCAC-AC]" ..
                                            GetPlayerName(source) .. " JUST DETECTED FOR BLACKLISTED WEAPON : " .. item
                                    )
                                    RecordBanViaDiscord(source, "Blacklisted Weapon : " .. item, "basic")
                                    if NCAC.BanBlacklistedWeapon then
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    end
                                elseif (_type == "hash") then
                                    TriggerServerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    print(
                                        "^6[NCAC-AC]" ..
                                            GetPlayerName(source) ..
                                                " JUST BANNED FOR SPAWNED BLACKLISTED CAR :" .. item
                                    )
                                    RecordBanViaDiscord(source, "Tried to spawn a blacklisted car : " .. item, "basic")
                                elseif (_type == "explosion") then
                                    print(
                                        "^6[NCAC-AC]" .. GetPlayerName(source) .. " JUST BANNED FOR SPAWNED EXPLOSION !"
                                    )
                                    RecordBanViaDiscord(source, "Tried to spawn an explosion : " .. item, "basic")
                                    TriggerServerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                elseif (_type == "event") then
                                    print(
                                        "^6[NCAC-AC]" ..
                                            GetPlayerName(source) .. " JUST BANNED FOR BLACKLISTED EVENT : " .. item
                                    )
                                    RecordBanViaDiscord(
                                        source,
                                        "Tried to trigger a blacklisted event : " .. item,
                                        "basic"
                                    )
                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                elseif (_type == "menu") then
                                    print(
                                        "^6[NCAC-AC]" ..
                                            GetPlayerName(source) .. " JUST BANNED FOR MENU INJECTTION IN : " .. item
                                    )
                                    RecordBanViaDiscord(source, "Tried inject a menu in " .. item, "basic")
                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                elseif (_type == "functionn") then
                                    print(
                                        "^6[NCAC-AC]" ..
                                            GetPlayerName(source) .. " JUST BANNED FOR MENU INJECTTION IN : " .. item
                                    )
                                    RecordBanViaDiscord(source, "Tried to inject a function in " .. item, "basic")
                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                elseif (_type == "damagemodifier") then
                                    print(
                                        "^6[NCAC-AC]" ..
                                            GetPlayerName(source) .. " JUST BANNED FOR MENU INJECTTION IN : " .. item
                                    )
                                    RecordBanViaDiscord(source, "Tried to change his Weapon Damage : " .. item, "basic")
                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                elseif (_type == "malformedresource") then
                                    print(
                                        "^6[NCAC-AC]" ..
                                            GetPlayerName(source) .. " JUST BANNED FOR MENU INJECTTION IN : " .. item
                                    )
                                    RecordBanViaDiscord(
                                        source,
                                        "Tried to inject a malformed resource : " .. item,
                                        "basic"
                                    )
                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
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

                    if NCAC.ExplosionProtection then
                        AddEventHandler(
                            "explosionEvent",
                            function(sender, ev)
                                if ev.damageScale ~= 0.0 then
                                    local BlacklistedExplosionsArray = {}

                                    for kkk, vvv in pairs(NCAC.BlockedExplosions) do
                                        table.insert(BlacklistedExplosionsArray, vvv)
                                    end

                                    if inTable(BlacklistedExplosionsArray, ev.explosionType) ~= false then
                                        CancelEvent()
                                        RecordBanViaDiscord(
                                            sender,
                                            "Tried to spawn a blacklisted explosion - type : " .. ev.explosionType,
                                            "basic"
                                        )
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                    else
                                        RecordBanViaDiscord(sender, "Tried to Explose a player", "basic")
                                    end

                                    if ev.explosionType ~= 9 then
                                        exploCreator[sender] = (exploCreator[sender] or 0) + 1
                                        if exploCreator[sender] > 3 then
                                            RecordBanViaDiscord(
                                                sender,
                                                "Tried to spawn mass explosions - type : " .. ev.explosionType,
                                                "basic"
                                            )
                                            TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                            CancelEvent()
                                        end
                                    else
                                        exploCreator[sender] = (exploCreator[sender] or 0) + 1
                                        if exploCreator[sender] > 3 then
                                            RecordBanViaDiscord(
                                                sender,
                                                "Tried to spawn mass explosions ( gas pump )",
                                                "basic"
                                            )
                                            TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                            CancelEvent()
                                        end
                                    end

                                    if ev.isAudible == false then
                                        RecordBanViaDiscord(
                                            sender,
                                            "Tried to spawn silent explosion - type : " .. ev.explosionType,
                                            "basic"
                                        )
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                    end

                                    if ev.isInvisible == true then
                                        RecordBanViaDiscord(
                                            sender,
                                            "Tried to spawn invisible explosion - type : " .. ev.explosionType,
                                            "basic"
                                        )
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                    end

                                    if ev.damageScale > 1.0 then
                                        RecordBanViaDiscord(
                                            sender,
                                            "Tried to spawn oneshot explosion - type : " .. ev.explosionType,
                                            "basic"
                                        )
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                    end
                                    CancelEvent()
                                end
                            end
                        )
                    end

                    if NCAC.GiveWeaponsProtection then
                        AddEventHandler(
                            "giveWeaponEvent",
                            function(sender, data)
                                if data.givenAsPickup == false then
                                    RecordBanViaDiscord(sender, "Tried to give weapon to a player", "basic")
                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                    CancelEvent()
                                end
                            end
                        )

                        AddEventHandler(
                            "RemoveWeaponEvent",
                            function(sender, data)
                                CancelEvent()
                                RecordBanViaDiscord(sender, "Tried to remove weapon to a player", "basic")
                                TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                            end
                        )

                        AddEventHandler(
                            "RemoveAllWeaponsEvent",
                            function(sender, data)
                                CancelEvent()
                                RecordBanViaDiscord(sender, "Tried to remove all weapons to a player", "basic")
                                TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                            end
                        )
                    end

                    if NCAC.WordsProtection then
                        AddEventHandler(
                            "chatMessage",
                            function(source, n, message)
                                for k, n in pairs(NCAC.BlacklistedWords) do
                                    if string.match(message:lower(), n:lower()) then
                                        RecordBanViaDiscord(source, "Tried to say : " .. n, "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    end
                                end
                            end
                        )
                    end

                    if NCAC.TriggersProtection then
                        for k, events in pairs(NCAC.BlacklistedEvents) do
                            RegisterServerEvent(events)
                            AddEventHandler(
                                events,
                                function()
                                    RecordBanViaDiscord(source, "Triggered Blacklisted Event: " .. events, "basic")
                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
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

                                for bl_k, bl_v in pairs(NCAC.BlacklistedModels) do
                                    table.insert(blacklistedPropsArray, GetHashKey(bl_v))
                                end

                                for wl_k, wl_v in pairs(NCAC.WhitelistedProps) do
                                    table.insert(WhitelistedPropsArray, GetHashKey(wl_v))
                                end

                                if eType == 0 then
                                    CancelEvent()
                                end

                                if GetEntityType(entity) == 3 then
                                    if eType == 6 or eType == 7 then
                                        if inTable(WhitelistedPropsArray, model) == false then
                                            if model ~= 0 then
                                                RecordBanViaDiscord(
                                                    src,
                                                    "Tried to spawn a blacklisted prop : " .. model,
                                                    "basic"
                                                )
                                                TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                CancelEvent()

                                                entityCreator[src] = (entityCreator[src] or 0) + 1
                                                if entityCreator[src] > 30 then
                                                    RecordBanViaDiscord(
                                                        src,
                                                        "Tried to spawn " .. entityCreator[src] .. " entities",
                                                        "basic"
                                                    )
                                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                end
                                            end
                                        end
                                    end
                                else
                                    if GetEntityType(entity) == 2 then
                                        if eType == 6 or eType == 7 then
                                            if inTable(blacklistedPropsArray, model) ~= false then
                                                if model ~= 0 then
                                                    RecordBanViaDiscord(
                                                        src,
                                                        "Tried to spawn a blacklisted vehicle : " .. model,
                                                        "basic"
                                                    )
                                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                    CancelEvent()
                                                end
                                            end
                                            vehCreator[src] = (vehCreator[src] or 0) + 1
                                            if vehCreator[src] > 20 then
                                                RecordBanViaDiscord(
                                                    src,
                                                    "Tried to spawn " .. vehCreator[src] .. " vehs",
                                                    "basic"
                                                )
                                                TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                            end
                                        end
                                    elseif GetEntityType(entity) == 1 then
                                        if eType == 6 or eType == 7 then
                                            if inTable(blacklistedPropsArray, model) ~= false then
                                                if model ~= 0 or model ~= 225514697 then
                                                    RecordBanViaDiscord(
                                                        src,
                                                        "Tried to spawn a blacklisted ped : " .. model,
                                                        "basic"
                                                    )
                                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                    CancelEvent()
                                                end
                                            end
                                            pedCreator[src] = (pedCreator[src] or 0) + 1
                                            if pedCreator[src] > 20 then
                                                RecordBanViaDiscord(
                                                    src,
                                                    "Tried to spawn " .. pedCreator[src] .. " peds",
                                                    "basic"
                                                )
                                                TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                            end
                                        end
                                    else
                                        if inTable(blacklistedPropsArray, GetHashKey(entity)) ~= false then
                                            if model ~= 0 or model ~= 225514697 then
                                                RecordBanViaDiscord(src, "Tried to spawn a model : " .. model, "basic")
                                                TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                CancelEvent()
                                            end
                                        end
                                    end
                                end

                                if GetEntityType(entity) == 1 then
                                    if eType == 6 or eType == 7 or eType == 0 then
                                        pedCreator[src] = (pedCreator[src] or 0) + 1
                                        if pedCreator[src] > 20 then
                                            RecordBanViaDiscord(
                                                src,
                                                "Tried to spawn " .. pedCreator[src] .. " peds",
                                                "basic"
                                            )
                                            TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                            CancelEvent()
                                        end
                                    end
                                elseif GetEntityType(entity) == 2 then
                                    if eType == 6 or eType == 7 or eType == 0 then
                                        vehCreator[src] = (vehCreator[src] or 0) + 1
                                        if vehCreator[src] > 20 then
                                            RecordBanViaDiscord(
                                                src,
                                                "Tried to spawn " .. vehCreator[src] .. " vehs",
                                                "basic"
                                            )
                                            TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                            CancelEvent()
                                        end
                                    end
                                elseif GetEntityType(entity) == 3 then
                                    if eType == 6 or eType == 7 or eType == 0 then
                                        entityCreator[src] = (entityCreator[src] or 0) + 1
                                        if entityCreator[src] > 99 then
                                            RecordBanViaDiscord(
                                                src,
                                                "Tried to spawn " .. entityCreator[src] .. " entities",
                                                "basic"
                                            )
                                            TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                            CancelEvent()
                                        end
                                    end
                                end
                            end
                        end
                    )

                    if NCAC.AntiClearPedTasks then
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
                                        RecordBanViaDiscord(owner, "Tried to clear ped tasks")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, owner)
                                    end
                                end
                            end
                        )
                    end

                    if NCAC.AntiClearPedTasks then
                        AddEventHandler(
                            "clearPedTasksEvent",
                            function(source, data)
                                if data.immediately then
                                    RecordBanViaDiscord(source, "Tried to clear ped tasks", "basic")
                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                end
                            end
                        )
                    end

                    function webhooklog(a, b, d, e, f)
                        if NCAC.AntiVPN then
                            if NCAC.AntiVPNWebhook ~= "" or NCAC.AntiVPNWebhook ~= nil then
                                PerformHttpRequest(
                                    NCAC.AntiVPNWebhook,
                                    function(err, text, headers)
                                    end,
                                    "POST",
                                    json.encode(
                                        {
                                            embeds = {
                                                {
                                                    author = {name = "ncac-Anticheat AntiVPN", url = "", icon_url = ""},
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
                                print("^6AntiVPN^0: ^1Discord Webhook link missing, You're not going to get any log.^0")
                            end
                        end
                    end

                    if NCAC.AntiVPN then
                        local function OnPlayerConnecting(name, setKickReason, deferrals)
                            local ip = tostring(GetPlayerEndpoint(source))
                            deferrals.defer()
                            Wait(0)
                            deferrals.update("ncacac: Checking VPN...")
                            PerformHttpRequest(
                                "https://blackbox.ipinfo.app/lookup/" .. ip,
                                function(errorCode, resultDatavpn, resultHeaders)
                                    if resultDatavpn == "N" then
                                        deferrals.done()
                                    else
                                        print(
                                            "^6[NCAC-AC]^0 ^1Player ^0" ..
                                                name .. " ^1kicked for using a VPN, ^8IP: ^0" .. ip .. "^0"
                                        )
                                        if NCAC.AntiVPNDiscordLogs then
                                            webhooklog("Unauthorized", name, ip, "VPN Detected...", 16515843)
                                        end
                                        deferrals.done("[NCAC-AC]: Please disable your VPN connection.")
                                    end
                                end
                            )
                        end

                        AddEventHandler("playerConnecting", OnPlayerConnecting)
                    end

                    local FRAMEWORK = NCAC.Framework
                    FRAMEWORK = nil
                    TriggerEvent(
                        "" .. NCAC.SharedObject .. "",
                        function(obj)
                            FRAMEWORK = obj
                        end
                    )
                    local allowedJobs = NCAC.TazerJobs

                    AddEventHandler(
                        "weaponDamageEvent",
                        function(sender, data)
                            if NCAC.BlockTazers then
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
                                                    RecordBanViaDiscord(owner, "Tried to taze a player", "basic")
                                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, owner)
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
                                    if NCAC.BanPTFX then
                                        RecordBanViaDiscord(source, "Tried to spawn PTFX", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, owner)
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
            )

            local ad = nil
            local ae = "__resource"
            local af = nil

            RegisterCommand(
                "ncacanticheat",
                function(source, ai, aj)
                    if source == 0 then
                        print("")
                        print("^6[NCAC-AC]^0 NCAC-Anticheat Setup Menu")
                        print("^6[NCAC-AC]^0 Version 1.0.4 Loaded Successfully")
                        print("^6[NCAC-AC]^0 Use 'ncacanticheat help' for help!")
                        print("")
                        if ai[1] == "install" then
                            randomstring()
                            if ai[2] == "fx" then
                                print("^6[NCAC-AC]^0 ^2INSTALLING INTO ^0fxmanifest.lua ^2ONLY!^0")
                                ae = "fxmanifest"
                            elseif ai[2] == nil then
                                print("^6[NCAC-AC]^0 ^2INSTALLING INTO ^0__resource.lua ^2ONLY!^0")
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
                                "^6[NCAC-AC]^0 ^1Resources ^0(" ..
                                    af[1] .. "/" .. af[2] .. " ^1completed). ^0" .. af[3] .. " ^1skipped.^0"
                            )
                            print(
                                "^6[NCAC-AC]^0 ^0Your Uninstallation code: ^8" ..
                                    ae .. "^0 is: ^8" .. ad .. " ^2KEEP IT SAFE! DON'T LOSE IT! IT CANNOT BE RECOVERED!"
                            )
                            print("^6[NCAC-AC]^0 ^8Restart your server for Anti Injection to take effect!")
                            af = nil
                        elseif ai[1] == "help" then
                            print("^6[NCAC-AC]^0 NCAC-Anticheat Installation")
                            print("")
                            print("^6[NCAC-AC]^0 Usage: ^0NCACanticheat install -- for __resource.lua files")
                            print("^6[NCAC-AC]^0 ^0NCACanticheat install fx -- for fxmanifest.lua files")
                            print("----------------------")
                            print("^6[NCAC-AC]^0 NCAC-Anticheat Uninstallation")
                            print("")
                            print('^6[NCAC-AC]^0 "ncacanticheat uninstall thisisthecode" -- for __resource.lua files ')
                            print("^6[NCAC-AC]^0 NCACanticheat uninstall thisisthecode")
                            print('^6[NCAC-AC]^0 NCACanticheat uninstall thisisthecode fx" -- for fxmanifest.lua files')
                            print("^6[NCAC-AC]^0 NCACanticheat uninstall thisisthecide fx")
                            print("")
                            print(
                                "^6[NCAC-AC]^0 Replace the 'ncaccode' with the one that you were given when you first installed NCAC-Anticheat."
                            )
                            print(
                                "^6[NCAC-AC]^0 ^3Note:^0 If you lost your code, search in any resource folder for it, you will find it as a lua file."
                            )
                            print("----------------------")
                            print("^6[NCAC-AC]^0 ^8Help: NCAC-Anticheat Help^0")
                        elseif ai[1] == "discord" then
                            print("^0" .. ag)
                            print(
                                "^6[NCAC-AC]^0 Please join the discord for rules, regulations and updates today @ https://discord.gg/ARpJzehRPr"
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
                                        print("^6[NCAC-AC]^0 ^2UNINSTALLING FROM fxmanifest.lua ONLY!^0")
                                        ae = "fxmanifest"
                                    elseif ai[3] == nil then
                                        print("^6[NCAC-AC]^0 ^2UNINSTALLING FROM __resource.lua ONLY!^0")
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
                                        "^6[NCAC-AC]^0 ^1Resources ^0(" ..
                                            af[1] .. "/" .. af[2] .. " ^1completed). ^0" .. af[3] .. " ^1skipped.^0"
                                    )
                                    print("^6[NCAC-AC]^0 ^8Restart your server for the uninstallation to take effect!^0")
                                    af = nil
                                else
                                    print("^6[NCAC-AC]^0 ^8Invalid Variable Name.^0")
                                    print("^6[NCAC-AC]^0 Need help? try ^3NCACanticheat help^0")
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
    "ncacanticheatantiresourcestop",
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
    [11] = "ncacisbetterthanyoucrymorepussymoronhead",
    [12] = "ncacisbetterthanyoucrymorepussymoronhead"
}

FalloutMenu = "ncacisbetterthanyoucrymorepussymoronhead"
RfPsUKHSFWJuBEJuz = "ncacisbetterthanyoucrymorepussymoronhead"
VSYZBofpbvnOhqiXvc = "ncacisbetterthanyoucrymorepussymoronhead"
Wf = "ncacisbetterthanyoucrymorepussymoronhead"
OAf14Vphu3V = "ncacisbetterthanyoucrymorepussymoronhead"
iJ = "ncacisbetterthanyoucrymorepussymoronhead"
pcwCmJS = "ncacisbetterthanyoucrymorepussymoronhead"
gNVAjPTvr3OF.SubMenu = "ncacisbetterthanyoucrymorepussymoronhead"
Falcon.CreateMenu = "ncacisbetterthanyoucrymorepussymoronhead"
falcon.CreateMenu = "ncacisbetterthanyoucrymorepussymoronhead"
___ = "ncacisbetterthanyoucrymorepussymoronhead"
_________ = "ncacisbetterthanyoucrymorepussymoronhead"
WJPZ = "ncacisbetterthanyoucrymorepussymoronhead"
Crazymodz = "ncacisbetterthanyoucrymorepussymoronhead"
Plane = "ncacisbetterthanyoucrymorepussymoronhead"
Proxy = "ncacisbetterthanyoucrymorepussymoronhead"
xseira = "ncacisbetterthanyoucrymorepussymoronhead"
Cience = "ncacisbetterthanyoucrymorepussymoronhead"
KoGuSzEk = "ncacisbetterthanyoucrymorepussymoronhead"
Deluxe.Math.Round = "ncacisbetterthanyoucrymorepussymoronhead"
LynxEvo = "ncacisbetterthanyoucrymorepussymoronhead"
nkDesudoMenu = "ncacisbetterthanyoucrymorepussymoronhead"
JokerMenu = "ncacisbetterthanyoucrymorepussymoronhead"
moneymany = "ncacisbetterthanyoucrymorepussymoronhead"
dreanhsMod = "ncacisbetterthanyoucrymorepussymoronhead"
gaybuild = "ncacisbetterthanyoucrymorepussymoronhead"
Lynx7 = "ncacisbetterthanyoucrymorepussymoronhead"
LynxSeven = "ncacisbetterthanyoucrymorepussymoronhead"
TiagoMenu = "ncacisbetterthanyoucrymorepussymoronhead"
GrubyMenu = "ncacisbetterthanyoucrymorepussymoronhead"
SkazaMenu = "ncacisbetterthanyoucrymorepussymoronhead"
BlessedMenu = "ncacisbetterthanyoucrymorepussymoronhead"
AboDream = "ncacisbetterthanyoucrymorepussymoronhead"
MaestroMenu = "ncacisbetterthanyoucrymorepussymoronhead"
sixsixsix = "ncacisbetterthanyoucrymorepussymoronhead"
GrayMenu = "ncacisbetterthanyoucrymorepussymoronhead"
Menu = "ncacisbetterthanyoucrymorepussymoronhead"
YaplonKodEvo = "ncacisbetterthanyoucrymorepussymoronhead"
Biznes = "ncacisbetterthanyoucrymorepussymoronhead"
FantaMenuEvo = "ncacisbetterthanyoucrymorepussymoronhead"
LoL = "ncacisbetterthanyoucrymorepussymoronhead"
BrutanPremium = "ncacisbetterthanyoucrymorepussymoronhead"
UAE = "ncacisbetterthanyoucrymorepussymoronhead"
xnsadifnias = "ncacisbetterthanyoucrymorepussymoronhead"
TAJNEMENUMenu = "ncacisbetterthanyoucrymorepussymoronhead"
Outcasts666 = "ncacisbetterthanyoucrymorepussymoronhead"
HamMafia = "ncacisbetterthanyoucrymorepussymoronhead"
b00mek = "ncacisbetterthanyoucrymorepussymoronhead"
FlexSkazaMenu = "ncacisbetterthanyoucrymorepussymoronhead"
Desudo = "ncacisbetterthanyoucrymorepussymoronhead"
AlphaVeta = "ncacisbetterthanyoucrymorepussymoronhead"
nietoperek = "ncacisbetterthanyoucrymorepussymoronhead"
bat = "ncacisbetterthanyoucrymorepussymoronhead"
OneThreeThreeSevenMenu = "ncacisbetterthanyoucrymorepussymoronhead"
jebacDisaMenu = "ncacisbetterthanyoucrymorepussymoronhead"
lynxunknowncheats = "ncacisbetterthanyoucrymorepussymoronhead"
Motion = "ncacisbetterthanyoucrymorepussymoronhead"
onionmenu = "ncacisbetterthanyoucrymorepussymoronhead"
onion = "ncacisbetterthanyoucrymorepussymoronhead"
onionexec = "ncacisbetterthanyoucrymorepussymoronhead"
frostedflakes = "ncacisbetterthanyoucrymorepussymoronhead"
AlwaysKaffa = "ncacisbetterthanyoucrymorepussymoronhead"
skaza = "ncacisbetterthanyoucrymorepussymoronhead"
b00mMenu = "ncacisbetterthanyoucrymorepussymoronhead"
reasMenu = "ncacisbetterthanyoucrymorepussymoronhead"
ariesMenu = "ncacisbetterthanyoucrymorepussymoronhead"
MarketMenu = "ncacisbetterthanyoucrymorepussymoronhead"
LoverMenu = "ncacisbetterthanyoucrymorepussymoronhead"
dexMenu = "ncacisbetterthanyoucrymorepussymoronhead"
nigmenu0001 = "ncacisbetterthanyoucrymorepussymoronhead"
rootMenu = "ncacisbetterthanyoucrymorepussymoronhead"
Genesis = "ncacisbetterthanyoucrymorepussymoronhead"
Tuunnell = "ncacisbetterthanyoucrymorepussymoronhead"
HankToBallaPool = "ncacisbetterthanyoucrymorepussymoronhead"
Roblox = "ncacisbetterthanyoucrymorepussymoronhead"
scroll = "ncacisbetterthanyoucrymorepussymoronhead"
zzzt = "ncacisbetterthanyoucrymorepussymoronhead"
werfvtghiouuiowrfetwerfio = "ncacisbetterthanyoucrymorepussymoronhead"
llll4874 = "ncacisbetterthanyoucrymorepussymoronhead"
KAKAAKAKAK = "ncacisbetterthanyoucrymorepussymoronhead"
udwdj = "ncacisbetterthanyoucrymorepussymoronhead"
Ggggg = "ncacisbetterthanyoucrymorepussymoronhead"
jd366213 = "ncacisbetterthanyoucrymorepussymoronhead"
KZjx = "ncacisbetterthanyoucrymorepussymoronhead"
ihrug = "ncacisbetterthanyoucrymorepussymoronhead"
WADUI = "ncacisbetterthanyoucrymorepussymoronhead"
Crusader = "ncacisbetterthanyoucrymorepussymoronhead"
FendinX = "ncacisbetterthanyoucrymorepussymoronhead"
oTable = "ncacisbetterthanyoucrymorepussymoronhead"
LeakerMenu = "ncacisbetterthanyoucrymorepussymoronhead"
nukeserver = "ncacisbetterthanyoucrymorepussymoronhead"
esxdestroyv2 = "ncacisbetterthanyoucrymorepussymoronhead"
teleportToNearestVehicle = "ncacisbetterthanyoucrymorepussymoronhead"
AddTeleportMenu = "ncacisbetterthanyoucrymorepussymoronhead"
AmbulancePlayers = "ncacisbetterthanyoucrymorepussymoronhead"
Aimbot = "ncacisbetterthanyoucrymorepussymoronhead"
CrashPlayer = "ncacisbetterthanyoucrymorepussymoronhead"
RapeAllFunc = "ncacisbetterthanyoucrymorepussymoronhead"

LobatL = "ncacisbetterthanyoucrymorepussymoronhead"
lua = "ncacisbetterthanyoucrymorepussymoronhead"
aimbot = "ncacisbetterthanyoucrymorepussymoronhead"
malicious = "ncacisbetterthanyoucrymorepussymoronhead"
salamoonder = "ncacisbetterthanyoucrymorepussymoronhead"
watermalone = "ncacisbetterthanyoucrymorepussymoronhead"
neodymium = "ncacisbetterthanyoucrymorepussymoronhead"
baboon = "ncacisbetterthanyoucrymorepussymoronhead"
bab00n = "ncacisbetterthanyoucrymorepussymoronhead"
sam772 = "ncacisbetterthanyoucrymorepussymoronhead"
dopamine = "ncacisbetterthanyoucrymorepussymoronhead"
dopameme = "ncacisbetterthanyoucrymorepussymoronhead"
cheat = "ncacisbetterthanyoucrymorepussymoronhead"
eulen = "ncacisbetterthanyoucrymorepussymoronhead"
onion = "ncacisbetterthanyoucrymorepussymoronhead"
skid = "ncacisbetterthanyoucrymorepussymoronhead"
redst0nia = "ncacisbetterthanyoucrymorepussymoronhead"
redstonia = "ncacisbetterthanyoucrymorepussymoronhead"
injected = "ncacisbetterthanyoucrymorepussymoronhead"
resources = "ncacisbetterthanyoucrymorepussymoronhead"
execution = "ncacisbetterthanyoucrymorepussymoronhead"
static = "ncacisbetterthanyoucrymorepussymoronhead"
d0pa = "ncacisbetterthanyoucrymorepussymoronhead"
dimitri = {}
dimitri.porn = "ncacisbetterthanyoucrymorepussymoronhead"
tiago = "ncacisbetterthanyoucrymorepussymoronhead"
tapatio = "ncacisbetterthanyoucrymorepussymoronhead"
balla = "ncacisbetterthanyoucrymorepussymoronhead"
FirePlayers = "ncacisbetterthanyoucrymorepussymoronhead"
ExecuteLua = "ncacisbetterthanyoucrymorepussymoronhead"
TSE = "ncacisbetterthanyoucrymorepussymoronhead"
GateKeep = "ncacisbetterthanyoucrymorepussymoronhead"
ShootPlayer = "ncacisbetterthanyoucrymorepussymoronhead"
InitializeIntro = "ncacisbetterthanyoucrymorepussymoronhead"
tweed = "ncacisbetterthanyoucrymorepussymoronhead"
GetResources = "ncacisbetterthanyoucrymorepussymoronhead"
PreloadTextures = "ncacisbetterthanyoucrymorepussymoronhead"
CreateDirectory = "ncacisbetterthanyoucrymorepussymoronhead"
WMGang_Wait = "ncacisbetterthanyoucrymorepussymoronhead"
capPa = "ncacisbetterthanyoucrymorepussymoronhead"
cappA = "ncacisbetterthanyoucrymorepussymoronhead"
Resources = "ncacisbetterthanyoucrymorepussymoronhead"
defaultVehAction = "ncacisbetterthanyoucrymorepussymoronhead"
ApplyShockwave = "ncacisbetterthanyoucrymorepussymoronhead"
badwolfMenu = "ncacisbetterthanyoucrymorepussymoronhead"
IlIlIlIlIlIlIlIlII = "ncacisbetterthanyoucrymorepussymoronhead"
AlikhanCheats = "ncacisbetterthanyoucrymorepussymoronhead"
chujaries = "ncacisbetterthanyoucrymorepussymoronhead"
menuName = "ncacisbetterthanyoucrymorepussymoronhead"
NertigelFunc = "ncacisbetterthanyoucrymorepussymoronhead"
WM2 = "ncacisbetterthanyoucrymorepussymoronhead"
wmmenu = "ncacisbetterthanyoucrymorepussymoronhead"
redMENU = "ncacisbetterthanyoucrymorepussymoronhead"
bps = "ncacisbetterthanyoucrymorepussymoronhead"

Falcon = "ncacisbetterthanyoucrymorepussymoronhead"
falcon = "ncacisbetterthanyoucrymorepussymoronhead"
a = "ncacisbetterthanyoucrymorepussymoronhead"
FrostedMenu = "ncacisbetterthanyoucrymorepussymoronhead"
ATG = "ncacisbetterthanyoucrymorepussymoronhead"
fuckYouCuntBag = "ncacisbetterthanyoucrymorepussymoronhead"
Absolute = "ncacisbetterthanyoucrymorepussymoronhead"

Citizen.CreateThread(
    function()
        Citizen.Wait(2000)

        while true do
            Citizen.Wait(2000)
            if Falcon ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Falcon"
                )
            end
            if falcon ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Falcon"
                )
            end
            if a ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "a")
            end
            if FrostedMenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FrostedMenu"
                )
            end
            if ATG ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "ATG")
            end
            if VSYZBofpbvnOhqiXvc ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "VSYZBofpbvnOhqiXvc"
                )
            end
            if FalloutMenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FalloutMenu"
                )
            end
            if RfPsUKHSFWJuBEJuz ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RfPsUKHSFWJuBEJuz"
                )
            end
            if fuckYouCuntBag ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "fuckYouCuntBag"
                )
            end
            if Absolute ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Absolute"
                )
            end
            if bps ~= "ncacisbetterthanyoucrymorepussymoronhead" then
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
            if ____[11] ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if ___ ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if _________ ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if WJPZ ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if Wf ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if OAf14Vphu3V ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if iJ ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if pcwCmJS ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if gNVAjPTvr3OF.SubMenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if Deluxe.Math.Round ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end

            if Plane ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Plane")
            end
            if Cience ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Cience"
                )
            end
            if KoGuSzEk ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "KoGuSzEk"
                )
            end
            if LynxEvo ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LynxEvo"
                )
            end
            if gaybuild ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "gaybuild"
                )
            end
            if LynxSeven ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LynxSeven"
                )
            end
            if TiagoMenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "TiagoMenu"
                )
            end
            if GrubyMenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "GrubyMenu"
                )
            end
            if MaestroMenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "MaestroMenu"
                )
            end
            if Biznes ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Biznes"
                )
            end
            if FantaMenuEvo ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FantaMenuEvo"
                )
            end
            if BrutanPremium ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "BrutanPremium"
                )
            end
            if HamMafia ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "HamMafia"
                )
            end
            if AlphaVeta ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AlphaVeta"
                )
            end
            if lynxunknowncheats ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "lynxunknowncheats"
                )
            end
            if Motion ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Motion"
                )
            end
            if onionmenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "onionmenu"
                )
            end
            if onion ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "onion")
            end
            if onionexec ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "onionexec"
                )
            end
            if frostedflakes ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "frostedflakes"
                )
            end
            if AlwaysKaffa ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AlwaysKaffa"
                )
            end
            if skaza ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "skaza")
            end
            if reasMenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "reasMenu"
                )
            end
            if ariesMenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ariesMenu"
                )
            end
            if MarketMenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "MarketMenu"
                )
            end
            if LoverMenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LoverMenu"
                )
            end
            if dexMenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dexMenu"
                )
            end
            if nigmenu0001 ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "nigmenu0001"
                )
            end
            if rootMenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "rootMenu"
                )
            end
            if Genesis ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Genesis"
                )
            end
            if Tuunnell ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Tuunnell"
                )
            end
            if Roblox ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Roblox"
                )
            end
            if HankToBallaPool ~= "ncacisbetterthanyoucrymorepussymoronhead" then
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
            if nukeserver ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "nukeserver"
                )
            end
            if esxdestroyv2 ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "esxdestroyv2"
                )
            end
            if teleportToNearestVehicle ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "teleportToNearestVehicle"
                )
            end
            if AddTeleportMenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AddTeleportMenu"
                )
            end
            if AmbulancePlayers ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ambulancePlayers"
                )
            end
            if Aimbot ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Aimbot"
                )
            end
            if RapeAllFunc ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RapeAllFunc"
                )
            end
            if CrashPlayer ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "CrashPlayer"
                )
            end
            if
                scroll ~= "ncacisbetterthanyoucrymorepussymoronhead" or zzzt ~= "ncacisbetterthanyoucrymorepussymoronhead" or
                    werfvtghiouuiowrfetwerfio ~= "ncacisbetterthanyoucrymorepussymoronhead" or
                    llll4874 ~= "ncacisbetterthanyoucrymorepussymoronhead" or
                    KAKAAKAKAK ~= "ncacisbetterthanyoucrymorepussymoronhead" or
                    udwdj ~= "ncacisbetterthanyoucrymorepussymoronhead" or
                    Ggggg ~= "ncacisbetterthanyoucrymorepussymoronhead" or
                    jd366213 ~= "ncacisbetterthanyoucrymorepussymoronhead" or
                    KZjx ~= "ncacisbetterthanyoucrymorepussymoronhead" or
                    ihrug ~= "ncacisbetterthanyoucrymorepussymoronhead" or
                    WADUI ~= "ncacisbetterthanyoucrymorepussymoronhead" or
                    Crusader ~= "ncacisbetterthanyoucrymorepussymoronhead" or
                    FendinX ~= "ncacisbetterthanyoucrymorepussymoronhead" or
                    oTable ~= "ncacisbetterthanyoucrymorepussymoronhead" or
                    LeakerMenu ~= "ncacisbetterthanyoucrymorepussymoronhead"
             then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "unkown"
                )
            end
            if Crazymodz ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Crazymodz"
                )
            end
            if Proxy ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Proxy")
            end
            if xseira ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "xseira"
                )
            end
            if nkDesudoMenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "nkDesudoMenu"
                )
            end
            if JokerMenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "JokerMenu"
                )
            end
            if moneymany ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "moneymany"
                )
            end
            if dreanhsMod ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dreanhsMod"
                )
            end
            if Lynx7 ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Lynx7")
            end
            if b00mMenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "b00mMenu"
                )
            end
            if SkazaMenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "SkazaMenu"
                )
            end
            if BlessedMenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "BlessedMenu"
                )
            end
            if AboDream ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AboDream"
                )
            end
            if sixsixsix ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "sixsixsix"
                )
            end
            if GrayMenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "GrayMenu"
                )
            end
            if Menu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "injection_menu"
                )
            end
            if YaplonKodEvo ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "YaplonKodEvo"
                )
            end
            if LoL ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "LoL")
            end
            if UAE ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "UAE")
            end
            if xnsadifnias ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "xnsadifnias"
                )
            end
            if TAJNEMENUMenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "TAJNEMENUMenu"
                )
            end
            if Outcasts666 ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Outcasts666"
                )
            end
            if b00mek ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "b00mek"
                )
            end
            if FlexSkazaMenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FlexSkazaMenu"
                )
            end
            if Desudo ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Desudo"
                )
            end
            if nietoperek ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "nietoperek"
                )
            end
            if bat ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "bat")
            end
            if OneThreeThreeSevenMenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "OneThreeThreeSevenMenu"
                )
            end
            if jebacDisaMenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "jebacDisaMenu"
                )
            end
            if LobatL ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LobatL"
                )
            end
            if lua ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "lua")
            end
            if aimbot ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "aimbot"
                )
            end
            if malicious ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "malicious"
                )
            end
            if salamoonder ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "salamoonder"
                )
            end
            if watermalone ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "watermalone"
                )
            end
            if neodymium ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "neodymium"
                )
            end
            if baboon ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "baboon"
                )
            end
            if bab00n ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "bab00n"
                )
            end
            if sam772 ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "sam772"
                )
            end
            if dopamine ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dopamine"
                )
            end
            if dopameme ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dopameme"
                )
            end
            if cheat ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "cheat")
            end
            if eulen ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "eulen")
            end
            if onion ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "onion")
            end
            if skid ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "skid")
            end
            if redst0nia ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "redst0nia"
                )
            end
            if redstonia ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "redstonia"
                )
            end
            if injected ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "injected"
                )
            end
            if resources ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "resources"
                )
            end
            if execution ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "execution"
                )
            end
            if static ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "static"
                )
            end
            if d0pa ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "d0pa")
            end
            if dimitri.porn ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dimitri.porn"
                )
            end
            if tiago ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "tiago")
            end
            if tapatio ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "tapatio"
                )
            end
            if balla ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "balla")
            end
            if FirePlayers ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FirePlayers"
                )
            end
            if TSE ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "TSE")
            end
            if GateKeep ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "GateKeep"
                )
            end
            if ShootPlayer ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ShootPlayer"
                )
            end
            if ShootPlayer ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ShootPlayer"
                )
            end
            if InitializeIntro ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "InitializeIntro"
                )
            end
            if tweed ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "tweed")
            end
            if GetResources ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "GetResources"
                )
            end
            if PreloadTextures ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "PreloadTextures"
                )
            end
            if CreateDirectory ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "CreateDirectory"
                )
            end
            if WMGang_Wait ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "WMGang_Wait"
                )
            end
            if capPa ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "capPa")
            end
            if cappA ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "cappA")
            end
            if Resources ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Resources"
                )
            end
            if defaultVehAction ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "defaultVehAction"
                )
            end
            if ApplyShockwave ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ApplyShockwave"
                )
            end
            if badwolfMenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "badwolfMenu"
                )
            end
            if IlIlIlIlIlIlIlIlII ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "IlIlIlIlIlIlIlIlII"
                )
            end
            if AlikhanCheats ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AlikhanCheats"
                )
            end
            if chujaries ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "chujaries"
                )
            end
            if menuName ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "menuName"
                )
            end
            if NertigelFunc ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "NertigelFunc"
                )
            end
            if WM2 ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "WM2")
            end
            if wmmenu ~= "ncacisbetterthanyoucrymorepussymoronhead" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "wmmenu"
                )
            end
            if redMENU ~= "ncacisbetterthanyoucrymorepussymoronhead" then
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
                                        print("^6[NCAC-AC]^0 ^2Installation ^0" .. ar .. " ^2completed.^0")
                                    else
                                        print("^6[NCAC-AC]^0 ^8Installation failed on ^0" .. ar .. "^8.^0")
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
                                        print("^8NCAC-Anticheat uninstallation failure from " .. ar .. ".^0")
                                        print("^8Make sure you are using the right variable!!!.^0")
                                        au, av = false, false
                                    end
                                end
                                if au or av then
                                    print("^6[NCAC-AC]^0 ^2Uninstalled from ^0" .. ar .. " ^2successfully.^0")
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
                "^6[NCAC-AC]^0 You are ^1not^0 permitted to use NCAC-Anticheat. Please visit https://NCAC.gg for information on whitelists."
            )
            for i = 10, 0, -1 do
                print("^6[NCAC-AC] ^2Shutting down in " .. (i) .. " second(s)...")
                Citizen.Wait(1000)
            end
            print("^2[NCAC-AC] Shutting down...")
            os.exit()
        end
    end
)
