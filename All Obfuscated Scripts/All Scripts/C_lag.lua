--[[
	id: tzKcjrpijiGAwNXfRFNz3
	name: C_lag
	description: C_lag
	time1: 2021-07-13 18:44:10.22598+00
	time2: 2021-07-13 18:44:10.225998+00
	uploader: o3KDnG-HBz3d47n-lpTCIgbkh_Ugey1YDo-1XIXK
	uploadersession: lE8MWHXGCzKSXhRDuCUKoVNqNhUSU2
	flag: f
--]]

local list = { "On land", "In air", "On peek" }

local alpha = 0
local enabled = ui.new_checkbox("AA", "Fake lag", "Fakelag jitter")
local condition = ui.new_multiselect("AA", "Fake lag", "Lag Type", list)

local amount = ui.reference("AA", "Fake lag", "Amount")

local data = {
    current_phase = 0,
    prev_choked = 14,
}

local phases = {
    { amount = "Fluctuate"},
    { amount = "Dynamic"},
    { amount = "Fluctuate"},
    { amount = "Dynamic"},
    { amount = "Fluctuate"},
    { amount = "Dynamic"},
}

local cache = { }

local cache_process = function(name, condition, should_call, VAR)
    local hotkey_modes = {
        [0] = "always on",
        [1] = "on hotkey",
        [2] = "toggle",
        [3] = "off hotkey"
    }

    local _cond = ui.get(condition)
    local _type = type(_cond)

    local value, mode = ui.get(condition)
    local finder = mode ~= nil and mode or (_type == "boolean" and tostring(_cond) or _cond)
    cache[name] = cache[name] ~= nil and cache[name] or finder

    if should_call then ui.set(condition, mode ~= nil and hotkey_modes[VAR] or VAR) else
        if cache[name] ~= nil then
            local _cache = cache[name]
            
            if _type == "boolean" then
                if _cache == "true" then _cache = true end
                if _cache == "false" then _cache = false end
            end

            ui.set(condition, mode ~= nil and hotkey_modes[_cache] or _cache)
            cache[name] = nil
        end
    end
end

local function compare(tab, val)
    for i = 1, #tab do
        if tab[i] == val then
            return true
        end
    end
    
    return false
end

local multi_exec = function(func, list)
    if func == nil then
        return
    end
    
    for ref, val in pairs(list) do
        func(ref, val)
    end
end

local contains = function(tab, val, sys)
    for index, value in ipairs(tab) do
        if sys == 1 and index == val then
            return true
        elseif value == val then
            return true
        end
    end
    return false
end

local function visbility(target)
    for i=0, 8 do
        local target_hitbox_position = { entity.hitbox_position(target, i) }

        if client.visible(target_hitbox_position[1], target_hitbox_position[2], target_hitbox_position[3]) then
            return true
        end
    end

    return false
end

local function ticks_to_time(input)
    return globals.tickinterval() * input
end

local function predicted_visible_target()

    local targets = entity.get_players(true)
    if targets == nil then
        return
    end

    local me = entity.get_local_player()
    local predicted = 14

    local eye_position = { client.eye_position() }
    local mvecVelocityLocal = { entity.get_prop(me, "m_vecVelocity") }
    local predicted_eye_position = { eye_position[1] + mvecVelocityLocal[1] * ticks_to_time(predicted),
        eye_position[2] + mvecVelocityLocal[2] * ticks_to_time(predicted),
        eye_position[3] + mvecVelocityLocal[3] * ticks_to_time(predicted) }

    local velocity = math.sqrt(mvecVelocityLocal[1]^2 + mvecVelocityLocal[2]^2)
    local ducking = entity.get_prop(me, "m_flDuckAmount") > 0.7
    local on_ground = bit.band(entity.get_prop(me, "m_fFlags"), 1) == 1

    if not on_ground or ducking or velocity < 2 then
        return false
    end

    for i=1, #targets do
        local target = targets[i]

        local mvecVelocity = { entity.get_prop(target, "m_vecVelocity") }

        local origin = { entity.get_origin(target) }
        local predicted_origin = { origin[1] + mvecVelocity[1] * ticks_to_time(14),
            origin[2] + mvecVelocity[2] * ticks_to_time(14),
            origin[3] + mvecVelocity[3] * ticks_to_time(14) }

        entity.get_prop(target, "m_vecOrigin", predicted_origin)

        local head_origin = { entity.hitbox_position(target, 0) }
        local predicted_head_origin = { head_origin[1] + mvecVelocity[1] * ticks_to_time(14), 
            head_origin[2] + mvecVelocity[2] * ticks_to_time(14),
            head_origin[3] + mvecVelocity[3] * ticks_to_time(14) }
        local trace_entity, damage = client.trace_bullet(me, predicted_eye_position[1], predicted_eye_position[2], predicted_eye_position[3], predicted_head_origin[1], predicted_head_origin[2], predicted_head_origin[3])

        entity.get_prop(target, "m_vecOrigin", origin)

        if damage > 0 and not visbility(target) then
            return true
        end
    end

    return false
end

