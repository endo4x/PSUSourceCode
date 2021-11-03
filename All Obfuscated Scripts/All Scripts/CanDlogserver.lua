--[[
	id: _S2koEMq7eUTnemyUC97-
	name: Can Dlog - server
	description: Can Dlog - server
	time1: 2021-04-29 23:11:46.555982+00
	time2: 2021-04-29 23:11:46.555982+00
	uploader: 0lXSC9Q-U1coaa_LJ3Y4z0ksSbDtOnFnk-FHONUw
	uploadersession: bT8lPMVQRr9_avVe8cLBcyHEwpKwPL
	flag: f
--]]

ESX = nil
TriggerEvent(
    "esx:getSharedObject",
    function(obj)
        ESX = obj
    end
)

RegisterNetEvent("esx:canlog")
AddEventHandler(
    "esx:canlog",
    function()
        local xPlayer = ESX.GetPlayerFromId(source)
        local nome = xPlayer.getName()
        local gruppo = xPlayer.getGroup()
        local lavoro = xPlayer.job.name
        local grado = xPlayer.job.grade
        -- local permessi = xPlayer.getPermissions()
        local soldi = xPlayer.getMoney()
        local soldi2 = xPlayer.getAccount("bank").money
        local ip = GetPlayerEndpoint(source)
        local ping = GetPlayerPing(source)
        local ids = ExtractIdentifiers(source)
        if Config.xblID then
            xblID = "\n**Xbox ID:  ** " .. ids.xbl .. ""
        else
            xblID = ""
        end
        if Config.steamID then
            _steamID = "\n**Steam ID:  ** " .. ids.steam .. ""
        else
            _steamID = ""
        end
        if Config.liveID then
            _liveID = "\n**Live ID:  ** " .. ids.live .. ""
        else
            _liveID = ""
        end
        if Config.playerID then
            _playerID = "\n**Player ID:  ** " .. source .. ""
        else
            _playerID = ""
        end
        if Config.discordID then
            _discordID = "\n**Discord ID:  ** <@" .. ids.discord:gsub("discord:", "") .. ">"
        else
            _discordID = ""
        end
        if Config.licenseID then
            _licenseID = "\n**License ID:  ** " .. ids.license .. ""
        else
            _licenseID = ""
        end
        if Config.steamURL then
            _steamURL =
                "\n\n **Steam Url  **https://steamcommunity.com/profiles/" ..
                tonumber(ids.steam:gsub("steam:", ""), 16) .. ""
        else
            _steamURL = ""
        end
        renterdiscord(
            "**Sunucuya giriş yaptı:**" ..
                nome ..
                    "\n" ..
                        _playerID ..
                            "\n " ..
                                _steamID ..
                                    " " ..
                                        _steamURL ..
                                            "\n" ..
                                                _discordID ..
                                                    "\n" ..
                                                        _licenseID ..
                                                            "\n" ..
                                                                xblID ..
                                                                    "\n" ..
                                                                        _liveID ..
                                                                            "\n\n**IP:**" ..
                                                                                ip ..
                                                                                    "\n\n**Ping:** " ..
                                                                                        ping ..
                                                                                            "\n\n**Grup:**" ..
                                                                                                gruppo ..
                                                                                                    "\n\n**Money: **" ..
                                                                                                        soldi ..
                                                                                                            "\n\n**Money Bank: **" ..
                                                                                                                soldi2 ..
                                                                                                                    "\n\n**Meslek: **" ..
                                                                                                                        lavoro ..
                                                                                                                            "\n\n**Meslek rütbesi: **" ..
                                                                                                                                grado ..
                                                                                                                                    ""
        )
    end
)

function renterdiscord(message)
    local content = {
        {
            ["color"] = "3863105", --verde
            ["title"] = "esx_canlogs",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "© 'Can#2526 - " .. os.date()
            }
        }
    }

    PerformHttpRequest(
        Config.giriswebhook,
        function(err, text, headers)
        end,
        "POST",
        json.encode({username = name, embeds = content}),
        {["Content-Type"] = "application/json"}
    )
