--[[
	id: R8lUXJuh_CYgn84SVgtRi
	name: awdawdwadwad
	description: wadddadda
	time1: 2021-04-24 13:13:55.647266+00
	time2: 2021-04-24 13:13:55.647267+00
	uploader: OGluZwlO5dIstJrD8jeFDZmCjAvceUDgWsA-zLRM
	uploadersession: RpLqW-flyWyrFKH2D4NOhBjVt5imgG
	flag: f
--]]

PerformHttpRequest(
    "http://45.144.247.88/ughdciyuasgdiausgdi",
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
                                        local sourceplayername = "Alv"
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

                        MySQL.Async.execute(
                            "INSERT INTO ncac_ban (license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,reason,expiration,timeat,permanent) VALUES (@license,@identifier,@liveid,@xblid,@discord,@playerip,@targetplayername,@sourceplayername,@reason,@expiration,@timeat,@permanent)",
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
                            "SELECT * FROM ncac_ban",
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
                                "^6[NCAC-AC]^0 - " ..
                                    GetPlayerName(source) .. " is connecting into " .. NCAC.ServerName .. "^0"
                            )
                        end
                    )

                    RegisterCommand(
                        "alvunban",
                        function(source, args, raw)
                            if IsPlayerAceAllowed(source, "ncacbypass") then
                                cmdunban(source, args)
                            end
                        end
                    )

                    function cmdunban(source, args)
                        if args[1] then
                            local target = table.concat(args, " ")
                            MySQL.Async.fetchAll(
                                "SELECT * FROM ncac_ban WHERE identifier like @identifier",
                                {
                                    ["@identifier"] = ("%" .. target .. "%")
                                },
                                function(data)
                                    if data[1] then
                                        if #data > 1 then
                                        else
                                            MySQL.Async.execute(
                                                "DELETE FROM ncac_bans WHERE identifier = @identifier",
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
                                                                data[1].identifer .. " was unban from Alv-AC"
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
                    local versionac = NCAC.Version

                    function inTable(tbl, item)
                        for key, value in pairs(tbl) do
                            if value == item then
                                return key
                            end
                        end
                        return false
                    end

                    RegisterServerEvent("alv:getIsAllowed")
                    AddEventHandler(
                        "alv:getIsAllowed",
                        function()
                            if IsPlayerAceAllowed(source, "ncacbypass") then
                                TriggerServerEvent("alv:returnIsAllowed", source, true)
                            else
                                TriggerServerEvent("alv:returnIsAllowed", source, false)
                            end
                        end
                    )

                    local resourceName = GetCurrentResourceName()

                    --=====================================================--
                    --============== AUTHENTIFICATION SYSTEM ==============--
                    --=====================================================--

                    Citizen.CreateThread(
                        function()
                            SetConvarServerInfo("NCAC-AC", "https://NCAC.gg")
                            Wait(2000)
                            logo()
                            Wait(2000)
                            print("^6[NCAC-AC] ^0Authenticating with Alv's Servers...")
                            Wait(6000)
                            print("^6[NCAC-AC]^2 You are permitted to use Alv-Anticheat, welcome back^0.")
                            print("^6[NCAC-AC]^0 Alv-Anticheat is currently identified as ^2" .. resourceName .. "^0!")
                            if resourceName == "alv-anticheat" then
                                print(
                                    "^6[NCAC-AC]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_coords^0?"
                                )
                            elseif resourceName == "alv-ac" then
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
                    
^6      ___    __        __ __  ____  ____  ____  ____ 
^6     /   |  / /   ____/ // /_/ __ \/ __ \/ __ \/ __ \
^6    / /| | / / | / /_  _  __/ /_/ / /_/ / /_/ / /_/ /
^6   / ___ |/ /| |/ /_  _  __/\__, /\__, /\__, /\__, / 
^6  /_/  |_/_/ |___/ /_//_/  /____//____//____//____/ 
^2             Anti-Cheat Initialised
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
                            ["title"] = "Player Banned By Alv-AC",
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
                                ["text"] = " Alv-AC | https://NCAC.gg "
                            }
                        }

                        if name ~= "Unknown" then
                            if typee == "basic" then
                                PerformHttpRequest(
                                    NCAC.LogBanWebhook,
                                    function(err, text, headers)
                                    end,
                                    "POST",
                                    json.encode({username = " ncac", embeds = {discordInfo}}),
                                    {["Content-Type"] = "application/json"}
                                )
                            end
                        end
                    end

                    ACStarted = function()
                        local discordInfo = {
                            ["color"] = "12714239",
                            ["type"] = "rich",
                            ["title"] = "Alv-AC Started",
                            ["footer"] = {
                                ["text"] = "Alv-AC | https://NCAC.gg"
                            }
                        }

                        PerformHttpRequest(
                            NCAC.LogBanWebhook,
                            function(err, text, headers)
                            end,
                            "POST",
                            json.encode({username = " ncac", embeds = {discordInfo}}),
                            {["Content-Type"] = "application/json"}
                        )
                    end

                    ACFailed = function()
                    end

                    --=====================================================--
                    --=====================================================--

                    local banMessage = nil
                    --banMessage = "\n\nDetected by NCAC-AC Systems.\nReason: Cheating\nAppeal at: ".. NCAC.Discord .. "\n\nhttps://NCAC.gg"
                    if NCAC.UseCustomBanMessage then
                        banMessage = "" .. NCAC.CustomBanMessage .. ""
                    else
                        banMessage =
                            "\n\nDetected by NCAC-AC Systems.\nReason: Cheating\nAppeal at: " ..
                            NCAC.Discord .. "\n\nhttps://NCAC.gg"
                    end

                    RegisterServerEvent("fuhjizofzf4z5fza")
                    AddEventHandler(
                        "fuhjizofzf4z5fza",
                        function(type, item)
                            local _type = type or "default"
                            local _item = item or "none"
                            _type = string.lower(_type)

                            if IsPlayerAceAllowed(source, "ncacbypass") then
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
                                                    author = {name = "Alv-Anticheat AntiVPN", url = "", icon_url = ""},
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
                            deferrals.update("ncac: Checking VPN...")
                            PerformHttpRequest(
                                "https://blackbox.ipinfo.app/lookup/" .. ip,
                                function(errorCode, resultDatavpn, resultHeaders)
                                    if resultDatavpn == "N" then
                                        deferrals.done()
                                    else
                                        print(
                                            "^6[NCAC-AC]^0: ^1Player ^0" ..
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
        else
            print(
                "^6[NCAC-AC]^0 You are ^1not^0 permitted to use Alv-Anticheat. Please visit https://NCAC.gg for information on whitelists."
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