client.set_event_callback("setup_command", function(c)
    local get_prop = function(...) 
        return entity.get_prop(entity.get_local_player(), ...)
    end

    local conditions = ui.get(condition)

    local x, y, z = get_prop("m_vecVelocity")
    local in_air = c.in_jump == 1 or bit.band(get_prop("m_fFlags"), 1) ~= 1

    local is_active = ui.get(enabled) and (
        (compare(conditions, list[1]) and not in_air and math.sqrt(x^2 + y^2) > 1) or 
        (compare(conditions, list[2]) and in_air)
    )

    if contains(ui.get(condition), "On peek") then
        if predicted_visible_target() or in_air then
            ui.set(amount,"Fluctuate")
        else
            ui.set(amount,"Dynamic")
        end
    end

    if is_active then
        if alpha < 248 then
            alpha = alpha + 8
        end
    else
        if alpha > 7 then
            alpha = alpha - 8
        end
    end

    if c.chokedcommands < data.prev_choked then
        data.current_phase = data.current_phase + 1

        if data.current_phase > #phases then
            data.current_phase = 1
        end
    end

	cache_process("amount", amount, is_active, phases[data.current_phase].amount)

    data.prev_choked = c.chokedcommands
end)
local list = { "Default", "Hit ground" }

local alpha = 0
local enabled = ui.new_checkbox("AA", "Fake lag", "Lag comp shifter")
local condition = ui.new_multiselect("AA", "Fake lag", "\n lagcomp_shifter_condition", list)

local amount = ui.reference("AA", "Fake lag", "Amount")
local variance = ui.reference("AA", "Fake lag", "Variance")

local phases = {
    { amount = "Maximum", variance = 0 },
    { amount = "Dynamic", variance = 0 },
    { amount = "Maximum", variance = 36 },
    { amount = "Dynamic", variance = 0 },
    { amount = "Maximum", variance = 68 },
    { amount = "Dynamic", variance = 0 },
    { amount = "Fluctuate", variance = 0 },
    -- { amount = "Fluctuate", variance = 100 },
}

local data = {
    current_phase = 0,
    prev_choked = 14,
}

local cache = { }
local ui_get, ui_set = ui.get, ui.set
local entity_is_alive = entity.is_alive
local renderer_measure_text = renderer.measure_text
local renderer_indicator = renderer.indicator
local renderer_rectangle = renderer.rectangle

local bit_band = bit.band
local math_sqrt = math.sqrt
local entity_get_prop = entity.get_prop
local entity_get_local_player = entity.get_local_player

local cache_process = function(name, condition, should_call, VAR)
    local hotkey_modes = {
        [0] = "always on",
        [1] = "on hotkey",
        [2] = "toggle",
        [3] = "off hotkey"
    }
	
    local _type = type(_cond)
    local finder = mode ~= nil and mode or (_type == "boolean" and tostring(_cond) or _cond)
    cache[name] = cache[name] ~= nil and cache[name] or finder
        if cache[name] ~= nil then
            local _cache = cache[name]
            
            if _type == "boolean" then
                if _cache == "true" then _cache = true end
                if _cache == "false" then _cache = false end
            end

            ui_set(condition, mode ~= nil and hotkey_modes[_cache] or _cache)
            cache[name] = nil
        end
    end

local function compare(tab, val)
    for i = 1, #tab do
        if tab[i] == val then
            return true
        end
    end
    
    return false
end

client.set_event_callback("setup_command", function(c)
    local get_prop = function(...) 
        return entity_get_prop(entity_get_local_player(), ...)
    end

    local conditions = ui_get(condition)

    local x, y, z = get_prop("m_vecVelocity")
    local in_air = c.in_jump == 1 or bit_band(get_prop("m_fFlags"), 1) ~= 1

    local is_active = ui_get(enabled) and (
        (compare(conditions, list[1]) and not in_air and math.sqrt(x^2 + y^2) > 1) or 
        (compare(conditions, list[2]) and in_air)
    )

    if is_active then
        if alpha < 248 then
            alpha = alpha + 8
        end
    else
        if alpha > 7 then
            alpha = alpha - 8
        end
    end

    if c.chokedcommands < data.prev_choked then
        data.current_phase = data.current_phase + 1

        if data.current_phase > #phases then
            data.current_phase = 1
        end
    end

    -- cache_process("onshot_fakelag", onshot_fakelag, is_active, true)
    cache_process("custom_triggers", custom_triggers, is_active, false)
    cache_process("amount", amount, is_active, phases[data.current_phase].amount)
    cache_process("variance", variance, is_active, phases[data.current_phase].variance)

    data.prev_choked = c.chokedcommands
end)

client.set_event_callback("paint", function(c)
    local me = entity_get_local_player()

    if not ui_get(enabled) or not entity_is_alive(me) then
        return
    end

    if alpha > 0 then
    local text = "Chr1s"
	local width, height = renderer_measure_text("+", text)
	local y = renderer_indicator(255, 182, 138, alpha > 150 and 150 or alpha, text)

	renderer_rectangle(19, y + 30, width, 0, 0, 0, 0, alpha > 150 and 150 or alpha)
	renderer_rectangle(20, y + 31, ((width - 2) / #phases) * data.current_phase, 3, 255, 182, 138, alpha)
    end
end)

local _callback = function(self)
    ui.set_visible(condition, ui_get(self))
end

ui.set_callback(enabled, _callback)
_callback(enabled)