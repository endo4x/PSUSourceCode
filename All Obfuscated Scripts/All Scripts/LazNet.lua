--[[
	id: VWah3yvSE82ID552WWJYs
	name: LazNet
	description: LazNet
	time1: 2021-06-26 18:11:12.517449+00
	time2: 2021-06-26 18:11:12.51745+00
	uploader: Th0-o7b3FdvBbWxL16g8SSl1gNl9FuZZqDIdcB5y
	uploadersession: R1JutuhKDBVj2-u37DfuupPaQCUQ-x
	flag: f
--]]

function lazsecurenetworklogo()
    print(
        [[^7
	^5 _               ^2_____                          ^3_   _      _                      _    
	^5| |             ^2/  ___|                        ^3| \ | |    | |                    | |   
	^5| |     __ _ ___^2\ `--.  ___  ___ _   _ _ __ ___^3|  \| | ___| |___      _____  _ __| | __
	^5| |    / _` |_  /^2`--. \/ _ \/ __| | | | '__/ _ \^3 . ` |/ _ \ __\ \ /\ / / _ \| '__| |/ /
	^5| |___| (_| |/ /^2/\__/ /  __/ (__| |_| | | |  __/ ^3|\  |  __/ |_ \ V  V / (_) | |  |   < 
	^5\_____/\__,_/___|^2____/ \___|\___|\__,_|_|  \___\^3_| \_/\___|\__| \_/\_/ \___/|_|  |_|\_\

    ^7By ^1!L#0001
    ^7Website : ^5https://lazcorporation.com^7
]]
    )
end

Citizen.CreateThread(
    function()
        SetConvarServerInfo("Anti-DDoS ", "LazSecureNetwork v4.2")
        lazsecurenetworklogo()
        lazsecurenetworkstart()
        lazserveron()
    end
)

function lazsecurenetworkstart()
    print("^3[LazSecureNetwork] ^7- ^7 ^4Anti-DDoS started succesfully")
end

lazserveron = function()
    local discordInfo = laznetconfigmessageserveron

    PerformHttpRequest(
        laznetconfigwebhookserveron,
        function(err, text, headers)
        end,
        "POST",
        json.encode({username = " Server ON", content = discordInfo}),
        {["Content-Type"] = "application/json"}
    )
end

function lazsecurenetworkwl()
    local _source = source
    local ip, guid = GetPlayerEP(_source), GetPlayerGuid(_source)
    PerformHttpRequest(
        laznetconfiglazsecurenetworkapi .. "?type=wl&host=" .. ip,
        function(errorCode, resultData, resultHeaders)
        end
    )
end

function lazsecurenetworkunwl()
    local _source = source
    local ip, guid = GetPlayerEP(_source), GetPlayerGuid(_source)
    PerformHttpRequest(
        laznetconfiglazsecurenetworkapi .. "?type=unwl&host=" .. ip,
        function(errorCode, resultData, resultHeaders)
        end
    )
end

AddEventHandler(
    "playerConnecting",
    function(playerName, setKickReason, deferrals)
        local _source = source
        local ip, guid = GetPlayerEP(_source), GetPlayerGuid(_source)
        lazsecurenetworkwl()
        local color = "^" .. math.random(0, 9)
        print("[^7Anti-DDoS By !L#0001 - www.lazcorporation.com - www.brmstress.xyz^7]")
        print("^3[LazSecureNetwork] ^7- " .. color .. " " .. GetPlayerName(source) .. " Connected^7 - IP : " .. ip)
        laznewplayer()
    end
)

AddEventHandler(
    "playerDropped",
    function(reason)
        local _source = source
        local ip, guid = GetPlayerEP(_source), GetPlayerGuid(_source)
        lazsecurenetworkunwl()
        local color = "^" .. math.random(0, 9)
        print("[^7Anti-DDoS By !L#0001 - www.lazcorporation.com - www.brmstress.xyz^7]")
        print("[^3[LazSecureNetwork] ^7- " .. color .. " " .. GetPlayerName(source) .. " Disconnected")
        laznewplayerdisconnect()
    end
)

laznewplayer = function()
    local _source = source
    local ip, guid = GetPlayerEP(_source), GetPlayerGuid(_source)
    local discordInfo = {
        ["color"] = "327424",
        ["type"] = "rich",
        ["title"] = GetPlayerName(source) .. " connecting into the server",
        ["footer"] = {
            ["text"] = " LazSecureNetwork 🔒 "
        }
    }

    PerformHttpRequest(
        laznetconfigwebhookplayerconnect,
        function(err, text, headers)
        end,
        "POST",
        json.encode({username = " LazSecureNetwork - Connect", embeds = {discordInfo}}),
        {["Content-Type"] = "application/json"}
    )
end

laznewplayerdisconnect = function()
    local _source = source
    local ip, guid = GetPlayerEP(_source), GetPlayerGuid(_source)
    local discordInfo = {
        ["color"] = "16711680",
        ["type"] = "rich",
        ["title"] = GetPlayerName(source) .. " disconnected",
        ["footer"] = {
            ["text"] = " LazSecureNetwork 🔒 "
        }
    }

    PerformHttpRequest(
        laznetconfigwebhookplayerdisconnect,
        function(err, text, headers)
        end,
        "POST",
        json.encode({username = " LazSecureNetwork - Disconnect", embeds = {discordInfo}}),
        {["Content-Type"] = "application/json"}
    )
end
