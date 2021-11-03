--[[
	id: IoV069gm_MJMy7jTEg5nE
	name: Doubletap
	description: 1.0.1
	time1: 2021-07-24 19:52:52.987749+00
	time2: 2021-07-24 19:52:52.987749+00
	uploader: 1161
	uploadersession: 8bb6vPAEu246Bk-5VdMlrrdLiVqpVA
	flag: f
--]]

--region libraries
---@module vector
local vector = require 'vector'

---@module ffi
local ffi = require 'ffi'
local get_weapon_info_t = ffi.typeof([[
    struct {
        char    pad_vtable[0x4];
        char*    consoleName;        char    pad_0[0xc];
        int        iMaxClip1;
        int        MaxClip2;
        int        iDefaultClip1;
        int     iDefaultClip2;
        int        iPrimaryReserveAmmoMax;
        int        iSecondaryReserveAmmoMax;
        char*    szWorldModel;
        char*    szViewModel;
        char*    szDroppedModel;        char    pad_9[0x50];
        char*    szHudName;
        char*    szWeaponName;        char    pad_11[0x2];
        bool    bIsMeleeWeapon;        char    pad_12[0x9];
        float    flWeaponWeight;        char    pad_13[0x2c];
        int        iWeaponType;
        int        iWeaponPrice;
        int        iKillAward;            char    pad_16[0x4];
        float    flCycleTime;
        float    flCycleTimeAlt;        char    pad_18[0x8];
        bool    bFullAuto;            char    pad_19[0x3];
        int        iDamage;
        float    flArmorRatio;
        int        iBullets;
        float    flPenetration;        char    pad_23[0x8];
        float    flWeaponRange;
        float    flRangeModifier;
        float    flThrowVelocity;    char    pad_26[0xc];
        bool    bHasSilencer;        char    pad_27[0xb];
        char*    szBulletType;
        float    flMaxSpeed;
        float    flMaxSpeedAlt;        char    pad_29[0x50];
        int        iRecoilSeed;
    }* (__thiscall*)(void*)
]])

local classptr = ffi.typeof('void***')

local ffi_stuff = {
    fnGetClientEntity = vtable_bind('client.dll', 'VClientEntityList003', 3, 'void*(__thiscall*)(void*, int)'),
    fnGetClientNetworkable = vtable_bind('client.dll', 'VClientEntityList003', 0, 'void*(__thiscall*)(void*, int)'),
    fnGetWeaponInfo = vtable_thunk(460, get_weapon_info_t),
    GetClientEntity = function(self, ent)
        return self.fnGetClientEntity(ent)
    end,
    GetWeaponInfo = function(self, ent)
        return self.fnGetWeaponInfo(ffi.cast(classptr, self:GetClientEntity(ent)))
    end
}

