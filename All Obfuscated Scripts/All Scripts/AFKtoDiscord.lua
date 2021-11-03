--[[
	id: QKy6BGtbbcPJmquuEYIOX
	name: AFK to Discord
	description: Sistema de AFK con webhook en el discord by Team Loyalty
	time1: 2021-06-21 03:12:41.302096+00
	time2: 2021-06-21 03:12:41.302097+00
	uploader: TTWZMiub_a-mg_5jiVsR5FmSOSYtWW498PI8RUWx
	uploadersession: mbM9rDLuE_-jF2WXcTb7xVzTO2KOwy
	flag: f
--]]

-- Don't touch anything in here unless  you know what you're doing

RegisterNetEvent("qAFK:webhook") -- Webhook 
AddEventHandler("qAFK:webhook", function(Value, ValueTwo, Decimal)
    local date = os.date()
    local connect = {
        {
            ["color"] = Decimal,
            ["fields"] = {
                {
                    ["name"] = ValueTwo,
                    ["value"] = Value,
                }
            },
            ["author"] = {
                ["name"] = "Develop by Loyalty Jxhn",
                --["url"] = "https://qtprod.com",
                ["icon_url"] = "https://i.imgur.com/Whjwth6.png"
            },
            ["footer"] = {
                ["text"] = "Action Happened: " .. date,
                ["icon_url"] = Config.webhookImage,
            },
        }
    }
    PerformHttpRequest(Config.webhook, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = Config.webhookImage}), {['Content-Type'] = 'application/json'})
end)

RegisterCommand( -- /afk Command
    "afk",
    function(source, args, rawCommand)
        TriggerClientEvent("qAFK:setAFK", source)
end, false)

RegisterNetEvent("qAFK:sendAFKmessagetoServer") -- If Config.afkmessagestoServer is true, it will send a message to the server.
AddEventHandler("qAFK:sendAFKmessagetoServer", function(name)
    if Config.afkmessagestoServer then 
        TriggerClientEvent("chatMessage", -1, "^7[^4"..GetPlayerName(source).."^7]".." Se ha ido AFK.")
    end
end)

RegisterCommand(-- /afkoff command
    "afkoff",
    function(source, args, rawCommand)
        TriggerClientEvent("qAFK:setNot", source)
end, false)

RegisterServerEvent("qAFK:kickPlayer") -- kick the player as long as AFKkick config is on
AddEventHandler("qAFK:kickPlayer", function(time)
	DropPlayer(source, "Has estado AFK por "..time.. ". por lo tanto, fuistes kickeado por el sistema de AFK del servidor!")
end)

-- Updates
PerformHttpRequest("https://github.com/qavas/qAFK/blob/main/version.txt", function(err, serverVersion, headers)
    local version = "v1.0.0"
    if string.find(serverVersion, version) == nil then
        print("^4"..GetCurrentResourceName() .."^7 is ^1outdated^7. Get the new version at github.com/qavas/qAFK")
    else
        print("^4"..GetCurrentResourceName() .."^7 is on the ^2newest ^7version!^7")
    end
end)