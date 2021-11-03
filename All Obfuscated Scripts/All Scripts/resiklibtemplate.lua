--[[
	id: CsaSGmNjcOXp7sF4ErCzH
	name: resiklibtemplate
	description: template for creating resik libs
	time1: 2021-07-17 01:27:17.002997+00
	time2: 2021-07-17 01:27:17.002998+00
	uploader: 842
	uploadersession: -9U-k1Fbaf6Svx7TXUfxAkw4HqXKro
	flag: f
--]]

-- caching common functions
local client_unset_event_callback = client.unset_event_callback
local client_set_event_callback = client.set_event_callback
local client_system_time = client.system_time
local client_color_log = client.color_log

local cvar_sndplaydelay = cvar.sndplaydelay

local globals_realtime = globals.realtime

local table_remove = table.remove
local table_insert = table.insert

local logs = {} do
    -- general
    logs.name = 'gamesense'

    logs.set_name = function(name)
        logs.name = name
    end

    logs.color = {
        r = 181,
        g = 230,
        b = 29
    }

    logs.set_color = function(r, g, b)
        logs.color.r = r or logs.color.r
        logs.color.g = g or logs.color.g
        logs.color.b = b or logs.color.b
    end

    logs.txt = {}

    -- print
    logs.print = function(...)
        local args = {...}
        local str = ''
        for i=1, select('#', ...) do -- god i love sapphyrus
            str = str .. tostring(args[i])
        end
        
        if #str == 0 then
            return
        end

        local on_output = function() end
        
        client_set_event_callback('output', on_output)

        client_color_log(logs.color.r, logs.color.g, logs.color.b, ('[%s] \0'):format(logs.name))

        client_unset_event_callback('output', on_output)
    
        client_color_log(216, 216, 216, ('%s\0'):format(str))

        table_insert(logs.txt, {
            system_time = {client_system_time()},
            text = str
        })
    
        return client_color_log(255, 255, 255, '\n\0')
    end

    logs.timer = 1

    -- warns
    logs.warns = {}

    logs.warn = function(...)
        local realtime = globals_realtime()

        local args = {...}

        local str = ''
        for i=1, select('#', ...) do -- god i love sapphyrus
            str = str .. tostring(args[i])
        end
        
        if #str == 0 then
            return
        end

        for i, warn in ipairs(logs.warns) do
            local elapsed = realtime - warn.time
            if elapsed >= logs.timer then
                table_remove(logs.warns, i)
            end

            if warn.text == str and elapsed < logs.timer then
                return
            end
        end
    
        local on_output = function() end
        
        client_set_event_callback('output', on_output)

        client_color_log(logs.color.r, logs.color.g, logs.color.b, ('[%s] \0'):format(logs.name))

        client_unset_event_callback('output', on_output)
    
        client_color_log(255, 40, 40, ('%s\0'):format(str))

        cvar_sndplaydelay:invoke_callback(0, 'ui\\weapon_cant_buy.wav')

        table_insert(logs.txt, {
            system_time = {client_system_time()},
            text = str
        })

        table_insert(logs.warns, {
            time = realtime,
            text = str
        })
    
        return client_color_log(255, 40, 40, '\n\0')
    end

    -- error
    logs.error = function(...)
        local args = {...}

        local str = ''
        for i=1, select('#', ...) do -- god i love sapphyrus
            str = str .. tostring(args[i])
        end
        
        if #str == 0 then
            return
        end

        table_insert(logs.txt, {
            system_time = {client_system_time()},
            text = str
        })

        return error(logs.warn(...))
    end
end

client.set_event_callback('shutdown', function()
    local contents = readfile('resolver/logs.txt') or '// resolver logs'

    for i, log in ipairs(logs.txt) do
        contents = contents .. ('\n[%02d:%02d:%02d] %s'):format(log.system_time[1], log.system_time[2], log.system_time[3], log.text)
    end

    writefile('resolver/logs.txt', contents)
end)

return logs