local gram_create = function(value, count) local gram = { }; for i=1, count do gram[i] = value; end return gram; end
local gram_update = function(tab, value, forced) local new_tab = tab; if forced or new_tab[#new_tab] ~= value then table.insert(new_tab, value); table.remove(new_tab, 1); end; tab = new_tab; end

local function clamp(val, lower, upper)
    if lower > upper then lower, upper = upper, lower end -- swap if boundaries supplied the wrong way
    return math.max(lower, math.min(upper, val))
end

local bullet = {
    svg = '<?xml version="1.0" encoding="utf-8"?><svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="32" height="32"><g><g><path fill="#FFFFFF" d="M5,24.5l5.4,4.3l9.8-13c0.2-0.3,0.5-1.2,0.5-1.2s0.1-0.7,0.5-1.4c0.4-0.7,1.2-1.7,1.2-1.7l-3.7-3.1c0,0-1.6,1.5-1.8,1.7c-0.7,0.7-1.5,1-1.8,1.4S5,24.5,5,24.5z"/><polygon fill="#FFFFFF" points="19.3,7.8 23,10.8 27.9,1.8 26.6,0.7"/><path fill="#FFFFFF" d="M4.4,25.2l5.5,4.4l-0.5,0.5c0,0-2,0-3.7-1.3c-1.9-1.4-1.7-3.1-1.7-3.1L4.4,25.2z"/></g></g></svg>',
    id = nil,
    size = nil,
    load = function(self, size)
        local size = size*vector(32, 32)
        local id = renderer.load_svg(self.svg, size.x, size.y)
        return {
            id = id,
            size = size,
            draw = function(self, pos, color, mode)
                if self.id == nil or self.size == nil then
                    return
                end
                return renderer.texture(self.id, pos.x, pos.y, self.size.x, self.size.y, color.r, color.g, color.b, color.a, mode or nil)
            end
        }
    end
}

--endregion

--region logging
local log = {
    count = 0,
    debug = true,
    prefix = " > exscord:",
    error_prefix = " X exscord:",
    debug_prefix = " >> exscord:",
    create = function(self, ...)
        local args = { ... }
        local text = self.prefix .. " [ "

        for _, v in pairs(args) do
            text = text .. v
        end
        text = text .. " ]"
        client.color_log(255, 255, 255, text)
        self.count = self.count + 1
    end,
    error = function(self, ...)
        local args = { ... }
        local text = self.error_prefix .. " [ "

        for _, v in pairs(args) do
            text = text .. v
        end
        text = text .. " ]"
        client.color_log(255, 50, 0, text)
        self.count = self.count + 1
    end,
    debugging = function(self, ...)
        if self.debug == false then
            return
        end
        local args = { ... }
        local text = self.debug_prefix .. " [ "

        for _, v in pairs(args) do
            text = text .. v
        end
        text = text .. " ]"
        client.color_log(0, 255, 255, text)
        self.count = self.count + 1
    end
}
--endregion

--region ui_manager
---@class ui_manager
---@version 1.0.0
local ui_manager = {}
local ui_manager_mt = { __index = ui_manager }

function ui_manager:create(ui_function, tab, container, ...)

    local element = { ui_function(tab, container, ...) }

    return setmetatable({
        reference = element
    }, ui_manager_mt)
end

function ui_manager:get()
    local values = {}

    for k, v in pairs(self.reference) do
        values[#values + 1] = ui.get(v)
    end

    return unpack(values)
end

function ui_manager:set(value, index)
    local index = index or 1
    ui.set(self.reference[index], type(value) == 'table' and unpack(value) or value)
end

function ui_manager:visible(bool, index)
    local index = index or 1
    ui.set_visible(self.reference[index], bool)
end

function ui_manager:cache(index, should_call, var)
    local index = index or 1
    
    if package._gcache == nil then
        package._gcache = { }
    end

    local name, _cond = 
        ui.name(self.reference[index]):lower() .. index, 
        ui.get(self.reference[index])

    local _type = type(_cond)
    local _, mode = ui.get(self.reference[index])
    local finder = mode or (_type == 'boolean' and tostring(_cond) or _cond)

    package._gcache[name] = package._gcache[name] or finder

    local hotkey_modes = { [0] = 'always on', [1] = 'on hotkey', [2] = 'toggle', [3] = 'off hotkey' }

    if should_call then ui.set(self.reference[index], mode ~= nil and hotkey_modes[var] or var) else
        if package._gcache[name] ~= nil then
            local _cache = package._gcache[name]
            
            if _type == 'boolean' then
                if _cache == 'true' then _cache = true end
                if _cache == 'false' then _cache = false end
            end

            ui.set(self.reference[index], mode ~= nil and hotkey_modes[_cache] or _cache)
            package._gcache[name] = nil
        end
    end
end

function ui_manager:callback(func, index)
    local index = index or 1
    ui.set_callback(self.reference[index], func)
end

--endregion
--region tickbasecontroller
---@class tickbasecontroller
---@version 1.0.0
local tickbasecontroller = {}
local tickbasecontroller_mt = { __index = tickbasecontroller }

---@type function
---@return class

function tickbasecontroller:construct()

    local script_items = {
        doubletap = ui_manager:create(ui.reference, "RAGE", "Other", "Double tap"),
        mode = ui_manager:create(ui.reference, "RAGE", "Other", "Double tap mode"),
        maxusrticks = ui_manager:create(ui.reference, "MISC", "Settings", "sv_maxusrcmdprocessticks"),
        holdaim = ui_manager:create(ui.reference, "MISC", "Settings", "sv_maxusrcmdprocessticks_holdaim"),
        clocks = ui_manager:create(ui.reference, "MISC", "Settings", "sv_clockcorrection_msecs"),
        dt_limit = ui_manager:create(ui.reference, "RAGE", "Other", "Double tap fake lag limit"),

        masterswitch = ui_manager:create(ui.new_checkbox, "LUA", "B", " > exscord DT Controller"),
        tbc_mode = ui_manager:create(ui.new_combobox, "LUA", "B", "   >> Mode", { "Default", "Aggressive", "Accuracy"}),
        tbc_indicator = ui_manager:create(ui.new_checkbox, "LUA", "B", "   >> DT Indicator"),
       -- tbc_shift_ticks = ui_manager:create(ui.new_slider, "AA", "Other", "   >> Exploit ticks", 1, 10, 4),
    }

    local update_visible = function()
        local master_switch = script_items.masterswitch:get()

        script_items.tbc_mode:visible(master_switch)
        script_items.tbc_indicator:visible(master_switch)

    end

    script_items.masterswitch:callback(update_visible)
    script_items.tbc_mode:callback(update_visible)

    update_visible()

    local mt = setmetatable({
        ui = script_items,
        tickbase_shifted = false,
        tickbase_shift_ticks = 0,
        prev_command = 0,
        last_sent = 0, 
        current_choke = 0,
        teleport = 0,
        last_origin = nil,
        breaking_lc = 0,
        tick_base = 0,
        shift_ticks = 0,
        lc_data = gram_create(0, 2),
        tickbase_data = gram_create(0, 16),
        callbacks = {},
        shutdown = nil,
        max_shift_ticks = 0,
        shift_bullets = 0,
        max_recharge_time = 0,
        recharge_time = 0,
        skeet_indicators = {},
        charge_state = 0,
        aimbot_data = nil,
        max_time = 0,
        weapon_fired_predict = false,
        GLOBAL_ALPHA = 0
    }, tickbasecontroller_mt)

    return mt
end
---@type function
---@param func_name string
---@param event_name string
---@return function destroy_func
function tickbasecontroller:event_handler(func_name, event_name, unset)
    local error_text = "Can`t create callback { %s }"
    if self[func_name] == nil then
        log:error(string.format(error_text, string.format("can`t find this: %s function", func_name)))
        return
    end

    local func = function(...)
        return self[func_name](self, ...)
    end

    local callback_function = unset == nil and client.set_event_callback or client.unset_event_callback

    callback_function(event_name, func)
    return (function() 
        self:event_handler(func_name, event_name, unset)
        log:debugging("destroy function: ", func_name, " event: ", event_name)
    end)
end
---@type function
function tickbasecontroller:update_information()
    local me = entity.get_local_player()

    local tick_base = entity.get_prop(me, 'm_nTickBase')
    local simulation_time = entity.get_prop(me, 'm_flSimulationTime')

    if me == nil or tick_base == nil or simulation_time == nil then
        return
    end

    if me == nil or tick_base == nil or simulation_time == nil then
        return
    end

    local shift_ticks = (simulation_time / globals.tickinterval()) - globals.tickcount()
    local potential_shifting = self.tick_base ~= 0 and tick_base < self.tick_base
    local teleport_distance_breaking = self.teleport > 4096

    if teleport_distance_breaking or potential_shifting then
        if potential_shifting then
            self.breaking_lc = 2
        elseif teleport_distance_breaking then
            self.breaking_lc = 1
        else
            self.breaking_lc = 0
        end
    else
        self.breaking_lc = math.max(unpack(self.tickbase_data)) < 0 and 2 or 0
    end

    gram_update(self.tickbase_data, shift_ticks, true)

    self.tick_base = tick_base
    self.shift_ticks = shift_ticks
end
---@type function
function tickbasecontroller:correct_clocks(is_shutdown)
    local is_shutdown = is_shutdown or false

    local cl_clock_correction = cvar.cl_clock_correction
    local cl_clock_correction_force_server_tick = cvar.cl_clock_correction_force_server_tick
    local cl_clock_correction_adjustment_max_amount = cvar.cl_clock_correction_adjustment_max_amount
    local cl_clock_correction_adjustment_max_offset = cvar.cl_clock_correction_adjustment_max_offset
    local cl_clock_correction_adjustment_min_offset = cvar.cl_clock_correction_adjustment_min_offset
    local cl_clockdrift_max_ms = cvar.cl_clockdrift_max_ms

    local drift_max_ms = 1000 / (1 / 64)

    -- cl_interp_ratio:set_raw_int(1)
    -- cl_interp:set_raw_float(0.031)

    cl_clock_correction:set_raw_int(1)
    cl_clock_correction_force_server_tick:set_raw_int(0)

    cl_clock_correction_adjustment_max_amount:set_raw_int(is_shutdown and 200 or 0)
    cl_clock_correction_adjustment_max_offset:set_raw_int(is_shutdown and 90 or 0)
    cl_clock_correction_adjustment_min_offset:set_raw_int(is_shutdown and 10 or 0)

    self.ui.clocks:cache(1, is_shutdown, 30)
    
    cl_clockdrift_max_ms:set_raw_int(is_shutdown and 150 or 0)

end
---@type function
---@param me number local_player
---@param cmd userdata create_move_tbl
function tickbasecontroller:quick_stop(me, cmd)
    local velocity_prop = vector(entity.get_prop(me, "m_vecVelocity"))
    local velocity = math.sqrt(velocity_prop.x * velocity_prop.x + velocity_prop.y * velocity_prop.y)
    local direction = vector(0, 0, 0)
    local forward_vector = velocity_prop:to(direction)
    local direction = vector(forward_vector:angles())
    direction.y = cmd.yaw - direction.y;

    local new_move = vector(0, 0, 0)
    new_move:init_from_angles(direction.x, direction.y, direction.z)

    local max_move = math.max(math.abs(cmd.forwardmove), math.abs(cmd.sidemove))
    local multiplier = 450 / max_move
    new_move = vector(new_move.x * -multiplier, new_move.y * -multiplier, new_move.z * -multiplier)

    cmd.forwardmove = new_move.x
    cmd.sidemove = new_move.y  
end
---@type function
---@param aimbot_data table shot_data
function tickbasecontroller:aimbot_fire(aimbot_data)
    if self.breaking_lc == 2 then
        self.aimbot_data = aimbot_data
    end
end
---@type function
---@param aimbot_data table shot_data
function tickbasecontroller:aimbot_hit(aimbot_data)
    if self.aimbot_data == nil then
        return
    end
    if self.aimbot_data.id == aimbot_data.id then
        self.aimbot_data = nil
    end
end
---@type function
---@param aimbot_data table shot_data
function tickbasecontroller:aimbot_miss(aimbot_data)
    if self.aimbot_data == nil then
        return
    end
    if self.aimbot_data.id == aimbot_data.id then
        self.aimbot_data = nil
    end
end
---@type function
---@param cmd userdata create_move_tbl
function tickbasecontroller:predict_command(cmd)
    local me = entity.get_local_player()

    local shots_fired = entity.get_prop(me, "m_iShotsFired")

    self.weapon_fired_predict = shots_fired > 0
end
---@type function
---@param me number entity_index
---@param wpn number wpn_index
---@param ticks_to_shift number 
function tickbasecontroller:can_exploit(me, wpn, ticks_to_shift)
    if wpn == nil then
        return false
    end
    local tickbase = entity.get_prop(me, "m_nTickBase")
    local curtime = globals.tickinterval() * (tickbase - ticks_to_shift)

    if curtime < entity.get_prop(me, "m_flNextAttack") then
        return false
    end
    if curtime < entity.get_prop(wpn, "m_flNextPrimaryAttack") then
        return false
    end
    return true
end

---@type function
---@param me number entity_index
---@param wpn number wpn_index
function tickbasecontroller:exploit(me, maximum_ticks)
    if me == nil or not entity.is_alive(me) then
        return nil
    end

    local m_velocity = vector(entity.get_prop(me, 'm_vecVelocity'))
    local distance_per_tick = m_velocity:length2d() * globals.tickinterval()

    --region aimware_adaptive_fl
    local wish_ticks = 0
    local adapt_ticks = 2
    local g_pRandomNumber = client.random_int(1, globals.tickcount())

    while (wish_ticks * distance_per_tick) <= 68.0 / 3 do
        if ((adapt_ticks-1) * distance_per_tick) > 68.0 / 3 then
            wish_ticks = wish_ticks+1
            break
        end

        if (adapt_ticks * distance_per_tick) > 68.0 / 3 then
            wish_ticks = wish_ticks+2
            break
        end

        if ((adapt_ticks+1) * distance_per_tick) > 68.0 / 3 then
            wish_ticks = wish_ticks+3
            break
        end

        if ((adapt_ticks+2) * distance_per_tick) > 68.0 / 3 then
            wish_ticks = wish_ticks+4
            break
        end

        adapt_ticks = adapt_ticks+5
        wish_ticks = wish_ticks+5

        if adapt_ticks > math.max(16, maximum_ticks+1) then
            break
        end
    end

    wish_ticks = math.min(wish_ticks, maximum_ticks)
    g_pRandomNumber = 0x41C64E6D * g_pRandomNumber + 12345

    return { ticks = wish_ticks, is_adaptive = (wish_ticks < maximum_ticks), randome_choke = g_pRandomNumber % maximum_ticks }
    --endregion
end

---@type function
---@param cmd userdata create_move_tbl
function tickbasecontroller:setup_command(cmd)
    local doubletap = { self.ui.doubletap:get() }
    if doubletap[1] and doubletap[2] and self.breaking_lc ~= 2 then
        self.recharge_time = self.recharge_time + 1
    elseif doubletap[1] and doubletap[2] and self.breaking_lc == 2 and self.recharge_time > 0 then
        self.max_time = self.recharge_time
        self.recharge_time = 0
    end

    local me = entity.get_local_player()
    local wpn = entity.get_player_weapon(me)

    local next_attack = math.max(entity.get_prop(wpn, "m_flNextPrimaryAttack") or 0, entity.get_prop(me, "m_flNextAttack") or 0)

    local can_shoot = next_attack - globals.curtime() < 0

    if self.breaking_lc ~= 2 then self.charge_state = 0 end
    if self:can_exploit(me, wpn, 14) then self.charge_state = 1 end
    if self.breaking_lc == 2 then self.charge_state = 2 end

    if cmd.chokedcommands == 0 then
        local m_origin = vector(entity.get_origin(me))

        if self.last_origin ~= nil then
            self.teleport = (m_origin-self.last_origin):length2dsqr()
        end

        gram_update(self.lc_data, self.breaking_lc, true)

        self.last_sent = self.current_choke
        self.last_origin = m_origin

    end

    local max_shift_ticks = math.abs(self.shift_ticks)

    local wpninfo = ffi_stuff:GetWeaponInfo(wpn)
    
    local shot_ticks = (wpninfo.flCycleTime) / globals.tickinterval() + self.max_shift_ticks

    local max_recharge_time = 0
    if can_shoot then
        max_recharge_time = wpninfo.flCycleTimeAlt
    elseif not can_shoot and self.breaking_lc ~= 2 then
        max_recharge_time = wpninfo.flCycleTime + wpninfo.flCycleTimeAlt
    end

    self.max_recharge_time = max_recharge_time / globals.tickinterval()

    local max_bullets = shot_ticks / (wpninfo.flCycleTime / globals.tickinterval() )
    local max_bullets_floor = math.floor(max_bullets)

    if max_bullets - max_bullets_floor > 0.5 then
        if max_bullets - max_bullets_floor > 0.75 then
            self.shift_bullets = math.ceil(max_bullets)
        else
            self.shift_bullets = max_bullets_floor + 0.5
        end
    else
        self.shift_bullets = max_bullets_floor
    end

    if self.max_shift_ticks < max_shift_ticks then
        self.max_shift_ticks = max_shift_ticks
    end

    if self.breaking_lc ~= 2 then
        self.max_shift_ticks = 0
        self.shift_bullets = 0
    end

    --region shot_handler

    local shots_fired = entity.get_prop(me, "m_iShotsFired")

   -- local exploit = self:exploit(me, self.ui.tbc_shift_ticks:get())
    -- { ticks = wish_ticks, is_adaptive = (wish_ticks < maximum_ticks), randome_choke = g_pRandomNumber % ( maximum_ticks + 1 ) }

    --self.ui.dt_limit:cache(1, self.ui.tbc_mode:get() == "Experimental" and self.ui.masterswitch:get() and self.breaking_lc == 2 and exploit.is_adaptive == false and globals.tickcount() % 2 == 0, exploit.ticks)
    --self.ui.mode:cache(1, self.ui.tbc_mode:get() == "Experimental" and self.ui.masterswitch:get(), "Defensive")

    if self.aimbot_data ~= nil and self.ui.masterswitch:get() then
        local aimbot_cord = vector(self.aimbot_data.x, self.aimbot_data.y, self.aimbot_data.z)
        local eye_pos = vector(client.eye_position())

        local forward_vector = eye_pos:to(aimbot_cord)

        local angles = vector(forward_vector:angles())

        
        if self.ui.tbc_mode:get() ~= "Default" then

            cmd.allow_send_packet = false
            cmd.command_number = self.prev_command - 1

            if self.ui.tbc_mode:get() == "Accuracy" then
                tickbasecontroller:quick_stop(me, cmd)
            end

            --cmd.yaw = angles.y
            --cmd.pitch = angles.x

            cmd.in_attack = 1
        end

        --cmd.allow_send_packet = true
        self.aimbot_data = nil
    end
    --endregion

    self.prev_command = cmd.command_number
    self.current_choke = cmd.chokedcommands
end
---@type function
---@param indicator_handler indicator
function tickbasecontroller:indicator(indicator_handler)
    table.insert(self.skeet_indicators, indicator_handler)
end
---@type function
function tickbasecontroller:run_command()

    self.ui.maxusrticks:cache(1, self.ui.masterswitch:get() and self.ui.tbc_mode:get() ~= 'Default', 17)
    self.ui.holdaim:set(not (self.breaking_lc == 2 and self.aimbot_data ~= nil) and self.ui.tbc_mode:get() == "Aggressive")

end
---@type function
function tickbasecontroller:render()

    local y_offset = 0

    local screen_size = vector(client.screen_size())

    local y = screen_size.y - 348

    for _, indicator in pairs(self.skeet_indicators) do

        local text_size = vector(renderer.measure_text("d+", indicator.text))
        if indicator.text == "DT" and self.ui.tbc_indicator:get() and self.ui.masterswitch:get() then
            local x, y = 20, y - (text_size.y + 8)*y_offset + 14

            local text = string.format("exscord | %s | tickbase: %s state: %s ", indicator.text, self.max_shift_ticks, self.charge_state)
            local text_size = vector(renderer.measure_text("d", text))

            local h, w = text_size.y + 6, text_size.x + 8

            local color_tbl = {
                [0] = { 255, 25, 0 },
                [1] = { 228, 126, 10 },
                [2] = { 124, 195, 13 }
            }

            local color = color_tbl[self.charge_state]

            renderer.gradient(x, y+h, (w/2), 1, 0, 0, 0, 25, color[1], color[2], color[3], 255, true)
            renderer.gradient(x + w/2, y+h, w-w/2, 1, color[1], color[2], color[3], 255, 0, 0, 0, 25, true)

			renderer.gradient(x, y, w/2, h, 0, 0, 0, 25, 17, 17, 17, 175, true)
            renderer.gradient(x + w/2, y, w-w/2, h, 17, 17, 17, 175, 0, 0, 0, 25, true)
			renderer.text(x+4, y + 2, 255, 255, 255, 255, 'd', 0, text)

            local floor_bullets = math.floor(self.shift_bullets)
            local shift_bullets = (self.shift_bullets - floor_bullets) > 0 and floor_bullets + 1 or floor_bullets

            local frames = globals.frametime() * 6

            if self.charge_state == 2 then
                if self.GLOBAL_ALPHA < shift_bullets then
                    self.GLOBAL_ALPHA = self.GLOBAL_ALPHA + frames
                end

                if self.GLOBAL_ALPHA > shift_bullets then
                    self.GLOBAL_ALPHA = shift_bullets
                end
            else
                if self.GLOBAL_ALPHA > 0 then
                    self.GLOBAL_ALPHA = self.GLOBAL_ALPHA - frames
                end

                if self.GLOBAL_ALPHA <= 0 then
                    self.GLOBAL_ALPHA = 0
                end
            end

            for i=1, shift_bullets do

                local alpha_multiplier = self.GLOBAL_ALPHA/shift_bullets

                local size = vector(0.65, 0.65)
                local small_size = vector(0.50, 0.50)

                local bullet = bullet:load( ( (self.shift_bullets - floor_bullets) > 0 and i == shift_bullets ) and small_size or size )

                bullet:draw(vector(x + w + 16*(i - 1), y), { r = 255, g = 255, b = 255, a = 255*alpha_multiplier/i }, 'f')
            end

        else
            renderer.text(20, y - (text_size.y + 8)*y_offset, indicator.r, indicator.g, indicator.b, indicator.a, "d+", 0, indicator.text)
        end
        y_offset = y_offset + 1
    end

    self.skeet_indicators = {}
end
--endregion

--region initialization
---@type tickbasecontroller class
local exscord = tickbasecontroller:construct()

local functions = {
    exscord:event_handler("update_information", "net_update_start"),
    exscord:event_handler("setup_command", "setup_command"),
    exscord:event_handler("predict_command", "predict_command"),
    exscord:event_handler("run_command", "run_command"),
    exscord:event_handler("render", "paint"),
    exscord:event_handler("indicator", "indicator"),
    exscord:event_handler("aimbot_fire", "aim_fire"),
    exscord:event_handler("aimbot_hit", "aim_hit"),
    exscord:event_handler("aimbot_miss", "aim_miss")
}

--exscord:correct_clocks()

client.set_event_callback("shutdown", function()
    for _, destroy_func in pairs(functions) do
        destroy_func()
    end

    --exscord:correct_clocks(true)
end)
--endregion
