--[[
	id: HH-Dd8y9htwQis2DFuKvo
	name: shield_functions_pre
	description: shield_functions_pre
	time1: 2021-06-01 12:50:24.09992+00
	time2: 2021-06-01 12:50:24.099921+00
	uploader: RvQrAbi1z5Qa7DGokdNBOxigrkzFr6j8aZTB6eiv
	uploadersession: p8lRlwW2LkzD_KNseDpqBDrV2cGOTE
	flag: f
--]]


-- Screenshot logs

RegisterNetEvent('shield:Screenshot')
AddEventHandler('shield:Screenshot', function()
    local src = source;
    if not doesPlayerHavePerms(src, Shield.Bypass) then
        local screenshotOptions = {
            encoding = 'png',
            quality = 1
        }    
        local ids = ExtractIdentifiers(src);
        local playerIP = ids.ip;
        local playerSteam = ids.steam;
        local playerLicense = ids.license;
        local playerXbl = ids.xbl;
        local playerLive = ids.live;
        local playerDisc = ids.discord;
        exports['discord-screenshot']:requestCustomClientScreenshotUploadToDiscord(src, Shield.Screenshotwebhook, screenshotOptions, {
            username = '[fiveShield]',
            avatar_url = 'https://discord.gg/HVpCubWHAM',
            content = '',
            embeds = {
                {
                    color = 16711680,
                    author = {
                        name = '[fiveShield]',
                        icon_url = 'https://i.ibb.co/5R3XKjr/fiveshield.png'
                    },
                    title = '[Possible Modder]',
                    description = '**__Player Identifiers:__** \n\n'
                    .. '**Server ID:** `' .. src .. '`\n\n'
                    .. '**Username:** `' .. GetPlayerName(src) .. '`\n\n'
                    .. '**IP:** `' .. playerIP .. '`\n\n'
                    .. '**Steam:** `' .. playerSteam .. '`\n\n'
                    .. '**License:** `' .. playerLicense .. '`\n\n'
                    .. '**Xbl:** `' .. playerXbl .. '`\n\n'
                    .. '**Live:** `' .. playerLive .. '`\n\n'
                    .. '**Discord:** `' .. playerDisc .. '`\n\n',
                    footer = {
                        text = "[" .. src .. "]" .. GetPlayerName(src),
                    }
                }
            }
        });
    end
end)

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    --Loop over all identifiers
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        --Convert it to a nice table.
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