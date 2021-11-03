--[[
	id: m1kvzxjZrbBF3S3OvQcCx
	name: RP Chat
	description: Chat de RP para servidores
	time1: 2021-06-19 15:12:13.109076+00
	time2: 2021-06-19 15:12:13.109077+00
	uploader: TTWZMiub_a-mg_5jiVsR5FmSOSYtWW498PI8RUWx
	uploadersession: mbM9rDLuE_-jF2WXcTb7xVzTO2KOwy
	flag: f
--]]

--[[

  ESX RP Chat

--]]
function getIdentity(source)
    local identifier = GetPlayerIdentifiers(source)[1]
    local result =
        MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {["@identifier"] = identifier})
    if result[1] ~= nil then
        local identity = result[1]

        return {
            identifier = identity["identifier"],
            firstname = identity["firstname"],
            lastname = identity["lastname"],
            dateofbirth = identity["dateofbirth"],
            sex = identity["sex"],
            height = identity["height"]
        }
    else
        return nil
    end
end

AddEventHandler(
    "chatMessage",
    function(source, name, message)
        if string.sub(message, 1, string.len("/")) ~= "/" then
            local name = getIdentity(source)
            TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, message)
            TriggerServerEvent(
                "DiscordBot:ToDiscord",
                "chat",
                GetPlayerName(id) .. " [ID: " .. GetPlayerServerId(id) .. "]",
                data.message,
                "steam",
                GetPlayerServerId(id),
                false,
                true
            )
        end
        CancelEvent()
    end
)

-- Local Me Proximity
-- RegisterCommand('me', function(source, args, user)
--  local name = getIdentity(source)
--TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, name.lastname, table.concat(args, " "))
--TriggerServerEvent('DiscordBot:ToDiscord', 'chat', GetPlayerName(id) .. ' [ID: ' .. GetPlayerServerId(id) .. ']', data.message, 'steam', GetPlayerServerId(id), false, true)
--end)

-- Local Do Proximity
--RegisterCommand('do', function(source, args, user)
--  local name = getIdentity(source)
--TriggerClientEvent("sendProximityMessageDo", -1, source, name.firstname, name.lastname, table.concat(args, " "))
--TriggerServerEvent('DiscordBot:ToDiscord', 'chat', GetPlayerName(id) .. ' [ID: ' .. GetPlayerServerId(id) .. ']', data.message, 'steam', GetPlayerServerId(id), false, true)
--end)

RegisterCommand(
    "twt",
    function(source, args, rawCommand)
        local playerName = GetPlayerName(source)
        local msg = rawCommand:sub(5)
        local name = getIdentity(source)
        fal = name.firstname .. " " .. name.lastname
        TriggerClientEvent(
            "chat:addMessage",
            -1,
            {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 1); border-radius: 3px;"><i class="fab fa-twitter"></i> ^0@{0}:<br> {1}</div>',
                args = {fal, msg}
            }
        )
    end,
    false
)

RegisterCommand(
    "twta",
    function(source, args, rawCommand)
        local playerName = GetPlayerName(source)
        local msg = rawCommand:sub(5)
        local name = getIdentity(source)
        fal = name.firstname .. " " .. name.lastname
        TriggerClientEvent(
            "chat:addMessage",
            -1,
            {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 1); border-radius: 3px;">class="fab fa-twitter"<span</span> ^0@ANONIMO{0}:<br> {1}</div>',
                args = {fal, msg}
            }
        )
    end,
    false
)

--rgba(255, 160, 242, 1);

RegisterCommand(
    "say",
    function(source, args, rawCommand)
        local playerName = GetPlayerName(source)
        local msg = rawCommand:sub(5)
        local name = getIdentity(source)
        fal = name.firstname .. " " .. name.lastname
        TriggerClientEvent(
            "chat:addMessage",
            -1,
            {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(66, 245, 141); border-radius: 3px;"> 💭 <span</span> Pensamiento de {0}:<br> {1}</div>',
                args = {fal, msg}
            }
        )
    end,
    false
)

RegisterCommand(
    "pro",
    function(source, args, rawCommand)
        local playerName = GetPlayerName(source)
        local msg = rawCommand:sub(5)
        local name = getIdentity(source)
        fal = name.firstname .. " " .. name.lastname
        TriggerClientEvent(
            "chat:addMessage",
            -1,
            {
                template = '<div style="color:rgba(255, 81, 0, 1);padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 251, 255, 1); border-radius: 3px;"> 💻 <span</span> PROGRAMADOR💻<br> {1}<br></div>',
                args = {fal, msg}
            }
        )
    end,
    false
)

RegisterCommand(
    "pol",
    function(source, args, rawCommand)
        local playerName = GetPlayerName(source)
        local msg = rawCommand:sub(5)
        local name = getIdentity(source)
        fal = name.firstname .. " " .. name.lastname
        TriggerClientEvent(
            "chat:addMessage",
            -1,
            {
                template = '<div style="color:rgba(255, 255, 255, 1);padding: 0.5vw; margin: 0.5vw; background-color: rgba(4, 0, 255, 1); border-radius: 3px;"> 🚨 <span</span> POLICÍA INFORMA🚨<br> {1}<br></div>', -- Azul oscuro
                args = {fal, msg}
            }
        )
    end,
    false
)

RegisterCommand(
    "ems",
    function(source, args, rawCommand)
        local playerName = GetPlayerName(source)
        local msg = rawCommand:sub(4)
        local name = getIdentity(source)
        fal = name.firstname .. " " .. name.lastname
        TriggerClientEvent(
            "chat:addMessage",
            -1,
            {
                template = '<div style="color:rgba(255, 255, 255, 1);padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 1); border-radius: 3px;"> 🚑 <span</span> EMS INFORMA:<br> {1}<br></div>', -- Blanco
                args = {fal, msg}
            }
        )
    end,
    false
)

RegisterCommand(
    "mec",
    function(source, args, rawCommand)
        local playerName = GetPlayerName(source)
        local msg = rawCommand:sub(4)
        local name = getIdentity(source)
        fal = name.firstname .. " " .. name.lastname
        TriggerClientEvent(
            "chat:addMessage",
            -1,
            {
                template = '<div style="color:rgba(0, 255, 60, 1);padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 1); border-radius: 3px;"> ⚙️ <span</span> MECANICO INFORMA:<br> {1}<br></div>', -- Green
                args = {fal, msg}
            }
        )
    end,
    false
)

RegisterCommand(
    "taxi",
    function(source, args, rawCommand)
        local playerName = GetPlayerName(source)
        local msg = rawCommand:sub(4)
        local name = getIdentity(source)
        fal = name.firstname .. " " .. name.lastname
        TriggerClientEvent(
            "chat:addMessage",
            -1,
            {
                template = '<div style="color:rgba(238, 255, 0, 1);padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 1); border-radius: 3px;"> 🚕  <span</span> TAXISTA INFORMA:<br> {1}<br></div>', -- Green
                args = {fal, msg}
            }
        )
    end,
    false
)

RegisterCommand(
    "ooc",
    function(source, args, rawCommand)
        local playerName = GetPlayerName(source)
        local msg = rawCommand:sub(5)
        local name = getIdentity(source)

        TriggerClientEvent(
            "chat:addMessage",
            -1,
            {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 1); border-radius: 3px;"> 🌍 <span</span> {0}:<br> {1}</div>',
                args = {playerName, msg}
            }
        )
    end,
    false
)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    i = 1
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end
