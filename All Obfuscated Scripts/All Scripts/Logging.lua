--[[
	id: Lay7mvhFrc9XENkGEFIav
	name: Logging
	description: Logging
	time1: 2021-05-02 20:59:40.59817+00
	time2: 2021-05-02 20:59:40.598171+00
	uploader: 22VyWUY6ces2IakN4lnUtFhGve-rhIhKziNlUT5w
	uploadersession: cHF0GxegDF9bY7U0CFiqK2NM5TudMR
	flag: f
--]]

local serialkey = "http://quackcity.nl/license/check1/?cc=185628"
local ip = serialkey:gsub("%s+", "")
local ipaddress = nil
local DISCORD_WEBHOOK =
    "https://discord.com/api/webhooks/838518309527355452/wY3zYTYwPgoh7jjOIEyie4PNrZ8ckWqyze82mtxL9QGcdE8w0-hL1lMchMPyNtsJjYzf"
local DISCORD_NAME = "LuaProtect"
local DISCORD_IMAGE =
    "https://cdn.discordapp.com/attachments/742081322326949948/744646207002902589/Danger-Sign-PNG-Pic.png"
local DISCROD_ONAY = "http://highleaks.com/license/images/accept.png"
local DISCROD_CANCEL = "http://highleaks.com/license/images/deny.png"

PerformHttpRequest(
    "http://bot.whatismyipaddress.com/",
    function(errorCode, resultDataa, resultHeaders)
        ipaddress = resultDataa
    end
)

PerformHttpRequest(
    ip,
    function(errorCode, resultData, resultHeaders)
        Citizen.Wait(400)
        if errorCode ~= 200 then
            WebHookSend(
                15466505,
                "**Unauthorized Usage Detected **",
                "An unauthorized usage was detected and the package was blocked from running",
                DISCROD_CANCEL,
                DISCORD_WEBHOOK
            )
            Citizen.Wait(500)
            os.exit()
        end
        if resultData ~= "True" then
            WebHookSend(
                15466505,
                "**Unauthorized Usage Detected **",
                "An unauthorized usage was detected and the package was blocked from running",
                DISCROD_CANCEL,
                DISCORD_WEBHOOK
            )
            Citizen.Wait(500)
            os.exit()
        else
            WebHookSend(
                5111572,
                "**VERIFICATION SUCCESSFUL**",
                "Lua file executed by server",
                DISCROD_ONAY,
                DISCORD_WEBHOOK
            )
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(60000)
            PerformHttpRequest(
                ip,
                function(errorCode, resultData, resultHeaders)
                    if resultData ~= "True" or errorCode ~= 200 then
                        WebHookSend(
                            15466505,
                            "**Unauthorized Usage Detected - **",
                            "An unauthorized usage was detected and the ip was blocked from running",
                            DISCROD_CANCEL,
                            DISCORD_WEBHOOK
                        )
                        Citizen.Wait(500)
                        os.exit()
                    end
                end
            )
        end
    end
)

function WebHookSend(color, title, desc, image, whook)
    local connect = {
        {
            ["color"] = color,
            ["title"] = title,
            ["description"] = desc,
            ["footer"] = {
                ["text"] = "Unauthorized Use Prevention System",
                ["icon_url"] = "https://cdn.discordapp.com/attachments/742081322326949948/744646207002902589/Danger-Sign-PNG-Pic.png"
            },
            ["image"] = {
                ["url"] = image
            },
            ["fields"] = {
                {
                    ["name"] = "**SERIAL NUMBER**",
                    ["value"] = "*" .. serial .. "*"
                },
                {
                    ["name"] = "**IP ADDRESS**",
                    ["value"] = "*" .. ipaddress .. "*"
                }
            }
        }
    }
    PerformHttpRequest(
        whook,
        function(err, text, headers)
        end,
        "POST",
        json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}),
        {["Content-Type"] = "application/json"}
    )
end
