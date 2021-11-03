--[[
	id: djfvB9Mw04KRd3DYJVYOs
	name: g
	description: g
	time1: 2021-04-27 20:04:10.184247+00
	time2: 2021-04-27 20:04:10.184248+00
	uploader: AZtTUxhQ9cLj3tqhYw_Q7zf5zhr9A-0KAU3uOmnL
	uploadersession: TT9GadOnTA0JWZJ3I8nk7ShWk10ZN0
	flag: f
--]]

-- events backed nigga
if not Config.Events.AdvancedProtection then
    return
end

local Events = {
    Registered = {},
    RegResources = {},
    Received = {},
    DevMode = false,
}

GlobalState.SafeEvents = Config.Events.Whitelist

RegisterNetEvent('hokkaido:registerEvent')
AddEventHandler('hokkaido:registerEvent', function(resource, event, secret)
    Events.Registered[event] = secret -- assign generated secret to a value with index=name of event in table of specified resource in registered events table
    -- print(('Globally registered new event %s with secret %s!'):format(event, secret))
end)

RegisterNetEvent('hokkaido:registerResource')
AddEventHandler('hokkaido:registerResource', function(resource)
    if tonumber(source) and tonumber(source) > 0 then
        return
    end

    Events.RegResources[resource] = true
    print(('hokkaido :: Registered new resource %s!'):format(resource))
end)

RegisterNetEvent('hokkaido:clientFetchEvents')
AddEventHandler('hokkaido:clientFetchEvents', function(resource)
    if not Events.Received[resource] then
        Events.Received[resource] = {}
    elseif Events.Received[resource][source] then
        return
    end

    while Events.RegResources[resource] == nil do
        Wait(50)
    end

    Events.Received[resource][source] = true

    print(('Client %s requested the event secrets from resource %s'):format(source, resource))
    TriggerClientEvent(resource .. ':hokkaido:sendSecrets', source, Events.Registered)
end)

AddEventHandler('onResourceStart', function(resource) -- Support for restarting resources
    while Events.RegResources[resource] == nil do
        Wait(100)
    end
    
    TriggerClientEvent(resource .. ':hokkaido:updateSecrets', -1, Events.Registered)
end)

AddEventHandler('onResourceStop', function(resource) -- Support for restarting resources
    Events.RegResources[resource] = nil
    Events.Received[resource] = nil
end)

RegisterNetEvent('hokkaido:events:AuthFail')
AddEventHandler('hokkaido:events:AuthFail', function(...)
    Events:AuthFail(...)
end)

function Events:AuthFail(client, event, secret, resource)
    local violation = 'Event manipulation'
    local details = 'User triggered an unauthorized server event'
    
    local realSecret = Events.Registered[event]
    local devInfo = (Events.DevMode and '**Client secret:** %s\n**Server secret:** %s\n') or ''

    local info = Utils:GetIdentifiers(client)
    local identifiers = ('**Player:** %s (ID %s)\n'):format(GetPlayerName(client), client)

    -- System:SendToDiscord(
    --     violation, 
    --     (
    --         identifiers .. '**Details:** %s\n**Event:** %s (%s)\n' .. devInfo
    --     ):format(details, event or "unknown", resource or "unknown", secret or "unknown", realSecret or "unknown"), 
    --     16734464, Config.Discord.EventsWebhook
    -- )

    TriggerEvent('hokkaido:banCheater', client, violation, details)
end