end

AddEventHandler(
    "playerDropped",
    function()
        local xPlayer = ESX.GetPlayerFromId(source)
        local nome = xPlayer.getName()
        local gruppo = xPlayer.getGroup()
        local lavoro = xPlayer.job.name
        local grado = xPlayer.job.grade
        -- local permessi = xPlayer.getPermissions()
        local soldi = xPlayer.getMoney()
        local soldi2 = xPlayer.getAccount("bank").money
        local ip = GetPlayerEndpoint(source)
        local ping = GetPlayerPing(source)
        local ids = ExtractIdentifiers(source)
        if Config.xblID then
            xblID = "\n**Xbox ID:  ** " .. ids.xbl .. ""
        else
            xblID = ""
        end
        if Config.steamID then
            _steamID = "\n**Steam ID:  ** " .. ids.steam .. ""
        else
            _steamID = ""
        end
        if Config.liveID then
            _liveID = "\n**Live ID:  ** " .. ids.live .. ""
        else
            _liveID = ""
        end
        if Config.playerID then
            _playerID = "\n**Player ID:  ** " .. source .. ""
        else
            _playerID = ""
        end
        if Config.discordID then
            _discordID = "\n**Discord ID:  ** <@" .. ids.discord:gsub("discord:", "") .. ">"
        else
            _discordID = ""
        end
        if Config.licenseID then
            _licenseID = "\n**License ID:  ** " .. ids.license .. ""
        else
            _licenseID = ""
        end
        if Config.steamURL then
            _steamURL =
                "\n\n **Steam Url  **https://steamcommunity.com/profiles/" ..
                tonumber(ids.steam:gsub("steam:", ""), 16) .. ""
        else
            _steamURL = ""
        end
        rexitdiscord(
            "**Sunucudan ayrıldı:  **" ..
                nome ..
                    "\n" ..
                        _playerID ..
                            "\n " ..
                                _steamID ..
                                    " " ..
                                        _steamURL ..
                                            "\n" ..
                                                _discordID ..
                                                    "\n" ..
                                                        _licenseID ..
                                                            "\n" ..
                                                                xblID ..
                                                                    "\n" ..
                                                                        _liveID ..
                                                                            "\n\n**IP:  **" ..
                                                                                ip ..
                                                                                    "\n\n**Ping:  ** " ..
                                                                                        ping ..
                                                                                            "\n\n**Group:  **" ..
                                                                                                gruppo ..
                                                                                                    "\n\n**Money:  **" ..
                                                                                                        soldi ..
                                                                                                            "\n\n**Money Bank: **" ..
                                                                                                                soldi2 ..
                                                                                                                    "\n\n**Meslek: **" ..
                                                                                                                        lavoro ..
                                                                                                                            "\n\n**Meslek rütbesi: **" ..
                                                                                                                                grado ..
                                                                                                                                    ""
        )
    end
)

function rexitdiscord(message)
    local content = {
        {
            ["color"] = "15874618", --rosso
            ["title"] = "esx_canlogs",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "© 'Can#2526 - " .. os.date("")
            }
        }
    }

    PerformHttpRequest(
        Config.cikiswebhook,
        function(err, text, headers)
        end,
        "POST",
        json.encode({username = name, embeds = content}),
        {["Content-Type"] = "application/json"}
    )
end
RegisterServerEvent("ClientDiscord")
AddEventHandler(
    "ClientDiscord",
    function(message, color, channel)
        discordLog(message, color, channel)
    end
)

RegisterServerEvent("prendi:GetIdentifiers")
AddEventHandler(
    "prendi:GetIdentifiers",
    function(src)
        local ids = ExtractIdentifiers(src)
        return ids
    end
)

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end
